Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF667CF62A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbjJSLHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjJSLHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:07:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02F511F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:07:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BD1C433C7;
        Thu, 19 Oct 2023 11:07:44 +0000 (UTC)
Date:   Thu, 19 Oct 2023 12:07:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZTEN_oe97VRWbnHb@arm.com>
References: <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
 <20231013134541.GP3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013134541.GP3952@nvidia.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 10:45:41AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 13, 2023 at 02:08:10PM +0100, Catalin Marinas wrote:
> > On Fri, Oct 13, 2023 at 10:29:35AM +0100, Will Deacon wrote:
> > > On Thu, Oct 12, 2023 at 06:26:01PM +0100, Catalin Marinas wrote:
> > > > On Thu, Oct 12, 2023 at 03:48:08PM +0100, Will Deacon wrote:
> > > > > Claiming back the device also seems strange if the guest has been using
> > > > > non-cacheable accesses since I think you could get write merging and
> > > > > reordering with subsequent device accesses trying to reset the device.
> > > > 
> > > > True. Not sure we have a good story here (maybe reinvent the DWB barrier ;)).
> > > 
> > > We do have a good story for this part: use Device-nGnRE!
> > 
> > Don't we actually need Device-nGnRnE for this, coupled with a DSB for
> > endpoint completion?
> > 
> > Device-nGnRE may be sufficient as a read from that device would ensure
> > that the previous write is observable (potentially with a DMB if
> > accessing separate device regions) but I don't think we do this now
> > either. Even this, isn't it device-specific? I don't know enough about
> > PCIe, posted writes, reordering, maybe others can shed some light.
> > 
> > For Normal NC, if the access doesn't have side-effects (or rather the
> > endpoint is memory-like), I think we are fine. The Stage 2 unmapping +
> > TLBI + DSB (DVM + DVMSync) should ensure that a pending write by the CPU
> > was pushed sufficiently far as not to affect subsequent writes by other
> > CPUs.
> > 
> > For I/O accesses that change some state of the device, I'm not sure the
> > TLBI+DSB is sufficient. But I don't think Device nGnRE is either, only
> > nE + DSB as long as the PCIe device plays along nicely.
> 
> Can someone explain this concern a little more simply please?
> 
> Let's try something simpler. I have no KVM. My kernel driver 
> creates a VMA with pgprot_writecombine (NormalNC). Userpsace does a
> write to the NormalNC and immediately unmaps the VMA
> 
> What is the issue?

The issue is when the device is reclaimed to be given to another
user-space process, do we know the previous transaction reached the
device? With the TLBI + DSB in unmap, we can only tell that a subsequent
map + write (in a new process) is ordered after the write in the old
process. Maybe that's sufficient in most cases.

> And then how does making KVM the thing that creates the NormalNC
> change this?

They are similar.

> Not knowing the whole details, here is my story about how it should work:
> 
> Unmapping the VMA's must already have some NormalNC friendly ordering
> barrier across all CPUs or we have a bigger problem. This barrier
> definately must close write combining.

I think what we have is TLBI + DSB generating the DVM/DVMSync messages
should ensure that the Normal NC writes on other CPUs reach some
serialisation point (not necessarily the device, AFAICT we can't
guarantee end-point completion here).

> VFIO issues a config space write to reset the PCI function.  Config
> space writes MUST NOT write combine with anything. This is already
> impossible for PCIe since they are different TLP types at the PCIe
> level.

Yes, config space writes are fine, vfio-pci even maps them as
Device_nGnRnE. But AFAIK a guest won't have direct access to the config
space.

> By the PCIe rules, config space write must order strictly after all
> other CPU's accesses. Once the reset non-posted write returns back to
> VFIO we know that:
> 
>  1) There is no reference in any CPU page table to the MMIO PFN
>  2) No CPU has pending data in any write buffer
>  3) The interconnect and PCIe fabric have no inflight operations
>  4) The device is in a clean post-reset state

I think from the CPU perspective, we can guarantee that a Normal_NC
write on CPU0 for example reaches a serialisation point before a config
space (Device_nGnRnE) write on CPU1 by the host as long as CPU1 issued a
TLBI+DSB. Now, what I'm not sure is what this serialisation point is. If
it is the PCIe root complex, we are probably fine, we hope it deals with
any ordering between the Normal_NC write and the config space one.

Talking to Will earlier, I think we can deem the PCIe scenario
(somewhat) safe but not as a generic mechanism for other non-PCIe
devices (e.g. platform). With this concern, can we make this Stage 2
relaxation in KVM only for vfio-pci mappings? I don't have an example of
non-PCIe device assignment to figure out how this should work though.

> > knows all the details. The safest is for the VMM to keep it as Device (I
> > think vfio-pci goes for the strongest nGnRnE).
> 
> We are probably going to allow VFIO to let userspace pick if it should
> be pgprot_device or pgprot_writecombine.

I guess that's for the direct use by an application rather than VMM+VM.
IIUC people work around this currently by mapping PCIe BARs as
pgprot_writecombine() via sysfs. Getting vfio-pci to allow different
mappings is probably a good idea, though it doesn't currently help with
the KVM case as we can't force the VMM to know the specifics of the
device it is giving to a guest.

> The alias issue could be resolved by teaching KVM how to insert a
> physical PFN based on some VFIO FD/dmabuf rather than a VMA so that
> the PFNs are never mapped in the hypervisor side.

This should work as well and solves the aliasing problem, though it
requires changes to the VMM as well, not just KVM, which currently
relies on vfio-pci mmap().

-- 
Catalin
