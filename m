Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CE1788247
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbjHYIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243752AbjHYIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:38:36 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB542114;
        Fri, 25 Aug 2023 01:38:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VqWSqxp_1692952701;
Received: from 30.178.80.74(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VqWSqxp_1692952701)
          by smtp.aliyun-inc.com;
          Fri, 25 Aug 2023 16:38:23 +0800
Message-ID: <cc5a3029-3698-1310-519a-c545f7e515b7@linux.alibaba.com>
Date:   Fri, 25 Aug 2023 16:38:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] mm/khugepaged: increase
 transparent_hugepage_recommend_disable parameter to disable active
 modification of min_free_kbytes
To:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, rostedt@goodmis.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230817035155.84230-1-liusong@linux.alibaba.com>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20230817035155.84230-1-liusong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Any suggestions for this patch? Indeed, too much memory is being 
reserved for the 64K PAGESIZE scenario. Looking forward to everyone's 
suggestions.

Thanks

在 2023/8/17 11:51, Liu Song 写道:
> In the arm64 environment, when PAGESIZE is 4K, the "pageblock_nr_pages"
> value is 512, and the recommended min_free_kbytes in
> "set_recommended_min_free_kbytes" usually does not exceed 44MB.
>
> However, when PAGESIZE is 64K, the "pageblock_nr_pages" value is 8192,
> and the recommended min_free_kbytes in "set_recommended_min_free_kbytes"
> is 8192 * 2 * (2 + 9) * 64K, which directly increases to 11GB.
>
> According to this calculation method, due to the modification of min_free_kbytes,
> the reserved memory in my 128GB memory environment reaches 10GB, and MemAvailable
> is correspondingly reduced by 10GB.
>
> In the case of PAGESIZE 64K, transparent hugepages are 512MB, and we only
> need them to be used on demand. If transparent hugepages cannot be allocated,
> falling back to regular 64K pages is completely acceptable.
>
> Therefore, we added the transparent_hugepage_recommend_disable parameter
> to disable active modification of min_free_kbytes, thereby meeting our
> requirements for transparent hugepages in the 64K scenario, and it will
> not excessively reduce the available memory.
>
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  5 +++++
>   mm/khugepaged.c                               | 20 ++++++++++++++++++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 654d0d921101..612bdf601cce 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6553,6 +6553,11 @@
>   			See Documentation/admin-guide/mm/transhuge.rst
>   			for more details.
>   
> +	transparent_hugepage_recommend_disable
> +			[KNL,THP]
> +			Can be used to disable transparent hugepage to actively modify
> +			/proc/sys/vm/min_free_kbytes during enablement process.
> +
>   	trusted.source=	[KEYS]
>   			Format: <string>
>   			This parameter identifies the trust source as a backend
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 78fc1a24a1cc..ac40c618f4f6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -88,6 +88,9 @@ static unsigned int khugepaged_max_ptes_none __read_mostly;
>   static unsigned int khugepaged_max_ptes_swap __read_mostly;
>   static unsigned int khugepaged_max_ptes_shared __read_mostly;
>   
> +/* default enable recommended */
> +static unsigned int transparent_hugepage_recommend __read_mostly = 1;
> +
>   #define MM_SLOTS_HASH_BITS 10
>   static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>   
> @@ -2561,6 +2564,11 @@ static void set_recommended_min_free_kbytes(void)
>   		goto update_wmarks;
>   	}
>   
> +	if (!transparent_hugepage_recommend) {
> +		pr_info("do not allow to recommend modify min_free_kbytes\n");
> +		return;
> +	}
> +
>   	for_each_populated_zone(zone) {
>   		/*
>   		 * We don't need to worry about fragmentation of
> @@ -2591,7 +2599,10 @@ static void set_recommended_min_free_kbytes(void)
>   
>   	if (recommended_min > min_free_kbytes) {
>   		if (user_min_free_kbytes >= 0)
> -			pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
> +			pr_info("raising user specified min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
> +				min_free_kbytes, recommended_min);
> +		else
> +			pr_info("raising default min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
>   				min_free_kbytes, recommended_min);
>   
>   		min_free_kbytes = recommended_min;
> @@ -2601,6 +2612,13 @@ static void set_recommended_min_free_kbytes(void)
>   	setup_per_zone_wmarks();
>   }
>   
> +static int __init setup_transparent_hugepage_recommend_disable(char *str)
> +{
> +	transparent_hugepage_recommend = 0;
> +	return 1;
> +}
> +__setup("transparent_hugepage_recommend_disable", setup_transparent_hugepage_recommend_disable);
> +
>   int start_stop_khugepaged(void)
>   {
>   	int err = 0;
