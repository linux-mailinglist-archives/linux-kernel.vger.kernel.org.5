Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785376B667
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjHANzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjHANzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB6DEC;
        Tue,  1 Aug 2023 06:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00C2E615B9;
        Tue,  1 Aug 2023 13:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE6C433C7;
        Tue,  1 Aug 2023 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690898115;
        bh=b1Ru6HQQj7OPPfkrcTILfSpriwVsHE8DXB9CcteRH7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sTftyfWhUXdsiUvIXoMfKSa+/Du3FjvtgH+PAuawF7RHao97/0VmcPoDslQutHia9
         lUcythuVIfRDv53GkwNM1bDcfWOAm6V6ykX/x76OAtoo3ZyMlP4sPxNdxFUgTb5CDM
         +4S75u8Tp4pA+QKP/HpDUZYy9aZD4Q0OXRH/PcDvvuvWtm6TbUa4zJOc5Kzi+J+FUc
         cl5E8QlmKDceNm1ZtaAU14QFm5yJbC4Y9jg5Ofzx5fj/n/NjrZy3cdLZvq6cnFIgd7
         qMMEiuZ53Ek4OX2z5SllDlLh58rxuoS7Ws5y6rfQdrL7DHZyK8qGV++DUsJHndTsI/
         bWYLLSe/C8zfw==
Date:   Tue, 1 Aug 2023 14:55:08 +0100
From:   Will Deacon <will@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, andersson@kernel.org, luca@z3ntu.xyz,
        konrad.dybcio@linaro.org, dmitry.baryshkov@linaro.org,
        joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 4/6] iommu/qcom: Index contexts by asid number to
 allow asid 0
Message-ID: <20230801135507.GB26253@willie-the-truck>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
 <20230622092742.74819-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622092742.74819-5-angelogioacchino.delregno@collabora.com>
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

On Thu, Jun 22, 2023 at 11:27:40AM +0200, AngeloGioacchino Del Regno wrote:
> This driver was indexing the contexts by asid-1, which is probably
> done under the assumption that the first ASID is always 1.
> Unfortunately this is not always true: at least for MSM8956 and
> MSM8976's GPU IOMMU, the gpu_user context's ASID number is zero.
> To allow using a zero asid number, index the contexts by `asid`
> instead of by `asid - 1`.
> 
> While at it, also enhance human readability by renaming the
> `num_ctxs` member of struct qcom_iommu_dev to `max_asid`.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index f1bd7c035db8..9786fd094e7d 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -51,8 +51,8 @@ struct qcom_iommu_dev {
>  	struct clk_bulk_data clks[CLK_NUM];
>  	void __iomem		*local_base;
>  	u32			 sec_id;
> -	u8			 num_ctxs;
> -	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid-1 */
> +	u8			 max_asid;
> +	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
>  };
>  
>  struct qcom_iommu_ctx {
> @@ -94,7 +94,7 @@ static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid
>  	struct qcom_iommu_dev *qcom_iommu = d->iommu;
>  	if (!qcom_iommu)
>  		return NULL;
> -	return qcom_iommu->ctxs[asid - 1];
> +	return qcom_iommu->ctxs[asid];
>  }
>  
>  static inline void
> @@ -534,12 +534,10 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	qcom_iommu = platform_get_drvdata(iommu_pdev);
>  
>  	/* make sure the asid specified in dt is valid, so we don't have
> -	 * to sanity check this elsewhere, since 'asid - 1' is used to
> -	 * index into qcom_iommu->ctxs:
> +	 * to sanity check this elsewhere:
>  	 */
> -	if (WARN_ON(asid < 1) ||
> -	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
> -	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
> +	if (WARN_ON(asid > qcom_iommu->max_asid) ||
> +	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
>  		put_device(&iommu_pdev->dev);
>  		return -EINVAL;
>  	}
> @@ -696,7 +694,7 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
>  
>  	dev_dbg(dev, "found asid %u\n", ctx->asid);
>  
> -	qcom_iommu->ctxs[ctx->asid - 1] = ctx;
> +	qcom_iommu->ctxs[ctx->asid] = ctx;
>  
>  	return 0;
>  }
> @@ -708,7 +706,7 @@ static void qcom_iommu_ctx_remove(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, NULL);
>  
> -	qcom_iommu->ctxs[ctx->asid - 1] = NULL;
> +	qcom_iommu->ctxs[ctx->asid] = NULL;
>  }
>  
>  static const struct of_device_id ctx_of_match[] = {
> @@ -755,11 +753,11 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  	for_each_child_of_node(dev->of_node, child)
>  		max_asid = max(max_asid, get_asid(child));
>  
> -	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid),
> +	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid + 1),
>  				  GFP_KERNEL);

So is this '+ 1' there to handle the case where ASIDs are indexed from 1? If
so, please add a comment because this isn't obvious at all.

Will
