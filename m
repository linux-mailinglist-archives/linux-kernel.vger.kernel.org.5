Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653F68053E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjLEMMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346969AbjLELkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:40:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211779A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:40:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96643C433C8;
        Tue,  5 Dec 2023 11:40:49 +0000 (UTC)
Date:   Tue, 5 Dec 2023 11:40:47 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     ankita@nvidia.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, jgg@nvidia.com,
        oliver.upton@linux.dev, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, will@kernel.org, ardb@kernel.org,
        akpm@linux-foundation.org, gshan@redhat.com, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com, mochs@nvidia.com,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org, lpieralisi@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZW8MP2tDt4_9ROBz@arm.com>
References: <20231205033015.10044-1-ankita@nvidia.com>
 <86fs0hatt3.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fs0hatt3.wl-maz@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Lorenzo, he really needs to be on this thread.

On Tue, Dec 05, 2023 at 09:21:28AM +0000, Marc Zyngier wrote:
> On Tue, 05 Dec 2023 03:30:15 +0000,
> <ankita@nvidia.com> wrote:
> > From: Ankit Agrawal <ankita@nvidia.com>
> > 
> > Currently, KVM for ARM64 maps at stage 2 memory that is considered device
> > (i.e. it is not RAM) with DEVICE_nGnRE memory attributes; this setting
> > overrides (as per the ARM architecture [1]) any device MMIO mapping
> > present at stage 1, resulting in a set-up whereby a guest operating
> > system cannot determine device MMIO mapping memory attributes on its
> > own but it is always overridden by the KVM stage 2 default.
[...]
> Despite the considerable increase in the commit message length, a
> number of questions are left unanswered:
> 
> - Shameer reported a regression on non-FWB systems, breaking device
>   assignment:
> 
>   https://lore.kernel.org/all/af13ed63dc9a4f26a6c958ebfa77d78a@huawei.com/

This referred to the first patch in the old series which was trying to
make the Stage 2 cacheable based on the vma attributes. That patch has
been dropped for now. It would be good if Shameer confirms this was the
problem.

> - Will had unanswered questions in another part of the thread:
> 
>   https://lore.kernel.org/all/20231013092954.GB13524@willie-the-truck/
> 
>   Can someone please help concluding it?

Is this about reclaiming the device? I think we concluded that we can't
generalise this beyond PCIe, though not sure there was any formal
statement to that thread. The other point Will had was around stating
in the commit message why we only relax this to Normal NC. I haven't
checked the commit message yet, it needs careful reading ;).

> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index d14504821b79..1cb302457d3f 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -1071,7 +1071,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
> >  	struct kvm_mmu_memory_cache cache = { .gfp_zero = __GFP_ZERO };
> >  	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
> >  	struct kvm_pgtable *pgt = mmu->pgt;
> > -	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_DEVICE |
> > +	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_NORMAL_NC |
> >  				     KVM_PGTABLE_PROT_R |
> >  				     (writable ? KVM_PGTABLE_PROT_W : 0);
> 
> Doesn't this affect the GICv2 VCPU interface, which is effectively a
> shared peripheral, now allowing a guest to affect another guest's
> interrupt distribution? If that is the case, this needs to be fixed.
> 
> In general, I don't think this should be a blanket statement, but be
> limited to devices that we presume can deal with this (i.e. PCIe, and
> not much else).

Based on other on-list and off-line discussions, I came to the same
conclusion that we can't relax this beyond PCIe. How we do this, it's up
for debate. Some ideas:

- something in the vfio-pci driver like a new VM_* flag that KVM can
  consume (hard sell for an arch-specific thing)

- changing the vfio-pci driver to allow WC and NC mappings (x86
  terminology) with additional knowledge about what it can safely map
  as NC. KVM would mimic the vma attributes (it doesn't eliminate the
  alias though, the guest can always go for Device while the VMM for
  Normal)

- some per-SoC pfn ranges that are permitted as Normal NC. Can the arch
  code figure out where these PCIe BARs are or is it only the vfio-pci
  driver? I guess we can sort something out around the PCIe but I'm not
  familiar with this subsystem. The alternative is some "safe" ranges in
  firmware tables, assuming the firmware configures the PCIe BARs
  location

-- 
Catalin
