Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B117EC636
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbjKOOrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjKOOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:47:31 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A8DB6;
        Wed, 15 Nov 2023 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=yfv8RLWW8OJj6tqwzcuXfDoEVuCDGTTEEl/uhycqU/w=; b=ePgCLU1vqT8vyT45MEJbB1mbxt
        YKJR6DLsyQTsAPDfCvg90F5s3hUXwGgxs1LxW4xBm2YkGxppuuJCmBBDCWDUF/z4SoekYxECWgJZT
        0HDPmPEdAm3eWNT0YGsB/y+KOEyEyPHJPKYhSFKTMWf7noUHSkb6Oj8WFsp2noK5FGPU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57814 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r3HAj-0001dr-Pm; Wed, 15 Nov 2023 09:47:18 -0500
Date:   Wed, 15 Nov 2023 09:47:17 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Daniel Mack <daniel@zonque.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        lech.perczak@camlingroup.com, u.kleine-koenig@pengutronix.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Popov <maxim.snafu@gmail.com>, stable@vger.kernel.org
Message-Id: <20231115094717.7541b01ec0c8a7f4006fcae6@hugovil.com>
In-Reply-To: <140280a6-1948-4630-b10c-8e6a2afec2de@zonque.org>
References: <20231114074904.239458-1-daniel@zonque.org>
        <20231114102025.d48c0a6ec6c413f274b7680b@hugovil.com>
        <140280a6-1948-4630-b10c-8e6a2afec2de@zonque.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 14 Nov 2023 16:55:33 +0100
Daniel Mack <daniel@zonque.org> wrote:

> Hi Hugo,
> 
> On 11/14/23 16:20, Hugo Villeneuve wrote:
> > On Tue, 14 Nov 2023 08:49:04 +0100
> > Daniel Mack <daniel@zonque.org> wrote:
> >> This devices has a silicon bug that makes it report a timeout interrupt
> >> but no data in FIFO.
> >>
> >> The datasheet states the following in the errata section 18.1.4:
> >>
> >>   "If the host reads the receive FIFO at the at the same time as a
> >>   time-out interrupt condition happens, the host might read 0xCC
> >>   (time-out) in the Interrupt Indication Register (IIR), but bit 0
> >>   of the Line Status Register (LSR) is not set (means there is not
> >>   data in the receive FIFO)."
> >>
> >> When this happens, the loop in sc16is7xx_irq() will run forever,
> >> which effectively blocks the i2c bus and breaks the functionality
> >> of the UART.
> >>
> >> From the information above, it is assumed that when the bug is
> >> triggered, the FIFO does in fact have payload in its buffer, but the
> >> fill level reporting is off-by-one. Hence this patch fixes the issue
> >> by reading one byte from the FIFO when that condition is detected.
> > 
> > From what I understand from the errata, when the problem occurs, it
> > affects bit 0 of the LSR register. I see no mention that it
> > also affects the RX FIFO level register (SC16IS7XX_RXLVL_REG)?
> 
> True, the errata doesn't explicitly mention that, but tests have shown
> that the RXLVL register is equally affected.

Hi Daniel,
ok, now it makes more sense if RXLVL is affected.

Have you contacted NXP about this? If not, I suggest you do open a
support case and let them know about your findings, because it is very
strange that it is not mentioned in the errata. And doing so may led to
an updated and better documentation on their side about this errata.

And incorporate this new info into your commit log for an eventual
patch V2.

Thank you,
Hugo.


> > LSR[0] would be checked only if we were using polled mode of
> > operation, but we always use the interrupt mode (IRQ), and therefore I
> > would say that this errata doesn't apply to this driver, and the
> > patch is not necessary...
> 
> Well, it is. We have seen this bug in the wild and extensively
> stress-tested the patch on dozens of boards for many days. Without this
> patch, kernels on affected systems would consume a lot of CPU cycles in
> the interrupt threads and effectively render the I2C bus unusable due to
> the busy polling.
> 
> With this patch applied, we were no longer able to reproduce the issue.
> 
> 
> Thanks,
> Daniel
> 
> 
