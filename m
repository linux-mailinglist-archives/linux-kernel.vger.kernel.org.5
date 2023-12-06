Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD33C8073A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379145AbjLFP0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379088AbjLFP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:26:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F032BDE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:26:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7BFC433C8;
        Wed,  6 Dec 2023 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701876417;
        bh=ErOUL0OR4b4hUkNAU5v24U4RXrnfJw3pOrdPFiz7eOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQ9Iv/tGorGk7fvwR9E+4Z8h5RM1dV3/5S7kwpiBtNtvuNiTNNg36Df+XdZZavqwI
         mdvSKnon4grfYi5DaWWIyRZ8y61twyzALmuuMxZ9aQodeMBizWht8+vVH8SN1SbyfV
         4l8QqzRBrdIw7snA1S/c6e6qr00V4vUxruBRTnV+gbNzeb/PAj3Ej2CfYm/aKwK45n
         5vtBcYj5Q+ySjP2GkAVBz264JqHGfUbW4ZALgj+Sl85bten71VVVPeRtHFf8WdGjPY
         oq2mFIRf9xRm3WdijVp2xkwnJnCjZYcE8G2x7YLzgAFj7Xs7poDQfEfON0Zc9buXnQ
         0nR7p0iSSPNJg==
Date:   Wed, 6 Dec 2023 20:56:46 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Maramaina Naresh <quic_mnaresh@quicinc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chu.stanley@gmail.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: Re: [PATCH V2 1/3] ufs: core: Add CPU latency QoS support for ufs
 driver
Message-ID: <20231206152646.GH12802@thinkpad>
References: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
 <20231204143101.64163-2-quic_mnaresh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204143101.64163-2-quic_mnaresh@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 08:00:59PM +0530, Maramaina Naresh wrote:
> Register ufs driver to CPU latency PM QoS framework can improves
> ufs device random io performance.
> 
> PM QoS initialization will insert new QoS request into the CPU
> latency QoS list with the maximum latency PM_QOS_DEFAULT_VALUE
> value.
> 
> UFS driver will vote for performance mode on scale up and power
> save mode for scale down.
> 
> If clock scaling feature is not enabled then voting will be based
> on clock on or off condition.
> 
> tiotest benchmark tool io performance results on sm8550 platform:
> 
> 1. Without PM QoS support
> 	Type (Speed in)    | Average of 18 iterations
> 	Random Write(IPOS) | 41065.13
> 	Random Read(IPOS)  | 37101.3
> 
> 2. With PM QoS support
> 	Type (Speed in)    | Average of 18 iterations
> 	Random Write(IPOS) | 46784.9
> 	Random Read(IPOS)  | 42943.4
> (Improvement % with PM QoS = ~15%).
> 
> Co-developed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
> ---
>  drivers/ufs/core/ufshcd-priv.h |  8 +++++
>  drivers/ufs/core/ufshcd.c      | 62 ++++++++++++++++++++++++++++++++++
>  include/ufs/ufshcd.h           | 16 +++++++++
>  3 files changed, 86 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index f42d99ce5bf1..536805f6c4e1 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -241,6 +241,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
>  		hba->vops->config_scaling_param(hba, p, data);
>  }
>  
> +static inline u32 ufshcd_vops_config_qos_vote(struct ufs_hba *hba)
> +{
> +	if (hba->vops && hba->vops->config_qos_vote)
> +		return hba->vops->config_qos_vote(hba);

Please remove this callback as Bart noted.

> +
> +	return UFSHCD_QOS_DEFAULT_VOTE;
> +}
> +
>  static inline void ufshcd_vops_reinit_notify(struct ufs_hba *hba)
>  {
>  	if (hba->vops && hba->vops->reinit_notify)
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index ae9936fc6ffb..13370febd2b5 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -1001,6 +1001,20 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
>  	return ufshcd_get_local_unipro_ver(hba) < UFS_UNIPRO_VER_1_6;
>  }
>  
> +/**
> + * ufshcd_pm_qos_perf - vote for PM QoS performance or power save mode

ufshcd_pm_qos_update() - Update PM QoS request

> + * @hba: per adapter instance
> + * @on: If True, vote for perf PM QoS mode otherwise power save mode
> + */
> +static void ufshcd_pm_qos_perf(struct ufs_hba *hba, bool on)
> +{
> +	if (!hba->pm_qos_init)
> +		return;
> +
> +	cpu_latency_qos_update_request(&hba->pm_qos_req, on ? hba->qos_vote
> +							: PM_QOS_DEFAULT_VALUE);
> +}
> +
>  /**
>   * ufshcd_set_clk_freq - set UFS controller clock frequencies
>   * @hba: per adapter instance
> @@ -1153,6 +1167,10 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, unsigned long freq,
>  	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
>  			(scale_up ? "up" : "down"),
>  			ktime_to_us(ktime_sub(ktime_get(), start)), ret);
> +
> +	if (!ret)
> +		ufshcd_pm_qos_perf(hba, scale_up);

Can't you just move this before trace_ufshcd_profile_clk_scaling()? This also
avoids checking for !ret.

> +
>  	return ret;
>  }
>  
> @@ -9204,6 +9222,8 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
>  	if (ret)
>  		return ret;
>  
> +	if (!ufshcd_is_clkscaling_supported(hba))
> +		ufshcd_pm_qos_perf(hba, on);
>  out:
>  	if (ret) {
>  		list_for_each_entry(clki, head, list) {
> @@ -9296,6 +9316,45 @@ static int ufshcd_init_clocks(struct ufs_hba *hba)
>  	return ret;
>  }
>  
> +/**
> + * ufshcd_pm_qos_init - initialize PM QoS instance

"Initialize PM QoS request"

> + * @hba: per adapter instance
> + */
> +static void ufshcd_pm_qos_init(struct ufs_hba *hba)
> +{
> +	if (!(hba->caps & UFSHCD_CAP_PM_QOS))
> +		return;
> +
> +	/*
> +	 * called to configure PM QoS vote value for UFS host,
> +	 * expecting qos vote return value from caller else
> +	 * default vote value will be return.
> +	 */
> +	hba->qos_vote = ufshcd_vops_config_qos_vote(hba);

No need of this variable too if you get rid of the callback.

> +	cpu_latency_qos_add_request(&hba->pm_qos_req,
> +					PM_QOS_DEFAULT_VALUE);
> +
> +	if (cpu_latency_qos_request_active(&hba->pm_qos_req))
> +		hba->pm_qos_init = true;

Why do you need this flag?

> +
> +	dev_dbg(hba->dev, "%s: QoS %s, qos_vote: %u\n", __func__,
> +		hba->pm_qos_init ? "initialized" : "uninitialized",
> +		hba->qos_vote);
> +}
> +
> +/**
> + * ufshcd_pm_qos_exit - remove instance from PM QoS
> + * @hba: per adapter instance
> + */
> +static void ufshcd_pm_qos_exit(struct ufs_hba *hba)
> +{
> +	if (!hba->pm_qos_init)
> +		return;
> +
> +	cpu_latency_qos_remove_request(&hba->pm_qos_req);
> +	hba->pm_qos_init = false;
> +}
> +

[...]

>  /**
>   * struct ufs_hba - per adapter private structure
>   * @mmio_base: UFSHCI base register address
> @@ -912,6 +923,8 @@ enum ufshcd_mcq_opr {
>   * @mcq_base: Multi circular queue registers base address
>   * @uhq: array of supported hardware queues
>   * @dev_cmd_queue: Queue for issuing device management commands
> + * @pm_qos_req: PM QoS request handle
> + * @pm_qos_init: flag to check if pm qos init completed
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -1076,6 +1089,9 @@ struct ufs_hba {
>  	struct ufs_hw_queue *uhq;
>  	struct ufs_hw_queue *dev_cmd_queue;
>  	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
> +	struct pm_qos_request pm_qos_req;
> +	bool pm_qos_init;
> +	u32 qos_vote;

Order doesn't match Kdoc.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
