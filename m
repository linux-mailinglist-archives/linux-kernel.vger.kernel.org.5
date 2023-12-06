Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4F80784A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379117AbjLFS6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379188AbjLFS6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:58:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B351BD66
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:58:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19114C433C8;
        Wed,  6 Dec 2023 18:58:46 +0000 (UTC)
Date:   Wed, 6 Dec 2023 18:58:44 +0000
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
Message-ID: <ZXDEZO6sS1dE_to9@arm.com>
References: <20231205164318.GG2692119@nvidia.com>
 <86bkb4bn2v.wl-maz@kernel.org>
 <ZW9ezSGSDIvv5MsQ@arm.com>
 <86a5qobkt8.wl-maz@kernel.org>
 <ZW9uqu7yOtyZfmvC@arm.com>
 <868r67blwo.wl-maz@kernel.org>
 <ZXBlmt88dKmZLCU9@arm.com>
 <20231206151603.GR2692119@nvidia.com>
 <ZXCh9N2xp0efHcpE@arm.com>
 <20231206172035.GU2692119@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206172035.GU2692119@nvidia.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:20:35PM -0400, Jason Gunthorpe wrote:
> On Wed, Dec 06, 2023 at 04:31:48PM +0000, Catalin Marinas wrote:
> > > This would be fine, as would a VMA flag. Please pick one :)
> > > 
> > > I think a VMA flag is simpler than messing with pgprot.
> > 
> > I guess one could write a patch and see how it goes ;).
> 
> A lot of patches have been sent on this already :(

But not one with a VM_* flag. I guess we could also add a VM_VFIO flag
which implies KVM has less restrictions on the memory type. I think
that's more bike-shedding.

The key point is that we don't want to relax this for whatever KVM may
map in the guest but only for certain devices. Just having a vma may not
be sufficient, we can't tell where that vma came from.

So for the vfio bits, completely untested:

-------------8<----------------------------
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1929103ee59a..b89d2dfcd534 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1863,7 +1863,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	 * See remap_pfn_range(), called from vfio_pci_fault() but we can't
 	 * change vm_flags within the fault handler.  Set them now.
 	 */
-	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	vm_flags_set(vma, VM_VFIO | VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_ops = &vfio_pci_mmap_ops;

 	return 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..6df46fd7836a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -391,6 +391,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_UFFD_MINOR		VM_NONE
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */

+#ifdef CONFIG_64BIT
+#define VM_VFIO_BIT		39
+#define VM_VFIO			BIT(VM_VFIO_BIT)
+#else
+#define VM_VFIO			VM_NONE
+#endif
+
 /* Bits set in the VMA until the stack is in its final location */
 #define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
-------------8<----------------------------

In KVM, Akita's patch would take this into account, not just rely on
"device==true".

> > > > If we want the VMM to drive this entirely, we could add a new mmap()
> > > > flag like MAP_WRITECOMBINE or PROT_WRITECOMBINE. They do feel a bit
> > > 
> > > As in the other thread, we cannot unconditionally map NORMAL_NC into
> > > the VMM.
> > 
> > I'm not suggesting this but rather the VMM map portions of the BAR with
> > either Device or Normal-NC, concatenate them (MAP_FIXED) and pass this
> > range as a memory slot (or multiple if a slot doesn't allow multiple
> > vmas).
> 
> The VMM can't know what to do. We already talked about this. The VMM
> cannot be involved in the decision to make pages NORMAL_NC or
> not. That idea ignores how actual devices work.
[...]
> > Are the Device/Normal offsets within a BAR fixed, documented in e.g. the
> > spec or this is something configurable via some MMIO that the guest
> > does.
> 
> No, it is fully dynamic on demand with firmware RPCs.

I think that's a key argument. The VMM cannot, on its own, configure the
BAR and figure a way to communicate this to the guest. We could invent
some para-virtualisation/trapping mechanism but that's unnecessarily
complicated. In the DPDK case, DPDK both configures and interacts with
the device. In the VMM/VM case, we need the VM to do this, we can't
split the configuration in VMM and interaction with the device in the
VM.

-- 
Catalin
