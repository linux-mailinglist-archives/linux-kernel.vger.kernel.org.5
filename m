Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A177EC77E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjKOPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:38:06 -0500
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34639109;
        Wed, 15 Nov 2023 07:38:03 -0800 (PST)
Received: from [192.168.178.97] (pd95ef485.dip0.t-ipconnect.de [217.94.244.133])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 15C9A28157A;
        Wed, 15 Nov 2023 15:38:02 +0000 (UTC)
Message-ID: <938c06e4-ce48-49af-ac3a-61f524796e26@zonque.org>
Date:   Wed, 15 Nov 2023 16:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sc16is7xx: address RX timeout interrupt errata
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        lech.perczak@camlingroup.com, u.kleine-koenig@pengutronix.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Popov <maxim.snafu@gmail.com>, stable@vger.kernel.org
References: <20231114074904.239458-1-daniel@zonque.org>
 <20231114102025.d48c0a6ec6c413f274b7680b@hugovil.com>
 <140280a6-1948-4630-b10c-8e6a2afec2de@zonque.org>
 <20231115094717.7541b01ec0c8a7f4006fcae6@hugovil.com>
 <549319d4-5da9-4eb0-abeb-6e63b3e26e3f@zonque.org>
 <20231115103126.d1cb1168c32c264fe443347b@hugovil.com>
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <20231115103126.d1cb1168c32c264fe443347b@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

On 11/15/23 16:31, Hugo Villeneuve wrote:
> On Wed, 15 Nov 2023 15:57:38 +0100
> Daniel Mack <daniel@zonque.org> wrote:
> 
>> On 11/15/23 15:47, Hugo Villeneuve wrote:
>>> On Tue, 14 Nov 2023 16:55:33 +0100
>>> Daniel Mack <daniel@zonque.org> wrote:
>>>
>>>> Hi Hugo,
>>>>
>>>> On 11/14/23 16:20, Hugo Villeneuve wrote:
>>>>> On Tue, 14 Nov 2023 08:49:04 +0100
>>>>> Daniel Mack <daniel@zonque.org> wrote:
>>>>>> This devices has a silicon bug that makes it report a timeout interrupt
>>>>>> but no data in FIFO.
>>>>>>
>>>>>> The datasheet states the following in the errata section 18.1.4:
>>>>>>
>>>>>>   "If the host reads the receive FIFO at the at the same time as a
>>>>>>   time-out interrupt condition happens, the host might read 0xCC
>>>>>>   (time-out) in the Interrupt Indication Register (IIR), but bit 0
>>>>>>   of the Line Status Register (LSR) is not set (means there is not
>>>>>>   data in the receive FIFO)."
>>>>>>
>>>>>> When this happens, the loop in sc16is7xx_irq() will run forever,
>>>>>> which effectively blocks the i2c bus and breaks the functionality
>>>>>> of the UART.
>>>>>>
>>>>>> From the information above, it is assumed that when the bug is
>>>>>> triggered, the FIFO does in fact have payload in its buffer, but the
>>>>>> fill level reporting is off-by-one. Hence this patch fixes the issue
>>>>>> by reading one byte from the FIFO when that condition is detected.
>>>>>
>>>>> From what I understand from the errata, when the problem occurs, it
>>>>> affects bit 0 of the LSR register. I see no mention that it
>>>>> also affects the RX FIFO level register (SC16IS7XX_RXLVL_REG)?
>>>>
>>>> True, the errata doesn't explicitly mention that, but tests have shown
>>>> that the RXLVL register is equally affected.
>>>
>>> Hi Daniel,
>>> ok, now it makes more sense if RXLVL is affected.
>>>
>>> Have you contacted NXP about this? If not, I suggest you do open a
>>> support case and let them know about your findings, because it is very
>>> strange that it is not mentioned in the errata. And doing so may led to
>>> an updated and better documentation on their side about this errata.
>>
> 
> Hi Daniel,
> 
>> The errata is also wrong in other regards - the IIR register cannot
>> yield 0xcc according to their own documentation. It also makes no
>> suggestion on how to recover from that situation, which is common
>> practice usually.
> 
> 0xcc is valid according to the datasheet. Bits 7:6 are a mirror copy of
> FCR[0], so bits 5:0 are 0x0c, which is documented in table 14?

Ah, right. I was looking at the masked value.

> But you are right about the recovery procedure, it should be documented
> in the errata.
> 
> 
>> We'll let them know through our FAE channels, but the latest datasheet
>> for this chip was released over a decade ago, and I don't expect any
>> update to the errata wording.
> 
> You cannot assume they would not update the datasheet, especially with
> your findings about RXLVL which add a whole new dimension to this
> errata. The fact that the latest release was long ago is irrelevant.

Yes, we will give them a note. Let's see what happens.

>>> And incorporate this new info into your commit log for an eventual
>>> patch V2.
>>
>> It makes no sense IMO to have all users of this chip suffer from an
>> issue that was clearly identified to be present and which has an evident
>> fix. Why would we do that?
> 
> I don't know what you mean by that...
> 
> My suggestion was simply to incorporate your findings about RXLVL
> register into your commit log for patch V2...

My apologies, I misread your message then. I thought you suggested to
wait for a new errata statement from NXP so we can quote from that in
the commit.

The RXLVL detail is part of the the commit log in the v2 submission.


Thanks,
Daniel
