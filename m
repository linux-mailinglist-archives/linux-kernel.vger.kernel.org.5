Return-Path: <linux-kernel+bounces-84571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F386A87C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129C9289894
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494BE22F00;
	Wed, 28 Feb 2024 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uDUJ6vts"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60322EE8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102665; cv=none; b=qWm81U5Q8AsHltyVIvOVB6wmsXxl/Mwm5lyjfyjpUcdGgnkotNSUDmHQUYC/oYvY9LJwXJH3IDlrhmbuiidNCmAXnago6zPx281WKIxheG+TfOu1zUq0n8wa44POMU0oW7CSBXM2h0aQILmPWSSOMeepSTHqrGW9STSJhjRfSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102665; c=relaxed/simple;
	bh=LCnv3tVxpmAlhvoDB2KmHsp3n+wtnCb16MlPujATOX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cs3x1jJj+GuYGIQQy47WrnkoxDU2VBAcpFpqeGXDE3j7k3ZIzTlhyWTIYbKOQlFueccw65kyL/HAFmT5+A/scl5c9JYF/gzkYzJY6I1Bn+NeEVBm3Klf+1Nchb4zlITzLNzDGu2hiseTK8VMYdKqBKalUXgFzvg+Qq9Pvi7UOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uDUJ6vts; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a65ac3ad-9dfd-4da7-99e2-d23ab28b3729@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709102660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDw5AbPTFhldWRncX473mReQMJoUYqgYBgyYIvyTquk=;
	b=uDUJ6vtsCZLEtFibLEIP8BQ26/lnZ5LbvVahVBolUFrnAoq2E/C2cplUVj5eF5ZnjAJfKp
	99KP8bMjTsc2FlUIdSumDFB1BhlM6BfC+5oeDdPuCeELrB3IzPBaM+mQWU+KAZs2xAnYMk
	WJ2ee2mPti3LBzWs0QPe8JPf7z60wxc=
Date: Wed, 28 Feb 2024 14:44:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/zsmalloc: don't hold locks of all pages when
 free_zspage()
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: yosryahmed@google.com, hannes@cmpxchg.org, nphamcs@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
 <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>
 <20240228060113.GJ11972@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240228060113.GJ11972@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/28 14:01, Sergey Senozhatsky wrote:
> On (24/02/27 03:02), Chengming Zhou wrote:
>>  static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>>  				struct zspage *zspage)
>>  {
>> @@ -834,13 +841,12 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>>  		VM_BUG_ON_PAGE(!PageLocked(page), page);
> 
> Who owns page lock here if free_zspage() doesn't trylock_zspage() no longer?

Right, it should be removed.

> 
>>  		next = get_next_page(page);
>>  		reset_page(page);
>> -		unlock_page(page);
>>  		dec_zone_page_state(page, NR_ZSPAGES);
>>  		put_page(page);
>>  		page = next;
>>  	} while (page != NULL);
>>  
>> -	cache_free_zspage(pool, zspage);
>> +	call_rcu(&zspage->rcu_head, rcu_free_zspage);
>>  
>>  	class_stat_dec(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
>>  	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
>> @@ -852,16 +858,6 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
>>  	VM_BUG_ON(get_zspage_inuse(zspage));
>>  	VM_BUG_ON(list_empty(&zspage->list));
>>  
>> -	/*
>> -	 * Since zs_free couldn't be sleepable, this function cannot call
>> -	 * lock_page. The page locks trylock_zspage got will be released
>> -	 * by __free_zspage.
>> -	 */
>> -	if (!trylock_zspage(zspage)) {
>> -		kick_deferred_free(pool);
>> -		return;
>> -	}
>> -
>>  	remove_zspage(class, zspage);
>>  	__free_zspage(pool, class, zspage);
>>  }

