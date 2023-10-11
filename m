Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0FA7C5A79
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjJKRqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjJKRqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:46:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D909D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:45:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767B8C433C7;
        Wed, 11 Oct 2023 17:45:55 +0000 (UTC)
Date:   Wed, 11 Oct 2023 18:45:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        will@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Message-ID: <ZSbfUNLwDkaYL4ts@arm.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com>
 <ZR7hKYU1Wj+VTqpO@arm.com>
 <20231005165458.GM682044@nvidia.com>
 <ZSVe0nb02S4kz5D2@arm.com>
 <20231010150502.GM3952@nvidia.com>
 <ZSWHkvhutlnvVLUZ@arm.com>
 <20231010182328.GS3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010182328.GS3952@nvidia.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:23:28PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 10, 2023 at 06:19:14PM +0100, Catalin Marinas wrote:
> > This has been fixed in newer architecture versions but we haven't
> > added Linux support for it yet (and there's no hardware available
> > either). AFAIK, there's no MTE support for CXL-attached memory at
> > the moment in the current interconnects, so better not pretend it's
> > general purpose memory that supports all the features.
> 
> I don't know much about MTE, but the use case imagined for CXL memory
> allows the MM to exchange any system page with a CXL page. So there
> cannot be a behavioral difference.
> 
> Can usespace continue to use tagged pointers even if the mm has moved
> the pages to CXL that doesn't support it?

That would lead to external aborts in the worst case or just losing tags
in the best. But none of them ideal.

> The main purpose for this is to tier VM memory, so having CXL
> behaviorally different in a VM seems fatal to me.

Yes, that's why if you can't tell the memory supports MTE, either it
should not be given to a guest with KVM_CAP_ARM_MTE or MTE gets disabled
in the guest.

> Linux drivers need a way to understand this, like we can't have a CXL
> memory pool driver or GPU driver calling memremap_pages() and getting
> a somewhat broken system because of MTE incompatibilities. So maybe
> ARM really should block memremap_pages() in case of MTE until
> everything is resolved?

I need to understand this part of the kernel a bit more but see below
(and MTE as it currently stands doesn't play well with server-like
systems, memory hotplug etc.)

> From the mm perspective we can't have two kinds of cachable struct
> pages running around that are functionally different.

From a Linux+MTE perspective, what goes into ZONE_MOVABLE should work
fine, all pages interchangeable (if it doesn't, the hardware is broken).
These are added via the add_memory_resource() hotplug path. If a
platform is known not to support this, it better not advertise MTE as a
feature (the CPUs usually have some tie-off signal when the rest of the
SoC cannot handle MTE). We could claim it's a hardware erratum if it
does.

But for ZONE_DEVICE ranges, these are not guaranteed to support all the
characteristics of the main RAM. I think that's what memremap_pages()
gives us. I'm not too familiar with this part of the kernel but IIUC
that falls under the HMM category, so not interchangeable with the
normal RAM (hotplugged or not).

> > Other than preventing malicious guest behaviour, it depends what the VM
> > needs cacheable access for: some GPU memory that's only used for sharing
> > data and we don't need all features or general purpose memory that a VM
> > can use to run applications from etc. The former may not need all the
> > features (e.g. can skip exclusives) but the latter does.
> 
> Like CXL memory pooling GPU memory is used interchangably with every
> kind of DDR memory in every context. It must be completely transparent
> and interchangable via the mm's migration machinery.

I don't see the mm code doing this but I haven't looked deep enough.
At least not in the way of doing an mmap(MAP_ANONYMOUS) and the kernel
allocating ZONE_DEVICE pages and passing them to the user.

> > > > I've seen something similar in the past with
> > > > LSE atomics (or was it exclusives?) not being propagated. These don't
> > > > make the memory safe for a guest to use as general purpose RAM.
> > > 
> > > At least from a mm perspective, I think it is important that cachable
> > > struct pages are all the same and all interchangable. If the arch
> > > cannot provide this it should not allow the pgmap/memremap to succeed
> > > at all. Otherwise drivers using these new APIs are never going to work
> > > fully right..
> > 
> > Yes, for struct page backed memory, the current assumption is that all
> > are the same, support all CPU features. It's the PFN-based memory where
> > we don't have such guarantees.
> 
> I see it got a bit confused, I am talking about memremap_pages() (ie
> include/linux/memremap.h), not memremap (include/linux/io.h) for
> getting non-struct page memory. It is confusing :|
> 
> memremap_pages() is one of the entry points of the struct page hotplug
> machinery. Things like CXL drivers assume they can hot plug in new
> memory through these APIs and get new cachable struct pages that are
> functionally identical to boot time cachable struct pages.

We have two mechanisms, one in memremap.c and another in
memory_hotplug.c. So far my assumption is that only the memory added by
the latter ends up in ZONE_MOVABLE and can be used by the kernel as any
of the ZONE_NORMAL RAM, transparently to the user. For ZONE_DEVICE
allocations, one would have to explicitly mmap() it via a device fd.

If a VMM wants to mmap() such GPU memory and give it to the guest as
general purpose RAM, it should make sure it has all the characteristics
as advertised by the CPU or disable certain features (if it can).
Currently we don't have a way to tell what such memory supports (neither
ACPI tables nor any hardware probing). The same assumption w.r.t. MTE is
that it doesn't.

> > We have an additional flag, VM_MTE_ALLOWED, only set for mappings backed
> > by struct page. We could probe that in KVM and either fall back to
> > non-cacheable or allow cacheable if MTE is disable at the vCPU level.
> 
> I'm not sure what this does, it is only set by shmem_map? That is
> much stricter than "mappings backed by struct page"

This flag is similar to the VM_MAYWRITE etc. On an mmap(), the vma gets
the VM_MTE_ALLOWED flag if the mapping is MAP_ANONYMOUS (see
arch_calc_vm_flag_bits()) or the (driver) mmap function knows that the
memory supports MTE and sets the flag explicitly. Currently that's only
done in shmem_mmap() as we know where this memory is coming from. When
the user wants an mmap(PROT_MTE), the arch code checks whether
VM_MTE_ALLOWED is set on the vma before allowing tag accesses.

Memory mapped from ZONE_DEVICE won't have such flag set, so
mmap(PROT_MTE) will fail. But for KVM guests, there's no such mmap()
call into the hypervisor. A guest can simply enable MTE at stage 1
without the hypervisor being able to tell.

> Still, I'm not sure how to proceed here - we veered into this MTE
> stuff I don't know we have experiance with yet.

We veered mostly because on arm64 such GPU memory is not guaranteed to
have all the characteristics of the generic RAM. I think only MTE is the
dangerous one and it needs extra care but I wouldn't be surprised if we
notice atomics failing.

It looks like memremap_pages() also takes a memory type and I suspect
it's only safe to map MEMORY_DEVICE_COHERENT into a guest (as generic
RAM). Is there any sanity check on the host kernel side to allow VMM
cacheable mappings only for such memory and not the other
MEMORY_DEVICE_* types?

Going back to KVM, we can relax to cacheable mapping at Stage 2 if the
vma is cacheable and either VM_MTE_ALLOWED is set or KVM_CAP_ARM_MTE is
disabled. From the earlier discussions, we can probably ignore VM_IO
since we won't have a cacheable mapping with this flag. Not sure about
VM_PFNMAP.

-- 
Catalin
