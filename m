Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9412B7C74E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347349AbjJLRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347473AbjJLRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:37:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD855B98
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:26:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538F5C433C9;
        Thu, 12 Oct 2023 17:26:04 +0000 (UTC)
Date:   Thu, 12 Oct 2023 18:26:01 +0100
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
Message-ID: <ZSgsKSCv-zWgtWkm@arm.com>
References: <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012144807.GA12374@willie-the-truck>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 03:48:08PM +0100, Will Deacon wrote:
> On Thu, Oct 12, 2023 at 02:53:21PM +0100, Catalin Marinas wrote:
> > On Thu, Oct 12, 2023 at 01:35:41PM +0100, Will Deacon wrote:
> > > On Thu, Oct 05, 2023 at 11:56:55AM +0200, Lorenzo Pieralisi wrote:
> > > > For all these reasons, relax the KVM stage 2 device
> > > > memory attributes from DEVICE_nGnRE to NormalNC.
> > > 
> > > The reasoning above suggests to me that this should probably just be
> > > Normal cacheable, as that is what actually allows the guest to control
> > > the attributes. So what is the rationale behind stopping at Normal-NC?
> > 
> > It's more like we don't have any clue on what may happen. MTE is
> > obviously a case where it can go wrong (we can blame the architecture
> > design here) but I recall years ago where a malicious guest could bring
> > the platform down by mapping the GIC CPU interface as cacheable.
> 
> ... and do we know that isn't the case for non-cacheable? If not, why not?

Trying to get this information from the hw folk and architects is really
hard. So we only relax it one step at a time ;). But given the MTE
problems, I'd not go for cacheable Stage 2 unless we have FEAT_MTE_PERM
implemented (both hw and sw). S2 cacheable allows the guest to map it as
Normal Tagged.

> Also, are you saying we used to map the GIC CPU interface as cacheable
> at stage-2? I remember exclusives causing a problem, but I don't remember
> the guest having a cacheable mapping.

The guest never had a cacheable mapping, IIRC it was more of a
theoretical problem, plugging a hole. Now, maybe I misremember, it's
pretty hard to search the git logs given how the code was moved around
(but I do remember the building we were in when discussing this, it was
on the ground floor ;)).

> > Not sure how error containment works with cacheable memory. A cacheable
> > access to a device may stay in the cache a lot longer after the guest
> > has been scheduled out, only evicted at some random time.
> 
> But similarly, non-cacheable stores can be buffered. Why isn't that a
> problem?

RAS might track this for cacheable mappings as well, I just haven't
figured out the details.

> > We may no longer be able to associate it with the guest, especially if the
> > guest exited. Also not sure about claiming back the device after killing
> > the guest, do we need cache maintenance?
> 
> Claiming back the device also seems strange if the guest has been using
> non-cacheable accesses since I think you could get write merging and
> reordering with subsequent device accesses trying to reset the device.

True. Not sure we have a good story here (maybe reinvent the DWB barrier ;)).

> > So, for now I'd only relax this if we know there's RAM(-like) on the
> > other side and won't trigger some potentially uncontainable errors as a
> > result.
> 
> I guess my wider point is that I'm not convinced that non-cacheable is
> actually much better and I think we're going way off the deep end looking
> at what particular implementations do and trying to justify to ourselves
> that non-cacheable is safe, even though it's still a normal memory type
> at the end of the day.

Is this about Device vs NC or Device/NC vs Normal Cacheable? The
justification for the former has been summarised in Lorenzo's write-up.
How the hardware behaves, it depends a lot on the RAS implementation.
The BSA has some statements but not sure it covers everything.

Things can go wrong but that's not because Device does anything better.
Given the RAS implementation, external aborts caused on Device memory
(e.g. wrong size access) is uncontainable. For Normal NC it can be
contained (I can dig out the reasoning behind this if you want, IIUC
something to do with not being able to cancel an already issued Device
access since such accesses don't allow speculation due to side-effects;
for Normal NC, it's just about the software not getting the data).

> Obviously, it's up to Marc and Oliver if they want to do this, but I'm
> wary without an official statement from Arm to say that Normal-NC is
> correct. There's mention of such a statement in the cover letter:
> 
>   > We hope ARM will publish information helping platform designers
>   > follow these guidelines.
> 
> but imo we shouldn't merge this without either:
> 
>   (a) _Architectural_ guidance (as opposed to some random whitepaper or
>       half-baked certification scheme).

Well, you know the story, the architects will probably make it a SoC or
integration issue, PCIe etc., not something that can live in the Arm
ARM. The best we could get is more recommendations in the RAS spec
around containment but not for things that might happen outside the CPU,
e.g. PCIe root complex.

> - or -
> 
>   (b) A concrete justification based on the current architecture as to
>       why Normal-NC is the right thing to do for KVM.

To put it differently, we don't have any strong arguments why Device is
the right thing to do. We chose Device based on some understanding
software people had about how the hardware behaves, which apparently
wasn't entirely correct (and summarised by Lorenzo).

-- 
Catalin
