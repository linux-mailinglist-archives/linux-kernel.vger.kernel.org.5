Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0094D7A6F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjISXKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjISXJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A658D8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:09:17 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTecAisPGy22sD3/lz1Lk9T5rKFv9orfyF0LxD3p8X4=;
        b=P4Z6YRunkOPTZKgwIsuWd6MJHC5Jve4xUIDI+d4fkVbHEBJfHvFKY20lKV/ZbQVzzed+bN
        MfQvRsFkzDdxyBT+IZmKKKUteJ+8J5IBFw0fPuioztjOcPH0Fe+nnJIyu8aykUUn8Ctv8R
        Ugq8i2XNEq8PUibWlCTC35tFVw1vhjRNRzPnDtPbiCHzbeVy9+CUAhlAdhcdNIei8JnwXy
        /HE6mWR7bLz2wrXIziuD/LLifTzTCOL3NuTUodQradOkRCPWIM4TSHD3yWuMoHSeTypakZ
        mSWCGavnEgcD0wtISqPuMfA21Ucw8xbI5ZdrIOruL4WXyc8hMF1PqP1BX4eL6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTecAisPGy22sD3/lz1Lk9T5rKFv9orfyF0LxD3p8X4=;
        b=bNsSiUAr27aTwxXnYRc2P3wJ8k9ud163o0Nv9sPPRSLsA4qNbE2RVUk0ZGHH862/gVt4Ad
        hKPFyylULklOIbDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v2 08/11] panic: Add atomic write enforcement to warn/panic
Date:   Wed, 20 Sep 2023 01:14:53 +0206
Message-Id: <20230919230856.661435-9-john.ogness@linutronix.de>
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

Invoke the atomic write enforcement functions for warn/panic to
ensure that the information gets out to the consoles.

For the panic case, add explicit intermediate atomic flush
calls to ensure immediate flushing at important points.
Otherwise the atomic flushing only occurs when dropping out of
the elevated priority, which for panic may never happen.

It is important to note that if there are any legacy consoles
registered, they will be attempting to directly print from the
printk-caller context, which may jeopardize the reliability of
the atomic consoles. Optimally there should be no legacy
consoles registered.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 kernel/panic.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 07239d4ad81e..86ed71ba8c4d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -275,6 +275,7 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
  */
 void panic(const char *fmt, ...)
 {
+	enum nbcon_prio prev_prio;
 	static char buf[1024];
 	va_list args;
 	long i, i_next = 0, len;
@@ -322,6 +323,8 @@ void panic(const char *fmt, ...)
 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
 		panic_smp_self_stop();
 
+	prev_prio = nbcon_atomic_enter(NBCON_PRIO_PANIC);
+
 	console_verbose();
 	bust_spinlocks(1);
 	va_start(args, fmt);
@@ -382,6 +385,8 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
+	nbcon_atomic_flush_all();
+
 	console_unblank();
 
 	/*
@@ -406,6 +411,7 @@ void panic(const char *fmt, ...)
 		 * We can't use the "normal" timers since we just panicked.
 		 */
 		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
+		nbcon_atomic_flush_all();
 
 		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
 			touch_nmi_watchdog();
@@ -424,6 +430,7 @@ void panic(const char *fmt, ...)
 		 */
 		if (panic_reboot_mode != REBOOT_UNDEFINED)
 			reboot_mode = panic_reboot_mode;
+		nbcon_atomic_flush_all();
 		emergency_restart();
 	}
 #ifdef __sparc__
@@ -436,12 +443,16 @@ void panic(const char *fmt, ...)
 	}
 #endif
 #if defined(CONFIG_S390)
+	nbcon_atomic_flush_all();
 	disabled_wait();
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
+
+	nbcon_atomic_exit(NBCON_PRIO_PANIC, prev_prio);
+
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
@@ -652,6 +663,10 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
+	enum nbcon_prio prev_prio;
+
+	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
+
 	disable_trace_on_warning();
 
 	if (file)
@@ -682,6 +697,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);
 }
 
 #ifdef CONFIG_BUG
-- 
2.39.2

