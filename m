Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299E5767003
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbjG1PBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbjG1PBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:01:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5D72688;
        Fri, 28 Jul 2023 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/jk8cjAzNp5umM9o/8ZP9pvl8gboqgF2w9reMo9nXqk=; b=bKnvshZ/ndNOvwq1Tklq1Cz0FF
        vvHXxiHIW2w98Vm4G3ioNeylieIiFQhLuNgDolJXkC5pruqePdPgiqhpDO3JIWxFqkMxXeArZG9Py
        m6TkobUM+ooLjFSoHvZV61SiHLI1NzMFinHiIb7pS9Fc4MLXZSKGoCTyDhtfFXbneY3K+0bgyFfS/
        NGN5yHTSiwzJM5y/Pb5xe4EfMkXU7+O2ZsQ0nYzjLoUkbe2Zbov0O3K/T5AukAn0YyPeZotIW2alO
        Vs24fwevy7DKg6nsi1LvetldnCjRapaPzGi5QF+pfwrh8qu226UUksEiPjXrRL/s5ZJreTYGVd7Le
        jFUDTe1w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPOxY-008ar1-OS; Fri, 28 Jul 2023 15:00:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A5D63003A2;
        Fri, 28 Jul 2023 17:00:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 209E92C8FCA94; Fri, 28 Jul 2023 17:00:51 +0200 (CEST)
Message-ID: <20230728145808.835742568@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jul 2023 16:55:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: [RFC][PATCH 1/3] cpuidle: Inject tick boundary state
References: <20230728145515.990749537@infradead.org>
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

In order to facilitate governors that track history in idle-state
buckets (TEO) making a useful decision about NOHZ, make sure we have a
bucket that counts tick-and-longer.

In order to be inclusive of the tick itself -- after all, if we do not
disable NOHZ we'll sleep for a full tick, the actual boundary should
be just short of a full tick.

IOW, when registering the idle-states, add one that is always
disabled, just to have a bucket.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/cpuidle.h |    2 +
 drivers/cpuidle/driver.c  |   48 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/cpuidle.h   |    2 -
 3 files changed, 50 insertions(+), 2 deletions(-)

--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -72,4 +72,6 @@ static inline void cpuidle_coupled_unreg
 }
 #endif
 
+#define SHORT_TICK_NSEC (TICK_NSEC - TICK_NSEC/32)
+
 #endif /* __DRIVER_CPUIDLE_H */
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -147,13 +147,37 @@ static void cpuidle_setup_broadcast_time
 		tick_broadcast_disable();
 }
 
+static int tick_enter(struct cpuidle_device *dev,
+		      struct cpuidle_driver *drv,
+		      int index)
+{
+	return -ENODEV;
+}
+
+static void __cpuidle_state_init_tick(struct cpuidle_state *s)
+{
+	strcpy(s->name, "TICK");
+	strcpy(s->desc, "(no-op)");
+
+	s->target_residency_ns = SHORT_TICK_NSEC;
+	s->target_residency = div_u64(SHORT_TICK_NSEC, NSEC_PER_USEC);
+
+	s->exit_latency_ns = 0;
+	s->exit_latency = 0;
+
+	s->flags |= CPUIDLE_FLAG_UNUSABLE;
+
+	s->enter = tick_enter;
+	s->enter_s2idle = tick_enter;
+}
+
 /**
  * __cpuidle_driver_init - initialize the driver's internal data
  * @drv: a valid pointer to a struct cpuidle_driver
  */
 static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 {
-	int i;
+	int tick = 0, i;
 
 	/*
 	 * Use all possible CPUs as the default, because if the kernel boots
@@ -163,6 +187,9 @@ static void __cpuidle_driver_init(struct
 	if (!drv->cpumask)
 		drv->cpumask = (struct cpumask *)cpu_possible_mask;
 
+	if (WARN_ON_ONCE(drv->state_count >= CPUIDLE_STATE_MAX-2))
+		tick = 1;
+
 	for (i = 0; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 
@@ -192,6 +219,25 @@ static void __cpuidle_driver_init(struct
 			s->exit_latency_ns =  0;
 		else
 			s->exit_latency = div_u64(s->exit_latency_ns, NSEC_PER_USEC);
+
+		if (!tick && s->target_residency_ns >= SHORT_TICK_NSEC) {
+			tick = 1;
+
+			if (s->target_residency_ns == SHORT_TICK_NSEC)
+				continue;
+
+			memmove(&drv->states[i+1], &drv->states[i],
+				sizeof(struct cpuidle_state) * (CPUIDLE_STATE_MAX - i - 1));
+			__cpuidle_state_init_tick(s);
+			drv->state_count++;
+			i++;
+		}
+	}
+
+	if (!tick) {
+		struct cpuidle_state *s = &drv->states[i];
+		__cpuidle_state_init_tick(s);
+		drv->state_count++;
 	}
 }
 
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -16,7 +16,7 @@
 #include <linux/hrtimer.h>
 #include <linux/context_tracking.h>
 
-#define CPUIDLE_STATE_MAX	10
+#define CPUIDLE_STATE_MAX	16
 #define CPUIDLE_NAME_LEN	16
 #define CPUIDLE_DESC_LEN	32
 


