Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1676E392
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjHCIsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjHCIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:48:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A063EA;
        Thu,  3 Aug 2023 01:48:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1976121963;
        Thu,  3 Aug 2023 08:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691052520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hBbcrfPXGHM68Wuj3+6ufrfuN1l894aNWg5/t/rzUc=;
        b=BlREvVqy4q1sYcCDZ4YCCE7xdtk/rNcCD3GOas97X6g/DvZ4CUysjKQsFCHNn11lOgITRn
        GuL7Ba3IesEMtyElmsqS/Qdimu1a/duWfVaC5yi/osWFwdKaol581uSVRL3wQBkMX6Bgtn
        /xxI3iEgl5l4ls1qaQDI7PJFP0lyIGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691052520;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hBbcrfPXGHM68Wuj3+6ufrfuN1l894aNWg5/t/rzUc=;
        b=cWv1TM7WulkoU1ZH44WKmb+MF4rox4iZb4089/sKX9rLNqc/PvtLTtRyw/JXRrVOTJ8EIU
        xBdE5tnEW6AbR1Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECC9C134B0;
        Thu,  3 Aug 2023 08:48:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tXwYOedpy2SkXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Aug 2023 08:48:39 +0000
Message-ID: <d0b555a4-ed2e-3100-ae12-1b05f3035824@suse.cz>
Date:   Thu, 3 Aug 2023 10:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] parisc/mm: preallocate fixmap page tables at init
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Helge Deller <deller@gmx.de>
Cc:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230803062404.2373480-1-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230803062404.2373480-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 08:24, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Christoph Biedl reported early OOM on recent kernels:
> 
>     swapper: page allocation failure: order:0, mode:0x100(__GFP_ZERO),
> nodemask=(null)
>     CPU: 0 PID: 0 Comm: swapper Not tainted 6.3.0-rc4+ #16
>     Hardware name: 9000/785/C3600
>     Backtrace:
>      [<10408594>] show_stack+0x48/0x5c
>      [<10e152d8>] dump_stack_lvl+0x48/0x64
>      [<10e15318>] dump_stack+0x24/0x34
>      [<105cf7f8>] warn_alloc+0x10c/0x1c8
>      [<105d068c>] __alloc_pages+0xbbc/0xcf8
>      [<105d0e4c>] __get_free_pages+0x28/0x78
>      [<105ad10c>] __pte_alloc_kernel+0x30/0x98
>      [<10406934>] set_fixmap+0xec/0xf4
>      [<10411ad4>] patch_map.constprop.0+0xa8/0xdc
>      [<10411bb0>] __patch_text_multiple+0xa8/0x208
>      [<10411d78>] patch_text+0x30/0x48
>      [<1041246c>] arch_jump_label_transform+0x90/0xcc
>      [<1056f734>] jump_label_update+0xd4/0x184
>      [<1056fc9c>] static_key_enable_cpuslocked+0xc0/0x110
>      [<1056fd08>] static_key_enable+0x1c/0x2c
>      [<1011362c>] init_mem_debugging_and_hardening+0xdc/0xf8
>      [<1010141c>] start_kernel+0x5f0/0xa98
>      [<10105da8>] start_parisc+0xb8/0xe4
> 
>     Mem-Info:
>     active_anon:0 inactive_anon:0 isolated_anon:0
>      active_file:0 inactive_file:0 isolated_file:0
>      unevictable:0 dirty:0 writeback:0
>      slab_reclaimable:0 slab_unreclaimable:0
>      mapped:0 shmem:0 pagetables:0
>      sec_pagetables:0 bounce:0
>      kernel_misc_reclaimable:0
>      free:0 free_pcp:0 free_cma:0
>     Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB
> inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
> mapped:0kB dirty:0kB writeback:0kB shmem:0kB
> +writeback_tmp:0kB kernel_stack:0kB pagetables:0kB sec_pagetables:0kB
> all_unreclaimable? no
>     Normal free:0kB boost:0kB min:0kB low:0kB high:0kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB
> inactive_file:0kB unevictable:0kB writepending:0kB
> +present:1048576kB managed:1039360kB mlocked:0kB bounce:0kB free_pcp:0kB
> local_pcp:0kB free_cma:0kB
>     lowmem_reserve[]: 0 0
>     Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB
> 0*1024kB 0*2048kB 0*4096kB = 0kB
>     0 total pagecache pages
>     0 pages in swap cache
>     Free swap  = 0kB
>     Total swap = 0kB
>     262144 pages RAM
>     0 pages HighMem/MovableOnly
>     2304 pages reserved
>     Backtrace:
>      [<10411d78>] patch_text+0x30/0x48
>      [<1041246c>] arch_jump_label_transform+0x90/0xcc
>      [<1056f734>] jump_label_update+0xd4/0x184
>      [<1056fc9c>] static_key_enable_cpuslocked+0xc0/0x110
>      [<1056fd08>] static_key_enable+0x1c/0x2c
>      [<1011362c>] init_mem_debugging_and_hardening+0xdc/0xf8
>      [<1010141c>] start_kernel+0x5f0/0xa98
>      [<10105da8>] start_parisc+0xb8/0xe4
> 
>     Kernel Fault: Code=15 (Data TLB miss fault) at addr 0f7fe3c0
>     CPU: 0 PID: 0 Comm: swapper Not tainted 6.3.0-rc4+ #16
>     Hardware name: 9000/785/C3600
> 
> This happens because patching static key code temporarily maps it via
> fixmap and if it happens before page allocator is initialized set_fixmap()
> cannot allocate memory using pte_alloc_kernel().
> 
> Make sure that fixmap page tables are preallocated early so that
> pte_offset_kernel() in set_fixmap() never resorts to pte allocation.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks, Mike!

> ---
> 
> I didn't add Fixes tag with the commit Christoph bisected because that
> commit didn't change anything in the initialization of the static keys
> and I really doubt it is the actual cause of the issue.

Yeah I also don't see how the commit could cause a static key initialization
to happen sooner than it already has.
But if it's manifesting for whatever reason since 6.4 then a "Cc: stable #
6.4+" would be in order.

> 
>  arch/parisc/mm/fixmap.c |  3 ---
>  arch/parisc/mm/init.c   | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/parisc/mm/fixmap.c b/arch/parisc/mm/fixmap.c
> index cc15d737fda6..ae3493dae9dc 100644
> --- a/arch/parisc/mm/fixmap.c
> +++ b/arch/parisc/mm/fixmap.c
> @@ -19,9 +19,6 @@ void notrace set_fixmap(enum fixed_addresses idx, phys_addr_t phys)
>  	pmd_t *pmd = pmd_offset(pud, vaddr);
>  	pte_t *pte;
>  
> -	if (pmd_none(*pmd))
> -		pte = pte_alloc_kernel(pmd, vaddr);
> -
>  	pte = pte_offset_kernel(pmd, vaddr);
>  	set_pte_at(&init_mm, vaddr, pte, __mk_pte(phys, PAGE_KERNEL_RWX));
>  	flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
> index 406c52fe23d5..389941c7f209 100644
> --- a/arch/parisc/mm/init.c
> +++ b/arch/parisc/mm/init.c
> @@ -669,6 +669,39 @@ static void __init gateway_init(void)
>  		  PAGE_SIZE, PAGE_GATEWAY, 1);
>  }
>  
> +static void __init fixmap_init(void)
> +{
> +	unsigned long addr = FIXMAP_START;
> +	unsigned long end = FIXMAP_START + FIXMAP_SIZE;
> +	pgd_t *pgd = pgd_offset_k(addr);
> +	p4d_t *p4d = p4d_offset(pgd, addr);
> +	pud_t *pud = pud_offset(p4d, addr);
> +	pmd_t *pmd;
> +
> +	BUILD_BUG_ON(FIXMAP_SIZE > PMD_SIZE);
> +
> +#if CONFIG_PGTABLE_LEVELS == 3
> +	if (pud_none(*pud)) {
> +		pmd = memblock_alloc(PAGE_SIZE << PMD_TABLE_ORDER,
> +				     PAGE_SIZE << PMD_TABLE_ORDER);
> +		if (!pmd)
> +			panic("fixmap: pmd allocation failed.\n");
> +		pud_populate(NULL, pud, pmd);
> +	}
> +#endif
> +
> +	pmd = pmd_offset(pud, addr);
> +	do {
> +		pte_t *pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +		if (!pte)
> +			panic("fixmap: pte allocation failed.\n");
> +
> +		pmd_populate_kernel(&init_mm, pmd, pte);
> +
> +		addr += PAGE_SIZE;
> +	} while (addr < end);
> +}
> +
>  static void __init parisc_bootmem_free(void)
>  {
>  	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0, };
> @@ -683,6 +716,7 @@ void __init paging_init(void)
>  	setup_bootmem();
>  	pagetable_init();
>  	gateway_init();
> +	fixmap_init();
>  	flush_cache_all_local(); /* start with known state */
>  	flush_tlb_all_local(NULL);
>  
> 
> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4

