Return-Path: <linux-kernel+bounces-161871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FB8B5283
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469C4B21100
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA94D14A9F;
	Mon, 29 Apr 2024 07:45:55 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E112E7C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376755; cv=none; b=JN82MLADRoAj24ST/M+GX24BPomq8aUhhIkDDTpykdG3ug/O3LXAlAzsF25j3HilG+AMIWmh1VNRdraq19plXAaFgq5OLJnmEr2HaIjklv9xqSXIpj0pjfbyWSwAb9u+dxPiNIRxOfOfvsvLGsJbTxNoQeSaYZUi1HPBa5//Y1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376755; c=relaxed/simple;
	bh=f0rWuCd3N1DHxBQyLLk4t0jedNeLgIopaOYz6BLW66w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oVUMgKnCeUTccJRmdKohMKWmG53IPoDKH15XrB46DOA1H+6b4CbzG2W7nOE1jhpb275srFM/FkMPrh0LlHfIuQcR1Ed7D2FQeyuyg98p6e/+3yo+Ri3btpph5jTmVKOClKuL73OCMzONLLEG3Q0tUGutVt8sJIeYKDJFDVZ3xvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VSZzy1DMwz1RBGN;
	Mon, 29 Apr 2024 15:42:38 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 10AEF180065;
	Mon, 29 Apr 2024 15:45:46 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 15:45:44 +0800
Message-ID: <e936b9cd-39ce-1ae1-b348-3000f7e47a45@huawei.com>
Date: Mon, 29 Apr 2024 15:45:44 +0800
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
To: Dennis Zhou <dennisszhou@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <shakeelb@google.com>, <jack@suse.cz>,
	<surenb@google.com>, <kent.overstreet@linux.dev>, <mhocko@suse.cz>,
	<vbabka@suse.cz>, <yuzhao@google.com>, <yu.ma@intel.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-2-zhangpeng362@huawei.com>
 <ZithwiPpjke2qbrv@snowbird>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZithwiPpjke2qbrv@snowbird>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/4/26 16:11, Dennis Zhou wrote:

> On Thu, Apr 18, 2024 at 10:20:07PM +0800, Peng Zhang wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> Depending on whether counters is NULL, we can support two modes:
>> atomic mode and perpcu mode. We implement both modes by grouping
>> the s64 count and atomic64_t count_atomic in a union. At the same time,
>> we create the interface for adding and reading in atomic mode and for
>> switching atomic mode to percpu mode.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/percpu_counter.h | 43 +++++++++++++++++++++++++++++++---
>>   lib/percpu_counter.c           | 31 ++++++++++++++++++++++--
>>   2 files changed, 69 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
>> index 3a44dd1e33d2..160f9734c0bb 100644
>> --- a/include/linux/percpu_counter.h
>> +++ b/include/linux/percpu_counter.h
>> @@ -21,7 +21,13 @@
>>   
>>   struct percpu_counter {
>>   	raw_spinlock_t lock;
>> -	s64 count;
>> +	/* Depending on whether counters is NULL, we can support two modes,
>> +	 * atomic mode using count_atomic and perpcu mode using count.
>> +	 */
>> +	union {
>> +		s64 count;
>> +		atomic64_t count_atomic;
>> +	};
>>   #ifdef CONFIG_HOTPLUG_CPU
>>   	struct list_head list;	/* All percpu_counters are on a list */
>>   #endif
>> @@ -32,14 +38,14 @@ extern int percpu_counter_batch;
>>   
>>   int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
>>   			       gfp_t gfp, u32 nr_counters,
>> -			       struct lock_class_key *key);
>> +			       struct lock_class_key *key, bool switch_mode);
> Nit: the lock_class_key at the end.

Got it.

>>   
>>   #define percpu_counter_init_many(fbc, value, gfp, nr_counters)		\
>>   	({								\
>>   		static struct lock_class_key __key;			\
>>   									\
>>   		__percpu_counter_init_many(fbc, value, gfp, nr_counters,\
>> -					   &__key);			\
>> +					   &__key, false);		\
>>   	})
>>   
>>   
>> @@ -130,6 +136,20 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
>>   	return (fbc->counters != NULL);
>>   }
>>   
>> +static inline s64 percpu_counter_atomic_read(struct percpu_counter *fbc)
>> +{
>> +	return atomic64_read(&fbc->count_atomic);
>> +}
>> +
>> +static inline void percpu_counter_atomic_add(struct percpu_counter *fbc,
>> +					     s64 amount)
>> +{
>> +	atomic64_add(amount, &fbc->count_atomic);
>> +}
>> +
>> +int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
>> +				       u32 nr_counters);
>> +
>>   #else /* !CONFIG_SMP */
>>   
>>   struct percpu_counter {
>> @@ -260,6 +280,23 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
>>   static inline void percpu_counter_sync(struct percpu_counter *fbc)
>>   {
>>   }
>> +
>> +static inline s64 percpu_counter_atomic_read(struct percpu_counter *fbc)
>> +{
>> +	return fbc->count;
>> +}
>> +
>> +static inline void percpu_counter_atomic_add(struct percpu_counter *fbc,
>> +					     s64 amount)
>> +{
>> +	percpu_counter_add(fbc, amount);
>> +}
>> +
>> +static inline int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
>> +						     u32 nr_counters)
>> +{
>> +	return 0;
>> +}
>>   #endif	/* CONFIG_SMP */
>>   
>>   static inline void percpu_counter_inc(struct percpu_counter *fbc)
>> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
>> index 44dd133594d4..95c4e038051a 100644
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
>> + */
>> +int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
>> +				       u32 nr_counters)
>> +{
>> +	static struct lock_class_key __key;
> This is an improper use of lockdep. Now all of the percpu_counters
> initialized on this path will key off of this lock_class_key.

Sorry, I don't know much about lock_class_key. I may not understand the reason
why it's not appropriate here. Could you please help me with the details?

>> +	unsigned long flags;
>> +	bool ret = 0;
>> +
>> +	if (percpu_counter_initialized(fbc))
>> +		return 0;
>> +
>> +	preempt_disable();
>> +	local_irq_save(flags);
>> +	if (likely(!percpu_counter_initialized(fbc)))
>> +		ret = __percpu_counter_init_many(fbc, 0,
>> +					GFP_ATOMIC|__GFP_NOWARN|__GFP_ZERO,
>> +					nr_counters, &__key, true);
>> +	local_irq_restore(flags);
>> +	preempt_enable();
>> +
>> +	return ret;
>> +}
> I'm staring at this API and I'm not in love with it. I think it hinges
> on that there's one user of mm_stats prior hence it's safe. Generically
> though, I can't see why this is safe.
>
> I need to give this a little more thought, but my gut reaction is I'd
> rather this look like percpu_refcount where we can init dead minus the
> percpu allocation. Maybe that's not quite right, but I'd feel better
> about it than requiring external synchronization on a percpu_counter to
> ensure that it's correct.

Maybe it would be better if I change this API to the internal function of
mm counter.

Sorry again, maybe percpu_refcount is better, but I don't understand this
sentence "we can init dead minus the percpu allocation." Please forgive my
ignorance...

Thank you very much for your review and valuable comments!

>> +
>>   static int __init percpu_counter_startup(void)
>>   {
>>   	int ret;
>> -- 
>> 2.25.1
>>
> Thanks,
> Dennis

-- 
Best Regards,
Peng


