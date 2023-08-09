Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA59776502
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjHIQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjHIQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:27:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F73E171D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F51564058
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6664BC433C8;
        Wed,  9 Aug 2023 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691598475;
        bh=1TIrPLAB+pltO94ANnOelKVEZYEOgEmbVBQg99MGMTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2tDQLF1FDZ4OyY9IXNg55EhM3W98VPZN4lZHwJKU1YbPrQ9+n9NqKPPUHWh3u4uN
         Bj+dXJNWUmBIXiajTWliV2sbU5OmtNgmAXgFlxkHUwQD7k8ip1X4OUE4+0GJQMkPuf
         VRNOI68v+sK6awn82j7NdSkWqS6WTqVIxSFvRGqsdPyW1RuRliNmqaKOo8Kn4acdAz
         6UX9v9E9ApOmbM3AZNlDi0mRozExk72d3TIsYgRE40/K7ZOIaXtq+BZv/xiuZIj7SO
         gGsSqNPaLo7WO7VVULDmDWfZGsw5wciLmS1jXYcoYhQmCIoYN8HPej3RW+IsFki4pE
         BEFIUE1PvIPsw==
Date:   Wed, 9 Aug 2023 17:27:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <20230809162749.GA4663@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck>
 <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck>
 <ZNOr0ggoO9kXHJWl@nvidia.com>
 <20230809162254.GB4591@willie-the-truck>
 <ZNO+QVkXcHG78KG3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNO+QVkXcHG78KG3@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 01:26:41PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 05:22:54PM +0100, Will Deacon wrote:
> 
> > > > If we want to use 4k leaf tables in some cases, how would you add
> > > > that? Such a change shouldn't need the low-level strtab creation
> > > > code to change.
> > > 
> > > You would modify arm_smmu_ctx_desc_cfg to teach it about the different
> > > format. It would gain some (enum?) member that specifies the CD table
> > > layout and geometry. arm_smmu_get_cd_ste() will interpret that member
> > > and generate the correct STE for the specifc cd table.
> > 
> > Sounds a lot like the existing s1fmt field. Can we keep it?
> 
> If you are OK with the dead code, I don't object. But let's put it in
> the struct arm_smmu_ctx_desc_cfg.

Ok, we have a deal!

Will
