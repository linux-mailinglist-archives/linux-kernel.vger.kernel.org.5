Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5427BFF23
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjJJOZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjJJOZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53927AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:25:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDD1C433C8;
        Tue, 10 Oct 2023 14:25:24 +0000 (UTC)
Date:   Tue, 10 Oct 2023 15:25:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        will@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Message-ID: <ZSVe0nb02S4kz5D2@arm.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com>
 <ZR7hKYU1Wj+VTqpO@arm.com>
 <20231005165458.GM682044@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005165458.GM682044@nvidia.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 01:54:58PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 05, 2023 at 05:15:37PM +0100, Catalin Marinas wrote:
> > On Thu, Sep 07, 2023 at 11:14:58AM -0700, ankita@nvidia.com wrote:
> > > From: Ankit Agrawal <ankita@nvidia.com>
> > > Currently KVM determines if a VMA is pointing at IO memory by checking
> > > pfn_is_map_memory(). However, the MM already gives us a way to tell what
> > > kind of memory it is by inspecting the VMA.
> > 
> > Well, it doesn't. It tells us what attributes the user mapped that
> > memory with, not whether it's I/O memory or standard RAM.
> 
> There is VM_IO which is intended to be used for address space with
> side effects.
> 
> And there is VM_PFNMAP which is intended to be used for address space
> without struct page (IO or not)
> 
> And finally we have the pgprot bit which define the cachability.
> 
> Do you have a definition of IO memory that those three things don't
> cover?
> 
> I would propose that, for KVM's purpose, IO memory is marked with
> VM_IO or a non-cachable pgprot
> 
> And "standard RAM" is defined by a cachable pgprot. Linux never makes
> something that is VM_IO cachable.

I think we can safely set a stage 2 Normal NC for a vma with pgprot
other than MT_NORMAL or MT_NORMAL_TAGGED. But the other way around is
not that simple. Just because the VMM was allowed to map it as cacheable
does not mean that it supports all the CPU features. One example is MTE
where we can only guarantee that the RAM given to the OS at boot
supports tagged accesses. I've seen something similar in the past with
LSE atomics (or was it exclusives?) not being propagated. These don't
make the memory safe for a guest to use as general purpose RAM.

I don't have a nice solution, it looks more like the host kernel being
able to trust what the VMM maps and gives to a guest (or we map
everything as Device at Stage 2 as we currently do). An alternative
would be for the host to know which physical address ranges support
which attributes and ignore the vma but not sure we have such
information in the ACPI tables (we can make something up for DT).

> > > Unfortunately when FWB is not enabled, the kernel expects to naively do
> > > cache management by flushing the memory using an address in the
> > > kernel's map. This does not work in several of the newly allowed
> > > cases such as dcache_clean_inval_poc(). Check whether the targeted pfn
> > > and its mapping KVA is valid in case the FWB is absent before continuing.
> > 
> > I would only allow cacheable stage 2 mappings if FWB is enabled.
> > Otherwise we end up with a mismatch between the VMM mapping and whatever
> > the guest may do.
> 
> Does it need to be stronger? If FWB is disabled and the cache flush
> works then what is the issue?

I was thinking more about keeping things simpler and avoid any lack of
coherence between the VMM and the VM, in case the latter maps it as
Normal NC. But if the VMM doesn't touch it, the initial cache
maintenance by the KVM would do.

> I think there are two issues here. 
> 
> 1) KVM uses pfn_is_map_memory() which does not cover all our modern
> NUMA and memory hotplug cases for normal struct page backed cachable
> memory.
> 
> 2) KVM doesn't work with normal cachable memory that does not have
> struct pages.
> 
> For 1 the test should be 'does the pfn have a struct page, does the
> struct page refer to cachable memory?'
> 
> For 2 the test should be 'does the VMA have pgprot = cachable,
> VM_PFNMAP and not VM_IO (both implied)'

See above on the characteristics of the memory. If some of them are not
supported, it's probably fine (atomics not working) but others like MTE
accesses could either cause external aborts or access random addresses
from elsewhere. Currently we rely on pfn_is_map_memory() for this but we
need a way to tell that other ranges outside the initial RAM supports
all features. IOW, is any of this memory (mapped as cacheable in the
VMM) special purpose with only a subset of the CPU features supported?

-- 
Catalin
