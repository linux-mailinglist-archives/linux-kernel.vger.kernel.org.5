Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA177A49FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbjIRMqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbjIRMq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:46:29 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C53E51
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:44:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rq4J01vlDz4f3kkd
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:44:48 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd1ARghlVUEhAw--.8500S3;
        Mon, 18 Sep 2023 20:44:48 +0800 (CST)
Subject: Re: [PATCH v3 4/9] crash_core: add generic function to do reservation
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
References: <20230914033142.676708-1-bhe@redhat.com>
 <20230914033142.676708-5-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <3006f785-612d-383e-7faf-a1bd80419af1@huaweicloud.com>
Date:   Mon, 18 Sep 2023 20:44:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230914033142.676708-5-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDnfd1ARghlVUEhAw--.8500S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1xZFWUtw4DZr1fCr4rZrb_yoWxXFW7pF
        y8AFs3CFW7tFnrCay3Zr9xCrWkZw1fua429Fy2yryrJF9rtFnxKrs8uFy2qr1jyrZ0gFWj
        yFyFgrZI9w4qqrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IUbPEf5UUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/14 11:31, Baoquan He wrote:
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

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/crash_core.h |  28 ++++++++++
>  kernel/crash_core.c        | 107 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 134 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index d8050a7eab01..4dbd6565e0ff 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -93,6 +93,34 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
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
>  /* Alignment required for elf header segment */
>  #define ELF_CORE_HEADER_ALIGN   4096
>  
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index dce2f5874fea..ca66b5f41dc7 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -5,7 +5,6 @@
>   */
>  
>  #include <linux/buildid.h>
> -#include <linux/crash_core.h>
>  #include <linux/init.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> @@ -13,6 +12,9 @@
>  #include <linux/kexec.h>
>  #include <linux/memory.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/memblock.h>
> +#include <linux/kexec.h>
> +#include <linux/kmemleak.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -360,6 +362,109 @@ static int __init parse_crashkernel_dummy(char *arg)
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
> +	} else if (high) {
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
>  int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>  			  void **addr, unsigned long *sz)
>  {
> 

-- 
Regards,
  Zhen Lei

