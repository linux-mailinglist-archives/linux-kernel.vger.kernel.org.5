Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D36810DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjLMJxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjLMJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:53:38 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F3683
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:53:43 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b86f3cdca0so5092822b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702461222; x=1703066022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzmtfdvh8MoZlQ5iBqvO3AB68PsHcRVFzEzdstl9GkM=;
        b=lcHmABj6u5A/xmal7LzJCsaRs5rP3sqC8JOq9/Pw7plxZxd3fuYfP1yma5FBuxCDWp
         I+ympW5wI51wAAmTKAEduKAzK3cI/7sMkEsDGpHhgbRdMjYpTJNR1iW6Sn9Nhphu3Llh
         x5aQ7z7T5VVZGJARa2ZB5XfHPORJCa9pCDZA0HtM83z9TSbNeeQzimUYb5bHE6Pi2VVm
         yQ2uN1nOXi2uC2souEqVX0G39OFjGHxNlWSCGl9tK+9CM+XXuU87K78r4P8LU0ugs+sv
         Q61uDG5XYtruGO5PPuRBz+nLksg9++Dk4m6EnDOLPhDY9eRC+MkOh0Oa6fHWvA+asUiM
         fUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461222; x=1703066022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzmtfdvh8MoZlQ5iBqvO3AB68PsHcRVFzEzdstl9GkM=;
        b=jKM3RscTvR1IYa5okV6p3uTpLoctYPswW8ATd6wUECnUaHKVH8JqVOMr7AyZnl1v44
         Qv6+D+5Jjab4NnA4KAKAyp3sO86uFxRBQFUspD/nu9/ydlwLxayKwEyQhYRl+upu6rYg
         t+cb6z3tdKOMqS5DYWpL6ekCO7v4vEHBHVCCWno4TiPdOuK1f/WMtf55u0D9DZf/iXOm
         hJLN84Xz/WX0kpdHVgquP2E6bo11NN2+uxqJ68EVSIFXAoPSdMvDOBcg2TC+im46S6XQ
         TK92/Jo7DAMDyu5fy/W8xe/soI6Drf5vGwdbYgDVOEKIJubaHyIBgrVXpvAb2OQcVcBc
         fKlg==
X-Gm-Message-State: AOJu0Yw1CVUKqTd0oGZEyCaVDIPuH+PIgKHqfnbc2PLiH1DmhsByCHa4
        YPiZX9/nC8ZjU6QMKDvwpglOLQ==
X-Google-Smtp-Source: AGHT+IGmaafpc6Lp/1dId0bJ7+Egl3h6i7Z2OrZdU0SZ7n4VH5SmWCyoNukSRuvrWrxoYSu1PDUm5Q==
X-Received: by 2002:a05:6808:3991:b0:3b9:fd0a:247f with SMTP id gq17-20020a056808399100b003b9fd0a247fmr10824848oib.90.1702461222422;
        Wed, 13 Dec 2023 01:53:42 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id kb1-20020a17090ae7c100b00286e9bec1efsm11935666pjb.33.2023.12.13.01.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:53:41 -0800 (PST)
Date:   Wed, 13 Dec 2023 15:23:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Harald Mommer <Harald.Mommer@opensynergy.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com,
        quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [virtio-dev] [RFC PATCH v1 3/3] SPI: Add virtio SPI driver (V4
 draft specification).
Message-ID: <20231213095339.rurjk6mxjeap7tye@vireshk-i7>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-4-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027161016.26625-4-Harald.Mommer@opensynergy.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harald,

On 27-10-23, 18:10, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> This is the first public version of the virtio SPI Linux kernel driver
> compliant to the "PATCH v4" draft virtio SPI specification.
> 
> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> ---
>  drivers/spi/Kconfig      |  10 +
>  drivers/spi/Makefile     |   1 +
>  drivers/spi/spi-virtio.c | 513 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 524 insertions(+)
>  create mode 100644 drivers/spi/spi-virtio.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 35dbfacecf1c..55f45c5a8d82 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1125,6 +1125,16 @@ config SPI_UNIPHIER
>  
>  	  If your SoC supports SCSSI, say Y here.
>  
> +config SPI_VIRTIO
> +	tristate "Virtio SPI SPI Controller"
> +	depends on VIRTIO
> +	help
> +	  This enables the Virtio SPI driver.
> +
> +	  Virtio SPI is an SPI driver for virtual machines using Virtio.
> +
> +	  If your Linux is a virtual machine using Virtio, say Y here.
> +
>  config SPI_XCOMM
>  	tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
>  	depends on I2C
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 4ff8d725ba5e..ff2243e44e00 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -146,6 +146,7 @@ spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
>  obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
>  obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
>  obj-$(CONFIG_SPI_UNIPHIER)		+= spi-uniphier.o
> +obj-$(CONFIG_SPI_VIRTIO)		+= spi-virtio.o
>  obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
>  obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
>  obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
> diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
> new file mode 100644
> index 000000000000..12a4d96555f1
> --- /dev/null
> +++ b/drivers/spi/spi-virtio.c
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SPI bus driver for the Virtio SPI controller
> + * Copyright (C) 2023 OpenSynergy GmbH
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/stddef.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/version.h>
> +#include <linux/spi/spi.h>
> +#include <linux/virtio_spi.h>
> +
> +/* SPI device queues */
> +#define VIRTIO_SPI_QUEUE_RQ 0
> +#define VIRTIO_SPI_QUEUE_COUNT 1
> +
> +/* virtio_spi private data structure */
> +struct virtio_spi_priv {
> +	/* The virtio device we're associated with */
> +	struct virtio_device *vdev;
> +	/* The virtqueues */
> +	struct virtqueue *vqs[VIRTIO_SPI_QUEUE_COUNT];

There is no need to make this configurable since the specification
fixes it to 1. You can simplify this a bit.

> +	/* I/O callback function pointers for the virtqueues */
> +	vq_callback_t *io_callbacks[VIRTIO_SPI_QUEUE_COUNT];
> +	/* Support certain delay timing settings */
> +	bool support_delays;
> +};
> +
> +/* Compare with file i2c_virtio.c structure virtio_i2c_req */
> +struct virtio_spi_req {
> +	struct completion completion;
> +#ifdef DEBUG
> +	unsigned int rx_len;
> +#endif
> +	// clang-format off
> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
> +	const uint8_t *tx_buf			____cacheline_aligned;
> +	uint8_t *rx_buf				____cacheline_aligned;
> +	struct spi_transfer_result result	____cacheline_aligned;
> +	// clang-format on
> +};
> +
> +static struct spi_board_info board_info = {
> +	.modalias = "spi-virtio",
> +	.max_speed_hz = 125000000, /* Arbitrary very high limit */
> +	.bus_num = 0, /* Patched later during initialization */
> +	.chip_select = 0, /* Patched later during initialization */
> +	.mode = SPI_MODE_0,
> +};
> +
> +/* Compare with file i2c_virtio.c structure virtio_i2c_msg_done */
> +static void virtio_spi_msg_done(struct virtqueue *vq)
> +{
> +	struct virtio_spi_req *req;
> +	unsigned int len;
> +
> +	while ((req = virtqueue_get_buf(vq, &len)))
> +		complete(&req->completion);
> +}
> +

> +static int virtio_spi_transfer_one_message(struct spi_master *master,
> +					   struct spi_message *msg)
> +{
> +	struct virtio_spi_priv *priv = spi_master_get_devdata(master);
> +	struct virtqueue *vq = priv->vqs[VIRTIO_SPI_QUEUE_RQ];
> +	struct virtio_spi_req *spi_req;
> +	struct spi_transfer *xfer;
> +	int ret = 0;
> +
> +	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
> +	if (!spi_req) {
> +		ret = -ENOMEM;
> +		goto no_mem;
> +	}
> +
> +	/*
> +	 * Simple implementation: Process message by message and wait for each
> +	 * message to be completed by the device side.
> +	 */

And why not send all the messages once and speed this thing up ? Just
like how I2C does it.

> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		ret = virtio_spi_one_transfer(spi_req, master, msg, xfer);
> +		if (ret)
> +			goto msg_done;
> +
> +		virtqueue_kick(vq);
> +
> +		wait_for_completion(&spi_req->completion);
> +
> +		/* Read result from message */
> +		ret = (int)spi_req->result.result;
> +		if (ret)
> +			goto msg_done;
> +
> +#ifdef DEBUG

Drop all temporary things please.

> +		if (spi_req->rx_buf) {
> +			pr_debug("Dump of RX payload\n");
> +			print_hex_dump(KERN_DEBUG, KBUILD_MODNAME " ",
> +				       DUMP_PREFIX_NONE, 16, 1, spi_req->rx_buf,
> +				       spi_req->rx_len, true);
> +		}
> +#endif
> +	}
> +
> +msg_done:
> +	kfree(spi_req);
> +no_mem:
> +	msg->status = ret;
> +	/*
> +	 * Looking into other SPI drivers like spi-atmel.c the function
> +	 * spi_finalize_current_message() is supposed to be called only once
> +	 * for all transfers in the list and not for each single message
> +	 */
> +	spi_finalize_current_message(master);
> +	dev_dbg(&priv->vdev->dev, "%s() returning %d\n", __func__, ret);
> +	return ret;
> +}
> +
> +static void virtio_spi_read_config(struct virtio_device *vdev)
> +{
> +	struct spi_master *master = dev_get_drvdata(&vdev->dev);
> +	struct virtio_spi_priv *priv = vdev->priv;
> +	u16 bus_num;
> +	u16 cs_max_number;
> +	u8 support_delays;
> +
> +	bus_num = virtio_cread16(vdev,
> +				 offsetof(struct virtio_spi_config, bus_num));
> +	cs_max_number = virtio_cread16(vdev, offsetof(struct virtio_spi_config,
> +						      chip_select_max_number));
> +	support_delays =
> +		virtio_cread16(vdev, offsetof(struct virtio_spi_config,
> +					      cs_timing_setting_enable));

Instead of reading values separately, you can also read the entire
configuration structure in a single call to virtio_cread_bytes.

Won't you also need to convert all the values using le16_to_cpu() ? I
have done it that way for drivers/gpio/gpio-virtio.c driver, just in
case it helps.

> +
> +	if (bus_num > S16_MAX) {
> +		dev_warn(&vdev->dev, "Limiting bus_num = %u to %d\n", bus_num,
> +			 S16_MAX);
> +		bus_num = S16_MAX;
> +	}
> +
> +	if (support_delays > 1)
> +		dev_warn(&vdev->dev, "cs_timing_setting_enable = %u\n",
> +			 support_delays);

Why is this a warning ? And not just debug or info ?

> +	priv->support_delays = (support_delays != 0);
> +	master->bus_num = (s16)bus_num;
> +	master->num_chipselect = cs_max_number;
> +}
> +
> +static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
> +{
> +	static const char *const io_names[VIRTIO_SPI_QUEUE_COUNT] = { "spi-rq" };
> +
> +	priv->io_callbacks[VIRTIO_SPI_QUEUE_RQ] = virtio_spi_msg_done;
> +
> +	/* Find the queues. */
> +	return virtio_find_vqs(priv->vdev, VIRTIO_SPI_QUEUE_COUNT, priv->vqs,
> +			       priv->io_callbacks, io_names, NULL);

Since the vq count is fixed by spec to 1, I think you can directly use
virtio_find_single_vq() and simplify this a bit.

> +}
> +
> +/* Compare with i2c-virtio.c function virtio_i2c_del_vqs() */
> +/* Function must not be called before virtio_spi_find_vqs() has been run */
> +static void virtio_spi_del_vq(struct virtio_device *vdev)
> +{
> +	vdev->config->reset(vdev);

virtio_reset_device(vdev)

> +	vdev->config->del_vqs(vdev);
> +}
> +
> +static int virtio_spi_validate(struct virtio_device *vdev)
> +{
> +	/*
> +	 * SPI needs always access to the config space.
> +	 * Check that the driver can access the config space
> +	 */
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +		dev_err(&vdev->dev,
> +			"device does not comply with spec version 1.x\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int virtio_spi_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_spi_priv *priv;
> +	struct spi_master *master;
> +	int err;
> +	u16 csi;
> +
> +	err = -ENOMEM;

Why not do it with the definition itself ?

> +	master = spi_alloc_master(&vdev->dev, sizeof(struct virtio_spi_priv));

sizeof(*priv)

and there is a devm_* variant too that you can use.

> +	if (!master) {
> +		dev_err(&vdev->dev, "Kernel memory exhausted in %s()\n",
> +			__func__);

I think we removed print messages for allocation failure earlier, as
the alloc core handles it now. This may not be required.

> +		goto err_return;

We don't need to free any resources, maybe just return directly
without an unnecessary goto here. Yes it is normally cleaner to remove
all the resources at the bottom with a single return point, but we
normally return earlier if the resources were not required to be
freed.

> +	}
> +
> +	priv = spi_master_get_devdata(master);
> +	priv->vdev = vdev;
> +	vdev->priv = priv;
> +	dev_set_drvdata(&vdev->dev, master);
> +
> +	/* the spi->mode bits understood by this driver: */
> +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
> +			    SPI_LOOP | SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL |
> +			    SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL;
> +
> +	/* What most support. We don't know from the virtio device side */
> +	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);

> +	/* There is no associated device tree node */
> +	master->dev.of_node = NULL;

No need to unset a field which is already NULL.

> +	/* Get bus_num and num_chipselect from the config space */
> +	virtio_spi_read_config(vdev);

Why call it in the middle of all the initialization. Can we do it
before virtio_spi_find_vqs() ?

> +	/* Maybe this method is not needed for virtio SPI */
> +	master->setup = NULL; /* Function not needed for virtio-spi */
> +	/* No restrictions to announce */
> +	master->flags = 0;
> +	/* Method to transfer a single SPI message */
> +	master->transfer_one_message = virtio_spi_transfer_one_message;
> +	/* Method to cleanup the driver */

Some of the comments are not useful at all. The fields are self
explanatory and don't need a comment, unless there is a reason for
initializing it in a certain way that you want to mention.

> +	master->cleanup = NULL; /* Function not needed for virtio-spi */
> +
> +	/* Initialize virtqueues */
> +	err = virtio_spi_find_vqs(priv);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
> +		goto err_master_put;
> +	}
> +
> +	err = spi_register_master(master);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot register master\n");
> +		goto err_master_put;
> +	}
> +
> +	/* spi_new_device() currently does not use bus_num but better set it */
> +	board_info.bus_num = (u16)master->bus_num;

I am not sure if you need explicit casting here and while converting
from u16 to s16.

> +
> +	/* Add chip selects to master device */
> +	for (csi = 0; csi < master->num_chipselect; csi++) {
> +		dev_info(&vdev->dev, "Setting up CS=%u\n", csi);

Should be a debug message ?

> +		board_info.chip_select = csi;
> +		if (!spi_new_device(master, &board_info)) {
> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
> +			goto err_unregister_master;

What about freeing already added devices (before we failed) ? Is that
done by the core automatically ?

> +		}
> +	}
> +
> +	/* Request device going live */
> +	virtio_device_ready(vdev); /* Optionally done by virtio_dev_probe() */

Normally a driver shouldn't be calling it unless the probe function
uses the virtio device, like it is done in GPIO. Since it works for
you just fine, you can simply remove this.

> +
> +	dev_info(&vdev->dev, "Device live!\n");

Debug message ?

> +
> +	return 0;
> +
> +err_unregister_master:
> +	spi_unregister_master(master);
> +err_master_put:
> +	spi_master_put(master);
> +err_return:
> +	return err;
> +}
> +
> +static void virtio_spi_remove(struct virtio_device *vdev)
> +{
> +	struct spi_master *master = dev_get_drvdata(&vdev->dev);
> +
> +	virtio_spi_del_vq(vdev);
> +	spi_unregister_master(master);

The ordering should be just the opposite. Free the users first and
then the resource.

> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +/*
> + * Compare with i2c-virtio.c function virtio_i2c_freeze()
> + * and with spi-atmel.c function atmel_spi_suspend()
> + */
> +static int virtio_spi_freeze(struct virtio_device *vdev)
> +{
> +	struct device *dev = &vdev->dev;
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Stop the queue running */
> +	ret = spi_master_suspend(master);
> +	if (ret) {
> +		dev_warn(dev, "cannot suspend master (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	virtio_spi_del_vq(vdev);
> +	return 0;
> +}
> +
> +/*
> + * Compare with i2c-virtio.c function virtio_i2c_restore()
> + * and with spi-atmel.c function atmel_spi_resume()
> + */
> +static int virtio_spi_restore(struct virtio_device *vdev)
> +{
> +	struct device *dev = &vdev->dev;
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Start the queue running */
> +	ret = spi_master_resume(master);
> +	if (ret)
> +		dev_err(dev, "problem starting queue (%d)\n", ret);
> +
> +	return virtio_spi_find_vqs(vdev->priv);

You need to setup the queues first and then resume the master.

> +}
> +#endif
> +
> +static struct virtio_device_id virtio_spi_id_table[] = {
> +	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
> +	{ 0 },

The 0 value here is optional. This can be just {}.

> +};
> +
> +static struct virtio_driver virtio_spi_driver = {
> +	.feature_table = NULL,
> +	.feature_table_size = 0u,

You can skip defining them and they should be initialized to NULL/0
anyway.

> +	.driver.name = KBUILD_MODNAME,
> +	.driver.owner = THIS_MODULE,

Or:
	.driver = {
		.name	= KBUILD_MODNAME,
		.owner  = THIS_MODULE,
	},

> +	.id_table = virtio_spi_id_table,
> +	.validate = virtio_spi_validate,
> +	.probe = virtio_spi_probe,
> +	.remove = virtio_spi_remove,
> +	.config_changed = NULL,

Here too.

> +#ifdef CONFIG_PM_SLEEP
> +	.freeze = virtio_spi_freeze,
> +	.restore = virtio_spi_restore,
> +#endif

This is how we define them now a days.

b221df9c4e09 i2c: virtio: Remove #ifdef guards for PM related functions

> +};
> +
> +module_virtio_driver(virtio_spi_driver);

> +MODULE_DEVICE_TABLE(virtio, virtio_spi_id_table);

Maybe add right below the table without any blank line in between.

> +
> +MODULE_AUTHOR("OpenSynergy GmbH");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("SPI bus driver for Virtio SPI");

Maybe just: "Virtio SPI bus driver"

> -- 
> 2.25.1
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

-- 
viresh
