Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44D1764006
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjGZTzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGZTy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:54:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9398F1BFF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q8M54TtIfXpz3E0saocgBFlFRU6EcFnOz2tKfmmWHUE=; b=N7CthOPqeGl83Y9bE6GhnC7Nkv
        U17pOS0rAzPzti9z3/nXU1ENc6x+RJtsdF8PIqqPItUZFH+85Un0q9i25wrkMZbqsG5Jr5djRDmFj
        mFspq2g8OjL4ah9ZTpAl2eb7LK/VuCteRouQaJi5NqCiyDc9LoOUvSQNWK4KpH8Gwio2KVKu0h+AQ
        aigMfEdTN75wRZps+YxnEyvJwp7mpVcnz1zJHNu4poEof4hv/JPMus97bOtFRnF3r31gyQcxnlsir
        CqeTFtB5q4dUAMzhOjcHpizwa7LvryNJzxrW4/WKkX7GGn75THY0MetyMN4yLL0pUoOQzRcKkWbTx
        JDkSbmBA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOkao-006njx-37; Wed, 26 Jul 2023 19:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 606CF3006BC;
        Wed, 26 Jul 2023 21:54:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10D36202A40AC; Wed, 26 Jul 2023 18:14:32 +0200 (CEST)
Date:   Wed, 26 Jul 2023 18:14:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        g@hirez.programming.kicks-ass.net
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: Stopping the tick on a fully loaded system
Message-ID: <20230726161432.GW4253@hirez.programming.kicks-ass.net>
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
 <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
 <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
 <20230725222851.GC3784071@hirez.programming.kicks-ass.net>
 <CAJZ5v0gyQvPqCN8jPrJqJVNeYXkhmCOnkuNvLgdqQtcS-fgF-g@mail.gmail.com>
 <CAJZ5v0iW=kg4i1Fi_Fny=CaH_YKiGps+6KsBPcgWzS5YOk00VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iW=kg4i1Fi_Fny=CaH_YKiGps+6KsBPcgWzS5YOk00VA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 05:53:46PM +0200, Rafael J. Wysocki wrote:

> > > That means we don't track nearly enough data to reliably tell anything
> > > about disabling the tick or not. We should have at least one bucket
> > > beyond TICK_NSEC for this.
> >
> > Quite likely.
> 
> So the reasoning here was that those additional bins would not be
> necessary for idle state selection, but the problem of whether or not
> to stop the tick is kind of separate from the idle state selection
> problem if the target residency values for all of the idle states are
> relatively short.  And so it should be addressed separately which
> currently it is not.  Admittedly, this is a mistake.

Right, the C state buckets are enough to pick a state, but not to handle
the tick thing.

The below hack boots on my ivb-ep with extra (disabled) states. Now let
me go hack up teo to make use of that.

name		residency

POLL		0
C1              1
C1E             80
C3              156
C6              300
TICK            1000
POST-TICK       2000


---
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index d9cda7f6ccb9..5f435fb8b89f 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -147,13 +147,37 @@ static void cpuidle_setup_broadcast_timer(void *arg)
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
+	s->target_residency_ns = TICK_NSEC;
+	s->target_residency = div_u64(TICK_NSEC, NSEC_PER_USEC);
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
+	int tick = 0, post_tick = 0, i;
 
 	/*
 	 * Use all possible CPUs as the default, because if the kernel boots
@@ -192,6 +216,39 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 			s->exit_latency_ns =  0;
 		else
 			s->exit_latency = div_u64(s->exit_latency_ns, NSEC_PER_USEC);
+
+		if (!tick && s->target_residency_ns >= TICK_NSEC) {
+			tick = 1;
+
+			if (s->target_residency_ns == TICK_NSEC)
+				continue;
+
+			post_tick = 1;
+
+			memmove(&drv->states[i+1], &drv->states[i],
+				sizeof(struct cpuidle_state) * (CPUIDLE_STATE_MAX - i - 1));
+			drv->state_count++;
+
+			__cpuidle_state_init_tick(s);
+			i++;
+		}
+	}
+
+	if (!tick) {
+		struct cpuidle_state *s = &drv->states[i];
+		__cpuidle_state_init_tick(s);
+		drv->state_count++;
+		i++;
+	}
+
+	if (!post_tick) {
+		struct cpuidle_state *s = &drv->states[i];
+		__cpuidle_state_init_tick(s);
+		strcpy(s->name, "POST-TICK");
+		s->target_residency_ns *= 2;
+		s->target_residency *= 2;
+		drv->state_count++;
+		i++;
 	}
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3183aeb7f5b4..a642ee9e916c 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -16,7 +16,7 @@
 #include <linux/hrtimer.h>
 #include <linux/context_tracking.h>
 
-#define CPUIDLE_STATE_MAX	10
+#define CPUIDLE_STATE_MAX	16
 #define CPUIDLE_NAME_LEN	16
 #define CPUIDLE_DESC_LEN	32
 
