Return-Path: <linux-kernel+bounces-30721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EBC832385
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDD61F23C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443714A05;
	Fri, 19 Jan 2024 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="anA8kDQA"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E814E4689
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705633189; cv=none; b=RgtWgzimI6RtLmsMeIPPH+i5uuhgDrCl8Bgrskn5Zm8yzjBwiACR+lc90YLIERAbkkzzw0jmS7J5df2QAGT/RQ4qcpMWorRd8uxZi1uhllqqJAEwXM+2lGz8ogVPWEp6Y+2K6ksDnwKOMEqwVY4+8sluXd1KVsFRArZ1lj5bVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705633189; c=relaxed/simple;
	bh=236h0DgDZImCK2goedN8W9SWmHCQR18+oOMDZ46NdtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhBvNNbsa39oVG/d3fculjr+OvOjrKp84LS3wnFWVsWsI7Ko5pF74DCc5DWC9YiET7lV1SpD4YJy1pqfJ6jz84Xf2KGJbk6Bh7Enok/nywtuiAGnZRJkT/zHPvPVQNX9w2u/v1gFg18rKy2hSWSGWCX6N/9V9UIBJ2EoSoFxfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=anA8kDQA; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <10f26c5c-760d-4f1b-abdc-8508971236ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705633185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+Kc2NDnmlkNzK7U+ZErpyTm3v0Dgj/NSpkX/uSwmaM=;
	b=anA8kDQAnpivlHYD60wp5ZBbUwPiXufJoerQq/zAq6vBLsigfM74QswzqZq3BfqamEdtj9
	3x5ldDNPwygvuzhABK0bOBEvfN5st5WJZJgu3xBYdk/xJbMLsSi2UtV8JU4miD7gqY3pNK
	7WCX+Gj74hhjmZ/U+8svf/R2VTPvX7g=
Date: Fri, 19 Jan 2024 10:59:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/7] padata: dispatch works on different nodes
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-4-gang.li@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240118123911.88833-4-gang.li@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/18 20:39, Gang Li wrote:
> When a group of tasks that access different nodes are scheduled on the
> same node, they may encounter bandwidth bottlenecks and access latency.
>
> Thus, numa_aware flag is introduced here, allowing tasks to be
> distributed across different nodes to fully utilize the advantage of
> multi-node systems.
>
> Signed-off-by: Gang Li <gang.li@linux.dev>
> Tested-by: David Rientjes <rientjes@google.com>
> ---
>   include/linux/padata.h |  3 +++
>   kernel/padata.c        | 14 ++++++++++++--
>   mm/mm_init.c           |  1 +
>   3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/padata.h b/include/linux/padata.h
> index 495b16b6b4d7..f79ccd50e7f4 100644
> --- a/include/linux/padata.h
> +++ b/include/linux/padata.h
> @@ -137,6 +137,8 @@ struct padata_shell {
>    *             appropriate for one worker thread to do at once.
>    * @max_threads: Max threads to use for the job, actual number may be less
>    *               depending on task size and minimum chunk size.
> + * @numa_aware: Dispatch jobs to different nodes. If a node only has memory but
> + *              no CPU, dispatch its jobs to a random CPU.
>    */
>   struct padata_mt_job {
>   	void (*thread_fn)(unsigned long start, unsigned long end, void *arg);
> @@ -146,6 +148,7 @@ struct padata_mt_job {
>   	unsigned long		align;
>   	unsigned long		min_chunk;
>   	int			max_threads;
> +	bool			numa_aware;
>   };
>   
>   /**
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 179fb1518070..10eae3f59203 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -485,7 +485,8 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>   	struct padata_work my_work, *pw;
>   	struct padata_mt_job_state ps;
>   	LIST_HEAD(works);
> -	int nworks;
> +	int nworks, nid;
> +	static atomic_t last_used_nid = ATOMIC_INIT(0);
last_used_nid is only used during boot time so it could be
__init_data. Otherwise, LGTM.

Reviewed-by: Muchun Song <muchun.song@linux.dev>

>   
>   	if (job->size == 0)
>   		return;
> @@ -517,7 +518,16 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>   	ps.chunk_size = roundup(ps.chunk_size, job->align);
>   
>   	list_for_each_entry(pw, &works, pw_list)
> -		queue_work(system_unbound_wq, &pw->pw_work);
> +		if (job->numa_aware) {
> +			int old_node = atomic_read(&last_used_nid);
> +
> +			do {
> +				nid = next_node_in(old_node, node_states[N_CPU]);
> +			} while (!atomic_try_cmpxchg(&last_used_nid, &old_node, nid));
> +			queue_work_node(nid, system_unbound_wq, &pw->pw_work);
> +		} else {
> +			queue_work(system_unbound_wq, &pw->pw_work);
> +		}
>   
>   	/* Use the current thread, which saves starting a workqueue worker. */
>   	padata_work_init(&my_work, padata_mt_helper, &ps, PADATA_WORK_ONSTACK);
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 2c19f5515e36..549e76af8f82 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2231,6 +2231,7 @@ static int __init deferred_init_memmap(void *data)
>   			.align       = PAGES_PER_SECTION,
>   			.min_chunk   = PAGES_PER_SECTION,
>   			.max_threads = max_threads,
> +			.numa_aware  = false,
>   		};
>   
>   		padata_do_multithreaded(&job);


