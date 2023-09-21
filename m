Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E5B7A9B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjIUTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjIUTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E17EA0A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695317853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UMMavYCHBWGcbbAfcWzAVx7z+RZ7oLvoKa2eFe7kKpk=;
        b=TmvqrKeawELXForbziTrdg/5Lpu5qHtP+rAp+4zArua7/QdOez+TTyHsQ0pHmYy26uqk/x
        7RrSDvuFgOcU74yaK8UwKgLFWkcoPRA+opCLYYeggUMmzRlV0T47ZyDtxj0hf9T/SKWo4M
        d2aMvOfVSukfLKJ4bKFc3dfvJAqcDL4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-iP9KQ1_fN3q8cHPoL2jy3g-1; Thu, 21 Sep 2023 01:00:20 -0400
X-MC-Unique: iP9KQ1_fN3q8cHPoL2jy3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E83291C05AB4;
        Thu, 21 Sep 2023 05:00:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D419FC15BB8;
        Thu, 21 Sep 2023 05:00:16 +0000 (UTC)
Date:   Thu, 21 Sep 2023 13:00:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "chenjiahao (C)" <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        thunder.leizhen@huawei.com, catalin.marinas@arm.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 8/9] riscv: kdump: use generic interface to simplify
 crashkernel reservation
Message-ID: <ZQvN3cViaPYHUBsf@MiWiFi-R3L-srv>
References: <20230914033142.676708-1-bhe@redhat.com>
 <20230914033142.676708-9-bhe@redhat.com>
 <3e97290f-9031-a2f7-3505-c4ef6274f7da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e97290f-9031-a2f7-3505-c4ef6274f7da@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/23 at 10:36am, chenjiahao (C) wrote:
> 
> On 2023/9/14 11:31, Baoquan He wrote:
> > With the help of newly changed function parse_crashkernel() and
> > generic reserve_crashkernel_generic(), crashkernel reservation can be
> > simplified by steps:
> > 
> > 1) Add a new header file <asm/crash_core.h>, and define CRASH_ALIGN,
> >     CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX and
> >     DEFAULT_CRASH_KERNEL_LOW_SIZE in <asm/crash_core.h>;
> > 
> > 2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
> >     reserve_crashkernel_generic();
> > 
> > 3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
> >     arch/riscv/Kconfig.
> > 
> > The old reserve_crashkernel_low() and reserve_crashkernel() can be
> > removed.
> 
> Hi Baoquan,
> 
> Sorry for the late response. The refactor code has unified multiple
> arch via generic interface, which looks great!
> 
> However when I tested on my risc-v QEMU environment, a little problem
> occurred with following messages:
> 
> [    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000 (128 MB)
> [    0.000000] crashkernel reserved: 0x0000000177e00000 - 0x0000000277e00000 (4096 MB)
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/resource.c:779 __insert_resource+0x8e/0xd0
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc2-next-20230920 #1
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] epc : __insert_resource+0x8e/0xd0
> [    0.000000]  ra : insert_resource+0x28/0x4e
> [    0.000000] epc : ffffffff80017344 ra : ffffffff8001742e sp : ffffffff81203db0
> [    0.000000]  gp : ffffffff812ece98 tp : ffffffff8120dac0 t0 : ff600001f7ff2b00
> [    0.000000]  t1 : 0000000000000000 t2 : 3428203030303030 s0 : ffffffff81203dc0
> [    0.000000]  s1 : ffffffff81211e18 a0 : ffffffff81211e18 a1 : ffffffff81289380
> [    0.000000]  a2 : 0000000277dfffff a3 : 0000000177e00000 a4 : 0000000177e00000
> [    0.000000]  a5 : ffffffff81289380 a6 : 0000000277dfffff a7 : 0000000000000078
> [    0.000000]  s2 : ffffffff81289380 s3 : ffffffff80a0bac8 s4 : ff600001f7ff2880
> [    0.000000]  s5 : 0000000000000280 s6 : 8000000a00006800 s7 : 000000000000007f
> [    0.000000]  s8 : 0000000080017038 s9 : 0000000080038ea0 s10: 0000000000000000
> [    0.000000]  s11: 0000000000000000 t3 : ffffffff80a0bc00 t4 : ffffffff80a0bc00
> [    0.000000]  t5 : ffffffff80a0bbd0 t6 : ffffffff80a0bc00
> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> [    0.000000] [<ffffffff80017344>] __insert_resource+0x8e/0xd0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Failed to add a Crash kernel resource at 177e00000
> 
> The crashkernel memory has been allocated successfully, whereas
> it seems failed to insert into iomem_resource. This should due to
> the unique reserving logic in risc-v arch specific code, i.e.
> crashk_res/crashk_low_res will be added into iomem_resource
> later in init_resources(), which is not aligned with the
> unified reserving logic.

You are right, I didn't check this in riscv arch carefully. The resouce
adding is done repeatedly.

> 
> My simple solution here is removing the arch specific code within
> #ifdef CONFIG_KEXEC_CORE in init_resources(), which has been tested
> OK with all your testcases. Or do you have any other idea?

Yeah, that sounds good to me. You can post a patch with a detailed log
to describe the spotted problem and the root cause.

Thanks for working on this, Jiahao.

> 
> 
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >   arch/riscv/Kconfig                  |   3 +
> >   arch/riscv/include/asm/crash_core.h |  11 +++
> >   arch/riscv/include/asm/processor.h  |   2 +
> >   arch/riscv/mm/init.c                | 141 +++-------------------------
> >   4 files changed, 27 insertions(+), 130 deletions(-)
> >   create mode 100644 arch/riscv/include/asm/crash_core.h
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d607ab0f7c6d..25474f8c12b7 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -694,6 +694,9 @@ config ARCH_SUPPORTS_KEXEC_PURGATORY
> >   config ARCH_SUPPORTS_CRASH_DUMP
> >   	def_bool y
> > +config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> > +	def_bool CRASH_CORE
> > +
> >   config COMPAT
> >   	bool "Kernel support for 32-bit U-mode"
> >   	default 64BIT
> > diff --git a/arch/riscv/include/asm/crash_core.h b/arch/riscv/include/asm/crash_core.h
> > new file mode 100644
> > index 000000000000..e1874b23feaf
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/crash_core.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef _RISCV_CRASH_CORE_H
> > +#define _RISCV_CRASH_CORE_H
> > +
> > +#define CRASH_ALIGN			PMD_SIZE
> > +
> > +#define CRASH_ADDR_LOW_MAX		dma32_phys_limit
> > +#define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
> > +
> > +extern phys_addr_t memblock_end_of_DRAM(void);
> > +#endif
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index 3e23e1786d05..441da1839c94 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -116,6 +116,8 @@ static inline void wait_for_interrupt(void)
> >   	__asm__ __volatile__ ("wfi");
> >   }
> > +extern phys_addr_t dma32_phys_limit;
> > +
> >   struct device_node;
> >   int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
> >   int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *hartid);
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 9fe448900059..d9a4e8702864 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -65,7 +65,7 @@ extern char _start[];
> >   void *_dtb_early_va __initdata;
> >   uintptr_t _dtb_early_pa __initdata;
> > -static phys_addr_t dma32_phys_limit __initdata;
> > +phys_addr_t dma32_phys_limit __initdata;
> >   static void __init zone_sizes_init(void)
> >   {
> > @@ -1333,28 +1333,6 @@ static inline void setup_vm_final(void)
> >   }
> >   #endif /* CONFIG_MMU */
> > -/* Reserve 128M low memory by default for swiotlb buffer */
> > -#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
> > -
> > -static int __init reserve_crashkernel_low(unsigned long long low_size)
> > -{
> > -	unsigned long long low_base;
> > -
> > -	low_base = memblock_phys_alloc_range(low_size, PMD_SIZE, 0, dma32_phys_limit);
> > -	if (!low_base) {
> > -		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> > -		return -ENOMEM;
> > -	}
> > -
> > -	pr_info("crashkernel low memory reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> > -		low_base, low_base + low_size, low_size >> 20);
> > -
> > -	crashk_low_res.start = low_base;
> > -	crashk_low_res.end = low_base + low_size - 1;
> > -
> > -	return 0;
> > -}
> > -
> >   /*
> >    * reserve_crashkernel() - reserves memory for crash kernel
> >    *
> > @@ -1362,122 +1340,25 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >    * line parameter. The memory reserved is used by dump capture kernel when
> >    * primary kernel is crashing.
> >    */
> > -static void __init reserve_crashkernel(void)
> > +static void __init arch_reserve_crashkernel(void)
> >   {
> > -	unsigned long long crash_base = 0;
> > -	unsigned long long crash_size = 0;
> > -	unsigned long long crash_low_size = 0;
> > -	unsigned long search_start = memblock_start_of_DRAM();
> > -	unsigned long search_end = (unsigned long)dma32_phys_limit;
> > +	unsigned long long low_size = 0;
> > +	unsigned long long crash_base, crash_size;
> >   	char *cmdline = boot_command_line;
> > -	bool fixed_base = false;
> >   	bool high = false;
> > -
> > -	int ret = 0;
> > +	int ret;
> >   	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> >   		return;
> > -	/*
> > -	 * Don't reserve a region for a crash kernel on a crash kernel
> > -	 * since it doesn't make much sense and we have limited memory
> > -	 * resources.
> > -	 */
> > -	if (is_kdump_kernel()) {
> > -		pr_info("crashkernel: ignoring reservation request\n");
> > -		return;
> > -	}
> >   	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> > -				&crash_size, &crash_base, NULL, NULL);
> > -	if (ret == -ENOENT) {
> > -		/* Fallback to crashkernel=X,[high,low] */
> > -		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> > -		if (ret || !crash_size)
> > -			return;
> > -
> > -		/*
> > -		 * crashkernel=Y,low is valid only when crashkernel=X,high
> > -		 * is passed.
> > -		 */
> > -		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> > -		if (ret == -ENOENT)
> > -			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > -		else if (ret)
> > -			return;
> > -
> > -		search_start = (unsigned long)dma32_phys_limit;
> > -		search_end = memblock_end_of_DRAM();
> > -		high = true;
> > -	} else if (ret || !crash_size) {
> > -		/* Invalid argument value specified */
> > +				&crash_size, &crash_base,
> > +				&low_size, &high);
> > +	if (ret)
> >   		return;
> > -	}
> > -
> > -	crash_size = PAGE_ALIGN(crash_size);
> > -
> > -	if (crash_base) {
> > -		fixed_base = true;
> > -		search_start = crash_base;
> > -		search_end = crash_base + crash_size;
> > -	}
> > -
> > -	/*
> > -	 * Current riscv boot protocol requires 2MB alignment for
> > -	 * RV64 and 4MB alignment for RV32 (hugepage size)
> > -	 *
> > -	 * Try to alloc from 32bit addressible physical memory so that
> > -	 * swiotlb can work on the crash kernel.
> > -	 */
> > -	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> > -					       search_start, search_end);
> > -	if (crash_base == 0) {
> > -		/*
> > -		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> > -		 * message if can't reserve the specified region.
> > -		 */
> > -		if (fixed_base) {
> > -			pr_warn("crashkernel: allocating failed with given size@offset\n");
> > -			return;
> > -		}
> > -
> > -		if (high) {
> > -			/*
> > -			 * For crashkernel=size[KMG],high, if the first attempt was
> > -			 * for high memory, fall back to low memory.
> > -			 */
> > -			search_start = memblock_start_of_DRAM();
> > -			search_end = (unsigned long)dma32_phys_limit;
> > -		} else {
> > -			/*
> > -			 * For crashkernel=size[KMG], if the first attempt was for
> > -			 * low memory, fall back to high memory, the minimum required
> > -			 * low memory will be reserved later.
> > -			 */
> > -			search_start = (unsigned long)dma32_phys_limit;
> > -			search_end = memblock_end_of_DRAM();
> > -			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> > -		}
> > -
> > -		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> > -						       search_start, search_end);
> > -		if (crash_base == 0) {
> > -			pr_warn("crashkernel: couldn't allocate %lldKB\n",
> > -				crash_size >> 10);
> > -			return;
> > -		}
> > -	}
> > -
> > -	if ((crash_base >= dma32_phys_limit) && crash_low_size &&
> > -	     reserve_crashkernel_low(crash_low_size)) {
> > -		memblock_phys_free(crash_base, crash_size);
> > -		return;
> > -	}
> > -
> > -	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
> > -		crash_base, crash_base + crash_size, crash_size >> 20);
> > -	crashk_res.start = crash_base;
> > -	crashk_res.end = crash_base + crash_size - 1;
> > +	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> > +				    low_size, high);
> >   }
> >   void __init paging_init(void)
> > @@ -1495,7 +1376,7 @@ void __init misc_mem_init(void)
> >   	arch_numa_init();
> >   	sparse_init();
> >   	zone_sizes_init();
> > -	reserve_crashkernel();
> > +	arch_reserve_crashkernel();
> >   	memblock_dump_all();
> >   }
> 

