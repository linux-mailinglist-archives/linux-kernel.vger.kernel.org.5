Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D786A775C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjHILX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjHILXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE6D1BFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A8E96322E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB94EC433C9;
        Wed,  9 Aug 2023 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691580203;
        bh=/Jo698VUwWViOfRpDRaOF+geLJTlE2ZHuvKqfJHymbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cBVsEVdhjXnSoLGT3ZxfxQMdwIpTlHwYq31bkpyXuEt3FKgzMn8pbVUhgqStXya3/
         lcw+9dGGF+1Q2BZm2cJN1Bdpt/evjLRT4YVvAK3z0rqt5GvfgApsICmtIccmpgYJ3j
         YqiB4ahG1XIRUzI46dqIU1Ak6syGoPR0U9TFSJI8QUej/PICfsZ+svckYc07Q5qvJB
         a2g6nLd6G6ySr9vZQwcBIWNY54wilqzqqTl7QJVOXMAHcjGDfZSH6Oq95MsYvjZe/K
         YVFsSCCj4vJVlaU8xQoWXU+92Gt7AaZzj61uWagT0lOfsBREbBYGUSD1iX1/Rumki7
         MjGIxfMUma2yw==
Date:   Wed, 9 Aug 2023 12:23:18 +0100
From:   Will Deacon <will@kernel.org>
To:     zhurui <zhurui3@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
Message-ID: <20230809112317.GA3830@willie-the-truck>
References: <20230801085504.GA26130@willie-the-truck>
 <27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com>
 <d5fc1f72-7428-4fef-d868-d06b85add635@huawei.com>
 <20230804165225.GF30679@willie-the-truck>
 <ZM1DqxXcBT2SOs8/@Asurada-Nvidia>
 <015b4573-9d74-451b-8028-a1050ade7019@huawei.com>
 <661a7bb5-99e1-de16-d860-0cd17f7a0470@arm.com>
 <20230808162409.GB2890@willie-the-truck>
 <80ead8ee-4dbe-7b3c-44f5-944073a2a39d@arm.com>
 <412886be-644a-5b46-9bfa-1c9a358f9a5d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412886be-644a-5b46-9bfa-1c9a358f9a5d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 05:22:06PM +0800, zhurui wrote:
> On 2023/8/9 0:43, Robin Murphy wrote:
> > On 08/08/2023 5:24 pm, Will Deacon wrote:
> >> On Mon, Aug 07, 2023 at 08:20:45PM +0100, Robin Murphy wrote:
> >>> Yeah, I'd rather not downgrade to a non-range invalidate since that
> >>> complicates the reasoning for the errata affecting those. If the size of the
> >>> invalidation is equal to TG then it can only represent a single last-level
> >>> page, i.e. TTL=3, thus if it does warrant handling here then indeed
> >>> rearranging to base the condition on num_pages as well ought to suffice.
> >>> However, this is all still begging the question of where and why we're doing
> >>> a *non-leaf* invalidation that isn't aligned to the size of a table, because
> >>> that in itself doesn't make a whole heap of sense - my hunch is that that
> >>> wants figuring out and could probably be fixed at the source.
> >>
> >> Isn't that described above because we're using CMDQ_TLBI_RANGE_NUM_MAX
> >> to break up the range into separate commands?
> > 
> > Not really, because if we're doing a genuine non-leaf invalidation of a
> > table then it should be a block-aligned range that ought to fit in a
> > single command and should certainly never involve a single-granule
> > remainder. If we're doing non-leaf invalidations of things that
> > logically don't need to be non-leaf, making them leaf would be the even
> > better option.
> > 
> 
> I agree with Robin that if the caller is doing a genuine non-leaf invalidation
> of a table, it should not involve a single-granule tlbi. It seems that the
> caller only filter the block size, but not the address aligned or not maybe.

There's only one caller though, right? That's the
io_pgtable_tlb_flush_walk() call in io-pgtable-arm.c which shouldn't trigger
this problem.

Do you have a backtrace for the case when we generate the illegal command?

> >> Do you mind if I queue the patch as-is for now? I don't think the driver
> >> should be emitting illegal commands, and v2 of the patch does seem like
> >> the obvious thing to do.
> > 
> > TBH I'd rather you just drop my patch if it's proven problematic, and
> > I'll take another crack at it soon. The potential problems we introduce
> > by using non-range invalidates on errata-affected MMU-700 revisions are
> > worse than the almost-entirely-theoretical one I was trying to address.
> > 
> 
> If you all agree to roll back the problematic code, is the first patch be OK?
> Should I need to add some more descriptions to clarify this?

I can just go and revert Robin's original patch, but I'd like to see your
backtrace first so that we understand how this is occurring.

Thanks,

Will
