Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B24C76A295
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGaVX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGaVX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF81BCD;
        Mon, 31 Jul 2023 14:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C89C612A4;
        Mon, 31 Jul 2023 21:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D351EC433C7;
        Mon, 31 Jul 2023 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690838602;
        bh=zal/nhqEkOd2DBAsf4yglySl397XzFBXNWifX5Rkvrs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FfTKhsh3KSdUtzVHpvcQkBLUfxMmAfCQMC4gvRGdj3OY/0KZuxzXgbR7kW30ydjqY
         uO5LFQdsLhzc8NxAj4jvS78si/is4drRcBrjhmP+ftRVLJKxKqEa98zqmfnZroqudj
         MwzTXuGV4zjSJmI/8kMH4RFFctQMMCW6IjnQZEiuSO1wpdLmv0IL8ATqc2Nk0iT6k7
         A63LW+PbevWozYpKCBDxs6Tdb9uNzbTirbraCmS/Pg9AwuwqdQj+2ndsH4EVPm1tw6
         DgknfhATdR/T7l2p42I6efAb72XlRw7mLB4b7mPjrDgij+wBc6+WhKhVFT8y0lXG1F
         EvjUBcjwGb3+A==
Message-ID: <ac212920-286c-1ef5-fd40-a59717f59a92@kernel.org>
Date:   Mon, 31 Jul 2023 23:23:14 +0200
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

NAK.

return dev_err_probe.

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

No need, drop.

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

Ykes! No. This code needs more work.

Best regards,
Krzysztof

