Return-Path: <linux-kernel+bounces-24354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDBA82BB79
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F1F1C24B71
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EFF5C903;
	Fri, 12 Jan 2024 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rl6/mhHP"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02015C8FB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <feaf7851-f924-48f4-b16a-2fa5efdb28cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705043387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1/E36ja6hSjXcFMnhf7nMX3AJMPWbXzIlOegBOBTgw=;
	b=rl6/mhHP8qss1zJkt8tAb+O2UQRGEreguRM5ECbwehucdUCmiM3gdzMM1AvxJ6bX7sZ25K
	tKZs7xxGHKIplmLH6QebIJt7P/KRkt3ckrFNsgOC+P31/Re+W92p+KVm7w3R9j9bpYCWaL
	Zx12flbfZLdvnRGUe7PLpX4I8UkNgSs=
Date: Fri, 12 Jan 2024 15:09:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/7] padata: dispatch works on different nodes
Content-Language: en-US
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, David Rientjes
 <rientjes@google.com>, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com, David Hildenbrand <david@redhat.com>,
 Muchun Song <muchun.song@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
 <20240102131249.76622-4-gang.li@linux.dev>
 <1d9074955618ea0b4b155701f7c1b8b18a43fa8d.camel@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <1d9074955618ea0b4b155701f7c1b8b18a43fa8d.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/12 01:50, Tim Chen wrote:
> On Tue, 2024-01-02 at 21:12 +0800, Gang Li wrote:
>> When a group of tasks that access different nodes are scheduled on the
>> same node, they may encounter bandwidth bottlenecks and access latency.
>>
>> Thus, numa_aware flag is introduced here, allowing tasks to be
>> distributed across different nodes to fully utilize the advantage of
>> multi-node systems.
>>
>> Signed-off-by: Gang Li <gang.li@linux.dev>
>> ---
>>   include/linux/padata.h | 3 +++
>>   kernel/padata.c        | 8 ++++++--
>>   mm/mm_init.c           | 1 +
>>   3 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/padata.h b/include/linux/padata.h
>> index 495b16b6b4d72..f79ccd50e7f40 100644
>> --- a/include/linux/padata.h
>> +++ b/include/linux/padata.h
>> @@ -137,6 +137,8 @@ struct padata_shell {
>>    *             appropriate for one worker thread to do at once.
>>    * @max_threads: Max threads to use for the job, actual number may be less
>>    *               depending on task size and minimum chunk size.
>> + * @numa_aware: Dispatch jobs to different nodes. If a node only has memory but
>> + *              no CPU, dispatch its jobs to a random CPU.
>>    */
>>   struct padata_mt_job {
>>   	void (*thread_fn)(unsigned long start, unsigned long end, void *arg);
>> @@ -146,6 +148,7 @@ struct padata_mt_job {
>>   	unsigned long		align;
>>   	unsigned long		min_chunk;
>>   	int			max_threads;
>> +	bool			numa_aware;
>>   };
>>   
>>   /**
>> diff --git a/kernel/padata.c b/kernel/padata.c
>> index 179fb1518070c..1c2b3a337479e 100644
>> --- a/kernel/padata.c
>> +++ b/kernel/padata.c
>> @@ -485,7 +485,7 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>>   	struct padata_work my_work, *pw;
>>   	struct padata_mt_job_state ps;
>>   	LIST_HEAD(works);
>> -	int nworks;
>> +	int nworks, nid = 0;
> 
> If we always start from 0, we may be biased towards the low numbered node,
> and not use high numbered nodes at all.  Suggest you do
> static nid = 0;
> 

When we use `static`, if there are multiple parallel calls to
`padata_do_multithreaded`, it may result in an uneven distribution of
tasks for each padata_do_multithreaded.

We can make the following modifications to address this issue.

```
diff --git a/kernel/padata.c b/kernel/padata.c
index 1c2b3a337479e..925e48df6dd8d 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -485,7 +485,8 @@ void __init padata_do_multithreaded(struct 
padata_mt_job *job)
         struct padata_work my_work, *pw;
         struct padata_mt_job_state ps;
         LIST_HEAD(works);
-       int nworks, nid = 0;
+       int nworks, nid;
+       static volatile int global_nid = 0;

         if (job->size == 0)
                 return;
@@ -516,12 +517,15 @@ void __init padata_do_multithreaded(struct 
padata_mt_job *job)
         ps.chunk_size = max(ps.chunk_size, job->min_chunk);
         ps.chunk_size = roundup(ps.chunk_size, job->align);

+       nid = global_nid;
         list_for_each_entry(pw, &works, pw_list)
-               if (job->numa_aware)
-                       queue_work_node((++nid % num_node_state(N_MEMORY)),
-                                       system_unbound_wq, &pw->pw_work);
-               else
+               if (job->numa_aware) {
+                       queue_work_node(nid, system_unbound_wq, 
&pw->pw_work);
+                       nid = next_node(nid, node_states[N_CPU]);
+               } else
                         queue_work(system_unbound_wq, &pw->pw_work);
+       if (job->numa_aware)
+               global_nid = nid;

         /* Use the current thread, which saves starting a workqueue 
worker. */
         padata_work_init(&my_work, padata_mt_helper, &ps, 
PADATA_WORK_ONSTACK);
```


>>   
>>   	if (job->size == 0)
>>   		return;
>> @@ -517,7 +517,11 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>>   	ps.chunk_size = roundup(ps.chunk_size, job->align);
>>   
>>   	list_for_each_entry(pw, &works, pw_list)
>> -		queue_work(system_unbound_wq, &pw->pw_work);
>> +		if (job->numa_aware)
>> +			queue_work_node((++nid % num_node_state(N_MEMORY)),
>> +					system_unbound_wq, &pw->pw_work);
> 
> I think we should use nid = next_node(nid, node_states[N_CPU]) instead of
> ++nid % num_node_state(N_MEMORY).  You are picking the next node with CPU
> to handle the job.
> 
> Tim
> 

I agree.

