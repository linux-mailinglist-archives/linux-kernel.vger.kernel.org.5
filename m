Return-Path: <linux-kernel+bounces-120236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00E88D4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CF61C24B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B9420B12;
	Wed, 27 Mar 2024 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IHWzK86R"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4651BF31
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507331; cv=none; b=I84UnYXGFZPkRtlXWHay45K0G7ow72rcBs0xwn304zasM0iZA4/obdwA+LrnPM9q96AFpoSLBn9CaBFojl255B18pq7/EufdhaWpILvqy1xTSZP/mYz4ULTT5Rnx1Bth+OHAkUYeUOeEF3ycQ+eMrR4s0ratoNQ0MEkoSCEWAVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507331; c=relaxed/simple;
	bh=l+tzPMM8dU3sU4nPqBTSFDfzqMh40eJ2urwvHn2jQC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtrU+AttwAJGt+lxQZ5gaMvkb0EObL7p1eTvnxmt0O0AN684dCAdaZrKZNRf29LSJlt+HM8NuYzEHncVq9/BHyo5xURjzVDyjSBOh/UeHN8NoFy7oEpekM+v8xpE9QQeMt7Tb72tRXLKLNvrK7cZufccED86ZP/OGjMpOMC3rgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IHWzK86R; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88957a87-fe4c-448c-a22a-9052d65ab643@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711507327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzy+RwRkpomfrV5aU//CFi1vdBrORFrQTeVF8dJnbRg=;
	b=IHWzK86Rc8aGvWMdfBsPeiBdcXEyN+ObKgTyiAPNS9k1d1R2hnlh1OLogjiRG4Fkc5gyyP
	PpsqNMh+SzxTNwjCg6mHBCEClNtuazCc8lnlJzC1t1ezUEue1DwHCkGm86UUvaLuS9HCja
	W5rYuPaOWIpeCnKvZy9T4MujQn907Os=
Date: Wed, 27 Mar 2024 10:42:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 3/9] mm: zswap: refactor limit checking from
 zswap_store()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-4-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240325235018.2028408-4-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/26 07:50, Yosry Ahmed wrote:
> Refactor limit and acceptance threshold checking outside of
> zswap_store(). This code will be moved around in a following patch, so
> it would be cleaner to move a function call around.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index ff1975afb7e3d..6b890c8590ef7 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1415,6 +1415,21 @@ static void zswap_fill_page(void *ptr, unsigned long value)
>  	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
>  }
>  
> +static bool zswap_check_limit(void)
> +{
> +	unsigned long cur_pages = zswap_total_pages();
> +	unsigned long thr = zswap_accept_thr_pages();
> +	unsigned long max_pages = zswap_max_pages();
> +
> +	if (cur_pages >= max_pages) {
> +		zswap_pool_limit_hit++;
> +		zswap_pool_reached_full = true;
> +	} else if (zswap_pool_reached_full && cur_pages <= thr) {
> +		zswap_pool_reached_full = false;
> +	}
> +	return !zswap_pool_reached_full;

nit: Then we use "!zswap_check_limit()" below, double negation looks complex,
should we change to zswap_should_reject() or something?

> +}
> +
>  bool zswap_store(struct folio *folio)
>  {
>  	swp_entry_t swp = folio->swap;
> @@ -1422,7 +1437,6 @@ bool zswap_store(struct folio *folio)
>  	struct xarray *tree = swap_zswap_tree(swp);
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
> -	unsigned long max_pages, cur_pages;
>  	struct zswap_entry *entry;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> @@ -1446,22 +1460,8 @@ bool zswap_store(struct folio *folio)
>  		mem_cgroup_put(memcg);
>  	}
>  
> -	/* Check global limits */
> -	cur_pages = zswap_total_pages();
> -	max_pages = zswap_max_pages();
> -
> -	if (cur_pages >= max_pages) {
> -		zswap_pool_limit_hit++;
> -		zswap_pool_reached_full = true;
> +	if (!zswap_check_limit())
>  		goto reject;
> -	}
> -
> -	if (zswap_pool_reached_full) {
> -		if (cur_pages > zswap_accept_thr_pages())
> -			goto reject;
> -		else
> -			zswap_pool_reached_full = false;
> -	}
>  
>  	/* allocate entry */
>  	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));

