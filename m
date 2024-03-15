Return-Path: <linux-kernel+bounces-104856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A987D49A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1281F283BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE8354906;
	Fri, 15 Mar 2024 19:47:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4035476B;
	Fri, 15 Mar 2024 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532059; cv=none; b=OLI07F328kei0o1UeLk9APlus1nNlIWPSoeeNWa4Ru17eWlVasNq5CYj1fnfVjod7NkXjBipPIYf6qG/e9PPZdvFW3s0MGSZAPP0GAe37/iBLdbuMjwvrTn1weD6JYdN00SlKQM6GOKrn2kvgI7LC0l4cWe6bOpFduYW23nTN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532059; c=relaxed/simple;
	bh=TKtZ4GMb3j4H7p68J48yfBViqU7V2Ym8JFbsgI4d8Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRJZsthxFLCqo4BhQVdNV9C0KVkDPeb6N8RnDnC/9yxZv/9IvERRiRJ1WpqvLIhs7721uh7gJH0hVotdrK3C2yLRsZdDQIqOlvcsdQN1U1n8cT8A07jpkG8GCOx+vhY6+Sgo8342reFWyREU3WydVXrzvHXyqDBmM0YdT2u6k88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D92C15;
	Fri, 15 Mar 2024 12:48:11 -0700 (PDT)
Received: from [10.57.11.35] (unknown [10.57.11.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE7DD3F73F;
	Fri, 15 Mar 2024 12:47:31 -0700 (PDT)
Message-ID: <4300a3e5-061d-4daf-b277-631bfc16ff85@arm.com>
Date: Fri, 15 Mar 2024 19:47:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/7] sched/fair: Use CFS util_avg_uclamp for
 utilization and frequency
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-kernel@vger.kernel.org,
 David Dai <davidai@google.com>, Saravana Kannan <saravanak@google.com>,
 linux-pm@vger.kernel.org
References: <cover.1706792708.git.hongyan.xia2@arm.com>
 <4f755ae12895bbc74a74bac56bf2ef0f30413a32.1706792708.git.hongyan.xia2@arm.com>
 <5bb38524-fd13-477f-adde-0a9ac01bfeae@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <5bb38524-fd13-477f-adde-0a9ac01bfeae@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/03/2024 12:31, Dietmar Eggemann wrote:
> On 01/02/2024 14:12, Hongyan Xia wrote:
> 
> [...]
> 
>> @@ -7685,11 +7697,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>   static unsigned long
>>   cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>>   {
>> -	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
>> -	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
>> +	struct rq *rq = cpu_rq(cpu);
>> +	struct cfs_rq *cfs_rq = &rq->cfs;
>> +	unsigned long util = root_cfs_util(rq);
>> +	bool capped = uclamp_rq_is_capped(rq);
> 
> I try to rerun your tests in your 2 ipynbs (cover letter) but this let's
> the sum aggr stack go sideways ...
> 
> if 'sched_uclamp_used' then uclamp_rq_is_capped() will call
> cpu_util_cfs()->cpu_util() which then calls uclamp_rq_is_capped()
> recursively resulting in a stack overflow.
> 
> Do you have a fix for that you can share? For the time I remove the call
> to uclamp_rq_is_capped() in cpu_util().

My apologies. This has long ago been fixed and here is the diff:

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1ebdd0b9ebca..d5dcda036e0d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3018,9 +3018,8 @@ static inline bool uclamp_rq_is_capped(struct rq *rq)
         if (!static_branch_likely(&sched_uclamp_used))
                 return false;

-       rq_uclamp_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
-       rq_real_util = READ_ONCE(rq->cfs.avg.util_avg) +
-                      READ_ONCE(rq->avg_rt.util_avg);
+       rq_uclamp_util = READ_ONCE(rq->root_cfs_util_uclamp);
+       rq_real_util = READ_ONCE(rq->cfs.avg.util_avg);

         return rq_uclamp_util < SCHED_CAPACITY_SCALE &&
                rq_real_util > rq_uclamp_util;

> [...]
> 

