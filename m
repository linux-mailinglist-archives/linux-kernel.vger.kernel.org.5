Return-Path: <linux-kernel+bounces-99858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82346878E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1DC1F211DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A920A347C2;
	Tue, 12 Mar 2024 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SAIxxY67"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583881E48C;
	Tue, 12 Mar 2024 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223557; cv=none; b=LtQQx9IK5qG2GaITcJXR3aNo5luWm1aotbBK3ccJDbm0mnUWafzrQMmsSfBfZoeLNECMdzs/HyJOS8m+hfvGmNRVy+TWV/PJI5hZY1iN/pSl0dgNhX/FhEt1xr/X8JPrLldYeZQThxndorW1Q0cn0Z5SOEb6W+Gxg0DX9nXMftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223557; c=relaxed/simple;
	bh=rDcBJbsRo0JhtRhfwW/jpTXKT07sa2TW+DJ7aRY/6fs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UkVtNwBq3Y0fSCBvMvIbb1yVqDNdcrWcmY1SOliuAxOyEPhZ6QyUS0EX9VAwAUhmEH+aU2IePuQsno2Ipg0YxHYMeNYbgBVjX0kura0tVEQxt4w1h+uwTwq5o53XkI+YskkDBHXonvFAAesY6ZvK58XtMibvZj3B650k2RHx79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SAIxxY67; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710223552; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=+tAyefb9X6kRjApZV5oPZWTBz3sh185ettyS9iiaj4k=;
	b=SAIxxY67l9mMRH/Faczezr5ve+81pDcrAnAaC99+VoNi5JQkP4ip9seIgXGSxq9qu9rcDLzHFx4l943ESRL+xT5/jeaRiLQ8SbD76cSI5yTuAjv31cZNYzTUQZUEk5VQM/eNaCTi4tMNEmNX7By55sRn2vPIwkqaA01RCptMer4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0W2KiIQW_1710223549;
Received: from 30.240.112.150(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W2KiIQW_1710223549)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 14:05:51 +0800
Message-ID: <2a6642a1-d20d-4588-9e5c-a4693f96fe38@linux.alibaba.com>
Date: Tue, 12 Mar 2024 14:05:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v11 3/3] ACPI: APEI: handle synchronous exceptions in task
 work to send correct SIGBUS si_code
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
 mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-4-xueshuai@linux.alibaba.com>
 <20240308101836.GDZerl_IXIkWt8VuZN@fat_crate.local>
Content-Language: en-US
In-Reply-To: <20240308101836.GDZerl_IXIkWt8VuZN@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/3/8 18:18, Borislav Petkov wrote:
> On Sun, Feb 04, 2024 at 04:01:44PM +0800, Shuai Xue wrote:
>> Hardware errors could be signaled by asynchronous interrupt, e.g. when an
>> error is detected by a background scrubber, or signaled by synchronous
>> exception, e.g. when a CPU tries to access a poisoned cache line. Since
>> commit a70297d22132 ("ACPI: APEI: set memory failure flags as
>> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
>> could be used to determine whether a synchronous exception occurs on ARM64
>> platform. When a synchronous exception is detected, the kernel should
>> terminate the current process which accessing the poisoned page. This is
> 
> "which has accessed poison data"

Thank you. Will fix the grammer.

> 
>> done by sending a SIGBUS signal with an error code BUS_MCEERR_AR,
>> indicating an action-required machine check error on read.
>>
>> However, the memory failure recovery is incorrectly sending a SIGBUS
>> with wrong error code BUS_MCEERR_AO for synchronous errors in early kill
>> mode, even MF_ACTION_REQUIRED is set. The main problem is that
> 
> "even if"

Thank you. Will fix the grammer.


> 
>> synchronous errors are queued as a memory_failure() work, and are
>> executed within a kernel thread context, not the user-space process that
>> encountered the corrupted memory on ARM64 platform. As a result, when
>> kill_proc() is called to terminate the process, it sends the incorrect
>> SIGBUS error code because the context in which it operates is not the
>> one where the error was triggered.
>>
>> To this end, queue memory_failure() as a task_work so that it runs in
>> the context of the process that is actually consuming the poisoned data,
>> and it will send SIBBUS with si_code BUS_MCEERR_AR.
> 
> SIGBUS

Sorry, will fix the typo.
> 
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>  drivers/acpi/apei/ghes.c | 77 +++++++++++++++++++++++-----------------
>>  include/acpi/ghes.h      |  3 --
>>  mm/memory-failure.c      | 13 -------
>>  3 files changed, 44 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 0892550732d4..e5086d795bee 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -465,28 +465,41 @@ static void ghes_clear_estatus(struct ghes *ghes,
>>  }
>>  
>>  /*
>> - * Called as task_work before returning to user-space.
>> - * Ensure any queued work has been done before we return to the context that
>> - * triggered the notification.
>> + * struct sync_task_work - for synchronous RAS event
> 
> What's so special about it being a "sync_"?
> 
> task_work is just fine and something else could use it too.

You are right, the `sync_task_work` is only use for synchronous RAS event right, but
it could be also use for other purpose in the future. The purpose can be specified
through flags.

I will remove the `sync_` prefix.

> 
>> + *
>> + * @twork:                callback_head for task work
>> + * @pfn:                  page frame number of corrupted page
>> + * @flags:                fine tune action taken
> 
> s/fine tune action taken/work control flags/
> 

Will fix it.

>> + *
>> + * Structure to pass task work to be handled before
>> + * ret_to_user via task_work_add().
> 
> What is "ret_to_user"?
> 
> If this is an ARM thing, then make sure you explain stuff properly and
> detailed. This driver is used by multiple architectures.

It is not ARM specific thing. I mean it is used by task_work before returning to user-space.

	+ * Structure to pass task work to be handled before
	+ * returning to user-space via task_work_add().

> 
>>   */
>> -static void ghes_kick_task_work(struct callback_head *head)
>> +struct sync_task_work {
>> +	struct callback_head twork;
>> +	u64 pfn;
>> +	int flags;
>> +};
>> +
>> +static void memory_failure_cb(struct callback_head *twork)
>>  {
>> -	struct acpi_hest_generic_status *estatus;
>> -	struct ghes_estatus_node *estatus_node;
>> -	u32 node_len;
>> +	int ret;
>> +	struct sync_task_work *twcb =
>> +		container_of(twork, struct sync_task_work, twork);
> 
> Ugly linebreak - no need for it.

Will fix it.
> 
>> -	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
>> -	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>> -		memory_failure_queue_kick(estatus_node->task_work_cpu);
>> +	ret = memory_failure(twcb->pfn, twcb->flags);
>> +	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
>>  
>> -	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>> -	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
>> -	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
>> +	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
>> +		return;
>> +
>> +	pr_err("Sending SIGBUS to current task due to memory error not recovered");
>> +	force_sig(SIGBUS);
>>  }
>>  
>>  static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>  {
>>  	unsigned long pfn;
>> +	struct sync_task_work *twcb;
>>  
>>  	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>>  		return false;
>> @@ -499,6 +512,18 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>  		return false;
>>  	}
>>  
>> +	if (flags == MF_ACTION_REQUIRED && current->mm) {
>> +		twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
>> +		if (!twcb)
>> +			return false;
>> +
>> +		twcb->pfn = pfn;
>> +		twcb->flags = flags;
>> +		init_task_work(&twcb->twork, memory_failure_cb);
>> +		task_work_add(current, &twcb->twork, TWA_RESUME);
>> +		return true;
>> +	}
>> +
>>  	memory_failure_queue(pfn, flags);
>>  	return true;
>>  }
>> @@ -746,7 +771,7 @@ int cxl_cper_unregister_callback(cxl_cper_callback callback)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_callback, CXL);
>>  
>> -static bool ghes_do_proc(struct ghes *ghes,
>> +static void ghes_do_proc(struct ghes *ghes,
>>  			 const struct acpi_hest_generic_status *estatus)
>>  {
>>  	int sev, sec_sev;
>> @@ -814,8 +839,6 @@ static bool ghes_do_proc(struct ghes *ghes,
>>  		pr_err("Sending SIGBUS to current task due to memory error not recovered");
>>  		force_sig(SIGBUS);
>>  	}
>> -
>> -	return queued;
>>  }
>>  
>>  static void __ghes_print_estatus(const char *pfx,
>> @@ -1117,9 +1140,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>>  	struct ghes_estatus_node *estatus_node;
>>  	struct acpi_hest_generic *generic;
>>  	struct acpi_hest_generic_status *estatus;
>> -	bool task_work_pending;
>>  	u32 len, node_len;
>> -	int ret;
>>  
>>  	llnode = llist_del_all(&ghes_estatus_llist);
>>  	/*
>> @@ -1134,25 +1155,16 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>>  		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>>  		len = cper_estatus_len(estatus);
>>  		node_len = GHES_ESTATUS_NODE_LEN(len);
>> -		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
>> +
>> +		ghes_do_proc(estatus_node->ghes, estatus);
>> +
>>  		if (!ghes_estatus_cached(estatus)) {
>>  			generic = estatus_node->generic;
>>  			if (ghes_print_estatus(NULL, generic, estatus))
>>  				ghes_estatus_cache_add(generic, estatus);
>>  		}
>> -
>> -		if (task_work_pending && current->mm) {
>> -			estatus_node->task_work.func = ghes_kick_task_work;
>> -			estatus_node->task_work_cpu = smp_processor_id();
>> -			ret = task_work_add(current, &estatus_node->task_work,
>> -					    TWA_RESUME);
>> -			if (ret)
>> -				estatus_node->task_work.func = NULL;
>> -		}
>> -
>> -		if (!estatus_node->task_work.func)
>> -			gen_pool_free(ghes_estatus_pool,
>> -				      (unsigned long)estatus_node, node_len);
> 
> I have no clue why this is being removed.

Before this patch, a memory_failure() work is queued into workqueue for
both the asynchronous interrupt and synchronous exception. So
memory_failure() will be executed asynchronously.  For NMIlike
notifications, commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure()
queue for synchronous errors") keeps track of whether memory_failure() work
was queued, and makes task_work pending to flush out the queue.  It ensures
any queued work has been done before we return to the context that
triggered the notification.

In this patch:

	- a memory_failure() work is queued into workqueue for asynchronous interrupt
	- a memory_failure() task_work is queued by task_work_add for synchronous exception

The memory_failure() task_work will be handled before returning to user
space, so we does not need to queue a flushing task_work any anymore.

> 
> Why doesn't a synchronous exception on ARM call into ghes_proc_in_irq()?

	/*
	 * SEA can interrupt SError, mask it and describe this as an NMI so
	 * that APEI defers the handling.
	 */
	local_daif_restore(DAIF_ERRCTX);
	nmi_enter();
	 => ghes_notify_sea
		=> ghes_in_nmi_spool_from_list
			=> ghes_in_nmi_queue_one_entry	// also called in __ghes_sdei_callback
			=> irq_work_queue(&ghes_proc_irq_work);
	nmi_exit();
> 
> That SDEI thing certainly does.
> 
> Well looka here:
> 
>   7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
> 
> that thing does exactly what you're trying to "fix". So why doesn't that
> work for you?
> 

Commit a70297d22132 (ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events)
set MF_ACTION_REQUIRED for synchronous events.

	/*
	 * Send all the processes who have the page mapped a signal.
	 * ``action optional'' if they are not immediately affected by the error
	 * ``action required'' if error happened in current execution context
	 */
	static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
	{
		...
		if ((flags & MF_ACTION_REQUIRED) && (t == current))
			ret = force_sig_mceerr(BUS_MCEERR_AR,
					 (void __user *)tk->addr, addr_lsb);
		else
			ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
					      addr_lsb, t);
		...
	}

Because the memory_failure() running in a kthread context, the false branch in kill_proc()
will send SIGBUS with BUS_MCEERR_AO. But we except it as a BUS_MCEERR_AR.

Thank you for valuable comments :)

Best Regards,
Shuai

