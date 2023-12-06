Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE9806A8A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjLFJSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFJSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:18:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE33A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:18:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB55C433C8;
        Wed,  6 Dec 2023 09:18:42 +0000 (UTC)
Message-ID: <959f7620-c489-4864-8e2a-3d4cb1125d16@xs4all.nl>
Date:   Wed, 6 Dec 2023 10:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: pci: mgb4: remove bogus 'select' statements
Content-Language: en-US, nl
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Martin Tuma <martin.tuma@digiteqautomotive.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231023160539.1537355-1-arnd@kernel.org>
 <20231023160539.1537355-2-arnd@kernel.org>
 <25173a48-529c-463b-88aa-2ee75dd604ff@gpxsee.org>
 <75a110d5-c544-44b3-8155-ddfadbe1bd88@app.fastmail.com>
 <49c002db-fb3e-4e2c-adb4-0be05d4b27e6@gpxsee.org>
 <2c56410f-2762-4b3c-b37e-e8db75d30560@app.fastmail.com>
 <f61f90cd-55e2-420e-be16-6b0fbd492bbd@xs4all.nl>
In-Reply-To: <f61f90cd-55e2-420e-be16-6b0fbd492bbd@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,

Can you post a v2 for this?

Note that patch 1/1 is in v6.7 already.

Regards,

	Hans

On 13/11/2023 15:57, Hans Verkuil wrote:
> On 10/11/2023 15:37, Arnd Bergmann wrote:
>> On Wed, Nov 8, 2023, at 19:33, Martin Tůma wrote:
>>> On 08. 11. 23 17:13, Arnd Bergmann wrote:
>>>> On Fri, Oct 27, 2023, at 16:17, Martin Tůma wrote:
>>>>> On 23. 10. 23 18:05, Arnd Bergmann wrote:
>>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> On SoCs you probably get a kernel configuration that is missing some 
>>> feature but still boots up when you do not select/depend on the exact 
>>> controller, but in the case of the mgb4 PCIe card you get a driver that 
>>> does not work at all (The SPI_XILINX dependency could theoretically be 
>>> made configurable, but you would lose the ability to flash the correct 
>>> FW for the current HW module and the access to the card's serial number. 
>>> I2C and XDMA are crucial.).
>>
>> My point was that we do this all the time for things that are
>> essential: if your clock controller or the irqchip have
>> no driver, then the camera device won't work, but neither
>> would anything else.
>>
>> So in a SoC setting, you really just need to enable all
>> the drivers for devices on that chip through the .config.
>>
>>>> Since this is a PCI device, it's a bit different, so maybe
>>>> something like this would work to correctly document which
>>>> dependencies are required at build time vs run time:
>>>>
>>>> --- a/drivers/media/pci/mgb4/Kconfig
>>>> +++ b/drivers/media/pci/mgb4/Kconfig
>>>> @@ -1,15 +1,13 @@
>>>>   # SPDX-License-Identifier: GPL-2.0-only
>>>>   config VIDEO_MGB4
>>>>          tristate "Digiteq Automotive MGB4 support"
>>>> -       depends on VIDEO_DEV && PCI && I2C && DMADEVICES && SPI && MTD && IIO
>>>> +       depends on VIDEO_DEV && PCI && I2C && SPI && MTD && IIO
>>>>          depends on COMMON_CLK
>>>> +       depends on XILINX_XDMA
>>>> +       depends on (I2C_XILINX && SPI_XILINX) || COMPILE_TEST
>>>>          select VIDEOBUF2_DMA_SG
>>>>          select IIO_BUFFER
>>>>          select IIO_TRIGGERED_BUFFER
>>>> -       select I2C_XILINX
>>>> -       select SPI_XILINX
>>>> -       select MTD_SPI_NOR
>>>> -       select XILINX_XDMA
>>>>          help
>>>>            This is a video4linux driver for Digiteq Automotive MGB4 grabber
>>>>            cards.
>>>>
>>>
>>> My motivation when using "select" was to help people using "make 
>>> menuconfig" to get the module selected/configured as they will usually 
>>> not know that there are some Xilinx IP cores used that need separate 
>>> drivers and the menuconfig GUI simply hides the mgb4 option making it 
>>> almost impossible just from the menus to find out what has to be selected.
>>>
>>> But when there are reasons, why to chose "depends on" (like various 
>>> configurations, tests or the "readability" of the dependencies) than I'm 
>>> ok with your patch proposal.
>>
>> The main reason to use 'depends on' over 'select' here is that
>> mixing the two is a common source of dependency loops that end
>> up breaking the build. As a rule of thumb, I would use 'select'
>> only for symbols that others already select, or that are hidden
>> from visibility.
>>
>>       Arnd
>>
> 
> Arnd, can you post a v2? I think this should go to v6.7 as a fix.
> 
> Regards,
> 
> 	Hans
> 

