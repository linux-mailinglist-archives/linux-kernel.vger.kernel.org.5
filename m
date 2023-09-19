Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681167A6F32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjISXJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjISXJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15213C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:09:15 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzbPeuWkTorGv3d2yuxEAEu0gnIlvdjiqaqtf+AucME=;
        b=AcOxDy26/wZHBrY1PDymcspuNPgrI1Epe/gZj0sMxSW60NjlAnd6XQ6j36zzzT9zkdYknI
        SyHklaTdzHgcn9LBQa9GGeaoNOXlRJLOqVyOGnYrx+zkzbIjOj+rGfYaUoKZUHiO1i/fJH
        oRx2nLs96R3O1IprrRjd2SBLf/ZzZYM+KNEtDNGbqNxLXnoWFeL0oc2AHgyQV9MqCQR7Qi
        5z3jbF9q+31Ek8GNWMxr5rL6OX2Euegaz4BAcEFUl5UJQycdekHwYzhpuVHgZpAp3Ui5WR
        RMvkiMCLnfrW7ohY4ApfANrEpdmBI0//+TmvQRYsEISQxTsj/D2MYWTr6R03sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzbPeuWkTorGv3d2yuxEAEu0gnIlvdjiqaqtf+AucME=;
        b=gKmdzdskT7Ri+LOcvfojaRdY0IBLQEasZSxD8GXhIC5B7lEqTcovfFCrvzcWfX0+Tniup9
        d/UYvefBi8WwQrAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 06/11] printk: nbcon: Wire up nbcon console atomic flushing
Date:   Wed, 20 Sep 2023 01:14:51 +0206
Message-Id: <20230919230856.661435-7-john.ogness@linutronix.de>
In-Reply-To: <20230919230856.661435-1-john.ogness@linutronix.de>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Perform nbcon console atomic flushing at key call sites:

nbcon_atomic_exit() - When exiting from the outermost atomic
	printing section. If the priority was NBCON_PRIO_PANIC,
	attempt a second flush allowing unsafe hostile
	takeovers.

console_flush_on_panic() - Called from several call sites to
	trigger ringbuffer dumping in an urgent situation.

console_flush_on_panic() - Typically the panic() function will
	take care of atomic flushing the nbcon consoles on
	panic. However, there are several users of
	console_flush_on_panic() outside of panic().

printk_trigger_flush() - Used in urgent situations to trigger a
	dump in an irq_work context. However, the atomic
	flushing part happens in the calling context since an
	alternative context is not required.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 kernel/printk/nbcon.c  | 10 ++++++++++
 kernel/printk/printk.c |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 2a9ff18fc78c..82e6a1678363 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1092,6 +1092,11 @@ void nbcon_atomic_flush_all(void)
  * Return:	The previous priority that needs to be fed into
  *		the corresponding nbcon_atomic_exit()
  * Context:	Any context. Disables migration.
+ *
+ * When within an atomic printing section, no atomic printing occurs. This
+ * is to allow all emergency messages to be dumped into the ringbuffer before
+ * flushing the ringbuffer. The actual atomic printing occurs when exiting
+ * the outermost atomic printing section.
  */
 enum nbcon_prio nbcon_atomic_enter(enum nbcon_prio prio)
 {
@@ -1130,8 +1135,13 @@ void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio)
 {
 	struct nbcon_cpu_state *cpu_state;
 
+	__nbcon_atomic_flush_all(false);
+
 	cpu_state = nbcon_get_cpu_state();
 
+	if (cpu_state->prio == NBCON_PRIO_PANIC)
+		__nbcon_atomic_flush_all(true);
+
 	/*
 	 * Undo the nesting of nbcon_atomic_enter() at the CPU state
 	 * priority.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6ef33cefa4d0..419c0fabc481 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3159,6 +3159,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		console_srcu_read_unlock(cookie);
 	}
 
+	nbcon_atomic_flush_all();
+
 	console_flush_all(false, &next_seq, &handover);
 }
 
@@ -3903,6 +3905,10 @@ void defer_console_output(void)
 
 void printk_trigger_flush(void)
 {
+	migrate_disable();
+	nbcon_atomic_flush_all();
+	migrate_enable();
+
 	defer_console_output();
 }
 
-- 
2.39.2

