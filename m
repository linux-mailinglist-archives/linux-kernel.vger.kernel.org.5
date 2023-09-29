Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1787B3C89
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjI2WNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2WNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:13:05 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF189EB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:13:02 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 19034413B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 22:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696025581;
        bh=akEQpjnSaOCmVyFO6/j4VdCn72p157hzBoWjA60czn0=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=W6hol19aUVXaHaEi6qQbM0IyUdjHnDwxaa067188rmpqqdtrE142rgC89xqD6bZcH
         oVlj+R0oVBvSyRKn8VX6vqqEcvNoqf2vghsMmNHioVYg2CSR80+qh/DcvTFTATYrWE
         rGZPo187Do5R8fdLKU2W/T4HScBAY6ZDtHeBvIZ2oDUy8AVPEkB85rmjcC8xMynOnj
         KwzWePY9xYNpSdp+Mvk597uLunC/lvBu10I1+zxlVeVfYCzCsHQCWXdLb3ooWFNCGf
         PX6ts6S2BzTbvpJZum2VdbpS9wxWgrVswgDou4Q7IK44MvlfXPg/Uhlz00ex5eU/Xx
         N4VJPk8pmMK5g==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-418134c43d7so8735001cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696025580; x=1696630380;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akEQpjnSaOCmVyFO6/j4VdCn72p157hzBoWjA60czn0=;
        b=HfCtnfcWggs/N4An8pwAABSlIWduHEvqUtRO5c0ZoPHpLh/DerhN05+XWCZ4qgsW+9
         gL/rMogyU+ar25cHrjEtZ6jUJ6mxyMShglTOqxr9TFwEtjYxuTLIhiV7CUDL/pR/2Jp/
         LHpoJHr7w1I3trzlpLGv4A9pqYKsOZ3F4is8/mkTtsRBnAmFu4aWM/A5YffebGHNZ6xs
         lI0WIBYJS/INOAPN5y5+EUSK4VMAKbqURvVC58x3qii9mqTF1O7WrdBGJLHQ99b2i1XH
         IPMYeaZe8L0iAGxOL6c988TIV5qP3WI2ppec5vJ7lhPAGUJ827h841H+kXSXwP3sqjGT
         FC1A==
X-Gm-Message-State: AOJu0YymEJQ0Y6HVkqOs3uwBs+PLQeihdYF/ztDO2yO2D3mgnF0vmRtK
        SS1+LB06lL91uDudL0hs/2wmXcHYd8Q3BpDbp+e4fu0liyEeo8N0m2BRFXn65HcCfIeiH5aptQY
        msFbc/3oa3SemzKO0LQ+QnhPFMT57GTwrlZVOGdiVQt/b5kgf4bmwoyA97Q==
X-Received: by 2002:ac8:5b02:0:b0:418:11c9:ddb5 with SMTP id m2-20020ac85b02000000b0041811c9ddb5mr5685375qtw.25.1696025579742;
        Fri, 29 Sep 2023 15:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB4k+0zAFDt2sSwLYhrpY9z4bqBMrdow5w3FBKQoWQYu+kJM3gd7lbn/fBQ8vP2fJypw7YZZK5PghtHVTbwSw=
X-Received: by 2002:ac8:5b02:0:b0:418:11c9:ddb5 with SMTP id
 m2-20020ac85b02000000b0041811c9ddb5mr5685358qtw.25.1696025579473; Fri, 29 Sep
 2023 15:12:59 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Sep 2023 15:12:58 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230912072740.2544-1-jszhang@kernel.org>
References: <20230912072740.2544-1-jszhang@kernel.org>
Mime-Version: 1.0
Date:   Fri, 29 Sep 2023 15:12:58 -0700
Message-ID: <CAJM55Z9-+qFMAzXbDOX==bYhU92x0bgjbzJiYEHS_yL0wF-SbQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jisheng Zhang wrote:
> Previously, we use alternative mechanism to dynamically patch
> the CMO operations for THEAD C906/C910 during boot for performance
> reason. But as pointed out by Arnd, "there is already a significant
> cost in accessing the invalidated cache lines afterwards, which is
> likely going to be much higher than the cost of an indirect branch".
> And indeed, there's no performance difference with GMAC and EMMC per
> my test on Sipeed Lichee Pi 4A board.
>
> Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
> the alternative code, and to acchieve Arnd's goal -- "I think
> moving the THEAD ops at the same level as all nonstandard operations
> makes sense, but I'd still leave CMO as an explicit fast path that
> avoids the indirect branch. This seems like the right thing to do both
> for readability and for platforms on which the indirect branch has a
> noticeable overhead."

Hi Jisheng,

Thank you for doing this! This boots fine on my Nezha board (Allwinner D1)
running btrfs on the sd-card which was quick to find bugs when this code
first went upstream.

Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig.errata            |  1 +
>  arch/riscv/errata/thead/errata.c     | 76 +++++++++++++++++++++++++++-
>  arch/riscv/include/asm/errata_list.h | 50 +++---------------
>  3 files changed, 81 insertions(+), 46 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 566bcefeab50..d7972914f9de 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -78,6 +78,7 @@ config ERRATA_THEAD_CMO
>  	bool "Apply T-Head cache management errata"
>  	depends on ERRATA_THEAD && MMU
>  	select RISCV_DMA_NONCOHERENT
> +	select RISCV_NONSTANDARD_CACHE_OPS
>  	default y
>  	help
>  	  This will apply the cache management errata to handle the
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 0554ed4bf087..1c320abfe446 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -12,8 +12,10 @@
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
> +#include <asm/dma-noncoherent.h>
>  #include <asm/errata_list.h>
>  #include <asm/hwprobe.h>
> +#include <asm/io.h>
>  #include <asm/patch.h>
>  #include <asm/vendorid_list.h>
>
> @@ -33,6 +35,75 @@ static bool errata_probe_pbmt(unsigned int stage,
>  	return false;
>  }
>
> +/*
> + * dcache.ipa rs1 (invalidate, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01010      rs1       000      00000  0001011
> + * dache.iva rs1 (invalida, virtual address)
> + *   0000001    00110      rs1       000      00000  0001011
> + *
> + * dcache.cpa rs1 (clean, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01001      rs1       000      00000  0001011
> + * dcache.cva rs1 (clean, virtual address)
> + *   0000001    00101      rs1       000      00000  0001011
> + *
> + * dcache.cipa rs1 (clean then invalidate, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01011      rs1       000      00000  0001011
> + * dcache.civa rs1 (... virtual address)
> + *   0000001    00111      rs1       000      00000  0001011
> + *
> + * sync.s (make sure all cache operations finished)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000000    11001     00000      000      00000  0001011
> + */
> +#define THEAD_inval_A0	".long 0x0265000b"
> +#define THEAD_clean_A0	".long 0x0255000b"
> +#define THEAD_flush_A0	".long 0x0275000b"
> +#define THEAD_SYNC_S	".long 0x0190000b"
> +
> +#define THEAD_CMO_OP(_op, _start, _size, _cachesize)			\
> +asm volatile("mv a0, %1\n\t"						\
> +	     "j 2f\n\t"							\
> +	     "3:\n\t"							\
> +	     THEAD_##_op##_A0 "\n\t"					\
> +	     "add a0, a0, %0\n\t"					\
> +	     "2:\n\t"							\
> +	     "bltu a0, %2, 3b\n\t"					\
> +	     THEAD_SYNC_S						\
> +	     : : "r"(_cachesize),					\
> +		 "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
> +		 "r"((unsigned long)(_start) + (_size))			\
> +	     : "a0")
> +
> +static void thead_errata_cache_inv(phys_addr_t paddr, size_t size)
> +{
> +	void *vaddr = phys_to_virt(paddr);
> +
> +	THEAD_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
> +}
> +
> +static void thead_errata_cache_wback(phys_addr_t paddr, size_t size)
> +{
> +	void *vaddr = phys_to_virt(paddr);
> +
> +	THEAD_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +}
> +
> +static void thead_errata_cache_wback_inv(phys_addr_t paddr, size_t size)
> +{
> +	void *vaddr = phys_to_virt(paddr);
> +
> +	THEAD_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +}
> +
> +static const struct riscv_nonstd_cache_ops thead_errata_cmo_ops = {
> +	.wback = &thead_errata_cache_wback,
> +	.inv = &thead_errata_cache_inv,
> +	.wback_inv = &thead_errata_cache_wback_inv,
> +};
> +
>  static bool errata_probe_cmo(unsigned int stage,
>  			     unsigned long arch_id, unsigned long impid)
>  {
> @@ -48,6 +119,8 @@ static bool errata_probe_cmo(unsigned int stage,
>  	if (stage == RISCV_ALTERNATIVES_BOOT) {
>  		riscv_cbom_block_size = L1_CACHE_BYTES;
>  		riscv_noncoherent_supported();
> +		if (IS_ENABLED(CONFIG_RISCV_NONSTANDARD_CACHE_OPS))
> +			riscv_noncoherent_register_cache_ops(&thead_errata_cmo_ops);
>  	}
>
>  	return true;
> @@ -77,8 +150,7 @@ static u32 thead_errata_probe(unsigned int stage,
>  	if (errata_probe_pbmt(stage, archid, impid))
>  		cpu_req_errata |= BIT(ERRATA_THEAD_PBMT);
>
> -	if (errata_probe_cmo(stage, archid, impid))
> -		cpu_req_errata |= BIT(ERRATA_THEAD_CMO);
> +	errata_probe_cmo(stage, archid, impid);
>
>  	if (errata_probe_pmu(stage, archid, impid))
>  		cpu_req_errata |= BIT(ERRATA_THEAD_PMU);
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index b55b434f0059..ea33288f8a25 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -24,9 +24,8 @@
>
>  #ifdef CONFIG_ERRATA_THEAD
>  #define	ERRATA_THEAD_PBMT 0
> -#define	ERRATA_THEAD_CMO 1
> -#define	ERRATA_THEAD_PMU 2
> -#define	ERRATA_THEAD_NUMBER 3
> +#define	ERRATA_THEAD_PMU 1
> +#define	ERRATA_THEAD_NUMBER 2
>  #endif
>
>  #ifdef __ASSEMBLY__
> @@ -94,54 +93,17 @@ asm volatile(ALTERNATIVE(						\
>  #define ALT_THEAD_PMA(_val)
>  #endif
>
> -/*
> - * dcache.ipa rs1 (invalidate, physical address)
> - * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> - *   0000001    01010      rs1       000      00000  0001011
> - * dache.iva rs1 (invalida, virtual address)
> - *   0000001    00110      rs1       000      00000  0001011
> - *
> - * dcache.cpa rs1 (clean, physical address)
> - * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> - *   0000001    01001      rs1       000      00000  0001011
> - * dcache.cva rs1 (clean, virtual address)
> - *   0000001    00101      rs1       000      00000  0001011
> - *
> - * dcache.cipa rs1 (clean then invalidate, physical address)
> - * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> - *   0000001    01011      rs1       000      00000  0001011
> - * dcache.civa rs1 (... virtual address)
> - *   0000001    00111      rs1       000      00000  0001011
> - *
> - * sync.s (make sure all cache operations finished)
> - * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> - *   0000000    11001     00000      000      00000  0001011
> - */
> -#define THEAD_inval_A0	".long 0x0265000b"
> -#define THEAD_clean_A0	".long 0x0255000b"
> -#define THEAD_flush_A0	".long 0x0275000b"
> -#define THEAD_SYNC_S	".long 0x0190000b"
> -
>  #define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
> -asm volatile(ALTERNATIVE_2(						\
> -	__nops(6),							\
> +asm volatile(ALTERNATIVE(						\
> +	__nops(5),							\
>  	"mv a0, %1\n\t"							\
>  	"j 2f\n\t"							\
>  	"3:\n\t"							\
>  	CBO_##_op(a0)							\
>  	"add a0, a0, %0\n\t"						\
>  	"2:\n\t"							\
> -	"bltu a0, %2, 3b\n\t"						\
> -	"nop", 0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,	\
> -	"mv a0, %1\n\t"							\
> -	"j 2f\n\t"							\
> -	"3:\n\t"							\
> -	THEAD_##_op##_A0 "\n\t"						\
> -	"add a0, a0, %0\n\t"						\
> -	"2:\n\t"							\
> -	"bltu a0, %2, 3b\n\t"						\
> -	THEAD_SYNC_S, THEAD_VENDOR_ID,					\
> -			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
> +	"bltu a0, %2, 3b\n\t",						\
> +	0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM)		\
>  	: : "r"(_cachesize),						\
>  	    "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
>  	    "r"((unsigned long)(_start) + (_size))			\
> --
> 2.40.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
