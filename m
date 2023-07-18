Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7FB7584BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGRS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGRS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:26:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4332EB6;
        Tue, 18 Jul 2023 11:26:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B916D616AC;
        Tue, 18 Jul 2023 18:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCB9C433C7;
        Tue, 18 Jul 2023 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689704774;
        bh=BmbAbORDXYDDFKcIYnrPak+MHdZuKyT1UBUK6ko9gtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cP3E3JOJndEmXpsidCk0i1+jlQ9V5tG2WEIlI84a5fGrdAXaGkGwAOUdYqIFDnAqi
         L2+as1W1SCf+p8Tbyuv6I6RVZotAb6RR3ot/85oWg6pOydmY34UXgJscELk877uPRn
         EXorRxylWjORiudZtkt8E+3M/OGdeATITjpxnz3ZCZtdEYguEvBckJRGF9/x/tmbcw
         StbW0lJx9hrjNGiQLkhKt8CA22eCPrnLbB+UXPAGcLg1yit0vvq4HjZWsqb80pDm8E
         QOqkUuJAGV//wOcj523SmsvgkMgFiUVtx/vjVkUQZVWgPgXiWaGactFLD/KM2QVVCq
         NFyUdoP8yc6Xg==
Date:   Tue, 18 Jul 2023 11:29:37 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
Message-ID: <xkw36iwjb47q7spf6qle5x3kcmx6fv7or6cwhlpkuvihn3xmt2@qhrhtug4htp2>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718160833.36397-3-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:08:33AM -0700, Nikunj Kela wrote:
> diff --git a/drivers/firmware/arm_scmi/qcom_hvc.c b/drivers/firmware/arm_scmi/qcom_hvc.c
> new file mode 100644
> index 000000000000..3b6096d8fe67
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/qcom_hvc.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Message
> + * Qualcomm HVC/shmem Transport driver
> + *
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright 2020 NXP
> + *
> + * This is copied from drivers/firmware/arm_scmi/smc.c

s/copied from/based on/

> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/processor.h>

This is here because the original code uses spin_until_cond().

> +#include <linux/slab.h>
> +
> +#include "common.h"
> +
> +/**
> + * struct scmi_qcom_hvc - Structure representing a SCMI qcom hvc transport
> + *
> + * @cinfo: SCMI channel info
> + * @shmem: Transmit/Receive shared memory area
> + * @shmem_lock: Lock to protect access to Tx/Rx shared memory area.
> + * @func_id: hvc call function-id
> + * @cap_id: hvc doorbell's capability id
> + */
> +
> +struct scmi_qcom_hvc {
> +	struct scmi_chan_info *cinfo;
> +	struct scmi_shared_mem __iomem *shmem;
> +	/* Protect access to shmem area */
> +	struct mutex shmem_lock;
> +	u32 func_id;
> +	unsigned long cap_id;

One architecture-independent and one architecture-dependent parameter,
see below.

> +};
> +
> +static irqreturn_t qcom_hvc_msg_done_isr(int irq, void *data)
> +{
> +	struct scmi_qcom_hvc *scmi_info = data;
> +
> +	scmi_rx_callback(scmi_info->cinfo,
> +			 shmem_read_header(scmi_info->shmem), NULL);

80-char is a nice guideline, but this would be easier to read if not
line-wrapped.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static bool qcom_hvc_chan_available(struct device_node *of_node, int idx)
> +{
> +	struct device_node *np = of_parse_phandle(of_node, "shmem", 0);
> +
> +	if (!np)
> +		return false;
> +
> +	of_node_put(np);
> +	return true;
> +}
> +
> +static inline void qcom_hvc_channel_lock_init(struct scmi_qcom_hvc *scmi_info)
> +{
> +	mutex_init(&scmi_info->shmem_lock);

Just inline these three lock-related methods, saves the reader from
wondering what is actually locked, what a "channel" is (is a "channel"
the same thing as a "shm region"?) etc.

> +}
> +
> +static inline void
> +qcom_hvc_channel_lock_acquire(struct scmi_qcom_hvc *scmi_info,
> +			      struct scmi_xfer *xfer __maybe_unused)
> +{

You claim above that you copied smc.c, but you don't mention that you
dropped the support for transfers from atomic mode. Please capture this
in the commit message, so that someone looking at this in the future
knows why you made this choice.

> +	mutex_lock(&scmi_info->shmem_lock);
> +}
> +
> +static inline void qcom_hvc_channel_lock_release(struct scmi_qcom_hvc
> +						 *scmi_info)
> +{
> +	mutex_unlock(&scmi_info->shmem_lock);
> +}
> +
> +static int qcom_hvc_chan_setup(struct scmi_chan_info *cinfo,
> +			       struct device *dev, bool tx)
> +{
> +	struct device *cdev = cinfo->dev;
> +	struct scmi_qcom_hvc *scmi_info;
> +	resource_size_t size;
> +	struct resource res;
> +	struct device_node *np;
> +	unsigned long cap_id;
> +	u32 func_id;
> +	int ret, irq;

Please declare one variable per line, and please sort them by length, in
descending order (i.e. reverse Christmas tree).

> +
> +	if (!tx)
> +		return -ENODEV;
> +
> +	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
> +	if (!scmi_info)
> +		return -ENOMEM;
> +
> +	np = of_parse_phandle(cdev->of_node, "shmem", 0);
> +	if (!of_device_is_compatible(np, "arm,scmi-shmem"))
> +		return -ENXIO;
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	of_node_put(np);
> +	if (ret) {
> +		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
> +		return ret;
> +	}
> +
> +	size = resource_size(&res);
> +
> +	/* let's map 2 additional ulong since
> +	 * func-id & capability-id are kept after shmem.
> +	 *     +-------+
> +	 *     |       |
> +	 *     | shmem |
> +	 *     |       |
> +	 *     |       |
> +	 *     +-------+ <-- size
> +	 *     | funcId|
> +	 *     +-------+ <-- size + sizeof(ulong)
> +	 *     | capId |
> +	 *     +-------+ <-- size + 2*sizeof(ulong)

Relying on an undocumented convention that following the region
specified in DeviceTree are two architecture specifically sized integers
isn't good practice.

This should be covered by the DeviceTree binding, in one way or another.

> +	 */
> +
> +	scmi_info->shmem = devm_ioremap(dev, res.start,
> +					size + 2 * sizeof(unsigned long));

I don't find any code that uses the size of the defined shm, so I don't
think you need to do this dance.

> +	if (!scmi_info->shmem) {
> +		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	func_id = readl((void *)(scmi_info->shmem) + size);
> +
> +#ifdef CONFIG_ARM64
> +	cap_id = readq((void *)(scmi_info->shmem) + size +
> +		       sizeof(unsigned long));
> +#else
> +	cap_id = readl((void *)(scmi_info->shmem) + size +
> +		       sizeof(unsigned long));
> +#endif

Please don't make the in-memory representation depend on architecture
specific data types. Quite likely you didn't compile test one of these
variants?

Just define the in-memory representation as u32 + u64.

> +
> +	/*
> +	 * If there is an interrupt named "a2p", then the service and
> +	 * completion of a message is signaled by an interrupt rather than by
> +	 * the return of the hvc call.
> +	 */
> +	irq = of_irq_get_byname(cdev->of_node, "a2p");
> +	if (irq > 0) {
> +		ret = devm_request_irq(dev, irq, qcom_hvc_msg_done_isr,
> +				       IRQF_NO_SUSPEND,
> +				       dev_name(dev), scmi_info);
> +		if (ret) {
> +			dev_err(dev, "failed to setup SCMI completion irq\n");
> +			return ret;
> +		}
> +	} else {
> +		cinfo->no_completion_irq = true;
> +	}
> +
> +	scmi_info->func_id = func_id;
> +	scmi_info->cap_id = cap_id;
> +	scmi_info->cinfo = cinfo;
> +	qcom_hvc_channel_lock_init(scmi_info);
> +	cinfo->transport_info = scmi_info;
> +
> +	return 0;
> +}
> +
> +static int qcom_hvc_chan_free(int id, void *p, void *data)
> +{
> +	struct scmi_chan_info *cinfo = p;
> +	struct scmi_qcom_hvc *scmi_info = cinfo->transport_info;
> +
> +	cinfo->transport_info = NULL;
> +	scmi_info->cinfo = NULL;

Your a2p interrupt is cleaned up using devres, which will happen at a
later point. So just setting cinfo to NULL here would cause an interrupt
to trigger qcom_hvc_msg_done_isr() which will call scmi_rx_callback()
which happily will dereference that NULL.

> +
> +	return 0;
> +}
> +
> +static int qcom_hvc_send_message(struct scmi_chan_info *cinfo,
> +				 struct scmi_xfer *xfer)
> +{
> +	struct scmi_qcom_hvc *scmi_info = cinfo->transport_info;
> +	struct arm_smccc_res res;
> +
> +	/*
> +	 * Channel will be released only once response has been
> +	 * surely fully retrieved, so after .mark_txdone()
> +	 */
> +	qcom_hvc_channel_lock_acquire(scmi_info, xfer);
> +
> +	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
> +
> +	arm_smccc_1_1_hvc(scmi_info->func_id, scmi_info->cap_id,
> +			  0, 0, 0, 0, 0, 0, &res);
> +
> +	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */

Does this hold for your implementation as well?

> +	if (res.a0) {
> +		qcom_hvc_channel_lock_release(scmi_info);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_hvc_fetch_response(struct scmi_chan_info *cinfo,
> +				    struct scmi_xfer *xfer)
> +{
> +	struct scmi_qcom_hvc *scmi_info = cinfo->transport_info;
> +
> +	shmem_fetch_response(scmi_info->shmem, xfer);
> +}
> +
> +static void qcom_hvc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> +				 struct scmi_xfer *__unused)
> +{
> +	struct scmi_qcom_hvc *scmi_info = cinfo->transport_info;
> +
> +	qcom_hvc_channel_lock_release(scmi_info);
> +}
> +
> +static const struct scmi_transport_ops scmi_qcom_hvc_ops = {
> +	.chan_available = qcom_hvc_chan_available,
> +	.chan_setup = qcom_hvc_chan_setup,
> +	.chan_free = qcom_hvc_chan_free,
> +	.send_message = qcom_hvc_send_message,
> +	.mark_txdone = qcom_hvc_mark_txdone,
> +	.fetch_response = qcom_hvc_fetch_response,
> +};
> +
> +const struct scmi_desc scmi_qcom_hvc_desc = {
> +	.ops = &scmi_qcom_hvc_ops,
> +	.max_rx_timeout_ms = 30,
> +	.max_msg = 20,

I'm confused about the purpose of this number, it serves both as a limit
of the number of clients that are currently allowed to prepare messages,
and as a limit for how many outstanding transfers waiting for response.

Making the prior limit too low will result in the client running into an
-ENOMEM which it likely won't recover from - the user experience after
getting -ENOMEM on regulator_enable() will be suboptimal...

The latter limit would relate to resource limitations on the firmware
side. Please make sure that you have accounted for 2.5kB of firmware
memory, per agent, in your design.

> +	.max_msg_size = 128,

Regards,
Bjorn
