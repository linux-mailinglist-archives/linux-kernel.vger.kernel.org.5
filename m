Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C857EC64B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbjKOOuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344106AbjKOOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:50:03 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473358E;
        Wed, 15 Nov 2023 06:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=N4nOVNPHN/GNaTgQVzsx/iDuZLO8JZV/hkIdjCBQPKU=; b=hy9smrm8aioCpyQ50Y+b+qF/mR
        Tv4TUTLXXigyWiu7IyXVdkZ6k63lNhVUYECakrlpBnDmrylv/S6f6hqFfmqsdGZ/jYVBrFzyGCAbB
        jWRepxP8g91xFM/LH4TbzCaCHruQRiN+bJ4VcF19etJtdomIJIslOwXzFgSGB31J6gp4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55162 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r3HDF-0001ej-N4; Wed, 15 Nov 2023 09:49:54 -0500
Date:   Wed, 15 Nov 2023 09:49:53 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Daniel Mack <daniel@zonque.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        lech.perczak@camlingroup.com, u.kleine-koenig@pengutronix.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Popov <maxim.snafu@gmail.com>, stable@vger.kernel.org
Message-Id: <20231115094953.f2a3fee202765c11421b7fb7@hugovil.com>
In-Reply-To: <20231114074904.239458-1-daniel@zonque.org>
References: <20231114074904.239458-1-daniel@zonque.org>
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

On Tue, 14 Nov 2023 08:49:04 +0100
Daniel Mack <daniel@zonque.org> wrote:

Hi Daniel,

> This devices has a silicon bug that makes it report a timeout interrupt

devices -> device

> but no data in FIFO.
> 
> The datasheet states the following in the errata section 18.1.4:
> 
>   "If the host reads the receive FIFO at the at the same time as a

"at the at the" -> "at the"

Note: I know this error is part of the errata in NXP datasheet.


>   time-out interrupt condition happens, the host might read 0xCC
>   (time-out) in the Interrupt Indication Register (IIR), but bit 0
>   of the Line Status Register (LSR) is not set (means there is not
>   data in the receive FIFO)."
> 
> When this happens, the loop in sc16is7xx_irq() will run forever,
> which effectively blocks the i2c bus and breaks the functionality

i2c -> i2c/spi

Hugo.


> of the UART.
> 
> From the information above, it is assumed that when the bug is
> triggered, the FIFO does in fact have payload in its buffer, but the
> fill level reporting is off-by-one. Hence this patch fixes the issue
> by reading one byte from the FIFO when that condition is detected.
> 
> This clears the interrupt and hence breaks the polling loop.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Co-Developed-by: Maxim Popov <maxim.snafu@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/tty/serial/sc16is7xx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 289ca7d4e566..76f76e510ed1 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -765,6 +765,18 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
>  		case SC16IS7XX_IIR_RTOI_SRC:
>  		case SC16IS7XX_IIR_XOFFI_SRC:
>  			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
> +
> +			/*
> +			 * There is a silicon bug that makes the chip report a
> +			 * time-out interrupt but no data in the FIFO. This is
> +			 * described in errata section 18.1.4.
> +			 *
> +			 * When this happens, read one byte from the FIFO to
> +			 * clear the interrupt.
> +			 */
> +			if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
> +				rxlen = 1;
> +
>  			if (rxlen)
>  				sc16is7xx_handle_rx(port, rxlen, iir);
>  			break;
> -- 
> 2.41.0
> 
