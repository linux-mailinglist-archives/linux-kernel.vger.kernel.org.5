Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0E176CEBD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjHBNbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjHBNbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:31:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B25D1BFD;
        Wed,  2 Aug 2023 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JAEdkNYRa3AXqsFdc832avh6PD2FjtrGNGx2xJmd/wI=; b=fU6G3YXwQ34Cb1/wQwfYvcumtt
        LdxhBQ2iLVc8CMCboG1kI/Le/16V4MPrdeVKmPfbuURe5qbMWj5RjiOyNU+Nq4b8NQetB6dPC/SVx
        0X/DZFYsbtW4wMTqAdyzw/kYkZpsK5CgMufWNDUJJgcUSYP7tdpOLysCSaq6mBykBA+mtFdznhE1U
        eYmf+IZ5Tjg5P2CQdVYTBGWwf9qDFsVZtjZ9rHW4cDBosVOdTLhEebk5G0ceo9nIDkSUXOSr9ixQ1
        tJhwIjp4FFEyr8Y0BxmXi07xsYgMy/mVdfLiYz8L2Htb4dQxwMFUTu6VUQ4Zrq2K7ChqThiWnJ0gE
        ZhsV3++Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRBwZ-00FxfC-21;
        Wed, 02 Aug 2023 13:31:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12B0A300301;
        Wed,  2 Aug 2023 15:31:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ECE022107D7E6; Wed,  2 Aug 2023 15:31:14 +0200 (CEST)
Message-ID: <20230802132925.549643116@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Aug 2023 15:24:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kajetan.puchalski@arm.com
Subject: [RFC][PATCH v2 1/5] tick/nohz: Introduce tick_get_sleep_length()
References: <20230802132431.254614419@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a variant of tick_nohz_get_sleep_length() that conditionally does
the NOHZ part.

tick_get_sleep_length(false) returns the delta_next return value of
tick_nohz_get_sleep_length(), while tick_get_sleep_length(true)
returns the regular return of tick_nohz_get_sleep_length().

This allows eliding tick_nohz_next_event() -- which is going to be
expensive with timer-pull.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/tick.h     |    5 +++++
 kernel/time/tick-sched.c |   35 +++++++++++++++++++++++------------
 2 files changed, 28 insertions(+), 12 deletions(-)

--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -136,6 +136,7 @@ extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_next_hrtimer(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
+extern ktime_t tick_get_sleep_length(bool nohz);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
@@ -168,6 +169,10 @@ static inline ktime_t tick_nohz_get_slee
 	*delta_next = TICK_NSEC;
 	return *delta_next;
 }
+static inline ktime_t tick_get_sleep_length(bool nohz)
+{
+	return TICK_NSEC;
+}
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1218,17 +1218,7 @@ ktime_t tick_nohz_get_next_hrtimer(void)
 	return __this_cpu_read(tick_cpu_device.evtdev)->next_event;
 }
 
-/**
- * tick_nohz_get_sleep_length - return the expected length of the current sleep
- * @delta_next: duration until the next event if the tick cannot be stopped
- *
- * Called from power state control code with interrupts disabled.
- *
- * The return value of this function and/or the value returned by it through the
- * @delta_next pointer can be negative which must be taken into account by its
- * callers.
- */
-ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
+static ktime_t __tick_nohz_get_sleep_length(ktime_t *delta_next, bool nohz)
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
@@ -1244,7 +1234,7 @@ ktime_t tick_nohz_get_sleep_length(ktime
 
 	*delta_next = ktime_sub(dev->next_event, now);
 
-	if (!can_stop_idle_tick(cpu, ts))
+	if (!nohz || !can_stop_idle_tick(cpu, ts))
 		return *delta_next;
 
 	next_event = tick_nohz_next_event(ts, cpu);
@@ -1262,6 +1252,27 @@ ktime_t tick_nohz_get_sleep_length(ktime
 }
 
 /**
+ * tick_nohz_get_sleep_length - return the expected length of the current sleep
+ * @delta_next: duration until the next event if the tick cannot be stopped
+ *
+ * Called from power state control code with interrupts disabled.
+ *
+ * The return value of this function and/or the value returned by it through the
+ * @delta_next pointer can be negative which must be taken into account by its
+ * callers.
+ */
+ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
+{
+	return __tick_nohz_get_sleep_length(delta_next, true);
+}
+
+ktime_t tick_get_sleep_length(bool nohz)
+{
+	ktime_t delta;
+	return __tick_nohz_get_sleep_length(&delta, nohz);
+}
+
+/**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
  * for a particular CPU.
  *


