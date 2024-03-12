Return-Path: <linux-kernel+bounces-99833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBA8878E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0425F1C21429
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D861C8DD;
	Tue, 12 Mar 2024 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h6QTprJc"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A2BE6D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219509; cv=none; b=cL91fybNgQiE9z1jThqG6/8c5KGv3pq7Zvly/WbzgNgdEtUdll63tq7S2pfPaRKoBFvEZOS1rhHAwC0Lpgeap1V2oNZw22PkyuFYkFJuRa+kBoFBKkQBMzHIMvldzpqqyJcGS5iAs1WOHUhwYhnWVbFQ2y/it4zVyVlAKbw48ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219509; c=relaxed/simple;
	bh=6zqa6P2EGkiDuzFO/I4oTsjRTV8BpMATKDpKbTV4IAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMt2S5F1qifijtMDZ3x76rwQwx+fEdCX3yxV/KpkiI9hPvs9HWU4jKMsJ5bzqKsrYX3iyR+cL17kKTWP8KrpA21g7TUNInfDQyrKpi80xotz0hfd70MgIlebXo0ITimVlb2BlAnzjkGUGMlfCPrqcAY+KP+FIElnOF9cdDf+vxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h6QTprJc; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <afee884d-b19c-4e03-bba4-9207673b3c96@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710219505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YE1RJvCCOc/EPRwrM42zHZ3v+Ktd8fYS0EGnWpzzjWA=;
	b=h6QTprJcRwDIvZD9ZZ2dy/M0LKviyZxlEeF0pVMV+3Rg8bjsIXTCNvQnpFKjrPMJRdnq/1
	RRWUkBUailildodP3WpTMS7+2BbBrVbSqY7vw9VcuhZvKF0ieZxxQg1VnwvVL06fjJZNJa
	HdljuodYuF+pBGJK2ctuaJMPs4OLFV4=
Date: Tue, 12 Mar 2024 12:57:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: zswap: remove unnecessary check in zswap_find_zpool()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240311235210.2937484-1-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240311235210.2937484-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/12 07:52, Yosry Ahmed wrote:
> zswap_find_zpool() checks if ZSWAP_NR_ZPOOLS > 1, which is always true.
> This is a remnant from a patch version that had ZSWAP_NR_ZPOOLS as a
> config option and never made it upstream. Remove the unnecessary check.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Looks good to me!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/zswap.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9a32377520827..c6267b5e0999a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -884,12 +884,7 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
>  
>  static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
>  {
> -	int i = 0;
> -
> -	if (ZSWAP_NR_ZPOOLS > 1)
> -		i = hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS));
> -
> -	return entry->pool->zpools[i];
> +	return entry->pool->zpools[hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS))];
>  }
>  
>  /*

