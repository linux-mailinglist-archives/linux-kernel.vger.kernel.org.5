Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1003E7C8E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjJMUnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:43:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6E783
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:43:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697229825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mjf99a2paGdAGR0nlWpBb0LYsPYobGyOkvbTMY/UwZM=;
        b=YMywW7TmjqDxavYWyw8AOZBs3cMopz62odfIRtnDbqMMHgqe5SwGEhQFK7fORUctliDI2j
        Yk4Ei3icCjqpZjYcOgImo1TpNAgKjlVT7H7OjzoGUedNUVRCLp8tRqx51lS9t7CE1UUmsl
        xESJtHsXUT2cBeFgA/yfCku1AOG02cTRbdOI0HlZFHaltUOqBLmBMTAKctjMcS/UFuNgrh
        BdS9movtKRwMP6YZA8VzElDlXl6FpmfsEggjSdBizJ6UdIydyXJvp8tb/PFxaXkqX9lSCk
        ozeUfRXXPvg46WEUcuhFJCOL3KtA2e+KewUW7nxFSlLjmN6uPKtjy1hHtSrn8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697229825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mjf99a2paGdAGR0nlWpBb0LYsPYobGyOkvbTMY/UwZM=;
        b=gEzn5Z4VmNV46vMxbBhP5FsiEarSACMcAKzr7jBeM5v5tFTXunwo+NfIu3WKIodEYlVy+o
        HkCHJrsbiGoGaDCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 0/4] fix console flushing on panic
Date:   Fri, 13 Oct 2023 22:49:36 +0206
Message-Id: <20231013204340.1112036-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While testing various panic scenarios using legacy consoles, I
stumbled on a couple issues that cause the panic backtrace not
to be printed:

1. In panic, an unfinalized record blocks printing of finalized
   records that may follow.

2. It is possible (and easy to reproduce) a scenario where the
   console on the panic CPU hands over to a waiter of a stopped
   CPU.

This series addresses these 2 issues while also performing some
minor cleanups to remove open coded checks about the panic
context.

Because of multiple refactoring done in recent history, it
would be helpful to provide the LTS maintainers with the proper
backported patches. I am happy to do this.

John Ogness

John Ogness (4):
  printk: For @suppress_panic_printk check other panic
  printk: Add this_cpu_in_panic()
  printk: Skip unfinalized records in panic
  printk: Ignore waiter on panic

 kernel/printk/internal.h          |  1 +
 kernel/printk/printk.c            | 64 +++++++++++++++++++------------
 kernel/printk/printk_ringbuffer.c |  9 +++--
 3 files changed, 45 insertions(+), 29 deletions(-)


base-commit: 29fda1ad2a64a62e1c51d61207396e2de1c67362
-- 
2.39.2

