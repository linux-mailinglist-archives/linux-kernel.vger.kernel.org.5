Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C5A7DF791
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376905AbjKBQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344919AbjKBQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:22:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713F8137
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:22:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02108218A9;
        Thu,  2 Nov 2023 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698942166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GnHfnbxRW6xCASM+FghP5ql9o3nJhCS/JsgSRYW7wTg=;
        b=O/VU74RFkrUSN7aTui1xuUmqQdRpSycdS/nvysJF25G+mo+kET34FGNyVZ/ZnEW1EDQJos
        /buIPAUCXGsNGeEPyah6x42AzFIbipKmA/x3mYin8uw5B0JN/CIOJ8RqdHTekw/F77Ao3k
        Tt31BTKLbkFaLWcfM9w38cx56GJIo7s=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 362F22D42D;
        Thu,  2 Nov 2023 16:22:45 +0000 (UTC)
Date:   Thu, 2 Nov 2023 17:22:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 6.7
Message-ID: <ZUPM1ZD6Q3mNOPaS@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.7

================================

- Another preparation step for introducing printk kthreads. The main piece
  is a per-console lock with several features:

    - Support three priorities: normal, emergency, and panic. They will be
      defined by a context where the lock is taken. A context with a higher
      priority is allowed to take over the lock from a context with a lower
      one.

      The plan is to use the emergency context for Oops and WARN() messages,
      and also by watchdogs.

      The panic() context will be used on panic CPU.

    - The owner might enter/exit regions where it is not safe to take over
      the lock. It allows the take over the lock a safe way in the middle
      of a message.

      For example, serial drivers emit characters one by one. And
      the serial port is in a safe state in between.

      Only the final console_flush_in_panic() will be allowed to take over
      the lock even in the unsafe state (last chance, pray, and hope).

    - A higher priority context might busy wait with a timeout. The current
      owner is informed about the waiter and releases the lock on exit from
      the unsafe state.

    - The new lock is safe even in atomic contexts, including NMI.

  Another change is a safe manipulation of per-console sequence number
  counter under the new lock.

- simple_strntoull() micro-optimization

- Reduce pr_flush() pooling time.

- Calm down false warning about possible buffer invalid access to
  console buffers when CONFIG_PRINTK is disabled.

----------------------------------------------------------------
Alexey Dobriyan (1):
      vsprintf: uninline simple_strntoull(), reorder arguments

John Ogness (3):
      printk: Make static printk buffers available to nbcon
      printk: fix illegal pbufs access for !CONFIG_PRINTK
      printk: flush consoles before checking progress

Li kunyu (1):
      printk: printk: Remove unnecessary statements＇len = 0;＇

Petr Mladek (5):
      Merge branch 'rework/misc-cleanups' into for-linus
      printk: Reduce pr_flush() pooling time
      Merge branch 'for-6.7' into for-linus
      Merge branch 'rework/misc-cleanups' into for-linus
      Merge branch 'rework/nbcon-base' into for-linus

Thomas Gleixner (7):
      printk: Add non-BKL (nbcon) console basic infrastructure
      printk: nbcon: Add acquire/release logic
      printk: nbcon: Add buffer management
      printk: nbcon: Add ownership state functions
      printk: nbcon: Add sequence handling
      printk: nbcon: Add emit function and callback function for atomic printing
      printk: nbcon: Allow drivers to mark unsafe regions and check state

 include/linux/console.h  |  129 ++++++
 kernel/printk/Makefile   |    2 +-
 kernel/printk/internal.h |   31 ++
 kernel/printk/nbcon.c    | 1029 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   |  158 ++++---
 lib/vsprintf.c           |   25 +-
 6 files changed, 1295 insertions(+), 79 deletions(-)
 create mode 100644 kernel/printk/nbcon.c
