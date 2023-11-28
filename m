Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6827FB211
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbjK1Grc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1Grb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:47:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A7E1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:47:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0489C433C7;
        Tue, 28 Nov 2023 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701154057;
        bh=OxJgD4qf34Xbg3woKklJaOmC7kHvKBOOhlmPWeA/HYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcAob4de27eAJnSsYkTco2tUOVxlt6u5AaClzpVwGIEQSrsj/KI4FWlQWvN6PcwG3
         9gClQeLhzRkLfAfBIBTJLr+DilMRg6YAXNWHsDYjMG03tyu8XKkzi79NR0U2W3kV+0
         Krm7w+iGO86EnRwIHbF3sVUACJ7gAu4viZgX4mnclQr5sZFKGDniOyTc+DVVZjyf2Q
         oFqBoY9XRb2JY/lTwmnO0+pY7j1yzO0OV3YxqOSW3hYmGBwbBUxvc/4YobEQOjud7r
         i3HKJX7Mj0fq1Hjh+46Z7q8cJBq20gWs0MlqtZydntZLdy3j6ocP23cYRLgSHpCQ+M
         FE3bj5drIgN2A==
Date:   Tue, 28 Nov 2023 12:17:21 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, adrian.hunter@intel.com, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 09/10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Message-ID: <20231128064721.GJ3088@thinkpad>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-10-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1700729190-17268-10-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:46:29AM -0800, Can Guo wrote:
> On SM8550, two sets of UFS PHY settings are provided, one set is to support
> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
> settings are programming different values to different registers, mixing
> the two sets and/or overwriting one set with another set is definitely not
> blessed by UFS PHY designers.
> 
> To add HS-G5 support for SM8550, split the two sets of PHY settings into
> their dedicated overlay tables, only the common parts of the two sets of
> PHY settings are left in the .tbls.
> 
> Consider we are going to add even higher gear support in future, to avoid
> adding more tables with different names, rename the .tbls_hs_g4 and make it
> an array, a size of 2 is enough as of now.
> 
> In this case, .tbls alone is not a complete set of PHY settings, so either
> tbls_hs_overlay[0] or tbls_hs_overlay[1] must be applied on top of the
> .tbls to become a complete set of PHY settings.
> 

Thanks for the update! This really helps in minimizing the changes for future
gears.

> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   9 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 174 ++++++++++++++++++---
>  4 files changed, 166 insertions(+), 21 deletions(-)
> 
>  

[...]

> -static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
> +static bool qmp_ufs_match_gear_overlay(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg, int *i)
> +{
> +	u32 max_gear, floor_max_gear = cfg->max_supported_gear;
> +	bool found = false;
> +	int j;
> +
> +	for (j = 0; j < NUM_OVERLAY; j ++) {
> +		max_gear = cfg->tbls_hs_overlay[j].max_gear;
> +
> +		if (max_gear == 0)

Is this condition possible for hs_overlay tables?

> +			continue;
> +
> +		/* Direct matching, bail */
> +		if (qmp->submode == max_gear) {
> +			*i = j;
> +			return true;
> +		}
> +
> +		/* If no direct matching, the lowest gear is the best matching */
> +		if (max_gear < floor_max_gear) {

Can you start the loop from max? If looks odd to set the matching params in the
first iteration itself and then checking the next one.

> +			*i = j;
> +			found = true;
> +			floor_max_gear = max_gear;
> +		}
> +	}
> +
> +	return found;
> +}
> +
> +static int qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>  {
> +	bool apply_overlay;
> +	int i;
> +
> +	if (qmp->submode > cfg->max_supported_gear || qmp->submode == 0) {
> +		dev_err(qmp->dev, "Invalid PHY submode %u\n", qmp->submode);
> +		return -EINVAL;
> +	}

This check should be moved to qmp_ufs_set_mode().

Rest LGTM.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
