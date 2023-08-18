Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10BC781035
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378574AbjHRQVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378546AbjHRQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26893590
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67C7B61D89
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88F0C433C7;
        Fri, 18 Aug 2023 16:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692375680;
        bh=vNNA0DydvFNi8JxO1ms0ynUZolq4OWcAKa8ptRRbUcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxUIdHbGwA6ffzRww69NVxQyWOkcjddSpZt6hHCmMr4KnlJ357G6Vu8M5fvl6F7pK
         rRP7NU4vhh7g0l9rfAILxywMipNSmu7x7NB/Ulo4/ZV0a04AkIgd4HRwyyxHGXIvBy
         XCc/9BMralVSmfWOf+D9MdiOeLNdKxmvVYPYrwJXCXCTQ+dUU2iU21gKK3P3FIdi4K
         YF9EIvyolHAYCBIYgjof8H4kJU5LoAWEITPXehTy2j+FlOul2Oez88vzqUjuL4jY2z
         UAzhqeKR4mTT42YQtDfx0MwRbHNG7tb+Cy6JsMcGsn2EIh79ehNaaqbRvw/77j1G8r
         m6OVW3DLNs53A==
Date:   Fri, 18 Aug 2023 17:21:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     zhurui <zhurui3@huawei.com>, Nicolin Chen <nicolinc@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
Message-ID: <20230818162114.GB16216@willie-the-truck>
References: <d5fc1f72-7428-4fef-d868-d06b85add635@huawei.com>
 <20230804165225.GF30679@willie-the-truck>
 <ZM1DqxXcBT2SOs8/@Asurada-Nvidia>
 <015b4573-9d74-451b-8028-a1050ade7019@huawei.com>
 <661a7bb5-99e1-de16-d860-0cd17f7a0470@arm.com>
 <20230808162409.GB2890@willie-the-truck>
 <80ead8ee-4dbe-7b3c-44f5-944073a2a39d@arm.com>
 <412886be-644a-5b46-9bfa-1c9a358f9a5d@huawei.com>
 <280d0be7-7d41-ed78-bf4b-3db6c0076e22@arm.com>
 <197e87cd-91a2-dce8-716c-488b379abbaf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <197e87cd-91a2-dce8-716c-488b379abbaf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 05:19:31PM +0100, Robin Murphy wrote:
> On 2023-08-09 14:48, Robin Murphy wrote:
> [...]
> > Does the patch below work for you?
> 
> Any comments on this? Just noticed this commit on a local dev branch and
> realised I'd totally forgotten about it already. I'm pretty confident it
> ought to be right, but then it *was* also me who missed the original bug to
> begin with... ;)

I'm happy to take it if zhurui can confirm that it fixes their issue...

Will (had also forgotten about this)

> > ----->8-----
> > Subject: [PATCH] iommu/arm-smmu-v3: Avoid constructing invalid range
> > commands
> > 
> > Although io-pgtable's non-leaf invalidations are always for full tables,
> > I missed that SVA also uses non-leaf invalidations, while being at the
> > mercy of whatever range the MMU notifier throws at it. This means it
> > definitely wants the previous TTL fix as well, since it also doesn't
> > know exactly which leaf level(s) may need invalidating, but it can also
> > give us less-aligned ranges wherein certain corners may lead to building
> > an invalid command where TTL, Num and Scale are all 0. It should be fine
> > to handle this by over-invalidating an extra page, since falling back to
> > a non-range command opens up a whole can of errata-flavoured worms.
> > 
> > Fixes: 6833b8f2e199 ("iommu/arm-smmu-v3: Set TTL invalidation hint better")
> > Reported-by: Rui Zhu <zhurui3@huawei.com>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 9b0dc3505601..6ccbae9b93a1 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1895,18 +1895,23 @@ static void __arm_smmu_tlb_inv_range(struct
> > arm_smmu_cmdq_ent *cmd,
> >           /* Get the leaf page size */
> >           tg = __ffs(smmu_domain->domain.pgsize_bitmap);
> > 
> > +        num_pages = size >> tg;
> > +
> >           /* Convert page size of 12,14,16 (log2) to 1,2,3 */
> >           cmd->tlbi.tg = (tg - 10) / 2;
> > 
> >           /*
> > -         * Determine what level the granule is at. For non-leaf,
> > io-pgtable
> > -         * assumes .tlb_flush_walk can invalidate multiple levels at once,
> > -         * so ignore the nominal last-level granule and leave TTL=0.
> > +         * Determine what level the granule is at. For non-leaf, both
> > +         * io-pgtable and SVA pass a nominal last-level granule because
> > +         * they don't know what level(s) actually apply, so ignore that
> > +         * and leave TTL=0. However for various errata reasons we still
> > +         * want to use a range command, so avoid the SVA corner case
> > +         * where both scale and num could be 0 as well.
> >            */
> >           if (cmd->tlbi.leaf)
> >               cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
> > -
> > -        num_pages = size >> tg;
> > +        else if ((num_pages & CMDQ_TLBI_RANGE_NUM_MAX) == 1)
> > +            num_pages++;
> >       }
> > 
> >       cmds.num = 0;
> > 
