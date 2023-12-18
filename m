Return-Path: <linux-kernel+bounces-4476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF808817E04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7CB2828A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06354768EB;
	Mon, 18 Dec 2023 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0OedXEp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBC87690D;
	Mon, 18 Dec 2023 23:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF7EC433C9;
	Mon, 18 Dec 2023 23:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702941566;
	bh=Jj6CqcZq/pZ6jGPq5AqwOGCyrcsDTwMv9Bv+MG30lpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0OedXEpe7TdHAuEUjoZS031nMA8vIi+C1jB4UJK9EyzWV5mDKvo9vEQwWlnsKFlb
	 VJyx6izFRylZqstyJNMQCUmi5pTjUFVDkRvtyVjkH0r2hVK4KzeVOs/u608jbuGsDY
	 ZMGe1pG4kzPypddBqkW9FweztB4mfeP+m9NrGwisBFfWW/gMoSYDcxRTsNGT7+Bqh8
	 HmLmbVGdpKOmgzg9+5t2CtLlOwuSksH/9RsknFHUtkyHfOhtM2YK0iWwXLx61Cb/s7
	 bl5hxyARrPV0l9Dtw7ji0RAJN7ewXdITIXOR5JHYAcS7gEdmSWKCRra67QeVO1NyV3
	 vEUJp6Ll1YXXw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] hrtimer: Report offline hrtimer enqueue
Date: Tue, 19 Dec 2023 00:19:14 +0100
Message-ID: <20231218231916.11719-2-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231218231916.11719-1-frederic@kernel.org>
References: <20231218231916.11719-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hrtimers migration on CPU-down hotplug process has been moved
earlier, before the CPU actually goes to die. This leaves a small window
of opportunity to queue an hrtimer in a blind spot, leaving it ignored.

For example a practical case has been reported with RCU waking up a
SCHED_FIFO task right before the CPUHP_AP_IDLE_DEAD stage, queuing that
way a sched/rt timer to the local offline CPU.

Make sure such situations never go unnoticed and warn when that happens.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/hrtimer.h | 3 ++-
 kernel/time/hrtimer.c   | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index f2044d5a652b..f0204630a443 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -219,7 +219,8 @@ struct hrtimer_cpu_base {
 	unsigned int			hres_active		: 1,
 					in_hrtirq		: 1,
 					hang_detected		: 1,
-					softirq_activated       : 1;
+					softirq_activated       : 1,
+					online			: 1;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	unsigned int			nr_events;
 	unsigned short			nr_retries;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 760793998cdd..edb0f821dcea 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1085,6 +1085,7 @@ static int enqueue_hrtimer(struct hrtimer *timer,
 			   enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
+	WARN_ON_ONCE(!base->cpu_base->online);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -2183,6 +2184,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
@@ -2250,6 +2252,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
 	raw_spin_unlock(&new_base->lock);
+	old_base->online = 0;
 	raw_spin_unlock(&old_base->lock);
 
 	return 0;
-- 
2.42.1


