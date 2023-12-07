Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FCC808B05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443423AbjLGOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443322AbjLGOuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:50:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E4AC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:50:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE229C433C7;
        Thu,  7 Dec 2023 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701960618;
        bh=ROv4DFKKEEpLSUSHwElpbfywORQ7vxKS7FhooWQWgrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqx8dsk+Za2R5f1hFZYmCEE/Sr6KkS6eFsETYaOgAs8HGf8d4qq0Db067rEyGEyhs
         oBhIWAEOUkPpkMYxba0uDwXDsBqalS3CV0N0bMyvX+9yLhvnmeqlbrj8HK7AK00xjU
         J06J/tliIegHCiPwoyM/37M/haAxsZg5BfKgfpJkLku6PDZOcSIeVs2yMGerEpGy2D
         Afyghp+yZNbYb1q/itNfMTs13tWtBoFyYOeVHYpWe34GFO4w+ChTNfpEHeDcqgf5mG
         qCTiHuyaQbJEtAhT2mD0YT5DtG/hKn56Nt7WlSXRter5DFhQEhUE8sp5Svvkj81rcT
         9vsdOFnxtKoDw==
Date:   Thu, 7 Dec 2023 15:50:09 +0100
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
Message-ID: <ZXHbocMSiAtrFdyr@lpieralisi>
References: <ZW949Tl3VmQfPk0L@arm.com>
 <20231205194822.GL2692119@nvidia.com>
 <ZXCJ3pVbKuHJ3LTz@arm.com>
 <20231206150556.GQ2692119@nvidia.com>
 <ZXCQrTbf6q0BIhSw@lpieralisi>
 <20231206153809.GS2692119@nvidia.com>
 <ZXCf_e-ACqrj6VrV@arm.com>
 <20231206164802.GT2692119@nvidia.com>
 <ZXGa4A6rfxLtkTB2@lpieralisi>
 <20231207133825.GI2692119@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207133825.GI2692119@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:38:25AM -0400, Jason Gunthorpe wrote:
> On Thu, Dec 07, 2023 at 11:13:52AM +0100, Lorenzo Pieralisi wrote:
> > > > What about the other way around - would we have a prefetchable BAR that
> > > > has portions which are unprefetchable?
> > > 
> > > I would say possibly.
> > > 
> > > Prefetch is a dead concept in PCIe, it was obsoleted in PCI-X about 20
> > > years ago. No PCIe system has ever done prefetch.
> > > 
> > > There is a strong incentive to mark BAR's as prefetchable because it
> > > allows 64 bit addressing in configurations with bridges.
> > 
> > If by strong incentive you mean the "Additional guidance on the
> > Prefetchable Bit in Memory Space BARs" in the PCI express specifications,
> > I think it has been removed from the spec and the criteria that had to be
> > met to implement it were basically impossible to fulfill on ARM systems,
> > it did not make any sense in the first place.
> 
> No, I mean many systems don't have room to accommodate large 32 bit
> BARs and the only real way to make stuff work is to have a 64 bit BAR
> by setting prefetchable.

That's what the implementation note I mentioned referred to ;)

> Given mis-marking a read-side-effect region as prefetchable has no
> actual consequence on PCI-E I would not be surprised to learn people
> have done this.

PCIe specs 6.1, 7.5.1.2.1 "Base Address Registers"

"A function is permitted to mark a range as prefetchable if there are
no side effects on reads..."

I don't think that an OS should use the prefetchable flag to infer
anything (even though we do at the moment -> sysfs mappings, I know that
the prefetchable concept is being scrapped from the PCI specs altogether
for a reason), I don't see though how we can say that's a SW bug at
present given what I quoted above.

I'd agree that it is best not to use that flag for new code we are adding
(because it will be deprecated soon).

Thanks,
Lorenzo
