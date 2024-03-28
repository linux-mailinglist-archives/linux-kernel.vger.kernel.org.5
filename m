Return-Path: <linux-kernel+bounces-122574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073AD88F9E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B611B290636
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358353E32;
	Thu, 28 Mar 2024 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kOMXbJDC"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE017BB9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613769; cv=none; b=VrxmhjmbXsLKN/KcYa3o5II3qkkhYblW7xBhvNCtYlu7tZt+v4p+Z8DRqdKQIXp2qH3sgqpHK2f0CG3L32s+x6jRAwfSF5AIYF6eCcXo7wyAp5mU+hElmrz0RdtIKHlTEuaJMxM6w+T/Vehtj/pJLMqRej9wbAYXewCBKhnq/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613769; c=relaxed/simple;
	bh=dlGKVS+WvTf5/rAhT2E+OEMVaU2rjznUwxa7cmPIehw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKLUkcThhTqlbAf9e8pVMdSvW//j9TwEiMkHgue/eHLIapiVmoaLTDQrevv9x9AZEhfSaVupNrRef9o5qEB82q9CyfpQSEffs8rNZsOnrEjg0MKYgmCi9Xs4dLN8+SU+3BsqjML5TNgibKWK+fHoVEPXLfmAHrIxw0Yx1o5iRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kOMXbJDC; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <160b54f1-b578-40d5-a977-00b71fd22e34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711613765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tn2JXPtKgDb/RvnAaA2HxiulPKE1lezZ4kqGlrru2k=;
	b=kOMXbJDCyhekg4mdOuMJGuSHoVXwmrSC+tdEiXJm6Th2+sFjCM1dfRMYPcqQXINLd7J/2T
	xKLX06BUo0aabg+gmiTVW9sr7eMDj9ruk2h/27JDhTMlSusDB24NCxEsTSWmNtxx8adi0x
	5n1miXWD9XczovsTmc8kX3cEoqQQ0Ds=
Date: Thu, 28 Mar 2024 16:15:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 8/9] mm: zswap: do not check the global limit for
 zero-filled pages
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-9-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240325235018.2028408-9-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/26 07:50, Yosry Ahmed wrote:
> When storing zero-filled pages, there is no point of checking the global
> zswap limit. These pages do not consume any memory that contributes
> toward the limit. Move the limit checking after zero-filled pages are
> handled.
> 
> This avoids having zero-filled pages skip zswap and go to disk swap if
> the limit is hit. It also avoids queueing the shrink worker, which may
> end up being unnecessary if the zswap usage goes down on its own before
> another store is attempted.
> 
> Ignoring the memcg limits as well for zero-filled pages is more
> controversial. Those limits are more a matter of per-workload policy.
> Some workloads disable zswap completely by setting memory.zswap.max = 0,
> and those workloads could start observing some zswap activity even after
> disabling zswap. Although harmless, this could cause confusion to
> userspace. Remain conservative and keep respecting those limits.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Yeah, it looks reasonable to keep the memcg limits check.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/zswap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index efc323bab2f22..9357328d940af 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1460,9 +1460,6 @@ bool zswap_store(struct folio *folio)
>  		mem_cgroup_put(memcg);
>  	}
>  
> -	if (!zswap_check_limit())
> -		goto reject;
> -
>  	if (zswap_is_folio_zero_filled(folio)) {
>  		if (zswap_store_zero_filled(tree, offset, objcg))
>  			goto reject;
> @@ -1472,6 +1469,9 @@ bool zswap_store(struct folio *folio)
>  	if (!zswap_non_zero_filled_pages_enabled)
>  		goto reject;
>  
> +	if (!zswap_check_limit())
> +		goto reject;
> +
>  	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
>  	if (!entry) {
>  		zswap_reject_kmemcache_fail++;

