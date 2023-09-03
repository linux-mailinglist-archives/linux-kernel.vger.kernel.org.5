Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B044C790C96
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbjICPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241995AbjICPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:05:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DE5116
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:05:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693753543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MPEy6MGuHHt1rq0d7ZHWfZNeERTdYCqLHpMJrCD2RUQ=;
        b=oXGDFjSfilcUvmYuK8bXE7w3FiYaTZQ+0thDQdVvAtmqRb4ncvMHGTzowqcvTEM+OIuct9
        ZDUXAgCJWxoAvPhx1adVsUgxfKu0t6Ne+mBHvSg2ExqQSyRt699rKm75PZ2rSYYeV8c+qt
        zvRXT1OIHkw/R0sr/cVZooBDM6IlvIzyQoWeTLn9oEoGmzM5DM6BwYrfc1It5fi8xcXoj1
        UI6jc6elDA40mpJHK/kx17ZCsxRMFeY5MPlhDWuOALRNfd3bhN6FN0/hmRirI0xzEXsOmh
        nTk77w7yizQXSKvlYRLMjD+LzsX5U6WMCC2tMh5oei/LpaudWWK/en+NV0cI1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693753543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MPEy6MGuHHt1rq0d7ZHWfZNeERTdYCqLHpMJrCD2RUQ=;
        b=+6EBv7eGCGBvArygDj8bQtq6KFZk326nDCRxM3wkppSW+TxmS8yOWysy/YRCZYZ3is1EFi
        gImsdn4udyDgPvCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 0/7] provide nbcon base
Date:   Sun,  3 Sep 2023 17:11:32 +0206
Message-Id: <20230903150539.245076-1-john.ogness@linutronix.de>
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

This is v3 of a series to introduce the new non-BKL (nbcon)
consoles. v2 is here [0]. For information about the motivation
of the atomic consoles, please read the cover letter of v1 [1].

This series focuses on providing the base functionality of the
nbcon consoles. In particular, it implements the ownership and
priority semantics for nbcon consoles. This series does _not_
include threaded printing, atomic printing regions, or nbcon
drivers. Those features will be added in separate follow-up
series.

The changes since v2:

- rename nbcon_state::hostile_unsafe to
  nbcon_state::unsafe_takeover

- add 2-bit nbcon_state::req_tag to help identify waiters

- remove nbcon_context::unsafe

- remove nbcon_context::hostile

- rename nbcon_context::takeover_unsafe to
  nbcon_context::allow_unsafe_takeover

- callers must now check the current console state to see if it
  acquired the console using the unsafe hostile takeover method

- rename nbcon_write_context::hostile_unsafe to
  nbcon_write_context::unsafe_takeover

- allow direct takeover of owned consoles if higher priority
  and safe

- rename printk_nbcon.c to nbcon.c

- remove most printk.c changes, to be added in a later series
  once all the nbcon functionality is implemented (only init
  and seq updates/checks are kept)

- add nbcon_alloc() to be called early in register_console() to
  allow for simple backout on failure (nbcon_init() changed to
  return void)

- remove my special debugging because it was annoying

- rename __nbcon_seq_to_stored() to __seq_to_nbcon_seq()

- rename __nbcon_seq_to_full() to __nbcon_seq_to_seq()

- implement seq translation as suggested by pmladek

- in nbcon_seq_try_update(), unconditionally attempt cmpxchg to
  allow CONSOLE_REPLAY_ALL to work

- change semantics of all acquire methods to simplify the model

- add nbcon_waiter_matches() to check waiter based on prio and
  req_tag

- add nbcon_context_try_acquire_requested() to implement
  handover part of acquiring after setting request

- in nbcon_context_update_unsafe(), perform handover when
  transitioning to !unsafe and there is a waiter

- in nbcon_emit_next_record(), simplify initializing @wctxt

- in nbcon_emit_next_record(), set the console state to unsafe
  while updating @dropped and @nbcon_seq to avoid data race
  when not in panic

- cleanup comments as suggested by pmladek

John Ogness

[0] https://lore.kernel.org/lkml/20230728000233.50887-1-john.ogness@linutronix.de

[1] https://lore.kernel.org/lkml/20230302195618.156940-6-john.ogness@linutronix.de

Thomas Gleixner (7):
  printk: Add non-BKL (nbcon) console basic infrastructure
  printk: nbcon: Add acquire/release logic
  printk: nbcon: Add buffer management
  printk: nbcon: Add ownership state functions
  printk: nbcon: Add sequence handling
  printk: nbcon: Add emit function and callback function for atomic
    printing
  printk: nbcon: Add functions for drivers to mark unsafe regions

 include/linux/console.h  | 135 ++++++
 kernel/printk/Makefile   |   2 +-
 kernel/printk/internal.h |  29 ++
 kernel/printk/nbcon.c    | 945 +++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   |  60 ++-
 5 files changed, 1152 insertions(+), 19 deletions(-)
 create mode 100644 kernel/printk/nbcon.c


base-commit: cb65d08d735e00cc55ad7700a82a453bb88c93a3
-- 
2.39.2

