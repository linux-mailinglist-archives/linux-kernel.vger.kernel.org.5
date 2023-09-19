Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB37A6F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjISXKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjISXJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4637BF1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:09:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3M6IXxDMcErVEoXMIDzEHrM+hhZey9Pc7y7dowbbNtk=;
        b=ykzLmHkUV4QAIDn9PfSIf+5hV7yYHau/MwfSByro1+/RRo7xJ+fEdTKVzcdEcGiflpDxuO
        kjhSt3Zfya8Jid1zZi845nZJDhzpuhJEb0q3/Fcq++wddKi7Tl1uLEi4FT1haWi+es+l9Y
        dzyLYYnM4K/b0K0XJqsKPIPvLEv9kpe8Co4LCXg3656Db/fUAyCMJtb0z9Quatqcew/2r9
        i1kjEQuv0D67WRfbU8ew0zqcZe5bBTk+IuMcU6gwgqjCNgnIZqAPxazLb5yAWxaixS3aCt
        QwchMoJlviiIAzHllzE1v4+PtMxza/htLXQLUVyF0UKwidvdTK9D5mLcm5cnUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3M6IXxDMcErVEoXMIDzEHrM+hhZey9Pc7y7dowbbNtk=;
        b=NhLLwrLA38y5dN+KiT8IFLeDnAO76+WTX2vBcMJuxRtcbkK7T7OaHXmxLEaVWISZQUzkwD
        jr7HtmziecRcpUCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH printk v2 09/11] panic: Add atomic write enforcement to oops
Date:   Wed, 20 Sep 2023 01:14:54 +0206
Message-Id: <20230919230856.661435-10-john.ogness@linutronix.de>
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

Invoke the atomic write enforcement functions for oops to
ensure that the information gets out to the consoles.

Since there is no single general function that calls both
oops_enter() and oops_exit(), the nesting feature of atomic
write sections is taken advantage of in order to guarantee
full coverage between the first oops_enter() and the last
oops_exit().

It is important to note that if there are any legacy consoles
registered, they will be attempting to directly print from the
printk-caller context, which may jeopardize the reliability of
the atomic consoles. Optimally there should be no legacy
consoles registered.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/panic.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 86ed71ba8c4d..e2879098645d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -614,6 +614,10 @@ bool oops_may_print(void)
 	return pause_on_oops_flag == 0;
 }
 
+static atomic_t oops_cpu = ATOMIC_INIT(-1);
+static int oops_nesting;
+static enum nbcon_prio oops_prev_prio;
+
 /*
  * Called when the architecture enters its oops handler, before it prints
  * anything.  If this is the first CPU to oops, and it's oopsing the first
@@ -630,6 +634,36 @@ bool oops_may_print(void)
  */
 void oops_enter(void)
 {
+	enum nbcon_prio prev_prio;
+	int cpu = -1;
+
+	/*
+	 * If this turns out to be the first CPU in oops, this is the
+	 * beginning of the outermost atomic section. Otherwise it is
+	 * the beginning of an inner atomic section.
+	 */
+	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
+
+	if (atomic_try_cmpxchg_relaxed(&oops_cpu, &cpu, smp_processor_id())) {
+		/*
+		 * This is the first CPU in oops. Save the outermost
+		 * @prev_prio in order to restore it on the outermost
+		 * matching oops_exit(), when @oops_nesting == 0.
+		 */
+		oops_prev_prio = prev_prio;
+
+		/*
+		 * Enter an inner atomic section that ends at the end of this
+		 * function. In this case, the nbcon_atomic_enter() above
+		 * began the outermost atomic section.
+		 */
+		prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
+	}
+
+	/* Track nesting when this CPU is the owner. */
+	if (cpu == -1 || cpu == smp_processor_id())
+		oops_nesting++;
+
 	tracing_off();
 	/* can't trust the integrity of the kernel anymore: */
 	debug_locks_off();
@@ -637,6 +671,9 @@ void oops_enter(void)
 
 	if (sysctl_oops_all_cpu_backtrace)
 		trigger_all_cpu_backtrace();
+
+	/* Exit inner atomic section. */
+	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);
 }
 
 static void print_oops_end_marker(void)
@@ -652,6 +689,18 @@ void oops_exit(void)
 {
 	do_oops_enter_exit();
 	print_oops_end_marker();
+
+	if (atomic_read(&oops_cpu) == smp_processor_id()) {
+		oops_nesting--;
+		if (oops_nesting == 0) {
+			atomic_set(&oops_cpu, -1);
+
+			/* Exit outmost atomic section. */
+			nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, oops_prev_prio);
+		}
+	}
+	put_cpu();
+
 	kmsg_dump(KMSG_DUMP_OOPS);
 }
 
-- 
2.39.2

