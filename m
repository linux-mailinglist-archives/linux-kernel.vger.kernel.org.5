Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844847E5D49
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjKHSdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjKHSdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:33:23 -0500
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 199FC2111;
        Wed,  8 Nov 2023 10:33:20 -0800 (PST)
Received: from [192.168.4.14] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id BDE265F259;
        Wed,  8 Nov 2023 19:33:15 +0100 (CET)
Message-ID: <49c002db-fb3e-4e2c-adb4-0be05d4b27e6@gpxsee.org>
Date:   Wed, 8 Nov 2023 19:33:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: pci: mgb4: remove bogus 'select' statements
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Martin Tuma <martin.tuma@digiteqautomotive.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231023160539.1537355-1-arnd@kernel.org>
 <20231023160539.1537355-2-arnd@kernel.org>
 <25173a48-529c-463b-88aa-2ee75dd604ff@gpxsee.org>
 <75a110d5-c544-44b3-8155-ddfadbe1bd88@app.fastmail.com>
From:   =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
In-Reply-To: <75a110d5-c544-44b3-8155-ddfadbe1bd88@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 11. 23 17:13, Arnd Bergmann wrote:
> On Fri, Oct 27, 2023, at 16:17, Martin Tůma wrote:
>>
>> On 23. 10. 23 18:05, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> As this is just a regular device driver, it has no business force-enabling
>>> other drivers in the system, it should be entirely independent of the
>>> implementation of the spi-nor layer or the specific DMA engine.
>>>
>>
>> The drivers are required for IP cores that are used on the card (in the
>> FPGA). Without I2C_XILINX and XILINX_XDMA the card won't work at all.
>> Without SPI_XILINX the access to the card's FLASH (used e.g. for FW
>> changes) won't be possible.
>>
>> A change to "depend" instead of "select" is thus possible if it makes
>> more sense to you, but removing it would make the module not compile or
>> not work at runtime (there is no symbol dependency to I2C_XILINX and
>> SPI_XILINX, but both need to be present and are loaded using
>> request_module() at runtime).
> 
> Sorry for the delay at getting back to you here.
> 
> I don't think there is a good answer here, though I normally
> try to only list the minimal dependencies that are required
> at build time. E.g. for on-chip devices we don't require the
> use of a particular clock/irq/pin/gpio/... controller even if
> we know exactly which of those are used on a given chip.
> 

On SoCs you probably get a kernel configuration that is missing some 
feature but still boots up when you do not select/depend on the exact 
controller, but in the case of the mgb4 PCIe card you get a driver that 
does not work at all (The SPI_XILINX dependency could theoretically be 
made configurable, but you would lose the ability to flash the correct 
FW for the current HW module and the access to the card's serial number. 
I2C and XDMA are crucial.).

> Since this is a PCI device, it's a bit different, so maybe
> something like this would work to correctly document which
> dependencies are required at build time vs run time:
> 
> --- a/drivers/media/pci/mgb4/Kconfig
> +++ b/drivers/media/pci/mgb4/Kconfig
> @@ -1,15 +1,13 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config VIDEO_MGB4
>          tristate "Digiteq Automotive MGB4 support"
> -       depends on VIDEO_DEV && PCI && I2C && DMADEVICES && SPI && MTD && IIO
> +       depends on VIDEO_DEV && PCI && I2C && SPI && MTD && IIO
>          depends on COMMON_CLK
> +       depends on XILINX_XDMA
> +       depends on (I2C_XILINX && SPI_XILINX) || COMPILE_TEST
>          select VIDEOBUF2_DMA_SG
>          select IIO_BUFFER
>          select IIO_TRIGGERED_BUFFER
> -       select I2C_XILINX
> -       select SPI_XILINX
> -       select MTD_SPI_NOR
> -       select XILINX_XDMA
>          help
>            This is a video4linux driver for Digiteq Automotive MGB4 grabber
>            cards.
> 

My motivation when using "select" was to help people using "make 
menuconfig" to get the module selected/configured as they will usually 
not know that there are some Xilinx IP cores used that need separate 
drivers and the menuconfig GUI simply hides the mgb4 option making it 
almost impossible just from the menus to find out what has to be selected.

But when there are reasons, why to chose "depends on" (like various 
configurations, tests or the "readability" of the dependencies) than I'm 
ok with your patch proposal.

M.

>       Arnd

