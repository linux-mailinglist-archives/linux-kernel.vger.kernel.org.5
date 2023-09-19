Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E807A6F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjISXJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISXJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7081C5;
        Tue, 19 Sep 2023 16:09:09 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nzxvbCzxz7qN1cIIZLKetlqtaurCcasvn+7mrQhoMjQ=;
        b=Wje53M876JfN5LLQw13s9jsLTYcM2iz2WsfsaJu1W25CEL3pj+JTS+9I8pptJ91VghY1TB
        /BpZQTyJqSG/SmIN4XwVWp318BLJLsiLHhzgwA9xdiKfQI6Dk/r3sqeQ25f5Xmzj8nCItS
        e4E5j/0yFp2hZ5uWd7zkbRKxZauodtkxwqWqzaA0jySwiAeyHvsatXijBiGKTBtiINwMdI
        da0JT2/GWnckhmZW/P/DLSz0YFTPZc8y02wBFckUDlL9NwSTkxeKOMPQYgZinC4L3Ym20H
        tCU0rKNLcUwdxTx9RR41zPkcNx9lZOtmC1UrPZ32IZCLXsdJl+9VdoEK9xaU7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nzxvbCzxz7qN1cIIZLKetlqtaurCcasvn+7mrQhoMjQ=;
        b=DdRh7TWdKUGH21ctW9qq2wUhtGIl/XOtFOH2ddBrMZl2ejFzOfgrzYJ6MsZ3hQsFEyrBk0
        KH+1iKo400MLNqAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH printk v2 00/11] wire up nbcon atomic printing
Date:   Wed, 20 Sep 2023 01:14:45 +0206
Message-Id: <20230919230856.661435-1-john.ogness@linutronix.de>
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

This is v2 of a series to wire up the nbcon consoles so that
they actually perform atomic printing. This series is only a
subset of the original v1 [0]. In particular, this series
represents patches 14 and 16-18 of the v1 series. For
information about the motivation of the atomic consoles,
please read the cover letter of v1.

This series focuses on providing the functionality and marking
of atomic printing sections as well as wiring up the nbcon
atomic printing to the general console_flush_all() function.
This series does _not_ include threaded printing or nbcon
drivers. Those features will be added in separate follow-up
series.

Note that the behavior of atomic printing in priority-elevated
atomic printing sections differs from the legacy consoles. With
atomic printing, the full set of urgent messages
(WARN/OOPS/PANIC) are first stored into the ringbuffer and then
afterwards flushed. This makes sure the full backtraces are
available in the ringbuffer, even if they do not make it out to
the console(s). This is in accordance with what was discussed
at LPC 2022 [1].

A lot has changed since v1 and the patches no longer correlate
1:1. Here is an attempt to list the changes:

- Rather than flushing the full ringbuffer with one nbcon
  console before moving to the next nbcon console, adapt the
  same flushing strategy as the legacy consoles: rotation
  through the consoles, one record at a time.

- Introduce nbcon_atomic_emit_one() to perform the "lock, emit
  one record, unlock" pattern. (This is only a helper
  function.)

- Introduce nbcon_console_emit_next_record() to act as the
  nbcon variant of console_emit_next_record(). This allows
  straight forward integration of nbcon consoles into
  console_flush_all().

- nbcon_atomic_flush() no longer takes any arguments. These
  were awkward for the caller. The context object is now
  hidden from the caller.

- Introduce __nbcon_atomic_flush_all() as an internal helper
  function in order to hide the ability to attempt unsafe
  hostile takeovers from outside nbcon.c.

- For printk_trigger_flush(), migration is disabled instead of
  preemption.

- Add atomic write enforcement to oops and lockdep.

- Comments and kerneldoc updated.

John Ogness

[0] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

[1] https://lore.kernel.org/lkml/875yheqh6v.fsf@jogness.linutronix.de

John Ogness (7):
  printk: Make console_is_usable() available to nbcon
  printk: Let console_is_usable() handle nbcon
  printk: Add @flags argument for console_is_usable()
  printk: nbcon: Wire up nbcon into console_flush_all()
  panic: Add atomic write enforcement to oops
  rcu: Add atomic write enforcement for rcu stalls
  lockdep: Add atomic write enforcement for lockdep splats

Thomas Gleixner (4):
  printk: nbcon: Provide functions to mark atomic write sections
  printk: nbcon: Provide function for atomic flushing
  printk: nbcon: Wire up nbcon console atomic flushing
  panic: Add atomic write enforcement to warn/panic

 include/linux/console.h  |   4 +
 include/linux/printk.h   |   6 +
 kernel/locking/lockdep.c |   7 ++
 kernel/panic.c           |  66 +++++++++++
 kernel/printk/internal.h |  37 ++++++
 kernel/printk/nbcon.c    | 246 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk.c   |  67 +++++------
 kernel/rcu/tree_stall.h  |   6 +
 8 files changed, 396 insertions(+), 43 deletions(-)


base-commit: 9757acd0a700ba4a0d16dde4ba820eb052aba1a7
-- 
2.39.2

