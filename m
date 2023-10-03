Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309587B67BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbjJCLTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbjJCLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:19:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D1899E;
        Tue,  3 Oct 2023 04:19:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41F69C15;
        Tue,  3 Oct 2023 04:19:57 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FB283F762;
        Tue,  3 Oct 2023 04:19:17 -0700 (PDT)
Date:   Tue, 3 Oct 2023 12:19:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] firmware: arm_scmi: Add qcom hvc/shmem transport
 support
Message-ID: <20231003111914.63z35sn3r3k7drtp@bogus>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-5-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911194359.27547-5-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 12:43:59PM -0700, Nikunj Kela wrote:
> This change adds the support for SCMI message exchange on Qualcomm
> virtual platforms.
> 
> The hypervisor associates an object-id also known as capability-id
> with each hvc doorbell object. The capability-id is used to identify the
> doorbell from the VM's capability namespace, similar to a file-descriptor.
> 
> The hypervisor, in addition to the function-id, expects the capability-id
> to be passed in x1 register when HVC call is invoked.
> 
> The function-id & capability-id are allocated by the hypervisor on bootup
> and are stored in the shmem region by the firmware before starting Linux.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>  drivers/firmware/arm_scmi/driver.c |  1 +
>  drivers/firmware/arm_scmi/smc.c    | 47 ++++++++++++++++++++++++++----
>  2 files changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 87383c05424b..ea344bc6ae49 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -2915,6 +2915,7 @@ static const struct of_device_id scmi_of_match[] = {
>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
>  	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
>  	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
> +	{ .compatible = "qcom,scmi-hvc-shmem", .data = &scmi_smc_desc},
>  #endif
>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>  	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 0a0b7e401159..94ec07fdc14a 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -50,6 +50,9 @@
>   * @func_id: smc/hvc call function id
>   * @param_page: 4K page number of the shmem channel
>   * @param_offset: Offset within the 4K page of the shmem channel
> + * @cap_id: hvc doorbell's capability id to be used on Qualcomm virtual
> + *	    platforms
> + * @qcom_xport: Flag to indicate the transport on Qualcomm virtual platforms
>   */
>  
>  struct scmi_smc {
> @@ -63,6 +66,8 @@ struct scmi_smc {
>  	u32 func_id;
>  	u32 param_page;
>  	u32 param_offset;
> +	u64 cap_id;

Can it be unsigned long instead so that it just works for both 32 and 64 bit.

> +	bool qcom_xport;

Do we really need this ?

>  };
>  
>  static irqreturn_t smc_msg_done_isr(int irq, void *data)
> @@ -129,6 +134,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	struct resource res;
>  	struct device_node *np;
>  	u32 func_id;
> +	u64 cap_id;

Ditto..

>  	int ret;
>  
>  	if (!tx)
> @@ -158,9 +164,34 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  		return -EADDRNOTAVAIL;
>  	}
>  
> -	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
> -	if (ret < 0)
> -		return ret;
> +	if (of_device_is_compatible(dev->of_node, "qcom,scmi-hvc-shmem")) {
> +		scmi_info->qcom_xport = true;
> +
> +		/* The func-id & capability-id are kept in last 16 bytes of shmem.
> +		 *     +-------+
> +		 *     |       |
> +		 *     | shmem |
> +		 *     |       |
> +		 *     |       |
> +		 *     +-------+ <-- (size - 16)
> +		 *     | funcId|
> +		 *     +-------+ <-- (size - 8)
> +		 *     | capId |
> +		 *     +-------+ <-- size
> +		 */
> +
> +		func_id = readl((void __iomem *)(scmi_info->shmem) + size - 16);

So unlike 'arm,scmi-smc', you don't want 'arm,smc-id' in the DT ? Any
particular reason ? Just to get both FID and cap ID from shmem ?

> +#ifdef CONFIG_ARM64

I would rather make this arch agnostic using CONFIG_64BIT

> +		cap_id = readq((void __iomem *)(scmi_info->shmem) + size - 8);

Do you need __iomem typecast here ? Is scmi_info->shmem not already __iomem ?
Also scmi_info->shmem is ioremapped just few steps above and you are using
read* here, is that safe ?

> +#else
> +		/* capability-id is 32 bit wide on 32bit machines */
> +		cap_id = rieadl((void __iomem *)(scmi_info->shmem) + size - 8);

Other thought once you move for u64 to unsigned long you need not have
#ifdeffery, just do copy of sizeof(unsigned long)

> +#endif
> +	} else {
> +		ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param")) {
>  		scmi_info->param_page = SHMEM_PAGE(res.start);
> @@ -184,6 +215,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	}
>  
>  	scmi_info->func_id = func_id;
> +	scmi_info->cap_id = cap_id;
>  	scmi_info->cinfo = cinfo;
>  	smc_channel_lock_init(scmi_info);
>  	cinfo->transport_info = scmi_info;
> @@ -213,6 +245,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>  	struct arm_smccc_res res;
>  	unsigned long page = scmi_info->param_page;
>  	unsigned long offset = scmi_info->param_offset;
> +	unsigned long cap_id = (unsigned long)scmi_info->cap_id;
>  
>  	/*
>  	 * Channel will be released only once response has been
> @@ -222,8 +255,12 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>  
>  	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
>  
> -	arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0, 0, 0,
> -			     &res);
> +	if (scmi_info->qcom_xport)

Just make sure cap_id is set only for qcom and just use that as your flag.
No point in setting always true scmi_info->qcom_xport and using it here.

> +		arm_smccc_1_1_hvc(scmi_info->func_id, cap_id, 0, 0, 0, 0, 0, 0,
> +				  &res);
> +	else
> +		arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0,
> +				     0, 0, &res);
>  
>  	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
>  	if (res.a0) {
> -- 
> 2.17.1
> 

-- 
Regards,
Sudeep
