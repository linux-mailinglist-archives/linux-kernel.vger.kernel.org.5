Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3F75B420
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjGTQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGTQZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFCF9E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7844861A6D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3442C433CD;
        Thu, 20 Jul 2023 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689870346;
        bh=e2loJuE/ZqGkDkAvmTjMFKYb1nNFlu5Zk7Uq4LKqs3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3aC6zTL+n3FzJVGA/KDjcpv5j9Cuw7yM8SijVK45May6Dy/gYCHzCkgQUrLoNL0N
         75GyriGucZM+2PJSJ4U8/C535c5T/RdNo0MsKYUoGD8fs5v0a79M7aN3MYP3fl3FWf
         PQ6WY/ediXDPQksW6rcqLv/XBSywTgj18AqBwQwVjiByVxuZiHRXjndGRDtHyVDfy6
         O1ceM8q4TKDFQkXJ1D9E0wbwD+t4bKZqqtUWTZAZhND8G5wJ3duYhy2WYR4o7kds4H
         RSlHZuPHuRWDozx8FEiMwAd7WawvsR+sfoVUppFFCGGOi+SHg+b8bg1IKI4cGUT9DA
         UQQxwfXv/WpTA==
Date:   Thu, 20 Jul 2023 19:25:22 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm,memblock: reset memblock.reserved to system init
 state to  prevent UAF
Message-ID: <20230720162522.GO1901145@kernel.org>
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

On Wed, Jul 19, 2023 at 03:41:37PM -0400, Rik van Riel wrote:
> The memblock_discard function frees the memblock.reserved.regions
> array, which is good.
> 
> However, if a subsequent memblock_free (or memblock_phys_free) comes
> in later, from for example ima_free_kexec_buffer, that will result in
> a use after free bug in memblock_isolate_range.
> 
> When running a kernel with CONFIG_KASAN enabled, this will cause a
> kernel panic very early in boot. Without CONFIG_KASAN, there is
> a chance that memblock_isolate_range might scribble on memory
> that is now in use by somebody else.
> 
> Avoid those issues by making sure that memblock_discard points
> memblock.reserved.regions back at the static buffer.
> 
> If memblock_discard is called while there is still memory
> in the memblock.reserved type, that will print a warning
> in memblock_remove_region.

I'm going to apply this with the last paragraph rewritten as 

If memblock_free is called after memblock memory is discarded, that will
print a warning in memblock_remove_region.
 
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
