Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67247BA194
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjJEOmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbjJEOh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07FF4788B;
        Thu,  5 Oct 2023 07:02:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1E1C4167D;
        Thu,  5 Oct 2023 08:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696492995;
        bh=KPcsr8XqpbliBlKBPCcy5Hq2QiFVd1C2DY5JYyEzUlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xqMrGdRZjefjkoDX+uLyUyc4vTxSFrrACPkJoZRaixGShQastWySJ0hAkcvZL6hIw
         +CqrL1aIdDTQHDqaIa57Xpys7Mg2izH/rD1v4A/AbVoDb2byyxBJyTmtFSOx7pPYjt
         KpH7ADhN9TDhDwDKQLQwwpFetiaXsBKph2/HaBCw=
Date:   Thu, 5 Oct 2023 10:03:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v12 3/6] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
Message-ID: <2023100525-deflator-procedure-8d96@gregkh>
References: <20230923143200.268063-1-umang.jain@ideasonboard.com>
 <20230923143200.268063-4-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923143200.268063-4-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 08:01:57PM +0530, Umang Jain wrote:
> The devices that the vchiq interface registers (bcm2835-audio,
> bcm2835-camera) are implemented and exposed by the VC04 firmware.
> The device tree describes the VC04 itself with the resources required
> to communicate with it through a mailbox interface. However, the
> vchiq interface registers these devices as platform devices. This
> also means the specific drivers for these devices are getting
> registered as platform drivers. This is not correct and a blatant
> abuse of platform device/driver.
> 
> Add a new bus type, vchiq_bus_type and device type (struct vchiq_device)
> which will be used to migrate child devices that the vchiq interfaces
> creates/registers from the platform device/driver.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/Makefile        |   1 +
>  .../interface/vchiq_arm/vchiq_bus.c           | 100 ++++++++++++++++++
>  .../interface/vchiq_arm/vchiq_bus.h           |  54 ++++++++++
>  3 files changed, 155 insertions(+)
>  create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
>  create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
> 
> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> index 44794bdf6173..e8b897a7b9a6 100644
> --- a/drivers/staging/vc04_services/Makefile
> +++ b/drivers/staging/vc04_services/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_BCM2835_VCHIQ)	+= vchiq.o
>  vchiq-objs := \
>     interface/vchiq_arm/vchiq_core.o  \
>     interface/vchiq_arm/vchiq_arm.o \
> +   interface/vchiq_arm/vchiq_bus.o \
>     interface/vchiq_arm/vchiq_debugfs.o \
>     interface/vchiq_arm/vchiq_connected.o \
>  
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
> new file mode 100644
> index 000000000000..4ac3491efe45
> --- /dev/null
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * vchiq_device.c - VCHIQ generic device and bus-type
> + *
> + * Copyright (c) 2023 Ideas On Board Oy
> + */
> +
> +#include <linux/device/bus.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of_device.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include "vchiq_bus.h"
> +
> +static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
> +{
> +	if (dev->bus == &vchiq_bus_type &&
> +	    strcmp(dev_name(dev), drv->name) == 0)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int vchiq_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
> +{
> +	const struct vchiq_device *device = container_of_const(dev, struct vchiq_device, dev);
> +
> +	return add_uevent_var(env, "MODALIAS=%s", dev_name(&device->dev));
> +}
> +
> +static int vchiq_bus_probe(struct device *dev)
> +{
> +	struct vchiq_device *device = to_vchiq_device(dev);
> +	struct vchiq_driver *driver = to_vchiq_driver(dev->driver);
> +
> +	return driver->probe(device);
> +}
> +
> +struct bus_type vchiq_bus_type = {
> +	.name   = "vchiq-bus",
> +	.match  = vchiq_bus_type_match,
> +	.uevent = vchiq_bus_uevent,
> +	.probe  = vchiq_bus_probe,
> +};
> +
> +static void vchiq_device_release(struct device *dev)
> +{
> +	struct vchiq_device *device = to_vchiq_device(dev);
> +
> +	kfree(device);
> +}
> +
> +struct vchiq_device *
> +vchiq_device_register(struct device *parent, const char *name)
> +{
> +	struct vchiq_device *device;
> +	int ret;
> +
> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device)
> +		return NULL;
> +
> +	device->dev.init_name = name;
> +	device->dev.parent = parent;
> +	device->dev.bus = &vchiq_bus_type;
> +	device->dev.dma_mask = &device->dev.coherent_dma_mask;
> +	device->dev.release = vchiq_device_release;
> +
> +	of_dma_configure(&device->dev, parent->of_node, true);
> +
> +	ret = device_register(&device->dev);
> +	if (ret) {
> +		dev_err(parent, "Cannot register %s: %d\n", name, ret);
> +		put_device(&device->dev);
> +		kfree(device);

As per the documentation for the device_register() call, this kfree()
will crash.  The call to put_device() is all you need here to free the
memory.

I'll take this series as it's been reviewed and tested, but can you send
a follow-on patch for this?

thanks,

greg k-h
