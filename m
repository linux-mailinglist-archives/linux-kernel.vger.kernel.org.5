Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8DA756D92
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGQTqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQTqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:46:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B919E1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:46:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689623170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6Sg8oWx5z5RPOq+zJTuN8odXWF5bPvJEjQEBUr14J1U=;
        b=YP127NvP8JgUnAVIWyPjKu0W5k33QSO2kDnMO+7leWChXcSkVywIDm27BXqqafbVRF8wck
        SW4R+lXxJp6/BMwfsWiWOXbapNhgBvPJfkvjS5oMz8OjKwp9p1ZAbm1WuhlmdTXiTyJvyK
        tQ0RFgd4KtZijCxdyhQ0gOzGvLQY97/7QLeGnyd3u9xSEPYZgtMBdATLEfv6jErJqpZSKI
        r8qnjzjjloRwFUbt/OIwCl+HUA0N4XDqTTE+F6XVFEqsQ6dqvSQqIukwgJEbS1wqcvDSZK
        g529uNTpV3avbyd0w5Lk/B/ohGNNkxxzJW4FtPjRJh8yYGMQ1DufNWZYZZQzCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689623170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6Sg8oWx5z5RPOq+zJTuN8odXWF5bPvJEjQEBUr14J1U=;
        b=8LfqOQTcG/Ip3BiMdbFb22scsan9lsHZGyA0cRMM9XkLGHv3Jjcy14SB2IYVXWAoIIGB67
        akFFQMCRdR8hE5BQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 0/7] various cleanups
Date:   Mon, 17 Jul 2023 21:52:00 +0206
Message-Id: <20230717194607.145135-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v3 of a series providing some cleanup in preparation
for the threaded/atomic console work. v2 is here [0]. This
series provides useful cleanups independent of the
threaded/atomic work.

Changes since v2:

- "NMI safety" patch split into 3 patches: console_unblank,
  keep non-panic CPUs out, do not lock console on panic flush.

- console_unblank() aborts if there are no consoles implementing
  an unblank() callback. This check is performed before taking
  the console lock.

- Commit messages and comments updated to mention the details
  discussed in the v2 feedback.

John Ogness

[0] https://lore.kernel.org/lkml/20230710134524.25232-1-john.ogness@linutronix.de

John Ogness (7):
  kdb: Do not assume write() callback available
  printk: Reduce console_unblank() usage in unsafe scenarios
  printk: Keep non-panic-CPUs out of console lock
  printk: Do not take console lock for console_flush_on_panic()
  printk: Consolidate console deferred printing
  printk: Add per-console suspended state
  printk: Rename abandon_console_lock_in_panic() to other_cpu_in_panic()

 include/linux/console.h     |   3 +
 kernel/debug/kdb/kdb_io.c   |   2 +
 kernel/printk/internal.h    |   2 +
 kernel/printk/printk.c      | 213 +++++++++++++++++++++++++-----------
 kernel/printk/printk_safe.c |   9 +-
 5 files changed, 156 insertions(+), 73 deletions(-)


base-commit: 7ec85f3e089aa423a69559bf4555b6218b5a2ef7
-- 
2.30.2

