Return-Path: <linux-kernel+bounces-58998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 968BE84EFA8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543D91F25531
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79725677;
	Fri,  9 Feb 2024 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sv0HuYUF"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF65681
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707454257; cv=none; b=LYhv6IHplqYjZkbLw+EcSTrhw+Js8OuwL+FfSk36mcuzL/VLbuRGFyuzi90nWIz3pdOHwSVj0UwL471CdBs49hc6fLzJsZPgJl76Ur4aOB42wh47X040vZVkk4S9MvvOcA1eH3uZ2ldh9iwX2r0XYMVxCzwb908bH6voj6XtxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707454257; c=relaxed/simple;
	bh=xJwqN5X/u7wlJhFpyTJ76mMKj5EfOA+Z4i23eYGUNRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwWf5PQfU5FBPHYvIqWXl0V67pFu/shtZNKZQct5om3x11Id6OAmzKJgv5va/VvmPMxXQoh0hncNOovHwM/V0+7P0LR/LHOD0wjTYVM23bTtXin7xN6oP+POCEJXAV4q3FM/w9UiQtspj0cCye6jvsXw5oIBbfNZ2OIkPwfEXKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sv0HuYUF; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <61212b2b-7f40-42f0-9a44-1ab34a2a1cde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707454252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCsEgKAQ47A9auRHPKJ2GAU0swz6qNM7w47Z4P7dE2A=;
	b=Sv0HuYUF+rLrL2ry4C0stU1sqBDp6wsd3N5sQY4pOF1ColatziubJNT60FK9S9fiLWhnAd
	j1QwAzwIkcB5aPbSzow5c8ye7/mvVICXgoGAzY+Pv42L7w+iAtKX9swA7WdzdjRQMlDU86
	suACeiucy03M07Y4GzIEU6WNiThs0Ds=
Date: Fri, 9 Feb 2024 12:50:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-hotfixes-unstable] mm/zswap: invalidate duplicate entry
 when !zswap_enabled
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>, stable@vger.kernel.org
References: <20240207154308.bc275f3e72ec1c1fd06cf5a2@linux-foundation.org>
 <20240208023254.3873823-1-chengming.zhou@linux.dev>
 <20240208130952.b2696eaf6a27eef9866723d4@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240208130952.b2696eaf6a27eef9866723d4@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/9 05:09, Andrew Morton wrote:
> On Thu,  8 Feb 2024 02:32:54 +0000 chengming.zhou@linux.dev wrote:
> 
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> We have to invalidate any duplicate entry even when !zswap_enabled
>> since zswap can be disabled anytime. If the folio store success before,
>> then got dirtied again but zswap disabled, we won't invalidate the old
>> duplicate entry in the zswap_store(). So later lru writeback may
>> overwrite the new data in swapfile.
>>
>> ...
>>
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1516,7 +1516,7 @@ bool zswap_store(struct folio *folio)
>>  	if (folio_test_large(folio))
>>  		return false;
>>  
>> -	if (!zswap_enabled || !tree)
>> +	if (!tree)
>>  		return false;
>>  
>>  	/*
>> @@ -1531,6 +1531,10 @@ bool zswap_store(struct folio *folio)
>>  		zswap_invalidate_entry(tree, dupentry);
>>  	}
>>  	spin_unlock(&tree->lock);
>> +
>> +	if (!zswap_enabled)
>> +		return false;
>> +
>>  	objcg = get_obj_cgroup_from_folio(folio);
>>  	if (objcg && !obj_cgroup_may_zswap(objcg)) {
>>  		memcg = get_mem_cgroup_from_objcg(objcg);
> 
> OK, thanks.
> 
> I saw only one reject from mm-unstable patches.  Your patch "mm/zswap:
> make sure each swapfile always have zswap rb-tree" now does

It's correct. Thanks!

The other patch that includes optimization and cleanup is updated based on
mm-unstable and just resend:

https://lore.kernel.org/all/20240209044112.3883835-1-chengming.zhou@linux.dev/

> 
> --- a/mm/zswap.c~mm-zswap-make-sure-each-swapfile-always-have-zswap-rb-tree
> +++ a/mm/zswap.c
> @@ -1518,9 +1518,6 @@ bool zswap_store(struct folio *folio)
>  	if (folio_test_large(folio))
>  		return false;
>  
> -	if (!tree)
> -		return false;
> -
>  	/*
>  	 * If this is a duplicate, it must be removed before attempting to store
>  	 * it, otherwise, if the store fails the old page won't be removed from
> 
> 

