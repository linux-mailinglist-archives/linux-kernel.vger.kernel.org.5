Return-Path: <linux-kernel+bounces-86206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA01686C199
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8ACB20B66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E1B446B4;
	Thu, 29 Feb 2024 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tbpj1ahM"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EC23A1A7;
	Thu, 29 Feb 2024 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190331; cv=none; b=mb3UKt1wWaW+CBVlJINZEIcyyatpGfTvdxaTyWsfO5M1OEpgJCH3Bihl4ySDdM5AgUHO7PioeIePaZE0yfZam5K0kkzzWl7eyEIING+/pEtasshe2GVmnzGAPjr/XAzU28tesF/T6yRvp9+i+6e9cSXpSRTT1mM2crE9RIDq2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190331; c=relaxed/simple;
	bh=2b7Khu+JD4+0HbAFHFCd3tQfjCFdfL81GN223Ng7aW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofLMLiuEYtUPfI38dkIt7Bkvf2+oR8iIAjAUlmOuKpKbm5ASdd29vHPhMY5MK3PMm/5iuW4/Vcv6XsckxsNOMg1eIlssMNV0yh/6sjRq3bnSgZEzxDIRFkE9EJBRMJDhVJvMfYn/c9L/xU7AuLdwrz7JmDsew/k162rAoK6rfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tbpj1ahM; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709190326; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=b5tHPMq+dPpSUlxzH8dLnyuGCw1urXcLYTK5crBVE7g=;
	b=tbpj1ahMpeB94Hrfbudk1Doctp+6f5kzFGY0JE2BREqFK8l7p7tAE+9GD8TtW3mhK12u/QqzfgBRFJnVl35zz0UNUjaWi6U6RbqLOlPAAEP35iYLA+iFU2inh673nyPs69aaNqGTpqGwL5y3ruA8sHjkV9TrWR/JPc4ELE1vF58=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0W1SD-3m_1709190322;
Received: from 30.240.112.180(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W1SD-3m_1709190322)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 15:05:24 +0800
Message-ID: <e8c48420-4a60-4220-9acf-bafade4a3fa0@linux.alibaba.com>
Date: Thu, 29 Feb 2024 15:05:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/3] ACPI: APEI: handle synchronous exceptions in task
 work to send correct SIGBUS si_code
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>,
 "james.morse@arm.com" <james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com, bp@alien8.de, rafael@kernel.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-4-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20240204080144.7977-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/4 16:01, Shuai Xue wrote:
> Hardware errors could be signaled by asynchronous interrupt, e.g. when an
> error is detected by a background scrubber, or signaled by synchronous
> exception, e.g. when a CPU tries to access a poisoned cache line. Since
> commit a70297d22132 ("ACPI: APEI: set memory failure flags as
> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
> could be used to determine whether a synchronous exception occurs on ARM64
> platform. When a synchronous exception is detected, the kernel should
> terminate the current process which accessing the poisoned page. This is
> done by sending a SIGBUS signal with an error code BUS_MCEERR_AR,
> indicating an action-required machine check error on read.
> 
> However, the memory failure recovery is incorrectly sending a SIGBUS
> with wrong error code BUS_MCEERR_AO for synchronous errors in early kill
> mode, even MF_ACTION_REQUIRED is set. The main problem is that
> synchronous errors are queued as a memory_failure() work, and are
> executed within a kernel thread context, not the user-space process that
> encountered the corrupted memory on ARM64 platform. As a result, when
> kill_proc() is called to terminate the process, it sends the incorrect
> SIGBUS error code because the context in which it operates is not the
> one where the error was triggered.
> 
> To this end, queue memory_failure() as a task_work so that it runs in
> the context of the process that is actually consuming the poisoned data,
> and it will send SIBBUS with si_code BUS_MCEERR_AR.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 77 +++++++++++++++++++++++-----------------
>  include/acpi/ghes.h      |  3 --
>  mm/memory-failure.c      | 13 -------
>  3 files changed, 44 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0892550732d4..e5086d795bee 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -465,28 +465,41 @@ static void ghes_clear_estatus(struct ghes *ghes,
>  }
>  
>  /*
> - * Called as task_work before returning to user-space.
> - * Ensure any queued work has been done before we return to the context that
> - * triggered the notification.
> + * struct sync_task_work - for synchronous RAS event
> + *
> + * @twork:                callback_head for task work
> + * @pfn:                  page frame number of corrupted page
> + * @flags:                fine tune action taken
> + *
> + * Structure to pass task work to be handled before
> + * ret_to_user via task_work_add().
>   */
> -static void ghes_kick_task_work(struct callback_head *head)
> +struct sync_task_work {
> +	struct callback_head twork;
> +	u64 pfn;
> +	int flags;
> +};
> +
> +static void memory_failure_cb(struct callback_head *twork)
>  {
> -	struct acpi_hest_generic_status *estatus;
> -	struct ghes_estatus_node *estatus_node;
> -	u32 node_len;
> +	int ret;
> +	struct sync_task_work *twcb =
> +		container_of(twork, struct sync_task_work, twork);
>  
> -	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
> -	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
> -		memory_failure_queue_kick(estatus_node->task_work_cpu);
> +	ret = memory_failure(twcb->pfn, twcb->flags);
> +	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
>  
> -	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
> -	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
> -	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
> +	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
> +		return;
> +
> +	pr_err("Sending SIGBUS to current task due to memory error not recovered");
> +	force_sig(SIGBUS);
>  }
>  
>  static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>  {
>  	unsigned long pfn;
> +	struct sync_task_work *twcb;
>  
>  	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>  		return false;
> @@ -499,6 +512,18 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>  		return false;
>  	}
>  
> +	if (flags == MF_ACTION_REQUIRED && current->mm) {
> +		twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
> +		if (!twcb)
> +			return false;
> +
> +		twcb->pfn = pfn;
> +		twcb->flags = flags;
> +		init_task_work(&twcb->twork, memory_failure_cb);
> +		task_work_add(current, &twcb->twork, TWA_RESUME);
> +		return true;
> +	}
> +
>  	memory_failure_queue(pfn, flags);
>  	return true;
>  }
> @@ -746,7 +771,7 @@ int cxl_cper_unregister_callback(cxl_cper_callback callback)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_callback, CXL);
>  
> -static bool ghes_do_proc(struct ghes *ghes,
> +static void ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {
>  	int sev, sec_sev;
> @@ -814,8 +839,6 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		pr_err("Sending SIGBUS to current task due to memory error not recovered");
>  		force_sig(SIGBUS);
>  	}
> -
> -	return queued;
>  }
>  
>  static void __ghes_print_estatus(const char *pfx,
> @@ -1117,9 +1140,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>  	struct ghes_estatus_node *estatus_node;
>  	struct acpi_hest_generic *generic;
>  	struct acpi_hest_generic_status *estatus;
> -	bool task_work_pending;
>  	u32 len, node_len;
> -	int ret;
>  
>  	llnode = llist_del_all(&ghes_estatus_llist);
>  	/*
> @@ -1134,25 +1155,16 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>  		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>  		len = cper_estatus_len(estatus);
>  		node_len = GHES_ESTATUS_NODE_LEN(len);
> -		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
> +
> +		ghes_do_proc(estatus_node->ghes, estatus);
> +
>  		if (!ghes_estatus_cached(estatus)) {
>  			generic = estatus_node->generic;
>  			if (ghes_print_estatus(NULL, generic, estatus))
>  				ghes_estatus_cache_add(generic, estatus);
>  		}
> -
> -		if (task_work_pending && current->mm) {
> -			estatus_node->task_work.func = ghes_kick_task_work;
> -			estatus_node->task_work_cpu = smp_processor_id();
> -			ret = task_work_add(current, &estatus_node->task_work,
> -					    TWA_RESUME);
> -			if (ret)
> -				estatus_node->task_work.func = NULL;
> -		}
> -
> -		if (!estatus_node->task_work.func)
> -			gen_pool_free(ghes_estatus_pool,
> -				      (unsigned long)estatus_node, node_len);
> +		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
> +			      node_len);
>  
>  		llnode = next;
>  	}
> @@ -1213,7 +1225,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>  
>  	estatus_node->ghes = ghes;
>  	estatus_node->generic = ghes->generic;
> -	estatus_node->task_work.func = NULL;
>  	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>  
>  	if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index be1dd4c1a917..ebd21b05fe6e 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -35,9 +35,6 @@ struct ghes_estatus_node {
>  	struct llist_node llnode;
>  	struct acpi_hest_generic *generic;
>  	struct ghes *ghes;
> -
> -	int task_work_cpu;
> -	struct callback_head task_work;
>  };
>  
>  struct ghes_estatus_cache {
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d33729c48eff..4ad663bdc1d5 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2462,19 +2462,6 @@ static void memory_failure_work_func(struct work_struct *work)
>  	}
>  }
>  
> -/*
> - * Process memory_failure work queued on the specified CPU.
> - * Used to avoid return-to-userspace racing with the memory_failure workqueue.
> - */
> -void memory_failure_queue_kick(int cpu)
> -{
> -	struct memory_failure_cpu *mf_cpu;
> -
> -	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
> -	cancel_work_sync(&mf_cpu->work);
> -	memory_failure_work_func(&mf_cpu->work);
> -}
> -
>  static int __init memory_failure_init(void)
>  {
>  	struct memory_failure_cpu *mf_cpu;


Hi, Tony, Borislav, and James:

Any comments to this patch?

Looking forward to hear from you.

Best Regards,
Shuai

