Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D6B760871
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjGYE1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjGYEZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:25:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 345061BD2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:22:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54ECFFEC;
        Mon, 24 Jul 2023 21:23:07 -0700 (PDT)
Received: from [10.163.51.115] (unknown [10.163.51.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12AB43F67D;
        Mon, 24 Jul 2023 21:22:20 -0700 (PDT)
Message-ID: <4938685e-d293-4970-b964-3b9f560d45dd@arm.com>
Date:   Tue, 25 Jul 2023 09:52:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next v2] arm64: fix build warning for
 ARM64_MEMSTART_SHIFT
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Zhang Jianhua <chris.zjh@huawei.com>
Cc:     will@kernel.org, ryan.roberts@arm.com, joey.gouly@arm.com,
        ardb@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230724172751.3048501-1-chris.zjh@huawei.com>
 <ZL6UvLlyz3MyVfjr@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZL6UvLlyz3MyVfjr@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 20:41, Catalin Marinas wrote:
> On Mon, Jul 24, 2023 at 05:27:51PM +0000, Zhang Jianhua wrote:
>> When building with W=1, the following warning occurs.
>>
>> arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
>>   129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
>>       |                                         ^~~~~~~~~
>> arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
>>   142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
>>       |     ^~~~~~~~~~~~~~~~~~~~
> 
> Another thing that's missing here is that the warning is probably when
> this file is included from asm-offests.h or some .S file.
> 
>> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
>> index 577773870b66..51bdce66885d 100644
>> --- a/arch/arm64/include/asm/kernel-pgtable.h
>> +++ b/arch/arm64/include/asm/kernel-pgtable.h
>> @@ -125,12 +125,14 @@
>>   * (64k granule), or a multiple that can be mapped using contiguous bits
>>   * in the page tables: 32 * PMD_SIZE (16k granule)
>>   */
>> -#if defined(CONFIG_ARM64_4K_PAGES)
>> +#if defined(CONFIG_ARM64_4K_PAGES) && defined(PUD_SHIFT)
>>  #define ARM64_MEMSTART_SHIFT		PUD_SHIFT
> 
> That's not the correct fix since PUD_SHIFT should always be defined.
> When CONFIG_PGTABLE_LEVELS == 3, pgtable-types.h includes
> asm-generic/pgtable-nopud.h and this defines PUD_SHIFT. We either got

Right, PUD_SHIFT is always defined irrespective of page table levels.

> ARM64_MEMSTART_SHIFT defined in the wrong file or kernel-pgtable.h does
> not pull the relevant headers (either directly or via an included
> header). Even if kernel-pgtable.h ends up including the nopud/nopmd
> headers, P*D_SHIFT is guarded by an #indef __ASSEMBLY__ in those files.
> 
> Something like below appears to fix this, though I'm not particularly
> fond of guarding the ARM64_MEMSTART_* definitions by #ifndef
> __ASSEMBLY__ for no apparent reason (could add a comment though):
> 
> -----------------------8<---------------------------
> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index 577773870b66..fcea7e87a6ca 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -118,6 +118,8 @@
>  #define SWAPPER_RX_MMUFLAGS	(SWAPPER_RW_MMUFLAGS | PTE_RDONLY)
>  #endif
>  
> +#ifndef __ASSEMBLY__
> +
>  /*
>   * To make optimal use of block mappings when laying out the linear
>   * mapping, round down the base of physical memory to a size that can
> @@ -145,4 +147,6 @@
>  #define ARM64_MEMSTART_ALIGN	(1UL << ARM64_MEMSTART_SHIFT)
>  #endif
>  
> +#endif /* __ASSEMBLY__ */
> +
>  #endif	/* __ASM_KERNEL_PGTABLE_H */
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index e4944d517c99..22b36f2d5d93 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -6,6 +6,7 @@
>  #define __ASM_PGTABLE_HWDEF_H
>  
>  #include <asm/memory.h>
> +#include <asm/pgtable-types.h>
>  
>  /*
>   * Number of page-table levels required to address 'va_bits' wide
> diff --git a/arch/arm64/include/asm/pgtable-types.h b/arch/arm64/include/asm/pgtable-types.h
> index b8f158ae2527..ae86e66fdb11 100644
> --- a/arch/arm64/include/asm/pgtable-types.h
> +++ b/arch/arm64/include/asm/pgtable-types.h
> @@ -11,6 +11,8 @@
>  
>  #include <asm/types.h>
>  
> +#ifndef __ASSEMBLY__
> +
>  typedef u64 pteval_t;
>  typedef u64 pmdval_t;
>  typedef u64 pudval_t;
> @@ -44,6 +46,8 @@ typedef struct { pteval_t pgprot; } pgprot_t;
>  #define pgprot_val(x)	((x).pgprot)
>  #define __pgprot(x)	((pgprot_t) { (x) } )
>  
> +#endif /* __ASSEMBLY__ */
> +
>  #if CONFIG_PGTABLE_LEVELS == 2
>  #include <asm-generic/pgtable-nopmd.h>
>  #elif CONFIG_PGTABLE_LEVELS == 3
> -----------------------8<---------------------------
> 
> To avoid guarding the ARM64_MEMSTART_* definitions, we could instead
> move the P*D_SHIFT definitions in asm-generic/pgtable-nop*d.h outside
> the #ifndef __ASSEMBLY__ block.

OR could ARM64_MEMSTART_SHIFT and ARM64_MEMSTART_ALIGN computation blocks
be moved inside arch/arm64/mm/init.c, where it is used exclusively. Seems
to be solving the problem as well.
