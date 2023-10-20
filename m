Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88917D112C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377468AbjJTOEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376984AbjJTOEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:04:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4C093
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:04:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3145C433C7;
        Fri, 20 Oct 2023 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697810645;
        bh=jGn4CadJUGcXIko3cgZzK66leI6kgRcHdeUCJtNcI0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYFEkk/IKlj8DgLmPwUeClMRfq90ihEuyx4yBSkcedVTNV2yJxDvd+OsLv3APhEwV
         gbNf84Kh/fml3EUS9EBW41n5YkPP7+9sq0NW5kBqJUGfp4Yg4M5LW/Hy4CcBYi32AW
         yJvS4FgEl8L4weSx1t9K7jvndBgl7RaFAUK2LdqRAv4NMJkxc6Bp2XsoqBMtnfZ7UD
         /uP63cRltfuqbX1WVXlvpPN3I0I4Uw4wEIgM/bUIP1Rv0EYKBktdwRj7z6TgO4WnKd
         5zaSAg2zy3xB4fcmHpccuc8ckj4Nw9bfiUzZRZ2QEYoXuNSm9U/jU8L9Ljucb3dDOE
         t9rUyTLVj36HA==
Date:   Fri, 20 Oct 2023 16:03:57 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZTKIzZk3lGATLkGz@lpieralisi>
References: <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
 <20231013134541.GP3952@nvidia.com>
 <ZTEN_oe97VRWbnHb@arm.com>
 <20231019115142.GQ3952@nvidia.com>
 <ZTJizmxV4Gtb4g3S@arm.com>
 <20231020114719.GE3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020114719.GE3952@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 08:47:19AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 20, 2023 at 12:21:50PM +0100, Catalin Marinas wrote:
> > On Thu, Oct 19, 2023 at 08:51:42AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Oct 19, 2023 at 12:07:42PM +0100, Catalin Marinas wrote:
> > > > Talking to Will earlier, I think we can deem the PCIe scenario
> > > > (somewhat) safe but not as a generic mechanism for other non-PCIe
> > > > devices (e.g. platform). With this concern, can we make this Stage 2
> > > > relaxation in KVM only for vfio-pci mappings? I don't have an example of
> > > > non-PCIe device assignment to figure out how this should work though.
> > > 
> > > It is not a KVM problem. As I implied above it is VFIO's
> > > responsibility to reliably reset the device, not KVMs. If for some
> > > reason VFIO cannot do that on some SOC then VFIO devices should not
> > > exist.
> > > 
> > > It is not KVM's job to double guess VFIO's own security properties.
> > 
> > I'd argue that since KVM is the one relaxing the memory attributes
> > beyond what the VFIO driver allows the VMM to use, it is KVM's job to
> > consider the security implications. This is fine for vfio-pci and
> > Normal_NC but I'm not sure we can generalise.
> 
> I can see that, but I belive we should take this responsibility into
> VFIO as a requirement. As I said in the other email we do want to
> extend VFIO to support NormalNC VMAs for DPDK, so we need to take this
> anyhow.
> 
> > > Specifically about platform the generic VFIO platform driver is the
> > > ACPI based one. If the FW provides an ACPI method for device reset
> > > that is not properly serializing, that is a FW bug. We can quirk it in
> > > VFIO and block using those devices if they actually exist.
> > > 
> > > I expect the non-generic VFIO platform drivers to take care of this
> > > issue internally with, barriers, read from devices, whatver is
> > > required to make their SOCs order properly. Just as I would expect a
> > > normal Linux platform driver to directly manage whatever
> > > implementation specific ordering quirks the SOC may have.
> > 
> > This would be a new requirement if an existing VFIO platform driver
> > relied on all mappings being Device. But maybe that's just theoretical
> > at the moment, are there any concrete examples outside vfio-pci? If not,
> > we can document it as per Lorenzo's suggestion to summarise this
> > discussion under Documentation/.
> 
> My point is if this becomes a real world concern we have a solid
> answer on how to resolve it - fix the VFIO driver to have a stronger
> barrier before reset.

Just to make sure I am parsing this correctly: this case above is
related to a non-PCI VFIO device passthrough where a guest would want to
map the device MMIO at stage-1 with normal-NC memory type (well, let's
say with a memory attribute != device-nGnRE - that combined with the new
stage-2 default might cause transactions ordering/grouping trouble with
eg device resets), correct ? IIRC, all requests related to honouring
"write-combine" style stage-1 mappings were for PCI(e) devices but
that's as far as what *I* was made aware of goes.

> I'm confident it is not a problem for PCI and IIRC the remaining ARM
> platform drivers were made primarily for DPDK, not KVM.
> 
> So I agree with documenting and perhaps a comment someplace in VFIO is
> also warranted.

We will do that, I will start adding the recent discussions to the
new documentation file. Side note: for those who attend LPC it would be
useful to review the resulting documentation together there, it should
happen around v6.7-rc1.

Lorenzo
