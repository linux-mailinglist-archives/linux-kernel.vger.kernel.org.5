Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C9F77C8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjHOHtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjHOHtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:49:14 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21767172A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:49:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vpr0xAs_1692085747;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vpr0xAs_1692085747)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 15:49:08 +0800
Message-ID: <26477981-5348-2da0-8bc8-c736d080a2f2@linux.alibaba.com>
Date:   Tue, 15 Aug 2023 15:49:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/9] mm/compaction: call list_is_{first}/{last} more
 intuitively in move_freelist_{head}/{tail}
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-3-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230805110711.2975149-3-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/2023 7:07 PM, Kemeng Shi wrote:
> We use move_freelist_head after list_for_each_entry_reverse to skip
> recent pages. And there is no need to do actual move if all freepages
> are searched in list_for_each_entry_reverse, e.g. freepage point to
> first page in freelist. It's more intuitively to call list_is_first
> with list entry as the first argument and list head as the second
> argument to check if list entry is the first list entry instead of
> call list_is_last with list entry and list head passed in reverse.
> 
> Similarly, call list_is_last in move_freelist_tail is more intuitively.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Make sense to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 513b1caeb4fa..fa1b100b0d10 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1395,7 +1395,7 @@ move_freelist_head(struct list_head *freelist, struct page *freepage)
>   {
>   	LIST_HEAD(sublist);
>   
> -	if (!list_is_last(freelist, &freepage->buddy_list)) {
> +	if (!list_is_first(&freepage->buddy_list, freelist)) {
>   		list_cut_before(&sublist, freelist, &freepage->buddy_list);
>   		list_splice_tail(&sublist, freelist);
>   	}
> @@ -1412,7 +1412,7 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
>   {
>   	LIST_HEAD(sublist);
>   
> -	if (!list_is_first(freelist, &freepage->buddy_list)) {
> +	if (!list_is_last(&freepage->buddy_list, freelist)) {
>   		list_cut_position(&sublist, freelist, &freepage->buddy_list);
>   		list_splice_tail(&sublist, freelist);
>   	}
