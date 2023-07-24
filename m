Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D2A75EA10
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjGXD0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXD0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:26:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8B3F1B0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:26:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 880E8DE0;
        Sun, 23 Jul 2023 20:26:51 -0700 (PDT)
Received: from [10.162.41.7] (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 965193F6C4;
        Sun, 23 Jul 2023 20:26:05 -0700 (PDT)
Message-ID: <b31592db-d589-c425-1f5f-1c981ec72a65@arm.com>
Date:   Mon, 24 Jul 2023 08:56:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] arm64: fix -Wundef warning for PUD_SHIFT
Content-Language: en-US
To:     Zhang Jianhua <chris.zjh@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, joey.gouly@arm.com, mark.rutland@arm.com,
        ardb@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230724103055.2379274-1-chris.zjh@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230724103055.2379274-1-chris.zjh@huawei.com>
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



On 7/24/23 16:00, Zhang Jianhua wrote:
> When building with W=1, the following warning occurs.
> 
> arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
>   129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
>       |                                         ^~~~~~~~~
> arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
>   142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
>       |     ^~~~~~~~~~~~~~~~~~~~
> 
> The reason is that PUD_SHIFT isn't defined if CONFIG_PGTABLE_LEVELS ==
> 3, and at this time PUD_SHIFT is equal to PGDIR_SHIFT, so define it.

CONFIG_PGTABLE_LEVELS equals 3 only with CONFIG_VA_BITS = 39.

> 
> Fixes: 06e9bf2fd9b3 ("arm64: choose memstart_addr based on minimum sparsemem section alignment")

This is not a fix, ARM64_MEMSTART_ALIGN would fallback being (1UL << SECTION_SIZE_BITS)
when PUD_SHIFT is undefined (aka 0) but agreed that it's not clean.

> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
> ---
> v2:
> 	Define PUD_SHIFT before use it instead of judgement
> ---
> ---
>  arch/arm64/include/asm/kernel-pgtable.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index 577773870b66..996a144e2929 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -59,6 +59,10 @@
>  #define EARLY_KASLR	(0)
>  #endif
>  
> +#ifndef PUD_SHIFT
> +#define PUD_SHIFT PGDIR_SHIFT
> +#endif
Rather ARM64_MEMSTART_SHIFT block needs to be re-written in a more pgtable levels agnostic
manner ? OR maybe something like this.

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 577773870b66..5a83b4b249e8 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -125,12 +125,14 @@
  * (64k granule), or a multiple that can be mapped using contiguous bits
  * in the page tables: 32 * PMD_SIZE (16k granule)
  */
-#if defined(CONFIG_ARM64_4K_PAGES)
+#if defined(CONFIG_ARM64_4K_PAGES) && defined(PUD_SHIFT)
 #define ARM64_MEMSTART_SHIFT           PUD_SHIFT
-#elif defined(CONFIG_ARM64_16K_PAGES)
+#elif defined(CONFIG_ARM64_16K_PAGES) && defined(CONT_PMD_SHIFT)
 #define ARM64_MEMSTART_SHIFT           CONT_PMD_SHIFT
-#else
+#elif defined(CONFIG_AR64_64K_PAGES) && defined(PMD_SHIFT)
 #define ARM64_MEMSTART_SHIFT           PMD_SHIFT
+#else
+#define ARM64_MEMSTART_SHIFT           PGDIR_SHIFT
 #endif

The only cases where PUD_SHIFT or PMD_SHIFT (along with CONT_PMD_SHIFT) would not be defined is
when XXX_SHIFT level itself matches PGDIR_SHIFT.

> +
>  #define SPAN_NR_ENTRIES(vstart, vend, shift) \
>  	((((vend) - 1) >> (shift)) - ((vstart) >> (shift)) + 1)
> 
