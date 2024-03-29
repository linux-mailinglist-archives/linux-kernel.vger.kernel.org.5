Return-Path: <linux-kernel+bounces-124270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E189149F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7040288407
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F394176F;
	Fri, 29 Mar 2024 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dZj/HFMM"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38644C7C;
	Fri, 29 Mar 2024 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698948; cv=none; b=q/4li0QL3RlKO72aHyLri/4cKGLEh+AzY1VyJZV2+EEWZjTNsiMT9qdIZNQUkMBeSvr4vUlda/Vv9P75jEnuDM35XQuZkOiOz86onaLrRmO5sjKZfcVrjFhiFl7RlI0O9zBGMpTXgeJvaRtsmLGJ4s9RZUptEGtf3bPaCCLwfnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698948; c=relaxed/simple;
	bh=Nvs3LqwT7Tt/aqSIseHv/jZYUNHx1QTG7c388cyS4LU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGriJ9ZTD7MqnS6Jagkmu2KlKDGmoQXPEXQDDFw+NhoXu9CkMCdqaJkBHCiMR8DKvLj27Y7nY21dNNS+tF31FJNjMXyX434Rp7ErSZ+6c+OnlwQiuy3QVqj4AcGE6fLqi+Gze96cmaCuxxZ6pdsPNpkvIJveVCZ8LRWIbq6mNZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dZj/HFMM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SMAU2X014374;
	Fri, 29 Mar 2024 00:55:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=MpBmwyQGGcytys+zsU4Bn7
	zMHACEI2zxSek0uS9jmhg=; b=dZj/HFMMG3A7ra3chztHegECBPKP7SKDFR9S+P
	S9LtaNfbMWEkQNzewfYAqS20VTHEWbL7aimT8vbhkfcyG1eEmpeXnN2SbVbq/iTD
	KuY/kWOuD2SnvwGoy4W2+zANVdUAxe5r5K4rWz4GeccOEnLxVbInoK6SNuBhIlUl
	GjspUmAvr58fnpgbmO4rOzdYrQ/IPcdJd8Wa5H2OkWzXlrqsGqWKFyVdtMa6hcDN
	fmFnrsmIi4xovV95CiQpgdLQYs4IGXOwh/T8bl5wG2MvFXlEoD8d4zAgLv9IKn66
	vQnqrc73X5ORiaAlBwcQ+CF2JenMwZzq2z+4Pm7UFGqYxynA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x5gm3hmp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 00:55:26 -0700 (PDT)
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 42T7tQ4e023174;
	Fri, 29 Mar 2024 00:55:26 -0700
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x5gm3hmp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 00:55:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 29 Mar 2024 00:55:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 29 Mar 2024 00:55:24 -0700
Received: from IPBU-BLR-SERVER1 (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with SMTP id D45C83F707A;
	Fri, 29 Mar 2024 00:55:19 -0700 (PDT)
Date: Fri, 29 Mar 2024 13:25:18 +0530
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
CC: <olivia@selenic.com>, <herbert@gondor.apana.org.au>,
        <sehi.kim@samsung.com>, <linux-samsung-soc@vger.kernel.org>,
        <peter.griffin@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <alim.akhtar@samsung.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@android.com>, <andre.draszik@linaro.org>,
        <willmcvicker@google.com>, <saravanak@google.com>, <elder@linaro.org>,
        <tudor.ambarus@linaro.org>, <klimov.linux@gmail.com>
Subject: Re: [PATCH REVIEW] hwrng: add exynos Secure World RNG device driver
Message-ID: <20240329075518.GA1861799@IPBU-BLR-SERVER1>
References: <20240328125056.1054878-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240328125056.1054878-1-alexey.klimov@linaro.org>
X-Proofpoint-GUID: 2mAw42rsnzH4vMec9Fq6V8MxIL-GFnWz
X-Proofpoint-ORIG-GUID: nkPiBVKg3Laa6wkG8HDIk6Bmew-B--i5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_06,2024-03-28_01,2023-05-22_02

On 2024-03-28 at 18:20:56, Alexey Klimov (alexey.klimov@linaro.org) wrote:
> The Exynos TRNG device is controlled by firmware and shared between
> non-secure world and secure world. Access to it is exposed via SMC
> interface which is implemented here. The firmware code does
> additional security checks, start-up test and some checks on resume.
> 
> This device is found, for instance, in Google Tensor GS101-family
> of devices.
> 
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
Hi Alexey Klimov,

Please find few comments inline.

>  drivers/char/hw_random/Kconfig           |  12 +
>  drivers/char/hw_random/Makefile          |   1 +
>  drivers/char/hw_random/exynos-swd-trng.c | 423 +++++++++++++++++++++++
>  3 files changed, 436 insertions(+)
>  create mode 100644 drivers/char/hw_random/exynos-swd-trng.c
> 
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 442c40efb200..bff7c3ec129a 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -479,6 +479,18 @@ config HW_RANDOM_EXYNOS
>  
>  	  If unsure, say Y.
>  
> +config HW_RANDOM_EXYNOS_SWD
> +	tristate "Exynos SWD HW random number generator support"
> +	default n
> +	help
> +	  This driver provides kernel-side support for accessing Samsung
> +	  TRNG hardware located in secure world using smc calls.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called exynos-swd-trng.
> +
> +	  If unsure, say N.
> +
>  config HW_RANDOM_OPTEE
>  	tristate "OP-TEE based Random Number Generator support"
>  	depends on OPTEE
> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> index 32549a1186dc..ce64929d461a 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_HW_RANDOM_N2RNG) += n2-rng.o
>  n2-rng-y := n2-drv.o n2-asm.o
>  obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
>  obj-$(CONFIG_HW_RANDOM_EXYNOS) += exynos-trng.o
> +obj-$(CONFIG_HW_RANDOM_EXYNOS_SWD) += exynos-swd-trng.o
>  obj-$(CONFIG_HW_RANDOM_IXP4XX) += ixp4xx-rng.o
>  obj-$(CONFIG_HW_RANDOM_OMAP) += omap-rng.o
>  obj-$(CONFIG_HW_RANDOM_OMAP3_ROM) += omap3-rom-rng.o
> diff --git a/drivers/char/hw_random/exynos-swd-trng.c b/drivers/char/hw_random/exynos-swd-trng.c
> new file mode 100644
> index 000000000000..29def8e6d0b7
> --- /dev/null
> +++ b/drivers/char/hw_random/exynos-swd-trng.c
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * exynos-swd-trng.c - Random Number Generator driver for the exynos TRNG
> + * located in secure world
> + * Copyright (C) Linaro Ltd 2024 Alexey Klimov <alexey.klimov@linaro.org>
> + *
> + * Based on downstream driver:
> + * Copyright (C) 2018 Samsung Electronics
> + * Sehee Kim <sehi.kim@samsung.com>
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/delay.h>
> +#include <linux/hw_random.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +/* DTRNG smc */
> +#define SMC_CMD_RANDOM			(0x82001012)
> +
> +/* DTRNG smc commands */
> +#define HWRNG_INIT			(0x0)
> +#define HWRNG_EXIT			(0x1)
> +#define HWRNG_GET_DATA			(0x2)
> +#define HWRNG_RESUME			(0x3)
> +
> +#define HWRNG_RET_OK			0
> +#define HWRNG_RET_INVALID_ERROR		1
> +#define HWRNG_RET_RETRY_ERROR		2
> +#define HWRNG_RET_INVALID_FLAG_ERROR	3
> +#define HWRNG_RET_TEST_ERROR		4
> +#define HWRNG_RET_START_UP_TEST_DONE	5
> +#define HWRNG_RET_TEST_KAT_ERROR	0xC
> +
> +#define EXYRNG_START_UP_SIZE		(4096 + 1)
> +#define EXYRNG_RETRY_MAX_COUNT		1000000
> +#define EXYRNG_START_UP_TEST_MAX_RETRY	2
> +
> +#define DRVNAME	"exynos_swd_trng"
> +
> +enum state {
> +	INACTIVE = 0,
> +	ACTIVE,
> +};
> +
> +struct exyswd_rng {
> +	struct hwrng rng;
> +	enum state state;
> +	struct device *dev;
> +	/* to track and protect state of the device */
> +	struct mutex lock;
> +};
> +
> +static int __exynos_cm_smc(u64 *arg0, u64 *arg1,
> +			   u64 *arg2, u64 *arg3)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(*arg0, *arg1, *arg2, *arg3, 0, 0, 0, 0, &res);
> +
> +	*arg0 = res.a0;
> +	*arg1 = res.a1;
> +	*arg2 = res.a2;
> +	*arg3 = res.a3;
> +
> +	return *arg0;
> +}
> +
> +static int exynos_cm_cmd(int cmd)
> +{
> +	u64 reg0, reg1, reg2, reg3;
> +
> +	reg0 = SMC_CMD_RANDOM;
> +	reg1 = cmd;
> +	reg3 = reg2 = 0;
> +
> +	return __exynos_cm_smc(&reg0, &reg1, &reg2, &reg3);
> +}
> +
> +static int exynos_cm_get_data(u64 *arg0, u64 *arg1,
> +			      u64 *arg2, u64 *arg3)
> +{
> +	*arg0 = SMC_CMD_RANDOM;
> +	*arg1 = HWRNG_GET_DATA;
> +	*arg3 = 0;
> +
> +	return __exynos_cm_smc(arg0, arg1, arg2, arg3);
> +}

Can you avoid implementing specific SMC calls in this driver?
Instead, is it possible to use arm_smccc_1_1_invoke passing
corresponding arguements?

> +
> +static int exynos_swd_get_data(u64 *arg0, u64 *arg1, u64 *arg2, u64 *arg3,
> +			       struct exyswd_rng *exyswd_rng)
> +{
> +	u32 retry_cnt = 0;
> +	int ret;
> +
> +	while (retry_cnt++ < EXYRNG_RETRY_MAX_COUNT) {
> +		ret = exynos_cm_get_data(arg0, arg1, arg2, arg3);
> +
> +		if (ret == HWRNG_RET_OK)
> +			return 0;
> +
> +		if (ret == HWRNG_RET_RETRY_ERROR) {
> +			usleep_range(50, 100);
> +			continue;
> +		}
> +
> +		if (ret == HWRNG_RET_TEST_ERROR) {
> +			dev_dbg(exyswd_rng->dev, "error while testing\n");
> +			return -EAGAIN;
> +		}
> +
> +		return -EFAULT;
> +	}
> +
> +	ret = -EFAULT;
> +	dev_warn(exyswd_rng->dev, "retry counter is reached\n");
> +	return ret;
> +}
> +
> +static int exynos_swd_init(void)
> +{
> +	u32 retry_cnt = 0;
> +	int ret;
> +
> +	do {
> +		ret = exynos_cm_cmd(HWRNG_INIT);
> +		if (ret == HWRNG_RET_RETRY_ERROR) {
> +			if (retry_cnt++ > EXYRNG_RETRY_MAX_COUNT)
> +				break;
> +
> +			usleep_range(50, 100);
> +		}
> +	} while (ret == HWRNG_RET_RETRY_ERROR);
> +
> +	return ret;
> +}
> +
> +static void exynos_swd_exit(void)
> +{
> +	u32 retry_cnt = 0;
> +
> +	while (retry_cnt++ < EXYRNG_RETRY_MAX_COUNT) {
> +		if (!exynos_cm_cmd(HWRNG_EXIT))
> +			break;
> +		usleep_range(50, 100);
> +	}
> +}
> +
> +static int exynos_swd_startup_test(struct exyswd_rng *exyswd_rng)
> +{
> +	u64 reg0, reg1, reg2, reg3;
> +	int start_up_size = EXYRNG_START_UP_SIZE;
> +	u32 retry_cnt = 0;
> +	int ret;
> +
> +	ret = exynos_swd_init();
> +	if (ret != HWRNG_RET_OK) {
> +		if (ret == HWRNG_RET_TEST_ERROR) {
> +			ret = -EAGAIN;
> +			goto out;
> +		} else
> +			return -EFAULT;
> +	}
> +
> +	while (start_up_size > 0) {
> +		/* For start-up test the 3-rd argument has to be set to 1 */
> +		reg2 = 1;

Can this be changed to a #define constant for better clarity?

> +		ret = exynos_cm_get_data(&reg0, &reg1, &reg2, &reg3);
> +		if (ret == HWRNG_RET_RETRY_ERROR) {
> +			if (retry_cnt++ > EXYRNG_RETRY_MAX_COUNT) {
> +				dev_warn(exyswd_rng->dev,
> +					 "exceeded retry in start-up test\n");
> +				break;
> +			}
> +			usleep_range(50, 100);
> +			continue;
> +		}
> +
> +		if (ret == HWRNG_RET_TEST_ERROR ||
> +		    ret == HWRNG_RET_TEST_KAT_ERROR) {
> +			dev_err(exyswd_rng->dev,
> +				"malfunction of TRNG(HW) is detected\n");
> +			return -EFAULT;
> +		}
> +
> +		if (ret == HWRNG_RET_START_UP_TEST_DONE) {
> +			dev_dbg(exyswd_rng->dev,
> +				"start-up test is already done\n");
> +			ret = 0;
> +			break;
> +		}
> +
> +		if (ret != HWRNG_RET_OK) {
> +			dev_dbg(exyswd_rng->dev, "failed to get random data\n");
> +			return -EFAULT;
> +		}
> +
> +		start_up_size -= 32;
Similar to the above, please change this. And why 32 bytes?

> +		retry_cnt = 0;
> +	}
> +
> +out:
> +	exynos_swd_exit();
> +	return ret;
> +}
> +
> +static int exynos_swd_read(struct hwrng *rng, void *data, size_t max, bool wait)
> +{
> +	struct exyswd_rng *exyswd_rng =
> +				container_of(rng, struct exyswd_rng, rng);
> +	u64 reg0, reg1, reg2, reg3;
> +	u32 *read_buf = data;
> +	u32 read_size = max;
> +	u32 retry_cnt;
> +	int ret = HWRNG_RET_OK;
> +
> +	mutex_lock(&exyswd_rng->lock);
> +	ret = exynos_swd_init();
> +	if (ret != HWRNG_RET_OK) {
> +		if (ret == HWRNG_RET_TEST_ERROR) {
> +			ret = -EAGAIN;
> +			goto out_locked;
> +		} else {
> +			mutex_unlock(&exyswd_rng->lock);
> +			return -EFAULT;
> +		}
> +	}
> +
> +	exyswd_rng->state = ACTIVE;
> +	mutex_unlock(&exyswd_rng->lock);
> +
> +	retry_cnt = 0;
> +	while (read_size >= 8) {
> +		reg2 = 0;
> +		ret = exynos_swd_get_data(&reg0, &reg1, &reg2, &reg3, exyswd_rng);
> +		if (ret)
> +			goto out;
> +
> +		*(u32 *)(read_buf++) = (u32)reg2;
> +		*(u32 *)(read_buf++) = (u32)reg3;
> +
> +		read_size -= 8;
> +		retry_cnt = 0;
> +	}
> +
> +	/*
> +	 * rng_buf_size is 32 bytes or cache line usually, it is unlikely
> +	 * we will have remaining bytes to read here.
> +	 */
> +	if (unlikely(read_size > 0)) {
> +		reg2 = 0;
> +		ret = exynos_swd_get_data(&reg0, &reg1, &reg2, &reg3, exyswd_rng);
> +		if (ret)
> +			goto out;
> +		if (read_size >= 4) {
> +			*(u32 *)(read_buf++) = (u32)reg2;
> +			read_size -= 4;
> +		}
> +
> +		if (read_size) {
> +			memcpy(read_buf, &reg3, read_size);
> +			read_size = 0;
> +		}
> +	}
> +
> +	ret = max;
> +out:
> +	mutex_lock(&exyswd_rng->lock);
> +out_locked:
> +	exynos_swd_exit();
> +	exyswd_rng->state = INACTIVE;
> +	mutex_unlock(&exyswd_rng->lock);
> +
> +	return ret;
> +}
> +
> +static int exyswd_rng_probe(struct platform_device *pdev)
> +{
> +	struct exyswd_rng *exyswd_rng;
> +	int ret;
> +
> +	exyswd_rng = devm_kzalloc(&pdev->dev, sizeof(*exyswd_rng), GFP_KERNEL);
> +	if (!exyswd_rng)
> +		return -ENOMEM;
> +
> +	exyswd_rng->rng.name = DRVNAME;
> +	exyswd_rng->rng.read = exynos_swd_read;
> +	exyswd_rng->rng.quality = 500;
> +	exyswd_rng->dev = &pdev->dev;
> +	exyswd_rng->state = INACTIVE;
> +	mutex_init(&exyswd_rng->lock);
> +
> +	/*
> +	 * Do the startup test first. If it works we've got the device
> +	 * and can finish probe().
> +	 */
> +	ret = exynos_swd_startup_test(exyswd_rng);
> +	if (ret) {
> +		dev_dbg(&pdev->dev, "start-up test failed\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_hwrng_register(&pdev->dev, &exyswd_rng->rng);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to register hwrng\n");
> +
> +	platform_set_drvdata(pdev, exyswd_rng);
> +	dev_set_drvdata(&pdev->dev, exyswd_rng);
> +
> +	dev_info(&pdev->dev, "hwrng registered\n");
> +
> +	return 0;
> +}
> +
> +static int exyswd_rng_remove(struct platform_device *pdev)
> +{
> +	struct exyswd_rng *exyswd_rng = platform_get_drvdata(pdev);
> +
> +	devm_hwrng_unregister(&pdev->dev, &exyswd_rng->rng);
> +
> +	mutex_lock(&exyswd_rng->lock);
> +	if (exyswd_rng->state == ACTIVE) {
> +		exynos_swd_exit();
> +		exyswd_rng->state = INACTIVE;
> +	}
> +	mutex_unlock(&exyswd_rng->lock);
> +
> +	return 0;
> +}
> +
> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
> +static int exyswd_rng_suspend(struct device *dev)
> +{
> +	struct exyswd_rng *exyswd_rng = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&exyswd_rng->lock);
> +	if (exyswd_rng->state) {
> +		ret = exynos_cm_cmd(HWRNG_EXIT);
> +		if (ret != HWRNG_RET_OK)
> +			dev_warn(dev,
> +				 "failed to enter suspend, error %d\n", ret);
> +	}
> +	mutex_unlock(&exyswd_rng->lock);
> +
> +	return ret;
> +}
> +
> +static int exyswd_rng_resume(struct device *dev)
> +{
> +	struct exyswd_rng *exyswd_rng = dev_get_drvdata(dev);
> +	int ret;
> +
> +	mutex_lock(&exyswd_rng->lock);
> +	ret = exynos_cm_cmd(HWRNG_RESUME);
> +	if (ret != HWRNG_RET_OK)
> +		dev_warn(dev, "failed to resume, error %d\n", ret);
> +	if (exyswd_rng->state) {
> +		ret = exynos_cm_cmd(HWRNG_INIT);
> +		if (ret != HWRNG_RET_OK)
> +			dev_warn(dev,
> +				 "failed to init hwrng on resume, error %d\n",
> +				 ret);
> +	}
> +	mutex_unlock(&exyswd_rng->lock);
> +
> +	return ret;
> +}
> +#endif
> +
> +static UNIVERSAL_DEV_PM_OPS(exyswd_rng_pm_ops, exyswd_rng_suspend,
> +			    exyswd_rng_resume, NULL);
> +
> +static struct platform_driver exyswd_rng_driver = {
> +	.probe		= exyswd_rng_probe,
> +	.remove		= exyswd_rng_remove,
> +	.driver		= {
> +		.name	= DRVNAME,
> +		.owner	= THIS_MODULE,
> +		.pm     = &exyswd_rng_pm_ops,
> +	},
> +};
> +
> +static struct platform_device *exyswd_rng_pdev;
> +
> +static int __init exyswd_rng_init(void)
> +{
> +	int ret;
> +
> +	exyswd_rng_pdev = platform_device_register_simple(DRVNAME, -1, NULL, 0);
> +	if (IS_ERR(exyswd_rng_pdev))
> +		pr_err(DRVNAME ": could not register device: %ld\n",
> +		       PTR_ERR(exyswd_rng_pdev));
> +
> +	ret = platform_driver_register(&exyswd_rng_driver);
> +	if (ret) {
> +		platform_device_unregister(exyswd_rng_pdev);
> +		return ret;
> +	}
> +
> +	pr_info("ExyRNG driver, (c) 2014 Samsung Electronics\n");
> +
> +	return 0;
> +}
> +
> +static void __exit exyswd_rng_exit(void)
> +{
> +	platform_driver_unregister(&exyswd_rng_driver);
> +	platform_device_unregister(exyswd_rng_pdev);
> +}
> +
> +module_init(exyswd_rng_init);
> +module_exit(exyswd_rng_exit);
> +
> +MODULE_DESCRIPTION("Exynos SWD H/W Random Number Generator driver");
> +MODULE_AUTHOR("Alexey Klimov <alexey.klimov@linaro.org>");
> +MODULE_AUTHOR("Sehee Kim <sehi.kim@samsung.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.0
> 

