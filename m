Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3356B7FE9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbjK3HZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjK3HZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:25:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AE512C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:25:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A39BC433C7;
        Thu, 30 Nov 2023 07:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701329139;
        bh=3YX4RL0/1V4O8MWlDUyKMhHKGcnFeVIea0/CNFViUCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f1sVFBfc0P4R779c5VQ1VtL0BojnbpMZLeHp+EMcbfSo/5axvWqP9OchECsJevnWf
         dC2+VxCffos5IEZydk6/Y1WWSV4ej8uksP8dK1ZCqMnApDUS98ooeFu6KRh5klJXiL
         SuKhEC6BCMRtbrfqNxeSl97TmkPaQhPtBCBHOA4QFJLsyORdx4wi3ouV2iKh6y4TPi
         v+BCQuXZrA5DGjsFAl2jf+qdoA0cY/j5Ii+S7+zF6xY+DZUXhvxUwbVzhdmxCula/r
         lfis4EGaQ7ud0acwtauCW9iQL2ZV8SD/eJvn9oVQ5biWmzL/F24r8OPio9f9lc+nxt
         zdONEVv9XcfjQ==
Date:   Thu, 30 Nov 2023 12:55:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, adrian.hunter@intel.com, cmd4@qualcomm.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 10/10] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Message-ID: <20231130072529.GI3043@thinkpad>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-11-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1701246516-11626-11-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:28:35AM -0800, Can Guo wrote:
> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
> 
> A spare register in UFS host controller is used to indicate the UFS device
> version. The spare register is populated by bootloader for now, but in
> future it will be populated by HW automatically during link startup with
> its best efforts in any boot stages prior to Linux.
> 
> During host driver init, read the spare register, if it is not populated
> with a UFS device version, go ahead with the dual init mechanism. If a UFS
> device version is in there, use the UFS device version together with host
> controller's HW version to decide the proper PHY gear which should be used
> to configure the UFS PHY without going through the second init.
> 
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 23 ++++++++++++++++++-----
>  drivers/ufs/host/ufs-qcom.h |  2 ++
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 9c0ebbc..e94dea2 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1068,15 +1068,28 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>  static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
>  {
>  	struct ufs_host_params *host_params = &host->host_params;
> +	u32 val, dev_major = 0;

No need to initialize dev_major.

>  
>  	host->phy_gear = host_params->hs_tx_gear;
>  
> -	/*
> -	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> -	 * Switching to max gear will be performed during reinit if supported.
> -	 */
> -	if (host->hw_ver.major < 0x4)
> +	if (host->hw_ver.major < 0x4) {
> +		/*
> +		 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> +		 * Switching to max gear will be performed during reinit if supported.
> +		 */
>  		host->phy_gear = UFS_HS_G2;
> +	} else {

Can you please add a comment here to describe what is happening?

> +		val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
> +		dev_major = FIELD_GET(GENMASK(7, 4), val);

It'd be good to add a macro for GENMASK().

> +
> +		/* UFS device version populated, no need to do init twice */

"Since the UFS device version is populated, let's remove the REINIT quirk as the
negotiated gear won't change during boot. So there is no need to do reinit."

> +		if (dev_major != 0)

0x0

> +			host->hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
> +
> +		/* For UFS 3.1 and older, apply HS-G4 PHY gear to save power */
> +		if (dev_major < 0x4 && dev_major > 0)

if (dev_major > 0x0 && dev_major < 0x4)

- Mani

> +			host->phy_gear = UFS_HS_G4;
> +	}
>  }
>  
>  static void ufs_qcom_set_host_params(struct ufs_hba *hba)
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 11419eb..d12fc5a 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -54,6 +54,8 @@ enum {
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
> 

-- 
மணிவண்ணன் சதாசிவம்
