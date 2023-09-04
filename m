Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0546791595
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbjIDKRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjIDKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:17:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553DDBD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 03:16:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 101E22187A;
        Mon,  4 Sep 2023 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693822618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=ZsZRyBjVizCOdKCfDWvQMmj22cAUPrXD2YvcD1ag+uA=;
        b=N7QCb8vgjAiex3KMYK5mXG4EtB+b8GQiviNQaFP6nd5MN2x5IWiRPvCwkd4i+kUfBPZm6G
        xPvJD3EcObRFYMvbn20w6m0cidhW25+S5rwkmHNtRJim6T/ndKFUPpWqqy5rILGilBTGPb
        CCp6x8hg3xC7ZmUbiShN/b5F+ZV58I0=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F7E82C142;
        Mon,  4 Sep 2023 10:16:57 +0000 (UTC)
Date:   Mon, 4 Sep 2023 12:16:57 +0200
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
Subject: [GIT PULL] printk for 6.6
Message-ID: <ZPWumSQVlzdYkSJJ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.6

=================================

- Do not try to get the console lock when it is not need or useful
  in panic().

- Replace the global console_suspended state by a per-console flag.

- Export symbols needed for dumping the raw printk buffer in panic().

- Fix documentation of printf formats for integer types.

- Moved Sergey Senozhatsky to the reviewer role.

- Misc cleanups.

----------------------------------------------------------------
Andy Shevchenko (2):
      docs: printk-formats: Fix hex printing of signed values
      docs: printk-formats: Treat char as always unsigned

Enlin Mu (1):
      printk: export symbols for debug modules

John Ogness (7):
      kdb: Do not assume write() callback available
      printk: Reduce console_unblank() usage in unsafe scenarios
      printk: Keep non-panic-CPUs out of console lock
      printk: Do not take console lock for console_flush_on_panic()
      printk: Consolidate console deferred printing
      printk: Add per-console suspended state
      printk: Rename abandon_console_lock_in_panic() to other_cpu_in_panic()

Kees Cook (1):
      printk: ringbuffer: Fix truncating buffer size min_t cast

Nathan Chancellor (1):
      lib: test_scanf: Add explicit type cast to result initialization in test_number_prefix()

Petr Mladek (2):
      Merge branch 'for-6.6-vsprintf-doc' into for-linus
      Merge branch 'rework/misc-cleanups' into for-linus

Sergey Senozhatsky (1):
      MAINTAINERS: adjust printk/vsprintf entries

 Documentation/core-api/printk-formats.rst |   9 +-
 MAINTAINERS                               |   4 +-
 include/linux/console.h                   |   3 +
 kernel/debug/kdb/kdb_io.c                 |   2 +
 kernel/printk/internal.h                  |   2 +
 kernel/printk/printk.c                    | 215 +++++++++++++++++++++---------
 kernel/printk/printk_ringbuffer.c         |   2 +-
 kernel/printk/printk_safe.c               |   9 +-
 lib/test_scanf.c                          |   2 +-
 9 files changed, 167 insertions(+), 81 deletions(-)
