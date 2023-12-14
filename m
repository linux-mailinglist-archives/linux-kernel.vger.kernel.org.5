Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73136813709
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjLNQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLNQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:56:08 -0500
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [IPv6:2001:41d0:203:375::ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8620AB7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:56:12 -0800 (PST)
Date:   Thu, 14 Dec 2023 16:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702572970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YNudICFnccOJwSRae1JA15vTriKkExaSPdeDL+9ouQ=;
        b=E60cAGDAv7DLogGVzQ767p+8gD8T7Uf/QSXhFzabZSx5Z+LA7N2090ZifH+dopmn0oBAsB
        +KpmKolLuvIonLpihx3t0oJrVTF3GH9zJjB/5JxvxCNTx7I2g62Wu9IjAETEpeCRAeBwJF
        xmt2EieAYHyu3P78CbW8deoTVu4A78E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
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
Message-ID: <ZXszoQ48pZ7FnQNV@linux.dev>
References: <20231208164709.23101-1-ankita@nvidia.com>
 <20231208164709.23101-3-ankita@nvidia.com>
 <ZXicemDzXm8NShs1@arm.com>
 <20231212181156.GO3014157@nvidia.com>
 <ZXoOieQN7rBiLL4A@linux.dev>
 <ZXsjv+svp44YjMmh@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsjv+svp44YjMmh@lpieralisi>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 04:48:15PM +0100, Lorenzo Pieralisi wrote:

[...]

> > AFAICT, the only reason PCI devices can get the blanket treatment of
> > Normal-NC at stage-2 is because userspace has a Device-* mapping and can't
> > speculatively load from the alias. This feels a bit hacky, and maybe we
> > should prioritize an interface for mapping a device into a VM w/o a
> > valid userspace mapping.
> 
> FWIW - I have tried to summarize the reasoning behind PCIe devices
> Normal-NC default stage-2 safety in a document that I have just realized
> now it has become this series cover letter, I don't think the PCI blanket
> treatment is related *only* to the current user space mappings (ie
> BTW, AFAICS it is also *possible* at present to map a prefetchable BAR through
> sysfs with Normal-NC memory attributes in the host at the same time a PCI
> device is passed-through to a guest with VFIO - and therefore we have a
> dev-nGnRnE stage-1 mapping for it. Don't think anyone does that - what for -
> but it is possible and KVM would not know about it).
> 
> Again, FWIW, we were told (source Arm ARM) mismatched aliases concerning
> device-XXX vs Normal-NC are not problematic as long as the transactions
> issued for the related mappings are independent (and none of the
> mappings is cacheable).
> 
> I appreciate this is not enough to give everyone full confidence on
> this solution robustness - that's why I wrote that up so that we know
> what we are up against and write KVM interfaces accordingly.

Apologies, I didn't mean to question what's going on here from the
hardware POV. My concern was more from the kernel + user interfaces POV,
this all seems to work (specifically for PCI) by maintaining an
intentional mismatch between the VFIO stage-1 and KVM stage-2 mappings.

If we add more behind-the-scenes tricks to get other MMIO mappings
working in the future then this whole interaction will get even
hairier. At least if we follow the stage-1 attributes (where possible)
then we can document some sort of expected behavior in KVM. The VMM would
need know if the device has read side-effects, as the only way to get a
Normal-NC mapping in the guest would be to have one at stage-1.

Kinda stinks to make the VMM aware of the device, but IMO it is a
fundamental limitation of the way we back memslots right now.

-- 
Thanks,
Oliver
