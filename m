Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2E97EC136
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbjKOLWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbjKOLWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:22:15 -0500
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3522F5;
        Wed, 15 Nov 2023 03:22:11 -0800 (PST)
Received: from [10.10.0.76] (unknown [62.214.9.170])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 8B8E228154F;
        Wed, 15 Nov 2023 11:22:10 +0000 (UTC)
Message-ID: <ecc90a62-7cfa-45c9-9f6c-188e2c8ac50f@zonque.org>
Date:   Wed, 15 Nov 2023 12:22:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sc16is7xx: address RX timeout interrupt errata
Content-Language: en-US
To:     Lech Perczak <lech.perczak@camlingroup.com>,
        Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Popov <maxim.snafu@gmail.com>,
        stable@vger.kernel.org
References: <20231114074904.239458-1-daniel@zonque.org>
 <20231114102025.d48c0a6ec6c413f274b7680b@hugovil.com>
 <140280a6-1948-4630-b10c-8e6a2afec2de@zonque.org>
 <3fac7d72-0a1b-4d93-9245-a0f8af1240a6@camlingroup.com>
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <3fac7d72-0a1b-4d93-9245-a0f8af1240a6@camlingroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lech,

On 11/15/23 11:51, Lech Perczak wrote:
> W dniu 14.11.2023 o 16:55, Daniel Mack pisze:
>> Hi Hugo,
>>
>> On 11/14/23 16:20, Hugo Villeneuve wrote:
>>> On Tue, 14 Nov 2023 08:49:04 +0100
>>> Daniel Mack <daniel@zonque.org> wrote:
>>>> This devices has a silicon bug that makes it report a timeout interrupt
>>>> but no data in FIFO.
>>>>
>>>> The datasheet states the following in the errata section 18.1.4:
>>>>
>>>>   "If the host reads the receive FIFO at the at the same time as a
>>>>   time-out interrupt condition happens, the host might read 0xCC
>>>>   (time-out) in the Interrupt Indication Register (IIR), but bit 0
>>>>   of the Line Status Register (LSR) is not set (means there is not
>>>>   data in the receive FIFO)."
>>>>
>>>> When this happens, the loop in sc16is7xx_irq() will run forever,
>>>> which effectively blocks the i2c bus and breaks the functionality
>>>> of the UART.
>>>>
>>>> From the information above, it is assumed that when the bug is
>>>> triggered, the FIFO does in fact have payload in its buffer, but the
>>>> fill level reporting is off-by-one. Hence this patch fixes the issue
>>>> by reading one byte from the FIFO when that condition is detected.
>>> From what I understand from the errata, when the problem occurs, it
>>> affects bit 0 of the LSR register. I see no mention that it
>>> also affects the RX FIFO level register (SC16IS7XX_RXLVL_REG)?
>> True, the errata doesn't explicitly mention that, but tests have shown
>> that the RXLVL register is equally affected.
>>
>>> LSR[0] would be checked only if we were using polled mode of
>>> operation, but we always use the interrupt mode (IRQ), and therefore I
>>> would say that this errata doesn't apply to this driver, and the
>>> patch is not necessary...
>> Well, it is. We have seen this bug in the wild and extensively
>> stress-tested the patch on dozens of boards for many days. Without this
>> patch, kernels on affected systems would consume a lot of CPU cycles in
>> the interrupt threads and effectively render the I2C bus unusable due to
>> the busy polling.
>>
>> With this patch applied, we were no longer able to reproduce the issue.
> Could you share some more details on the setup you use to reproduce this? I'd like to try out as well.

We have boards with 2 I2C busses with an SC16IS752IBS on both. The UARTs
are configured in infrared mode, and they send receive IR signals
constantly. I guess the same would happen with other electrical
interfaces, but the important bit is that the UARTs see a steady stream
of inbound data.

The bug has hit us on production units and when it does, sc16is7xx_irq()
would spin forever because sc16is7xx_port_irq() keeps seeing an
interrupt in the IIR register that is not cleared because the driver
does not call into sc16is7xx_handle_rx() unless the RXLVL register
reports at least one byte in the FIFO.

Note that this issue might only occur in revision E of the silicon. And
there seems to be now way to read the revision code through I2C, so I
guess you won't be able to figure out easily whether your chip is affected.

Let me know if I can provide more information.


Thanks,
Daniel






