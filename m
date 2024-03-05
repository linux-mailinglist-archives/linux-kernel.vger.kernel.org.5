Return-Path: <linux-kernel+bounces-91582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AEF8713EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F14A1F23F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A952941F;
	Tue,  5 Mar 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s176z2eX"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D013286BF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607030; cv=none; b=niJ//ELq4U/FhfTRxZOcPT9d6Aqy6c5Mh9daRohcZ8RZKqFp3c9hXGxA7r7MXWDcoYAqTwipvYXQVWpSXXQDHb2CZJniaSt+aoK9lU/FpXt7NTojqq2aFZXhE/1QQJCkzue4ZUEubBXLCr9i2L9KJs0FgN5sVorUk3ku7NTMqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607030; c=relaxed/simple;
	bh=rHC9USEEgmXjo80WfaHeZlBPLiqTabTzCXcth89vmQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urwvUbZXkt/jJY0/xpqVuA2fZi6N4ZFLho3w1LtjLOZLftwCG7EhVGpEPUdKRgeKanQ4hGLplhzgU3SDU7XbRis+5Ri6zVDUN81G66l0MNp+k0qRvk8t4lv9sQlelyOa6l8ktW39C6qb6xD4DZayz0ZqN1LsTLOlPx067iWMxqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s176z2eX; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b044d9b-d3b1-4fb3-8b05-2a54c2b45716@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709607024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beUuoq2trrcVUwnkWmtat2HUyfIXk2ilttkG7yqdylo=;
	b=s176z2eXd+OYZPI6Y//fhAExukI7W6k5Cay9kE9dTHAchc7U5cofVgAUm6Og1PF+QkZMTL
	33gqhjGM7LDv2d8DtyD1nTAR1QI3heeu87qo8fNStZ45kQJ2d8xdvgaNvdVE+Br+ulClyw
	KrjzlyqksaCjvJLd8cSQP6QWL7XRnjo=
Date: Tue, 5 Mar 2024 10:49:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 4/8] padata: dispatch works on different nodes
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>,
 Muchun Song <muchun.song@linux.dev>, Tim Chen <tim.c.chen@linux.intel.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Jane Chu <jane.chu@oracle.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
References: <20240222140422.393911-1-gang.li@linux.dev>
 <20240222140422.393911-5-gang.li@linux.dev>
 <7g53p42favkoibzg4w3ly3ypdjdy6oymhj74ekwk62bwx4rlaj@seoavjygfadq>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <7g53p42favkoibzg4w3ly3ypdjdy6oymhj74ekwk62bwx4rlaj@seoavjygfadq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/2/28 05:24, Daniel Jordan wrote:
> Hi,
> 
> On Thu, Feb 22, 2024 at 10:04:17PM +0800, Gang Li wrote:
>> When a group of tasks that access different nodes are scheduled on the
>> same node, they may encounter bandwidth bottlenecks and access latency.
>>
>> Thus, numa_aware flag is introduced here, allowing tasks to be
>> distributed across different nodes to fully utilize the advantage of
>> multi-node systems.
>>
>> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
>> Tested-by: David Rientjes <rientjes@google.com>
>> Reviewed-by: Muchun Song <muchun.song@linux.dev>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> ---
>>   include/linux/padata.h |  2 ++
>>   kernel/padata.c        | 14 ++++++++++++--
>>   mm/mm_init.c           |  1 +
>>   3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/padata.h b/include/linux/padata.h
>> index 495b16b6b4d72..8f418711351bc 100644
>> --- a/include/linux/padata.h
>> +++ b/include/linux/padata.h
>> @@ -137,6 +137,7 @@ struct padata_shell {
>>    *             appropriate for one worker thread to do at once.
>>    * @max_threads: Max threads to use for the job, actual number may be less
>>    *               depending on task size and minimum chunk size.
>> + * @numa_aware: Distribute jobs to different nodes with CPU in a round robin fashion.
> 
> numa_interleave seems more descriptive.
> 
>>    */
>>   struct padata_mt_job {
>>   	void (*thread_fn)(unsigned long start, unsigned long end, void *arg);
>> @@ -146,6 +147,7 @@ struct padata_mt_job {
>>   	unsigned long		align;
>>   	unsigned long		min_chunk;
>>   	int			max_threads;
>> +	bool			numa_aware;
>>   };
>>   
>>   /**
>> diff --git a/kernel/padata.c b/kernel/padata.c
>> index 179fb1518070c..e3f639ff16707 100644
>> --- a/kernel/padata.c
>> +++ b/kernel/padata.c
>> @@ -485,7 +485,8 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>>   	struct padata_work my_work, *pw;
>>   	struct padata_mt_job_state ps;
>>   	LIST_HEAD(works);
>> -	int nworks;
>> +	int nworks, nid;
>> +	static atomic_t last_used_nid __initdata;
> 
> nit, move last_used_nid up so it's below load_balance_factor to keep
> that nice tree shape
> 
>>   
>>   	if (job->size == 0)
>>   		return;
>> @@ -517,7 +518,16 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>>   	ps.chunk_size = roundup(ps.chunk_size, job->align);
>>   
>>   	list_for_each_entry(pw, &works, pw_list)
>> -		queue_work(system_unbound_wq, &pw->pw_work);
>> +		if (job->numa_aware) {
>> +			int old_node = atomic_read(&last_used_nid);
>> +
>> +			do {
>> +				nid = next_node_in(old_node, node_states[N_CPU]);
>> +			} while (!atomic_try_cmpxchg(&last_used_nid, &old_node, nid));
> 
> There aren't concurrent NUMA-aware _do_multithreaded calls now, so an
> atomic per work seems like an unnecessary expense for guarding against

Hi Daniel,

Yes, this is not necessary. But I think this operation is infrequent, so
the burden shouldn't be too great?

> possible uneven thread distribution in the future.  Non-atomic access
> instead?
> 

>> +			queue_work_node(nid, system_unbound_wq, &pw->pw_work);
>> +		} else {
>> +			queue_work(system_unbound_wq, &pw->pw_work);
>> +		}
>>   
>>   	/* Use the current thread, which saves starting a workqueue worker. */
>>   	padata_work_init(&my_work, padata_mt_helper, &ps, PADATA_WORK_ONSTACK);
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 2c19f5515e36c..549e76af8f82a 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -2231,6 +2231,7 @@ static int __init deferred_init_memmap(void *data)
>>   			.align       = PAGES_PER_SECTION,
>>   			.min_chunk   = PAGES_PER_SECTION,
>>   			.max_threads = max_threads,
>> +			.numa_aware  = false,
>>   		};
>>   
>>   		padata_do_multithreaded(&job);
>> -- 
>> 2.20.1
>>

