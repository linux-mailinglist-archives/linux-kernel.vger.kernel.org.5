Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7947808608
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjLGKN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLGKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:13:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40BAA4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:14:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0C4C433C8;
        Thu,  7 Dec 2023 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701944040;
        bh=imy4ugx4p592rTLtYsew6LM8Qw7swHAvvWpZOmSRbzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhHuuJeqjenrJzluJ4waW5koAwpWLKrwzA15G7CY8Utv6hjNfvFBFFodpJSyTaKaF
         7EN4QZkZ0wMz69gziLzI+1qWic/TNJhzwqb92SOYzocWHNq5gIwurKXze1emnQSkUu
         5EaDIvOuY5Q9MPaZqjdoMnnNo9cbueXBY7gfxZidJC/YhLIrrDuLczNiynyULhIAXI
         +Ntbu8iq1JUNgGpTswSapQAtiLCQP87puO1UsFeWiY02poI233eYyilYZXLK6DrKQE
         vQEMmx2GQCZtFgFbx6pK6MBsP4SP7Y5Bg73JfNkZU6HgGJdvjt7ZSA9LYt+cuYd/lJ
         E6mNvF9PiP9pg==
Date:   Thu, 7 Dec 2023 11:13:52 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, ankita@nvidia.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, oliver.upton@linux.dev,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, will@kernel.org,
        ardb@kernel.org, akpm@linux-foundation.org, gshan@redhat.com,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        mochs@nvidia.com, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZXGa4A6rfxLtkTB2@lpieralisi>
References: <ZW9OSe8Z9gAmM7My@arm.com>
 <20231205164318.GG2692119@nvidia.com>
 <ZW949Tl3VmQfPk0L@arm.com>
 <20231205194822.GL2692119@nvidia.com>
 <ZXCJ3pVbKuHJ3LTz@arm.com>
 <20231206150556.GQ2692119@nvidia.com>
 <ZXCQrTbf6q0BIhSw@lpieralisi>
 <20231206153809.GS2692119@nvidia.com>
 <ZXCf_e-ACqrj6VrV@arm.com>
 <20231206164802.GT2692119@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206164802.GT2692119@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 12:48:02PM -0400, Jason Gunthorpe wrote:
> On Wed, Dec 06, 2023 at 04:23:25PM +0000, Catalin Marinas wrote:
> > On Wed, Dec 06, 2023 at 11:38:09AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Dec 06, 2023 at 04:18:05PM +0100, Lorenzo Pieralisi wrote:
> > > > On Wed, Dec 06, 2023 at 11:05:56AM -0400, Jason Gunthorpe wrote:
> > > > > On Wed, Dec 06, 2023 at 02:49:02PM +0000, Catalin Marinas wrote:
> > > > > > BTW, on those Mellanox devices that require different attributes within
> > > > > > a BAR, do they have a problem with speculative reads causing
> > > > > > side-effects? 
> > > > > 
> > > > > Yes. We definitely have had that problem in the past on older
> > > > > devices. VFIO must map the BAR using pgprot_device/noncached() into
> > > > > the VMM, no other choice is functionally OK.
> > > > 
> > > > Were those BARs tagged as prefetchable or non-prefetchable ? I assume the
> > > > latter but please let me know if I am guessing wrong.
> > > 
> > > I don't know it was quite old HW. Probably.
> > > 
> > > Just because a BAR is not marked as prefetchable doesn't mean that the
> > > device can't use NORMAL_NC on subsets of it.
> > 
> > What about the other way around - would we have a prefetchable BAR that
> > has portions which are unprefetchable?
> 
> I would say possibly.
> 
> Prefetch is a dead concept in PCIe, it was obsoleted in PCI-X about 20
> years ago. No PCIe system has ever done prefetch.
> 
> There is a strong incentive to mark BAR's as prefetchable because it
> allows 64 bit addressing in configurations with bridges.

If by strong incentive you mean the "Additional guidance on the
Prefetchable Bit in Memory Space BARs" in the PCI express specifications,
I think it has been removed from the spec and the criteria that had to be
met to implement it were basically impossible to fulfill on ARM systems,
it did not make any sense in the first place.

I agree on your statement related to the prefetchable concept but I
believe that a prefetchable BAR containing regions that have
read side-effects is essentially a borked design unless at system level
speculative reads are prevented (as far as I understand the
implementation note this could only be an endpoint integrated in a
system where read speculation can't just happen (?)).

Long story short: a PCIe card/device that can be plugged on any PCIe
compliant system (x86, ARM or whatever) should not mark a
BAR region with memory read side-effects as prefetchable, either
that or I don't understand what the implementation note above
was all about.

AFAIK the prefetchable concept in PCIe is likely to be scrapped
altogether in the not too distant future.

Anyway, that was just for completeness (and to shed light
on the BAR prefetchable bit usage).

Lorenzo
