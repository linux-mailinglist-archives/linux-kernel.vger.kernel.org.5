Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D5807E21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjLGB4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjLGB4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:56:43 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58E6B9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:56:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VxzqEAE_1701914205;
Received: from 30.97.48.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VxzqEAE_1701914205)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 09:56:46 +0800
Message-ID: <3d1ff4c8-5163-41fd-be12-34545c3556ec@linux.alibaba.com>
Date:   Thu, 7 Dec 2023 09:57:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: compaction: avoid fast_isolate_freepages blindly
 choose improper pageblock
To:     Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     david@redhat.com, hannes@cmpxchg.org, huzhanyuan@oppo.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        shikemeng@huaweicloud.com, v-songbaohua@oppo.com,
        willy@infradead.org
References: <20231206110054.61617-1-v-songbaohua@oppo.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231206110054.61617-1-v-songbaohua@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/2023 7:00 PM, Barry Song wrote:
> Testing shows fast_isolate_freepages can blindly choose an unsuitable
> pageblock from time to time particularly while the min mark is used
> from XXX path:
>   if (!page) {
>           cc->fast_search_fail++;
>           if (scan_start) {
>                   /*
>                    * Use the highest PFN found above min. If one was
>                    * not found, be pessimistic for direct compaction
>                    * and use the min mark.
>                    */
>                   if (highest >= min_pfn) {
>                           page = pfn_to_page(highest);
>                           cc->free_pfn = highest;
>                   } else {
>                           if (cc->direct_compaction && pfn_valid(min_pfn)) { /* XXX */
>                                   page = pageblock_pfn_to_page(min_pfn,
>                                           min(pageblock_end_pfn(min_pfn),
>                                               zone_end_pfn(cc->zone)),
>                                           cc->zone);
>                                   cc->free_pfn = min_pfn;
>                           }
>                   }
>           }
>   }
> 
> The reason is that no code is doing any check on the min_pfn
>   min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));
> 
> In contrast, slow path of isolate_freepages() is always skipping unsuitable
> pageblocks in a decent way.
> 
> This issue doesn't happen quite often. When running 25 machines with 16GiB
> memory for one night, most of them can hit this unexpected code path.
> However the frequency isn't like many times per second. It might be one
> time in a couple of hours. Thus, it is very hard to measure the visible
> performance impact in my machines though the affection of choosing the
> unsuitable migration_target should be negative in theory.
> 
> I feel it's still worth fixing this to at least make the code theoretically
> self-explanatory as it is quite odd an unsuitable migration_target can be
> still migration_target.
> 
> Reported-by: Zhanyuan Hu <huzhanyuan@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   v1:
>      move the fix to the specific min_pfn path with respect to Baolin's comment
>   rfc:
>      https://lore.kernel.org/linux-mm/20231129104530.63787-1-v-songbaohua@oppo.com/#t
> 
>   mm/compaction.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 01ba298739dd..de15a2ef0af5 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1611,6 +1611,9 @@ static void fast_isolate_freepages(struct compact_control *cc)
>   						min(pageblock_end_pfn(min_pfn),
>   						    zone_end_pfn(cc->zone)),
>   						cc->zone);
> +					if (page && !suitable_migration_target(cc, page))
> +						page = NULL;
> +
>   					cc->free_pfn = min_pfn;
>   				}
>   			}
