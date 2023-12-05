Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97928055E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345436AbjLEN2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjLEN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:28:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27B818C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:28:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AB7C433C7;
        Tue,  5 Dec 2023 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701782901;
        bh=DN0Ck4V6T8maLKGy2DJScQ19aj0jXGmxo0qjkMgLuqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fINV4e0swP3QxF0ev7mBQAvzki1Es9fxlLKrYt4Ml5r6ebyNV47ZFG6KKJE58Sa0C
         3zh32m3cDUj9V9aiRX6klfygHY7Zpag/nUR3YzCt09RaFofNMBfi6QGt0XDc7fBlvZ
         YYHL4xNzxt56xHiSJqB7mte+HCJKJEYPM3/4y67n1Yu+swv5KT4LghhIlT0HhhLs31
         KsBt+NMgbYuzWxiY1Ej3G1zN8rizq2crCh9Nzyb15ZhtgtZJFEPHxMtqV/PbiNc4yY
         4X90gR8CZ55cZR0ozTQqIzuX3V77lEZhQWAI2x9K81K7qN1j6jcpTDu/AB1FujSAMz
         s36dw6OW5eU+g==
Date:   Tue, 5 Dec 2023 14:28:12 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, ankita@nvidia.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, jgg@nvidia.com,
        oliver.upton@linux.dev, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, will@kernel.org, ardb@kernel.org,
        akpm@linux-foundation.org, gshan@redhat.com, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com, mochs@nvidia.com,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.morse@arm.com
Subject: Re: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZW8lbK88bgdmBgl9@lpieralisi>
References: <20231205033015.10044-1-ankita@nvidia.com>
 <86fs0hatt3.wl-maz@kernel.org>
 <ZW8MP2tDt4_9ROBz@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW8MP2tDt4_9ROBz@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+James]

On Tue, Dec 05, 2023 at 11:40:47AM +0000, Catalin Marinas wrote:

[...]

> > - Will had unanswered questions in another part of the thread:
> > 
> >   https://lore.kernel.org/all/20231013092954.GB13524@willie-the-truck/
> > 
> >   Can someone please help concluding it?
> 
> Is this about reclaiming the device? I think we concluded that we can't
> generalise this beyond PCIe, though not sure there was any formal
> statement to that thread. The other point Will had was around stating
> in the commit message why we only relax this to Normal NC. I haven't
> checked the commit message yet, it needs careful reading ;).

1) Reclaiming the device: I wrote a section that was reported in this
   commit log hunk:

   "Relaxing S2 KVM device MMIO mappings to Normal-NC is not expected to
   trigger any issue on guest device reclaim use cases either (i.e.
   device MMIO unmap followed by a device reset) at least for PCIe
   devices, in that in PCIe a device reset is architected and carried
   out through PCI config space transactions that are naturally ordered
   with respect to MMIO transactions according to the PCI ordering
   rules."

   It is not too verbose on purpose - I thought it is too
   complicated to express the details in a commit log but
   we can elaborate on that if it is beneficial, probably
   in /Documentation, not in the log itself.

2) On FWB: I added a full section to the log I posted here:

   https://lore.kernel.org/all/ZUz78gFPgMupew+m@lpieralisi

   but I think Ankit trimmed it and I can't certainly blame anyone
   for that, it is a commit log, it is already hard to digest as it is.

I added James because I think that most of the points I made in the logs
are really RAS related (and without him I would not have understood half
of them :)). It would be very beneficial to everyone to have those
added to kernel documentation - especially to express in architectural
terms why this it is a safe change to make (at least for PCIe devices).

I am happy to work on the documentation changes - let's just agree what
should be done next.

Thanks,
Lorenzo

> > > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > > index d14504821b79..1cb302457d3f 100644
> > > --- a/arch/arm64/kvm/mmu.c
> > > +++ b/arch/arm64/kvm/mmu.c
> > > @@ -1071,7 +1071,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
> > >  	struct kvm_mmu_memory_cache cache = { .gfp_zero = __GFP_ZERO };
> > >  	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
> > >  	struct kvm_pgtable *pgt = mmu->pgt;
> > > -	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_DEVICE |
> > > +	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_NORMAL_NC |
> > >  				     KVM_PGTABLE_PROT_R |
> > >  				     (writable ? KVM_PGTABLE_PROT_W : 0);
> > 
> > Doesn't this affect the GICv2 VCPU interface, which is effectively a
> > shared peripheral, now allowing a guest to affect another guest's
> > interrupt distribution? If that is the case, this needs to be fixed.
> > 
> > In general, I don't think this should be a blanket statement, but be
> > limited to devices that we presume can deal with this (i.e. PCIe, and
> > not much else).
> 
> Based on other on-list and off-line discussions, I came to the same
> conclusion that we can't relax this beyond PCIe. How we do this, it's up
> for debate. Some ideas:
> 
> - something in the vfio-pci driver like a new VM_* flag that KVM can
>   consume (hard sell for an arch-specific thing)
> 
> - changing the vfio-pci driver to allow WC and NC mappings (x86
>   terminology) with additional knowledge about what it can safely map
>   as NC. KVM would mimic the vma attributes (it doesn't eliminate the
>   alias though, the guest can always go for Device while the VMM for
>   Normal)
> 
> - some per-SoC pfn ranges that are permitted as Normal NC. Can the arch
>   code figure out where these PCIe BARs are or is it only the vfio-pci
>   driver? I guess we can sort something out around the PCIe but I'm not
>   familiar with this subsystem. The alternative is some "safe" ranges in
>   firmware tables, assuming the firmware configures the PCIe BARs
>   location
> 
> -- 
> Catalin
