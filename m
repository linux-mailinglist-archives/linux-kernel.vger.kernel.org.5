Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F070976CB7F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjHBLKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjHBLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:09:58 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA62102
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:09:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vout75S_1690974590;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vout75S_1690974590)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 19:09:51 +0800
Message-ID: <58c4cef1-ebba-6aa9-bdef-19470f7d2ce8@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 19:10:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/8] mm/compaction: avoid missing last page block in
 section after skip offline sections
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230802093741.2333325-1-shikemeng@huaweicloud.com>
 <20230802093741.2333325-2-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230802093741.2333325-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 5:37 PM, Kemeng Shi wrote:
> skip_offline_sections_reverse will return the last pfn in found online
> section. Then we set block_start_pfn to start of page block which
> contains the last pfn in section. Then we continue, move one page
> block forward and ignore the last page block in the online section.
> Make block_start_pfn point to first page block after online section to fix
> this:
> 1. make skip_offline_sections_reverse return end pfn of online section,
> i.e. pfn of page block after online section.
> 2. assign block_start_pfn with next_pfn.
> 
> Fixes: f63224525309 ("mm: compaction: skip the memory hole rapidly when isolating free pages")

The changes look good to me.
But the commit id is not stable, since it is not merged into mm-stable 
branch yet. Not sure how to handle this patch, squash it into the 
original patch? Andrew, what do you prefer?

> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index cd23da4d2a5b..a8cea916df9d 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -250,6 +250,11 @@ static unsigned long skip_offline_sections(unsigned long start_pfn)
>   	return 0;
>   }
>   
> +/*
> + * If the PFN falls into an offline section, return the end PFN of the
> + * next online section in reverse. If the PFN falls into an online section
> + * or if there is no next online section in reverse, return 0.
> + */
>   static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>   {
>   	unsigned long start_nr = pfn_to_section_nr(start_pfn);
> @@ -259,7 +264,7 @@ static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>   
>   	while (start_nr-- > 0) {
>   		if (online_section_nr(start_nr))
> -			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
> +			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION;
>   	}
>   
>   	return 0;
> @@ -1668,8 +1673,7 @@ static void isolate_freepages(struct compact_control *cc)
>   
>   			next_pfn = skip_offline_sections_reverse(block_start_pfn);
>   			if (next_pfn)
> -				block_start_pfn = max(pageblock_start_pfn(next_pfn),
> -						      low_pfn);
> +				block_start_pfn = max(next_pfn, low_pfn);
>   
>   			continue;
>   		}
