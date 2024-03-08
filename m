Return-Path: <linux-kernel+bounces-96912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0050387630B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4CF282453
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A767E5788F;
	Fri,  8 Mar 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S93+uT/1"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126B56470
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896719; cv=none; b=aLBMl58t6dlZNsJXXGy9YqYOtlcIWiYicjHopTUEACDL0WDfrOUCA+r+F/H+Nv0RhVW7g0vYsKzoGzDkfor0a/eDCF/jf2qyw35bcb5iObHFsyTw8I5GXW0bzlKEENHdbpx7dtyv8wjwn26Mq9oVIlnIpcPvmjEIgAJxRHVMp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896719; c=relaxed/simple;
	bh=L8lafKDdMvn9EJ78tUaB5RQaPJsItc6VfHZEgy27vM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UszSaZn0DQMLUJ0yy4SrgOIxMKhUlLHN8EnzYrhcfLy/WKYtF7YCzMtUdKJuxQ70JixbMkbDHs3BwXoD+gIwk7VQKODeTN2cRtZjVk4zhlgGe3eMmDvpLX/HG7ued16EBBdkm1oM2uIscg0MrEcHzt9VMCxc1KHnT/3PP5Z7VX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S93+uT/1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4131bbb7fbcso1275135e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896716; x=1710501516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEG8SsO50Sv7fjH2Pfb6/80Dg/X78lX+4wLY8v7JRQE=;
        b=S93+uT/1AKOd/2uCNx43xexTE4pYP1d24+nKwSKjfVMbHdPjQ/Pg60RdcrQ51EN6IN
         ZLRG8Sl3scQnmDiijTDIC+5mCmr53XTBVdMMzGQu4NhhOaucc+3xqZ0TpXGwwEzYriQH
         tdeBis97IZIl+Ir83eHFCcYkezxwsIBSmWpkbB2873lAOwB7wYOh06+kuCCRiXFdqOi2
         8bz1A3qtrSg6QG3kBhnFutX67xrpK1DgSuNZdV4VL6Ci9MGLw+48JI/KI/NvD94f5knu
         ShYgplHn/NSq+uHYnIml2YSSYnfVPRnvzokZPmZ+iZlgXhIHBoBT9V5J4N9Wl7oaBnQs
         E6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896716; x=1710501516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rEG8SsO50Sv7fjH2Pfb6/80Dg/X78lX+4wLY8v7JRQE=;
        b=l3OZUrAdROMr6xXnzmIWhBGp02tqq0u25J+wx3ci3SxacYuz+NfTYJEEr6gqrLZSHQ
         FJ8hqD+lm4oyGFjy1uAmpB5TvUGDf5g4q1rQGt1OAzPCqVLPm/iTCu1Uc9qodIJ2RES5
         GvKbkm3SfUoRkJO3btlNsq+QkS5xPt1zSBHI/eXhi2R2I0jk2zY2zmIrRTCHgjiarcGI
         vOA7KHfrDqhphjYJ+29qHxmsXbITRs/gPn4S83Wh2ULMCrR57XEP4GMrKc60qe0DEEUb
         pSQ+7YeFg2evUXUHeDBo5ENes0oKnF0R3N7EHuvBiY3tsP0dtWFKqc9gkTMFZLmajuJ9
         +u5w==
X-Gm-Message-State: AOJu0YwX9igbEt1DfvSJUtHNH4H6v7l1YbwwE1i7MS+71tSfaX/kpd3b
	tfab0JBTjMuOKmKhTevQ4emL/0t23jQv4xk3M+jKSLZ0gwL57ZaXJOHNobvsfuc=
X-Google-Smtp-Source: AGHT+IEEGohF2Hgc88Hig10dgi5nhxZypyL6ZJnV9HXjN9si0iG1jgbHuRi7acQd7W8NmtluUsPBSQ==
X-Received: by 2002:adf:f94a:0:b0:33d:bb65:806d with SMTP id q10-20020adff94a000000b0033dbb65806dmr14960404wrr.50.1709896715830;
        Fri, 08 Mar 2024 03:18:35 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:35 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 04/13] sched/balancing: Rename rebalance_domains() => sched_balance_domains()
Date: Fri,  8 Mar 2024 12:18:10 +0100
Message-Id: <20240308111819.1101550-5-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308111819.1101550-1-mingo@kernel.org>
References: <20240308111819.1101550-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/scheduler/sched-domains.rst                    | 2 +-
 Documentation/translations/zh_CN/scheduler/sched-domains.rst | 2 +-
 arch/arm/kernel/topology.c                                   | 2 +-
 kernel/sched/fair.c                                          | 8 ++++----
 kernel/sched/sched.h                                         | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index c7ea05f4107b..5d8e8b8b269e 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -34,7 +34,7 @@ out of balance are tasks moved between groups.
 In kernel/sched/core.c, sched_balance_trigger() is run periodically on each CPU
 through sched_tick(). It raises a softirq after the next regularly scheduled
 rebalancing event for the current runqueue has arrived. The actual load
-balancing workhorse, sched_balance_softirq()->rebalance_domains(), is then run
+balancing workhorse, sched_balance_softirq()->sched_balance_domains(), is then run
 in softirq context (SCHED_SOFTIRQ).
 
 The latter function takes two arguments: the runqueue of current CPU and whether
diff --git a/Documentation/translations/zh_CN/scheduler/sched-domains.rst b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
index 1a8587a971f9..e6590fd80640 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-domains.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
@@ -36,7 +36,7 @@ CPU共享。任意两个组的CPU掩码的交集不一定为空，如果是这
 
 在kernel/sched/core.c中，sched_balance_trigger()在每个CPU上通过sched_tick()
 周期执行。在当前运行队列下一个定期调度再平衡事件到达后，它引发一个软中断。负载均衡真正
-的工作由sched_balance_softirq()->rebalance_domains()完成，在软中断上下文中执行
+的工作由sched_balance_softirq()->sched_balance_domains()完成，在软中断上下文中执行
 （SCHED_SOFTIRQ）。
 
 后一个函数有两个入参：当前CPU的运行队列、它在sched_tick()调用时是否空闲。函数会从
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..2336ee2aa44a 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -42,7 +42,7 @@
  * can take this difference into account during load balance. A per cpu
  * structure is preferred because each CPU updates its own cpu_capacity field
  * during the load balance except for idle cores. One idle core is selected
- * to run the rebalance_domains for all idle cores and the cpu_capacity can be
+ * to run the sched_balance_domains for all idle cores and the cpu_capacity can be
  * updated during this sequence.
  */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e377b675920a..330788b0c617 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11685,7 +11685,7 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
  *
  * Balancing parameters are set up in init_sched_domains.
  */
-static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
+static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 {
 	int continue_balancing = 1;
 	int cpu = rq->cpu;
@@ -12161,7 +12161,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 			rq_unlock_irqrestore(rq, &rf);
 
 			if (flags & NOHZ_BALANCE_KICK)
-				rebalance_domains(rq, CPU_IDLE);
+				sched_balance_domains(rq, CPU_IDLE);
 		}
 
 		if (time_after(next_balance, rq->next_balance)) {
@@ -12422,7 +12422,7 @@ static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
 	/*
 	 * If this CPU has a pending NOHZ_BALANCE_KICK, then do the
 	 * balancing on behalf of the other idle CPUs whose ticks are
-	 * stopped. Do nohz_idle_balance *before* rebalance_domains to
+	 * stopped. Do nohz_idle_balance *before* sched_balance_domains to
 	 * give the idle CPUs a chance to load balance. Else we may
 	 * load balance only within the local sched_domain hierarchy
 	 * and abort nohz_idle_balance altogether if we pull some load.
@@ -12432,7 +12432,7 @@ static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
 
 	/* normal load balance */
 	update_blocked_averages(this_rq->cpu);
-	rebalance_domains(this_rq, idle);
+	sched_balance_domains(this_rq, idle);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5b0ddb0e6017..41024c1c49b4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2904,7 +2904,7 @@ extern void cfs_bandwidth_usage_dec(void);
 #define NOHZ_NEWILB_KICK_BIT	2
 #define NOHZ_NEXT_KICK_BIT	3
 
-/* Run rebalance_domains() */
+/* Run sched_balance_domains() */
 #define NOHZ_BALANCE_KICK	BIT(NOHZ_BALANCE_KICK_BIT)
 /* Update blocked load */
 #define NOHZ_STATS_KICK		BIT(NOHZ_STATS_KICK_BIT)
-- 
2.40.1


