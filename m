Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5478A783
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjH1ITz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjH1ITb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5DE54;
        Mon, 28 Aug 2023 01:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 918C6633D3;
        Mon, 28 Aug 2023 08:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11B7C433C7;
        Mon, 28 Aug 2023 08:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693210734;
        bh=cDzbDvHx9JvnjQPqDVFUcA/4mZdgWX5ArbwdyQslnRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgnoRXGCXBc9zb+6F9kJ/F3ghF/JP/pRNJdRkSD7Qx+xa8lEhwj6fZLOB/5Cge8PJ
         rrp4aRuIVvWlmE1KlLglzDOjIXvH2tKK3BumZvS4gfR4bmgKhCuyXCTNNYKSMWOB6P
         p3AcS0UEEibvzlVE9eHP94fb1oATqnpAyJaR35yMQfJt7wkKVKGWStYxuhWUJxicmf
         6RaYqcHCg0GnWDDo3ralloh0luMa/CuYjdfSxopli5gq8RnatTfiZtYPOBcT78Jt46
         UXdBHi+4nJ7+up+wsypZuONQPhGuRydZFSd+uCsQMjaPlPzMG/RnzRZkTMAYlDqW0+
         bH2216HMMMqJQ==
Date:   Mon, 28 Aug 2023 13:48:37 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: Re: [PATCH V5 6/6] scsi: ufs: qcom: Handle unipro clk HW division
 based on scaling conditions.
Message-ID: <20230828081837.GH5148@thinkpad>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <20230823154413.23788-7-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823154413.23788-7-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:14:13PM +0530, Nitin Rawat wrote:
> Configure internal HW division of unipro core_clk based on scale up and
> scale down condition. This bit should be cleared before entering any
> SVS mode as per hardware specification.
> 

Same comment as previous patch.

- Mani

> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 49 ++++++++++++++++++++-----------------
>  drivers/ufs/host/ufs-qcom.h |  2 +-
>  2 files changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 82cf3ac4193a..d886e28b8a2a 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -95,7 +95,8 @@ static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
>  static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
>  static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>  					u32 clk_cycles,
> -					u32 clk_40ns_cycles);
> +					u32 clk_40ns_cycles,
> +					bool scale_up);
> 
>  static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>  {
> @@ -700,19 +701,19 @@ static int ufs_qcom_cfg_core_clk_ctrl(struct ufs_hba *hba)
> 
>  	switch (max_freq) {
>  	case MHZ_403:
> -		err = ufs_qcom_set_core_clk_ctrl(hba, 403, 16);
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 403, 16, true);
>  		break;
>  	case MHZ_300:
> -		err = ufs_qcom_set_core_clk_ctrl(hba, 300, 12);
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 300, 12, true);
>  		break;
>  	case MHZ_201_5:
> -		err = ufs_qcom_set_core_clk_ctrl(hba, 202, 8);
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 202, 8, true);
>  		break;
>  	case MHZ_150:
> -		err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6, true);
>  		break;
>  	case MHZ_100:
> -		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4);
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4, true);
>  		break;
>  	default:
>  		dev_err(hba->dev, "unipro max_freq=%u entry missing\n", max_freq);
> @@ -1352,7 +1353,8 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
> 
>  static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>  					u32 clk_1us_cycles,
> -					u32 clk_40ns_cycles)
> +					u32 clk_40ns_cycles,
> +					bool scale_up)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>  	u32 mask = DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
> @@ -1378,18 +1380,20 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>  	core_clk_ctrl_reg &= ~(mask << offset);
>  	core_clk_ctrl_reg |= clk_1us_cycles << offset;
> 
> -	/* Clear CORE_CLK_DIV_EN */
> -	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> +	if (scale_up)
> +		core_clk_ctrl_reg |= CORE_CLK_DIV_EN_BIT;
> 
>  	err = ufshcd_dme_set(hba,
> -			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> -			    core_clk_ctrl_reg);
> +			     UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> +			     core_clk_ctrl_reg);
> +	if (err)
> +		return err;
>  	/*
>  	 * UFS host controller V4.0.0 onwards needs to program
>  	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
>  	 * frequency of unipro core clk of UFS host controller.
>  	 */
> -	if (!err && (host->hw_ver.major >= 4)) {
> +	if (host->hw_ver.major >= 4) {
>  		if (clk_40ns_cycles > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
>  			return -EINVAL;
> 
> @@ -1442,22 +1446,21 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>  	int err;
> -	u32 core_clk_ctrl_reg;
> +	u32 reg;
> 
>  	if (!ufs_qcom_cap_qunipro(host))
>  		return 0;
> 
> -	err = ufshcd_dme_get(hba,
> -			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> -			    &core_clk_ctrl_reg);
> +	err = ufshcd_dme_get(hba, UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL), &reg);
> +	if (err)
> +		return err;
> 
>  	/* make sure CORE_CLK_DIV_EN is cleared */
> -	if (!err &&
> -	    (core_clk_ctrl_reg & DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT)) {
> -		core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> +	if (reg & CORE_CLK_DIV_EN_BIT) {
> +		reg &= ~CORE_CLK_DIV_EN_BIT;
>  		err = ufshcd_dme_set(hba,
>  				    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
> -				    core_clk_ctrl_reg);
> +				    reg);
>  	}
> 
>  	return err;
> @@ -1488,13 +1491,13 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>  	}
>  	switch (curr_freq) {
>  	case MHZ_37_5:
> -		err = ufs_qcom_set_core_clk_ctrl(hba, 38, 2);
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 38, 2, false);
>  		break;
>  	case MHZ_75:
> -		err = ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 75, 3, false);
>  		break;
>  	case MHZ_100:
> -		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4);
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4, false);
>  		break;
>  	default:
>  		err = -EINVAL;
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 56550fd36c4e..6e8eb4bb9247 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -140,7 +140,7 @@ enum {
>  /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
>  #define MAX_CORE_CLK_1US_CYCLES_MASK_V4		0xFFF
>  #define MAX_CORE_CLK_1US_CYCLES_OFFSET_V4	0x10
> -#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
> +#define CORE_CLK_DIV_EN_BIT			BIT(8)
>  #define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
>  #define PA_VS_CORE_CLK_40NS_CYCLES	0x9007
>  #define PA_VS_CORE_CLK_40NS_CYCLES_MASK	0x3F
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
