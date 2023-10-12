Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7607C6E98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378420AbjJLM4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbjJLM4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:56:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3DFBB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:56:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613C1C433C7;
        Thu, 12 Oct 2023 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697115374;
        bh=vNui3MSrHwAI++J+DJ8BgqwZ/T4bJhNXSFBtteOZtHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDGE7WqEjJP9fczYEAK2GxMtarIG+Mw1T4I/MMiGZ2e8RuFK6lB7xSJDsj2vch82I
         GGQh5SDSOfSQslY2IvZ5ynphv/hafD3WvIHGqCQC+joaRg775lstfsHAV7/RQz7wGL
         AE4D6ahH+D1IUzMNYTUp6609UQdAZaYazgWz9w5MzrozKT2aHsfbaC2bZuEz6Syw6v
         REIJfLp8gbKuwKyczeh/jJHI3icq15VMMeAg1cptLjzOv1QLx68uouTO0JC3KAzXDM
         FJlAj6r13eHhG6ARDsKWP3Z3ytqonFqIz7VN7uES2KjyyC+DFUxz7zPV15+FEPnsQq
         uhRuiaV+JKEGw==
Date:   Thu, 12 Oct 2023 13:56:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux.dev, jgg@nvidia.com,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iommu/arm-smmu: Don't register fwnode for legacy
 binding
Message-ID: <20231012125609.GA12142@willie-the-truck>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <3a5cd62dd21ed58f337bb9a389d301054e503dc3.1697047261.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5cd62dd21ed58f337bb9a389d301054e503dc3.1697047261.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:52PM +0100, Robin Murphy wrote:
> When using the legacy binding we bypass the of_xlate mechanism, so avoid
> registering the instance fwnodes which act as keys for that. This will
> help __iommu_probe_device() to retrieve the registered ops the same way
> as for x86 etc. when no fwspec has previously been set up by of_xlate.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc0..4b83a3adacd6 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2161,7 +2161,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
> +	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
> +				    using_legacy_binding ? NULL : dev);
>  	if (err) {
>  		dev_err(dev, "Failed to register iommu\n");
>  		iommu_device_sysfs_remove(&smmu->iommu);
> -- 
> 2.39.2.101.g768bb238c484.dirty

Acked-by: Will Deacon <will@kernel.org>

Will
