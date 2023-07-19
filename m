Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F0759382
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGSKzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGSKz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:55:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05C5318D;
        Wed, 19 Jul 2023 03:55:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F05A82F4;
        Wed, 19 Jul 2023 03:56:09 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2723F67D;
        Wed, 19 Jul 2023 03:55:24 -0700 (PDT)
Date:   Wed, 19 Jul 2023 11:55:14 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>, sudeep.holla@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
Message-ID: <ZLfBEsVQ8Zf7NO3d@e120937-lin>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
 <xkw36iwjb47q7spf6qle5x3kcmx6fv7or6cwhlpkuvihn3xmt2@qhrhtug4htp2>
 <5c76250b-4415-950e-6aab-7ccbdc6ca83a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c76250b-4415-950e-6aab-7ccbdc6ca83a@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:53:24AM -0700, Nikunj Kela wrote:
> 
> On 7/18/2023 11:29 AM, Bjorn Andersson wrote:
> > On Tue, Jul 18, 2023 at 09:08:33AM -0700, Nikunj Kela wrote:
> > > diff --git a/drivers/firmware/arm_scmi/qcom_hvc.c b/drivers/firmware/arm_scmi/qcom_hvc.c
> > > new file mode 100644
> > > index 000000000000..3b6096d8fe67
> > > --- /dev/null
> > > +++ b/drivers/firmware/arm_scmi/qcom_hvc.c
> > > @@ -0,0 +1,241 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * System Control and Management Interface (SCMI) Message
> > > + * Qualcomm HVC/shmem Transport driver
> > > + *
> > > + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> > > + * Copyright 2020 NXP
> > > + *
> > > + * This is copied from drivers/firmware/arm_scmi/smc.c
> > s/copied from/based on/
> ok.

Hi Nikunj,

> > 
> > > + */
> > > +
> > > +#include <linux/arm-smccc.h>
> > > +#include <linux/device.h>
> > > +#include <linux/err.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>

[snip]

> > > +
> > > +static inline void
> > > +qcom_hvc_channel_lock_acquire(struct scmi_qcom_hvc *scmi_info,
> > > +			      struct scmi_xfer *xfer __maybe_unused)
> > > +{
> > You claim above that you copied smc.c, but you don't mention that you
> > dropped the support for transfers from atomic mode. Please capture this
> > in the commit message, so that someone looking at this in the future
> > knows why you made this choice.
> 
> At the moment, we dont have any requirement to support atomicity. Will add a
> comment in the commit message.
> 

As said no atomic support no wrappers needed.

> 
> > 
> > > +	mutex_lock(&scmi_info->shmem_lock);
> > > +}
> > > +
> > > +static inline void qcom_hvc_channel_lock_release(struct scmi_qcom_hvc
> > > +						 *scmi_info)
> > > +{
> > > +	mutex_unlock(&scmi_info->shmem_lock);
> > > +}
> > > +
> > > +static int qcom_hvc_chan_setup(struct scmi_chan_info *cinfo,
> > > +			       struct device *dev, bool tx)
> > > +{
> > > +	struct device *cdev = cinfo->dev;
> > > +	struct scmi_qcom_hvc *scmi_info;
> > > +	resource_size_t size;
> > > +	struct resource res;
> > > +	struct device_node *np;
> > > +	unsigned long cap_id;
> > > +	u32 func_id;
> > > +	int ret, irq;
> > Please declare one variable per line, and please sort them by length, in
> > descending order (i.e. reverse Christmas tree).
> ok
> > 
> > > +
> > > +	if (!tx)
> > > +		return -ENODEV;
> > > +
> > > +	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
> > > +	if (!scmi_info)
> > > +		return -ENOMEM;
> > > +
> > > +	np = of_parse_phandle(cdev->of_node, "shmem", 0);
> > > +	if (!of_device_is_compatible(np, "arm,scmi-shmem"))
> > > +		return -ENXIO;
> > > +
> > > +	ret = of_address_to_resource(np, 0, &res);
> > > +	of_node_put(np);
> > > +	if (ret) {
> > > +		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	size = resource_size(&res);
> > > +
> > > +	/* let's map 2 additional ulong since
> > > +	 * func-id & capability-id are kept after shmem.
> > > +	 *     +-------+
> > > +	 *     |       |
> > > +	 *     | shmem |
> > > +	 *     |       |
> > > +	 *     |       |
> > > +	 *     +-------+ <-- size
> > > +	 *     | funcId|
> > > +	 *     +-------+ <-- size + sizeof(ulong)
> > > +	 *     | capId |
> > > +	 *     +-------+ <-- size + 2*sizeof(ulong)
> > Relying on an undocumented convention that following the region
> > specified in DeviceTree are two architecture specifically sized integers
> > isn't good practice.
> > 
> > This should be covered by the DeviceTree binding, in one way or another.
> 
> ok. Usually, DTBs don't allow non-hw properties in the dtb. I can try adding
> a property as cap-id-width if its allowed.
> 

This is sort of transport configuration so maybe it could be placed on a
shmem on its own, but it seems difficult that the binding can be accepted
since, as you said, is not an HW description BUT indeed configuration.

> 
> > 
> > > +	 */
> > > +
> > > +	scmi_info->shmem = devm_ioremap(dev, res.start,
> > > +					size + 2 * sizeof(unsigned long));
> > I don't find any code that uses the size of the defined shm, so I don't
> > think you need to do this dance.
> Right! I can remove the addition part.
> > 

Mmm...but can you access this trailing config bytes if you dont ioremap it ?

> > > +	if (!scmi_info->shmem) {
> > > +		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
> > > +		return -EADDRNOTAVAIL;
> > > +	}
> > > +
> > > +	func_id = readl((void *)(scmi_info->shmem) + size);
> > > +
> > > +#ifdef CONFIG_ARM64
> > > +	cap_id = readq((void *)(scmi_info->shmem) + size +
> > > +		       sizeof(unsigned long));
> > > +#else
> > > +	cap_id = readl((void *)(scmi_info->shmem) + size +
> > > +		       sizeof(unsigned long));
> > > +#endif
> > Please don't make the in-memory representation depend on architecture
> > specific data types. Quite likely you didn't compile test one of these
> > variants?
> > 
> > Just define the in-memory representation as u32 + u64.
> I tested this for ARM64, I didn't test it for 32bit since Hypervisor doesn't
> support it currently. In future, it may add 32 bit support too.
> > > +
> > > +	/*
> > > +	 * If there is an interrupt named "a2p", then the service and
> > > +	 * completion of a message is signaled by an interrupt rather than by
> > > +	 * the return of the hvc call.
> > > +	 */
> > > +	irq = of_irq_get_byname(cdev->of_node, "a2p");
> > > +	if (irq > 0) {
> > > +		ret = devm_request_irq(dev, irq, qcom_hvc_msg_done_isr,
> > > +				       IRQF_NO_SUSPEND,
> > > +				       dev_name(dev), scmi_info);
> > > +		if (ret) {
> > > +			dev_err(dev, "failed to setup SCMI completion irq\n");
> > > +			return ret;
> > > +		}
> > > +	} else {
> > > +		cinfo->no_completion_irq = true;
> > > +	}
> > > +
> > > +	scmi_info->func_id = func_id;
> > > +	scmi_info->cap_id = cap_id;
> > > +	scmi_info->cinfo = cinfo;
> > > +	qcom_hvc_channel_lock_init(scmi_info);
> > > +	cinfo->transport_info = scmi_info;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int qcom_hvc_chan_free(int id, void *p, void *data)
> > > +{
> > > +	struct scmi_chan_info *cinfo = p;
> > > +	struct scmi_qcom_hvc *scmi_info = cinfo->transport_info;
> > > +
> > > +	cinfo->transport_info = NULL;
> > > +	scmi_info->cinfo = NULL;
> > Your a2p interrupt is cleaned up using devres, which will happen at a
> > later point. So just setting cinfo to NULL here would cause an interrupt
> > to trigger qcom_hvc_msg_done_isr() which will call scmi_rx_callback()
> > which happily will dereference that NULL.
> Ok, will add a check in ISR.
> > 

Other transports here takes care to block/inhibit any further possible
message reception with a transport/subsystem dependent method (like masking
the IRQ calling into mbox subsys or breaking the virtio device); I suppose
here you could also unregister the ISR before clearing to NULL.
(and I'll need to post a similar fix for SMC...)

Thanks,
Cristian
