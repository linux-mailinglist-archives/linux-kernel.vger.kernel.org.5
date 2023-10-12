Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5E7C7334
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379324AbjJLQjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347190AbjJLQjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:39:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6595D8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:39:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256E0C433C8;
        Thu, 12 Oct 2023 16:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697128778;
        bh=nmKoxXIpfilzAZLTQAUFdY/ZQ+BuKyRRQ73Ee6ZQiiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebsMJVckreTvHUZVjLCuOTn9Wp8fV/+EF1ukRSr9CPFnwEfMFBG5/w/qpDTO+dVgK
         zNmdKE9/Lrs31IpLCU9hPX2obqlst/bhu4JjbHEFaHEvepsfMn1405ZSTyqPQmUPf1
         eo3A8iBlCJzL9DqU89Y/gp4kMM8xFDCFkduwC376TjPFl/Zmu0xtx544kYYNsFMVy8
         w7zxDrjVcLakYrDg1eV4LvXdo+sBVypMqsoiQiU4mQb40453pltGUTDPiblNdZMCmu
         0sGXkmCbJcXbI6bK4a6NvWKIWvWbuMbciQ0XKWd/pKb589JNOg48GJ69xqkevUKpdP
         rwrnMZJ/E2hvg==
Date:   Thu, 12 Oct 2023 17:39:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231012163931.GA12592@willie-the-truck>
References: <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <20231012154439.GM3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012154439.GM3952@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 12:44:39PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 12, 2023 at 03:48:08PM +0100, Will Deacon wrote:
> 
> > I guess my wider point is that I'm not convinced that non-cacheable is
> > actually much better and I think we're going way off the deep end looking
> > at what particular implementations do and trying to justify to ourselves
> > that non-cacheable is safe, even though it's still a normal memory type
> > at the end of the day.
> 
> When we went over this with ARM it became fairly clear there wasn't an
> official statement that Device-* is safe from uncontained
> failures. For instance, looking at the actual IP, our architects
> pointed out that ARM IP already provides ways for Device-* to trigger
> uncontained failures today.
> 
> We then mutually concluded that KVM safe implementations must already
> be preventing uncontained failures for Device-* at the system level
> and that same prevention will carry over to NormalNC as well.
> 
> IMHO, this seems to be a gap where ARM has not fully defined when
> uncontained failures are allowed and left that as an implementation
> choice.
> 
> In other words, KVM safety around uncontained failure is not a
> property that can be reasoned about from the ARM architecture alone.
> 
> > The current wording talks about use-cases (I get this) and error containment
> > (it's a property of the system) but doesn't talk at all about why Normal-NC
> > is the right result.
> 
> Given that Device-* and NormalNC are equally implementation defined
> with regards to uncontained failures, NormalNC allows more VM
> functionality.
> 
> Further, we have a broad agreement that this use case is important,
> and that NormalNC is the correct way to adress it.
> 
> I think you are right to ask for more formality from ARM team but also
> we shouldn't hold up fixing real functional bugs in real shipping
> server ARM products.

All I'm asking for is justification as to why Normal-NC is the right
memory type rather than any other normal memory type. If it's not possible
to explain that architecturally, then I'm not sure this change belongs in
architecture code.

Ultimately, we need to be able to maintain this stuff, so we can't just
blindly implement changes based on a combination of off-list discussions
and individual product needs. For example, if somebody else rocks up
tomorrow and asks for this to be Normal-writethrough, what grounds do
we have to say no if we've taken this change already?

So please let's get to a point where we can actually reason about this.

Will
