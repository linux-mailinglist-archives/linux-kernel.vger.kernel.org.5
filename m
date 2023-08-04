Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5375770646
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjHDQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjHDQtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C1E198B;
        Fri,  4 Aug 2023 09:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 237CF62086;
        Fri,  4 Aug 2023 16:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B64BC433C7;
        Fri,  4 Aug 2023 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691167740;
        bh=lQCx9Dz9yMtIj1Oyu19SVTHVNDkjX0ALa4mVG6hzUYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0NfLVmp5hsUaUKM6GPz934nSxdGx97smGiC+ITLAyEyXGIb+6nz65V1gDN8bai0g
         kx9ZPaj+vqXSj7lNRk/Uly0NmRV4XU1mwCsoSiVCn0rh9enVoJ1DxwwIr8lXfo2hbZ
         t/mjcHZTbBdkTcLpgk3eFrRi3EPyIAC9uOGZWXPxSXzFLtUf2iOF2ignNe4gbRGuEF
         XGD/mfAjQ6ykpb9PA0TDYp3Yvx6Tsj14z22ecBbTYKXv1+07qbAXCDOmM4uhJRvIFG
         TCKdgtTRtP+NshOspyzucj/zd4OfD402u/ZLajV5lRN5g5wRekCqGrJBQY1NdrTMaL
         rx5GvJNKDAyOg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qRxyz-0005Xp-0t;
        Fri, 04 Aug 2023 18:48:58 +0200
Date:   Fri, 4 Aug 2023 18:48:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] firmware: qcom_scm: Add support for Qualcomm
 Secure Execution Environment SCM interface
Message-ID: <ZM0r-ZrkWXBtNZJZ@hovoldconsulting.com>
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-3-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730161906.606163-3-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 06:19:03PM +0200, Maximilian Luz wrote:

> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Qualcomm Secure Execution Environment (SEE) interface (QSEECOM).
> + * Responsible for setting up and managing QSEECOM client devices.
> + *
> + * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>

Looks like you're missing some includes like module.h and slab.h.

> +
> +#include <linux/firmware/qcom/qcom_qseecom.h>
> +#include <linux/firmware/qcom/qcom_scm.h>

> +static void qseecom_client_release(struct device *dev)
> +{
> +	struct qseecom_client *client = container_of(dev, struct qseecom_client, aux_dev.dev);

Nit: Perhaps you can separate declaration and initialisation here to
stay within 80 columns.

> +
> +	kfree(client);
> +}

> +static int qcom_qseecom_remove(struct platform_device *qseecom_dev)
> +{
> +	return 0;	/* Nothing to do here, all is managed via devm. */
> +}

You should just drop this one (even if it serves as documentation).

> +static struct platform_driver qcom_qseecom_driver = {
> +	.driver = {
> +		.name	= "qcom_qseecom",
> +	},
> +	.probe = qcom_qseecom_probe,
> +	.remove = qcom_qseecom_remove,
> +};
> +
> +static int __init qcom_qseecom_init(void)
> +{
> +	return platform_driver_register(&qcom_qseecom_driver);
> +}
> +subsys_initcall(qcom_qseecom_init);
> +
> +static void __exit qcom_qseecom_exit(void)
> +{
> +	platform_driver_unregister(&qcom_qseecom_driver);
> +}
> +module_exit(qcom_qseecom_exit);

No need for this one either since this driver can only be built-in now.

> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
> +MODULE_DESCRIPTION("Driver for the Qualcomm SEE (QSEECOM) interface");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:qcom_qseecom");

No need for MODULE_ALIAS() either.

> +static void qcom_scm_qseecom_free(void *data)
> +{
> +	struct platform_device *qseecom_dev = data;
> +
> +	platform_device_unregister(qseecom_dev);

Perhaps use platform_device_del() and platform_device_put() for symmetry
as you're not using platform_device_register() below.

> +}
> +
> +static int qcom_scm_qseecom_init(struct qcom_scm *scm)
> +{
> +	struct platform_device *qseecom_dev;
> +	u32 version;
> +	int ret;
> +
> +	/*
> +	 * Note: We do two steps of validation here: First, we try to query the
> +	 * QSEECOM version as a check to see if the interface exists on this
> +	 * device. Second, we check against known good devices due to current
> +	 * driver limitations (see comment in qcom_scm_qseecom_allowlist).
> +	 *
> +	 * Note that we deliberately do the machine check after the version
> +	 * check so that we can log potentially supported devices. This should
> +	 * be safe as downstream sources indicate that the version query is
> +	 * neither blocking nor reentrant.
> +	 */
> +	ret = qcom_scm_qseecom_get_version(&version);
> +	if (ret)
> +		return 0;
> +
> +	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
> +
> +	if (!qcom_scm_qseecom_machine_is_allowed()) {
> +		dev_info(scm->dev, "qseecom: untested device, skipping\n");

untested "machine"?

> +		return 0;
> +	}
> +
> +	/*
> +	 * Set up QSEECOM interface device. All application clients will be
> +	 * set up and managed by the corresponding driver for it.
> +	 */
> +	qseecom_dev = platform_device_alloc("qcom_qseecom", -1);
> +	if (!qseecom_dev)
> +		return -ENOMEM;
> +
> +	qseecom_dev->dev.parent = scm->dev;
> +
> +	ret = platform_device_add(qseecom_dev);
> +	if (ret) {
> +		platform_device_put(qseecom_dev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(scm->dev, qcom_scm_qseecom_free, qseecom_dev);
> +}
> +
> +#else /* CONFIG_QCOM_QSEECOM */
> +
> +static int qcom_scm_qseecom_init(struct qcom_scm *scm)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_QCOM_QSEECOM */
> +
>  /**
>   * qcom_scm_is_available() - Checks if SCM is available
>   */
> @@ -1468,6 +1848,18 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	if (download_mode)
>  		qcom_scm_set_download_mode(true);
>  
> +	/*
> +	 * Initialize the QSEECOM interface. Note: QSEECOM is fairly

Nit: I'd add a line break and an empty line before the "Note:".

> +	 * self-contained and this only adds the interface device (the driver
> +	 * of which does most of the heavy lifting). So any errors returned
> +	 * here should be either -ENOMEM or -EINVAL (with the latter only in
> +	 * case there's a bug in our code). This means that there is no need to
> +	 * bring down the whole SCM driver. Just log the error instead and let
> +	 * SCM live.
> +	 */
> +	ret = qcom_scm_qseecom_init(scm);
> +	WARN(ret < 0, "failed to initialize qseecom: %d", ret);

Missing '\n'.

> +
>  	return 0;
>  }
>  
  
> +#ifdef CONFIG_QCOM_QSEECOM
> +
> +int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id);
> +int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
> +			      size_t rsp_size);
> +
> +#else /* CONFIG_QCOM_QSEECOM */
> +
> +int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
> +{
> +	return -EINVAL;
> +}
> +
> +int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
> +			      size_t rsp_size)
> +{
> +	return -EINVAL;
> +}

These should be static inline as you already noticed.

> +
> +#endif /* CONFIG_QCOM_QSEECOM */
> +
>  #endif

With the above fixed you can add my

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
