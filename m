Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1776E80CFBC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344125AbjLKPh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344132AbjLKPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:37:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29FDFE4;
        Mon, 11 Dec 2023 07:37:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61CBBFEC;
        Mon, 11 Dec 2023 07:38:16 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86C763F738;
        Mon, 11 Dec 2023 07:37:25 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:37:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@lst.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] ACPI/IORT: Handle memory address size limits as
 limits
Message-ID: <ZXcssPaaDtqADKp6@FVFF77S0Q05N.cambridge.arm.com>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
 <20231211132757.GE25681@willie-the-truck>
 <91b22090-485f-49c9-a536-849fd7f92f8e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b22090-485f-49c9-a536-849fd7f92f8e@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:01:27PM +0000, Robin Murphy wrote:
> On 2023-12-11 1:27 pm, Will Deacon wrote:
> > On Wed, Nov 29, 2023 at 05:43:00PM +0000, Robin Murphy wrote:
> > > Return the Root Complex/Named Component memory address size limit as an
> > > inclusive limit value, rather than an exclusive size.  This saves us
> > > having to special-case 64-bit overflow, and simplifies our caller too.
> > > 
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   drivers/acpi/arm64/dma.c  |  9 +++------
> > >   drivers/acpi/arm64/iort.c | 18 ++++++++----------
> > >   include/linux/acpi_iort.h |  4 ++--
> > >   3 files changed, 13 insertions(+), 18 deletions(-)
> > 
> > [...]
> > 
> > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > index 6496ff5a6ba2..eb64d8e17dd1 100644
> > > --- a/drivers/acpi/arm64/iort.c
> > > +++ b/drivers/acpi/arm64/iort.c
> > > @@ -1367,7 +1367,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
> > >   { return -ENODEV; }
> > >   #endif
> > > -static int nc_dma_get_range(struct device *dev, u64 *size)
> > > +static int nc_dma_get_range(struct device *dev, u64 *limit)
> > >   {
> > >   	struct acpi_iort_node *node;
> > >   	struct acpi_iort_named_component *ncomp;
> > > @@ -1384,13 +1384,12 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
> > >   		return -EINVAL;
> > >   	}
> > > -	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
> > > -			1ULL<<ncomp->memory_address_limit;
> > > +	*limit = (1ULL << ncomp->memory_address_limit) - 1;
> > 
> > The old code handled 'ncomp->memory_address_limit >= 64' -- why is it safe
> > to drop that? You mention it in the cover letter, so clearly I'm missing
> > something!
> 
> Because an unsigned shift by 64 or more generates 0 (modulo 2^64), 

I'm pretty sure that regardless of whether a type is signed, shifting more than
the type's width is undefined behaviour. That causes GCC to scream at compile
time:

|   CC      arch/arm64/kernel/setup.o
| arch/arm64/kernel/setup.c: In function 'shift_test':
| arch/arm64/kernel/setup.c:295:20: warning: left shift count >= width of type [-Wshift-count-overflow]
|   295 |         return 1UL << 64;
|       |                    ^~

... and a UBSAN splat:

| ================================================================================
| UBSAN: shift-out-of-bounds in arch/arm64/kernel/setup.c:295:13
| shift exponent 64 is too large for 64-bit type 'long unsigned int'
| CPU: 0 PID: 0 Comm: swapper Not tainted 6.7.0-rc1-00005-g06034455cb74-dirty #3
| Call trace:
|  dump_backtrace+0x90/0xe8
|  show_stack+0x18/0x24
|  dump_stack_lvl+0x48/0x60
|  dump_stack+0x18/0x24
|  __ubsan_handle_shift_out_of_bounds+0x114/0x244
|  shift_test+0x24/0x34
|  setup_arch+0x238/0x68c
|  start_kernel+0x70/0x610
|  __primary_switched+0xbc/0xc4
| ================================================================================

Mark.

> thus
> subtracting 1 results in the correct all-bits-set value for an inclusive
> 64-bit limit.
> 
> Thanks,
> Robin.
> 
> > >   	return 0;
> > >   }
> > > -static int rc_dma_get_range(struct device *dev, u64 *size)
> > > +static int rc_dma_get_range(struct device *dev, u64 *limit)
> > >   {
> > >   	struct acpi_iort_node *node;
> > >   	struct acpi_iort_root_complex *rc;
> > > @@ -1408,8 +1407,7 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
> > >   		return -EINVAL;
> > >   	}
> > > -	*size = rc->memory_address_limit >= 64 ? U64_MAX :
> > > -			1ULL<<rc->memory_address_limit;
> > > +	*limit = (1ULL << rc->memory_address_limit) - 1;
> > 
> > Same thing here.
> > 
> > Will
