Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3744F78820C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbjHYI1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbjHYI0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D927619A1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:26:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7863962450
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCADC433C7;
        Fri, 25 Aug 2023 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692952002;
        bh=GX9kHRTvbYBel26XAIpavUFknh9Wifx+X21IDxKVqG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=05vY0/e9/7jOLrHtca6isuOnGrrM9gWPMKMIruKNskcC4ufFkWRjSWvgnASqKhf29
         wxPPol+Qfjql/tTVlWU8RbpjOWQIWbeB3duRihjXmJHsOT1z0BTCO7ZAlZvHfWG5aU
         VhibwqqgB5GtiPyxGgwh3loFpEdm4pInfIpb747k=
Date:   Fri, 25 Aug 2023 10:05:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Madhavan Venkataraman <madvenka@linux.microsoft.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        James Gowans <jgowans@amazon.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Jinank Jain <jinankjain@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Introduce persistent memory pool
Message-ID: <2023082506-enchanted-tripping-d1d5@gregkh>
References: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:34:34AM -0700, Stanislav Kinsburskii wrote:
> This patch addresses the need for a memory allocator dedicated to
> persistent memory within the kernel. This allocator will preserve
> kernel-specific states like DMA passthrough device states, IOMMU state, and
> more across kexec.

And CMA doesn't do this for you today?

> The proposed solution offers a foundational implementation for potential
> custom solutions that might follow. Though the implementation is
> intentionally kept concise and straightforward to foster discussion and
> feedback, it's fully functional in its current state.
> 
> The persistent memory pool consists of a simple page allocator that
> operates on reserved physical memory regions. It employs bitmaps to
> allocate and free pages, with the following characteristics:
> 
>   1. Memory pool regions are specified using the command line option:
> 
>        pmpool=<base>,<size>
> 
>      Where <base> represents the physical memory base address and <size>
>      indicates the memory size.
> 
>   2. While the pages allocation emulates the buddy allocator interface, it
>      isn't confined to the MAX_ORDER.
> 
>   3. The memory pool initializes during a cold boot and is retained across
>      kexec.
> 
> Potential applications include:
> 
>   1. Allowing various in-kernel entities to allocate persistent pages from
>      a singular memory pool, eliminating the need for multiple region
>      reservations.
> 
>   2. For in-kernel components that require the allocation address to be
>      available on kernel kexec, this address can be exposed to user space and
>      then passed via the command line.
> 
>   3. Separate subsystems or drivers can reserve their region, sharing a
>      portion of it for their persistent memory pool. This might be a file
>      system, a key-value store, or other applications.
> 
> Potential Enhancements for the Proposed Memory Pool:
> 
>   1. Multiple Memory Regions Support: enhance the pool to accommodate and
>      manage multiple memory regions simultaneously.
> 
>   2. In-Kernel Memory Allocations for Storage Memory Regions:
>    * Allow in-kernel memory allocations to serve as storage memory regions.
>    * Implement explicit reservation of these designated regions during kexec.

As you have no in-kernel users of this, it's not something we can even
consider at the moment for obvious reasons (neither would you want us
to.)

Can you make this part of a patch series that actually adds a user,
probably more than one, so that we can see if any of this even makes
sense?


>  drivers/misc/Kconfig   |    7 +
>  drivers/misc/Makefile  |    1 
>  drivers/misc/pmpool.c  |  270 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pmpool.h |   20 ++++
>  4 files changed, 298 insertions(+)
>  create mode 100644 drivers/misc/pmpool.c
>  create mode 100644 include/linux/pmpool.h

misc is not for memory pools, as this is not a driver.  please put this
in the properly location instead of trying to hide it from the mm
maintainers and subsystem :)

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index cadd4a820c03..c8ef5b37ee98 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -562,6 +562,13 @@ config TPS6594_PFSM
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tps6594-pfsm.
>  
> +config PMPOOL
> +	bool "Persistent memory pool support"
> +	help
> +	  This option adds support for a persistent memory pool feature, which
> +	  provides pages allocation and freeing from a set of persistent memory ranges,
> +	  deposited to the memory pool.

Why would this even be a user selectable option?  Either the kernel
needs this or it doesn't.


> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index f2a4d1ff65d4..31dd6553057d 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -67,3 +67,4 @@ obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
>  obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
>  obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
>  obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
> +obj-$(CONFIG_PMPOOL)		+= pmpool.o
> diff --git a/drivers/misc/pmpool.c b/drivers/misc/pmpool.c
> new file mode 100644
> index 000000000000..e2c923b31b36
> --- /dev/null
> +++ b/drivers/misc/pmpool.c
> @@ -0,0 +1,270 @@
> +#include <linux/io.h>

You forgot basic copyright/license stuff, did you use checkpatch.pl on
your file?

> +#include <linux/bitmap.h>
> +#include <linux/memblock.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include <linux/pmpool.h>
> +
> +#define VERSION			1

In kernel code does not need versions.

> +#define MAX_REGIONS		14

Why 14?  Why not 24?  Or something else?

> +
> +#define for_each_region(pmpool, r)					\
> +	for (r = pmpool->hdr->regions;					\
> +	     r - pmpool->hdr->regions < pmpool->hdr->nr_regions;	\
> +	     r++)
> +
> +#define for_each_used_region(pmpool, r)					\
> +	for_each_region((pmpool), (r))					\
> +		if (!(r)->size_in_pfns) { continue; } else
> +
> +struct pmpool_region {
> +	uint32_t		base_pfn;		/* 32 bits * 4k = up it 15TB of physical address space */

Please use proper kernel types when writing kernel code (i.e. u32, u8,
and so on.)  uint*_t is for userspace code only.

> --- /dev/null
> +++ b/include/linux/pmpool.h
> @@ -0,0 +1,20 @@
> +#ifndef _PMPOOL_H
> +#define _PMPOOL_H
> +
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +
> +void *alloc_pm_pages(unsigned int order);
> +void free_pm_pages(void *addr, unsigned int order);
> +
> +struct pmpool {
> +	spinlock_t		lock;
> +	struct pmpool_header	*hdr;
> +};
> +
> +int pmpool_init(struct pmpool *pmpool, phys_addr_t base, phys_addr_t size);
> +
> +void *alloc_pmpool_pages(struct pmpool *pmpool, unsigned int order);
> +void free_pmpool_pages(struct pmpool *pmpool, void *addr, unsigned int order);

Please use "noun_verb_*" for new apis so that we have a chance at
understanding where the calls are living.

good luck!

greg k-h
