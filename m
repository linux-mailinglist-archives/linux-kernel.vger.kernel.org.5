Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFAA7E641E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjKIHCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjKIHBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:01:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE772D4F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:01:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEDEC433C7;
        Thu,  9 Nov 2023 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699513304;
        bh=fgsI0uIO0jsMKqixNyhIaq5C4GRbyVIPgpkk7rwVEH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1C4aYfP7MYwyuFbY+Ig9qP6ambiE59+6AFXzomNTq+b1B0DdLKTHmGvQDzD/vTvrO
         THs7yY8857U9YFfobhbhJyVpt23cSGDvv3CthWv0qiu1Bi8wsxbLn9txmu7tuR13N9
         tW5ZJP07S8L6d/o0aU9c8l8UVDV2gHwz2UQt/qIs=
Date:   Thu, 9 Nov 2023 08:01:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     quic_zhezhu@quicinc.com
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] msm: misc: enable QRC support on msm-5.4 on RB3-Gen2
Message-ID: <2023110900-rewire-sister-61a3@gregkh>
References: <20231109-qrc-v1-1-8f0c538fc74d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-qrc-v1-1-8f0c538fc74d@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 02:39:32PM +0800, zhengjia zhu via B4 Relay wrote:
> From: zhengjia zhu <quic_zhezhu@quicinc.com>
> 
> QRC Driver support functions:
> - Read data from serial device port.
> - Write data to serial device port.
> - Pin control reset robotic controller.
> 
> Signed-off-by: zhengjia zhu <quic_zhezhu@quicinc.com>
> ---
>  drivers/misc/qrc/Kconfig    |  25 ++++
>  drivers/misc/qrc/Makefile   |   9 ++
>  drivers/misc/qrc/qrc_core.c | 312 +++++++++++++++++++++++++++++++++++++++
>  drivers/misc/qrc/qrc_core.h | 142 ++++++++++++++++++
>  drivers/misc/qrc/qrc_uart.c | 352 ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 840 insertions(+)
> 
> diff --git a/drivers/misc/qrc/Kconfig b/drivers/misc/qrc/Kconfig
> new file mode 100644
> index 000000000000..59f734c02092
> --- /dev/null
> +++ b/drivers/misc/qrc/Kconfig
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# QRC device driver configuration
> +#
> +
> +menu "qrc device driver"
> +
> +config QRC
> +	bool "QRC device driver for Robotic SDK MCU"

Why is this not able to be built as a module?

> +	help
> +	   This kernel configuration is used to enable robotic controller
> +	   device driver. Say Y here if you want to enable robotic
> +	   controller device driver.
> +	   When in doubt, say N.

What is the module name?

> +
> +config QRC_DEBUG
> +	bool "QRC Debugging"
> +	depends on QRC
> +	help
> +	  Say Y here if you want the robotic controller to produce
> +	  a bunch of debug messages to the system log. Select this if you
> +	  are having a problem with robotic controller support and want
> +	  to see more of what is going on.
> +	  When in doubt, say N.

No, please use the built-in kernel debugging functionality, which is NOT
a separate configuration option.  Nothing would work if we had this on a
per-driver level that had to be set at build time.  Use the normal
dynamic debugging logic and all will be fine.

> +endmenu
> diff --git a/drivers/misc/qrc/Makefile b/drivers/misc/qrc/Makefile
> new file mode 100644
> index 000000000000..d811992aa0d9
> --- /dev/null
> +++ b/drivers/misc/qrc/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the QRC bus specific drivers.
> +
> +
> +obj-$(CONFIG_QRC)		+=  qrc_core.o qrc_uart.o
> +
> +
> +#ccflags-$(CONFIG_QRC_DEBUG) := -DDEBUG
> diff --git a/drivers/misc/qrc/qrc_core.c b/drivers/misc/qrc/qrc_core.c
> new file mode 100644
> index 000000000000..9d03f35e9683
> --- /dev/null
> +++ b/drivers/misc/qrc/qrc_core.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* driver/misc/qrc/qrc_core.c
> + *
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/sched.h>
> +#include <linux/init.h>
> +#include <linux/cdev.h>
> +#include <linux/slab.h>
> +#include <linux/poll.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +
> +#include "qrc_core.h"
> +
> +#define FIFO_CLEAR 0x1
> +
> +#define QRC_DEVICE_NAME "qrc"
> +
> +static dev_t qrc_devt;
> +static struct class *qrc_class;
> +
> +static int qrc_cdev_fasync(int fd, struct file *filp, int mode)
> +{
> +	struct qrc_dev *qrc;
> +
> +	qrc = filp->private_data;
> +	return fasync_helper(fd, filp, mode, &qrc->async_queue);
> +}
> +
> +static int qrc_cdev_open(struct inode *inode, struct file *filp)
> +{
> +	struct qrc_dev *qrc;
> +
> +	qrc = container_of(inode->i_cdev,
> +						struct qrc_dev, cdev);

Very odd formatting, where did this come from?

Have you run checkpatch.pl on your patch?

> +	filp->private_data = qrc;
> +	if (qrc->qrc_ops != NULL)
> +		qrc->qrc_ops->qrcops_open(qrc);
> +	return 0;
> +}
> +
> +static int qrc_cdev_release(struct inode *inode, struct file *filp)
> +{
> +	struct qrc_dev *qrc;
> +
> +	qrc = filp->private_data;
> +	if (qrc->qrc_ops != NULL)
> +		qrc->qrc_ops->qrcops_close(qrc);
> +
> +	return 0;
> +}
> +
> +/* GPIO control  */
> +static int
> +qrc_control_gpio_init(struct qrc_dev *qdev, struct device_node *node)
> +{
> +	int ret;
> +
> +	/* QRC BOOT0 GPIO */
> +	qdev->qrc_boot0_gpio = of_get_named_gpio(node,
> +	"qcom,qrc-boot-gpio", 0);

Again, odd formatting.

> +	if (qdev->qrc_boot0_gpio < 0)
> +		pr_err("qrc_boot0_gpio is not available\n");

You are a driver, you should always use dev_err() and friends, never
pr_err().

> +
> +	/* UART RESET GPIO */
> +	qdev->qrc_reset_gpio = of_get_named_gpio(node,
> +	"qcom,qrc-reset-gpio", 0);
> +	if (qdev->qrc_reset_gpio < 0)
> +		pr_err("qrc_reset_gpio is not available\n");
> +
> +	if (gpio_is_valid(qdev->qrc_boot0_gpio)) {
> +		ret = gpio_request(qdev->qrc_boot0_gpio, "QRC_BOOT0_GPIO");
> +		if (unlikely(ret)) {

Unless you can measure it in a benchmark, never use likely/unlikely as
the compiler and cpu will do it better without it.

I've stopped reviewing here, please take some time to fix up the driver
based on this and resubmit.

thanks,

greg k-h
