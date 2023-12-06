Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29680785E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442773AbjLFTHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379150AbjLFTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:06:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CADEE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:07:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A909AC433C9;
        Wed,  6 Dec 2023 19:07:00 +0000 (UTC)
Date:   Wed, 6 Dec 2023 19:06:58 +0000
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
Message-ID: <ZXDGUskp1s4Bwbtr@arm.com>
References: <ZW9ezSGSDIvv5MsQ@arm.com>
 <86a5qobkt8.wl-maz@kernel.org>
 <ZW9uqu7yOtyZfmvC@arm.com>
 <868r67blwo.wl-maz@kernel.org>
 <ZXBlmt88dKmZLCU9@arm.com>
 <20231206151603.GR2692119@nvidia.com>
 <ZXCh9N2xp0efHcpE@arm.com>
 <20231206172035.GU2692119@nvidia.com>
 <ZXDEZO6sS1dE_to9@arm.com>
 <20231206190356.GD2692119@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206190356.GD2692119@nvidia.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:03:56PM -0400, Jason Gunthorpe wrote:
> On Wed, Dec 06, 2023 at 06:58:44PM +0000, Catalin Marinas wrote:
> > -------------8<----------------------------
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 1929103ee59a..b89d2dfcd534 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1863,7 +1863,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
> >  	 * See remap_pfn_range(), called from vfio_pci_fault() but we can't
> >  	 * change vm_flags within the fault handler.  Set them now.
> >  	 */
> > -	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> > +	vm_flags_set(vma, VM_VFIO | VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> >  	vma->vm_ops = &vfio_pci_mmap_ops;
> > 
> >  	return 0;
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 418d26608ece..6df46fd7836a 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -391,6 +391,13 @@ extern unsigned int kobjsize(const void *objp);
> >  # define VM_UFFD_MINOR		VM_NONE
> >  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> > 
> > +#ifdef CONFIG_64BIT
> > +#define VM_VFIO_BIT		39
> > +#define VM_VFIO			BIT(VM_VFIO_BIT)
> > +#else
> > +#define VM_VFIO			VM_NONE
> > +#endif
> > +
> >  /* Bits set in the VMA until the stack is in its final location */
> >  #define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
> > -------------8<----------------------------
> > 
> > In KVM, Akita's patch would take this into account, not just rely on
> > "device==true".
> 
> Yes, Ankit let's try this please. I would not call it VM_VFIO though
> 
> VM_VFIO_ALLOW_WC ?

Yeah. I don't really care about the name.

-- 
Catalin
