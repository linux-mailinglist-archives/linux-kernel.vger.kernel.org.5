Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D5578E50F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345824AbjHaDXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245749AbjHaDXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:23:44 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FDDCD6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:23:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rbmhh6NNhz4f3v6n
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:23:32 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqW2B_BkH_T6Bw--.5435S3;
        Thu, 31 Aug 2023 11:23:36 +0800 (CST)
Subject: Re: [PATCH v2 4/8] crash_core: add generic function to do reservation
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        samuel.holland@sifive.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-5-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <df395f20-55e9-169b-846b-f55d21d00861@huaweicloud.com>
Date:   Thu, 31 Aug 2023 11:23:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230829121610.138107-5-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHoqW2B_BkH_T6Bw--.5435S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1rKF43WryrXrWruF48JFb_yoWxZr4rpF
        y8CF4fCFW7tFnrCay3Zr9xCryrZw1S9a429Fy2yryrJF9rtFnxKr45uFy2qrWjyrZ0qFWj
        yFWFgrZIkw4jv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/29 20:16, Baoquan He wrote:
> In architecture like x86_64, arm64 and riscv, they have vast virtual
> address space and usually have huge physical memory RAM. Their
> crashkernel reservation doesn't have to be limited under 4G RAM,
> but can be extended to the whole physical memory via crashkernel=,high
> support.
> 
> Now add function reserve_crashkernel_generic() to reserve crashkernel
> memory if users specify any case of kernel pamameters, like
> crashkernel=xM[@offset] or crashkernel=,high|low.
> 
> This is preparation to simplify code of crashkernel=,high support
> in architecutures.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/crash_core.h |  34 ++++++++++--
>  kernel/crash_core.c        | 109 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 136 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 85260bf4a734..2f732493e922 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -77,12 +77,6 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len);
>  void final_note(Elf_Word *buf);
>  
> -#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> -#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> -#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
> -#endif
> -#endif
> -
>  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base,
>  		unsigned long long *low_size, bool *high);
> @@ -91,4 +85,32 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
>  
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
> +#endif
> +#ifndef CRASH_ALIGN
> +#define CRASH_ALIGN			SZ_2M
> +#endif
> +#ifndef CRASH_ADDR_LOW_MAX
> +#define CRASH_ADDR_LOW_MAX		SZ_4G
> +#endif
> +#ifndef CRASH_ADDR_HIGH_MAX
> +#define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
> +#endif
> +
> +void __init reserve_crashkernel_generic(char *cmdline,
> +		unsigned long long crash_size,
> +		unsigned long long crash_base,
> +		unsigned long long crash_low_size,
> +		bool high);
> +#else
> +static inline void __init reserve_crashkernel_generic(char *cmdline,
> +		unsigned long long crash_size,
> +		unsigned long long crash_base,
> +		unsigned long long crash_low_size,
> +		bool high)
> +{}
> +#endif
> +
>  #endif /* LINUX_CRASH_CORE_H */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 355b0ab5189c..6bc00cc390b5 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -5,11 +5,13 @@
>   */
>  
>  #include <linux/buildid.h>
> -#include <linux/crash_core.h>
>  #include <linux/init.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
> +#include <linux/memblock.h>
> +#include <linux/kexec.h>
> +#include <linux/kmemleak.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -349,6 +351,111 @@ static int __init parse_crashkernel_dummy(char *arg)
>  }
>  early_param("crashkernel", parse_crashkernel_dummy);
>  
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> +{
> +#ifdef CONFIG_64BIT
> +	unsigned long long low_base;
> +
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> +	if (!low_base) {
> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> +		return -ENOMEM;
> +	}
> +
> +	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
> +		low_base, low_base + low_size, low_size >> 20);
> +
> +	crashk_low_res.start = low_base;
> +	crashk_low_res.end   = low_base + low_size - 1;
> +	insert_resource(&iomem_resource, &crashk_low_res);
> +#endif
> +	return 0;
> +}
> +
> +void __init reserve_crashkernel_generic(char *cmdline,
> +			     unsigned long long crash_size,
> +			     unsigned long long crash_base,
> +			     unsigned long long crash_low_size,
> +			     bool high)
> +{
> +	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
> +	bool fixed_base = false;
> +
> +	/* User specifies base address explicitly. */
> +	if (crash_base) {
> +		fixed_base = true;
> +		search_base = crash_base;
> +		search_end = crash_base + crash_size;
> +	}
> +
> +	if (high) {

It might be a little clearer to use "else if (high) {"

> +		search_base = CRASH_ADDR_LOW_MAX;
> +		search_end = CRASH_ADDR_HIGH_MAX;
> +	}
> +
> +retry:
> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> +					       search_base, search_end);
> +	if (!crash_base) {
> +		/*
> +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> +		 * message if can't reserve the specified region.
> +		 */
> +		if (fixed_base) {
> +			pr_warn("crashkernel reservation failed - memory is in use.\n");
> +			return;
> +		}
> +
> +		/*
> +		 * For crashkernel=size[KMG], if the first attempt was for
> +		 * low memory, fall back to high memory, the minimum required
> +		 * low memory will be reserved later.
> +		 */
> +		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
> +			search_end = CRASH_ADDR_HIGH_MAX;
> +			search_base = CRASH_ADDR_LOW_MAX;
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +			goto retry;
> +		}
> +
> +		/*
> +		 * For crashkernel=size[KMG],high, if the first attempt was
> +		 * for high memory, fall back to low memory.
> +		 */
> +		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
> +			search_end = CRASH_ADDR_LOW_MAX;
> +			search_base = 0;
> +			goto retry;
> +		}
> +		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> +			crash_size);
> +		return;
> +	}
> +
> +	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
> +	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +		memblock_phys_free(crash_base, crash_size);
> +		return;
> +	}
> +
> +	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> +		crash_base, crash_base + crash_size, crash_size >> 20);
> +
> +	/*
> +	 * The crashkernel memory will be removed from the kernel linear
> +	 * map. Inform kmemleak so that it won't try to access it.
> +	 */
> +	kmemleak_ignore_phys(crash_base);
> +	if (crashk_low_res.end)
> +		kmemleak_ignore_phys(crashk_low_res.start);
> +
> +	crashk_res.start = crash_base;
> +	crashk_res.end = crash_base + crash_size - 1;
> +	insert_resource(&iomem_resource, &crashk_res);
> +}
> +#endif
> +
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len)
>  {
> 

-- 
Regards,
  Zhen Lei

