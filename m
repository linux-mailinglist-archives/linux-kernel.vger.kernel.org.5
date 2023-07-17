Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30A17561C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGQLmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGQLmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F2610E5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E9B60F96
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D9FC433C8;
        Mon, 17 Jul 2023 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689594110;
        bh=yU4FuU9GBzJLKMMJ6YPMbnokCAVqtjh1LQe6xjck7Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIgz1i0y9VqdA/C3kMpx8OQuNt5OxBgyURL5YQzROLf1QOzDUuYgTP3snLU+RSKXG
         GE53TKjbVyFddsOPtolkhThfGN2uj4rE++6Oj4qxfa8uBpYNyo58e51S1dQ5jvQSR3
         Q2xiEvuNBf8JTpQpeFDyN+jt5SvpsSXs+X2SEEUw0UIFIT9q58/IncO0dOAJohhmku
         GzQwewcuyy+ng2oaabhneXNHYdfzfzrPIQgOZUfM1wuzo/eP/PIyZzkZyU7Mv3FmlY
         dgEfn5ZyL6K2fWaBKb/7d+7+gfidr0iY2NuGUJjLf2g2Q4HKQpiiKiGruaKH2+Jtp0
         jGGVe0e5AGfPw==
Date:   Mon, 17 Jul 2023 14:41:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: drop node_start_pfn from
 adjust_zone_range_for_zone_movable()
Message-ID: <20230717114133.GE1901145@kernel.org>
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
