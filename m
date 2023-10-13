Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CABD7C8664
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjJMNIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjJMNIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:08:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5104ABE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:08:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42C1C433C8;
        Fri, 13 Oct 2023 13:08:12 +0000 (UTC)
Date:   Fri, 13 Oct 2023 14:08:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZSlBOiebenPKXBY4@arm.com>
References: <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013092934.GA13524@willie-the-truck>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 10:29:35AM +0100, Will Deacon wrote:
> On Thu, Oct 12, 2023 at 06:26:01PM +0100, Catalin Marinas wrote:
> > On Thu, Oct 12, 2023 at 03:48:08PM +0100, Will Deacon wrote:
> > > Claiming back the device also seems strange if the guest has been using
> > > non-cacheable accesses since I think you could get write merging and
> > > reordering with subsequent device accesses trying to reset the device.
> > 
> > True. Not sure we have a good story here (maybe reinvent the DWB barrier ;)).
> 
> We do have a good story for this part: use Device-nGnRE!

Don't we actually need Device-nGnRnE for this, coupled with a DSB for
endpoint completion?

Device-nGnRE may be sufficient as a read from that device would ensure
that the previous write is observable (potentially with a DMB if
accessing separate device regions) but I don't think we do this now
either. Even this, isn't it device-specific? I don't know enough about
PCIe, posted writes, reordering, maybe others can shed some light.

For Normal NC, if the access doesn't have side-effects (or rather the
endpoint is memory-like), I think we are fine. The Stage 2 unmapping +
TLBI + DSB (DVM + DVMSync) should ensure that a pending write by the CPU
was pushed sufficiently far as not to affect subsequent writes by other
CPUs.

For I/O accesses that change some state of the device, I'm not sure the
TLBI+DSB is sufficient. But I don't think Device nGnRE is either, only
nE + DSB as long as the PCIe device plays along nicely.

> Could we change these patches so that the memory type of the stage-1 VMA
> in the VMM is reflected in the stage-2? In other words, continue to use
> Device mappings at stage-2 for I/O but relax to Normal-NC if that's
> how the VMM has it mapped?

We've been through this and it's not feasible. The VMM does not have
detailed knowledge of the BARs of the PCIe device it is mapping (and the
prefetchable BAR attribute is useless). It may end up with a Normal
mapping of a BAR with read side-effects. It's only the guest driver that
knows all the details. The safest is for the VMM to keep it as Device (I
think vfio-pci goes for the strongest nGnRnE).

Yes, we end up with mismatched aliases but they only matter if the VMM
also accesses the I/O range via its own mapping. So far I haven't seen
case that suggests this.

> > Things can go wrong but that's not because Device does anything better.
> > Given the RAS implementation, external aborts caused on Device memory
> > (e.g. wrong size access) is uncontainable. For Normal NC it can be
> > contained (I can dig out the reasoning behind this if you want, IIUC
> > something to do with not being able to cancel an already issued Device
> > access since such accesses don't allow speculation due to side-effects;
> > for Normal NC, it's just about the software not getting the data).
> 
> I really think these details belong in the commit message.

I guess another task for Lorenzo ;).

> > > Obviously, it's up to Marc and Oliver if they want to do this, but I'm
> > > wary without an official statement from Arm to say that Normal-NC is
> > > correct. There's mention of such a statement in the cover letter:
> > > 
> > >   > We hope ARM will publish information helping platform designers
> > >   > follow these guidelines.
> > > 
> > > but imo we shouldn't merge this without either:
> > > 
> > >   (a) _Architectural_ guidance (as opposed to some random whitepaper or
> > >       half-baked certification scheme).
> > 
> > Well, you know the story, the architects will probably make it a SoC or
> > integration issue, PCIe etc., not something that can live in the Arm
> > ARM. The best we could get is more recommendations in the RAS spec
> > around containment but not for things that might happen outside the CPU,
> > e.g. PCIe root complex.
> 
> The Arm ARM _does_ mention PCI config space when talking about early write
> acknowledgement, so there's some precedence for providing guidance around
> which memory types to use.

Ah, yes, it looks like it does, though mostly around the config space.
We could ask them to add some notes but I don't think we have the
problem well defined yet.

Trying to restate what we aim: the guest driver knows what attributes it
needs and would set the appropriate attributes: Device or Normal. KVM's
role is not to fix bugs in the guest driver by constraining the
attributes but rather to avoid potential security issues with malicious
(or buggy) guests:

1) triggering uncontained errors

2) accessing memory that it shouldn't (like the MTE tag access)

3) causing delayed side-effects after the host reclaims the device

... anything else?

For (1), Normal NC vs. Device doesn't make any difference, slightly
better for the former. (2) so far is solved by not allowing Cacheable
(or disabling MTE, enabling FEAT_MTE_PERM in the future). I'm now trying
to understand (3), I think it needs more digging.

> > >   (b) A concrete justification based on the current architecture as to
> > >       why Normal-NC is the right thing to do for KVM.
> > 
> > To put it differently, we don't have any strong arguments why Device is
> > the right thing to do. We chose Device based on some understanding
> > software people had about how the hardware behaves, which apparently
> > wasn't entirely correct (and summarised by Lorenzo).
> 
> I think we use Device because that's what the host uses in its stage-1
> and mismatched aliases are bad.

They are "constrained" bad ;).

-- 
Catalin
