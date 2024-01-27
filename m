Return-Path: <linux-kernel+bounces-41216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B9083ED82
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9892841F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB2A25767;
	Sat, 27 Jan 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qYDlgui1"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F22560F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366263; cv=none; b=PlPlSxrR8evIEDggeBEmySIiR0MKnyz9piWaj6gs8uACVq/xCadh77krOakR6LZNZuh+EYMAO9qp5N8En8UFeWzgDpJcGpFJvCxhjq+G0WydBPYzlbCN6MaOViaMe80zPEBYQSIuKuUJ9/bzVlA/5fLcYhJvkz6wvWEbUXWq3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366263; c=relaxed/simple;
	bh=0Js3adgF+F9IPPmq0++Plksk8l+xnGP8XjIynGvGUS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRE+2EFAH7wntT1elAQXbkm++elWOHozt3gIwC2RrElUBp1u4TPlR66TFtTpyjeYSMfRXcFBwAi0puTy2IHv2/bDI9jk3o1yTwSbLxY1+YphsVdnX/TZV6v+D9N4QWGmHSYbmAFFtdqE+Nw515Rb0/DiRxhg9DLkvOf2BXiOhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qYDlgui1; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22e52669-2cf5-4375-9cb8-82d2f5faadc6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706366258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV3dWDakr9U818CnIN7WSME4LhiLTtmT6rYycJO+fHg=;
	b=qYDlgui1sVedlnQWxnqFLMKOyPA/LJ9C2q1zlti+WVLNGGzkmFKmaf5RM500TbvX7F2Nb6
	vY7cK7u5sn9aXlCnetWYF9+FSerVrXAw59oA2qqEvBuGua0FSH9gy0S+vkqSSLDOdom27O
	n9cGwYF8moInV/cCIV8lA8D0Gsh7n4M=
Date: Sat, 27 Jan 2024 22:37:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/zswap: don't return LRU_SKIP if we have dropped
 lru lock
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240126083015.3557006-1-chengming.zhou@linux.dev>
 <CAKEwX=NzDY57n6ogx6=VaaEx8j_Jtvz5BeuMDAW-KuDXmsyQFw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAKEwX=NzDY57n6ogx6=VaaEx8j_Jtvz5BeuMDAW-KuDXmsyQFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/27 02:01, Nhat Pham wrote:
> On Fri, Jan 26, 2024 at 12:31 AM <chengming.zhou@linux.dev> wrote:
>>
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> LRU_SKIP can only be returned if we don't ever dropped lru lock, or
>> we need to return LRU_RETRY to restart from the head of lru list.
> 
> Ooops. You're right! I just double checked and only LRU_REMOVED_RETRY
> and LRU_RETRY indicate we might have dropped the lock. My bad.
> 
>>
>> Actually we may need to introduce another LRU_STOP to really terminate
>> the ongoing shrinking scan process, when we encounter a warm page
> 
> Yup. This is what I was trying (and failing) to do. To be honest, this
> needs to be even stronger: short-circuit ALL concurrent/ongoing zswap
> shrinker scan processes that are touching this memcg (as they will
> also shrink into warmer regions going forward). But that's a bit more
> engineering to do. LRU_STOP, which stops this scan process, would be a
> good place to start.

Good suggestion, will look into that more later.

> 
>> already in the swap cache. The current list_lru implementation
>> doesn't have this function to early break from __list_lru_walk_one.
>>
>> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thanks.

> 
>> ---
>>  mm/zswap.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 00e90b9b5417..81cb3790e0dd 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -901,10 +901,8 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>>                  * into the warmer region. We should terminate shrinking (if we're in the dynamic
>>                  * shrinker context).
>>                  */
>> -               if (writeback_result == -EEXIST && encountered_page_in_swapcache) {
>> -                       ret = LRU_SKIP;
>> +               if (writeback_result == -EEXIST && encountered_page_in_swapcache)
>>                         *encountered_page_in_swapcache = true;
>> -               }
>>
>>                 goto put_unlock;
>>         }
>> --
>> 2.40.1
>>

