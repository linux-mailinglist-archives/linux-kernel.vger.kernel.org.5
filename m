Return-Path: <linux-kernel+bounces-84525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C73286A7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0302844CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6A20B35;
	Wed, 28 Feb 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GHsy7BXO"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64C210E6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097312; cv=none; b=CRodC+nHClV9veOCa4gTDDb/mPzCKqs4oo01lmNX2hB+ny5JPS1NwPoz5mbcaES3C5L0pTtlpC9Qc0eBpkJh1YohLT11OYxXf5opBPHeN/PYWUNLune1WE+RwU9Kp8EQHE1ecZNLorQ4GhG2Fi0KLLCHP6tdwaTZhJWa1L1sgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097312; c=relaxed/simple;
	bh=xTYHHrp6U8NIVX2UfNBmMHdjqPaESoOeIwGsvQDZ4ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/+67JhQ2YU0AZSO1ogM1qmPrga5IeoRedW3JmYjAQ6wN6O3uLKPoABYA+aVV1xltziZfOvodKrcQqUGXp/xJ2AK9JIA4woOsT6D4o5Hddl3iC53kkQL5jlIrYHdlprEHa2ZgICw9SBuo9OZxyYMmhXIgPn4FLK1jXz9vdVBp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GHsy7BXO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a556476-05b2-483e-8875-eeb3e2a51151@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709097304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgZMTdjfNWQh0YDiJwwEXmgUlMNBEeWeipdoEla6gn8=;
	b=GHsy7BXOca+egXV4CajBfaEUEScRqCFSkIt0tELiypa4eFBUjfK9sxpf6IjkETbBUG14mB
	JKS/dxFB+Q4w4mIbjNrGawSDzZgNUV+yEysExTYDOGK+jdxLy1fCEkEnU3DDQ4O1bGzBtx
	TusvMbLtZHyVNvKegnvNJkNsdg/F3I8=
Date: Wed, 28 Feb 2024 13:14:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/zsmalloc: don't hold locks of all pages when
 free_zspage()
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Chengming Zhou <zhouchengming@bytedance.com>
Cc: yosryahmed@google.com, hannes@cmpxchg.org, nphamcs@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
 <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>
 <20240228043358.GF11972@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240228043358.GF11972@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/28 12:33, Sergey Senozhatsky wrote:
> On (24/02/27 03:02), Chengming Zhou wrote:
> [..]
>> @@ -978,10 +974,11 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>>  		pages[i] = page;
>>  	}
>>  
>> -	create_page_chain(class, zspage, pages);
>>  	init_zspage(class, zspage);
>>  	zspage->pool = pool;
>>  	zspage->class = class->index;
>> +	/* RCU set_zspage() after zspage initialized. */
>> +	create_page_chain(class, zspage, pages);
> 
> So this hasn't been tested, has it?
I have tested it in my test vm, but it hasn't KASAN enabled. I tested the
kernel build in tmpfs with zswap enabled using zsmalloc pool, not sure
why the kernel didn't crash then...

> 
> init_zspage() does not like to be invoked before create_page_chain(),
> because we haven't setup required pointers yet.

You're right, I can reproduce the problem with KASAN enabled this time,
create_page_chain() should be put before init_zspage(), which will iterate
over the pages to create free objects list.

> 
> So when init_zspage() calls get_first_page() it gets NULL zspage->first_page
> which we then use in is_first_page(first_page)->PagePrivate(page). As far as
> I can tell.

Thanks! I will fix it and test throughly before send an update.

