Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20A47EB4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjKNQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjKNPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:55:45 -0500
X-Greylist: delayed 29183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 07:55:41 PST
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9111612C;
        Tue, 14 Nov 2023 07:55:41 -0800 (PST)
Received: from [10.251.0.132] (unknown [178.19.214.146])
        by mail.bugwerft.de (Postfix) with ESMTPSA id F02462800D8;
        Tue, 14 Nov 2023 15:55:39 +0000 (UTC)
Message-ID: <140280a6-1948-4630-b10c-8e6a2afec2de@zonque.org>
Date:   Tue, 14 Nov 2023 16:55:33 +0100
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
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <20231114102025.d48c0a6ec6c413f274b7680b@hugovil.com>
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

On 11/14/23 16:20, Hugo Villeneuve wrote:
> On Tue, 14 Nov 2023 08:49:04 +0100
> Daniel Mack <daniel@zonque.org> wrote:
>> This devices has a silicon bug that makes it report a timeout interrupt
>> but no data in FIFO.
>>
>> The datasheet states the following in the errata section 18.1.4:
>>
>>   "If the host reads the receive FIFO at the at the same time as a
>>   time-out interrupt condition happens, the host might read 0xCC
>>   (time-out) in the Interrupt Indication Register (IIR), but bit 0
>>   of the Line Status Register (LSR) is not set (means there is not
>>   data in the receive FIFO)."
>>
>> When this happens, the loop in sc16is7xx_irq() will run forever,
>> which effectively blocks the i2c bus and breaks the functionality
>> of the UART.
>>
>> From the information above, it is assumed that when the bug is
>> triggered, the FIFO does in fact have payload in its buffer, but the
>> fill level reporting is off-by-one. Hence this patch fixes the issue
>> by reading one byte from the FIFO when that condition is detected.
> 
> From what I understand from the errata, when the problem occurs, it
> affects bit 0 of the LSR register. I see no mention that it
> also affects the RX FIFO level register (SC16IS7XX_RXLVL_REG)?

True, the errata doesn't explicitly mention that, but tests have shown
that the RXLVL register is equally affected.

> LSR[0] would be checked only if we were using polled mode of
> operation, but we always use the interrupt mode (IRQ), and therefore I
> would say that this errata doesn't apply to this driver, and the
> patch is not necessary...

Well, it is. We have seen this bug in the wild and extensively
stress-tested the patch on dozens of boards for many days. Without this
patch, kernels on affected systems would consume a lot of CPU cycles in
the interrupt threads and effectively render the I2C bus unusable due to
the busy polling.

With this patch applied, we were no longer able to reproduce the issue.


Thanks,
Daniel

