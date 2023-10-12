Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25B57C70A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbjJLOsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378354AbjJLOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:48:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D843AB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:48:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4EBC433C7;
        Thu, 12 Oct 2023 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697122095;
        bh=iZPYvU5wRljfApCM+MJ581owf29pPt1A+Y/BqRAY+FE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZNUnXC1YMmjFRqVniBnW419vtLsGYUrow79j6TNfhCrFDGuF9rRWfIhvSl6PXOQQ
         QlxMhbim0buZILGg9x254gcDzAA8uXbN2gl9sLMQdtZQKHLdqKGRv4vs57zRG4BBj8
         bXHZTOeNMsrpzuPQKtTExlGtpRtmZawU4lCfhv5iQMDnwe21bUy/k8bWm81aSOOqPe
         dCpw/6x6ixPvpOCPg8rdcXZNZ/arpenL/pyzZSoyPQb8nuYxonJ0DbpEuIrm3qh/i1
         YDFsQ71W+evua2BfFNImFU7X+t9CIDoFzcn9ytjtnSyCuCKPt099BMfkeF7DPWKWFD
         Kn5fFXtEV1djw==
Date:   Thu, 12 Oct 2023 15:48:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20231012144807.GA12374@willie-the-truck>
References: <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSf6Ue09IO6QMBs1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 02:53:21PM +0100, Catalin Marinas wrote:
> On Thu, Oct 12, 2023 at 01:35:41PM +0100, Will Deacon wrote:
> > On Thu, Oct 05, 2023 at 11:56:55AM +0200, Lorenzo Pieralisi wrote:
> > > For all these reasons, relax the KVM stage 2 device
> > > memory attributes from DEVICE_nGnRE to NormalNC.
> > 
> > The reasoning above suggests to me that this should probably just be
> > Normal cacheable, as that is what actually allows the guest to control
> > the attributes. So what is the rationale behind stopping at Normal-NC?
> 
> It's more like we don't have any clue on what may happen. MTE is
> obviously a case where it can go wrong (we can blame the architecture
> design here) but I recall years ago where a malicious guest could bring
> the platform down by mapping the GIC CPU interface as cacheable.

... and do we know that isn't the case for non-cacheable? If not, why not?

Also, are you saying we used to map the GIC CPU interface as cacheable
at stage-2? I remember exclusives causing a problem, but I don't remember
the guest having a cacheable mapping.

> Not sure how error containment works with cacheable memory. A cacheable
> access to a device may stay in the cache a lot longer after the guest
> has been scheduled out, only evicted at some random time.

But similarly, non-cacheable stores can be buffered. Why isn't that a
problem?

> We may no longer be able to associate it with the guest, especially if the
> guest exited. Also not sure about claiming back the device after killing
> the guest, do we need cache maintenance?

Claiming back the device also seems strange if the guest has been using
non-cacheable accesses since I think you could get write merging and
reordering with subsequent device accesses trying to reset the device.

> So, for now I'd only relax this if we know there's RAM(-like) on the
> other side and won't trigger some potentially uncontainable errors as a
> result.

I guess my wider point is that I'm not convinced that non-cacheable is
actually much better and I think we're going way off the deep end looking
at what particular implementations do and trying to justify to ourselves
that non-cacheable is safe, even though it's still a normal memory type
at the end of the day.

Obviously, it's up to Marc and Oliver if they want to do this, but I'm
wary without an official statement from Arm to say that Normal-NC is
correct. There's mention of such a statement in the cover letter:

  > We hope ARM will publish information helping platform designers
  > follow these guidelines.

but imo we shouldn't merge this without either:

  (a) _Architectural_ guidance (as opposed to some random whitepaper or
      half-baked certification scheme).

- or -

  (b) A concrete justification based on the current architecture as to
      why Normal-NC is the right thing to do for KVM.

The current wording talks about use-cases (I get this) and error containment
(it's a property of the system) but doesn't talk at all about why Normal-NC
is the right result.

Will
