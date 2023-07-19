Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30298759B88
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjGSQyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGSQyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:54:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FE11C;
        Wed, 19 Jul 2023 09:54:37 -0700 (PDT)
Received: from [192.168.1.108] (unknown [103.86.18.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D05DD75B;
        Wed, 19 Jul 2023 18:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689785621;
        bh=UKccL+0mn74Yk7K8nhaXq/gmJYkxwNzhHZhaCYh2N6M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SFpDKhvgvCO1QASxbrwDJy4SIO79cBoCcuG/b9qh3W6EUnAcugF4E2RWF4KkKs8xW
         BLjCgg9U8GmZjfKNymblNOBBejL9Nfe4kOp+mT2rcJOMj0/qW/95BhH4ZRZQRWQrKy
         5YFvAHB4HvNKNuIzkckYV64dlJ2hTbgiYTRFyEaY=
Message-ID: <fe8ed301-dda8-9038-a035-c24e84bc2c5c@ideasonboard.com>
Date:   Wed, 19 Jul 2023 22:24:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v9 0/5] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
Content-Language: en-US
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
References: <20230719164427.1383646-1-umang.jain@ideasonboard.com>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20230719164427.1383646-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One comment,

On 7/19/23 10:14 PM, Umang Jain wrote:
> The patch series added a new bus type vchiq_bus_type and registers
> child devices in order to move them away from using platform
> device/driver.
>
> Patch 1/5 and 2/5 adds a new bus_type and registers them to vchiq
> interface
>
> Patch 3/5 and 4/5 moves the bcm2835-camera and bcm2835-audio
> to the new bus respectively
>
> Patch 5/5 removes a platform registeration helper which is no
> longer required.
>
> Changes in v9:
> - Fix module autoloading

While the autoloading of bcm2835-audio, bcm2835-camera is fixed as part 
of this series, there is one WARN coming in when bcm2835-audio is loaded 
regarding dma_alloc_attr

dmesg output: https://paste.debian.net/plain/1286359

I am investigating further...
> - Implement bus_type's probe() callback to load drivers
> - Implement bus_type's uevent() to make sure appropriate drivers are
>    loaded when device are registed from vchiq.
>
> Changes in v8:
> - Drop dual licensing. Instead use GPL-2.0 only for patch 1/5
>
> Changes in v7:
> (5 out of 6 patches from v6 merged)
> - Split the main patch (6/6) as requested.
> - Use struct vchiq_device * instead of struct device * in
>    all bus functions.
> - Drop additional name attribute displayed in sysfs (redundant info)
> - Document vchiq_interface doesn't enumerate device discovery
> - remove EXPORT_SYMBOL_GPL(vchiq_bus_type)
>
> Changes in v6:
> - Split struct device and struct driver wrappers in vchiq_device.[ch]
> - Move vchiq_bus_type definition to vchiq_device.[ch] as well
> - return error on bus_register() failure
> - drop dma_set_mask_and_coherent
> - trivial variable name change
>
> Changes in v5:
> - Fixup missing "staging: " in commits' subject line
> - No code changes from v4
>
> Changes in v4:
> - Introduce patches to drop include directives from Makefile
>
> Changes in v3:
> - Rework entirely to replace platform devices/driver model
>
> -v2:
> https://lore.kernel.org/all/20221222191500.515795-1-umang.jain@ideasonboard.com/
>
> -v1:
> https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/
>
> Umang Jain (5):
>    staging: vc04_services: vchiq_arm: Add new bus type and device type
>    staging: vc04_services: vchiq_arm: Register vchiq_bus_type
>    staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
>    staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
>    staging: vc04_services: vchiq_arm: Remove vchiq_register_child()
>
>   drivers/staging/vc04_services/Makefile        |   1 +
>   .../vc04_services/bcm2835-audio/bcm2835.c     |  20 ++--
>   .../bcm2835-camera/bcm2835-camera.c           |  17 +--
>   .../interface/vchiq_arm/vchiq_arm.c           |  48 ++++-----
>   .../interface/vchiq_arm/vchiq_device.c        | 102 ++++++++++++++++++
>   .../interface/vchiq_arm/vchiq_device.h        |  54 ++++++++++
>   6 files changed, 196 insertions(+), 46 deletions(-)
>   create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>   create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
>

