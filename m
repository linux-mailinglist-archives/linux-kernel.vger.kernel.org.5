Return-Path: <linux-kernel+bounces-95979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15198875594
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07D51F2220A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5E6130E53;
	Thu,  7 Mar 2024 17:54:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A11DA27
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834054; cv=none; b=N5RkmxOI8kk2IxV6ebrnhyROTABXMMqz5WrVMelzOdJPqnJImACrKN3XHygNPH1sIz1ScfY01FblR5rUIrDKAl4Q5Y8pwe1eeqPqkoqCqfS5womE3+4ZaLc6gWHFVpAMkjP/x80WUlpUc7L4JBdoLK2so1FqGDMpL0ewZ/iTuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834054; c=relaxed/simple;
	bh=A+zsF/94TegyvD88zYySBRwI2gYvPgWTS6m8gCqLJ5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRlDurMWC4s0RdN9sfP6GMIOxs/aEmdnrVx8IMxmlPyX6LtY/wgJhgRJEzuxTXvQFeGY2FEQoBlpSMN7AnRL/60+cYayb3arLIirxM5sYvSlYUtWkVPDtjojhgHDUJ5ELls1w5miSn5b6r9qQSKq1S7RPpnWvJwjXbWe5h1+/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99AF71FB;
	Thu,  7 Mar 2024 09:54:48 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B652B3F762;
	Thu,  7 Mar 2024 09:54:10 -0800 (PST)
Message-ID: <c39352f3-6018-49c5-b413-b8da1b601d65@arm.com>
Date: Thu, 7 Mar 2024 18:54:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] sched/fair: Check a task has a fitting cpu when
 updating misfit
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Pierre Gondois <Pierre.Gondois@arm.com>
References: <20240220225622.2626569-1-qyousef@layalina.io>
 <20240220225622.2626569-3-qyousef@layalina.io>
 <d6699c3a-3df6-46a3-98db-e07c8722f106@arm.com>
 <20240303174416.7m3gv5wywcmedov4@airbuntu>
 <20240306214704.uditboboedut2lm2@airbuntu>
 <CAKfTPtBLUkZ0hEd8K=e9wjg+zn9N5jgia-7wwLa3jaeYK+qkCw@mail.gmail.com>
 <20240307103527.y5zrnkjvwoqhtyll@airbuntu>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240307103527.y5zrnkjvwoqhtyll@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 11:35, Qais Yousef wrote:
> On 03/07/24 10:14, Vincent Guittot wrote:
>> On Wed, 6 Mar 2024 at 22:47, Qais Yousef <qyousef@layalina.io> wrote:
>>>
>>> On 03/03/24 17:44, Qais Yousef wrote:
>>>
>>>>       diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>       index 174687252e1a..b0e60a565945 100644
>>>>       --- a/kernel/sched/fair.c
>>>>       +++ b/kernel/sched/fair.c
>>>>       @@ -8260,6 +8260,8 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
>>>>                       cpumask_t *cpumask;
>>>>
>>>>                       cpumask = cpu_capacity_span(entry);
>>>>       +               if (!cpumask_intersects(cpu_active_mask, cpumask))
>>>>       +                       continue;
>>>>                       if (!cpumask_intersects(p->cpus_ptr, cpumask))
>>>>                               continue;
>>>>
>>>>       @@ -8269,6 +8271,53 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
>>>>               rcu_read_unlock();
>>>>        }
>>>>
>>>>       +static void __update_tasks_max_allowed_capacity(unsigned long capacity)
>>>>       +{
>>>>       +       struct task_struct *g, *p;
>>>>       +
>>>>       +       for_each_process_thread(g, p) {
>>>>       +               if (fair_policy(p->policy) && p->max_allowed_capacity == capacity)
>>>
>>> This condition actually not good enough. We need to differentiate between going
>>> online/offline. I didn't want to call set_task_max_allowed_capacity()
>>> unconditionally and make hotplug even slower.
>>
>> But should we even try to fix this ? hotplugging a cpu is a special
>> case and with patch 4 you will not increase lb_interval anymore
> 
> I don't care to be honest and this was my first reaction, but I couldn't ignore
> the report.

Seeing a 'max_allowed_capacity' on the task which is not achievable
anymore due to CPU hp will still cause MF activity. So it's a special
case but CPU hp is part of mainline ... ?

> I will need to do something to handle the dynamic EM changing capacities anyway
> after 6.9 merge window. Or maybe now; I still haven't thought about it. I am

Do you think about the case that the reloadable EM contains a
'table[ highest OPP].performance' value which is different to
arch_scale_cpu_capacity()?

Can we reject those EM reloads to avoid this mismatch?

> hoping I can trigger the update somewhere from the topology code. Maybe that
> work will make handling hotplug easier than the approach I've taken now on
> rq_online/offline.
> 
> FWIW, I have a working patch that solves the problem. The only drawback is that
> rq_online/offline() are not only called from sched_cpu_activate/deactivate()
> path but from build_sched_domains() path which for some reasons ends up calling
> rq_offline/online() for each cpu in the map.  To be even more efficient I need

This can be avoided IMHO when you do this only for 'cpu_of(rq) ==
smp_processor_id()'.

For off-lining there will be only one such call to rq_offline_fair()
(from sched_cpu_deactivate()) but for on-lining there are still 2 such
calls to rq_online_fair() (from sched_cpu_activate() and rq_attach_root()).

> to teach rq_offline/online() to differentiate between the two. Or refactor the
> code. Which if you don't think it's important too I'd be happy to drop this and
> replace it with a comment to see if someone cares. Only testing and dev could
> end up using hotplug; so there could be a difference in behavior in regards how
> often misfit migration can kick. But as you said hopefully with these fixes
> it'd just end up being unnecessary work. The only potential problem maybe is
> that misfit lb has a precedence over other types of lb types; so we could
> end up delaying load imbalance if there's a pointless misfit lb?
> 
> I'm happy to follow the crowd. But it'd be nice if this series can be made
> mergeable with follow up work. It'd make life much easier for me.

Or is the plan to only go with '[PATCH v6 4/4] sched/fair: Don't double
balance_interval for migrate_misfit' ?



