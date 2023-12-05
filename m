Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB4805B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjLEQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjLEQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:22:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1045F9E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:22:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9E8C433C7;
        Tue,  5 Dec 2023 16:22:35 +0000 (UTC)
Date:   Tue, 5 Dec 2023 16:22:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Marc Zyngier <maz@kernel.org>, ankita@nvidia.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, oliver.upton@linux.dev,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, will@kernel.org,
        ardb@kernel.org, akpm@linux-foundation.org, gshan@redhat.com,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        mochs@nvidia.com, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZW9OSe8Z9gAmM7My@arm.com>
References: <20231205033015.10044-1-ankita@nvidia.com>
 <86fs0hatt3.wl-maz@kernel.org>
 <ZW8MP2tDt4_9ROBz@arm.com>
 <20231205130517.GD2692119@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205130517.GD2692119@nvidia.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:05:17AM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 05, 2023 at 11:40:47AM +0000, Catalin Marinas wrote:
> > > - Will had unanswered questions in another part of the thread:
> > > 
> > >   https://lore.kernel.org/all/20231013092954.GB13524@willie-the-truck/
> > > 
> > >   Can someone please help concluding it?
> > 
> > Is this about reclaiming the device? I think we concluded that we can't
> > generalise this beyond PCIe, though not sure there was any formal
> > statement to that thread. The other point Will had was around stating
> > in the commit message why we only relax this to Normal NC. I haven't
> > checked the commit message yet, it needs careful reading ;).
> 
> Not quite, we said reclaiming is VFIO's problem and if VFIO can't
> reliably reclaim a device it shouldn't create it in the first place.
> 
> Again, I think alot of this is trying to take VFIO problems into KVM.
> 
> VFIO devices should not exist if they pose a harm to the system. If
> VFIO decided to create the devices anyhow (eg admin override or
> something) then it is not KVM's job to do any further enforcement.

Yeah, I made this argument in the past. But it's a fair question to ask
since the Arm world is different from x86. Just reusing an existing
driver in a different context may break its expectations. Does Normal NC
access complete by the time a TLBI (for Stage 2) and DSB (DVMsync) is
completed? It does reach some point of serialisation with subsequent
accesses to the same address but not sure how it is ordered with an
access to a different location like the config space used for reset.
Maybe it's not a problem at all or it is safe only for PCIe but it would
be good to get to the bottom of this.

Device-nGnRnE has some stronger rules around end-point completion and
that's what the vfio-pci uses. KVM, however, went for the slightly more
relaxed nGnRE variant which, at least per the Arm ARM, doesn't have
these guarantees.

> Remember, the feedback we got from the CPU architects was that even
> DEVICE_* will experience an uncontained failure if the device tiggers
> an error response in shipping ARM IP.
> 
> The reason PCIe is safe is because the PCI bridge does not generate
> errors in the first place!

That's an argument to restrict this feature to PCIe. It's really about
fewer arguments on the behaviour of other devices. Marc did raise
another issue with the GIC VCPU interface (does this even have a vma in
the host VMM?). That's a class of devices where the mapping is
context-switched, so the TLBI+DSB rules don't help.

> Thus, the way a platform device can actually be safe is if it too
> never generates errors in the first place! Obviously this approach
> works just as well with NORMAL_NC.
> 
> If a platform device does generate errors then we shouldn't expect
> containment at all, and the memory type has no bearing on the
> safety. The correct answer is to block these platform devices from
> VFIO/KVM/etc because they can trigger uncontained failures.

Assuming the error containment is sorted, there are two other issues
with other types of devices:

1. Ordering guarantees on reclaim or context switch

2. Unaligned accesses

On (2), I think PCIe is fairly clear on how the TLPs are generated, so I
wouldn't expect additional errors here. But I have no idea what AMBA/AXI
does here in general. Perhaps it's fine, I don't think we looked into it
as the focus was mostly on PCIe.

So, I think it would be easier to get this patch upstream if we limit
the change to PCIe devices for now. We may relax this further in the
future. Do you actually have a need for non-PCIe devices to support WC
in the guest or it's more about the complexity of the logic to detect
whether it's actually a PCIe BAR we are mapping into the guest? (I can
see some Arm GPU folk asking for this but those devices are not easily
virtualisable).

-- 
Catalin
