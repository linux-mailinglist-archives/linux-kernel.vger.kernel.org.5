Return-Path: <linux-kernel+bounces-136286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429F589D23D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0C7282482
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12246FE35;
	Tue,  9 Apr 2024 06:20:50 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C46524AF;
	Tue,  9 Apr 2024 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643650; cv=none; b=B7AOASd6kette3/EtqGrYsEdugPKh7bLza9/dCdbpaCPqb7clOnGxx+owv0ToL7V6fNZqJATasGwAgCS5fE5ofFwjqV2Z9HvdvmnHuR7tc8poGrLlbTn7PyFiswVP4DhGYWf7GoJ9fB7FToaQ9nLDP9lxFGFZc9nRsjiZM+u+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643650; c=relaxed/simple;
	bh=pOzVOIOfglB9B7nvykspsv2EL3wp9Zsg+kLK5u1kF2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z27DALpsth0Oidpfp50jyYr45sc1kUia+cwIZHivhmi6pnVEwAEXigSpCxVP9xyII3TmXr7zXb0zTu19EjbQDFw3DkoKkaMc7lOh4ru3kVa/rpCFv5rFHBzevGN2ZjSMU7cmpJzLGQfM6RqvrVG0AtBXRXb7FY7v0UVD4+moOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VDG3Q27MJz1R88n;
	Tue,  9 Apr 2024 14:17:54 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A64018002D;
	Tue,  9 Apr 2024 14:20:45 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 14:20:45 +0800
Message-ID: <a8cf7252-4d67-fb8c-6c3e-77f7a1c66dee@huawei.com>
Date: Tue, 9 Apr 2024 14:20:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] kprobes: Avoid possible warn in __arm_kprobe_ftrace()
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
References: <20240407035904.2556645-1-zhengyejian1@huawei.com>
 <20240408083403.3302274-1-zhengyejian1@huawei.com>
 <20240408214102.be792c5cefd5ab757ef32a14@kernel.org>
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20240408214102.be792c5cefd5ab757ef32a14@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)

On 2024/4/8 20:41, Masami Hiramatsu (Google) wrote:
> Hi Zheng,
> 
> On Mon, 8 Apr 2024 16:34:03 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> There is once warn in __arm_kprobe_ftrace() on:
>>
>>   ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
>>   if (WARN_ONCE(..., "Failed to arm kprobe-ftrace at %pS (error %d)\n", ...)
>>     return ret;
>>
>> This warning is generated because 'p->addr' is detected to be not a valid
>> ftrace location in ftrace_set_filter_ip(). The ftrace address check is done
>> by check_ftrace_location() at the beginning of check_kprobe_address_safe().
>> At that point, ftrace_location(addr) == addr should return true if the
>> module is loaded. Then the module is searched twice:
>>    1. in is_module_text_address(), we find that 'p->addr' is in a module;
>>    2. in __module_text_address(), we find the module;
>>
>> If the module has just been unloaded before the second search, then
>> '*probed_mod' is NULL and we would not go to get the module refcount,
>> then the return value of check_kprobe_address_safe() would be 0, but
>> actually we need to return -EINVAL.
> 
> OK, so you found a race window in check_kprobe_address_safe().
> 
> It does something like below.
> 
> check_kprobe_address_safe() {
> 	...
> 
> 	/* Timing [A] */
> 
> 	if (!(core_kernel_text(p->addr) ||
> 		is_module_text_address(p->addr)) ||
> 		...(other reserved address check)) {
> 		return -EINVAL;
> 	}
> 
> 	/* Timing [B] */
> 
> 	*probed_mod = __module_text_address(p->addr):
> 	if (*probe_mod) {
> 		if (!try_module_get(*probed_mod)) {
> 			return -ENOENT;
> 		}
> 		...	
> 	}
> }
> 
> So, if p->addr is in a module which is alive at the timing [A], but
> unloaded at timing [B], 'p->addr' is passed the
> 'is_module_text_address(p->addr)' check, but *probed_mod becomes NULL.
> Thus the corresponding module is not referenced and kprobe_arm(p) will
> access a wrong address (use after free).
> This happens either kprobe on ftrace is enabled or not.

Yes, This is the problem. And for this case, check_kprobe_address_safe() 
still return 0, and then going on to arm kprobe may cause problems. So
we should make check_kprobe_address_safe() return -EINVAL when refcount
of the module is not got.

> 
> To fix this problem, we should move the mutex_lock(kprobe_mutex) before
> check_kprobe_address_safe() because kprobe_module_callback() also lock it
> so it can stop module unloading.
> 
> Can you ensure this will fix your problem?

It seems not, the warning in __arm_kprobe_ftrace() still occurs. I
contrived following simple test:

     #!/bin/bash
     sysctl -w kernel.panic_on_warn=1
     while [ True ]; do
         insmod mod.ko    # contain function 'foo'
         rmmod mod.ko
     done &
     while [ True ]; do
         insmod kprobe.ko  # register kprobe on function 'foo'
         rmmod kprobe.ko
     done &

I think holding kprobe_mutex cannot make sure we get the refcount of the
module.

> I think your patch is just optimizing but not fixing the fundamental
> problem, which is we don't have an atomic search symbol and get module

Sorry, this patch is a little confusing, but it is not just optimizing :)

As shown below, after my patch, if p->addr is in a module which is alive
at the timing [A'] but unloaded at timing [B'], then *probed_mod must
not be NULL. Then after timing [B'], it will go to try_module_get() and
expected to fail and return -ENOENT. So this is the different.

     check_kprobe_address_safe() {
         ...
         *probed_mod = NULL;
         if (!core_kernel_text((unsigned long) p->addr)) {

             /* Timing [A'] */

             *probed_mod = __module_text_address((unsigned long) p->addr);
             if (!(*probed_mod)) {
                 return -EINVAL;
             }
         }
         ...

         /* Timing [B'] */

         if (*probed_mod) {
             if (!try_module_get(*probed_mod)) {
                 return -ENOENT;
             }
             ...
         }

> API. In that case, we should stop a whole module unloading system until
> registering a new kprobe on a module. (After registering the kprobe,
> the callback can mark it gone and disarm_kprobe does not work anymore.)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9d9095e81792..94eaefd1bc51 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1633,11 +1633,11 @@ int register_kprobe(struct kprobe *p)
>   	p->nmissed = 0;
>   	INIT_LIST_HEAD(&p->list);
>   
> +	mutex_lock(&kprobe_mutex);
> +
>   	ret = check_kprobe_address_safe(p, &probed_mod);
>   	if (ret)
> -		return ret;
> -
> -	mutex_lock(&kprobe_mutex);
> +		goto out;
>   
>   	if (on_func_entry)
>   		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
> 
> ----
> 
> Thank you,
> 
>>
>> To fix it, originally we can simply check 'p->addr' is out of text again,
>> like below. But that would check twice respectively in kernel text and
>> module text, so finally I reduce them to be once.
>>
>>    if (!(core_kernel_text((unsigned long) p->addr) ||
>>        is_module_text_address((unsigned long) p->addr)) || ...) {
>> 	ret = -EINVAL;
>> 	goto out;
>>    }
>>    ...
>>    *probed_mod = __module_text_address((unsigned long) p->addr);
>>    if (*probed_mod) {
>> 	...
>>    } else if (!core_kernel_text((unsigned long) p->addr)) { // check again!
>> 	ret = -EINVAL;
>> 	goto out;
>>    }
>>
>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>> ---
>>   kernel/kprobes.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> v2:
>>   - Update commit messages and comments as suggested by Masami.
>>     Link: https://lore.kernel.org/all/20240408115038.b0c85767bf1f249eccc32fff@kernel.org/
>>
>> v1:
>>   - Link: https://lore.kernel.org/all/20240407035904.2556645-1-zhengyejian1@huawei.com/
>>
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index 9d9095e81792..65adc815fc6e 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1567,10 +1567,17 @@ static int check_kprobe_address_safe(struct kprobe *p,
>>   	jump_label_lock();
>>   	preempt_disable();
>>   
>> -	/* Ensure it is not in reserved area nor out of text */
>> -	if (!(core_kernel_text((unsigned long) p->addr) ||
>> -	    is_module_text_address((unsigned long) p->addr)) ||
>> -	    in_gate_area_no_mm((unsigned long) p->addr) ||
>> +	/* Ensure the address is in a text area, and find a module if exists. */
>> +	*probed_mod = NULL;
>> +	if (!core_kernel_text((unsigned long) p->addr)) {
>> +		*probed_mod = __module_text_address((unsigned long) p->addr);
>> +		if (!(*probed_mod)) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +	}
>> +	/* Ensure it is not in reserved area. */
>> +	if (in_gate_area_no_mm((unsigned long) p->addr) ||
>>   	    within_kprobe_blacklist((unsigned long) p->addr) ||
>>   	    jump_label_text_reserved(p->addr, p->addr) ||
>>   	    static_call_text_reserved(p->addr, p->addr) ||
>> @@ -1580,8 +1587,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>>   		goto out;
>>   	}
>>   
>> -	/* Check if 'p' is probing a module. */
>> -	*probed_mod = __module_text_address((unsigned long) p->addr);
>> +	/* Get module refcount and reject __init functions for loaded modules. */
>>   	if (*probed_mod) {
>>   		/*
>>   		 * We must hold a refcount of the probed module while updating
>> -- 
>> 2.25.1
>>
>
--
Thanks
Zheng Yejian
> 


