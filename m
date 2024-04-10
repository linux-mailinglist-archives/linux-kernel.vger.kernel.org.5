Return-Path: <linux-kernel+bounces-137836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B5189E826
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C361F21B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E504A8C1E;
	Wed, 10 Apr 2024 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JkRcMD7u"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB138C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716237; cv=none; b=kNwve75hroSw49ODlqbSZcO9kpo9V6p9RzUo+3C8JU5UFjeaJqhviywmv97tmiXbE3dTq5F3kqy7P8SU72Ps2mLGhgOMBpkBCTZVvDHQGozyX3om1ekucuw0i4Sd/YCH6qM0TIbIN9iBlP0qMpMk91LTkLopNiEjdbyGlA9gz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716237; c=relaxed/simple;
	bh=ZUTW/e9rIKMKDrvJ1AX4sYw0AV1K+V6GwQHoIA7URrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsFIHLUO52YJ8Th2mGiWe7AEpd6UzseipkjC6BSC37TnoBqRVPeA3fm9EEsJBkjj1CfiFgSd0ST6CRDA1L/qnQu7uW0l9hKYLlhhI9V+IwgN+e0rLRMJCNJMJuUu3pHni5cYjUN9Hlkbb5bvyICFW+AxIdcJdTq0TjzQZd+R89Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JkRcMD7u; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <84eccd09-6434-4abc-97c4-99e8c13a7271@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712716232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep0yCE3LosNaiXPWKGlbOziHWDlxqD6vB41Roc/ZFwc=;
	b=JkRcMD7u5CmxOMIXQCHIPWwy1VWLnNlzCfb/6lHpL+e0H4xH67ZRZhA80LtX+zok0UpbbY
	uICAdNIkvaMAoJNstaf1NFN+LUckdSjhCH/HH+QtVzJpPOaZupn1Qc1TbMudLOewKY5zo3
	ZjCJGko/8fSuOd2n4orlBa0ksLrBGvY=
Date: Wed, 10 Apr 2024 10:30:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/5] mm: zswap: refactor limit checking from
 zswap_store()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240405053510.1948982-1-yosryahmed@google.com>
 <20240405053510.1948982-4-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240405053510.1948982-4-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/4/5 13:35, Yosry Ahmed wrote:
> Refactor limit and acceptance threshold checking outside of
> zswap_store(). This code will be moved around in a following patch, so
> it would be cleaner to move a function call around.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/zswap.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 832e3f56232f0..ab3cd43cdfc9d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1444,6 +1444,20 @@ static void zswap_fill_page(void *ptr, unsigned long value)
>  	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
>  }
>  
> +static bool zswap_check_full(void)
> +{
> +	unsigned long cur_pages = zswap_total_pages();
> +
> +	if (cur_pages >= READ_ONCE(zswap_max_pages)) {
> +		zswap_pool_limit_hit++;
> +		zswap_pool_reached_full = true;
> +	} else if (zswap_pool_reached_full &&
> +		   cur_pages <= READ_ONCE(zswap_accept_thr_pages)) {
> +		zswap_pool_reached_full = false;
> +	}
> +	return zswap_pool_reached_full;
> +}
> +
>  bool zswap_store(struct folio *folio)
>  {
>  	swp_entry_t swp = folio->swap;
> @@ -1452,7 +1466,6 @@ bool zswap_store(struct folio *folio)
>  	struct zswap_entry *entry, *old;
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
> -	unsigned long max_pages, cur_pages;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1475,20 +1488,8 @@ bool zswap_store(struct folio *folio)
>  		mem_cgroup_put(memcg);
>  	}
>  
> -	/* Check global limits */
> -	cur_pages = zswap_total_pages();
> -	if (cur_pages >= READ_ONCE(zswap_max_pages)) {
> -		zswap_pool_limit_hit++;
> -		zswap_pool_reached_full = true;
> +	if (zswap_check_full())
>  		goto reject;
> -	}
> -
> -	if (zswap_pool_reached_full) {
> -		if (cur_pages > READ_ONCE(zswap_accept_thr_pages))
> -			goto reject;
> -		else
> -			zswap_pool_reached_full = false;
> -	}
>  
>  	/* allocate entry */
>  	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));

