Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ADD7B66BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjJCKsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjJCKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:48:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5609BAC;
        Tue,  3 Oct 2023 03:48:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ECA5C15;
        Tue,  3 Oct 2023 03:49:08 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 903193F5A1;
        Tue,  3 Oct 2023 03:48:28 -0700 (PDT)
Date:   Tue, 3 Oct 2023 11:48:26 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     Brian Masney <bmasney@redhat.com>, cristian.marussi@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] firmware: arm_scmi: Add qcom hvc/shmem transport
 support
Message-ID: <20231003104826.g6gcgirra7gcoxd7@bogus>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-5-quic_nkela@quicinc.com>
 <ZRsNHnuUdGl+vuqz@brian-x1>
 <9684a5fc-f981-bc4b-5d3a-3cd539bdb421@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9684a5fc-f981-bc4b-5d3a-3cd539bdb421@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:42:22AM -0700, Nikunj Kela wrote:
> 
> On 10/2/2023 11:34 AM, Brian Masney wrote:
> > On Mon, Sep 11, 2023 at 12:43:59PM -0700, Nikunj Kela wrote:
> > > This change adds the support for SCMI message exchange on Qualcomm
> > > virtual platforms.
> > > 
> > > The hypervisor associates an object-id also known as capability-id
> > > with each hvc doorbell object. The capability-id is used to identify the
> > > doorbell from the VM's capability namespace, similar to a file-descriptor.
> > > 
> > > The hypervisor, in addition to the function-id, expects the capability-id
> > > to be passed in x1 register when HVC call is invoked.
> > > 
> > > The function-id & capability-id are allocated by the hypervisor on bootup
> > > and are stored in the shmem region by the firmware before starting Linux.
> > > 
> > > Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> > > ---
> > >   drivers/firmware/arm_scmi/driver.c |  1 +
> > >   drivers/firmware/arm_scmi/smc.c    | 47 ++++++++++++++++++++++++++----
> > >   2 files changed, 43 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > > index 87383c05424b..ea344bc6ae49 100644
> > > --- a/drivers/firmware/arm_scmi/driver.c
> > > +++ b/drivers/firmware/arm_scmi/driver.c
> > > @@ -2915,6 +2915,7 @@ static const struct of_device_id scmi_of_match[] = {
> > >   #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
> > >   	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
> > >   	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
> > > +	{ .compatible = "qcom,scmi-hvc-shmem", .data = &scmi_smc_desc},
> > >   #endif
> > >   #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
> > >   	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
> > > diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> > > index 0a0b7e401159..94ec07fdc14a 100644
> > > --- a/drivers/firmware/arm_scmi/smc.c
> > > +++ b/drivers/firmware/arm_scmi/smc.c
> > > @@ -50,6 +50,9 @@
> > >    * @func_id: smc/hvc call function id
> > >    * @param_page: 4K page number of the shmem channel
> > >    * @param_offset: Offset within the 4K page of the shmem channel
> > > + * @cap_id: hvc doorbell's capability id to be used on Qualcomm virtual
> > > + *	    platforms
> > > + * @qcom_xport: Flag to indicate the transport on Qualcomm virtual platforms
> > >    */
> > >   struct scmi_smc {
> > > @@ -63,6 +66,8 @@ struct scmi_smc {
> > >   	u32 func_id;
> > >   	u32 param_page;
> > >   	u32 param_offset;
> > > +	u64 cap_id;
> > > +	bool qcom_xport;
> > >   };
> > [snip]
> > 
> > >   static irqreturn_t smc_msg_done_isr(int irq, void *data)
> > > @@ -129,6 +134,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> > >   	struct resource res;
> > >   	struct device_node *np;
> > >   	u32 func_id;
> > > +	u64 cap_id;
> > >   	int ret;
> > [snip]
> > 
> > > +		func_id = readl((void __iomem *)(scmi_info->shmem) + size - 16);
> > > +#ifdef CONFIG_ARM64
> > > +		cap_id = readq((void __iomem *)(scmi_info->shmem) + size - 8);
> > > +#else
> > > +		/* capability-id is 32 bit wide on 32bit machines */
> > > +		cap_id = readl((void __iomem *)(scmi_info->shmem) + size - 8);
> > > +#endif
> > The 32 bit case is defined as a u64 in two places above.
> 
> That is done to make sure the size of the structure in memory is not
> architecture dependent. This was recommended in one of the previous version
> of this patch.
> 
> 
> > 
> > > +
> > > +		/* The func-id & capability-id are kept in last 16 bytes of shmem.
> > > +		 *     +-------+
> > > +		 *     |       |
> > > +		 *     | shmem |
> > > +		 *     |       |
> > > +		 *     |       |
> > > +		 *     +-------+ <-- (size - 16)
> > > +		 *     | funcId|
> > > +		 *     +-------+ <-- (size - 8)
> > > +		 *     | capId |
> > > +		 *     +-------+ <-- size
> > > +		 */
> > Personally I'd add one more space to the right side of the table after
> > funcId.
> 
> I could do that but then in 32bit case, you would want one more space right
> after cap-id since it is 32 bit on 32 bit platform. If it helps, I can have
> two lay out one for 32bit and one for 64 bit.
>

IIUC, it was just a cosmetic change requested. Instead of this,

		+-------+ <-- (size - 16)
		| funcId|
		+-------+ <-- (size - 8)

something like this, just a extra space after 'funcId' text.

		+--------+ <-- (size - 16)
		| funcId |
		+--------+ <-- (size - 8)
-- 
Regards,
Sudeep
