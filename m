Return-Path: <linux-kernel+bounces-107074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5FB87F73A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8ABE1F22634
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1195C03D;
	Tue, 19 Mar 2024 06:23:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1867B4597B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829403; cv=none; b=j/hMtExaQ/g5UCVh1qo/fugBK0FH+UinasBzKJdwBeO1jz+CxEPWYCqZVn8Ri7bijw6+kuPY8fGuzx4dVwmM0Gh6CrrKSeUhiBzshu+dkclXfcUhpVP5Xq5XusM322BpetDdL35XVa3UVu9es4R8ncVOoygjDwGlIOpwCWTkWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829403; c=relaxed/simple;
	bh=nbLlhlzYM8VOA2idP7XWrKo81oPMLxNz8Xu1ogVme+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NI+6aqLL7O/EGSDZIo7zsP7+OJZpOjbjLWfmjE3jZ2Bu30LmBrSO1JG9xt/HZucMA1IFkMUvEcKX3vdMAsRb4ouxM/vmeDXRqGsNRYNBoV2g1zx8SFayX/k/kJXk4XoNFVLx9fkHHNw0hjrY0THm5wG06CdXv57EWkC+WlUANdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81388106F;
	Mon, 18 Mar 2024 23:23:54 -0700 (PDT)
Received: from [10.163.53.175] (unknown [10.163.53.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23CD83F762;
	Mon, 18 Mar 2024 23:23:17 -0700 (PDT)
Message-ID: <016273da-8f11-4cfa-a5c0-6e5dd60956be@arm.com>
Date: Tue, 19 Mar 2024 11:53:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/mm_init.c: eliminate a local variable in
 mem_debugging_and_hardening_init()
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>, thunder.leizhen@huaweicloud.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240318135715.312-1-thunder.leizhen@huaweicloud.com>
 <Zfhs5LD-1RQt3aw4@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zfhs5LD-1RQt3aw4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/24 22:03, Mike Rapoport wrote:
> On Mon, Mar 18, 2024 at 09:57:14PM +0800, thunder.leizhen@huaweicloud.com wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> The local variable 'page_poisoning_requested' is assigned true at only
>> one point. It can be eliminated by moving the code that depends on it
>> to the location where it is assigned true. This also make the moved
>> code to be compiled only if CONFIG_PAGE_POISONING is set.
> 
> I don't see it as much of an improvement and code readability becomes worse
> IMO.

+1 agreed.

>  
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  mm/mm_init.c | 17 +++++++----------
>>  1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 549e76af8f82a8e..3eb217130bcb2b5 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -2614,7 +2614,6 @@ DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
>>   */
>>  static void __init mem_debugging_and_hardening_init(void)
>>  {
>> -	bool page_poisoning_requested = false;
>>  	bool want_check_pages = false;
>>  
>>  #ifdef CONFIG_PAGE_POISONING
>> @@ -2626,18 +2625,16 @@ static void __init mem_debugging_and_hardening_init(void)
>>  	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
>>  	      debug_pagealloc_enabled())) {
>>  		static_branch_enable(&_page_poisoning_enabled);
>> -		page_poisoning_requested = true;
>>  		want_check_pages = true;
>> -	}
>> -#endif
>>  
>> -	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
>> -	    page_poisoning_requested) {
>> -		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
>> -			"will take precedence over init_on_alloc and init_on_free\n");
>> -		_init_on_alloc_enabled_early = false;
>> -		_init_on_free_enabled_early = false;
>> +		if (_init_on_alloc_enabled_early || _init_on_free_enabled_early) {
>> +			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
>> +				"will take precedence over init_on_alloc and init_on_free\n");
>> +			_init_on_alloc_enabled_early = false;
>> +			_init_on_free_enabled_early = false;
>> +		}
>>  	}
>> +#endif
>>  
>>  	if (_init_on_alloc_enabled_early) {
>>  		want_check_pages = true;
>> -- 
>> 2.34.1
>>
> 

