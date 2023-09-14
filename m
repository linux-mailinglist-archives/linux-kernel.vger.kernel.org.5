Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5012979FE33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbjINIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjINIXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:23:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927311BF9;
        Thu, 14 Sep 2023 01:23:08 -0700 (PDT)
Received: from [192.168.1.110] (unknown [103.86.18.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7FE8710A0;
        Thu, 14 Sep 2023 10:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694679693;
        bh=nZmUcGdGil+IV3hOMk1J09Htu1fHl8OG/jy6x8mr4ak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=urY+/D7wmLF+3Fs7nh3G/UViSGV87AVig0VYbrdvfQULbKAIkIvy9e9Sf2LxTC3rU
         iwhgwTUMwqGEgaJGsVWiyYoCnn9+2EQhboKVAD49m0oORXJEsJQBfDqJPaReJRNkl2
         o5JuXXXQnZUIerpTCvZdFDtk91JS5IRTMm3ejCrQ=
Message-ID: <abfb79a4-cbdd-87d3-630d-d9a7aed5ec2a@ideasonboard.com>
Date:   Thu, 14 Sep 2023 13:52:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v11 2/5] staging: vc04_services: vchiq_arm: Register
 vchiq_bus_type
To:     Stefan Wahren <wahrenst@gmx.net>, linux-staging@lists.linux.dev,
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
 <20230913195354.835884-3-umang.jain@ideasonboard.com>
 <0793697d-08b9-49bf-eef7-2abf33dfa747@gmx.net>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <0793697d-08b9-49bf-eef7-2abf33dfa747@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan

On 9/14/23 2:31 AM, Stefan Wahren wrote:
> Hi Umang,
>
> Am 13.09.23 um 21:53 schrieb Umang Jain:
>> Register the vchiq_bus_type bus with the vchiq interface.
>> The bcm2835-camera and bcm2835_audio will be registered to this bus type
>> going ahead.
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>> ---
>>   .../vc04_services/interface/vchiq_arm/vchiq_arm.c   | 13 ++++++++++++-
>>   .../interface/vchiq_arm/vchiq_device.c              |  7 -------
>>   2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index aa2313f3bcab..d993a91de237 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/cdev.h>
>>   #include <linux/fs.h>
>>   #include <linux/device.h>
>> +#include <linux/device/bus.h>
>>   #include <linux/mm.h>
>>   #include <linux/highmem.h>
>>   #include <linux/pagemap.h>
>> @@ -34,6 +35,7 @@
>>   #include "vchiq_ioctl.h"
>>   #include "vchiq_arm.h"
>>   #include "vchiq_debugfs.h"
>> +#include "vchiq_device.h"
>>   #include "vchiq_connected.h"
>>   #include "vchiq_pagelist.h"
>>
>> @@ -1870,9 +1872,17 @@ static int __init vchiq_driver_init(void)
>>   {
>>       int ret;
>>
>> +    ret = bus_register(&vchiq_bus_type);
>> +    if (ret) {
>> +        pr_err("Failed to register %s\n", vchiq_bus_type.name);
>> +        return ret;
>> +    }
>> +
>>       ret = platform_driver_register(&vchiq_driver);
>> -    if (ret)
>> +    if (ret) {
>>           pr_err("Failed to register vchiq driver\n");
>> +        bus_unregister(&vchiq_bus_type);
>> +    }
>>
>>       return ret;
>>   }
>> @@ -1880,6 +1890,7 @@ module_init(vchiq_driver_init);
>>
>>   static void __exit vchiq_driver_exit(void)
>>   {
>> +    bus_unregister(&vchiq_bus_type);
>>       platform_driver_unregister(&vchiq_driver);
>>   }
>>   module_exit(vchiq_driver_exit);
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> index aad55c461905..b8c46f39e74a 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> @@ -74,13 +74,6 @@ vchiq_device_register(struct device *parent, const 
>> char *name)
>>       device->dev.bus = &vchiq_bus_type;
>>       device->dev.release = vchiq_device_release;
>>
>> -    of_dma_configure(&device->dev, parent->of_node, true);
>> -    ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
>> -    if (ret) {
>> -        dev_err(&device->dev, "32-bit DMA enable failed\n");
>> -        return NULL;
>> -    }
>> -
>
> this code was added in the patch before and now it's removed again.
> Please avoid this.

Ouch, fixup! got incorrectly squashed in this patch, should have been 
squashed in earlier patch, apologies.

>
>>       ret = device_register(&device->dev);
>>       if (ret) {
>>           dev_err(parent, "Cannot register %s: %d\n", name, ret);
>

