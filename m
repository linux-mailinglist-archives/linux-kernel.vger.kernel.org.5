Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B90B7C7240
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379469AbjJLQQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347336AbjJLQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:16:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3B3E5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:16:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9ACC433C7;
        Thu, 12 Oct 2023 16:16:20 +0000 (UTC)
Date:   Thu, 12 Oct 2023 17:16:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        will@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Message-ID: <ZSgb0WBSsXHHYJT0@arm.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com>
 <ZR7hKYU1Wj+VTqpO@arm.com>
 <20231005165458.GM682044@nvidia.com>
 <ZSVe0nb02S4kz5D2@arm.com>
 <20231010150502.GM3952@nvidia.com>
 <ZSWHkvhutlnvVLUZ@arm.com>
 <20231010182328.GS3952@nvidia.com>
 <ZSbfUNLwDkaYL4ts@arm.com>
 <20231011183839.GC3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011183839.GC3952@nvidia.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 03:38:39PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 11, 2023 at 06:45:52PM +0100, Catalin Marinas wrote:
> > But for ZONE_DEVICE ranges, these are not guaranteed to support all the
> > characteristics of the main RAM. I think that's what memremap_pages()
> > gives us. I'm not too familiar with this part of the kernel but IIUC
> > that falls under the HMM category, so not interchangeable with the
> > normal RAM (hotplugged or not).
> 
> DAX pages use ZONE_DEVICE and they are cachable, and not "HMM".
> 
> They are not fully interchangable, but they get into the page cache,
> they can back .data segements, they could be subject atomics/etc. So
> they should be fully functional like DDR.

Unfortunately the Arm architecture makes the distinction between
"cacheable" and "cacheable tagged". We don't currently have any way of
describing this in firmware tables, so we rely on the hardware or
firmware not advertising MTE if such memory ends up as general purpose.

That said, DAX mappings are safe since the vma would have VM_MTE_ALLOWED
set, so no mmap(PROT_MTE) possible.

> > I don't see the mm code doing this but I haven't looked deep enough.
> > At least not in the way of doing an mmap(MAP_ANONYMOUS) and the kernel
> > allocating ZONE_DEVICE pages and passing them to the user.
> 
> Not ZONE_DEVICE. One popular coherent GPU approach is to use
> ZONE_MOVABLE pages.

OK, so presumably the driver could tell on which architecture it is
running and plug in the memory appropriately (or refuse to). It's a bit
more arch knowledge in a (generic) driver that I'd like but we don't
have a way to describe or probe this yet. Maybe a firmware config would
just turn MTE off in this case (SCTLR_EL3.ATA=0 and some other chicken
bit or tie-off for the ID registers not to advertise MTE).

> > If a VMM wants to mmap() such GPU memory and give it to the guest as
> > general purpose RAM, it should make sure it has all the characteristics
> > as advertised by the CPU or disable certain features (if it can).
> 
> This is the VFIO flow we are talking about here, I think. PFNMAP
> memory that goes into a VM that is cachable.
> 
> > Currently we don't have a way to tell what such memory supports (neither
> > ACPI tables nor any hardware probing). The same assumption w.r.t. MTE is
> > that it doesn't.
> 
> Indeed, but my GPU driver hot plugged it as ZONE_MOVABLE and my VFIO
> driver turned in into PFNMAP.. So these things seem incompatible.

So can we end up with the same pfn mapped in two different vmas, one
backed by struct page and another with VM_PFNMAP (implying no struct
page)? I don't know how this is supposed to work. Even if the memory
supports MTE, we rely on the struct page to track the status of the tags
(the PG_mte_tagged flag). We may get away with this if user_mem_abort()
-> sanitise_mte_tags() -> pfn_to_page() finds a page structure but I'd
actually prevent this path altogether if VM_PFNMAP (well, we may
actually have a bug if we don't already do this).

> > From the earlier discussions, we can probably ignore VM_IO
> > since we won't have a cacheable mapping with this flag. Not sure about
> > VM_PFNMAP.
> 
> PFNMAP is the interesting one for VFIO, at least. Can we use the same
> reasoning that it will be !VM_MTE_ALLOWED and we can close the MTE
> discussion.
> 
> Currently no VFIO driver is doing cachable that has memory that is
> different from DDR memory. So this is sort of theoretical discussion
> about future cachable HW that does use VFIO that does have a
> non-uniformity.
> 
> Maybe that HW should set VM_IO on its VFIO PFN map and obviously not
> use ZONE_MOVABLE?

I think we should only keep VM_IO for memory mapped I/O with side
effects. Other ranges can be VM_PFNMAP if not backed by struct page.

> Where does that leave us for this patch? We check the VM_MTE_ALLOWED
> and check for ZONE_MOVABLE struct pages as one of the conditions for
> NORMAL?

I think we should keep it as simple as possible and, looking at it
again, maybe even ignore vm_page_prot. Two questions though:

1. Does VM_IO imply vm_page_prot never having MT_NORMAL or
   MT_NORMAL_TAGGED?

2. Do all I/O ranges (side-effects, non-RAM) mapped into a guest (and
   which end up in user_mem_abort()) imply VM_IO?

If yes to both, I think something like below would do:

	mte_allowed = kvm_vma_mte_allowed(vma);
	noncacheable = false;				// or 'device' as in user_mem_abort()
	...
	if (vma->flags & VM_IO)				// replaces !pfn_is_map_memory()
		noncacheable = true;
	else if (!mte_allowed && kvm_has_mte())
		noncaheable = true;
	...
	if (noncacheable)
		prot |= KVM_PGTABLE_PROT_DEVICE;	// or the new KVM_PGTABLE_PROT_NC

mte_allowed would cover DAX mappings (and, who knows, some future DAX
mapping may allow MTE and the driver explicitly set the flag). Anything
else hot-plugged into ZONE_MOVABLE should have VM_MTE_ALLOWED set or
MTE disabled altogether.

-- 
Catalin
