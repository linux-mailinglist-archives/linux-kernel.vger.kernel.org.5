Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E459675C4C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGUKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjGUKgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975AB171B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3170D60C7B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1F3C433C7;
        Fri, 21 Jul 2023 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689935794;
        bh=d3RDQYHBiofoLtTOsVGd0+hDYbPOksiQmmPkI1vmf0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/UWsDU4VYCbs4LhUhJWB2TbtnSnTADPvw3/xdSxrWWYc5Ut5Kz0JBEQi501rF5rn
         Y5azfgrgwsSWJUNSm/tGZLMZBeeqhNYVZKOkaKBSv9GTlgyrWB24l//X2DK7XaEhCg
         udrRlLvqWmAG9oBEYFTQwpztGAbWcUkcpX3Jsxd5ta/lmAlDSS3worDmILpldn3Xko
         zsWZ2TzZYs1AGUQk74sSHZwVE6SZAkO5pAMlnoaumMDvefFn3MYhyE2KJxG2SzVOdA
         L0dKvaEZgcFneP70XGrWfgG0RXib7YeLcsBYKbTh+GmBEGXgAmvAYWFbzqDfp0u5tW
         S3PkKsigEKd+Q==
Date:   Fri, 21 Jul 2023 11:36:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        sudaraja@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        anshuman.khandual@arm.com
Subject: Re: [RFC PATCH] arm64: mm: Fix kernel page tables incorrectly
 deleted during memory removal
Message-ID: <20230721103628.GA12601@willie-the-truck>
References: <20230717115150.1806954-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717115150.1806954-1-mawupeng1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 07:51:50PM +0800, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> During our test, we found that kernel page table may be unexpectedly
> cleared with rodata off. The root cause is that the kernel page is
> initialized with pud size(1G block mapping) while offline is memory
> block size(MIN_MEMORY_BLOCK_SIZE 128M), eg, if 2G memory is hot-added,
> when offline a memory block, the call trace is shown below,
> 
>  offline_and_remove_memory
>     try_remove_memory
>       arch_remove_memory
>        __remove_pgd_mapping
>          unmap_hotplug_range
>            unmap_hotplug_p4d_range
>              unmap_hotplug_pud_range
>                if (pud_sect(pud))
>                  pud_clear(pudp);

Sorry, but I'm struggling to understand the problem here. If we're adding
and removing a 2G memory region, why _wouldn't_ we want to use large 1GiB
mappings? Or are you saying that only a subset of the memory is removed,
but we then accidentally unmap the whole thing?

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 95d360805f8a..44c724ce4f70 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -44,6 +44,7 @@
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
> +#define NO_PUD_MAPPINGS		BIT(3)
>  
>  int idmap_t0sz __ro_after_init;
>  
> @@ -344,7 +345,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  		 */
>  		if (pud_sect_supported() &&
>  		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> +		    (flags & (NO_BLOCK_MAPPINGS | NO_PUD_MAPPINGS)) == 0) {
>  			pud_set_huge(pudp, phys, prot);
>  
>  			/*
> @@ -1305,7 +1306,7 @@ struct range arch_get_mappable_range(void)
>  int arch_add_memory(int nid, u64 start, u64 size,
>  		    struct mhp_params *params)
>  {
> -	int ret, flags = NO_EXEC_MAPPINGS;
> +	int ret, flags = NO_EXEC_MAPPINGS | NO_PUD_MAPPINGS;

I think we should allow large mappings here and instead prevent partial
removal of the block, if that's what is causing the issue.

Will
