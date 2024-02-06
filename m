Return-Path: <linux-kernel+bounces-54200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4484AC27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423F01C23206
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E7F56B62;
	Tue,  6 Feb 2024 02:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oQMdyuN/"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFEF56B61
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186222; cv=none; b=NHK/CgQ+DLIql1zWHqiZrKpFlHx91slZJmRbIsk8TLCXsz+DFugdHOzSMbLHjPtDFsSE0oEgfn6MYYXSfUJCSZMdseyd2sV3TY36x3KXOEZaFlCLUkFlYqz/ly9+PqMtwU2X3cnc8TD3sx74wvo0/oPw4vr4L86DkOy+5EYXwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186222; c=relaxed/simple;
	bh=cmj0dv2kT2fCoAyowc5LGWqlSMvUWsWKMYDOQqEJwj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUB0f+0npELeJEjCIKmWlgAkVcMu/ASr6KTHJ/DCKtZxIvt36IM8AoFYo9pQxquCFF1zYJcsMsUk4+N3x6opV5BWq8K9DJCZxg8OjQg2ygJmJmDoMredOWHHJk9XUClugKVYWSt0e7R3vhakt+OqF9k7Q2iASQoPfOVne0UbE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oQMdyuN/; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5315e2d-a03a-4b2f-9e12-1685fa0515e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707186218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWOM6rLUSXhQ0cpOJnsOOSLPrLEastBq1peLqBFRdbk=;
	b=oQMdyuN/MixUuBdNNyhcwctxZbyzMcoHleds5u5dMpRJkGarpvFY5ggVPo+GF6xMik8KVO
	IAff2ZUfIXnO16yQIQ2QG1F6abv1EKmbClOUpSMR83UmSE6aU3SeK542UGmU7z3HzwvKcO
	wsntrKRHGjhPc03SjHBAExUU/glkdAk=
Date: Tue, 6 Feb 2024 10:23:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/zswap: invalidate old entry when store fail or
 !zswap_enabled
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240204083411.3762683-1-chengming.zhou@linux.dev>
 <ZcFne336KJdbrvvS@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZcFne336KJdbrvvS@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/6 06:55, Yosry Ahmed wrote:
> On Sun, Feb 04, 2024 at 08:34:11AM +0000, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> We may encounter duplicate entry in the zswap_store():
>>
>> 1. swap slot that freed to per-cpu swap cache, doesn't invalidate
>>    the zswap entry, then got reused. This has been fixed.
>>
>> 2. !exclusive load mode, swapin folio will leave its zswap entry
>>    on the tree, then swapout again. This has been removed.
>>
>> 3. one folio can be dirtied again after zswap_store(), so need to
>>    zswap_store() again. This should be handled correctly.
>>
>> So we must invalidate the old duplicate entry before insert the
>> new one, which actually doesn't have to be done at the beginning
>> of zswap_store(). And this is a normal situation, we shouldn't
>> WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
>> to detect swap entry UAF problem? But not very necessary here.)
>>
>> The good point is that we don't need to lock tree twice in the
>> store success path.
>>
>> Note we still need to invalidate the old duplicate entry in the
>> store failure path, otherwise the new data in swapfile could be
>> overwrite by the old data in zswap pool when lru writeback.
> 
> I think this may have been introduced by 42c06a0e8ebe ("mm: kill
> frontswap"). Frontswap used to check if the page was present in
> frontswap and invalidate it before calling into zswap, so it would
> invalidate a previously stored page when it is dirtied and swapped out
> again, even if zswap is disabled.
> 
> Johannes, does this sound correct to you? If yes, I think we need a
> proper Fixes tag and a stable backport as this may cause data
> corruption.

I haven't looked into that commit. If this is true, will add:

Fixes: 42c06a0e8ebe ("mm: kill frontswap")

> 
>>
>> We have to do this even when !zswap_enabled since zswap can be
>> disabled anytime. If the folio store success before, then got
>> dirtied again but zswap disabled, we won't invalidate the old
>> duplicate entry in the zswap_store(). So later lru writeback
>> may overwrite the new data in swapfile.
>>
>> This fix is not good, since we have to grab lock to check everytime
>> even when zswap is disabled, but it's simple.
> 
> Frontswap had a bitmap that we can query locklessly to find out if there
> is an outdated stored page. I think we can overcome this with the
> xarray, we can do a lockless lookup first, and only take the lock if
> there is an outdated entry to remove.

Yes, agree! We can lockless lookup once xarray lands in.

> 
> Meanwhile I am not sure if acquiring the lock on every swapout even with
> zswap disabled is acceptable, but I think it's the simplest fix for now,
> unless we revive the bitmap.

Yeah, it's simple. I think bitmap is not needed if we will use xarray.

> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 33 +++++++++++++++------------------
>>  1 file changed, 15 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index cd67f7f6b302..0b7599f4116d 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1518,18 +1518,8 @@ bool zswap_store(struct folio *folio)
>>  		return false;
>>  
>>  	if (!zswap_enabled)
>> -		return false;
>> +		goto check_old;
>>  
>> -	/*
>> -	 * If this is a duplicate, it must be removed before attempting to store
>> -	 * it, otherwise, if the store fails the old page won't be removed from
>> -	 * the tree, and it might be written back overriding the new data.
>> -	 */
>> -	spin_lock(&tree->lock);
>> -	entry = zswap_rb_search(&tree->rbroot, offset);
>> -	if (entry)
>> -		zswap_invalidate_entry(tree, entry);
>> -	spin_unlock(&tree->lock);
>>  	objcg = get_obj_cgroup_from_folio(folio);
>>  	if (objcg && !obj_cgroup_may_zswap(objcg)) {
>>  		memcg = get_mem_cgroup_from_objcg(objcg);
>> @@ -1608,15 +1598,11 @@ bool zswap_store(struct folio *folio)
>>  	/* map */
>>  	spin_lock(&tree->lock);
>>  	/*
>> -	 * A duplicate entry should have been removed at the beginning of this
>> -	 * function. Since the swap entry should be pinned, if a duplicate is
>> -	 * found again here it means that something went wrong in the swap
>> -	 * cache.
>> +	 * The folio could be dirtied again, invalidate the possible old entry
>> +	 * before insert this new entry.
>>  	 */
>> -	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
>> -		WARN_ON(1);
>> +	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST)
>>  		zswap_invalidate_entry(tree, dupentry);
>> -	}
> 
> I always thought the loop here was confusing. We are holding the lock,
> so it should be guaranteed that if we get -EEXIST once and invalidate
> it, we won't find it the next time around.

Ah, right, this is obvious.

> 
> This should really be a cmpxchg operation, which is simple with the
> xarray. We can probably do the same with the rbtree, but perhaps it's
> not worth it if the xarray change is coming soon.
> 
> For now, I think an if condition is clearer:
> 
> if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> 	zswap_invalidate_entry(tree, dupentry);
> 	/* Must succeed, we just removed the dup under the lock */
> 	WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
> }

This is clearer, will change to this version.

Thanks!

> 
>>  	if (entry->length) {
>>  		INIT_LIST_HEAD(&entry->lru);
>>  		zswap_lru_add(&entry->pool->list_lru, entry);
>> @@ -1638,6 +1624,17 @@ bool zswap_store(struct folio *folio)
>>  reject:
>>  	if (objcg)
>>  		obj_cgroup_put(objcg);
>> +check_old:
>> +	/*
>> +	 * If zswap store fail or zswap disabled, we must invalidate possible
>> +	 * old entry which previously stored by this folio. Otherwise, later
>> +	 * writeback could overwrite the new data in swapfile.
>> +	 */
>> +	spin_lock(&tree->lock);
>> +	entry = zswap_rb_search(&tree->rbroot, offset);
>> +	if (entry)
>> +		zswap_invalidate_entry(tree, entry);
>> +	spin_unlock(&tree->lock);
>>  	return false;
>>  
>>  shrink:
>> -- 
>> 2.40.1
>>

