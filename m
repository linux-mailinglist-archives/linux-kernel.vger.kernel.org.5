Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985A0808232
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjLGHz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjLGHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:55:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D97510CC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:55:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F360C433C7;
        Thu,  7 Dec 2023 07:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701935730;
        bh=h2qXX+SDRSNTW3YzbKtkw81hP5ImdwnjfPNFY/0DW7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENVZhDKsDCJEWt2gqs/Itk/W+0OBm1YSOWMeUtZbDTk+La8+6ONji9ytbE5xtzLGm
         hDJIXrXUQkWer4CkV1ipNAMAtbzP/OL5Aza0NbY6nV13HVkd8kfn2h6EDEqRAEQX+5
         98oh/IsLPYu+UItkolSoxPsSX8TTHDNhforVEFonu75ZWM56GdtK7nGaz1F4NaRB6z
         /wTuPiNrMexMtLkwPFxBEFQpZP8tCnhgtnz3VWdYRraaz2yZKGszwwXmIHxT/RSQ70
         DUwXvzNxPTXZudre5Cp3iXAzBGJUqJ8NFtZrKDjiq65QZlXM6mRiZR1f/3xWXoaORK
         Rfn6B976M696w==
Date:   Thu, 7 Dec 2023 13:25:20 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
        vkoul@kernel.org, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 08/10] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Message-ID: <20231207075520.GF2932@thinkpad>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
 <1701520577-31163-9-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1701520577-31163-9-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 04:36:14AM -0800, Can Guo wrote:
> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
> 
> Start from HW ver 5, a spare register in UFS host controller is added and
> used to indicate the UFS device version. The spare register is populated by
> bootloader for now, but in future it will be populated by HW automatically
> during link startup with its best efforts in any boot stage prior to Linux.
> 
> During host driver init, read the spare register, if it is not populated
> with a UFS device version, go ahead with the dual init mechanism. If a UFS
> device version is in there, use the UFS device version together with host
> controller's HW version to decide the proper PHY gear which should be used
> to configure the UFS PHY without going through the second init.
> 
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> v7 -> v8:
> Fixed a BUG introduced from v6 -> v7. The spare register is added since HW ver 5, hence exclude HW ver == 4.
> 
> ---
>  drivers/ufs/host/ufs-qcom.c | 35 ++++++++++++++++++++++++++++-------
>  drivers/ufs/host/ufs-qcom.h |  4 ++++
>  2 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index ee3f07a..968a4c0 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1065,17 +1065,38 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>  static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
>  {
>  	struct ufs_host_params *host_params = &host->host_params;
> +	u32 val, dev_major;
>  
>  	host->phy_gear = host_params->hs_tx_gear;
>  
> -	/*
> -	 * For controllers whose major HW version is < 4, power up the PHY using
> -	 * minimum supported gear (UFS_HS_G2). Switching to max gear will be
> -	 * performed during reinit if supported. For newer controllers, whose
> -	 * major HW version is >= 4, power up the PHY using max supported gear.
> -	 */
> -	if (host->hw_ver.major < 0x4)
> +	if (host->hw_ver.major < 0x4) {
> +		/*
> +		 * For controllers whose major HW version is < 4, power up the
> +		 * PHY using minimum supported gear (UFS_HS_G2). Switching to
> +		 * max gear will be performed during reinit if supported.
> +		 * For newer controllers, whose major HW version is >= 4, power
> +		 * up the PHY using max supported gear.
> +		 */
>  		host->phy_gear = UFS_HS_G2;
> +	} else if (host->hw_ver.major >= 0x5) {
> +		val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
> +		dev_major = FIELD_GET(UFS_DEV_VER_MAJOR_MASK, val);
> +
> +		/*
> +		 * Since the UFS device version is populated, let's remove the
> +		 * REINIT quirk as the negotiated gear won't change during boot.
> +		 * So there is no need to do reinit.
> +		 */
> +		if (dev_major != 0x0)
> +			host->hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
> +
> +		/*
> +		 * For UFS 3.1 device and older, power up the PHY using HS-G4
> +		 * PHY gear to save power.
> +		 */
> +		if (dev_major > 0x0 && dev_major < 0x4)
> +			host->phy_gear = UFS_HS_G4;
> +	}
>  }
>  
>  static void ufs_qcom_set_host_params(struct ufs_hba *hba)
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 11419eb..32e51d9 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -23,6 +23,8 @@
>  #define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
>  #define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
>  
> +#define UFS_DEV_VER_MAJOR_MASK	GENMASK(7, 4)
> +
>  /* vendor specific pre-defined parameters */
>  #define SLOW 1
>  #define FAST 2
> @@ -54,6 +56,8 @@ enum {
>  	UFS_AH8_CFG				= 0xFC,
>  
>  	REG_UFS_CFG3				= 0x271C,
> +
> +	REG_UFS_DEBUG_SPARE_CFG			= 0x284C,
>  };
>  
>  /* QCOM UFS host controller vendor specific debug registers */
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
