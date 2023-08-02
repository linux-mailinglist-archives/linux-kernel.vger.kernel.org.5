Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9B476CBC9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjHBLbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjHBLbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:31:13 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF1212D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:31:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VoutDZH_1690975867;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VoutDZH_1690975867)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 19:31:07 +0800
Message-ID: <318912b8-b8dd-2e64-ca2a-cdb80551b2aa@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 19:31:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/8] mm/compaction: correct comment of
 fast_find_migrateblock in isolate_migratepages
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230802093741.2333325-1-shikemeng@huaweicloud.com>
 <20230802093741.2333325-5-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230802093741.2333325-5-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 5:37 PM, Kemeng Shi wrote:
> After 90ed667c03fe5 ("Revert "Revert "mm/compaction: fix set skip in
> fast_find_migrateblock"""), we remove skip set in fast_find_migrateblock.
> Correct comment that fast_find_block is used to avoid isolation_suitable
> check for pageblock returned from fast_find_migrateblock because
> fast_find_migrateblock will mark found pageblock skipped.
> Instead, comment that fast_find_block is used to avoid a redundant check
> of fast found pageblock which is already checked skip flag inside
> fast_find_migrateblock.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 984c17a5c8fd..5c9dc4049e8e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1966,8 +1966,8 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>   		block_start_pfn = cc->zone->zone_start_pfn;
>   
>   	/*
> -	 * fast_find_migrateblock marks a pageblock skipped so to avoid
> -	 * the isolation_suitable check below, check whether the fast
> +	 * fast_find_migrateblock will ignore pageblock skipped, so to avoid

These seem confusing to me, since the fast_find_migrateblock() did not 
ignore the skip flag checking. So how about below words?

"fast_find_migrateblock() has already ensured the pageblock is not set 
with a skipped flag, so to avoid the isolation_suitable check below 
again ..."

> +	 * the isolation_suitable check below again, check whether the fast
>   	 * search was successful.
>   	 */
>   	fast_find_block = low_pfn != cc->migrate_pfn && !cc->fast_search_fail;
