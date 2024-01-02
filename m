Return-Path: <linux-kernel+bounces-14643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3596382201B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0CF1F23B12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED025154B0;
	Tue,  2 Jan 2024 17:10:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7471549C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 265C4C15;
	Tue,  2 Jan 2024 09:10:43 -0800 (PST)
Received: from [10.34.100.129] (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1859F3F64C;
	Tue,  2 Jan 2024 09:09:55 -0800 (PST)
Message-ID: <8e2263b7-e33b-43e1-b0df-92b560b8fa25@arm.com>
Date: Tue, 2 Jan 2024 18:09:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v3 2/2] sched/topology: Sort asym_cap_list in descending
 order
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org
References: <20231231175218.510721-1-qyousef@layalina.io>
 <20231231175218.510721-3-qyousef@layalina.io>
Content-Language: en-US
In-Reply-To: <20231231175218.510721-3-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Qais,
I just have some comments regarding the commit message/comments,
otherwise the code (of the 2 patches) looks good to me,

Regards,
Pierre

On 12/31/23 18:52, Qais Yousef wrote:
> So that searches always start from biggest CPU which would help misfit
> detection logic to be more efficient.
> 
> I see the following when adding trace_printks() during add and del
> operations
> 
>              init-1       [000] .....     0.058128: asym_cpu_capacity_update_data: Added new capacity 250. Capacity list order:
>              init-1       [000] .....     0.058132: asym_cpu_capacity_update_data: -- 250
>              init-1       [000] .....     0.058135: asym_cpu_capacity_update_data: Added new capacity 620. Capacity list order:
>              init-1       [000] .....     0.058136: asym_cpu_capacity_update_data: -- 620
>              init-1       [000] .....     0.058137: asym_cpu_capacity_update_data: -- 250
>              init-1       [000] .....     0.058139: asym_cpu_capacity_update_data: Added new capacity 1024. Capacity list order:
>              init-1       [000] .....     0.058140: asym_cpu_capacity_update_data: -- 1024
>              init-1       [000] .....     0.058141: asym_cpu_capacity_update_data: -- 620
>              init-1       [000] .....     0.058142: asym_cpu_capacity_update_data: -- 250
>              init-1       [000] .....     0.058143: asym_cpu_capacity_scan: Final capacity list order:
>              init-1       [000] .....     0.058145: asym_cpu_capacity_scan: -- 1024
>              init-1       [000] .....     0.058145: asym_cpu_capacity_scan: -- 620
>              init-1       [000] .....     0.058146: asym_cpu_capacity_scan: -- 250
>             <...>-244     [007] .....     1.959174: asym_cpu_capacity_update_data: Added new capacity 160. Capacity list order:
>             <...>-244     [007] .....     1.959175: asym_cpu_capacity_update_data: -- 1024
>             <...>-244     [007] .....     1.959176: asym_cpu_capacity_update_data: -- 620
>             <...>-244     [007] .....     1.959176: asym_cpu_capacity_update_data: -- 250
>             <...>-244     [007] .....     1.959176: asym_cpu_capacity_update_data: -- 160
>             <...>-244     [007] .....     1.959183: asym_cpu_capacity_update_data: Added new capacity 498. Capacity list order:
>             <...>-244     [007] .....     1.959184: asym_cpu_capacity_update_data: -- 1024
>             <...>-244     [007] .....     1.959184: asym_cpu_capacity_update_data: -- 620
>             <...>-244     [007] .....     1.959185: asym_cpu_capacity_update_data: -- 498
>             <...>-244     [007] .....     1.959185: asym_cpu_capacity_update_data: -- 250
>             <...>-244     [007] .....     1.959186: asym_cpu_capacity_update_data: -- 160
>             <...>-244     [007] .....     1.959204: asym_cpu_capacity_scan: Deleted capacity 620
>             <...>-244     [007] .....     1.959208: asym_cpu_capacity_scan: Deleted capacity 250
>             <...>-244     [007] .....     1.959209: asym_cpu_capacity_scan: Final capacity list order:
>             <...>-244     [007] .....     1.959209: asym_cpu_capacity_scan: -- 1024
>             <...>-244     [007] .....     1.959210: asym_cpu_capacity_scan: -- 498
>             <...>-244     [007] .....     1.959210: asym_cpu_capacity_scan: -- 160
>           rcuop/7-66      [001] b....     1.968114: free_asym_cap_entry: Freeing capacity 620
>           rcuop/7-66      [001] b....     1.968118: free_asym_cap_entry: Freeing capacity 250

IMO the trace is not necessary.

> 
> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>   kernel/sched/topology.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index ba4a0b18ae25..1505677e4247 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1384,18 +1384,30 @@ static void free_asym_cap_entry(struct rcu_head *head)
>   static inline void asym_cpu_capacity_update_data(int cpu)
>   {
>   	unsigned long capacity = arch_scale_cpu_capacity(cpu);
> -	struct asym_cap_data *entry = NULL;
> +	struct asym_cap_data *insert_entry = NULL;
> +	struct asym_cap_data *entry;
>   
> +	/*
> +	 * Search if capacity already exits. If not, track which the entry
> +	 * where we should insert to keep the list ordered descendingly.
> +	 */

IMO just a small comment like the one suggested below should be enough,
but this is just a suggestion.

>   	list_for_each_entry(entry, &asym_cap_list, link) {
>   		if (capacity == entry->capacity)
>   			goto done;
> +		else if (!insert_entry && capacity > entry->capacity)
> +			insert_entry = list_prev_entry(entry, link);
>   	}
>   
>   	entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);
>   	if (WARN_ONCE(!entry, "Failed to allocate memory for asymmetry data\n"))
>   		return;
>   	entry->capacity = capacity;
> -	list_add_rcu(&entry->link, &asym_cap_list);
> +
> +	/* If NULL then the new capacity is the smallest, add last. */

(something like):
	/* asym_cap_list is sorted by descending order. */
> +	if (!insert_entry)
> +		list_add_tail_rcu(&entry->link, &asym_cap_list);
> +	else
> +		list_add_rcu(&entry->link, &insert_entry->link);
>   done:
>   	__cpumask_set_cpu(cpu, cpu_capacity_span(entry));
>   }

