Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5661A79C657
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjILFui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjILFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:50:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A41E75;
        Mon, 11 Sep 2023 22:50:32 -0700 (PDT)
Received: from [192.168.1.110] (unknown [103.251.226.41])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F19E9BEB;
        Tue, 12 Sep 2023 07:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694497738;
        bh=a9DyY6o5t7bkr8tkQopXYkiw/TlLaoHCbQzS2foii3s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ghh/qR1kI7n4jKq41uvBT7YILzp7QusiKhLMMuptUmwBC0taDZqxNMAscekBfH3tp
         zWuuK46S6ZXkQE4jZ+NYap/dePplnNvgXw8tNg4GcMG37WbyH6tQ+GNmfMuI7aGp1Y
         S8BfOkrvHgXIY/Xb8TLpZPZ8SfJAatE66Tpioab8=
Message-ID: <d006e31a-33df-51b1-c8cf-9c7e5590adb6@ideasonboard.com>
Date:   Tue, 12 Sep 2023 11:20:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v10 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
To:     Stefan Wahren <wahrenst@gmx.net>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        athierry@redhat.com, error27@gmail.com,
        kieran.bingham@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        dave.stevenson@raspberrypi.com, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <20230911140712.180751-1-umang.jain@ideasonboard.com>
 <20230911140712.180751-2-umang.jain@ideasonboard.com>
 <c96262e7-9bd9-c75d-7584-e6ff62f69530@gmx.net>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <c96262e7-9bd9-c75d-7584-e6ff62f69530@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan

On 9/12/23 1:52 AM, Stefan Wahren wrote:
> Hi Umang,
>
> Am 11.09.23 um 16:07 schrieb Umang Jain:
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
>> +    if (ret) {
>> +        dev_err(&device->dev, "32-bit DMA enable failed\n");
>> +        return NULL;
>> +    }
>
> Unfortunately the call of of_dma_configure() generates warnings likes
> this (Raspberry Pi 3A+ with multi_v7_defconfig + VCHIQ):
>
> [    9.206802] vchiq-bus bcm2835-audio: DMA mask not set
> [    9.206892] vchiq-bus bcm2835-camera: DMA mask not set

huh, really weird, as on my RPi-3-b I get these set correctly and I 
don't any such warning.

I am even checking the ret value here, so if it can't set it, it will 
log an error. I don't that getting logged on my end. Can you share you 
entire dmesg output please?

Also, I have tested this against arm64 kernel, I assume you are using 
32-bit?

>
> In the old platform driver code we had something like
>
>   pdevinfo.dma_mask = DMA_BIT_MASK(32);
>
> So there is still something missing for our new bus driver.

>
>> +
>> +    ret = device_register(&device->dev);
>> +    if (ret) {
>> +        dev_err(parent, "Cannot register %s: %d\n", name, ret);
>> +        put_device(&device->dev);
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

