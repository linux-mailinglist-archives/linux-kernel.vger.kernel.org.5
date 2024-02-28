Return-Path: <linux-kernel+bounces-85852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F3986BC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D151F2209B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1101F71ECE;
	Wed, 28 Feb 2024 23:34:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E213D2EC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163282; cv=none; b=Thxr8IB6LcBlXiSugGHeV8m10lJLibAPnEcl2bFVuLs4Ia+1QbbFgDDIGPkGIcVvZ2Sh846yrj/9DfqvpbY6SsYiSPOY7aD+HZ94S+Ci+e0qmDuRX+nG3fG2z9SFm0WrhgYZXsL/n3HNBQH3Wmqo5QAKWJ1VgMFWw8Y9AMrbu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163282; c=relaxed/simple;
	bh=+MsY1IJSTlCHzh7O9mUgcv30fwS5Nx5yrNhbZQvAZyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayE0Co5FrMZE7UYW/jOeO8YjxI4wISNd6BDkdsQCdy54sSxM0zQl2cvHOfouekMd1kEUR0vlQ0DCzXsQfEoy3KoXEmztC7BTwlq5twesgZ7n8vKx+/p9zzlxJEOC/32eWHoZsKv3Koh5ADa+T4MnuH2uccMQusNeK3zROyKQwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 199A31FB;
	Wed, 28 Feb 2024 15:35:17 -0800 (PST)
Received: from [192.168.2.96] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 617E33F73F;
	Wed, 28 Feb 2024 15:34:34 -0800 (PST)
Message-ID: <1146ab2f-56c7-43f3-b26b-d91d2bd08556@arm.com>
Date: Thu, 29 Feb 2024 00:34:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/fair: Add EAS checks before updating
 overutilized
Content-Language: en-US
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Pierre Gondois <pierre.gondois@arm.com>
Cc: yu.c.chen@intel.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
 aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
 morten.rasmussen@arm.com, qyousef@layalina.io, mingo@kernel.org,
 peterz@infradead.org, vincent.guittot@linaro.org
References: <20240228071621.602596-1-sshegde@linux.ibm.com>
 <20240228071621.602596-2-sshegde@linux.ibm.com>
 <86f000a3-3068-4c57-858d-c00e3eb6e974@arm.com>
 <72c2d279-90ae-4612-9b96-e579333b8088@linux.ibm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <72c2d279-90ae-4612-9b96-e579333b8088@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 18:24, Shrikanth Hegde wrote:
> 
> 
> On 2/28/24 9:28 PM, Pierre Gondois wrote:

[...]

> But we will do some extra computation currently and then not use it if it 
> Non-EAS case in update_sg_lb_stats
> 
> Would something like this makes sense?
> @@ -9925,7 +9925,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 if (nr_running > 1)
>                         *sg_status |= SG_OVERLOAD;
>  
> -               if (cpu_overutilized(i))
> +               if (sched_energy_enabled() && cpu_overutilized(i))
>                         *sg_status |= SG_OVERUTILIZED;

Yes, we could also disable the setting of OU in load_balance in the none
!EAS case.

[...]

>> NIT:
>> When called from check_update_overutilized_status(),
>> sched_energy_enabled() will be checked twice.
> Yes. 
> But, I think that's okay since it is a static branch check at best. 
> This way it keeps the code simpler. 

You could keep the ched_energy_enabled() outside of the new
set_overutilized_status() to avoid this:

-->8--

---
 kernel/sched/fair.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 32bc98d9123d..c82164bf45f3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6676,12 +6676,19 @@ static inline bool cpu_overutilized(int cpu)
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }
 
+static inline void set_overutilized_status(struct rq *rq, unsigned int val)
+{
+	WRITE_ONCE(rq->rd->overutilized, val);
+	trace_sched_overutilized_tp(rq->rd, val);
+}
+
 static inline void update_overutilized_status(struct rq *rq)
 {
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
-		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
-	}
+	if (!sched_energy_enabled())
+		return;
+
+	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+		set_overutilized_status(rq, SG_OVERUTILIZED);
 }
 #else
 static inline void update_overutilized_status(struct rq *rq) { }
@@ -10755,19 +10762,16 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
 
 	if (!env->sd->parent) {
-		struct root_domain *rd = env->dst_rq->rd;
-
 		/* update overload indicator if we are at root domain */
-		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
+		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
-	} else if (sg_status & SG_OVERUTILIZED) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
+		if (sched_energy_enabled()) {
+			set_overutilized_status(env->dst_rq,
+						sg_status & SG_OVERUTILIZED);
+		}
+	} else if (sched_energy_enabled() && sg_status & SG_OVERUTILIZED) {
+		set_overutilized_status(env->dst_rq, SG_OVERUTILIZED);
 	}
 
 	update_idle_cpu_scan(env, sum_util);
-- 
2.25.1

