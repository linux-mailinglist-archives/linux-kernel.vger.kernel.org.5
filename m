Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F78806F80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378009AbjLFMOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377846AbjLFMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:14:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E126BA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:14:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D996C433C7;
        Wed,  6 Dec 2023 12:14:20 +0000 (UTC)
Date:   Wed, 6 Dec 2023 12:14:18 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, ankita@nvidia.com,
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
Message-ID: <ZXBlmt88dKmZLCU9@arm.com>
References: <86fs0hatt3.wl-maz@kernel.org>
 <ZW8MP2tDt4_9ROBz@arm.com>
 <20231205130517.GD2692119@nvidia.com>
 <ZW9OSe8Z9gAmM7My@arm.com>
 <20231205164318.GG2692119@nvidia.com>
 <86bkb4bn2v.wl-maz@kernel.org>
 <ZW9ezSGSDIvv5MsQ@arm.com>
 <86a5qobkt8.wl-maz@kernel.org>
 <ZW9uqu7yOtyZfmvC@arm.com>
 <868r67blwo.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868r67blwo.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:39:03AM +0000, Marc Zyngier wrote:
> On Tue, 05 Dec 2023 18:40:42 +0000,
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Dec 05, 2023 at 05:50:27PM +0000, Marc Zyngier wrote:
> > > On Tue, 05 Dec 2023 17:33:01 +0000,
> > > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > Ideally we should do this for vfio only but we don't have an easy
> > > > way to convey this to KVM.
> > > 
> > > But if we want to limit this to PCIe, we'll have to find out. The
> > > initial proposal (a long while ago) had a flag conveying some
> > > information, and I'd definitely feel more confident having something
> > > like that.
> > 
> > We can add a VM_PCI_IO in the high vma flags to be set by
> > vfio_pci_core_mmap(), though it limits it to 64-bit architectures. KVM
> > knows this is PCI and relaxes things a bit. It's not generic though if
> > we need this later for something else.
> 
> Either that, or something actually describing the attributes that VFIO
> wants.
> 
> And I very much want it to be a buy-in behaviour, not something that
> automagically happens and changes the default behaviour for everyone
> based on some hand-wavy assertions.
> 
> If that means a userspace change, fine by me. The VMM better know what
> is happening.

Driving the attributes from a single point like the VFIO driver is
indeed better. The problem is that write-combining on Arm doesn't come
without speculative loads, otherwise we would have solved it by now. I
also recall the VFIO maintainer pushing back on relaxing the
pgprot_noncached() for the user mapping but I don't remember the
reasons.

We could do with a pgprot_maybewritecombine() or
pgprot_writecombinenospec() (similar to Jason's idea but without
changing the semantics of pgprot_device()). For the user mapping on
arm64 this would be Device (even _GRE) since it can't disable
speculation but stage 2 would leave the decision to the guest since the
speculative loads aren't much different from committed loads done
wrongly.

If we want the VMM to drive this entirely, we could add a new mmap()
flag like MAP_WRITECOMBINE or PROT_WRITECOMBINE. They do feel a bit
weird but there is precedent with PROT_MTE to describe a memory type.
One question is whether the VFIO driver still needs to have the
knowledge and sanitise the requests from the VMM within a single BAR. If
there are no security implications to such mappings, the VMM can map
parts of the BAR as pgprot_noncached(), other parts as
pgprot_writecombine() and KVM just follows them (similarly if we need a
cacheable mapping).

The latter has some benefits for DPDK but it's a lot more involved with
having to add device-specific knowledge into the VMM. The VMM would also
have to present the whole BAR contiguously to the guest even if there
are different mapping attributes within the range. So a lot of MAP_FIXED
uses. I'd rather leaving this decision with the guest than the VMM, it
looks like more hassle to create those mappings. The VMM or the VFIO
could only state write-combine and speculation allowed.

-- 
Catalin
