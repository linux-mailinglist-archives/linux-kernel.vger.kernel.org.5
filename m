Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A577EC68B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbjKOPBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344288AbjKOPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:01:33 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F3AB;
        Wed, 15 Nov 2023 07:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=YCgL2ztxtDiVu3eA8ljQ93m5dha9B9l8BgMn8Bi6WTk=; b=G1P0VEDbI+fPM86puwbmL/Zoal
        NCzgGfhf2Gg+s7fQzaauU1PrAiLcSbt7QiaWr2rENJyzXQ3dhCxEpyKV+M78HObWM/nYk+IJl6YbQ
        Qd/Nrjs/OO1Q8XDU75UOodwJUkYEa3vv1E7n6Od5K700PMmVuFWJ2FzMJCL1BSjBX7/I=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52530 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r3HOL-0001hg-UI; Wed, 15 Nov 2023 10:01:22 -0500
Date:   Wed, 15 Nov 2023 10:01:21 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Daniel Mack <daniel@zonque.org>
Cc:     Lech Perczak <lech.perczak@camlingroup.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Popov <maxim.snafu@gmail.com>,
        stable@vger.kernel.org
Message-Id: <20231115100121.5c926d4eb6d3abb02234887d@hugovil.com>
In-Reply-To: <ecc90a62-7cfa-45c9-9f6c-188e2c8ac50f@zonque.org>
References: <20231114074904.239458-1-daniel@zonque.org>
        <20231114102025.d48c0a6ec6c413f274b7680b@hugovil.com>
        <140280a6-1948-4630-b10c-8e6a2afec2de@zonque.org>
        <3fac7d72-0a1b-4d93-9245-a0f8af1240a6@camlingroup.com>
        <ecc90a62-7cfa-45c9-9f6c-188e2c8ac50f@zonque.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_CSS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] serial: sc16is7xx: address RX timeout interrupt errata
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 12:22:10 +0100
Daniel Mack <daniel@zonque.org> wrote:

> Hi Lech,
>=20
> On 11/15/23 11:51, Lech Perczak wrote:
> > W dniu 14.11.2023 o=A016:55, Daniel Mack pisze:
> >> Hi Hugo,
> >>
> >> On 11/14/23 16:20, Hugo Villeneuve wrote:
> >>> On Tue, 14 Nov 2023 08:49:04 +0100
> >>> Daniel Mack <daniel@zonque.org> wrote:
> >>>> This devices has a silicon bug that makes it report a timeout interr=
upt
> >>>> but no data in FIFO.
> >>>>
> >>>> The datasheet states the following in the errata section 18.1.4:
> >>>>
> >>>>   "If the host reads the receive FIFO at the at the same time as a
> >>>>   time-out interrupt condition happens, the host might read 0xCC
> >>>>   (time-out) in the Interrupt Indication Register (IIR), but bit 0
> >>>>   of the Line Status Register (LSR) is not set (means there is not
> >>>>   data in the receive FIFO)."
> >>>>
> >>>> When this happens, the loop in sc16is7xx_irq() will run forever,
> >>>> which effectively blocks the i2c bus and breaks the functionality
> >>>> of the UART.
> >>>>
> >>>> From the information above, it is assumed that when the bug is
> >>>> triggered, the FIFO does in fact have payload in its buffer, but the
> >>>> fill level reporting is off-by-one. Hence this patch fixes the issue
> >>>> by reading one byte from the FIFO when that condition is detected.
> >>> From what I understand from the errata, when the problem occurs, it
> >>> affects bit 0 of the LSR register. I see no mention that it
> >>> also affects the RX FIFO level register (SC16IS7XX_RXLVL_REG)?
> >> True, the errata doesn't explicitly mention that, but tests have shown
> >> that the RXLVL register is equally affected.
> >>
> >>> LSR[0] would be checked only if we were using polled mode of
> >>> operation, but we always use the interrupt mode (IRQ), and therefore I
> >>> would say that this errata doesn't apply to this driver, and the
> >>> patch is not necessary...
> >> Well, it is. We have seen this bug in the wild and extensively
> >> stress-tested the patch on dozens of boards for many days. Without this
> >> patch, kernels on affected systems would consume a lot of CPU cycles in
> >> the interrupt threads and effectively render the I2C bus unusable due =
to
> >> the busy polling.
> >>
> >> With this patch applied, we were no longer able to reproduce the issue.
> > Could you share some more details on the setup you use to reproduce thi=
s? I'd like to try out as well.
>=20
> We have boards with 2 I2C busses with an SC16IS752IBS on both. The UARTs
> are configured in infrared mode, and they send receive IR signals
> constantly. I guess the same would happen with other electrical
> interfaces, but the important bit is that the UARTs see a steady stream
> of inbound data.
>=20

Hi Daniel,

> The bug has hit us on production units and when it does, sc16is7xx_irq()
> would spin forever because sc16is7xx_port_irq() keeps seeing an
> interrupt in the IIR register that is not cleared because the driver
> does not call into sc16is7xx_handle_rx() unless the RXLVL register
> reports at least one byte in the FIFO.

I would suggest that you replace the second paragraph or your original
commit message with this, it better explains what is the problem.

Also, when the problem happens, you say that "the fill level reporting
is off-by-one", so doest it mean that RXLVL can sometimes be non-zero
when the bug occurs?


> Note that this issue might only occur in revision E of the silicon. And

Is this just a supposition or based on NXP info or some actual tests?

> there seems to be now way to read the revision code through I2C, so I
> guess you won't be able to figure out easily whether your chip is affecte=
d.
>=20
> Let me know if I can provide more information.

I have a board with two SC16IS752IPW using SPI interface, but I don't
know (yet) what is the revision. I will try to determine it if possible,
although I do not see any info on that in the datasheet.

I will also try to reproduce the issue, and test your patch.

Hugo.
