Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C81766075
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjG1ACp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjG1ACl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:02:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65F71FC4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:02:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690502556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7VJGt1oaLzPzNdavyJrVicoAw+051RIQFfoOM0HgoeU=;
        b=dQK4Uv3Jodc5Kva/yhj7snHQMbc4IQxTJMp4U872Rxlxuappy4YirzsNEJmcF+0S/uJmRk
        962OlizcyNyzUieKkvemuiiUUnujNDvPQRzqpfJQzFlmiA2a9+F0n/Qtq+i9K5xSlXgdrc
        Y1hAKdbcW9wlhERuxx1l64FrMQC3cG05hRJ4CRXI8AZb+fmY7VZKhGa6UtvDSNUZ8Z9Gve
        wvujpa/2zcMhMVXs6mdF93jR46ON1sCb5cXFwtlD7ZvuVLcBgQQsxBDLwXcoTSFbV5jjiE
        l/07s4ZkDCBnRXxoC6sn0BcwvnyhKPpRHspEKHh+ME/ERTsxn5v/oqib0K0AFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690502556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7VJGt1oaLzPzNdavyJrVicoAw+051RIQFfoOM0HgoeU=;
        b=FRGww273bt+j0G7gz/jDlCvorOZWl24p2vIVefkL/ZJvV5Q1bemqEJiBEf869gCwu9JLzP
        KFKmOA+icKLXn4Ag==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 0/8] wire up nbcon consoles
Date:   Fri, 28 Jul 2023 02:08:25 +0206
Message-Id: <20230728000233.50887-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2 of a series to introduce the new non-BKL (nbcon)
consoles. This series is only a subset of the original
v1 [0]. In particular, this series represents patches 5-10 of
the v1 series. For information about the motivation of the
atomic consoles, please read the cover letter of v1.

This series focuses on wiring up the printk subsystem to
be able to use the nbcon consoles and implement their ownership
interfaces and rules. This series does _not_ include threaded
printing, atomic printing regions, or nbcon drivers. Those
features will be added in separate follow-up series.

There is not much that has _not_ changed since v1. Here is an
attempt to list the changes:

- new naming:
    OLD         NEW
    bkl         legacy
    nobkl       nbcon
    CON_NO_BKL  CON_NBCON
    cons_()     nbcon_()

- rather than allocating context objects per-cpu, per-prio, and
  per-console, require the context object to sit on the stack

- serialize nbcon consoles with the console_lock until there
  are no more boot consoles registered

- update @have_boot_console and @have_legacy_console on
  unregister_console()

- only use @nbcon_seq for the nbcon sequence counter

- avoid console lock in __pr_flush() if there are only nbcon
  consoles

- use only 1 state variable instead of CUR and REQ states

- replace saved states in the context with boolean flags

- use atomic long for nbcon_seq, expanded as needed on 32bit
  systems

- instead of the owner performing the handover, now the owner
  gives up ownership and the waiter takes ownership

- remove unnecessary state and context fields

- simplify sequence tracking by only allowing incrementing
  (positive) updates

- simplify buffer handling by only allowing hostile takeovers
  in the single panic context

- remove early buffer handling because there is no early window

- carefully consider individual state bits rather than
  performing general set compares

- split the code for various locking strategies based on
  complete methods rather than functional pieces

John Ogness

[0] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (1):
  printk: Provide debug_store() for nbcon debugging

Thomas Gleixner (7):
  printk: Add non-BKL (nbcon) console basic infrastructure
  printk: nbcon: Add acquire/release logic
  printk: nbcon: Add buffer management
  printk: nbcon: Add sequence handling
  printk: nbcon: Add ownership state functions
  printk: nbcon: Add emit function and callback function for atomic
    printing
  printk: nbcon: Add functions for drivers to mark unsafe regions

 include/linux/console.h      | 132 +++++
 kernel/printk/Makefile       |   2 +-
 kernel/printk/internal.h     |  29 ++
 kernel/printk/printk.c       | 156 ++++--
 kernel/printk/printk_nbcon.c | 955 +++++++++++++++++++++++++++++++++++
 5 files changed, 1243 insertions(+), 31 deletions(-)
 create mode 100644 kernel/printk/printk_nbcon.c


base-commit: 132a90d1527fedba2d95085c951ccf00dbbebe41
-- 
2.39.2

