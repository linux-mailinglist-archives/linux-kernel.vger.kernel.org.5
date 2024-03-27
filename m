Return-Path: <linux-kernel+bounces-120233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDB988D4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC9A300496
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF9208CB;
	Wed, 27 Mar 2024 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aJC0diZB"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9717BA6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507157; cv=none; b=V9BPI0s8dLR4MkuI8Hc2kvdpRQYC4wt7Sz/x6ub0nur6jfyIafks3+4/C6Io6MRbeHijoomeWERdXMwmkGL3TrcGlhEanRCGEWlbOtMC/WGcw2paJSXkSlDWdRK+S9tPfnvV6vBp2jCwW/HPice/2pHp7NSQuKDyQA9gLQrPUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507157; c=relaxed/simple;
	bh=EuzoT5DmLS9P1s0u3VWduBe7o3xiQSFmQs/DtTfO8GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBlhHvNv0OxHk6EYjhhZMBlJuAYnj/5mHO2Y4FhljCa82lYkYY0DBYs0NpfQKJ5EytFMt+WPmwXe/lO1KiD70CMUpZhNu9x9cZSbjShYX4CQ/ALUpEx3ty4GDrodGeWiSX+n7cs6n9uC9LhHqhCKikZQRJpKSh1ots026/qBLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aJC0diZB; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fef4556f-5d22-4941-9990-a4a3cf003dc4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711507152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtdGJbvgCvyX9L150u2NBhNCNfz4EeUXpgYSQTOqlaQ=;
	b=aJC0diZBUSd4toccTsUitzENznMKTDh1pGnhGg9403Av5Bg/9H4lMSVS2ttJw/r+aRd+W7
	RLLYc3K/AGwUcC3sMKEKdKf574k6d/AFVKTRcCK+d4jLs3O52b8TYbgE5DaZHh4YSpebPP
	m1RM3+DI7R+M+tN5Y2QoeDr0g+xGtPM=
Date: Wed, 27 Mar 2024 10:39:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 4/9] mm: zswap: move more same-filled pages checks
 outside of zswap_store()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-5-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240325235018.2028408-5-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/26 07:50, Yosry Ahmed wrote:
> Currently, zswap_store() check zswap_same_filled_pages_enabled, kmaps
> the folio, then calls zswap_is_page_same_filled() to check the folio
> contents. Move this logic into zswap_is_page_same_filled() as well (and
> rename it to use 'folio' while we are at it).
> 
> This makes zswap_store() cleaner, and makes following changes to that
> logic contained within the helper.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM with one comment below:

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>  mm/zswap.c | 45 ++++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6b890c8590ef7..498a6c5839bef 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1385,26 +1385,36 @@ static void shrink_worker(struct work_struct *w)
>  	} while (zswap_total_pages() > thr);
>  }
>  
> -static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
> +static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
>  {
>  	unsigned long *page;
>  	unsigned long val;
>  	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
> +	bool ret;
>  
> -	page = (unsigned long *)ptr;
> +	if (!zswap_same_filled_pages_enabled)
> +		return false;
> +
> +	page = kmap_local_folio(folio, 0);
>  	val = page[0];
>  
> -	if (val != page[last_pos])
> -		return 0;
> +	if (val != page[last_pos]) {
> +		ret = false;
> +		goto out;
> +	}
>  
>  	for (pos = 1; pos < last_pos; pos++) {
> -		if (val != page[pos])
> -			return 0;
> +		if (val != page[pos]) {
> +			ret = false;

nit: ret can be initialized to false, so

> +			goto out;
> +		}
>  	}
>  
>  	*value = val;
> -
> -	return 1;
> +	ret = true;

only need to set to true here.

Thanks.

> +out:
> +	kunmap_local(page);
> +	return ret;
>  }
>  
>  static void zswap_fill_page(void *ptr, unsigned long value)
> @@ -1438,6 +1448,7 @@ bool zswap_store(struct folio *folio)
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
>  	struct zswap_entry *entry;
> +	unsigned long value;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1470,19 +1481,11 @@ bool zswap_store(struct folio *folio)
>  		goto reject;
>  	}
>  
> -	if (zswap_same_filled_pages_enabled) {
> -		unsigned long value;
> -		u8 *src;
> -
> -		src = kmap_local_folio(folio, 0);
> -		if (zswap_is_page_same_filled(src, &value)) {
> -			kunmap_local(src);
> -			entry->length = 0;
> -			entry->value = value;
> -			atomic_inc(&zswap_same_filled_pages);
> -			goto insert_entry;
> -		}
> -		kunmap_local(src);
> +	if (zswap_is_folio_same_filled(folio, &value)) {
> +		entry->length = 0;
> +		entry->value = value;
> +		atomic_inc(&zswap_same_filled_pages);
> +		goto insert_entry;
>  	}
>  
>  	if (!zswap_non_same_filled_pages_enabled)

