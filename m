Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B657FB12D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbjK1FY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjK1FY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:24:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF6194
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:24:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EA5C433C8;
        Tue, 28 Nov 2023 05:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701149073;
        bh=sIsBjrpSot3b7HbeiDj1WiAo9EQ85x5QrsxcU8uxZBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZYM5gfYm03LDxKFecMOeBwx5JVe8LekM4ojSyc/OpPTl0GC+2gZ5BUpizpddey6O
         tzf44X/apOlirmH6b4SEvA5GYkdU/d/q38hLR3FwgtFiL6sNHDzlHPnMghA4BWVBTe
         X3HHej83UxkZt2xlvM8qVSj4I5wGIjT7iJA0qypU25hZangjbevvoqc3Ysxxn5UR0L
         QTSvPSTuWuUIxoCcQCnCBnOv2cmJjbVTvOvFxT3gilEk22daPjLZbJHre9b4YN7KDW
         V1VWL+9WqpOjcGG8sMTRvt3wY2ggcQX+INb4THk9xDeUU0IC3Jnk1hU9+A0BQba4DJ
         YmN9VAmYitnog==
Date:   Tue, 28 Nov 2023 10:54:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, adrian.hunter@intel.com, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/10] scsi: ufs: ufs-qcom: Setup host power mode
 during init
Message-ID: <20231128052418.GD3088@thinkpad>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-4-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1700729190-17268-4-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:46:23AM -0800, Can Guo wrote:
> Setup host power mode and its limitations during UFS host driver init to
> avoid repetitive work during every power mode change.
> 
> Acked-by: Andrew Halaney <ahalaney@redhat.com>
> Co-developed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 21 ++++++++++++++-------
>  drivers/ufs/host/ufs-qcom.h |  1 +
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index cc30ad9..cc0eb37 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -898,7 +898,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  				struct ufs_pa_layer_attr *dev_req_params)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	struct ufs_host_params host_params;
> +	struct ufs_host_params *host_params = &host->host_params;
>  	int ret = 0;
>  
>  	if (!dev_req_params) {
> @@ -908,12 +908,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  
>  	switch (status) {
>  	case PRE_CHANGE:
> -		ufshcd_init_host_param(&host_params);
> -
> -		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
> -		host_params.hs_tx_gear = host_params.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> -
> -		ret = ufshcd_negotiate_pwr_param(&host_params, dev_max_params, dev_req_params);
> +		ret = ufshcd_negotiate_pwr_param(host_params, dev_max_params, dev_req_params);
>  		if (ret) {
>  			dev_err(hba->dev, "%s: failed to determine capabilities\n",
>  					__func__);
> @@ -1048,6 +1043,17 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>  		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>  }
>  
> +static void ufs_qcom_set_host_params(struct ufs_hba *hba)
> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct ufs_host_params *host_params = &host->host_params;
> +
> +	ufshcd_init_host_param(host_params);
> +
> +	/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
> +	host_params->hs_tx_gear = host_params->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> +}
> +
>  static void ufs_qcom_set_caps(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> @@ -1272,6 +1278,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  
>  	ufs_qcom_set_caps(hba);
>  	ufs_qcom_advertise_quirks(hba);
> +	ufs_qcom_set_host_params(hba);
>  
>  	err = ufs_qcom_ice_init(host);
>  	if (err)
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 82cd143..11419eb 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -238,6 +238,7 @@ struct ufs_qcom_host {
>  
>  	struct gpio_desc *device_reset;
>  
> +	struct ufs_host_params host_params;
>  	u32 phy_gear;
>  
>  	bool esi_enabled;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
