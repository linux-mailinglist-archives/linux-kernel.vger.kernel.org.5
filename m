Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18F57E500D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjKHFe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjKHFe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:34:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7EA1A4;
        Tue,  7 Nov 2023 21:34:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD713C433C7;
        Wed,  8 Nov 2023 05:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699421665;
        bh=QCMb8LNvrw0v1n2WKL+qqMTAtgJkKYzYKLDoK7dEVho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INFPOU7QgqLQwfvrQ2zSmvcDkpJuMTs/mqrdkxsp5CJh3g4qm6cPnm7zqAv6AaJXC
         /slMj1Ht504mIuErcYlVfbIWwxPzRF+WGeIHYZCcFGZkNjikncQShyQ7AfZVr/2BLL
         27mIl+jpDNxTpJCAweeSX4ICRZJnuOmdOueyTmgr9VFJdbfeqyGYXjX+fvZgkH/ya1
         jW/Eo+5Kcz1Go/uRsCU51gHMhvjvQ+1Sr2URUMV2VduBebwh4z/3ckrXLQbUWbaBcs
         TusYJpgcxgeXwo5pcRx+dUd2HRBaRaHWhQ4J6lB011K+aW1JOAxRKm5cxXLyZZqP1d
         Uu5FryDZ9/pjQ==
Date:   Wed, 8 Nov 2023 11:04:15 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <cang@qti.qualcomm.com>
Cc:     quic_cang@quicinc.com, bvanassche@acm.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] scsi: ufs: ufs-qcom: Set initial PHY gear to max
 HS gear for HW ver 5 and newer
Message-ID: <20231108053415.GE3296@thinkpad>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-6-git-send-email-cang@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699332374-9324-6-git-send-email-cang@qti.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 08:46:11PM -0800, Can Guo wrote:
> From: Can Guo <quic_cang@quicinc.com>
> 
> Set the initial PHY gear to max HS gear for hosts with HW ver 5 and newer.
> 

How about,

"For UFSHC >= 5.0, set the initial PHY gear based on the gear value returned by
ufs_qcom_get_hs_gear(). For the rest, use the existing default value of G2."

> This patch is not changing any functionalities or logic but only a
> preparation patch for the next patch in this series.
> 

You are also moving the default phy_gear code to ufs_qcom_set_host_params(). So
it should be mentioned in the commit message.

> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 55ee31d..94d34b5 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1069,6 +1069,14 @@ static void ufs_qcom_set_host_params(struct ufs_hba *hba)
>  
>  	/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
>  	host_params->hs_tx_gear = host_params->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> +	host->phy_gear = host_params->hs_tx_gear;
> +
> +	/*
> +	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> +	 * Switching to max gear will be performed during reinit if supported.
> +	 */

This comment should be moved inside the "if" condition here as done in the next
patch.

- Mani

> +	if (host->hw_ver.major < 0x5)
> +		host->phy_gear = UFS_HS_G2;
>  }
>  
>  static void ufs_qcom_set_caps(struct ufs_hba *hba)
> @@ -1313,12 +1321,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
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

-- 
மணிவண்ணன் சதாசிவம்
