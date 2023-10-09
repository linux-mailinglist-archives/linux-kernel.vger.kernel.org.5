Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B25F7BE36D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbjJIOr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjJIOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:47:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B51DFAC;
        Mon,  9 Oct 2023 07:47:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1385A1FB;
        Mon,  9 Oct 2023 07:48:29 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5DCE3F5A1;
        Mon,  9 Oct 2023 07:47:46 -0700 (PDT)
Date:   Mon, 9 Oct 2023 15:47:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] firmware: arm_scmi: Add qcom smc/hvc transport
 support
Message-ID: <20231009144744.yi44ljq4llaxjsb7@bogus>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231006164206.40710-1-quic_nkela@quicinc.com>
 <20231006164206.40710-3-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006164206.40710-3-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 09:42:06AM -0700, Nikunj Kela wrote:
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

Since you are happy to move to signed value, I assume you are happy to loose
upper half of the range values ?

Anyways after Bjorn pointed out inconsistency, I am thinking of moving
all the values to unsigned long to work with both 32bit and 64bit.

Does the below delta on top of this patch works for you and makes sense?

--
Regards,
Sudeep

-->8
diff --git c/drivers/firmware/arm_scmi/smc.c i/drivers/firmware/arm_scmi/smc.c
index bf0b7769c7b2..e00c5e81c8d9 100644
--- c/drivers/firmware/arm_scmi/smc.c
+++ i/drivers/firmware/arm_scmi/smc.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/limits.h>
 #include <linux/processor.h>
 #include <linux/slab.h>
 
@@ -65,7 +66,7 @@ struct scmi_smc {
 	unsigned long func_id;
 	unsigned long param_page;
 	unsigned long param_offset;
-	s64 cap_id;
+	unsigned long cap_id;
 };
 
 static irqreturn_t smc_msg_done_isr(int irq, void *data)
@@ -127,11 +128,11 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx)
 {
 	struct device *cdev = cinfo->dev;
+	unsigned long cap_id = ULONG_MAX;
 	struct scmi_smc *scmi_info;
 	resource_size_t size;
 	struct resource res;
 	struct device_node *np;
-	s64 cap_id = -EINVAL;
 	u32 func_id;
 	int ret;
 
@@ -167,6 +168,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		return ret;
 
 	if (of_device_is_compatible(dev->of_node, "qcom,scmi-smc")) {
+		void __iomem *ptr = (void __iomem *)scmi_info->shmem + size - 8;
 		/* The capability-id is kept in last 8 bytes of shmem.
 		 *     +-------+
 		 *     |       |
@@ -177,12 +179,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		 *     | capId |
 		 *     +-------+ <-- size
 		 */
-
-#ifdef CONFIG_64BIT
-		cap_id = ioread64((void *)scmi_info->shmem + size - 8);
-#else
-		cap_id = ioread32((void *)scmi_info->shmem + size - 8);
-#endif
+		memcpy_fromio(&cap_id, ptr, sizeof(cap_id));
 	}
 
 	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param")) {
@@ -247,7 +244,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 
 	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
 
-	if (cap_id >= 0)
+	if (cap_id != ULONG_MAX)
 		arm_smccc_1_1_invoke(scmi_info->func_id, cap_id, 0, 0, 0, 0, 0,
 				     0, &res);
 	else

