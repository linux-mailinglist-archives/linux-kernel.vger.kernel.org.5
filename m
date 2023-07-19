Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF9F758F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjGSHtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGSHtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:49:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A759AE43
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:48:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E4152F4;
        Wed, 19 Jul 2023 00:49:41 -0700 (PDT)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 758CE3F738;
        Wed, 19 Jul 2023 00:48:56 -0700 (PDT)
Message-ID: <397768bc-b861-1f6e-4c12-8fbbdff0900f@arm.com>
Date:   Wed, 19 Jul 2023 13:18:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/mm_init.c: drop node_start_pfn from
 adjust_zone_range_for_zone_movable()
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>, rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230717065811.1262-1-haifeng.xu@shopee.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230717065811.1262-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 12:28, Haifeng Xu wrote:
> node_start_pfn is not used in adjust_zone_range_for_zone_movable(), so
> it is pointless to waste a function argument. Drop the parameter.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/mm_init.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index a313d1828a6c..23d50541e1f7 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1105,7 +1105,6 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   */
>  static void __init adjust_zone_range_for_zone_movable(int nid,
>  					unsigned long zone_type,
> -					unsigned long node_start_pfn,
>  					unsigned long node_end_pfn,
>  					unsigned long *zone_start_pfn,
>  					unsigned long *zone_end_pfn)
> @@ -1222,9 +1221,8 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
>  	/* Get the start and end of the zone */
>  	*zone_start_pfn = clamp(node_start_pfn, zone_low, zone_high);
>  	*zone_end_pfn = clamp(node_end_pfn, zone_low, zone_high);
> -	adjust_zone_range_for_zone_movable(nid, zone_type,
> -				node_start_pfn, node_end_pfn,
> -				zone_start_pfn, zone_end_pfn);
> +	adjust_zone_range_for_zone_movable(nid, zone_type, node_end_pfn,
> +					   zone_start_pfn, zone_end_pfn);
>  
>  	/* Check that this node has pages within the zone's required range */
>  	if (*zone_end_pfn < node_start_pfn || *zone_start_pfn > node_end_pfn)
