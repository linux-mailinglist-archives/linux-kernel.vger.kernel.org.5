Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B357BF8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjJJKnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjJJKm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:42:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F3CFB7;
        Tue, 10 Oct 2023 03:42:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 874F31FB;
        Tue, 10 Oct 2023 03:43:37 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D05F3F762;
        Tue, 10 Oct 2023 03:42:55 -0700 (PDT)
Date:   Tue, 10 Oct 2023 11:42:52 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/2] firmware: arm_scmi: Add qcom smc/hvc transport
 support
Message-ID: <20231010104252.dwix4xg766uk2y44@bogus>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231009191437.27926-1-quic_nkela@quicinc.com>
 <20231009191437.27926-3-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009191437.27926-3-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:14:37PM -0700, Nikunj Kela wrote:
> This change adds the support for SCMI message exchange on Qualcomm
> virtual platforms.
> 
> The hypervisor associates an object-id also known as capability-id
> with each smc/hvc doorbell object. The capability-id is used to
> identify the doorbell from the VM's capability namespace, similar
> to a file-descriptor.
> 
> The hypervisor, in addition to the function-id, expects the capability-id
> to be passed in x1 register when SMC/HVC call is invoked.
> 
> The capability-id is allocated by the hypervisor on bootup and is stored in
> the shmem region by the firmware before starting Linux.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

FYI for the next time. When posting on the list, the senders sign-off must
be the last. The only reason I signed off is because it is needed as part
of committer in the git repo. You should have ideally dropped it in this case.
If there was some other author/co-developer of the patch, then your signoff
will be always at the end as you are sending the patch.

Refer "Sign your work - the Developer's Certificate of Origin" section
in Documentation/process/submitting-patches.rst

> ---
>  drivers/firmware/arm_scmi/driver.c |  1 +
>  drivers/firmware/arm_scmi/smc.c    | 27 +++++++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 87383c05424b..09371f40d61f 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -2915,6 +2915,7 @@ static const struct of_device_id scmi_of_match[] = {
>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
>  	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
>  	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
> +	{ .compatible = "qcom,scmi-smc", .data = &scmi_smc_desc},
>  #endif
>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>  	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 8eba60a41975..7611e9665038 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/limits.h>
>  #include <linux/processor.h>
>  #include <linux/slab.h>
>  
> @@ -50,6 +51,8 @@
>   * @func_id: smc/hvc call function id
>   * @param_page: 4K page number of the shmem channel
>   * @param_offset: Offset within the 4K page of the shmem channel
> + * @cap_id: smc/hvc doorbell's capability id to be used on Qualcomm virtual
> + *	    platforms
>   */
>  
>  struct scmi_smc {
> @@ -63,6 +66,7 @@ struct scmi_smc {
>  	unsigned long func_id;
>  	unsigned long param_page;
>  	unsigned long param_offset;
> +	unsigned long cap_id;
>  };
>  
>  static irqreturn_t smc_msg_done_isr(int irq, void *data)
> @@ -124,6 +128,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  			  bool tx)
>  {
>  	struct device *cdev = cinfo->dev;
> +	unsigned long cap_id = ULONG_MAX;
>  	struct scmi_smc *scmi_info;
>  	resource_size_t size;
>  	struct resource res;
> @@ -162,6 +167,18 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> +	if (of_device_is_compatible(dev->of_node, "qcom,scmi-smc")) {
> +		void __iomem *ptr = (void __iomem *)scmi_info->shmem + size - 8;
> +		/* The capability-id is kept in last 8 bytes of shmem.
> +		 *     +-------+ <-- 0
> +		 *     | shmem |
> +		 *     +-------+ <-- size - 8
> +		 *     | capId |
> +		 *     +-------+ <-- size
> +		 */
> +		memcpy_fromio(&cap_id, ptr, sizeof(cap_id));
> +	}
> +
>  	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param")) {
>  		scmi_info->param_page = SHMEM_PAGE(res.start);
>  		scmi_info->param_offset = SHMEM_OFFSET(res.start);
> @@ -184,6 +201,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	}
>  
>  	scmi_info->func_id = func_id;
> +	scmi_info->cap_id = cap_id;
>  	scmi_info->cinfo = cinfo;
>  	smc_channel_lock_init(scmi_info);
>  	cinfo->transport_info = scmi_info;
> @@ -220,8 +238,13 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>  
>  	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
>  
> -	arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->param_page,
> -			     scmi_info->param_offset, 0, 0, 0, 0, 0, &res);
> +	if (scmi_info->cap_id != ULONG_MAX)
> +		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
> +				     0, 0, 0, 0, 0, &res);
> +	else
> +		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->param_page,
> +				     scmi_info->param_offset, 0, 0, 0, 0, 0,
> +				     &res);
>  
>  	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
>  	if (res.a0) {
> -- 
> 2.17.1
> 

-- 
Regards,
Sudeep
