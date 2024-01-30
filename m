Return-Path: <linux-kernel+bounces-44253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053BB841F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F041F2257B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F426086B;
	Tue, 30 Jan 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="usqM2Erd"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E538DEC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606754; cv=none; b=mU3Kwug3QtL3iL0eRDzNLwMY1oHmW1qL8PyrrU0Q+6SPQLvORjXRe6NO+gR43kiFOhsO/afrSoapyYFcJ7KryVXIxmdVXeKhHHdRX2z0X+lgdXcAkXf3ypxu2MgmyHOXM3sUAVavCVjuv0Hc2LBw6kGALlY8unPXsTL0X5iG1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606754; c=relaxed/simple;
	bh=SDrIhhk0216kuinfVjYExBnLEatSwxttoaR1lucHHbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAux4r9Qs9E7hgpgFnoEEMhaQZebyhUmq+HMZSduEr5cZSxH4RephmHi6RUPSqUtpLlZ/fH3T3HOVBn4xpO9fkR0TtgqWuh5GCmdsT/XiESf6931MvlrZTgMy+EdmOCsYVDW2P1KJ91bLbU8N6Zt0fvfQK4azffzlTw7OLV3CTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=usqM2Erd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d5f27642-e3e2-c5c9-f9d8-a688512ce945@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706606749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSk7it6b1JMh823m6ptl66Jh5MU45iWziHAMy2DNJmA=;
	b=usqM2Erdea00X8HzNmACoAbCZnm5HDokXtXhSQv93VoOKGqRQmjhulO7Qm5tXIJioBb77K
	X/au/eifMwJTdv6qjZiGAQ/vGDjqQZnXf4koQw7QhnQx9yEuRve1G1dMB4z5SOo1P9M4ox
	02JkUv6XSszcfGxXCzoq/Dmmi6Y6A0U=
Date: Tue, 30 Jan 2024 17:25:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mmap: use SZ_{8M, 128M} helper macro
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240126085905.2835513-1-yajun.deng@linux.dev>
 <Zbi9OyG9kcldGyJ1@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <Zbi9OyG9kcldGyJ1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/1/30 17:11, Mike Rapoport wrote:
> On Fri, Jan 26, 2024 at 04:59:05PM +0800, Yajun Deng wrote:
>> Use SZ_{8M, 128M} macro intead of the number in init_user_reserve and
>> reserve_mem_notifier.
>>
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>>   mm/mmap.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 476de5daf598..f90924b2a6d2 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -3845,7 +3845,7 @@ static int init_user_reserve(void)
>>   
>>   	free_kbytes = K(global_zone_page_state(NR_FREE_PAGES));
>>   
>> -	sysctl_user_reserve_kbytes = min(free_kbytes / 32, 1UL << 17);
>> +	sysctl_user_reserve_kbytes = min(free_kbytes / 32, SZ_128M);
> (1UL << 17) != SZ_128M
I am sorry for this, I didn't realize that the unit was kbyte.
>
>>   	return 0;
>>   }
>>   subsys_initcall(init_user_reserve);
>> @@ -3866,7 +3866,7 @@ static int init_admin_reserve(void)
>>   
>>   	free_kbytes = K(global_zone_page_state(NR_FREE_PAGES));
>>   
>> -	sysctl_admin_reserve_kbytes = min(free_kbytes / 32, 1UL << 13);
>> +	sysctl_admin_reserve_kbytes = min(free_kbytes / 32, SZ_8M);
>>   	return 0;
>>   }
>>   subsys_initcall(init_admin_reserve);
>> @@ -3898,12 +3898,12 @@ static int reserve_mem_notifier(struct notifier_block *nb,
>>   	case MEM_ONLINE:
>>   		/* Default max is 128MB. Leave alone if modified by operator. */
>>   		tmp = sysctl_user_reserve_kbytes;
>> -		if (0 < tmp && tmp < (1UL << 17))
>> +		if (tmp > 0 && tmp < SZ_128M)
>>   			init_user_reserve();
>>   
>>   		/* Default max is 8MB.  Leave alone if modified by operator. */
>>   		tmp = sysctl_admin_reserve_kbytes;
>> -		if (0 < tmp && tmp < (1UL << 13))
>> +		if (tmp > 0 && tmp < SZ_8M)
> (1UL << 13) != SZ_8M
>
>>   			init_admin_reserve();
>>   
>>   		break;
>> -- 
>> 2.25.1
>>
>>

