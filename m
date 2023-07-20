Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D013E75A54A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGTFBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGTFBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:01:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691EB2122
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1B3B615B1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BEAC433C7;
        Thu, 20 Jul 2023 05:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689829271;
        bh=fS7HyRAzNtCEQx3osa1ecBKATZwAMKPT9YjrYfvPOnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJ+cQPG9w+4yoMDgmGRhX8w3l9hXb3C9LeP0AG7UI5l0XyMxerF7SkNS1tVJ7u1Od
         b2OGtLukQs58CIODl43C3V/VClONSU+XWJCfavEVpoXIAyWxj7lbcJERhx9mB+ZqQ0
         DHlQB8L0yea52OhwRbpTl7Jw+MdEIrX3T5o+mChINvtzBmxvT7SQGVEXem17ZNUYNi
         7iILekTwwduFHwuVtepPlEQwat9GBz5JFVQp23vWs6e3t1dMd7RV/aZW6WPoywo9vr
         /LGguxqa1RINXyQEEGt9A6IhzmiXv9dLdhM5Dg5OWkAJtO1cl6T+FdiPZHxUtnkECi
         lDNmDImWv4AlQ==
Date:   Thu, 20 Jul 2023 08:00:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm,memblock: reset memblock.reserved to system init
 state to  prevent UAF
Message-ID: <20230720050047.GL1901145@kernel.org>
References: <20230719154137.732d8525@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719154137.732d8525@imladris.surriel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ric,

On Wed, Jul 19, 2023 at 03:41:37PM -0400, Rik van Riel wrote:
> The memblock_discard function frees the memblock.reserved.regions
> array, which is good.
> 
> However, if a subsequent memblock_free (or memblock_phys_free) comes
> in later, from for example ima_free_kexec_buffer, that will result in
> a use after free bug in memblock_isolate_range.

The use of memblock_phys_free() in ima_free_kexec_buffer() is entirely
bogus and must be fixed. It should be memblock_free_late() there.
 
> When running a kernel with CONFIG_KASAN enabled, this will cause a
> kernel panic very early in boot. Without CONFIG_KASAN, there is
> a chance that memblock_isolate_range might scribble on memory
> that is now in use by somebody else.
 
This can't happen because memblock_double_array() uses kmalloc() as soon as
slab_is_available(), so this sentence is misleading.

> Avoid those issues by making sure that memblock_discard points
> memblock.reserved.regions back at the static buffer.
>
> If memblock_discard is called while there is still memory
> in the memblock.reserved type, that will print a warning
> in memblock_remove_region.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  mm/memblock.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3feafea06ab2..068289a46903 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -374,6 +374,10 @@ void __init memblock_discard(void)
>  			kfree(memblock.reserved.regions);
>  		else
>  			memblock_free_late(addr, size);
> +		/* Reset to prevent UAF from stray frees. */
> +		memblock.reserved.regions = memblock_reserved_init_regions;
> +		memblock.reserved.cnt = 1;
> +		memblock_remove_region(&memblock.reserved, 0);
>  	}
>  
>  	if (memblock.memory.regions != memblock_memory_init_regions) {
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
