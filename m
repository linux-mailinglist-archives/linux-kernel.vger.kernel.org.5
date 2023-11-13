Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAAE7EA23A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjKMRlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:41:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8604910EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:41:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F11C433C8;
        Mon, 13 Nov 2023 17:41:41 +0000 (UTC)
Date:   Mon, 13 Nov 2023 17:41:39 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZVJf06MoJs9Ld75C@arm.com>
References: <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
 <ZUz78gFPgMupew+m@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUz78gFPgMupew+m@lpieralisi>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

Thanks for putting this together. It looks fine to me, just some general
comments below.

On Thu, Nov 09, 2023 at 04:34:10PM +0100, Lorenzo Pieralisi wrote:
> Updated commit log (it might be [is] too verbose) below, it should probably
> be moved into a documentation file but to do that I should decouple
> it from this changeset (ie a document explaining memory attributes
> and error containment for ARM64 - indipendent from KVM S2 defaults).
> 
> I'd also add a Link: to the lore archive entry for reference (did not
> add it in the log below).
> 
> Please let me know what's the best option here.

It would be good to have this under Documentation/arch/arm64/, though as
a document at the end of the series describing what the new behaviour
is, the kernel/KVM expectations (after the patches have been applied).
We could even submit it separately once we agreed on how the series
looks like.

> -- >8 --
> Currently, KVM for ARM64 maps at stage 2 memory that is
> considered device (ie it is not RAM) with DEVICE_nGnRE
> memory attributes; this setting overrides (as per the ARM
> architecture [1]) any device MMIO mapping present at stage
> 1, resulting in a set-up whereby a guest operating system
> can't determine device MMIO mapping memory attributes on its
> own but it is always overriden by the KVM stage 2 default.

To be fully correct, stage 1 and stage 2 attributes combine in a way
that results in the more restrictive properties, so not a simple
override. But to keep things simple, especially if this part only goes
in the commit log, leave it as is.

> This set-up does not allow guest operating systems to select
> device memory attributes on a page by page basis independently

Not sure it's even worth specifying "page by page". It just doesn't
allow the guest to relax the device map memory attributes at all.

> from KVM stage-2 mappings (refer to [1], "Combining stage 1 and stage
> 2 memory type attributes"), which turns out to be an issue in that
> guest operating systems (eg Linux) may request to map
> devices MMIO regions with memory attributes that guarantee
> better performance (eg gathering attribute - that for some
> devices can generate larger PCIe memory writes TLPs)
> and specific operations (eg unaligned transactions) such as
> the NormalNC memory type.

Another case is correct guest behaviour where it would not expect
unaligned accesses from Normal NC mappings.

> The default device stage 2 mapping was chosen in KVM
> for ARM64 since it was considered safer (ie it would
> not allow guests to trigger uncontained failures
> ultimately crashing the machine) but this turned out
> to be imprecise.

s/imprecise/asynchronous (SError)/

Another reason was probably that it matches the default VFIO mapping
(though the latter is slightly stricter as in Device_nGnRnE).

> Failures containability is a property of the platform
> and is independent from the memory type used for MMIO
> device memory mappings.
> 
> Actually, DEVICE_nGnRE memory type is even more problematic
> than eg Normal-NC memory type in terms of faults containability
> in that eg aborts triggered on DEVICE_nGnRE loads cannot be made,
> architecturally, synchronous (ie that would imply that the processor
> should issue at most 1 load transaction at a time - ie it can't pipeline
> them - otherwise the synchronous abort semantics would break the
> no-speculation attribute attached to DEVICE_XXX memory).
> 
> This means that regardless of the combined stage1+stage2 mappings a
> platform is safe if and only if device transactions cannot trigger
> uncontained failures and that in turn relies on platform
> capabilities and the device type being assigned (ie PCIe AER/DPC
> error containment and RAS architecture[3]); therefore the default
> KVM device stage 2 memory attributes play no role in making device
> assignment safer for a given platform (if the platform design
> adheres to design guidelines outlined in [3]) and therefore can
> be relaxed.
> 
> For all these reasons, relax the KVM stage 2 device
> memory attributes from DEVICE_nGnRE to Normal-NC.

I think this covers the safety aspect w.r.t. uncontained errors.

> A different Normal memory type default at stage-2
> (eg Normal Write-through) could have been chosen
> instead of Normal-NC but Normal-NC was chosen
> because:
> 
> - Its attributes are well-understood compared to
>   other Normal memory types for MMIO mappings

Ideally we'd have gone for Device_GRE from a performance perspective but
it doesn't support unaligned accesses. Basically at this stage we don't
want cacheable accesses to MMIO until we gain a better understanding on
what the impact would be.

> - On systems implementing S2FWB (FEAT_S2FWB), that's the only sensible
>   default for normal memory types. For systems implementing
>   FEAT_S2FWB (see [1] D8.5.5 S2=stage-2 - S2 MemAttr[3:0]), the options
>   to choose the memory types are as follows:
> 
>   if S2 MemAttr[2] == 0, the mapping defaults to DEVICE_XXX
>   (XXX determined by S2 MemAttr[1:0]). This is what we have
>   today (MemAttr[2:0] == 0b001) and therefore it is not described
>   any further.
> 
>   if S2 MemAttr[2] == 1, there are the following options:
>  
>   S2 MemAttr[2:0] | Resulting mapping
>   -----------------------------------------------------------------------------
>   0b101           | Prevent the guest from selecting cachable memory type, it
> 		  | allows it to choose Device-* or Normal-NC
>   0b110           | It forces write-back memory type; it breaks MMIO.
>   0b111           | Allow the VM to select any memory type including cachable.
> 		  | It is unclear whether this is safe from a platform
> 		  | perspective, especially wrt uncontained failures and
> 		  | cacheability (eg device reclaim/reset and cache
> 		  | maintenance).
>   ------------------------------------------------------------------------------
> 
>   - For !FEAT_S2FWB systems, it is logical to choose a default S2 mapping
>     identical to FEAT_S2FWB (that basically would force Normal-NC, see
>     option S2 MemAttr[2:0] == 0b101 above), to guarantee a coherent approach
>     between the two

Is this text only to say that we can't use write-through memory because
with FEAT_S2FWB it is forced cacheable? I'd probably keep in simple and
just state that we went for Normal NC to avoid cache
allocation/snooping.

It just crossed my mind, I think we also assume here that on platforms
with transparent caches, Normal NC of MMIO won't be upgraded to
cacheable (that's irrespective of KVM). This may need to be stated in
some Arm BSA document (I'm not aware of any arch rules that prevent this
from happening). AFAIK, platforms with transparent caches only do this
for the memory ranges where the DRAM is expected.

> Relaxing S2 KVM device MMIO mappings to Normal-NC is not expected to
> trigger any issue on guest device reclaim use cases either (ie device
> MMIO unmap followed by a device reset) at least for PCIe devices, in that
> in PCIe a device reset is architected and carried out through PCI config
> space transactions that are naturally ordered wrt MMIO transactions
> according to the PCI ordering rules.

We could state this in a doc that for device pass-through, there's an
expectation that the device can be reclaimed along the lines of the PCIe
reset behaviour. If one admin decides to allow device pass-through for
some unsafe devices/platforms, it's their problem really. I don't think
a Device_nGnRE mapping would help in those cases anyway.

This could be expanded to Normal Cacheable at some point but KVM would
have to do cache maintenance after unmapping the device from the guest
(so let's leave this for a separate series).

> Having Normal-NC S2 default puts guests in control (thanks to
> stage1+stage2 combined memory attributes rules [1]) of device MMIO
> regions memory mappings, according to the rules described in [1]
> and summarized here ([(S1) - stage1], [(S2) - stage 2]):
> 
> S1	     |  S2	     | Result
> NORMAL-WB    |  NORMAL-NC    | NORMAL-NC
> NORMAL-WT    |  NORMAL-NC    | NORMAL-NC
> NORMAL-NC    |  NORMAL-NC    | NORMAL-NC
> DEVICE<attr> |  NORMAL-NC    | DEVICE<attr>
> 
> It is worth noting that currently, to map devices MMIO space to user
> space in a device pass-through use case the VFIO framework applies memory
> attributes derived from pgprot_noncached() settings applied to VMAs, which
> result in device-nGnRnE memory attributes for the stage-1 VMM mappings.
> 
> This means that a userspace mapping for device MMIO space carried
> out with the current VFIO framework and a guest OS mapping for the same
> MMIO space may result in a mismatched alias as described in [2].
> 
> Defaulting KVM device stage-2 mappings to Normal-NC attributes does not change
> anything in this respect, in that the mismatched aliases would only affect
> (refer to [2] for a detailed explanation) ordering between the userspace and
> GuestOS mappings resulting stream of transactions (ie it does not cause loss of
> property for either stream of transactions on its own), which is harmless
> given that the userspace and GuestOS access to the device is carried
> out through independent transactions streams.

I think this was a recent clarification from the architects (in private
emails). My understanding for some time has been that the mere presence
of a Normal alias would affect the semantics of the user (VMM) accesses
to the Device mapping. Apparently, this only matters if there is some
expected ordering between the user (VMM) access and the VM one with
different aliases. I can't tell where the mismatched aliases rules state
this but I haven't read them in a while.

-- 
Catalin
