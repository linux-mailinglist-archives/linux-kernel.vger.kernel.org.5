Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139D5801142
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378519AbjLAQzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLAQzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:55:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81530103;
        Fri,  1 Dec 2023 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701449719; x=1702054519; i=eberhard.stoll@gmx.de;
        bh=0jjOyskWrTtZzzIWvSKOAEYVWsKiIQdx9scG4AhdcjA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=WxlHU6yj8bCkIrnscZiwLIW1vR3Y+bcbdAHrIvDPIci7G9ZUJ9Bke7uBpsFUQt4S
         BAC3GVFW0WOp33+4nU3sBegn1DNCohsGgnKd1y/cn9+C+5gDLZdAP1JGg2oIXr9b5
         kS3/fvwAChOHf+V3FWakaM/53wxZNy4OaKR1NhLLNhrIdRnZBzQYZtRedBPoDONkp
         Vf0PI2O7rzGQbTZ9e6cSmWbacchmfYVJXDdYf0kEsbxPTwt9fOKytwi8O1p0R3WZj
         XYHXKsXqr5+o7epzIT9wCEWmMFO7crccFQiGmid5QexYUvjEflfl6N6/Bn/glV/s3
         EQXTGhwUTbtOXfa8NQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.126] ([87.122.194.157]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1r8Gmg1wwX-003eZg; Fri, 01
 Dec 2023 17:55:19 +0100
Message-ID: <a9c6d8e7-a014-4e04-9c6a-617235130c7b@gmx.de>
Date:   Fri, 1 Dec 2023 17:55:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: imx: fix tx statemachine deadlock
To:     Rasmus Villemoes <rasmus.villemoes@prevas.se>,
        Paul Geurts <paul_geurts@live.nl>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <2023112434-winter-embezzle-1b46@gregkh>
 <AM0PR09MB26758F651BC1B742EB45775995B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
 <a283cb15-d740-4f94-a81e-0147c2035cf7@prevas.dk>
 <e770c302-2fef-40ba-b955-dc8c54c8727c@prevas.se>
Content-Language: en-US
From:   Eberhard Stoll <eberhard.stoll@gmx.de>
In-Reply-To: <e770c302-2fef-40ba-b955-dc8c54c8727c@prevas.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gHtwEHppOHKCoBAjke6fuy3AVIjVbK56gCiHgPy4cAt0kKKVbnp
 VNY9QNI/kfnD9Q5UHMlAM7KudUUHbomYJf4HvjFwsktyQHxJmZtierqwWmjY3DaVhdmhSU8
 W2NhgO/Uri+AyOhfkgjbo33w7whMPwA9nZl7GgHbB6iM7LtSwMe3s2qEI7liOUKo2x5CW7Q
 wytgZufFBsauQufXvaYPQ==
UI-OutboundReport: notjunk:1;M01:P0:+SJaVTKirck=;jNUiqEylytKupCSA+lzaE5loEAk
 NKARH8ziCRrbalw/h4pQUlPV8ifcBCQdseBSR2UcSiFXHl7UWUIFtoFVTl490lf/KiLcUE3JM
 kYHktpsjfKXYyyHA4LYx2hjNIlIvPIywG90Gfu8swm/yV9SUplzS8drpmDsgDbeV94GhwE+mN
 tSHLHRDqgOlvdoQxPK+Mbj/jQ6u0z43u76+ZsIafqqcYqOW6F+q60RlDXVigg1/WWA56pRE7U
 asRL6o7nJgK00OeJRZ4zPxHbzJFiLjT25rqe3VGUOwxSibDmT5miPJaxYQxgUOToDCKZ1DwQN
 4ccTTfDRjhyGWJSkNXZs2iTpPHq03oXQzFegSjfhseId0XlO2ujewGE3FaL08Pf1GB7Bp+bni
 6h9AxKZOTITIoUT92H98iWOddslzib/E2QB/XGqttiDFAp7D2d0OFZVmfK3qY4yu5uxk4BUOd
 UocfdSZ9zJmiBWdJBkIdye1PV+M1kQkvwJMkNYg+bX8aN35AMZdUsege6mLBVpmjGHdKA/73+
 haVwVX80moM4voL5eKGEH1BmlskHD2CgLaYjsu3nVtSpBQrWloabeLEjPKPRjtUzbO5UIuxIL
 emUkoEf6I6Cp80DhOlfGKgd3PMzc/koo1o+tAp5MgOiPCWWhM3KLnl5MQMdBTc673CW/ye6ad
 ZVTIOnqlO//0XVS9GetE0A28llEIJpeSoWgPOQsvPXQZsJsIUplwr2NZSQOhoHFpSE+fsXu5M
 c0btEGtAuvY0Pqt0oimmXAAiAv4O96ZRogQS3+E9zXMBMYqECBfwKKXdDSif8Dn4+CKMmixQ0
 nR7eAlL68RE06Eu9ok8E5w0dBWFYegltqcTsyDoYNvVITnqOjSoq1t10g6C2IiYed3OEojfyT
 lKH/r9PJOGikizeleyg1QI4byLPNa3ZYeXEn8yoOPfgl+5InGCyvTaC3zrdAZ1JCBkuJ+glL7
 olBqgt1k+TQ4p355eGQkJC8AjMA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.11.23 10:09, Rasmus Villemoes wrote:
> On 24/11/2023 14.37, Rasmus Villemoes wrote:
>> On 24/11/2023 14.11, Paul Geurts wrote:
>>> When using the serial port as RS485 port, the tx statemachine is used =
to
>>> control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
>>> TTY port is closed in the middle of a transmission (for instance durin=
g
>>> userland application crash), imx_uart_shutdown disables the interface
>>> and disables the Transmission Complete interrupt. afer that,
>>> imx_uart_stop_tx bails on an incomplete transmission, to be retriggere=
d
>>> by the TC interrupt. This interrupt is disabled and therefore the tx
>>> statemachine never transitions out of SEND. The statemachine is in
>>> deadlock now, and the TX_EN remains low, making the interface useless.
>>>
>>> imx_uart_stop_tx now checks for incomplete transmission AND whether TC
>>> interrupts are enabled before bailing to be retriggered. This makes su=
re
>>> the state machine handling is reached, and is properly set to
>>> WAIT_AFTER_SEND.
>>>
>>> Fixes: cb1a60923609 ("serial: imx: implement rts delaying for rs485")
>>> Signed-off-by: Paul Geurts <paul_geurts@live.nl>
>>
>> Hi Paul
>>
>> Interestingly, both Eberhard (cc'ed) and I have hit similar problems in
>> this driver recently. See the thread
>> https://lore.kernel.org/lkml/20231120132256.136625-1-rasmus.villemoes@p=
revas.dk/
>> .
>>
>> It is possible that this also fixes the problems I/we saw, but I can't
>> get around to testing until sometime next week.
>
> This also seems to fix the problem I had when switching to rs232 and
> back to rs485, and I agree that it seems to be a cleaner fix than mine.
>
> I also tried reproducing what Eberhard reported, and I think I managed
> to do that, and at least my way of reproducing the tx lockup also seems
> to be fixed by this patch. Eberhard, can you test this patch in your set=
up?
>
> In any case,
>
> Tested-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>
> Rasmus
>

Yes, it also works for my test setup!

Tested-by: Eberhard Stoll <eberhard.stoll@gmx.de>

Best regards
Eberhard

