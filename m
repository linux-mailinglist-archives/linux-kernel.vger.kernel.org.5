Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF57FE94A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344631AbjK3Gm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjK3Gm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:42:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE031A8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:42:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD50C433CC;
        Thu, 30 Nov 2023 06:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701326553;
        bh=3ZrDhM013NGA07FQN53GnlT8/tNmjwSsKx1hHNJ7Rzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loGYpoO9b1Y80KOFWcAmmz+L3BS2lYVqrAe2I3+oIUMPTgpIggiN0w7ObJ6whM40y
         glzLAWEGmpGAkaCUPRd6LtqkwmZ9oLLR20JEi1d8nYXYB+rwmkbiT7e+D3IKEfN3/l
         4CwBkthUsXx1pvYHXxob0fT0lFjwAKGxlqXKAV2WIHMs3/uJ4fAbuPLz58X/omgVKd
         ArP4lN0B54GGuYKBYBV7ra+iiHxFptsZWuUEwcEQUqCmHagjCpYXRlTfBT8Ayk34V3
         Fr2RfRRmL2bEay6iyh6iAiSLWSYb3hY6mT+D8Bk0ZSYVrx8haFZ96eZ/fTglIqfYkO
         lU5OJYFXv8tJA==
Date:   Thu, 30 Nov 2023 12:12:21 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
        cmd4@qualcomm.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 04/10] scsi: ufs: ufs-qcom: Allow the first init start
 with the maximum supported gear
Message-ID: <20231130064221.GE3043@thinkpad>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-5-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1701246516-11626-5-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:28:29AM -0800, Can Guo wrote:
> During host driver init, the phy_gear is set to the minimum supported gear
> (HS_G2). Then, during the first power mode change, the negotiated gear, say
> HS-G4, is updated to the phy_gear variable so that in the second init the
> updated phy_gear can be used to program the PHY.
> 
> But the current code only allows update the phy_gear to a higher value. If
> one wants to start the first init with the maximum support gear, say HS-G4,
> the phy_gear is not updated to HS-G3 if the device only supports HS-G3.
> 
> The original check added there is intend to make sure the phy_gear won't be
> updated when gear is scaled down (during clock scaling). Update the check
> so that one can start the first init with the maximum support gear without
> breaking the original fix by checking the ufshcd_state, that is, allow
> update to phy_gear only if power mode change is invoked from
> ufshcd_probe_hba().
> 
> This change is a preparation patch for the next patches in the same series.

If you happen to respin the series, please remove this line. When the patches
get merged, there will be no concept of patches/series as all will be git
commits.

You can have this information in the comment section (below --- line) though.

> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 9a90019..81056b9 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -916,11 +916,12 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  		}
>  
>  		/*
> -		 * Update phy_gear only when the gears are scaled to a higher value. This is
> -		 * because, the PHY gear settings are backwards compatible and we only need to
> -		 * change the PHY gear settings while scaling to higher gears.
> +		 * During UFS driver probe, always update the PHY gear to match the negotiated
> +		 * gear, so that, if quirk UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH is enabled,
> +		 * the second init can program the optimal PHY settings. This allows one to start
> +		 * the first init with either the minimum or the maximum support gear.
>  		 */
> -		if (dev_req_params->gear_tx > host->phy_gear)
> +		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
>  			host->phy_gear = dev_req_params->gear_tx;
>  
>  		/* enable the device ref clock before changing to HS mode */
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
