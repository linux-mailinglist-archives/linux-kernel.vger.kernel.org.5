Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C089576A28B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGaVRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjGaVQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CF41BEA;
        Mon, 31 Jul 2023 14:16:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DC1612DF;
        Mon, 31 Jul 2023 21:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5573C433C8;
        Mon, 31 Jul 2023 21:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690838214;
        bh=Beb76i4tUZTNXiJ+eleS4wywWbP1Gvm8OjqFBzhISq4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KrdHG0WQiCKyJtCKBPv4PZguGuB98U3WgMnI5EBiUqx+ANgg8ygqW2fBfL/FTmS0k
         qlwP68hhQxA3rWnvyJl2r0qm/cFF/5CRTHTWO9hp++pNPHpgOwo6yasK3qPfM6ZIRq
         jNmRw57R0VTCNBzfLb/jEcmGCl0MpeG6UAfb30UjntkpryeCEbe1JxceTBbChotCe4
         bnosrmF9LaVEh48EJe4yrlhGR93jfz7QNTcgkqfTj5WvDUWrcesyW1t/epuBCj1DLE
         QBWxKqqTBSH14KBrkPDv9yBUwTCj/h1IGF7dTsgGXIQWuDRpYqdfz/Yd5BSQXcTWWW
         //EpYPAWEP9vg==
Message-ID: <0149fcd0-e64b-f155-05d8-f32a78d7e83b@kernel.org>
Date:   Mon, 31 Jul 2023 23:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 02/33] iris: vidc: add core functions
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 15:23, Vikash Garodia wrote:
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> This implements the platform driver methods, file
> operations and v4l2 registration.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  .../platform/qcom/iris/vidc/src/msm_vidc_probe.c   | 660 +++++++++++++++++++++
>  1 file changed, 660 insertions(+)
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
> 
> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
> new file mode 100644
> index 0000000..43439cb
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
> @@ -0,0 +1,660 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020-2022, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/stringify.h>
> +#include <linux/version.h>
> +#include <linux/workqueue.h>
> +
> +#include "msm_vidc_core.h"
> +#include "msm_vidc_debug.h"
> +#include "msm_vidc_driver.h"
> +#include "msm_vidc_internal.h"
> +#include "msm_vidc_memory.h"
> +#include "msm_vidc_platform.h"
> +#include "msm_vidc_state.h"
> +#include "venus_hfi.h"
> +
> +#define BASE_DEVICE_NUMBER 32
> +
> +struct msm_vidc_core *g_core;
> +
> +static inline bool is_video_device(struct device *dev)
> +{
> +	return !!(of_device_is_compatible(dev->of_node, "qcom,sm8550-vidc"));

Where is it documented? Are you 100% sure that checkpatch does not complain?

I is also a bit surprising to see of_device_is_compatible inside the
code in some random place. How does it scale? Any driver data and
variant checks should be done via helpers and driver data, not putting
compatibles in multiple places.


> +}
> +
> +static inline bool is_video_context_bank_device(struct device *dev)
> +{
> +	return !!(of_device_is_compatible(dev->of_node, "qcom,vidc,cb-ns"));
> +}
> +
> +static int msm_vidc_init_resources(struct msm_vidc_core *core)
> +{
> +	struct msm_vidc_resource *res = NULL;
> +	int rc = 0;
> +
> +	res = devm_kzalloc(&core->pdev->dev, sizeof(*res), GFP_KERNEL);
> +	if (!res) {
> +		d_vpr_e("%s: failed to alloc memory for resource\n", __func__);
> +		return -ENOMEM;
> +	}
> +	core->resource = res;
> +
> +	rc = call_res_op(core, init, core);
> +	if (rc) {
> +		d_vpr_e("%s: Failed to init resources: %d\n", __func__, rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id msm_vidc_dt_match[] = {
> +	{.compatible = "qcom,sm8550-vidc"},
> +	{.compatible = "qcom,vidc,cb-ns"},

No, srsly, where did you document it?

If this is not suitable for upstreaming (as it looks like) mark it as
RFC, so we will know it that you did not run checkpatch...


> +	MSM_VIDC_EMPTY_BRACE
> +};
> +MODULE_DEVICE_TABLE(of, msm_vidc_dt_match);
> +
> +static void msm_vidc_release_video_device(struct video_device *vdev)
> +{
> +	d_vpr_e("%s: video device released\n", __func__);

And why would you ever print anything here? What's wrong with tracing?

> +}

...

> +
> +static int msm_vidc_probe_video_device(struct platform_device *pdev)
> +{
> +	int rc = 0;
> +	struct msm_vidc_core *core = NULL;
> +	int nr = BASE_DEVICE_NUMBER;
> +
> +	d_vpr_h("%s: %s\n", __func__, dev_name(&pdev->dev));

No debug prints reinventing tracing.

> +
> +	core = devm_kzalloc(&pdev->dev, sizeof(struct msm_vidc_core), GFP_KERNEL);
> +	if (!core) {
> +		d_vpr_e("%s: failed to alloc memory for core\n", __func__);

Ooops, this for sure did not pass any checks by tools. Sorry, please run
basic checks like coccinelle, smatch, sparse, W=1 builds.

> +		return -ENOMEM;
> +	}
> +	g_core = core;
> +
> +	core->pdev = pdev;
> +	dev_set_drvdata(&pdev->dev, core);
> +
> +	core->debugfs_parent = msm_vidc_devm_debugfs_get(&pdev->dev);
> +	if (!core->debugfs_parent)
> +		d_vpr_h("Failed to create debugfs for msm_vidc\n");
> +
> +	rc = msm_vidc_devm_init_core(&pdev->dev, core);
> +	if (rc) {
> +		d_vpr_e("%s: init core failed with %d\n", __func__, rc);
> +		goto init_core_failed;
> +	}
> +
> +	rc = msm_vidc_init_platform(core);
> +	if (rc) {
> +		d_vpr_e("%s: init platform failed with %d\n", __func__, rc);
> +		rc = -EINVAL;
> +		goto init_plat_failed;
> +	}
> +
> +	rc = msm_vidc_init_resources(core);
> +	if (rc) {
> +		d_vpr_e("%s: init resource failed with %d\n", __func__, rc);
> +		goto init_res_failed;
> +	}
> +
> +	rc = msm_vidc_init_core_caps(core);
> +	if (rc) {
> +		d_vpr_e("%s: init core caps failed with %d\n", __func__, rc);
> +		goto init_res_failed;
> +	}
> +
> +	rc = msm_vidc_init_instance_caps(core);
> +	if (rc) {
> +		d_vpr_e("%s: init inst cap failed with %d\n", __func__, rc);
> +		goto init_inst_caps_fail;
> +	}
> +
> +	core->debugfs_root = msm_vidc_debugfs_init_core(core);
> +	if (!core->debugfs_root)
> +		d_vpr_h("Failed to init debugfs core\n");
> +
> +	d_vpr_h("populating sub devices\n");
> +	/*
> +	 * Trigger probe for each sub-device i.e. qcom,msm-vidc,context-bank.
> +	 * When msm_vidc_probe is called for each sub-device, parse the
> +	 * context-bank details.
> +	 */
> +	rc = of_platform_populate(pdev->dev.of_node, msm_vidc_dt_match, NULL,
> +				  &pdev->dev);
> +	if (rc) {
> +		d_vpr_e("Failed to trigger probe for sub-devices\n");
> +		goto sub_dev_failed;
> +	}
> +
> +	rc = v4l2_device_register(&pdev->dev, &core->v4l2_dev);
> +	if (rc) {
> +		d_vpr_e("Failed to register v4l2 device\n");
> +		goto v4l2_reg_failed;
> +	}
> +
> +	/* setup the decoder device */
> +	rc = msm_vidc_register_video_device(core, MSM_VIDC_DECODER, nr);
> +	if (rc) {
> +		d_vpr_e("Failed to register video decoder\n");
> +		goto dec_reg_failed;
> +	}
> +
> +	/* setup the encoder device */
> +	rc = msm_vidc_register_video_device(core, MSM_VIDC_ENCODER, nr + 1);
> +	if (rc) {
> +		d_vpr_e("Failed to register video encoder\n");
> +		goto enc_reg_failed;
> +	}
> +
> +	rc = venus_hfi_queue_init(core);
> +	if (rc) {
> +		d_vpr_e("%s: interface queues init failed\n", __func__);
> +		goto queues_init_failed;
> +	}
> +
> +	rc = msm_vidc_core_init(core);
> +	if (rc) {
> +		d_vpr_e("%s: sys init failed\n", __func__);
> +		goto core_init_failed;
> +	}
> +
> +	d_vpr_h("%s(): succssful\n", __func__);
> +
> +	return rc;
> +
> +core_init_failed:
> +	venus_hfi_queue_deinit(core);
> +queues_init_failed:
> +	of_platform_depopulate(&pdev->dev);
> +sub_dev_failed:
> +	msm_vidc_unregister_video_device(core, MSM_VIDC_ENCODER);
> +enc_reg_failed:
> +	msm_vidc_unregister_video_device(core, MSM_VIDC_DECODER);
> +dec_reg_failed:
> +	v4l2_device_unregister(&core->v4l2_dev);
> +v4l2_reg_failed:
> +init_inst_caps_fail:
> +init_res_failed:
> +init_plat_failed:
> +init_core_failed:
> +	dev_set_drvdata(&pdev->dev, NULL);
> +	g_core = NULL;
> +
> +	return rc;
> +}
> +
> +static int msm_vidc_probe_context_bank(struct platform_device *pdev)
> +{
> +	struct msm_vidc_core *core = NULL;
> +	int rc = 0;
> +
> +	if (!pdev) {
> +		d_vpr_e("%s: Invalid platform device %pK", __func__, pdev);
> +		return -EINVAL;
> +	} else if (!pdev->dev.parent) {
> +		d_vpr_e("%s: Failed to find a parent for %s\n",
> +			__func__, dev_name(&pdev->dev));
> +		return -ENODEV;
> +	}
> +
> +	d_vpr_h("%s(): %s\n", __func__, dev_name(&pdev->dev));
> +
> +	core = dev_get_drvdata(pdev->dev.parent);
> +	if (!core) {
> +		d_vpr_e("%s: core not found in device %s",
> +			__func__, dev_name(pdev->dev.parent));
> +		return -EINVAL;
> +	}
> +
> +	rc = msm_vidc_setup_context_bank(core, &pdev->dev);
> +	if (rc) {
> +		d_vpr_e("%s: Failed to probe context bank %s\n",
> +			__func__, dev_name(&pdev->dev));
> +		return rc;
> +	}
> +
> +	return rc;
> +}
> +
> +static int msm_vidc_probe(struct platform_device *pdev)
> +{
> +	if (!pdev) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Sub devices probe will be triggered by of_platform_populate() towards
> +	 * the end of the probe function after msm-vidc device probe is
> +	 * completed. Return immediately after completing sub-device probe.
> +	 */
> +	if (is_video_device(&pdev->dev))
> +		return msm_vidc_probe_video_device(pdev);
> +	else if (is_video_context_bank_device(&pdev->dev))
> +		return msm_vidc_probe_context_bank(pdev);
> +
> +	/* How did we end up here? */
> +	WARN_ON(1);
> +	return -EINVAL;
> +}
> +
> +static int msm_vidc_pm_suspend(struct device *dev)
> +{
> +	int rc = 0;
> +	struct msm_vidc_core *core;
> +	enum msm_vidc_allow allow = MSM_VIDC_DISALLOW;
> +
> +	/*
> +	 * Bail out if
> +	 * - driver possibly not probed yet
> +	 * - not the main device. We don't support power management on
> +	 *   subdevices (e.g. context banks)
> +	 */
> +	if (!dev || !dev->driver || !is_video_device(dev))
> +		return 0;
> +
> +	core = dev_get_drvdata(dev);
> +	if (!core) {
> +		d_vpr_e("%s: invalid core\n", __func__);

How core can be invalid?

> +		return -EINVAL;
> +	}
> +
> +	core_lock(core, __func__);

What's this? Why do you use some custom locking (it's almost never a
good idea)?

> +	allow = msm_vidc_allow_pm_suspend(core);
> +
> +	if (allow == MSM_VIDC_IGNORE) {
> +		d_vpr_h("%s: pm already suspended\n", __func__);

So you have bug in PM runtime code? Runtime PM does not suspend devices
twice.

> +		msm_vidc_change_core_sub_state(core, 0, CORE_SUBSTATE_PM_SUSPEND, __func__);
> +		rc = 0;
> +		goto unlock;
> +	} else if (allow != MSM_VIDC_ALLOW) {
> +		d_vpr_h("%s: pm suspend not allowed\n", __func__);
> +		rc = 0;
> +		goto unlock;
> +	}
> +
> +	rc = msm_vidc_suspend(core);
> +	if (rc == -EOPNOTSUPP)
> +		rc = 0;
> +	else if (rc)
> +		d_vpr_e("Failed to suspend: %d\n", rc);
> +	else
> +		msm_vidc_change_core_sub_state(core, 0, CORE_SUBSTATE_PM_SUSPEND, __func__);
> +
> +unlock:
> +	core_unlock(core, __func__);
> +	return rc;
> +}
> +

Best regards,
Krzysztof

