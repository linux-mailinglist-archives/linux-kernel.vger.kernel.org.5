Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5253753A42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjGNL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjGNL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D0211C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 601AD61C63
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A325C433C8;
        Fri, 14 Jul 2023 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689335900;
        bh=XPNXw+zC1w8RbtaJ2thy0ub4eQLzKHetkdRtlWXLPzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDf8swqgbZB3tBitDp3NjyKaozwsGZyNqVB1Y89y6YM0qqwo/MrT6CMrIC777M4N6
         Sc2JPkQLoJ9+7FVIYHpYrIvl5kkG9sKOHFJktiaKn0NdmEDKqpjSWOMrg66/NFGTLt
         ZzR+x3fK6k1Xc5O3SFeRVteyM19E0Cf+Wx2dUD3Py7jzeRGFS4wgK714yBa6KPELYO
         +vpOWA4ctIQMCbpR7MyKqTyOZ4J78IgDJzVP3Ahe42H4YnxUV5Hf7kc27S/B9t7zju
         Mp2em+8iKShzFUTk++zkKNxW+sXGRKnRP2YqhnGlIvkX+lokSWfPyxCLhrg7t2Ze8r
         cVjwPRWHPrK2g==
Date:   Fri, 14 Jul 2023 12:58:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <20230714115815.GA5363@willie-the-truck>
References: <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
 <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
 <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
 <ZLBWh370pPjx2B+z@Asurada-Nvidia>
 <ZLCNUNRsWy/YuHhQ@nvidia.com>
 <ZLChc4A58PkU2Fe5@Asurada-Nvidia>
 <CAKHBV240_0bUE-25sND3oSG57jT0yJiZzAt+fPTXehjm=zmRBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV240_0bUE-25sND3oSG57jT0yJiZzAt+fPTXehjm=zmRBw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 05:12:35PM +0800, Michael Shavit wrote:
> On Fri, Jul 14, 2023 at 9:14 AM Nicolin Chen <nicolinc@nvidia.com> wrote:
> > @Michael,
> > Would it be possible for you to update a v5, following Jason's
> > suggestion overall? And I think we can have a smaller refactor
> > series first without set_dev_pasid, to have a common codeline
> > sooner for us to add new features, such as set_dev_pasid, the
> > use case of IDENTITY default substream, and the nesting series.
> > I will help testing with some pasid/non-pasid use cases too.
> 
> Want to make sure I fully understand these last few messages first. At
> a high level, we want:
> 1. arm_smmu_master is allowed to own a CD table, but not an
> STE-precursor (s1_cfg/s2_cfg). The s1_cfg is practically already that,
> and we can probably get there with minimal changes.
> 2. arm_smmu_master shouldn't point to the currently active CD table
> (which may or may not be the one it owns) or STE-precursor as a
> shortcut. All code should figure it out by looking at the master's
> currently attached domain (functionality could be provided by helper).
> 3. arm_smmu_domain shouldn't pre-generate any STE-precursors. The
> STE/CD for a domain should either be computed right when it is
> written, or computed ahead of time and stored as a copy in the
> smmu-domain.
> Is that right?

To be honest, I'm having a hard time following the thread. I'd like to
avoid renaming things "for fun", so let's try to focus on the actual
restructuring initially. I'd also like to see what this "computing" of
the SMMU data structures actually looks like -- the information stored
in the 'arm_smmu_master' structure isn't redundant, so what's the problem?

If you all grok this, then I'm happy to wait for the patches, but I don't
want you to go away and spend lots of effort hacking something which doesn't
end up being what folks are asking for.

Will
