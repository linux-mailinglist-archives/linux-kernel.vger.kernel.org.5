Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B5176A947
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjHAGi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjHAGiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:38:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A29CDB;
        Mon, 31 Jul 2023 23:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D3B361489;
        Tue,  1 Aug 2023 06:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31641C433C8;
        Tue,  1 Aug 2023 06:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690871887;
        bh=hDT+iR6AIZkPiUojYsTG3f1l1RIz7J/cYfpHFlOtmcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihVqg2sCDGTatgUfOTqQau2d5hVIQ7FhkJ4dQpOT6tNN864bCCltGkeZsSp33J3G6
         67N3c/0YoQ7uttpJF1XBIQwpsMlhyfqYfn0RI23AQwNs82WxOMomf6WcFs2wg6yuwo
         qESSyNtICw/59SiCMx7JA4bv1FkEQ3vhy5wSX/Nc=
Date:   Tue, 1 Aug 2023 08:38:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: Re: [PATCH v7 0/9] Allow dynamic allocation of software IO TLB
 bounce buffers
Message-ID: <2023080144-cardigan-nerd-2bed@gregkh>
References: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 08:23:55AM +0200, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> Motivation
> ==========
> 
> The software IO TLB was designed with these assumptions:
> 
> 1) It would not be used much. Small systems (little RAM) don't need it, and
>    big systems (lots of RAM) would have modern DMA controllers and an IOMMU
>    chip to handle legacy devices.
> 2) A small fixed memory area (64 MiB by default) is sufficient to
>    handle the few cases which require a bounce buffer.
> 3) 64 MiB is little enough that it has no impact on the rest of the
>    system.
> 4) Bounce buffers require large contiguous chunks of low memory. Such
>    memory is precious and can be allocated only early at boot.
> 
> It turns out they are not always true:
> 
> 1) Embedded systems may have more than 4GiB RAM but no IOMMU and legacy
>    32-bit peripheral busses and/or DMA controllers.
> 2) CoCo VMs use bounce buffers for all I/O but may need substantially more
>    than 64 MiB.
> 3) Embedded developers put as many features as possible into the available
>    memory. A few dozen "missing" megabytes may limit what features can be
>    implemented.
> 4) If CMA is available, it can allocate large continuous chunks even after
>    the system has run for some time.
> 
> Goals
> =====
> 
> The goal of this work is to start with a small software IO TLB at boot and
> expand it later when/if needed.
> 
> Design
> ======
> 
> This version of the patch series retains the current slot allocation
> algorithm with multiple areas to reduce lock contention, but additional
> slots can be added when necessary.
> 
> These alternatives have been considered:
> 
> - Allocate and free buffers as needed using direct DMA API. This works
>   quite well, except in CoCo VMs where each allocation/free requires
>   decrypting/encrypting memory, which is a very expensive operation.
> 
> - Allocate a very large software IO TLB at boot, but allow to migrate pages
>   to/from it (like CMA does). For systems with CMA, this would mean two big
>   allocations at boot. Finding the balance between CMA, SWIOTLB and rest of
>   available RAM can be challenging. More importantly, there is no clear
>   benefit compared to allocating SWIOTLB memory pools from the CMA.
> 
> Implementation Constraints
> ==========================
> 
> These constraints have been taken into account:
> 
> 1) Minimize impact on devices which do not benefit from the change.
> 2) Minimize the number of memory decryption/encryption operations.
> 3) Avoid contention on a lock or atomic variable to preserve parallel
>    scalability.
> 
> Additionally, the software IO TLB code is also used to implement restricted
> DMA pools. These pools are restricted to a pre-defined physical memory
> region and must not use any other memory. In other words, dynamic
> allocation of memory pools must be disabled for restricted DMA pools.
> 
> Data Structures
> ===============
> 
> The existing struct io_tlb_mem is the central type for a SWIOTLB allocator,
> but it now contains multiple memory pools::
> 
>   io_tlb_mem
>   +---------+   io_tlb_pool
>   | SWIOTLB | 	+-------+   +-------+   +-------+
>   |allocator|-->|default|-->|dynamic|-->|dynamic|-->...
>   |    	    |  	|memory |   |memory |   |memory |
>   +---------+ 	| pool  |   | pool  |   | pool  |
> 	      	+-------+   +-------+   +-------+
> 
> The allocator structure contains global state (such as flags and counters)
> and structures needed to schedule new allocations. Each memory pool
> contains the actual buffer slots and metadata. The first memory pool in the
> list is the default memory pool allocated statically at early boot.
> 
> New memory pools are allocated from a kernel worker thread. That's because
> bounce buffers are allocated when mapping a DMA buffer, which may happen in
> interrupt context where large atomic allocations would probably fail.
> Allocation from process context is much more likely to succeed, especially
> if it can use CMA.
> 
> Nonetheless, the onset of a load spike may fill up the SWIOTLB before the
> worker has a chance to run. In that case, try to allocate a small transient
> memory pool to accommodate the request. If memory is encrypted and the
> device cannot do DMA to encrypted memory, this buffer is allocated from the
> coherent atomic DMA memory pool. Reducing the size of SWIOTLB may therefore
> require increasing the size of the coherent pool with the "coherent_pool"
> command-line parameter.
> 
> Performance
> ===========
> 
> All testing compared a vanilla v6.4-rc6 kernel with a fully patched
> kernel. The kernel was booted with "swiotlb=force" to allow stress-testing
> the software IO TLB on a high-performance device that would otherwise not
> need it. CONFIG_DEBUG_FS was set to 'y' to match the configuration of
> popular distribution kernels; it is understood that parallel workloads
> suffer from contention on the recently added debugfs atomic counters.
> 
> These benchmarks were run:
> 
> - small: single-threaded I/O of 4 KiB blocks,
> - big: single-threaded I/O of 64 KiB blocks,
> - 4way: 4-way parallel I/O of 4 KiB blocks.
> 
> In all tested cases, the default 64 MiB SWIOTLB would be sufficient (but
> wasteful). The "default" pair of columns shows performance impact when
> booted with 64 MiB SWIOTLB (i.e. current state). The "growing" pair of
> columns shows the impact when booted with a 1 MiB initial SWIOTLB, which
> grew to 5 MiB at run time. The "var" column in the tables below is the
> coefficient of variance over 5 runs of the test, the "diff" column is the
> difference in read-write I/O bandwidth (MiB/s). The very first column is
> the coefficient of variance in the results of the base unpatched kernel.
> 
> First, on an x86 VM against a QEMU virtio SATA driver backed by a RAM-based
> block device on the host:
> 
> 	base	   default	   growing
> 	var	var	diff	var	diff
> small	1.96%	0.47%	-1.5%	0.52%	-2.2%
> big	2.03%	1.35%	+0.9%	2.22%	+2.9%
> 4way	0.80%	0.45%	-0.7%	1.22%	<0.1%
> 
> Second, on a Raspberry Pi4 with 8G RAM and a class 10 A1 microSD card:
> 
> 	base	   default	   growing
> 	var	var	diff	var	diff
> small	1.09%	1.69%	+0.5%	2.14%	-0.2%
> big	0.03%	0.28%	-0.5%	0.03%	-0.1%
> 4way	5.15%	2.39%	+0.2%	0.66%	<0.1%
> 
> Third, on a CoCo VM. This was a bigger system, so I also added a 24-thread
> parallel I/O test:
> 
> 	base	   default	   growing
> 	var	var	diff	var	diff
> small	2.41%	6.02%	+1.1%	10.33%	+6.7%
> big	9.20%	2.81%	-0.6%	16.84%	-0.2%
> 4way	0.86%	2.66%	-0.1%	 2.22%	-4.9%
> 24way	3.19%	6.19%	+4.4%	 4.08%	-5.9%
> 
> Note the increased variance of the CoCo VM, although the host was not
> otherwise loaded. These are caused by the first run, which includes the
> overhead of allocating additional bounce buffers and sharing them with the
> hypervisor. The system was not rebooted between successive runs.
> 
> Parallel tests suffer from a reduced number of areas in the dynamically
> allocated memory pools. This can be improved by allocating a larger pool
> from CMA (not implemented in this series yet).
> 
> I have no good explanation for the increase in performance of the
> 24-thread I/O test with the default (non-growing) memory pool. Although the
> difference is within variance, it seems to be real. The average bandwidth
> is consistently above that of the unpatched kernel.
> 
> To sum it up:
> 
> - All workloads benefit from reduced memory footprint.
> - No performance regressions have been observed with the default size of
>   the software IO TLB.
> - Most workloads retain their former performance even if the software IO
>   TLB grows at run time.
> 

For the driver-core touched portions:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
