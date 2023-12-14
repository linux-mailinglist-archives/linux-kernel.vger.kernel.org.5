Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4514381352D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573894AbjLNPsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573858AbjLNPsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:48:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A34498
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:48:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E61C433C8;
        Thu, 14 Dec 2023 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702568907;
        bh=c5Hrhu9jv1aI02dxQqDlqaubcSiytClNWLM8d4C/kvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJqaV9djsO/05rDV52LNkS1/r3WX1iHi+z4LvSF0/Di2UKXcchnv6sNH/cOKDIuBx
         6MpAsvRG7pW6buIuMSK5/WrN8+vWJn03EpganGs7uk0UJSNmk2VfbrrARLeUyrYLqb
         DrjO+9QjEGyJkOWwoGkiMkxi93cpzZJOeLBi7crnAeQEDvyrV7Fqr9tTj4usU4fsz4
         p3KC5eQByNZx19W2DV9ABOEKUr2SF0bWlWuEEOK/zS5y0Dn+xhk7PZ7JYQ0r3ZrKAL
         FeGwO/Bi3QkCYVvPEXbACz4VsJMvz7XU3430O1c+P0LxSe2lJjXSwOo5SYUFY2MP/w
         pFc7cqInVHFIQ==
Date:   Thu, 14 Dec 2023 16:48:15 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>, ankita@nvidia.com,
        maz@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        will@kernel.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, ardb@kernel.org, akpm@linux-foundation.org,
        gshan@redhat.com, linux-mm@kvack.org, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com, mochs@nvidia.com,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.morse@arm.com
Subject: Re: [PATCH v3 2/2] kvm: arm64: set io memory s2 pte as normalnc for
 vfio pci devices
Message-ID: <ZXsjv+svp44YjMmh@lpieralisi>
References: <20231208164709.23101-1-ankita@nvidia.com>
 <20231208164709.23101-3-ankita@nvidia.com>
 <ZXicemDzXm8NShs1@arm.com>
 <20231212181156.GO3014157@nvidia.com>
 <ZXoOieQN7rBiLL4A@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXoOieQN7rBiLL4A@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+James]

On Wed, Dec 13, 2023 at 08:05:29PM +0000, Oliver Upton wrote:
> Hi,
> 
> Sorry, a bit late to the discussion :)
> 
> On Tue, Dec 12, 2023 at 02:11:56PM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 12, 2023 at 05:46:34PM +0000, Catalin Marinas wrote:
> > > should know the implications. There's also an expectation that the
> > > actual driver (KVM guests) or maybe later DPDK can choose the safe
> > > non-cacheable or write-combine (Linux terminology) attributes for the
> > > BAR.
> > 
> > DPDK won't rely on this interface
> 
> Wait, so what's the expected interface for determining the memory
> attributes at stage-1? I'm somewhat concerned that we're conflating two
> things here:
> 
>  1) KVM needs to know the memory attributes to use at stage-2, which
>     isn't fundamentally different from what's needed for userspace
>     stage-1 mappings.
> 
>  2) KVM additionally needs a hint that the device / VFIO can handle
>     mismatched aliases w/o the machine exploding. This goes beyond
>     supporting Normal-NC mappings at stage-2 and is really a bug
>     with our current scheme (nGnRnE at stage-1, nGnRE at stage-2).
> 
> I was hoping that (1) could be some 'common' plumbing for both userspace
> and KVM mappings. And for (2), any case where a device is intolerant of
> mismatches && KVM cannot force the memory attributes should be rejected.
> 
> AFAICT, the only reason PCI devices can get the blanket treatment of
> Normal-NC at stage-2 is because userspace has a Device-* mapping and can't
> speculatively load from the alias. This feels a bit hacky, and maybe we
> should prioritize an interface for mapping a device into a VM w/o a
> valid userspace mapping.

FWIW - I have tried to summarize the reasoning behind PCIe devices
Normal-NC default stage-2 safety in a document that I have just realized
now it has become this series cover letter, I don't think the PCI blanket
treatment is related *only* to the current user space mappings (ie
BTW, AFAICS it is also *possible* at present to map a prefetchable BAR through
sysfs with Normal-NC memory attributes in the host at the same time a PCI
device is passed-through to a guest with VFIO - and therefore we have a
dev-nGnRnE stage-1 mapping for it. Don't think anyone does that - what for -
but it is possible and KVM would not know about it).

Again, FWIW, we were told (source Arm ARM) mismatched aliases concerning
device-XXX vs Normal-NC are not problematic as long as the transactions
issued for the related mappings are independent (and none of the
mappings is cacheable).

I appreciate this is not enough to give everyone full confidence on
this solution robustness - that's why I wrote that up so that we know
what we are up against and write KVM interfaces accordingly.

> I very much understand that this has been going on for a while, and we
> need to do *something* to get passthrough working well for devices that
> like 'WC'. I just want to make sure we don't paint ourselves into a corner
> that's hard to get out of in the future.

That makes perfect sense, see above, if there is anything we can do
to clarify we will, in whatever shape it is preferred.

Thanks,
Lorenzo
