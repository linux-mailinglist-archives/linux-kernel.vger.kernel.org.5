Return-Path: <linux-kernel+bounces-8660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BC81BABA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4012A28D537
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFA539F2;
	Thu, 21 Dec 2023 15:26:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E78360B3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D4BD2F4;
	Thu, 21 Dec 2023 07:27:20 -0800 (PST)
Received: from [192.168.1.25] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 192B03F64C;
	Thu, 21 Dec 2023 07:26:32 -0800 (PST)
Message-ID: <179693ab-74d1-4358-8fdf-04cdcb80a814@arm.com>
Date: Thu, 21 Dec 2023 16:26:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] sched: Generalize misfit load balance
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
 Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
 Chung-Kai Mei <chungkai@google.com>
References: <20231209011759.398021-1-qyousef@layalina.io>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231209011759.398021-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Qais,

On 12/9/23 02:17, Qais Yousef wrote:
> Misfit load balance was added to help handle HMP systems where we can make
> a wrong decision at wake up thinking a task can run at a smaller core, but its
> characteristics change and requires to migrate to a bigger core to meet its
> performance demands.
> 
> With the addition of uclamp, we can encounter more cases where such wrong
> placement decisions can be made and require load balancer to do a corrective
> action.
> 
> Specifically if a big task capped by uclamp_max was placed on a big core at
> wake up because EAS thought it is the most energy efficient core at the time,
> the dynamics of the system might change where other uncapped tasks might wake
> up on the cluster and there could be a better new more energy efficient
> placement for the capped task(s).
> 
> We can generalize the misfit load balance to handle different type of misfits
> (whatever they may be) by simply giving it a reason. The reason can decide the
> type of action required then.
> 
> Current misfit implementation is considered MISFIT_PERF. Which means we need to
> move a task to a better CPU to meet its performance requirement.
> 
> For UCLAMP_MAX I propose MISFIT_POWER, where we need to find a better placement
> to control its impact on power.
> 
> Once we have an API to annotate latency sensitive tasks, it is anticipated
> MISFIT_LATENCY load balance will be required to help handle oversubscribe
> situations to help better distribute the latency sensitive tasks to help reduce
> their wake up latency.
> 
> Patch 1 splits misfit status update from misfit detection by adding a new
> function is_misfit_task().
> 
> Patch 2 implements the generalization logic by adding a misfit reason and
> propagating that correctly and guarding the current misfit code with
> MISFIT_PERF reason.
> 
> Patch 3 is an RFC on a potential implementation for MISFIT_POWER.
> 
> Patch 1 and 2 were tested stand alone and had no regression observed and should
> not introduce a functional change and can be considered for merge if they make
> sense after addressing any review comments.
> 
> Patch 3 was only tested to verify it does what I expected it to do. But no real
> power/perf testing was done. Mainly because I was expecting to remove uclamp
> max-aggregation [1] and the RFC I currently have (which I wrote many many
> months ago) is tied to detecting a task being uncapped by max-aggregation.
> I need to rethink the detection mechanism.

I tried to trigger the MISFIT_POWER misfit reason without success so far.
Would it be possible to provide a workload/test to reliably trigger the
condition ?

Regards,
Pierre

> 
> Beside that, the logic relies on using find_energy_efficient_cpu() to find the
> best potential new placement for the task. To do that though, we need to force
> every CPU to do the MISFIT_POWER load balance as we don't know which CPU should
> do the pull. But there might be better thoughts on how to handle this. So
> feedback and thoughts would be appreciated.
> 
> [1] https://lore.kernel.org/lkml/20231208015242.385103-1-qyousef@layalina.io/
> 
> Thanks!
> 
> --
> Qais Yousef
> 
> Qais Yousef (3):
>    sched/fair: Add is_misfit_task() function
>    sched/fair: Generalize misfit lb by adding a misfit reason
>    sched/fair: Implement new type of misfit MISFIT_POWER
> 
>   kernel/sched/fair.c  | 115 +++++++++++++++++++++++++++++++++++++------
>   kernel/sched/sched.h |   9 ++++
>   2 files changed, 110 insertions(+), 14 deletions(-)
> 

