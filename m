Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6815798E6B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbjIHSwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244345AbjIHSwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:52:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A71724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:51:32 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694199011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JYUWM253IxHWu+rAc5zyedmFlMYlcxjGsRf5TiHx1ts=;
        b=fJPcF6lNZco3FbBgkzrosdkJNHNc6Li9puWookgitovtytELozhvQIkVaJbSwkJ4H6iJfL
        7K23+EcbXXgDa28rosaK96ThRHoldPIfALutn4+Z/A4gbHq7qL1qS8ESYJN45brQvLyI+k
        rDyBpCbtm36BwppwW1Q4Rs2hSmLgG+iIxQuSwKSp2hOaP28fqsD2sC1QOL3f5WLGUC96lh
        oeCCVxjO1HYoab6MAu2ocmBgAL4f8knt4Kxgab3Tl2VDI70eV+3QEEK9ZfzlUaMwHo1ukU
        1vbBgoDrnHe7nL7/HatnNMgA3K7snnvsWv4ciEKWvUVYxtJnM2C0kGd9AdbalQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694199011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JYUWM253IxHWu+rAc5zyedmFlMYlcxjGsRf5TiHx1ts=;
        b=KoNo04WADQQU7ZnmfeDeJCNGBmsJnpR3XlNiGbde0cJlh61702yQcy2/URoj4wePpw/bqv
        GCv43hJ/LLz3D3Cg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 0/8] provide nbcon base
Date:   Fri,  8 Sep 2023 20:56:00 +0206
Message-Id: <20230908185008.468566-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v4 of a series to introduce the new non-BKL (nbcon)
consoles. v3 is here [0]. For information about the motivation
of the atomic consoles, please read the cover letter of v1 [1].

This series focuses on providing the base functionality of the
nbcon consoles. In particular, it implements the ownership and
priority semantics for nbcon consoles. This series does _not_
include threaded printing, atomic printing regions, or nbcon
drivers. Those features will be added in separate follow-up
series.

The changes since v3:

- Remove @req_tag from nbcon_state. Comments in
  nbcon_waiter_matches() updated to explain why @req_prio is
  enough.

- Rename nbcon_cleanup() to nbcon_free().

- In nbcon_seq_try_update(), expand sequence when cmpxchg
  fails.

- Add macros nbcon_context_enter_unsafe() and
  nbcon_context_exit_unsafe() to replace
  nbcon_context_update_unsafe() usage.

- Rename nbcon_context_update_unsafe() to
  __nbcon_context_update_unsafe() since it should not be called
  directly. Use the new macros instead.

- Put printk_get_next_message() and console_prepend_dropped()
  within an unsafe region to avoid NORMAL and EMERGENCY
  priorities clobbering buffers.

- Make the global legacy @pbufs (from
  within console_emit_next_record()) available to nbcon.c as
  well, renaming it to @printk_shared_pbufs.

- For nbcon boot consoles, use @printk_shared_pbufs as its
  printk buffers. This works because boot console printing will
  be synchronized on the console_lock.

- Fix kerneldoc for nbcon_context_acquire_hostile().

- Update comments as suggested by pmladek.

John Ogness

[0] https://lore.kernel.org/lkml/20230903150539.245076-1-john.ogness@linutronix.de

[1] https://lore.kernel.org/lkml/20230302195618.156940-6-john.ogness@linutronix.de

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

 include/linux/console.h  | 132 ++++++
 kernel/printk/Makefile   |   2 +-
 kernel/printk/internal.h |  31 ++
 kernel/printk/nbcon.c    | 948 +++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   |  73 ++-
 5 files changed, 1163 insertions(+), 23 deletions(-)
 create mode 100644 kernel/printk/nbcon.c


base-commit: cb65d08d735e00cc55ad7700a82a453bb88c93a3
-- 
2.39.2

