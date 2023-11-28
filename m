Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8383B7FB090
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjK1C53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjK1C52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:57:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABAC1A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:57:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751EFC433C8;
        Tue, 28 Nov 2023 02:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701140251;
        bh=IhUgIdJeE+itYyxUU3dgOKEWbgbB+C0E/UB4uNL5GjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhXbFWsLNILbSv6rXeUOmomHNCY40hzy4tCGP6leUPTEZ5H35KSI0yUe2h8wxUNA+
         dqhaOXzmbG0WpgCk+g/gj2Pf+etis6HatkXWsN/jq9JGS6fEADVO+VXGaejCm7oEjW
         G5Wz2TNpQVpqSwuZgywxPwcovE+ilRCS6oVGlfWYLDHqDhRJIX207JB7dgxuDE2Z0+
         sEyqk2I1LB1ZjlWQiQEhom2QfSO0EZg4gUQcgt6NiHbP1uiZIAOeXAgpjD/cQqlVFe
         s85PtYsaP3GCgQ/B5dTzfLJZ+E4V91ttaWZi92BUW1tOKm8/g0/i9CSZVU9S8NgdOp
         vhHm8MsIl8Tww==
Date:   Mon, 27 Nov 2023 19:01:02 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        dmitry.baryshkov@linaro.org, a39.skl@gmail.com,
        konrad.dybcio@linaro.org, quic_bjorande@quicinc.com,
        mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org,
        u.kleine-koenig@pengutronix.de, robh@kernel.org,
        vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com,
        quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
Subject: Re: [PATCH v3 1/4] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Message-ID: <2lkajltbalhqipqapzsvb33mebzxb36cfvwnrtih624odja2ev@kssf4fagteri>
References: <20231127145412.3981-1-quic_bibekkum@quicinc.com>
 <20231127145412.3981-2-quic_bibekkum@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127145412.3981-2-quic_bibekkum@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 08:24:09PM +0530, Bibek Kumar Patro wrote:
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a prefetch setting of 1/3/7/15 enabling TLB to prefetch

In the previous discussion with Dmitry you stated that the "prefetch
setting" doesn't directly map to any known values. This commit message
give a clear indication about the meaning of these values.

So, please fix the commit message to properly document the value space -
to avoid confusion when people are searching for the meaning of the
defines...


Please also clarify why there are 4 possible values here, 4 possible
values of the 2 prefetch settings bits in the register, but only 3
defines in the actual patch.

Regards,
Bjorn

> the next set of page tables accordingly allowing for faster translations.
> 
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> 
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 56 +++++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  6 ++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
>  4 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 7f52ac67495f..4a38cae29be2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -14,6 +14,12 @@
> 
>  #define QCOM_DUMMY_VAL	-1
> 
> +struct actlr_config {
> +	u16 sid;
> +	u16 mask;
> +	u32 actlr;
> +};
> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>  	return container_of(smmu, struct qcom_smmu, smmu);
> @@ -205,10 +211,40 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
>  	return true;
>  }
> 
> +static void arm_smmu_set_actlr(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
> +		const struct actlr_config *actlrcfg, size_t actlrcfg_size)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	struct arm_smmu_smr *smr;
> +	int i;
> +	int j;
> +	u16 id;
> +	u16 mask;
> +	int idx;
> +
> +	for (i = 0; i < actlrcfg_size; ++i) {
> +		id = (actlrcfg + i)->sid;
> +		mask = (actlrcfg + i)->mask;
> +
> +		for_each_cfg_sme(cfg, fwspec, j, idx) {
> +			smr = &smmu->smrs[idx];
> +			if (smr_is_subset(*smr, id, mask))
> +				arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
> +						(actlrcfg + i)->actlr);
> +		}
> +	}
> +}
> +
>  static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
>  	struct adreno_smmu_priv *priv;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	const struct actlr_config *actlrcfg;
> +	size_t actlrcfg_size;
> +	int cbndx = smmu_domain->cfg.cbndx;
> 
>  	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> 
> @@ -238,6 +274,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	priv->set_stall = qcom_adreno_smmu_set_stall;
>  	priv->resume_translation = qcom_adreno_smmu_resume_translation;
> 
> +	if (qsmmu->data->actlrcfg_gfx) {
> +		actlrcfg = qsmmu->data->actlrcfg_gfx;
> +		actlrcfg_size = qsmmu->data->actlrcfg_gfx_size;
> +		arm_smmu_set_actlr(dev, smmu, cbndx, actlrcfg, actlrcfg_size);
> +	}
> +
>  	return 0;
>  }
> 
> @@ -263,6 +305,18 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	const struct actlr_config *actlrcfg;
> +	size_t actlrcfg_size;
> +	int cbndx = smmu_domain->cfg.cbndx;
> +
> +	if (qsmmu->data->actlrcfg) {
> +		actlrcfg = qsmmu->data->actlrcfg;
> +		actlrcfg_size = qsmmu->data->actlrcfg_size;
> +		arm_smmu_set_actlr(dev, smmu, cbndx, actlrcfg, actlrcfg_size);
> +	}
> +
>  	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> 
>  	return 0;
> @@ -464,7 +518,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>  		return ERR_PTR(-ENOMEM);
> 
>  	qsmmu->smmu.impl = impl;
> -	qsmmu->cfg = data->cfg;
> +	qsmmu->data = data;
> 
>  	return &qsmmu->smmu;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> index 593910567b88..138fc57f7b0d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> @@ -8,7 +8,7 @@
> 
>  struct qcom_smmu {
>  	struct arm_smmu_device smmu;
> -	const struct qcom_smmu_config *cfg;
> +	const struct qcom_smmu_match_data *data;
>  	bool bypass_quirk;
>  	u8 bypass_cbndx;
>  	u32 stall_enabled;
> @@ -25,6 +25,10 @@ struct qcom_smmu_config {
>  };
> 
>  struct qcom_smmu_match_data {
> +	const struct actlr_config *actlrcfg;
> +	size_t actlrcfg_size;
> +	const struct actlr_config *actlrcfg_gfx;
> +	size_t actlrcfg_gfx_size;
>  	const struct qcom_smmu_config *cfg;
>  	const struct arm_smmu_impl *impl;
>  	const struct arm_smmu_impl *adreno_impl;
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc0..8e4faf015286 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -990,9 +990,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
>  		 * expect simply identical entries for this case, but there's
>  		 * no harm in accommodating the generalisation.
>  		 */
> -		if ((mask & smrs[i].mask) == mask &&
> -		    !((id ^ smrs[i].id) & ~smrs[i].mask))
> +
> +		if (smr_is_subset(smrs[i], id, mask))
>  			return i;
> +
>  		/*
>  		 * If the new entry has any other overlap with an existing one,
>  		 * though, then there always exists at least one stream ID
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 703fd5817ec1..b1638bbc41d4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
>  		writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>  }
> 
> +static inline bool smr_is_subset(struct arm_smmu_smr smrs, u16 id, u16 mask)
> +{
> +	return (mask & smrs.mask) == mask && !((id ^ smrs.id) & ~smrs.mask);
> +}
> +
>  #define ARM_SMMU_GR0		0
>  #define ARM_SMMU_GR1		1
>  #define ARM_SMMU_CB(s, n)	((s)->numpage + (n))
> --
> 2.17.1
> 
> 
