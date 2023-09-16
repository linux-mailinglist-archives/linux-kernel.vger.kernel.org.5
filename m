Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147A87A3236
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbjIPTUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjIPTUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:20:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D39C186
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:20:15 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694892013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ypaWc5Og+ko+YhlZxCoeIG9EwGQFApQm6ipFjJd/eyo=;
        b=sXQTslrXSUNhuY3Y1oIEkt5g/U3qacYDD+q3dOQWrp0h/eVurpRHGp39kUvrg3sqEu8mQ1
        PB8SPxXuFF4AldaBtcWQ9XcObap7TGNMJYIYSIfvAcyjquCIP1Etfb9qkYvx3BLoR0ZaSD
        nG+L9gYA7//AnMrMjm+kdZYJO89Z0cgEVjPSA54/XBQs6sbRcPekj1OcqF0Goh+3BcDgJg
        rD8Z5gW/mPocYYbbQNOALaTy82h6w1PTY3pGCl9hOxDlmHPg/pHPBsBQjEfQJiR/IEOg8W
        PEkM3FGNxPGBPcXL/esJM4mMJ2uH8151flFE2o7+uMEULBOwIk/tfNMwtXBpBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694892013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ypaWc5Og+ko+YhlZxCoeIG9EwGQFApQm6ipFjJd/eyo=;
        b=IIBRzTUqihn24cm8qcNIbOE7bP13aiYNxUohq5mUVsSMBd2FK8MPwRmE4j6VttYE0OQc6L
        T0LECY2SHu+4UJAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 0/8] provide nbcon base
Date:   Sat, 16 Sep 2023 21:25:59 +0206
Message-Id: <20230916192007.608398-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v5 of a series to introduce the new non-BKL (nbcon)
consoles. v4 is here [0]. For information about the motivation
of the atomic consoles, please read the cover letter of v1 [1].

This series focuses on providing the base functionality of the
nbcon consoles. In particular, it implements the ownership and
priority semantics for nbcon consoles. This series does _not_
include threaded printing, atomic printing regions, or nbcon
drivers. Those features will be added in separate follow-up
series.

The changes since v4:

- Remove nbcon_seq_init() and use nbcon_seq_force() instead.

- For nbcon_seq_force(), use the oldest record if the specified
  record no longer exists.

- For all try_acquire_*() variants, do not update the nbcon
  state on success since it was not used.

- For nbcon_context_try_acquire_requested(), replace the cmpxhg
  loop with a single cmpxchg.

- For nbcon_context_try_acquire_requested(), remove an explicit
  check for @unsafe_takeover. The nbcon_waiter_matches() check
  is enough to detect unsafe hostile takeovers.

- Rename nbcon_context_acquire_hostile() back to
  nbcon_context_try_acquire_hostile().

- Decide in nbcon_context_try_acquire_hostile() if an unsafe
  hostile acquire is allowed rather than at the end of and
  after nbcon_context_try_acquire_handover().

- For register_console(), call nbcon_free() if it is a braille
  console.

- Change many comments as suggested by pmladek. In the feedback
  thread I mentioned some other comment changes that I made.

- Added various WARN_ON_ONCE() checks as suggested by pmladek.

John Ogness

[0] https://lore.kernel.org/lkml/20230908185008.468566-1-john.ogness@linutronix.de

[1] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (1):
  printk: Make static printk buffers available to nbcon

Thomas Gleixner (7):
  printk: Add non-BKL (nbcon) console basic infrastructure
  printk: nbcon: Add acquire/release logic
  printk: nbcon: Add buffer management
  printk: nbcon: Add ownership state functions
  printk: nbcon: Add sequence handling
  printk: nbcon: Add emit function and callback function for atomic
    printing
  printk: nbcon: Allow drivers to mark unsafe regions and check state

 include/linux/console.h  |  129 +++++
 kernel/printk/Makefile   |    2 +-
 kernel/printk/internal.h |   31 ++
 kernel/printk/nbcon.c    | 1029 ++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   |   78 ++-
 5 files changed, 1245 insertions(+), 24 deletions(-)
 create mode 100644 kernel/printk/nbcon.c


base-commit: 189f53ec666838729ab29a220ca4c1e1f1359f95
-- 
2.39.2

