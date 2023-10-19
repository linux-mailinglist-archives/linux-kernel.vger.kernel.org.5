Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF677CFB34
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbjJSNfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345663AbjJSNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:35:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EAEB6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:35:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AC2C433C8;
        Thu, 19 Oct 2023 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697722531;
        bh=m0eZGJfiQ96XU0OENhX6foFqWIFTV3BxcEAxtgRb8VQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2hBfqYEhdvoJ4WEfhJ6DijG0jf25hm0Dh/BMihxjSSOo5qHO+cJs+3Sl8Nhz2ivz
         rHh6H12MgjBcjwby2wtIIiPy4of2seteW2rb1LNEqMe2gu6PD9w/X99YuijZs00u29
         L5LtzZBPkTfczt530VL33f/iFQW6XE0N/Qc2NWw18RREV3ViWPEdyc2T1qKe9CtdHf
         g06WYhmvExu6wE8YmQg+uEZpgieGkdHUth1Gqhv1iIXF9GI1rDzvQ/ud7wdY0A8Kuv
         Ag7iNoLy3hjKcSGGm/xgvP1wdwDTrGg9NGMOhepf83t0TSYceAeNuY32VCQT+Akno6
         Dl1vIxwz1Oa5Q==
Date:   Thu, 19 Oct 2023 15:35:24 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZTEwnBoPLL3PE3Xo@lpieralisi>
References: <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
 <20231013134541.GP3952@nvidia.com>
 <ZTEN_oe97VRWbnHb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTEN_oe97VRWbnHb@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:07:42PM +0100, Catalin Marinas wrote:

[...]

> > VFIO issues a config space write to reset the PCI function.  Config
> > space writes MUST NOT write combine with anything. This is already
> > impossible for PCIe since they are different TLP types at the PCIe
> > level.
> 
> Yes, config space writes are fine, vfio-pci even maps them as
> Device_nGnRnE. But AFAIK a guest won't have direct access to the config
> space.
> 
> > By the PCIe rules, config space write must order strictly after all
> > other CPU's accesses. Once the reset non-posted write returns back to
> > VFIO we know that:
> > 
> >  1) There is no reference in any CPU page table to the MMIO PFN
> >  2) No CPU has pending data in any write buffer
> >  3) The interconnect and PCIe fabric have no inflight operations
> >  4) The device is in a clean post-reset state
> 
> I think from the CPU perspective, we can guarantee that a Normal_NC
> write on CPU0 for example reaches a serialisation point before a config
> space (Device_nGnRnE) write on CPU1 by the host as long as CPU1 issued a
> TLBI+DSB. Now, what I'm not sure is what this serialisation point is. If
> it is the PCIe root complex, we are probably fine, we hope it deals with
> any ordering between the Normal_NC write and the config space one.

If it is the PCI host bridge (and for PCI it should be since it is the
logic between the ARM world - where ARM ordering rules and barriers
apply - and PCI protocol), either it enforces PCI ordering rules or it
is broken by design; if it is the latter, at that stage device
assignment would be the least of our problems.

For non-PCI device assignment, I am not sure at all we can rely on
anything other than what Jason mentioned, eg resets (and the components
that through eg MMIO are carrying them out) are not architected, the
device MMIO space and the MMIO space used to trigger the reset (again,
it is an example) may well be placed on different interconnect paths,
it is device specific.

Lorenzo

> Talking to Will earlier, I think we can deem the PCIe scenario
> (somewhat) safe but not as a generic mechanism for other non-PCIe
> devices (e.g. platform). With this concern, can we make this Stage 2
> relaxation in KVM only for vfio-pci mappings? I don't have an example of
> non-PCIe device assignment to figure out how this should work though.
> 
> > > knows all the details. The safest is for the VMM to keep it as Device (I
> > > think vfio-pci goes for the strongest nGnRnE).
> > 
> > We are probably going to allow VFIO to let userspace pick if it should
> > be pgprot_device or pgprot_writecombine.
> 
> I guess that's for the direct use by an application rather than VMM+VM.
> IIUC people work around this currently by mapping PCIe BARs as
> pgprot_writecombine() via sysfs. Getting vfio-pci to allow different
> mappings is probably a good idea, though it doesn't currently help with
> the KVM case as we can't force the VMM to know the specifics of the
> device it is giving to a guest.
> 
> > The alias issue could be resolved by teaching KVM how to insert a
> > physical PFN based on some VFIO FD/dmabuf rather than a VMA so that
> > the PFNs are never mapped in the hypervisor side.
> 
> This should work as well and solves the aliasing problem, though it
> requires changes to the VMM as well, not just KVM, which currently
> relies on vfio-pci mmap().
> 
> -- 
> Catalin
