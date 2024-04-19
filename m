Return-Path: <linux-kernel+bounces-150950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F88AA713
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C9B1C20B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7218379CC;
	Fri, 19 Apr 2024 03:14:06 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C10110E3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713496446; cv=none; b=rqm1f/jDEx0p4rRGao36CcQHKX98IYXjzfwEaZJEqVmruYxllmuodPOucvNtnIP3alhtIppzeMqIRyiFGATDY1TVTLDSuNuJSyqC0QTsXwVS7jQIuuwv0BE2uwp9k5kDTGWmZ5bffvmHMhFaXF0U0Nw/BRzIqS4sW8WwjmGIdJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713496446; c=relaxed/simple;
	bh=/ICbOqzA7EBKTDtBwiunIRPslZsL+XWngVGJAlgDGpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mXKC5wF0Y4J0sh+vSuI4uttYvB8s9/vQzaW5yDpWgtDH9088gpRfLPv9LuVCJvDQyhfY+dkvFWulGtw+Y/vqSagNA2mawABybKNuARZ7FnFIsX8fdZ7mHpu6eqeBceka+3YjAWUgU/PFT1VkbO/F9RcVEFytb6CXeRWrFPMRfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VLK2R5wQDz1N7rs;
	Fri, 19 Apr 2024 10:53:03 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 61C631400D5;
	Fri, 19 Apr 2024 10:55:58 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 10:55:57 +0800
Message-ID: <bdf18710-2fad-2aec-51da-cb902f20c87b@huawei.com>
Date: Fri, 19 Apr 2024 10:55:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v2 1/2] percpu_counter: introduce atomic mode for
 percpu_counter
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<dennisszhou@gmail.com>, <shakeelb@google.com>, <jack@suse.cz>,
	<surenb@google.com>, <kent.overstreet@linux.dev>, <mhocko@suse.cz>,
	<vbabka@suse.cz>, <yuzhao@google.com>, <yu.ma@intel.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-2-zhangpeng362@huawei.com>
 <20240418124000.ce4606dad982d7f31fc0d117@linux-foundation.org>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20240418124000.ce4606dad982d7f31fc0d117@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/4/19 3:40, Andrew Morton wrote:

> On Thu, 18 Apr 2024 22:20:07 +0800 Peng Zhang <zhangpeng362@huawei.com> wrote:
>
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> Depending on whether counters is NULL, we can support two modes:
>> atomic mode and perpcu mode. We implement both modes by grouping
>> the s64 count and atomic64_t count_atomic in a union. At the same time,
>> we create the interface for adding and reading in atomic mode and for
>> switching atomic mode to percpu mode.
>>
> I think it would be better if we had a detailed code comment in an
> appropriate place which fully describes the tradeoffs here.  Tell
> people when they would benefit from using one mode versus the other.
>
Thanks for your reply!

Yes, of course, I would add before the union:

	/*
	 * Depending on whether counters is NULL, we can support two modes,
	 * atomic mode using count_atomic and perpcu mode using count.
	 * The single-thread processes should use atomic mode to reduce the
	 * memory consumption and performance regression.
	 * The multiple-thread processes should use percpu mode to reduce the
	 * error margin.
	 */
	union {
		s64 count;
		atomic64_t count_atomic;
	};

>> --- a/lib/percpu_counter.c
>> +++ b/lib/percpu_counter.c
>> @@ -153,7 +153,7 @@ EXPORT_SYMBOL(__percpu_counter_sum);
>>   
>>   int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
>>   			       gfp_t gfp, u32 nr_counters,
>> -			       struct lock_class_key *key)
>> +			       struct lock_class_key *key, bool switch_mode)
>>   {
>>   	unsigned long flags __maybe_unused;
>>   	size_t counter_size;
>> @@ -174,7 +174,8 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
>>   #ifdef CONFIG_HOTPLUG_CPU
>>   		INIT_LIST_HEAD(&fbc[i].list);
>>   #endif
>> -		fbc[i].count = amount;
>> +		if (likely(!switch_mode))
>> +			fbc[i].count = amount;
>>   		fbc[i].counters = (void *)counters + (i * counter_size);
>>   
>>   		debug_percpu_counter_activate(&fbc[i]);
>> @@ -357,6 +358,32 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
>>   	return good;
>>   }
>>   
>> +/*
>> + * percpu_counter_switch_to_pcpu_many: Converts struct percpu_counters from
>> + * atomic mode to percpu mode.
> Describe what happens if that GFP_ATOMIC allocation fails.  We remain
> in atomic mode, yes?

Yes. I'll add comments like:
  * Return: 0 if percpu_counter is already in atomic mode or successfully
  * switched to atomic mode; -ENOMEM if perpcu memory allocation fails,
  * perpcu_counter is still in atomic mode.

>> + */
>> +int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
>> +				       u32 nr_counters)
>> +{
>> +	static struct lock_class_key __key;
>> +	unsigned long flags;
>> +	bool ret = 0;
>> +
>> +	if (percpu_counter_initialized(fbc))
>> +		return 0;
>> +
>> +	preempt_disable();
>> +	local_irq_save(flags);
> Do we need both?  Does local_irq_save() always disable preemption?
> This might not be the case for RT kernels, I always forget.

Yes, we need both. For RT kernels, local_irq_save() doesn't mean
that preemption is disabled.

>> +	if (likely(!percpu_counter_initialized(fbc)))
>> +		ret = __percpu_counter_init_many(fbc, 0,
>> +					GFP_ATOMIC|__GFP_NOWARN|__GFP_ZERO,
>> +					nr_counters, &__key, true);
>> +	local_irq_restore(flags);
>> +	preempt_enable();
>> +
>> +	return ret;
>> +}
>> +
> Why is there no API for switching back to atomic mode?

At least for the current test scenario, we don't need to switch back
to atomic mode. The scenario for switching back to atomic mode may be
that the multi-threaded process destroys the last second thread. I could
add this API if needed later.

-- 
Best Regards,
Peng


