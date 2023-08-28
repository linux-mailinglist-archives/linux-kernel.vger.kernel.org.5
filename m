Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F239C78A71F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjH1IGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjH1IFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:05:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65278125;
        Mon, 28 Aug 2023 01:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBC1C616BA;
        Mon, 28 Aug 2023 08:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62984C433C8;
        Mon, 28 Aug 2023 08:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693209937;
        bh=gE6AAo7LpJHIX8SAFv0wwRy03H31xBkBS7hCtLUOaO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAOpd3aAB5MxDARCQ4QrDCaSU8ylI0MXVkU/mqxVEvwxZK7imseh28543c+ZYTMnx
         LqABG4kZ6la3bK5Jew+HaK7deWscP9o+YUiIwBgyIMcIkV9gzrLMXTqcNErXW11iaR
         AVppITIqmcN6u5UbZXdF+iMY8IxMljJyci4yKcdntfTTtO681R4QIW+toek6Nn7TfG
         cBMZmrt/3cniSXZHmB+V5YcATTpKPDrY9kD5/tSoZFwdd5xkTfsvEqj42F77s7/UUq
         VE67U61S6IDnIsoPhkd7HkEeaSekUxk17NstamYAtF4ZgCy9rUC+8ZZGcu6moNkMCF
         2/SN9khKBF4Zw==
Date:   Mon, 28 Aug 2023 13:35:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: Re: [PATCH V5 3/6] scsi: ufs: qcom: Add multiple frequency support
 for unipro clk attributes
Message-ID: <20230828080522.GD5148@thinkpad>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <20230823154413.23788-4-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823154413.23788-4-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:14:10PM +0530, Nitin Rawat wrote:
> Add Support to configure CORE_CLK_1US_CYCLES, PA_VS_CORE_CLK_40NS_CYCLES
> for multiple unipro clock frequencies. Currently this is handled only for
> only 150Mhz and 75MHz.
> 
> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 88 ++++++++++++++++++++++++++++++++-----
>  drivers/ufs/host/ufs-qcom.h |  9 ++++
>  2 files changed, 87 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index abc0e7f7d1b0..8162b19191a9 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -671,6 +671,45 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>  	return 0;
>  }
> 
> +static int ufs_qcom_cfg_core_clk_ctrl(struct ufs_hba *hba)
> +{
> +	struct list_head *head = &hba->clk_list_head;
> +	struct ufs_clk_info *clki;
> +	u32 max_freq = 0;
> +	int err;

Let's use "ret" from now onwards. Existing "err" can be cleaned up later.

> +
> +	list_for_each_entry(clki, head, list) {
> +		if (!IS_ERR_OR_NULL(clki->clk) &&
> +			!strcmp(clki->name, "core_clk_unipro")) {

Odd indentation.

> +			max_freq = clki->max_freq;
> +			break;
> +		}
> +	}
> +
> +	switch (max_freq) {
> +	case MHZ_403:

UNIPRO_CORE_CLK_FREQ_403_MHZ?

Same applies to other defines.

> +		err = ufs_qcom_set_core_clk_ctrl(hba, 403, 16);

#define to_cycles_per_1us(freq)		(freq / (1000 * 1000))

		ret = ufs_qcom_set_core_clk_ctrl(hba, to_cycles_per_1us(max_freq), 16);

> +		break;
> +	case MHZ_300:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 300, 12);
> +		break;
> +	case MHZ_201_5:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 202, 8);
> +		break;
> +	case MHZ_150:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
> +		break;
> +	case MHZ_100:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4);
> +		break;
> +	default:
> +		dev_err(hba->dev, "unipro max_freq=%u entry missing\n", max_freq);

"UNIPRO clk max frequency (%u) not supported!"

> +		err = -EINVAL;

-ERANGE

> +		break;
> +	}
> +
> +	return err;
> +}
>  static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>  					enum ufs_notify_change_status status)
>  {
> @@ -686,12 +725,15 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>  			return -EINVAL;
>  		}
> 
> -		if (ufs_qcom_cap_qunipro(host))
> -			/*
> -			 * set unipro core clock cycles to 150 & clear clock
> -			 * divider
> -			 */
> -			err = ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
> +		if (ufs_qcom_cap_qunipro(host)) {
> +			err = ufs_qcom_cfg_core_clk_ctrl(hba);
> +			if (err) {
> +				dev_err(hba->dev,
> +					"%s cfg core clk ctrl failed\n",

"Failed to configure UNIPRO core clk"

> +					__func__);
> +				return err;
> +			}
> +		}
> 
>  		/*
>  		 * Some UFS devices (and may be host) have issues if LCC is
> @@ -1369,8 +1411,7 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>  	if (!ufs_qcom_cap_qunipro(host))
>  		return 0;
> 
> -	/* set unipro core clock cycles to 150 and clear clock divider */
> -	return ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
> +	return ufs_qcom_cfg_core_clk_ctrl(hba);
>  }
> 
>  static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
> @@ -1401,12 +1442,39 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>  static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct list_head *head = &hba->clk_list_head;
> +	struct ufs_clk_info *clki;
> +	u32 curr_freq = 0;
> +	int err;
> 
>  	if (!ufs_qcom_cap_qunipro(host))
>  		return 0;
> 
> -	/* set unipro core clock cycles to 75 and clear clock divider */
> -	return ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
> +
> +	list_for_each_entry(clki, head, list) {
> +		if (!IS_ERR_OR_NULL(clki->clk) &&
> +			!strcmp(clki->name, "core_clk_unipro")) {
> +			curr_freq = clk_get_rate(clki->clk);
> +			break;
> +		}
> +	}
> +	switch (curr_freq) {
> +	case MHZ_37_5:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 38, 2);
> +		break;
> +	case MHZ_75:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
> +		break;
> +	case MHZ_100:
> +		err = ufs_qcom_set_core_clk_ctrl(hba, 100, 4);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		dev_err(hba->dev, "unipro curr_freq=%u entry missing\n", curr_freq);
> +		break;
> +	}
> +
> +	return err;

Why can't you use the existing ufs_qcom_cfg_core_clk_ctrl() function?

- Mani

>  }
> 
>  static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 325f08aca260..56550fd36c4e 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -79,6 +79,15 @@ enum {
>  	UFS_MEM_CQIS_VS		= 0x8,
>  };
> 
> +/* QCOM UFS host controller core clk frequencies */
> +#define MHZ_37_5	37500000
> +#define MHZ_50		50000000
> +#define MHZ_75		75000000
> +#define MHZ_100		100000000
> +#define MHZ_150		150000000
> +#define MHZ_300		300000000
> +#define MHZ_201_5	201500000
> +#define MHZ_403		403000000
>  #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
>  #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
> 
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
