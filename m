Return-Path: <linux-kernel+bounces-43901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10883841A97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FB928748A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6BD374F6;
	Tue, 30 Jan 2024 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c8iGEe/3"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0AA374C2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585716; cv=none; b=tdZlgyYzdspzm8SMag/gg7el6mkryGbg/iNEXU94F6UVDc3aiLL24kopDFn5roUv/4rqfITTUIzvLCg5pav7G18aB385EfhQa8u9AF3k4cMWNwQzc3rqXWVUnkYDguZn9UlYZt+MhR141/WenXGfyFbvC++D13G8AaODylv6hc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585716; c=relaxed/simple;
	bh=laPAM7tjrewUtvM6boCm1JshgXuGj0fLm3/PW/FAzeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBRIgsjsxPXPN8j3y/rNaJsUuzbmZAnHYMO5k9hoBPkFw9640oVc8x5Q37e2GxEkTpoBqGk2lYVGiE22KG2MWvY3IbHweZ0IiZnTq3Fw3sv9tVHYe4h/VX8LF3eUW60jQyBBz1ym9X7EgwN99ZTSfFfLBnanVStZ3/TxsMp52O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c8iGEe/3; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd9030d68fso1997657b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706585713; x=1707190513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQVcVHhd8KNKc0LGt7HNrbGiDVwEw4z8+pwpVo1DBE8=;
        b=c8iGEe/3leKgqsSypu2c1UOxgT8AmEFv1nFKut0zVj1sqPuQgPKKp6II7SJHdboiMo
         mGcBQmmNHyaB3IMJjq2FX8Dg4//MXLxFjiianlaJWr4b6fxTxIWYPilZb+Yum+ewCr4X
         CGa177MVQ2x44Mf1Om0zLkXesfkrxotXkQUtJA10eKBUDLi5VIy9j+VPuui2Pxsm61UZ
         0xWFVnGry4S8bQDnAq4BjjEL2GDN2HpvxjsagmTn2CqsGdEuzjhw8fDRaw3RQ0QFKh3R
         ZuB6f80rfwoZPbyTx6cQBTSznnkEyiexMjhiyiH6cllTws99wINQGjqwtUCAD1tfEFH1
         hMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585713; x=1707190513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQVcVHhd8KNKc0LGt7HNrbGiDVwEw4z8+pwpVo1DBE8=;
        b=FofUgSTP9Bcx0JeZ6ttFCnrYvZoOAJU6L4/IxOZnjwwbdi3mTq2ApVASpyspAuSI+T
         nqqzhudAY0MSSDwn16wM/M7tOb/+geQ4TmD1p0Nxa31PoHehnKE278L1SbIYlBjVlaF8
         y4eRavdJ4+TX/u61uJ9MK/tA7GuZxT6+cdO0x1G3wxHXbk1blV+M90kGRezeEDmsehD9
         6vTsY92ARFG7y/1dDXBL75UjEBVLHdE2mLIKrGq4p7HLHopLdpRa+s9zO0l1u1xFrqdB
         2B1SRH64Xq4Tf4RuKFNOp4+jp/mDkGyaNrsjrbAMVhcUFzquWdw5tsnppiuJyvfdG7UT
         8ICA==
X-Gm-Message-State: AOJu0YzIDdnys5GqJp0TNWEDhRxzeWaE2KooMzi895cPwB+FSQ07oqlQ
	8Ro0wgVSweeE801KEfKeiS2XsOVJYhljarkEpOV9gBiIntBXLJeYl94Cr6fdLimYh+1NCndcEKE
	K
X-Google-Smtp-Source: AGHT+IE0BoBKdjYHU7EZjSrc3Yg3PDLB0p6ahufonMqKpd3aUlTJ3aDwYex0PVWJzlEiw/LfpbZpaw==
X-Received: by 2002:a05:6808:114d:b0:3bd:97b0:f893 with SMTP id u13-20020a056808114d00b003bd97b0f893mr7624944oiu.49.1706585713066;
        Mon, 29 Jan 2024 19:35:13 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y17-20020a63b511000000b005d8b481c4d3sm5561909pge.87.2024.01.29.19.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:35:12 -0800 (PST)
Message-ID: <21f2bcba-a646-48b7-aa54-d763a490b216@bytedance.com>
Date: Tue, 30 Jan 2024 11:35:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] mm: zswap: further cleanup zswap_store()
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-9-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014208.565554-9-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:36, Johannes Weiner wrote:
> - Remove dupentry, reusing entry works just fine.
> - Rename pool to shrink_pool, as this one actually is confusing.
> - Remove page, use folio_nid() and kmap_local_folio() directly.
> - Set entry->swpentry in a common path.
> - Move value and src to local scope of use.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f9b9494156ba..cde309c539b3 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1542,14 +1542,11 @@ bool zswap_store(struct folio *folio)
>  {
>  	swp_entry_t swp = folio->swap;
>  	pgoff_t offset = swp_offset(swp);
> -	struct page *page = &folio->page;
>  	struct zswap_tree *tree = swap_zswap_tree(swp);
>  	struct zswap_entry *entry, *dupentry;
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
> -	struct zswap_pool *pool;
> -	unsigned long value;
> -	u8 *src;
> +	struct zswap_pool *shrink_pool;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1567,10 +1564,10 @@ bool zswap_store(struct folio *folio)
>  	 * the tree, and it might be written back overriding the new data.
>  	 */
>  	spin_lock(&tree->lock);
> -	dupentry = zswap_rb_search(&tree->rbroot, offset);
> -	if (dupentry) {
> +	entry = zswap_rb_search(&tree->rbroot, offset);
> +	if (entry) {
> +		zswap_invalidate_entry(tree, entry);
>  		zswap_duplicate_entry++;
> -		zswap_invalidate_entry(tree, dupentry);
>  	}
>  	spin_unlock(&tree->lock);
>  	objcg = get_obj_cgroup_from_folio(folio);
> @@ -1598,17 +1595,19 @@ bool zswap_store(struct folio *folio)
>  	}
>  
>  	/* allocate entry */
> -	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
> +	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
>  	if (!entry) {
>  		zswap_reject_kmemcache_fail++;
>  		goto reject;
>  	}
>  
>  	if (zswap_same_filled_pages_enabled) {
> -		src = kmap_local_page(page);
> +		unsigned long value;
> +		u8 *src;
> +
> +		src = kmap_local_folio(folio, 0);
>  		if (zswap_is_page_same_filled(src, &value)) {
>  			kunmap_local(src);
> -			entry->swpentry = swp;
>  			entry->length = 0;
>  			entry->value = value;
>  			atomic_inc(&zswap_same_filled_pages);
> @@ -1637,9 +1636,8 @@ bool zswap_store(struct folio *folio)
>  	if (!zswap_compress(folio, entry))
>  		goto put_pool;
>  
> -	entry->swpentry = swp;
> -
>  insert_entry:
> +	entry->swpentry = swp;
>  	entry->objcg = objcg;
>  	if (objcg) {
>  		obj_cgroup_charge_zswap(objcg, entry->length);
> @@ -1684,9 +1682,9 @@ bool zswap_store(struct folio *folio)
>  	return false;
>  
>  shrink:
> -	pool = zswap_pool_last_get();
> -	if (pool && !queue_work(shrink_wq, &pool->shrink_work))
> -		zswap_pool_put(pool);
> +	shrink_pool = zswap_pool_last_get();
> +	if (shrink_pool && !queue_work(shrink_wq, &shrink_pool->shrink_work))
> +		zswap_pool_put(shrink_pool);
>  	goto reject;
>  }
>  

