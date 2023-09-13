Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9627779F209
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjIMT3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjIMT3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:29:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A214D19A0;
        Wed, 13 Sep 2023 12:29:09 -0700 (PDT)
Received: from [192.168.1.110] (unknown [103.86.18.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2B5FB72E;
        Wed, 13 Sep 2023 21:27:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694633255;
        bh=2PEdmZJVlkIWAZzcOdmGLDTCygP7cmTZ3CudbNNyMNU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nWQubWVHMeD45QxffS4RL2R2BLxbLOzXQZoW3tmGE9C0iknhslbVvGmY0UBW1wCxT
         Ckyleni/lqSxJ4xUm6mKc2EPvIR0R07FWiCoOR26Oa1PsRI7L3/R50n07HRH+34C2K
         pHK+IazdsKq2Mu+5tsigKnCOmfNogzhe/vmJMfQg=
Message-ID: <de05bdf5-7fec-6d13-9faa-61c4e54f3dad@ideasonboard.com>
Date:   Thu, 14 Sep 2023 00:59:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v10 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
To:     Robin Murphy <robin.murphy@arm.com>,
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
 <cd242cf0-a7ae-d980-899e-b89e0cb2d1aa@arm.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <cd242cf0-a7ae-d980-899e-b89e0cb2d1aa@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin

On 9/13/23 5:38 PM, Robin Murphy wrote:
> On 2023-09-12 06:50, Umang Jain wrote:
> [...]
>>>> +struct vchiq_device *
>>>> +vchiq_device_register(struct device *parent, const char *name)
>>>> +{
>>>> +    struct vchiq_device *device;
>>>> +    int ret;
>>>> +
>>>> +    device = kzalloc(sizeof(*device), GFP_KERNEL);
>>>> +    if (!device) {
>>>> +        dev_err(parent, "Cannot register %s: Insufficient memory\n",
>>>> +            name);
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    device->dev.init_name = name;
>>>> +    device->dev.parent = parent;
>>>> +    device->dev.bus = &vchiq_bus_type;
>>>> +    device->dev.release = vchiq_device_release;
>>>> +
>>>> +    of_dma_configure(&device->dev, parent->of_node, true);
>>>> +    ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
>>>> +    if (ret) {
>>>> +        dev_err(&device->dev, "32-bit DMA enable failed\n");
>>>> +        return NULL;
>>>> +    }
>>>
>>> Unfortunately the call of of_dma_configure() generates warnings likes
>>> this (Raspberry Pi 3A+ with multi_v7_defconfig + VCHIQ):
>>>
>>> [    9.206802] vchiq-bus bcm2835-audio: DMA mask not set
>>> [    9.206892] vchiq-bus bcm2835-camera: DMA mask not set
>>
>> huh, really weird, as on my RPi-3-b I get these set correctly and I 
>> don't any such warning.
>
> Can you point to the code above where device->dev.dma_mask gets 
> initialised between the initial kzalloc() and the call to 
> of_dma_configure()? ;)
>
> BTW, bus code shouldn't be calling dma_set_mask_and_coherent() on 
> behalf of its children, that is for the individual drivers to do, if 
> and when they intend to actually use DMA. Removing that here will save 
> you needing to fix the memory leak as well...

Thanks for this suggestion. I have now set the dma_mask within the child 
itself!
>
> Thanks,
> Robin.

