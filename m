Return-Path: <linux-kernel+bounces-108308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E68808F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D6D284C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D448C04;
	Wed, 20 Mar 2024 01:18:30 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB54523D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897510; cv=none; b=ZkaTPNLlb0ksYBEtx/ig2NR2OkQ8IClw0JNPTky8lnNMfsyWl6N+oxci4rnPRf4lm7diaZzo7/5iERbLu/Ttp1OFKaLi4ut6BVMESiqL9kUA8tQ9QcQY3ij1pPGRoy7stZSmeyUb8rOwpYQoGAw8tVLqDUVKJZk1ZNDK88byh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897510; c=relaxed/simple;
	bh=db7j+9ibIbPWtuaCLZjiRfpB7eLBbR84d04juTR3uEo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KKEe0EECfWMplR05Sh5uLxOYBCmuaMpFAHgtiJ9xUsULlt5jDWYEyTX7sXURVLQcLAGuLH3AHqfOBha03oeSpJ3uaf4utmx4CnY2vP2HGl3InrAXXF14A0sMVRmcrHUl48S65pOLgvZwXQ2aUosSnaH6ohkzgtigZPa4XwaDNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TzrLv0nktz4f3jrp
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:18:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 19D4B1A01A7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:18:21 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ5bOfplnw71HQ--.12656S3;
	Wed, 20 Mar 2024 09:18:20 +0800 (CST)
Subject: Re: [PATCH 1/1] mm/mm_init.c: eliminate a local variable in
 mem_debugging_and_hardening_init()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
References: <20240318135715.312-1-thunder.leizhen@huaweicloud.com>
 <Zfhs5LD-1RQt3aw4@kernel.org>
 <5fd9144b-fb1c-08fc-8124-1972f86253a4@huaweicloud.com>
 <Zfmo0jPNsU6TdsNt@kernel.org>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <5d180035-1337-fcb5-601c-75b773c20a28@huaweicloud.com>
Date: Wed, 20 Mar 2024 09:18:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zfmo0jPNsU6TdsNt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHZQ5bOfplnw71HQ--.12656S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4xWF15Ar18WF15Xw1kKrg_yoW5WFyrpF
	WrJ3WjyFZ5ArZak3y2qryqgr9rt3yrKF47XryUXa45Xw1qkFZ3GF1kKr15uFykZFs3Xa1S
	qa93KF9xuF15ta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/3/19 23:01, Mike Rapoport wrote:
> On Tue, Mar 19, 2024 at 09:22:03AM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2024/3/19 0:33, Mike Rapoport wrote:
>>> On Mon, Mar 18, 2024 at 09:57:14PM +0800, thunder.leizhen@huaweicloud.com wrote:
>>>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>>>
>>>> The local variable 'page_poisoning_requested' is assigned true at only
>>>> one point. It can be eliminated by moving the code that depends on it
>>>> to the location where it is assigned true. This also make the moved
>>>> code to be compiled only if CONFIG_PAGE_POISONING is set.
>>>
>>> I don't see it as much of an improvement and code readability becomes worse
>>> IMO.
>>
>> Yes, the moved branch will be optimized by the compiler if CONFIG_PAGE_POISONING is
>> not set. But for a reader, he can simply skip over that moved branch when
>> CONFIG_PAGE_POISONING is not set.
> 
> Saving one branch at init does not justify the churn and reduced
> readability. 

OK, I got it.

>   
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  mm/mm_init.c | 17 +++++++----------
>>>>  1 file changed, 7 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>> index 549e76af8f82a8e..3eb217130bcb2b5 100644
>>>> --- a/mm/mm_init.c
>>>> +++ b/mm/mm_init.c
>>>> @@ -2614,7 +2614,6 @@ DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
>>>>   */
>>>>  static void __init mem_debugging_and_hardening_init(void)
>>>>  {
>>>> -	bool page_poisoning_requested = false;
>>>>  	bool want_check_pages = false;
>>>>  
>>>>  #ifdef CONFIG_PAGE_POISONING
>>>> @@ -2626,18 +2625,16 @@ static void __init mem_debugging_and_hardening_init(void)
>>>>  	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
>>>>  	      debug_pagealloc_enabled())) {
>>>>  		static_branch_enable(&_page_poisoning_enabled);
>>>> -		page_poisoning_requested = true;
>>>>  		want_check_pages = true;
>>>> -	}
>>>> -#endif
>>>>  
>>>> -	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
>>>> -	    page_poisoning_requested) {
>>>> -		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
>>>> -			"will take precedence over init_on_alloc and init_on_free\n");
>>>> -		_init_on_alloc_enabled_early = false;
>>>> -		_init_on_free_enabled_early = false;
>>>> +		if (_init_on_alloc_enabled_early || _init_on_free_enabled_early) {
>>>> +			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
>>>> +				"will take precedence over init_on_alloc and init_on_free\n");
>>>> +			_init_on_alloc_enabled_early = false;
>>>> +			_init_on_free_enabled_early = false;
>>>> +		}
>>>>  	}
>>>> +#endif
>>>>  
>>>>  	if (_init_on_alloc_enabled_early) {
>>>>  		want_check_pages = true;
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
>> -- 
>> Regards,
>>   Zhen Lei
>>
> 

-- 
Regards,
  Zhen Lei


