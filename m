Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3D7764ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHIQXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjHIQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:23:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09885FD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9481F61184
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CC9C433C8;
        Wed,  9 Aug 2023 16:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691598180;
        bh=N7ndOy3GioD/nFo3aBoMYk3YXE6IcLArdc85d4DINEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKXGNuJ9OASRtuPCBpfDR7ua7lIgyw421gKDDkX0rVgpNBMcoK6dTBMyWx6P497Ex
         G0HVNUXzVeXZwhPl/Wp0+UQk4PTDHySl7xVSRsH8Zo0HcX4ZXuiUEY6XXeLzdrFCqv
         ZieEYyyCmkAq+gveHcp221v4mTPwrkReb0r0GBrE7hE7rnZB7kyq82nKeq3GIfVUlq
         GHY9FTxXejKodQTWVjHPFu8ITQDxUxC15Cv86GycOThFQWe6pDK23gm8bOAjWNNkGS
         DGSE0Eg3ptTZ3gJF5FSOO/oANkBGyaN6c2xqPOlD8ZRj8MJ0d3i2hjYXoDoXDf1429
         IKmDQe4CXPiFg==
Date:   Wed, 9 Aug 2023 17:22:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <20230809162254.GB4591@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck>
 <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck>
 <ZNOr0ggoO9kXHJWl@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNOr0ggoO9kXHJWl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:08:02PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 03:55:43PM +0100, Will Deacon wrote:
> > On Wed, Aug 09, 2023 at 10:59:33AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 09, 2023 at 02:49:41PM +0100, Will Deacon wrote:
> > > 
> > > > > @@ -1360,10 +1357,14 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> > > > >  		    !master->stall_enabled)
> > > > >  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
> > > > >  
> > > > > -		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > > > > -			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> > > > > -			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
> > > > > -			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
> > > > > +		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > > > > +		       FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> > > > > +		       FIELD_PREP(STRTAB_STE_0_S1CDMAX,
> > > > > +				  cd_table->max_cds_bits) |
> > > > > +		       FIELD_PREP(STRTAB_STE_0_S1FMT,
> > > > > +				  cd_table->l1_desc ?
> > > > > +					  STRTAB_STE_0_S1FMT_64K_L2 :
> > > > > +					  STRTAB_STE_0_S1FMT_LINEAR);
> > > > 
> > > > magically know that we're using 64k tables.
> > > > 
> > > > Why is this an improvement to the driver?
> > > 
> > > Put the above in a function 
> > > 
> > > arm_smmu_get_cd_ste(struct arm_smmu_ctx_desc_cfg *cdtab, void *ste)
> > > 
> > > And it makes more sense.
> > 
> > Sorry, but I'm not seeing it :/
> > 
> > > We don't need the driver to precompute the "s1_cfg" parameters and
> > > store them in a redundant struct along side the ctx_desc_cfg when we
> > > can compute those same values on the fly with no cost.
> > 
> > But the computation isn't happening -- the STRTAB_STE_0_S1FMT_64K_L2
> > constant is hardcoded here. 
> 
> So it would be hard coded in arm_smmu_get_cd_ste() because that
> reflects the current state of CD table code.
> 
> > If we want to use 4k leaf tables in some cases, how would you add
> > that? Such a change shouldn't need the low-level strtab creation
> > code to change.
> 
> You would modify arm_smmu_ctx_desc_cfg to teach it about the different
> format. It would gain some (enum?) member that specifies the CD table
> layout and geometry. arm_smmu_get_cd_ste() will interpret that member
> and generate the correct STE for the specifc cd table.

Sounds a lot like the existing s1fmt field. Can we keep it?

Will
