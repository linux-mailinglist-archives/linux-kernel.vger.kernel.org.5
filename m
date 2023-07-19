Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA70758CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 06:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGSEcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 00:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGSEcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5F41B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9409E60C37
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17576C433C8;
        Wed, 19 Jul 2023 04:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689741159;
        bh=yU4FuU9GBzJLKMMJ6YPMbnokCAVqtjh1LQe6xjck7Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXMpg8BbhJZJNkpHSPLHr1qjWo5E4zGZfD5bHPWtIg/l2IeZ57hgDzj44YOHivqZG
         AS0MuLpTF7gFAwMDxhTP0wq2ZUexx34z7lJUYYP7q7TGtsA2UBl/l/92sxdgi/7L7e
         Yz20BMiMcSCvwSg9FqRVOzMMs5SqCYdCvtg+cj2/CNrExK/BzkoFXxMjs6S8tRICQA
         HvR2ElBn+SOBXOXfpbChVH6AY8RX0N7hToZKNj92DBMFp+UI3qn96vq6CnrqFbQBAU
         GHUePA8+GH7wYnA2mIbdIavTA7+38AwRVLGr+hOL1g4zl9aQTIfq5rDM9xENyPoPF+
         xnILTX+hjNBsw==
Date:   Wed, 19 Jul 2023 07:32:18 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: drop node_start_pfn from
 adjust_zone_range_for_zone_movable()
Message-ID: <20230719043218.GF1901145@kernel.org>
References: <20230717065811.1262-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717065811.1262-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:58:11AM +0000, Haifeng Xu wrote:
> node_start_pfn is not used in adjust_zone_range_for_zone_movable(), so
> it is pointless to waste a function argument. Drop the parameter.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
