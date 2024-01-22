Return-Path: <linux-kernel+bounces-32405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E21A835B54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF951C2118F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2599F500;
	Mon, 22 Jan 2024 06:59:00 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8FF4F5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906740; cv=none; b=gpKXbGhLM3zLYBGzK0aEkNT3MiikdplFtewu37MIa9KgeMTkHDBZaX68LmXpeW+nJrwGy3c/Em5xJtgWxaTq87lEAPFzFINQ7+8WOMZ8haFTLAFQiSQ31usHRi3PdJjFjU+rtJPuGW953ROZbR770seQlj8ibQhHdBRr+317/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906740; c=relaxed/simple;
	bh=9Gpr5J/URHQx8HuStmmIo9rY5v1KXaEpYa2XKURSP7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkhAW6mqI74zqj5YFoLnwV1Y+NhSfQ+hWbXFcFIEB9h5ymR8db1EzBg9zM4MnZLcXWgZfMvV6cRALAuM1YVuLOmktjbO36ffdA7fC1AxmenLxEz5TP2XhjT+NxLuH4q3JtnUfbZjDXu5QE/rfPbgmUialW3Jp40pJ7vciZQI1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W.3HVKO_1705906727;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W.3HVKO_1705906727)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 14:58:48 +0800
Message-ID: <8583a965-82ae-42fe-b22a-e84ddda11ae5@linux.alibaba.com>
Date: Mon, 22 Jan 2024 14:59:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/compaction: add check mechanism to avoid cma alloc
 fail
To: Haiqiang Gong <Haiqiang.Gong@mediatek.com>, linux-kernel@vger.kernel.org
Cc: mike.zhang@mediatek.com, Andrew Morton <akpm@linux-foundation.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240122022317.30091-1-Haiqiang.Gong@mediatek.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240122022317.30091-1-Haiqiang.Gong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/22/2024 10:23 AM, Haiqiang Gong wrote:
> cma alloc may fail when we doing cma alloc/free test on kernel 5.10/5.15.

Do you have a real use case for the cma alloc issue? And have you tried 
it on the new kernel?

> We found that the next memory cannot be migrated because of the alloc of
> fs as next backtrace:
> __alloc_pages_nodemask
> pagecache_get_page
> grow_dev_page
> __getblk_gfp
> ext4_sb_breadahead_unmovable
> __ext4_get_inode_loc
> __ext4_iget
> ext4_lookup
> __lookup_slow
> walk_component
> path_lookupat
> filename_lookup
> vfs_statx
> This kind of unmovable memory is not placed in the cma buffer when kernel
> memory alloc but is migrated in by kcompactd when the kernel migration.
> It will cause memory can't be migrate when cma alloc.

Why the CMA memory can not be migrated? Could you describe in more 
detail the reasons for the CMA memory migration failure?

> Add check mechanism in the compaction_alloc() where kcompaced alloc for
> memory. Will return NULL and give up this memory migration if the
> allocated memory is in the cma buffer and the memory is unmovable.
> 
> Signed-off-by: Haiqiang Gong <Haiqiang.Gong@mediatek.com>
> ---
>   mm/compaction.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 27ada42924d5..29c0661adc22 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -25,6 +25,11 @@
>   #include <linux/psi.h>
>   #include "internal.h"
>   
> +#ifdef CONFIG_CMA
> +#include <linux/cma.h>
> +#include "cma.h"
> +#endif
> +
>   #ifdef CONFIG_COMPACTION
>   /*
>    * Fragmentation score check interval for proactive compaction purposes.
> @@ -1758,6 +1763,33 @@ static void isolate_freepages(struct compact_control *cc)
>   	split_map_pages(freelist);
>   }
>   
> +#ifdef CONFIG_CMA
> +static bool is_in_cma_range(struct folio *folio)
> +{
> +	int i;
> +	unsigned long pfn = 0;
> +	struct page *page = folio_page(folio, 0);
> +
> +	pfn = page_to_pfn(page);
> +	for (i = 0; i < cma_area_count; i++) {
> +		struct cma *cma = &cma_areas[i];
> +
> +		if (cma->base_pfn <= pfn && (cma->base_pfn + cma->count) > pfn)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool forbid_move_to_cma_range(struct folio *src, struct folio *dst)
> +{
> +	if (folio_mapping(src) && is_in_cma_range(dst))
> +		return true;
> +
> +	return false;
> +}
> +#endif
> +
>   /*
>    * This is a migrate-callback that "allocates" freepages by taking pages
>    * from the isolated freelists in the block we are migrating to.
> @@ -1775,6 +1807,12 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>   	}
>   
>   	dst = list_entry(cc->freepages.next, struct folio, lru);
> +#ifdef CONFIG_CMA
> +	if (forbid_move_to_cma_range(src, dst)) {
> +		pr_notice("kcompactd: could not move non-cma memory to cma buffer\n");
> +		return NULL;
> +	}
> +#endif
>   	list_del(&dst->lru);
>   	cc->nr_freepages--;
>   

