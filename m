Return-Path: <linux-kernel+bounces-84544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7320786A816
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDD01C21CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429242137F;
	Wed, 28 Feb 2024 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BD0d/kX5"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34BFFBED
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709099027; cv=none; b=RMiqU+ycHbjnRGPmTR85MfYrFQ6gJN/H9e9OqRg9ivkk2FdXrLdoIMHFU2XhMhluO17Pq+f63mWUS6Zvwrtu+lD9q+N/8mh8BhtkqtP1bTDvm/6j3IIAN/SQ5FPVPiYXeRDmn2Ra4dw/rrIgWljVWEiojNbTmEVNoXHzFMDMgmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709099027; c=relaxed/simple;
	bh=piCLNf56YkprcJVSME4dyYKfVoLjzyiu57lZF9Hz8xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9rN5TA37fRjQB2IUdpq1c4fHrYJx+4eDQhluAXP1wev3ePfF7/nGSyzfb4jucsr7zNIcCZ7fJtveDHLWflXbWwKkk1wjerG+dwJ3vaUU1hqv9ZVpRubU7i5/uaPcfbSVqrT/OMtd84OKEI+6aapumY+zoFcZWElQzvTzY3yywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BD0d/kX5; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <913f1a04-8fa2-46b0-85dc-edd23477a1d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709099022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l++iOCqyZO1CS1muFXU9O7bGLWcbSNYXIqpB73Ui0aM=;
	b=BD0d/kX55nWw6Z/vo5v4uMJlEMGO6Ut0NyuoKToZJOEP91ok9gNi8C7JtAHoBRPG0C8LhW
	zfvsTnwtpVjfN75CiocJVFiE88F2nI/edNDCZMpFyP7o28aNBpbQ8xmn/BS6Yg6alShtkL
	SjwaBxv1hqcenzVi4S4rAu4HGlkLGNE=
Date: Wed, 28 Feb 2024 13:42:47 +0800
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
Cc: Chengming Zhou <zhouchengming@bytedance.com>, yosryahmed@google.com,
 hannes@cmpxchg.org, nphamcs@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
 <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>
 <20240228043358.GF11972@google.com>
 <5a556476-05b2-483e-8875-eeb3e2a51151@linux.dev>
 <20240228052906.GI11972@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240228052906.GI11972@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/28 13:29, Sergey Senozhatsky wrote:
> On (24/02/28 13:14), Chengming Zhou wrote:
>> On 2024/2/28 12:33, Sergey Senozhatsky wrote:
>>> On (24/02/27 03:02), Chengming Zhou wrote:
>>> [..]
>>>> @@ -978,10 +974,11 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>>>>  		pages[i] = page;
>>>>  	}
>>>>  
>>>> -	create_page_chain(class, zspage, pages);
>>>>  	init_zspage(class, zspage);
>>>>  	zspage->pool = pool;
>>>>  	zspage->class = class->index;
>>>> +	/* RCU set_zspage() after zspage initialized. */
>>>> +	create_page_chain(class, zspage, pages);
>>>
>>> So this hasn't been tested, has it?
>> I have tested it in my test vm, but it hasn't KASAN enabled. I tested the
>> kernel build in tmpfs with zswap enabled using zsmalloc pool, not sure
>> why the kernel didn't crash then...
> 
> I hit the problem on non-kasan-enabled kernel.  KASAN was enabled
> later on.

Ok, It should be a problem with my process, sorry.

> 
> [..]
> 
>>> So when init_zspage() calls get_first_page() it gets NULL zspage->first_page
>>> which we then use in is_first_page(first_page)->PagePrivate(page). As far as
>>> I can tell.
>>
>> Thanks! I will fix it and test throughly before send an update.
> 
> I'm curious if we want to add RCU to the picture, given that zsmalloc
> is quite often run under memory pressure.

Yes, it's a reasonable point. But given struct zspage size has only 56 bytes,
it maybe not a problem to delay its free to RCU?

Thanks.

