Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A147EC6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbjKOPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbjKOPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:12:36 -0500
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4210818A;
        Wed, 15 Nov 2023 07:12:32 -0800 (PST)
Received: from [192.168.178.97] (pd95ef485.dip0.t-ipconnect.de [217.94.244.133])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 1FB5228157A;
        Wed, 15 Nov 2023 15:12:31 +0000 (UTC)
Message-ID: <beb4421c-c012-4833-abf8-f2780bcc43db@zonque.org>
Date:   Wed, 15 Nov 2023 16:12:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sc16is7xx: address RX timeout interrupt errata
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Lech Perczak <lech.perczak@camlingroup.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Popov <maxim.snafu@gmail.com>,
        stable@vger.kernel.org
References: <20231114074904.239458-1-daniel@zonque.org>
 <20231114102025.d48c0a6ec6c413f274b7680b@hugovil.com>
 <140280a6-1948-4630-b10c-8e6a2afec2de@zonque.org>
 <3fac7d72-0a1b-4d93-9245-a0f8af1240a6@camlingroup.com>
 <ecc90a62-7cfa-45c9-9f6c-188e2c8ac50f@zonque.org>
 <20231115100121.5c926d4eb6d3abb02234887d@hugovil.com>
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <20231115100121.5c926d4eb6d3abb02234887d@hugovil.com>
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

On 11/15/23 16:01, Hugo Villeneuve wrote:
> On Wed, 15 Nov 2023 12:22:10 +0100
> Daniel Mack <daniel@zonque.org> wrote:
> Hi Daniel,
> 
>> The bug has hit us on production units and when it does, sc16is7xx_irq()
>> would spin forever because sc16is7xx_port_irq() keeps seeing an
>> interrupt in the IIR register that is not cleared because the driver
>> does not call into sc16is7xx_handle_rx() unless the RXLVL register
>> reports at least one byte in the FIFO.
> 
> I would suggest that you replace the second paragraph or your original
> commit message with this, it better explains what is the problem.

Good idea, will do.

> Also, when the problem happens, you say that "the fill level reporting
> is off-by-one", so doest it mean that RXLVL can sometimes be non-zero
> when the bug occurs?

Maybe, but if that happens we would read one byte too less, which
doesn't harm as we would get another interrupt later to handle the rest.
The problematic case is when we don't read any data at all even though
there is something in the FIFO, and the interrupt suggested that as well.

>> Note that this issue might only occur in revision E of the silicon. And
> 
> Is this just a supposition or based on NXP info or some actual tests?

Well, the datasheet states "Errata for Rev. E added 12 August 2011", and
as "Revision E" does not seem to refer to a datasheet version, it will
most likely be about the silicon revision. And another assumption is
that the issue would fixed in subsequent versions of the chip, in case
there are any at all.

FTR, this is the document I'm looking at:

  https://www.nxp.com/docs/en/data-sheet/SC16IS752_SC16IS762.pdf

>> there seems to be now way to read the revision code through I2C, so I
>> guess you won't be able to figure out easily whether your chip is affected.
>>
>> Let me know if I can provide more information.
> 
> I have a board with two SC16IS752IPW using SPI interface, but I don't
> know (yet) what is the revision. I will try to determine it if possible,
> although I do not see any info on that in the datasheet.
> 
> I will also try to reproduce the issue, and test your patch.

Great, thanks!


Best regards,
Daniel
