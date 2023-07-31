Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF1876956A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGaMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGaMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:00:53 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA95B5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:00:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vog4uW9_1690804847;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vog4uW9_1690804847)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 20:00:48 +0800
Message-ID: <6e76323f-a1cc-7d20-676e-4eccdbcf6b91@linux.alibaba.com>
Date:   Mon, 31 Jul 2023 20:01:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/8] mm/compaction: avoid missing last page block in
 section after skip offline sections
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-2-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230728171037.2219226-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/2023 1:10 AM, Kemeng Shi wrote:
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
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 9b7a0a69e19f..ce7841363b12 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -259,7 +259,7 @@ static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>   
>   	while (start_nr-- > 0) {
>   		if (online_section_nr(start_nr))
> -			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
> +			return section_nr_to_pfn(start_nr + 1);

This is incorrect, you returned the start pfn of this section.

>   	}
>   
>   	return 0;
> @@ -1670,8 +1670,7 @@ static void isolate_freepages(struct compact_control *cc)
>   
>   			next_pfn = skip_offline_sections_reverse(block_start_pfn);
>   			if (next_pfn)
> -				block_start_pfn = max(pageblock_start_pfn(next_pfn),
> -						      low_pfn);
> +				block_start_pfn = max(next_pfn, low_pfn);

'block_start_pfn' should be pageblock aligned. If the 'next_pfn' is not 
pageblock-aligned (though this is not the common case), we should skip it.

But if the 'next_pfn' is pageblock-aligned, yes, the commit f63224525309 
still ignores the last pageblock, which is not right. So I think it 
should be:
block_start_pfn = pageblock_aligned(next_pfn) ? : 
pageblock_start_pfn(next_pfn);
block_start_pfn = max(block_start_pfn, low_pfn);
