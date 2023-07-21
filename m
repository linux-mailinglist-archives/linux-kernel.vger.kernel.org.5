Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6729E75D526
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGUTiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGUTiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5972686;
        Fri, 21 Jul 2023 12:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C9961D91;
        Fri, 21 Jul 2023 19:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58870C433C8;
        Fri, 21 Jul 2023 19:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689968297;
        bh=vrWeO6d/WVUoBFUVjBSttPcQkFgnIMkGsqD8edgeIAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFDfk2oO14n3vGim7CN/Gix1y7oG04/CHCNAWSm6LbpwTZm6wPPxJjSb+vcNM85kz
         SxvzBXVYmAJiVs2zRhPW9P7sE1YGpyr2FWim0PBBVjXxtDXzpEYQ+aSEB5z226Kxqr
         6kz9U5OLBf5qGGrctna79TamcT9zCgGj3pmyUn7/+GxpEB5OObybUILS2RGZaG5to0
         5vljAZBJDqgkLhTM4RPjYcwuAps13MP3pJI+S5EvqwA7BERhaQyxyosjxeQpvnGbzT
         IsAiIbIYZsJs9cNpBxdETCKW4uUc+GncVMuZebxuJelWiCdYqZbn4ub3z89IPXHVOB
         YTR7BEuCLvzYg==
Received: (nullmailer pid 1688695 invoked by uid 1000);
        Fri, 21 Jul 2023 19:38:15 -0000
Date:   Fri, 21 Jul 2023 13:38:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Mike Rapoport <rppt@kernel.org>, devicetree@vger.kernel.org,
        x86@kernel.org, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mm,ima,kexec: use memblock_free_late from
 ima_free_kexec_buffer
Message-ID: <20230721193815.GA1679711-robh@kernel.org>
References: <20230720101431.71640c8a@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720101431.71640c8a@imladris.surriel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 10:14:31AM -0400, Rik van Riel wrote:
> The code calling ima_free_kexec_buffer runs long after the memblock
> allocator has already been torn down, potentially resulting in a use
> after free in memblock_isolate_range.
> 
> With KASAN or KFENCE, this use after free will result in a BUG
> from the idle task, and a subsequent kernel panic.
> 
> Switch ima_free_kexec_buffer over to memblock_free_late to avoid
> that issue.
> 
> Fixes: fee3ff99bc67 ("powerpc: Move arch independent ima kexec functions to drivers/of/kexec.c")

Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")

Acked-by: Rob Herring <robh@kernel.org>

(I'm assuming someone else is taking this)

> Cc: stable@kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Mike Rappoport <rppt@kernel.org>
> ---
>  arch/x86/kernel/setup.c | 8 ++------
>  drivers/of/kexec.c      | 3 ++-
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index fd975a4a5200..aa0df37c1fe7 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -359,15 +359,11 @@ static void __init add_early_ima_buffer(u64 phys_addr)
>  #if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
>  int __init ima_free_kexec_buffer(void)
>  {
> -	int rc;
> -
>  	if (!ima_kexec_buffer_size)
>  		return -ENOENT;
>  
> -	rc = memblock_phys_free(ima_kexec_buffer_phys,
> -				ima_kexec_buffer_size);
> -	if (rc)
> -		return rc;
> +	memblock_free_late(ima_kexec_buffer_phys,
> +			   ima_kexec_buffer_size);
>  
>  	ima_kexec_buffer_phys = 0;
>  	ima_kexec_buffer_size = 0;
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index f26d2ba8a371..68278340cecf 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -184,7 +184,8 @@ int __init ima_free_kexec_buffer(void)
>  	if (ret)
>  		return ret;
>  
> -	return memblock_phys_free(addr, size);
> +	memblock_free_late(addr, size);
> +	return 0;
>  }
>  #endif
>  
> -- 
> 2.41.0
> 
