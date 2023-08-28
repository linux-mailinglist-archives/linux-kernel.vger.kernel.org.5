Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB9A78A777
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjH1ISY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjH1ISD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956251A6;
        Mon, 28 Aug 2023 01:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE8D633BD;
        Mon, 28 Aug 2023 08:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CEDC433C7;
        Mon, 28 Aug 2023 08:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693210654;
        bh=qBWd+q0agMWBA8SxQUSyoQNGqIS2NvJEdeZcW4X58/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJFZkjuLooSQvl/kgsH1ZkpLmIIss/WI+uoGjtqSrIOItxcM2Sht5rRE+hu5smAlP
         Fyq9S4oyFjU4PokoNAr5OxWM3CeaS08mL7HXStL5D7PZ6ITylcbU/jVLgTZwYTyfqv
         PGiWdHjAs4B1/xbXjYv8rleVmly596b3adDXZerFTBln+dFHz8SiXXIWz8LLgdzltu
         mb/vkRJ3ryOeMk3X55cDbl2vmVIVDrqvR7OcwimAGD5O1G3/tBWFo4NKD/0XuS2Hti
         EsLnFCWqjGoGbSlc3BpbQGZgvoyyYPPsvrU6nu1L20P1v5sC4fapSFIOOdl1DMc+Wo
         pPhARmXvybT9Q==
Date:   Mon, 28 Aug 2023 13:47:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: Re: [PATCH V5 5/6] scsi: ufs: qcom: Refactor ufs_qcom_cfg_timers
 function.
Message-ID: <20230828081719.GG5148@thinkpad>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <20230823154413.23788-6-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823154413.23788-6-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:14:12PM +0530, Nitin Rawat wrote:
> This change configures SYS1CLK_1US_REG for pre scale up condition. Also
> move ufs_qcom_cfg_timers from clk scaling post change ops to clk scaling
> pre change ops to align with the hardware specification.
> 

Same comment as previous patch. This looks like a bug fix to me.

Also, this patch should be splitted into 2. SYS1CLK_1US_REG and
ufs_qcom_cfg_timers change.

- Mani

> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 61 +++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 491c0173603e..82cf3ac4193a 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -533,7 +533,8 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>   * Return: zero for success and non-zero in case of a failure.
>   */
>  static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
> -			       u32 hs, u32 rate, bool update_link_startup_timer)
> +				 u32 hs, u32 rate, bool link_startup,
> +				 bool is_pre_scale_up)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>  	struct ufs_clk_info *clki;
> @@ -564,11 +565,16 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>  	/*
>  	 * The Qunipro controller does not use following registers:
>  	 * SYS1CLK_1US_REG, TX_SYMBOL_CLK_1US_REG, CLK_NS_REG &
> -	 * UFS_REG_PA_LINK_STARTUP_TIMER
> -	 * But UTP controller uses SYS1CLK_1US_REG register for Interrupt
> -	 * Aggregation logic.
> -	*/
> -	if (ufs_qcom_cap_qunipro(host) && !ufshcd_is_intr_aggr_allowed(hba))
> +	 * UFS_REG_PA_LINK_STARTUP_TIMER.
> +	 * However UTP controller uses SYS1CLK_1US_REG register for Interrupt
> +	 * Aggregation logic and Auto hibern8 logic.
> +	 * It is mandatory to write SYS1CLK_1US_REG register on UFS host
> +	 * controller V4.0.0 onwards.
> +	 */
> +	if (ufs_qcom_cap_qunipro(host) &&
> +	    !(ufshcd_is_intr_aggr_allowed(hba) ||
> +	    ufshcd_is_auto_hibern8_supported(hba) ||
> +	    host->hw_ver.major >= 4))
>  		return 0;
> 
>  	if (gear == 0) {
> @@ -577,8 +583,14 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>  	}
> 
>  	list_for_each_entry(clki, &hba->clk_list_head, list) {
> -		if (!strcmp(clki->name, "core_clk"))
> -			core_clk_rate = clk_get_rate(clki->clk);
> +		if (!strcmp(clki->name, "core_clk")) {
> +			if (is_pre_scale_up)
> +				core_clk_rate = clki->max_freq;
> +			else
> +				core_clk_rate = clk_get_rate(clki->clk);
> +			break;
> +		}
> +
>  	}
> 
>  	/* If frequency is smaller than 1MHz, set to 1MHz */
> @@ -658,7 +670,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>  		mb();
>  	}
> 
> -	if (update_link_startup_timer && host->hw_ver.major != 0x5) {
> +	if (link_startup && host->hw_ver.major != 0x5) {
>  		ufshcd_writel(hba, ((core_clk_rate / MSEC_PER_SEC) * 100),
>  			      REG_UFS_CFG0);
>  		/*
> @@ -719,7 +731,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>  	switch (status) {
>  	case PRE_CHANGE:
>  		if (ufs_qcom_cfg_timers(hba, UFS_PWM_G1, SLOWAUTO_MODE,
> -					0, true)) {
> +					0, true, false)) {
>  			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
>  				__func__);
>  			return -EINVAL;
> @@ -968,7 +980,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  	case POST_CHANGE:
>  		if (ufs_qcom_cfg_timers(hba, dev_req_params->gear_rx,
>  					dev_req_params->pwr_rx,
> -					dev_req_params->hs_rate, false)) {
> +					dev_req_params->hs_rate, false, false)) {
>  			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
>  				__func__);
>  			/*
> @@ -1401,11 +1413,24 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>  static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
> +	int err;
> 
>  	if (!ufs_qcom_cap_qunipro(host))
> -		return 0;
> +		goto out;
> +
> +	if (attr) {
> +		err = ufs_qcom_cfg_timers(hba, attr->gear_rx,
> +					    attr->pwr_rx, attr->hs_rate,
> +					    false, true);
> +		if (err)
> +			dev_err(hba->dev, "%s ufs cfg timer failed\n",
> +								__func__);
> +	}
> 
> -	return ufs_qcom_cfg_core_clk_ctrl(hba);
> +	err = ufs_qcom_cfg_core_clk_ctrl(hba);
> +out:
> +	return err;
>  }
> 
>  static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
> @@ -1441,6 +1466,7 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>  static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
>  	struct list_head *head = &hba->clk_list_head;
>  	struct ufs_clk_info *clki;
>  	u32 curr_freq = 0;
> @@ -1449,6 +1475,9 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>  	if (!ufs_qcom_cap_qunipro(host))
>  		return 0;
> 
> +	if (attr)
> +		ufs_qcom_cfg_timers(hba, attr->gear_rx, attr->pwr_rx,
> +					 attr->hs_rate, false, false);
> 
>  	list_for_each_entry(clki, head, list) {
>  		if (!IS_ERR_OR_NULL(clki->clk) &&
> @@ -1480,7 +1509,6 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>  		bool scale_up, enum ufs_notify_change_status status)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	struct ufs_pa_layer_attr *dev_req_params = &host->dev_req_params;
>  	int err = 0;
> 
>  	/* check the host controller state before sending hibern8 cmd */
> @@ -1510,11 +1538,6 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>  			return err;
>  		}
> 
> -		ufs_qcom_cfg_timers(hba,
> -				    dev_req_params->gear_rx,
> -				    dev_req_params->pwr_rx,
> -				    dev_req_params->hs_rate,
> -				    false);
>  		ufs_qcom_icc_update_bw(host);
>  		ufshcd_uic_hibern8_exit(hba);
>  	}
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
