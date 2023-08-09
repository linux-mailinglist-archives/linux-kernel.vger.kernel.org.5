Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5277619E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjHINtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjHINts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC161982
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 411C9616BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F9AC433C8;
        Wed,  9 Aug 2023 13:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691588986;
        bh=ar0mMRXsv0Rx7tGOFJWybZSLLq+jCQO+XeZZeG+0cTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NbSn1mREKJOAex9EGksy+mD7WRbdRuqsQfOkFvKlS4cPFZ40AS9D+ras9eOCo+uDc
         Dtl4dgc6kpLPufZKbQLxLn1guTiWQU2FBF38OiwRh69MTlE7WUpP/FURbhxsx34Ja3
         BI5PZBMcDqSv58hfWI9gkGYig8s2x1G8pimrVOn2HNmGsMaU2PScWL3bkmeM7dacpJ
         jAqrEc2+zr+lNjvnpxht2Q9hPdXcEcT4oLLPtB3q71xn3Y8yhokRQUmWM8tNYEar/X
         S3eyM9HPEEHpsUTaEqTgLN8nOvTt/kyTuSysMAMmWNNbB6ceQE9Nni8E6pX38qKzVg
         1D+7HnbxqobYA==
Date:   Wed, 9 Aug 2023 14:49:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <20230809134941.GA4226@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
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

On Wed, Aug 09, 2023 at 01:11:58AM +0800, Michael Shavit wrote:
> Remove struct arm_smmu_s1_cfg. This is really just a CD table with a
> bit of extra information. Enhance the existing CD table structure,
> struct arm_smmu_ctx_desc_cfg, with max_cds_bits and replace all usages
> of arm_smmu_s1_cfg with arm_smmu_ctx_desc_cfg.
> 
> Compute the other values that were stored in s1cfg directly from
> existing arm_smmu_ctx_desc_cfg.
> 
> For clarity, use the name "cd_table" for the variables pointing to
> arm_smmu_ctx_desc_cfg in the new code instead of cdcfg. A later patch
> will make this fully consistent.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---

Sorry, but I'm having a hard time seeing some of the benefits of this
particular change. Most of the rest of the series looks good, but see
below:

> @@ -1071,7 +1071,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>  	bool cd_live;
>  	__le64 *cdptr;
>  
> -	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
> +	if (WARN_ON(ssid >= (1 << smmu_domain->cd_table.max_cds_bits)))
>  		return -E2BIG;

S1CDMAX is architectural terminology -- it's the name given to bits 63:59
of the STE structure. Why is "max_cds_bits" better?

>  	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
> @@ -1138,19 +1138,16 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
>  	size_t l1size;
>  	size_t max_contexts;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> -	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
> +	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
>  
> -	max_contexts = 1 << cfg->s1cdmax;
> +	max_contexts = 1 << cdcfg->max_cds_bits;
>  
>  	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
>  	    max_contexts <= CTXDESC_L2_ENTRIES) {
> -		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
>  		cdcfg->num_l1_ents = max_contexts;
>  
>  		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
>  	} else {
> -		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;

And here we're dropping the S1FMT setting from the code allocating the
CD tables (i.e. the only code which should be aware of it's configuration)
and now having the low-level STE writing logic here:

> @@ -1360,10 +1357,14 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  		    !master->stall_enabled)
>  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>  
> -		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> -			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> -			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
> -			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
> +		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> +		       FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> +		       FIELD_PREP(STRTAB_STE_0_S1CDMAX,
> +				  cd_table->max_cds_bits) |
> +		       FIELD_PREP(STRTAB_STE_0_S1FMT,
> +				  cd_table->l1_desc ?
> +					  STRTAB_STE_0_S1FMT_64K_L2 :
> +					  STRTAB_STE_0_S1FMT_LINEAR);

magically know that we're using 64k tables.

Why is this an improvement to the driver?

Will
