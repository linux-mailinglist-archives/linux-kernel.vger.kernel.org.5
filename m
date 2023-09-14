Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D2C7A109F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjINWP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:15:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D27F9CCD;
        Thu, 14 Sep 2023 15:15:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 959BA1FB;
        Thu, 14 Sep 2023 15:15:57 -0700 (PDT)
Received: from [10.57.93.68] (unknown [10.57.93.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE2723F738;
        Thu, 14 Sep 2023 15:15:17 -0700 (PDT)
Message-ID: <f4601452-061f-203e-6c05-3e03977eb7f9@arm.com>
Date:   Thu, 14 Sep 2023 23:15:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v11 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
Content-Language: en-GB
To:     Stefan Wahren <wahrenst@gmx.net>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20230913195354.835884-1-umang.jain@ideasonboard.com>
 <20230913195354.835884-2-umang.jain@ideasonboard.com>
 <5e7aff1e-82de-2ec4-4d30-2b1f37ed2eed@gmx.net>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <5e7aff1e-82de-2ec4-4d30-2b1f37ed2eed@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-13 21:58, Stefan Wahren wrote:
> Hi Umang,
> 
> Am 13.09.23 um 21:53 schrieb Umang Jain:
>> The devices that the vchiq interface registers (bcm2835-audio,
>> bcm2835-camera) are implemented and exposed by the VC04 firmware.
>> The device tree describes the VC04 itself with the resources required
>> to communicate with it through a mailbox interface. However, the
>> vchiq interface registers these devices as platform devices. This
>> also means the specific drivers for these devices are getting
>> registered as platform drivers. This is not correct and a blatant
>> abuse of platform device/driver.
>>
>> Add a new bus type, vchiq_bus_type and device type (struct vchiq_device)
>> which will be used to migrate child devices that the vchiq interfaces
>> creates/registers from the platform device/driver.
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   drivers/staging/vc04_services/Makefile        |   1 +
>>   .../interface/vchiq_arm/vchiq_device.c        | 111 ++++++++++++++++++
>>   .../interface/vchiq_arm/vchiq_device.h        |  54 +++++++++
>>   3 files changed, 166 insertions(+)
>>   create mode 100644 
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>>   create mode 100644 
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
>>
>> diff --git a/drivers/staging/vc04_services/Makefile 
>> b/drivers/staging/vc04_services/Makefile
>> index 44794bdf6173..2d071e55e175 100644
>> --- a/drivers/staging/vc04_services/Makefile
>> +++ b/drivers/staging/vc04_services/Makefile
>> @@ -5,6 +5,7 @@ vchiq-objs := \
>>      interface/vchiq_arm/vchiq_core.o  \
>>      interface/vchiq_arm/vchiq_arm.o \
>>      interface/vchiq_arm/vchiq_debugfs.o \
>> +   interface/vchiq_arm/vchiq_device.o \
>>      interface/vchiq_arm/vchiq_connected.o \
>>
>>   ifdef CONFIG_VCHIQ_CDEV
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> new file mode 100644
>> index 000000000000..aad55c461905
>> --- /dev/null
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> @@ -0,0 +1,111 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * vchiq_device.c - VCHIQ generic device and bus-type
>> + *
>> + * Copyright (c) 2023 Ideas On Board Oy
>> + */
>> +
>> +#include <linux/device/bus.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/of_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +
>> +#include "vchiq_device.h"
>> +
>> +static int vchiq_bus_type_match(struct device *dev, struct 
>> device_driver *drv)
>> +{
>> +    if (dev->bus == &vchiq_bus_type &&
>> +        strcmp(dev_name(dev), drv->name) == 0)
>> +        return 1;
>> +
>> +    return 0;
>> +}
>> +
>> +static int vchiq_bus_uevent(const struct device *dev, struct 
>> kobj_uevent_env *env)
>> +{
>> +    const struct vchiq_device *device = container_of_const(dev, 
>> struct vchiq_device, dev);
>> +
>> +    return add_uevent_var(env, "MODALIAS=%s", dev_name(&device->dev));
>> +}
>> +
>> +static int vchiq_bus_probe(struct device *dev)
>> +{
>> +    struct vchiq_device *device = to_vchiq_device(dev);
>> +    struct vchiq_driver *driver = to_vchiq_driver(dev->driver);
>> +    int ret;
>> +
>> +    ret = driver->probe(device);
>> +    if (ret == 0)
>> +        return 0;
>> +
>> +    return ret;
>> +}
>> +
>> +struct bus_type vchiq_bus_type = {
>> +    .name   = "vchiq-bus",
>> +    .match  = vchiq_bus_type_match,
>> +    .uevent = vchiq_bus_uevent,
>> +    .probe  = vchiq_bus_probe,
>> +};
>> +
>> +static void vchiq_device_release(struct device *dev)
>> +{
>> +    struct vchiq_device *device = to_vchiq_device(dev);
>> +
>> +    kfree(device);
>> +}
>> +
>> +struct vchiq_device *
>> +vchiq_device_register(struct device *parent, const char *name)
>> +{
>> +    struct vchiq_device *device;
>> +    int ret;
>> +
>> +    device = kzalloc(sizeof(*device), GFP_KERNEL);
>> +    if (!device) {
>> +        dev_err(parent, "Cannot register %s: Insufficient memory\n",
>> +            name);
> AFAIK kzalloc already logs an error in case of insufficient memory, so
> there is no need for this.
>> +        return NULL;
>> +    }
>> +
>> +    device->dev.init_name = name;
>> +    device->dev.parent = parent;
>> +    device->dev.bus = &vchiq_bus_type;
>> +    device->dev.release = vchiq_device_release;
>> +
>> +    of_dma_configure(&device->dev, parent->of_node, true);
>> +    ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
>  From my understand Robin suggested to drop dma_set_mask_and_coherent()
> here, too. In case this cause a regression until patch 3 & 4 are
> applied. The DMA mask parts should be applied separately before this patch.

Indeed, here we should have "device->dev.dma_mask = 
&device->dev.dma_coherent_mask;", unconditionally, before 
of_dma_configure() is called, and we should *not* be calling 
dma_set_mask_and_coherent() at all. That will then be equivalent to what 
the platform bus code was previously doing for these devices.

The vchiq_device drivers can then call dma_set_mask_and_coherent() if 
they need to (AFAICS I'm not sure if they're actually using DMA at the 
moment?) and should not touch dev->dma_mask directly. That does not need 
to be done in any particular order relative to this patch, since the 
truth is that of_dma_configure() will still initialise the masks to 32 
bits by default anyway (as it currently does for the platform devices), 
however it is still correct to add explicit calls (and handle their 
potential failure if DMA is entirely unusable), and not simply assume 
that the default masks are OK.

Hope that's clear.

Thanks,
Robin.

>> +    if (ret) {
>> +        dev_err(&device->dev, "32-bit DMA enable failed\n");
>> +        return NULL;
>> +    }
>> +
>> +    ret = device_register(&device->dev);
>> +    if (ret) {
>> +        dev_err(parent, "Cannot register %s: %d\n", name, ret);
>> +        put_device(&device->dev);
> Also Robin pointed out that there is a memory leak in the error path,
> because the "device" get lost.
> 
> Thanks Stefan
>> +        return NULL;
>> +    }
>> +
>> +    return device;
>> +}
>> +
>> +void vchiq_device_unregister(struct vchiq_device *vchiq_dev)
>> +{
>> +    device_unregister(&vchiq_dev->dev);
>> +}
>> +
>> +int vchiq_driver_register(struct vchiq_driver *vchiq_drv)
>> +{
>> +    vchiq_drv->driver.bus = &vchiq_bus_type;
>> +
>> +    return driver_register(&vchiq_drv->driver);
>> +}
>> +EXPORT_SYMBOL_GPL(vchiq_driver_register);
>> +
>> +void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv)
>> +{
>> +    driver_unregister(&vchiq_drv->driver);
>> +}
>> +EXPORT_SYMBOL_GPL(vchiq_driver_unregister);
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
>> new file mode 100644
>> index 000000000000..7eaaf9a91cda
>> --- /dev/null
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
>> @@ -0,0 +1,54 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2023 Ideas On Board Oy
>> + */
>> +
>> +#ifndef _VCHIQ_DEVICE_H
>> +#define _VCHIQ_DEVICE_H
>> +
>> +#include <linux/device.h>
>> +
>> +struct vchiq_device {
>> +    struct device dev;
>> +};
>> +
>> +struct vchiq_driver {
>> +    int        (*probe)(struct vchiq_device *device);
>> +    void        (*remove)(struct vchiq_device *device);
>> +    int        (*resume)(struct vchiq_device *device);
>> +    int        (*suspend)(struct vchiq_device *device,
>> +                   pm_message_t state);
>> +    struct device_driver driver;
>> +};
>> +
>> +static inline struct vchiq_device *to_vchiq_device(struct device *d)
>> +{
>> +    return container_of(d, struct vchiq_device, dev);
>> +}
>> +
>> +static inline struct vchiq_driver *to_vchiq_driver(struct 
>> device_driver *d)
>> +{
>> +    return container_of(d, struct vchiq_driver, driver);
>> +}
>> +
>> +extern struct bus_type vchiq_bus_type;
>> +
>> +struct vchiq_device *
>> +vchiq_device_register(struct device *parent, const char *name);
>> +void vchiq_device_unregister(struct vchiq_device *dev);
>> +
>> +int vchiq_driver_register(struct vchiq_driver *vchiq_drv);
>> +void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv);
>> +
>> +/**
>> + * module_vchiq_driver() - Helper macro for registering a vchiq driver
>> + * @__vchiq_driver: vchiq driver struct
>> + *
>> + * Helper macro for vchiq drivers which do not do anything special in
>> + * module init/exit. This eliminates a lot of boilerplate. Each 
>> module may only
>> + * use this macro once, and calling it replaces module_init() and 
>> module_exit()
>> + */
>> +#define module_vchiq_driver(__vchiq_driver) \
>> +    module_driver(__vchiq_driver, vchiq_driver_register, 
>> vchiq_driver_unregister)
>> +
>> +#endif /* _VCHIQ_DEVICE_H */
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
