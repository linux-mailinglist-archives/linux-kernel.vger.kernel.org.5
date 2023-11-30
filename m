Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888307FE953
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344642AbjK3GsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3GsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:48:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9037C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:48:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D984BC433C8;
        Thu, 30 Nov 2023 06:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701326899;
        bh=gOfLP9a8UQteKGQvzwzRuAdiTT3+zV8jVyNsEuloosg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVbn8Y1WSqrmnYfNs7wYWMrkeVYraoomrCYiMSJPVQfyKa1qLyU6Bj3msNJP0fQkf
         IBVPRMw49e48Ml4sWHlgCd44rBiK7jNhCJSSvSDmislsLQhnndfJz3Bc4M9sO4rAIz
         zNiI/2hgknUh/rqq+XRS5vPlBVoLDjaxhickQhZt0lWplkM9UlEEiPaN43VfHmnQxP
         VvqC2sGstWBoyJK0yyiT3yinqX3jt+AfKBYL/ljMbQDEo/4zcPTkBuzSRcvHHM88Sk
         vbid21OE7Fd4afH5Bh8TWEY/Z3KyJcAwESlFKghM6ryF2NYpvaoig/9tSppRxbBZKM
         z/dienjQCTZ2w==
Date:   Thu, 30 Nov 2023 12:17:57 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, adrian.hunter@intel.com, cmd4@qualcomm.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/10] scsi: ufs: ufs-qcom: Set initial PHY gear to
 max HS gear for HW ver 4 and newer
Message-ID: <20231130064757.GF3043@thinkpad>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-7-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1701246516-11626-7-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:28:31AM -0800, Can Guo wrote:
> Since HW ver 4, max HS gear can be get from UFS host controller's register,
> use the max HS gear as the initial PHY gear instead of UFS_HS_G2, so that
> we don't need to update the hard code for newer targets in future.
> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/ufs/host/ufs-qcom.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index aca6199..30f4ca6 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1060,6 +1060,20 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>  		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>  }
>  
> +static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
> +{
> +	struct ufs_host_params *host_params = &host->host_params;
> +
> +	host->phy_gear = host_params->hs_tx_gear;
> +
> +	/*
> +	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> +	 * Switching to max gear will be performed during reinit if supported.

As I mentioned in v5, you need to reword this comment to make it clear we are
setting G2 only for platforms < v4. Something like below:

"For controllers whose major version is < 4, power up the PHY using minimum
supported gear (UFS_HS_G2). Switching to max gear will be performed during
reinit if supported. For newer controllers (>= 4), PHY will be powered up using
max supported gear."

- Mani

> +	 */
> +	if (host->hw_ver.major < 0x4)
> +		host->phy_gear = UFS_HS_G2;
> +}
> +
>  static void ufs_qcom_set_host_params(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> @@ -1296,6 +1310,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  	ufs_qcom_set_caps(hba);
>  	ufs_qcom_advertise_quirks(hba);
>  	ufs_qcom_set_host_params(hba);
> +	ufs_qcom_set_phy_gear(host);
>  
>  	err = ufs_qcom_ice_init(host);
>  	if (err)
> @@ -1313,12 +1328,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  		dev_warn(dev, "%s: failed to configure the testbus %d\n",
>  				__func__, err);
>  
> -	/*
> -	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> -	 * Switching to max gear will be performed during reinit if supported.
> -	 */
> -	host->phy_gear = UFS_HS_G2;
> -
>  	return 0;
>  
>  out_variant_clear:
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
