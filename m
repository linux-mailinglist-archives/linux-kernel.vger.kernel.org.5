Return-Path: <linux-kernel+bounces-141237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D0B8A1B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0961C213AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE656B71;
	Thu, 11 Apr 2024 15:53:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB4B56448
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850827; cv=none; b=U38f3KakyRcmEyE5R4OMeLz9Npo3HGwWyptXRBzsDeM2ggbPibMBftwpzX8UIIneXrKTbMs8jtKAKwSFIF6js3h6fpSYg2p8AJi+uHj6LTTIbrGA9dn8npdxH16JJrSsOE7WfS1kO0hdxB1g1yXirqc4F3Hpw2Pa3ctiVI/KSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850827; c=relaxed/simple;
	bh=yHQIkG0qtTf5BfJsqCqe+kvPCGQ5cBRA2aCNtawHVGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMk/YM+FYjIy0gNH04i0yI2GEyVVWVs85xAQefRv3KOrK9EedC/mbYrg9UgMfg1vrphT6qtkD31lgdZKeQwvqgDautaPnNOzh9QPiaAqIHQoPA4Zp2IstUD5iNHZhY2PybMc/dNK++Ky3Wr4kykf8adzwfGShwXpeehSTtsa2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07E13113E;
	Thu, 11 Apr 2024 08:54:15 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47CDE3F6C4;
	Thu, 11 Apr 2024 08:53:43 -0700 (PDT)
Message-ID: <226c4935-def2-4d72-b0bb-308578d1e0b1@arm.com>
Date: Thu, 11 Apr 2024 16:53:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm: add per-order mTHP swpin_refault counter
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org
References: <20240409082631.187483-1-21cnbao@gmail.com>
 <20240409082631.187483-6-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240409082631.187483-6-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 09:26, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Currently, we are handling the scenario where we've hit a
> large folio in the swapcache, and the reclaiming process
> for this large folio is still ongoing.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/huge_mm.h | 1 +
>  mm/huge_memory.c        | 2 ++
>  mm/memory.c             | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c8256af83e33..b67294d5814f 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -269,6 +269,7 @@ enum mthp_stat_item {
>  	MTHP_STAT_ANON_ALLOC_FALLBACK,
>  	MTHP_STAT_ANON_SWPOUT,
>  	MTHP_STAT_ANON_SWPOUT_FALLBACK,
> +	MTHP_STAT_ANON_SWPIN_REFAULT,

I don't see any equivalent counter for small folios. Is there an analogue?

>  	__MTHP_STAT_COUNT
>  };
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d8d2ed80b0bf..fb95345b0bde 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -556,12 +556,14 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAULT);
>  
>  static struct attribute *stats_attrs[] = {
>  	&anon_alloc_attr.attr,
>  	&anon_alloc_fallback_attr.attr,
>  	&anon_swpout_attr.attr,
>  	&anon_swpout_fallback_attr.attr,
> +	&anon_swpin_refault_attr.attr,
>  	NULL,
>  };
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index 9818dc1893c8..acc023795a4d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4167,6 +4167,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		nr_pages = nr;
>  		entry = folio->swap;
>  		page = &folio->page;
> +		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);

I don't think this is the point of no return yet? There's the pte_same() check
immediately below (although I've suggested that needs to be moved to earlier),
but also the folio_test_uptodate() check. Perhaps this should go after that?

>  	}
>  
>  check_pte:


