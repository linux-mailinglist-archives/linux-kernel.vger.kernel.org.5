Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF25B809F7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573441AbjLHJfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjLHJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:35:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70BA90
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:35:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA98DC433C7;
        Fri,  8 Dec 2023 09:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702028127;
        bh=2RDEVzmuLhz2tEm7RLeEBtH8w/GArNTHcFtmWcAE6Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gG6QeilFYtk+3SeDmXLLfGh0A6HyGUgUpd5hmq6w/s5pgLCQkrKjWgIfIQft4McJe
         WlmdLj9+Jyr32y6T3eHIiztaLmtMany7q4LdUdUKkXx15Wj2t7dMl0r4botTKelIps
         agKXjuKrN6tajgXFSssjAfmoQYh+YwfDvF5aiOWuqO90Q3FTihlyKfH4JgzTRgsd1g
         XTsH4MDMYn+gHG5dQlMZVP7pazHmBSfqdfMujoRoxYjbbjuiUgP9S1ul6VErL6gN5L
         qC2qdzHk2FxSKjo+o/OsGQtyoFgpro7bE2S+xvgse6zdAf1bYk4nM1ezKI0lD9HG1q
         Q0FYSd6sk04Ag==
Date:   Fri, 8 Dec 2023 11:35:16 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] memblock: Return NUMA_NO_NODE instead of -1 to improve
 code readability
Message-ID: <20231208093515.GN636165@kernel.org>
References: <20231207131001.224914-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207131001.224914-1-ytcoode@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:10:01PM +0800, Yuntao Wang wrote:
> When no corresponding memory region is found for the given pfn, return
> NUMA_NO_NODE instead of -1. This improves code readability and aligns with
> the existing logic of the memblock_search_pfn_nid() function's user.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>

Applied, thanks!

> ---
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5a88d6d24d79..c1f579c23396 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1851,7 +1851,7 @@ int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
>  	int mid = memblock_search(type, PFN_PHYS(pfn));
>  
>  	if (mid == -1)
> -		return -1;
> +		return NUMA_NO_NODE;
>  
>  	*start_pfn = PFN_DOWN(type->regions[mid].base);
>  	*end_pfn = PFN_DOWN(type->regions[mid].base + type->regions[mid].size);
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
