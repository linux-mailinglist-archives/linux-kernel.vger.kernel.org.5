Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE20A7A5FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjISKgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjISKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:36:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9D2EA;
        Tue, 19 Sep 2023 03:36:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B49C433C7;
        Tue, 19 Sep 2023 10:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695119773;
        bh=D6DfpeYVzK3rD6VA7OhFQixuNQJ5A3vhT9JLUZQAKfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgBILvG//BL+IpMhFuZHh2hLhLRmDVg50iWXDNtIbkBjnbxwMvK8QP6RFbir02vfi
         nKbnZy9d7MAq6ryKAkWHxXPA0qGLNGwTKVXh4gMMia4BQmk/i7ICVqcKnf3jcASWAX
         KWA0BPyhv3SDOmxwP5dsyy1VHDB1zFIrOQEd3VoO4w4+frdUgyl7j+0y+NrT1nd3gW
         E7yeprkXnXpvI5eix+gnVZsd8xJkCMM1FhyrjnZzQerGMIo3c5vYXQ8SFxwcKhok/c
         c5WUAJSgfMM8vozlSRBJLN6LD7Y3lZNfv9BCSclcLVIGM9ru71SBfU8krvw+OzI1wA
         ggwlzTo+AhBuw==
Date:   Tue, 19 Sep 2023 12:36:07 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] scsi: ufs: ufs-qcom: Setup host power mode during
 init
Message-ID: <20230919103607.GA4732@thinkpad>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-2-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1694411968-14413-2-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 10:59:22PM -0700, Can Guo wrote:
> Setup host power mode and its limitations during UFS host driver init to
> avoid repetitive work during every power mode change.
> 
> Co-developed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 27 ++++++++++++++++++---------
>  drivers/ufs/host/ufs-qcom.h |  1 +
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index c3215d3..710f079 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -443,7 +443,11 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
>  static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
>  	struct phy *phy = host->generic_phy;
> +	enum phy_mode mode = host_pwr_cap->hs_rate == PA_HS_MODE_B ?
> +							PHY_MODE_UFS_HS_B :
> +							PHY_MODE_UFS_HS_A;

I do not see anyone passing PA_HS_MODE_A in this patch, so this change is not
required now. If you are doing this as a preparatory work, please do it in a
separate patch.

>  	int ret;
>  
>  	/* Reset UFS Host Controller and PHY */
> @@ -460,7 +464,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  		return ret;
>  	}
>  
> -	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);
> +	phy_set_mode_ext(phy, mode, host->phy_gear);

Same as above.

>  
>  	/* power on phy - start serdes and phy's power and clocks */
>  	ret = phy_power_on(phy);
> @@ -884,7 +888,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  				struct ufs_pa_layer_attr *dev_req_params)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	struct ufs_dev_params ufs_qcom_cap;
>  	int ret = 0;
>  
>  	if (!dev_req_params) {
> @@ -894,13 +897,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  
>  	switch (status) {
>  	case PRE_CHANGE:
> -		ufshcd_init_pwr_dev_param(&ufs_qcom_cap);
> -		ufs_qcom_cap.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
> -
> -		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
> -		ufs_qcom_cap.hs_tx_gear = ufs_qcom_cap.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> -
> -		ret = ufshcd_get_pwr_dev_param(&ufs_qcom_cap,
> +		ret = ufshcd_get_pwr_dev_param(&host->host_pwr_cap,
>  					       dev_max_params,
>  					       dev_req_params);
>  		if (ret) {
> @@ -1037,6 +1034,17 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>  		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>  }
>  
> +static void ufs_qcom_set_pwr_mode_limits(struct ufs_hba *hba)

It's good that you are moving the setting to init() as they are static, but I'm
worried about the different naming conventions used all over the place.

The intention here is to set host parameters and then get the agreed one between
host and the device. But different names are being used. The structure itself is
named as "ufs_dev_params" even though it targets host and the vendor drivers are
naming it as "ufs_<vendor>_cap" or "host_cap". And now you've given a new name,
"host_pwr_cap", which makes things even worse.

So we should rename the struct itself as "ufs_host_params" and all the vendor
drivers should stick to "host_params".

If you do not want to do it in this series, please use existing "host_cap",
since you are embedding it within "ufs_qcom_host" struct.

Also, it'd be good to make this change for other vendor drivers as well (moving
to init()).

- Mani

> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct ufs_dev_params *host_pwr_cap = &host->host_pwr_cap;
> +
> +	ufshcd_init_pwr_dev_param(host_pwr_cap);
> +
> +	/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
> +	host_pwr_cap->hs_tx_gear = host_pwr_cap->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> +}
> +
>  static void ufs_qcom_set_caps(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> @@ -1259,6 +1267,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  	if (err)
>  		goto out_variant_clear;
>  
> +	ufs_qcom_set_pwr_mode_limits(hba);
>  	ufs_qcom_set_caps(hba);
>  	ufs_qcom_advertise_quirks(hba);
>  
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index fa54248..4db64d9 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -227,6 +227,7 @@ struct ufs_qcom_host {
>  
>  	struct gpio_desc *device_reset;
>  
> +	struct ufs_dev_params host_pwr_cap;
>  	u32 phy_gear;
>  
>  	bool esi_enabled;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
