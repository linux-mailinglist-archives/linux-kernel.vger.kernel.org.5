Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9545779E793
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbjIMMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbjIMMI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:08:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 174FC19A7;
        Wed, 13 Sep 2023 05:08:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08DBD1FB;
        Wed, 13 Sep 2023 05:09:01 -0700 (PDT)
Received: from [10.57.93.239] (unknown [10.57.93.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A10D33F67D;
        Wed, 13 Sep 2023 05:08:21 -0700 (PDT)
Message-ID: <cd242cf0-a7ae-d980-899e-b89e0cb2d1aa@arm.com>
Date:   Wed, 13 Sep 2023 13:08:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v10 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
Content-Language: en-GB
To:     Umang Jain <umang.jain@ideasonboard.com>,
        Stefan Wahren <wahrenst@gmx.net>
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
 <d006e31a-33df-51b1-c8cf-9c7e5590adb6@ideasonboard.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <d006e31a-33df-51b1-c8cf-9c7e5590adb6@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 06:50, Umang Jain wrote:
[...]
>>> +struct vchiq_device *
>>> +vchiq_device_register(struct device *parent, const char *name)
>>> +{
>>> +    struct vchiq_device *device;
>>> +    int ret;
>>> +
>>> +    device = kzalloc(sizeof(*device), GFP_KERNEL);
>>> +    if (!device) {
>>> +        dev_err(parent, "Cannot register %s: Insufficient memory\n",
>>> +            name);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    device->dev.init_name = name;
>>> +    device->dev.parent = parent;
>>> +    device->dev.bus = &vchiq_bus_type;
>>> +    device->dev.release = vchiq_device_release;
>>> +
>>> +    of_dma_configure(&device->dev, parent->of_node, true);
>>> +    ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
>>> +    if (ret) {
>>> +        dev_err(&device->dev, "32-bit DMA enable failed\n");
>>> +        return NULL;
>>> +    }
>>
>> Unfortunately the call of of_dma_configure() generates warnings likes
>> this (Raspberry Pi 3A+ with multi_v7_defconfig + VCHIQ):
>>
>> [    9.206802] vchiq-bus bcm2835-audio: DMA mask not set
>> [    9.206892] vchiq-bus bcm2835-camera: DMA mask not set
> 
> huh, really weird, as on my RPi-3-b I get these set correctly and I 
> don't any such warning.

Can you point to the code above where device->dev.dma_mask gets 
initialised between the initial kzalloc() and the call to 
of_dma_configure()? ;)

BTW, bus code shouldn't be calling dma_set_mask_and_coherent() on behalf 
of its children, that is for the individual drivers to do, if and when 
they intend to actually use DMA. Removing that here will save you 
needing to fix the memory leak as well...

Thanks,
Robin.
