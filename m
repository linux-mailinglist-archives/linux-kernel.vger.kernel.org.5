Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6575ADD5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjGTMIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGTMIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:08:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF911BC6;
        Thu, 20 Jul 2023 05:08:38 -0700 (PDT)
Received: from [192.168.1.108] (unknown [103.86.18.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 83023881;
        Thu, 20 Jul 2023 14:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689854861;
        bh=I7D8HsntABbOPGm+D0eg6gBaHau8vi0Fy8weIblvRiI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C9rcCL//i41y22J1MMM06/Y+nst5kyJEYz1JS+G77t0VdpLGKRY0uPKEo+asf2C2b
         5SYb86rrJfchaHctEjcRqzGGbL/iDDvztPDxzIAoKmQ20u6boYTQdW/58ZWO+rljzS
         rr+ojFuVkiBN431XerImw1kYcWGLoiV57ZvOJ+mA=
Message-ID: <43b2929d-f6be-d382-2802-412b0928dad0@ideasonboard.com>
Date:   Thu, 20 Jul 2023 17:38:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v9 0/5] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
References: <20230719164427.1383646-1-umang.jain@ideasonboard.com>
 <fe8ed301-dda8-9038-a035-c24e84bc2c5c@ideasonboard.com>
 <546b2da6-994a-ebc7-60c1-1d1ff2202f88@i2se.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <546b2da6-994a-ebc7-60c1-1d1ff2202f88@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan ,


On 7/19/23 11:05 PM, Stefan Wahren wrote:
> Hi Umang,
>
> Am 19.07.23 um 18:54 schrieb Umang Jain:
>> Hi,
>>
>> One comment,
>>
>> On 7/19/23 10:14 PM, Umang Jain wrote:
>>> The patch series added a new bus type vchiq_bus_type and registers
>>> child devices in order to move them away from using platform
>>> device/driver.
>>>
>>> Patch 1/5 and 2/5 adds a new bus_type and registers them to vchiq
>>> interface
>>>
>>> Patch 3/5 and 4/5 moves the bcm2835-camera and bcm2835-audio
>>> to the new bus respectively
>>>
>>> Patch 5/5 removes a platform registeration helper which is no
>>> longer required.
>>>
>>> Changes in v9:
>>> - Fix module autoloading
>>
>> While the autoloading of bcm2835-audio, bcm2835-camera is fixed as 
>> part of this series, there is one WARN coming in when bcm2835-audio 
>> is loaded regarding dma_alloc_attr
>>
>> dmesg output: https://paste.debian.net/plain/1286359
>
> is it possible that after your patch series no DMA mask like 
> DMA_BIT_MASK(32) is provided?

I am trying to set DMA_BIT_MASK(32) via  dma_set_mask_and_coherent() but 
it fails with -EIO
>
>>
>> I am investigating further...
>>> - Implement bus_type's probe() callback to load drivers
>>> - Implement bus_type's uevent() to make sure appropriate drivers are
>>>    loaded when device are registed from vchiq.
>>>
>>> Changes in v8:
>>> - Drop dual licensing. Instead use GPL-2.0 only for patch 1/5
>>>
>>> Changes in v7:
>>> (5 out of 6 patches from v6 merged)
>>> - Split the main patch (6/6) as requested.
>>> - Use struct vchiq_device * instead of struct device * in
>>>    all bus functions.
>>> - Drop additional name attribute displayed in sysfs (redundant info)
>>> - Document vchiq_interface doesn't enumerate device discovery
>>> - remove EXPORT_SYMBOL_GPL(vchiq_bus_type)
>>>
>>> Changes in v6:
>>> - Split struct device and struct driver wrappers in vchiq_device.[ch]
>>> - Move vchiq_bus_type definition to vchiq_device.[ch] as well
>>> - return error on bus_register() failure
>>> - drop dma_set_mask_and_coherent
>>> - trivial variable name change
>>>
>>> Changes in v5:
>>> - Fixup missing "staging: " in commits' subject line
>>> - No code changes from v4
>>>
>>> Changes in v4:
>>> - Introduce patches to drop include directives from Makefile
>>>
>>> Changes in v3:
>>> - Rework entirely to replace platform devices/driver model
>>>
>>> -v2:
>>> https://lore.kernel.org/all/20221222191500.515795-1-umang.jain@ideasonboard.com/ 
>>>
>>>
>>> -v1:
>>> https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/ 
>>>
>>>
>>> Umang Jain (5):
>>>    staging: vc04_services: vchiq_arm: Add new bus type and device type
>>>    staging: vc04_services: vchiq_arm: Register vchiq_bus_type
>>>    staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
>>>    staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
>>>    staging: vc04_services: vchiq_arm: Remove vchiq_register_child()
>>>
>>>   drivers/staging/vc04_services/Makefile        |   1 +
>>>   .../vc04_services/bcm2835-audio/bcm2835.c     |  20 ++--
>>>   .../bcm2835-camera/bcm2835-camera.c           |  17 +--
>>>   .../interface/vchiq_arm/vchiq_arm.c           |  48 ++++-----
>>>   .../interface/vchiq_arm/vchiq_device.c        | 102 
>>> ++++++++++++++++++
>>>   .../interface/vchiq_arm/vchiq_device.h        |  54 ++++++++++
>>>   6 files changed, 196 insertions(+), 46 deletions(-)
>>>   create mode 100644 
>>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>>>   create mode 100644 
>>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
>>>
>>

