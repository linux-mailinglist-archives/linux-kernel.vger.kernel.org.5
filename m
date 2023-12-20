Return-Path: <linux-kernel+bounces-6646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82AB819B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009731C22258
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BA1F602;
	Wed, 20 Dec 2023 09:43:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A51F5E4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VyttMeo_1703065374;
Received: from 30.97.48.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VyttMeo_1703065374)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 17:42:55 +0800
Message-ID: <7ec7bbfd-41db-4a62-b58a-315ad244c0aa@linux.alibaba.com>
Date: Wed, 20 Dec 2023 17:43:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: page_alloc: remove duplication of free_one_page()
To: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: casper.li@mediatek.com, chinwen.chang@mediatek.com,
 qun-wei.lin@mediatek.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231220074757.3656-1-Kuan-Ying.Lee@mediatek.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231220074757.3656-1-Kuan-Ying.Lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/20/2023 3:47 PM, Kuan-Ying Lee wrote:
> Remove duplication of free_one_page().
> 
> Cc: Casper Li <casper.li@mediatek.com>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

Just FYI:
There is already a same patch submitted, see: 
https://lore.kernel.org/all/20231216030503.2126130-1-yajun.deng@linux.dev/T/#u

> ---
>   mm/page_alloc.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2f646773a934..f46af8616cac 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1262,7 +1262,6 @@ static void free_one_page(struct zone *zone,
>   static void __free_pages_ok(struct page *page, unsigned int order,
>   			    fpi_t fpi_flags)
>   {
> -	unsigned long flags;
>   	int migratetype;
>   	unsigned long pfn = page_to_pfn(page);
>   	struct zone *zone = page_zone(page);
> @@ -1277,13 +1276,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
>   	 */
>   	migratetype = get_pfnblock_migratetype(page, pfn);
>   
> -	spin_lock_irqsave(&zone->lock, flags);
> -	if (unlikely(has_isolate_pageblock(zone) ||
> -		is_migrate_isolate(migratetype))) {
> -		migratetype = get_pfnblock_migratetype(page, pfn);
> -	}
> -	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
> -	spin_unlock_irqrestore(&zone->lock, flags);
> +	free_one_page(zone, page, pfn, order, migratetype, fpi_flags);
>   
>   	__count_vm_events(PGFREE, 1 << order);
>   }

