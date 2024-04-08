Return-Path: <linux-kernel+bounces-134753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C289B666
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7E31C20936
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD1A187F;
	Mon,  8 Apr 2024 03:29:10 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985831860;
	Mon,  8 Apr 2024 03:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546950; cv=none; b=UU5+J9zirklsT3VhzkZN+13+XPkQ4htZmYzJawrJn3iLHCgaXDnZZuxrxIArAS26b0y8IMr2A3Cjd90oV30pINir7iEQNqMta/NMomJBACHA4IfcjIJA+juQW3WlCO3TyvwXTq6QyBc6/ZKm7f2WFH1P9xh62T5MyAce8oVoIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546950; c=relaxed/simple;
	bh=lxXWSdVbvt7G6rco2TqN9WSRsNT27Sr3Ycoc2phECj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q64NR9p+vpI5ixEwWwLO89rAZZHpUvWGYGk+BItSeUz2+ha+TWPJaIyU9INCpNarGH3B/ChlGM2fhsE0/Igm3fefBfb9dc+1H1s8OqeC1KYFtaKCjPSkpkjVupgwbkTVizSV55shIUeQONYmDRP5TGfx39OLg50svy3+GGy/svo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VCZL25kvdz21kcw;
	Mon,  8 Apr 2024 11:28:10 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E5CB1401E0;
	Mon,  8 Apr 2024 11:29:05 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 11:29:04 +0800
Message-ID: <d3e65876-0730-98a5-f89e-d7841797de31@huawei.com>
Date: Mon, 8 Apr 2024 11:29:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] kprobes: Fix possible warn in __arm_kprobe_ftrace()
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
References: <20240407035904.2556645-1-zhengyejian1@huawei.com>
 <20240408115038.b0c85767bf1f249eccc32fff@kernel.org>
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20240408115038.b0c85767bf1f249eccc32fff@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)

On 2024/4/8 10:50, Masami Hiramatsu (Google) wrote:
> On Sun, 7 Apr 2024 11:59:04 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> There is once warn in __arm_kprobe_ftrace() on:
>>
>>   ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
>>   if (WARN_ONCE(..., "Failed to arm kprobe-ftrace at %pS (error %d)\n", ...)
>>     return ret;
>>
>> This warning is due to 'p->addr' is not a valid ftrace_location and
>> that invalid 'p->addr' was bypassed in check_kprobe_address_safe():
> 
> Ah, this is a guard warning to detect changes on ftrace_set_filter() and/or
> preparation steps. (A kind of debug message.)
> The ftrace address check is done by check_ftrace_location() at the beginning of
> check_kprobe_address_safe(). At that point, ftrace_location(addr) == addr should
> return true if the module is loaded. But there is a small window that we check
> the ftrace_location() and get the module refcount, even if the "addr" was ftrace
> location, the module is unloaded and failed to get the module refcount and fail
> to register the kprobe.

Thanks, I'll complete the description in V2.

> 
>>     check_kprobe_address_safe() {
>>       ...
>>       // 1. p->addr is in some module, this check passed
>>       is_module_text_address((unsigned long) p->addr)
>>       ...
>>       // 2. If the moudle is removed, the *probed_mod is NULL, but then
>>       //    the return value would still be 0 !!!
>>       *probed_mod = __module_text_address((unsigned long) p->addr);
>>       ...
>>     }
>>
>> So adjust the module text check to fix it.
> 
> This seems just optimizing code (skip the 2nd module search), right?

Yes, optimze more than fix, but this can still avoid latter warn like in
__arm_kprobe_ftrace()

> Also some comments needs to be updated.

Will do in V2.

> 
>>
>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>> ---
>>   kernel/kprobes.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index 9d9095e81792..e0612cc3e2a3 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1567,10 +1567,16 @@ static int check_kprobe_address_safe(struct kprobe *p,
>>   	jump_label_lock();
>>   	preempt_disable();
>>
> 
> 	/* Ensure the address is in a text area, and find a module if exists. */
>    
>> +	*probed_mod = NULL;
>> +	if (!core_kernel_text((unsigned long) p->addr)) {
>> +		*probed_mod = __module_text_address((unsigned long) p->addr);
>> +		if (!(*probed_mod)) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
> 
> nit: this should get the module refcount soon after getting probed_mod.
> (I think this should be an atomic operation, but we don't have such interface.)

Yes, it's better to get the module refcount right here, but suppose the
module is expected to be unloaded soon, we don't really need to make the 
registration succeed.

> 
>> +	}
> 
>>   	/* Ensure it is not in reserved area nor out of text */
> 
> 	/* Ensure it is not in reserved area. */
> 
>> -	if (!(core_kernel_text((unsigned long) p->addr) ||
>> -	    is_module_text_address((unsigned long) p->addr)) ||
> 
> Note that this part is doing same thing. If the probe address is !kernel_text
> and !module_text, it will be rejected.
> 

Yes.

>> -	    in_gate_area_no_mm((unsigned long) p->addr) ||
>> +	if (in_gate_area_no_mm((unsigned long) p->addr) ||
>>   	    within_kprobe_blacklist((unsigned long) p->addr) ||
>>   	    jump_label_text_reserved(p->addr, p->addr) ||
>>   	    static_call_text_reserved(p->addr, p->addr) ||
>> @@ -1581,7 +1587,6 @@ static int check_kprobe_address_safe(struct kprobe *p,
>>   	}
>>   
>>   	/* Check if 'p' is probing a module. */
> 
> 	/* Get module refcount and reject __init functions for loaded modules. */
> 
>> -	*probed_mod = __module_text_address((unsigned long) p->addr);
>>   	if (*probed_mod) {
>>   		/*
>>   		 * We must hold a refcount of the probed module while updating
>> -- 
>> 2.25.1
>>
> 
> Thank you,
> 

--

Thank you,
Zheng Yejian


