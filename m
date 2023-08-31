Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF478E51E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbjHaDoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjHaDoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:44:02 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B277CC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:43:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rbn8B656Hz4f3m8f
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:43:54 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH1qh5DPBkeSH8Bw--.465S3;
        Thu, 31 Aug 2023 11:43:55 +0800 (CST)
Subject: Re: [PATCH v2 6/8] x86: kdump: use generic interface to simplify
 crashkernel reservation code
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        samuel.holland@sifive.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-7-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <5b53d460-7134-e292-77ec-967016e89003@huaweicloud.com>
Date:   Thu, 31 Aug 2023 11:43:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230829121610.138107-7-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBH1qh5DPBkeSH8Bw--.465S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy5tr43Cw48JF17Zw15XFb_yoWfAw17pr
        y3JF4fArWDtFyDG3y7Arn7CrW8A3Za9a4j9r15Jr95Jr9rKrnxKr43uw12gryUKr95WFy8
        tFWrXF9Yga10qrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/29 20:16, Baoquan He wrote:
> With the help of newly changed function parse_crashkernel() and
> generic reserve_crashkernel_generic(), crashkernel reservation can be
> simplified by steps:
> 
> 1) Add a new header file <asm/crash_core.h>, and define CRASH_ALIGN,
>    CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX and
>    DEFAULT_CRASH_KERNEL_LOW_SIZE in <asm/crash_core.h>;
> 
> 2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
>    reserve_crashkernel_generic(), and do the ARCH specific work if
>    needed.
> 
> 3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
>    arch/x86/Kconfig.
> 
> When adding DEFAULT_CRASH_KERNEL_LOW_SIZE, add crash_low_size_default()
> to calculate crashkernel low memory because x86_64 has special
> requirement.
> 
> The old reserve_crashkernel_low() and reserve_crashkernel() can be
> removed.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/Kconfig                  |   3 +
>  arch/x86/include/asm/crash_core.h |  34 +++++++
>  arch/x86/kernel/setup.c           | 144 ++++--------------------------
>  3 files changed, 53 insertions(+), 128 deletions(-)
>  create mode 100644 arch/x86/include/asm/crash_core.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8d9e4b362572..c4539dc35985 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2037,6 +2037,9 @@ config KEXEC_FILE
>  config ARCH_HAS_KEXEC_PURGATORY
>  	def_bool KEXEC_FILE
>  
> +config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +	def_bool CRASH_CORE
> +
>  config KEXEC_SIG
>  	bool "Verify kernel signature during kexec_file_load() syscall"
>  	depends on KEXEC_FILE
> diff --git a/arch/x86/include/asm/crash_core.h b/arch/x86/include/asm/crash_core.h
> new file mode 100644
> index 000000000000..5fc5e4f94521
> --- /dev/null
> +++ b/arch/x86/include/asm/crash_core.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _X86_CRASH_CORE_H
> +#define _X86_CRASH_CORE_H
> +
> +/* 16M alignment for crash kernel regions */
> +#define CRASH_ALIGN             SZ_16M
> +
> +/*
> + * Keep the crash kernel below this limit.
> + *
> + * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
> + * due to mapping restrictions.
> + *
> + * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
> + * the upper limit of system RAM in 4-level paging mode. Since the kdump
> + * jump could be from 5-level paging to 4-level paging, the jump will fail if
> + * the kernel is put above 64 TB, and during the 1st kernel bootup there's
> + * no good way to detect the paging mode of the target kernel which will be
> + * loaded for dumping.
> + */
> +
> +#ifdef CONFIG_X86_32
> +# define CRASH_ADDR_LOW_MAX     SZ_512M
> +# define CRASH_ADDR_HIGH_MAX    SZ_512M
> +#else
> +# define CRASH_ADDR_LOW_MAX     SZ_4G
> +# define CRASH_ADDR_HIGH_MAX    SZ_64T
> +#endif
> +
> +# define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
> +
> +extern unsigned long crash_low_size_default(void);
> +
> +#endif /* _X86_CRASH_CORE_H */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 382c66d2cf71..559a5c4141db 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -474,152 +474,40 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  /*
>   * --------- Crashkernel reservation ------------------------------
>   */
> -
> -/* 16M alignment for crash kernel regions */
> -#define CRASH_ALIGN		SZ_16M
> -
> -/*
> - * Keep the crash kernel below this limit.
> - *
> - * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
> - * due to mapping restrictions.
> - *
> - * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
> - * the upper limit of system RAM in 4-level paging mode. Since the kdump
> - * jump could be from 5-level paging to 4-level paging, the jump will fail if
> - * the kernel is put above 64 TB, and during the 1st kernel bootup there's
> - * no good way to detect the paging mode of the target kernel which will be
> - * loaded for dumping.
> - */
> -#ifdef CONFIG_X86_32
> -# define CRASH_ADDR_LOW_MAX	SZ_512M
> -# define CRASH_ADDR_HIGH_MAX	SZ_512M
> -#else
> -# define CRASH_ADDR_LOW_MAX	SZ_4G
> -# define CRASH_ADDR_HIGH_MAX	SZ_64T
> -#endif
> -
> -static int __init reserve_crashkernel_low(void)
> +unsigned long crash_low_size_default(void)
>  {
>  #ifdef CONFIG_X86_64
> -	unsigned long long base, low_base = 0, low_size = 0;
> -	unsigned long low_mem_limit;
> -	int ret;
> -
> -	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
> -
> -	/* crashkernel=Y,low */
> -	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
> -	if (ret) {
> -		/*
> -		 * two parts from kernel/dma/swiotlb.c:
> -		 * -swiotlb size: user-specified with swiotlb= or default.
> -		 *
> -		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> -		 * to 8M for other buffers that may need to stay low too. Also
> -		 * make sure we allocate enough extra low memory so that we
> -		 * don't run out of DMA buffers for 32-bit devices.
> -		 */
> -		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> -	} else {
> -		/* passed with crashkernel=0,low ? */
> -		if (!low_size)
> -			return 0;
> -	}
> -
> -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> -	if (!low_base) {
> -		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> -		       (unsigned long)(low_size >> 20));
> -		return -ENOMEM;
> -	}
> -
> -	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
> -		(unsigned long)(low_size >> 20),
> -		(unsigned long)(low_base >> 20),
> -		(unsigned long)(low_mem_limit >> 20));
> -
> -	crashk_low_res.start = low_base;
> -	crashk_low_res.end   = low_base + low_size - 1;
> -	insert_resource(&iomem_resource, &crashk_low_res);
> -#endif
> +	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> +#else
>  	return 0;
> +#endif
>  }
>  
> -static void __init reserve_crashkernel(void)
> +static void __init arch_reserve_crashkernel(void)
>  {
> -	unsigned long long crash_size, crash_base, total_mem;
> +	unsigned long long crash_base, crash_size, low_size = 0;
> +	char *cmdline = boot_command_line;
>  	bool high = false;
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
>  
> -	total_mem = memblock_phys_mem_size();
> -
> -	/* crashkernel=XM */
> -	ret = parse_crashkernel(boot_command_line, total_mem,
> -				&crash_size, &crash_base, NULL, NULL);
> -	if (ret != 0 || crash_size <= 0) {
> -		/* crashkernel=X,high */
> -		ret = parse_crashkernel_high(boot_command_line, total_mem,
> -					     &crash_size, &crash_base);
> -		if (ret != 0 || crash_size <= 0)
> -			return;
> -		high = true;
> -	}
> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> +				&crash_size, &crash_base,
> +				&low_size, &high);
> +	if (ret)
> +		return;
>  
>  	if (xen_pv_domain()) {
>  		pr_info("Ignoring crashkernel for a Xen PV domain\n");
>  		return;
>  	}
>  
> -	/* 0 means: find the address automatically */
> -	if (!crash_base) {
> -		/*
> -		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> -		 * crashkernel=x,high reserves memory over 4G, also allocates
> -		 * 256M extra low memory for DMA buffers and swiotlb.
> -		 * But the extra memory is not required for all machines.
> -		 * So try low memory first and fall back to high memory
> -		 * unless "crashkernel=size[KMG],high" is specified.
> -		 */
> -		if (!high)
> -			crash_base = memblock_phys_alloc_range(crash_size,
> -						CRASH_ALIGN, CRASH_ALIGN,
> -						CRASH_ADDR_LOW_MAX);
> -		if (!crash_base)
> -			crash_base = memblock_phys_alloc_range(crash_size,
> -						CRASH_ALIGN, CRASH_ALIGN,
> -						CRASH_ADDR_HIGH_MAX);
> -		if (!crash_base) {
> -			pr_info("crashkernel reservation failed - No suitable area found.\n");
> -			return;
> -		}
> -	} else {
> -		unsigned long long start;
> -
> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> -						  crash_base + crash_size);
> -		if (start != crash_base) {
> -			pr_info("crashkernel reservation failed - memory is in use.\n");
> -			return;
> -		}
> -	}
> -
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> -		memblock_phys_free(crash_base, crash_size);
> -		return;
> -	}
> -
> -	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
> -		(unsigned long)(crash_size >> 20),
> -		(unsigned long)(crash_base >> 20),
> -		(unsigned long)(total_mem >> 20));
> +	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> +				    low_size, high);
>  
> -	crashk_res.start = crash_base;
> -	crashk_res.end   = crash_base + crash_size - 1;
> -	insert_resource(&iomem_resource, &crashk_res);
> +	return;

This can be omitted.

>  }
>  
>  static struct resource standard_io_resources[] = {
> @@ -1231,7 +1119,7 @@ void __init setup_arch(char **cmdline_p)
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
>  	 */
> -	reserve_crashkernel();
> +	arch_reserve_crashkernel();
>  
>  	memblock_find_dma_reserve();
>  
> 

-- 
Regards,
  Zhen Lei

