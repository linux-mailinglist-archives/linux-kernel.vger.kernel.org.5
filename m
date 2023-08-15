Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3A77C86E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjHOHRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjHOHQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:16:58 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3634110F0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:16:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VpqlvxU_1692083811;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpqlvxU_1692083811)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 15:16:52 +0800
Message-ID: <1921eae9-f428-e36c-6ee0-60872d5a340e@linux.alibaba.com>
Date:   Tue, 15 Aug 2023 15:16:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/9] mm/compaction: use correct list in
 move_freelist_{head}/{tail}
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-2-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230805110711.2975149-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/2023 7:07 PM, Kemeng Shi wrote:
> The freepage is chained with buddy_list in freelist head. Use buddy_list
> instead of lru to correct the list operation.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index ea61922a1619..513b1caeb4fa 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1395,8 +1395,8 @@ move_freelist_head(struct list_head *freelist, struct page *freepage)
>   {
>   	LIST_HEAD(sublist);
>   
> -	if (!list_is_last(freelist, &freepage->lru)) {
> -		list_cut_before(&sublist, freelist, &freepage->lru);
> +	if (!list_is_last(freelist, &freepage->buddy_list)) {
> +		list_cut_before(&sublist, freelist, &freepage->buddy_list);
>   		list_splice_tail(&sublist, freelist);
>   	}
>   }
> @@ -1412,8 +1412,8 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
>   {
>   	LIST_HEAD(sublist);
>   
> -	if (!list_is_first(freelist, &freepage->lru)) {
> -		list_cut_position(&sublist, freelist, &freepage->lru);
> +	if (!list_is_first(freelist, &freepage->buddy_list)) {
> +		list_cut_position(&sublist, freelist, &freepage->buddy_list);
>   		list_splice_tail(&sublist, freelist);
>   	}
>   }
