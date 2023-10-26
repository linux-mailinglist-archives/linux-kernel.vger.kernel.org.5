Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EBC7D8499
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbjJZOYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjJZOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:24:42 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9596C1BE;
        Thu, 26 Oct 2023 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=I0PpOgjWWDUtxtcOnCmhc1dwoPuyIJGwsTA62bPuxdc=; b=nhsJ2VtHaOS/D4tIqoPFSsYHKG
        yGxCJb2fIAPmrXCq6gq0DsKRU/qB38i0o7MIwgUXNCp4HO/KTmncSo8rpoGU/wQtNB9j39mAC1/mI
        jwKmqDqH0vJkfqi2OoFVGvXsupb2OG0FUPWXbrhtIouKr28N6Rfs3lTufY81vg0GNQRQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41414 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qw1Hd-0007wo-EI; Thu, 26 Oct 2023 10:24:26 -0400
Date:   Thu, 26 Oct 2023 10:24:24 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     =?ISO-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Message-Id: <20231026102424.81c0f7487df505d2ed92cf13@hugovil.com>
In-Reply-To: <20231026-mbly-uart-v1-4-9258eea297d3@bootlin.com>
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
        <20231026-mbly-uart-v1-4-9258eea297d3@bootlin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 4/6] tty: serial: amba-pl011: replace TIOCMBIT macros by
 static functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 12:41:21 +0200
Th=E9o Lebrun <theo.lebrun@bootlin.com> wrote:

Hi,

> The driver uses two TIOCMBIT macros inside pl011_{get,set}_mctrl to
> simplify the logic. Those look scary to checkpatch because they contain
> ifs without do-while loops.
>=20
> Avoid the macros by creating small equivalent static functions; that
> lets the compiler do its type checking & avoids checkpatch errors.
>=20
> For the second instance __assign_bit is not usable because it deals with
> unsigned long pointers whereas we have an unsigned int in
> pl011_set_mctrl.
>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 46 +++++++++++++++++++++--------------=
------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 0d53973374de..bb3082c4d35c 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1087,7 +1087,6 @@ static void pl011_dma_rx_poll(struct timer_list *t)
>  	 */
>  	if (jiffies_to_msecs(jiffies - dmarx->last_jiffies)
>  			> uap->dmarx.poll_timeout) {
> -

This should go into a separate patch, or simply be merged with one
of your other coding style/whitespace cleanup patches.

Hugo.


>  		spin_lock_irqsave(&uap->port.lock, flags);
>  		pl011_dma_rx_stop(uap);
>  		uap->im |=3D UART011_RXIM;
> @@ -1595,6 +1594,12 @@ static unsigned int pl011_tx_empty(struct uart_por=
t *port)
>  							0 : TIOCSER_TEMT;
>  }
> =20
> +static void pl011_maybe_set_bit(bool cond, unsigned int *ptr, unsigned i=
nt mask)
> +{
> +	if (cond)
> +		*ptr |=3D mask;
> +}
> +
>  static unsigned int pl011_get_mctrl(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =3D
> @@ -1602,18 +1607,22 @@ static unsigned int pl011_get_mctrl(struct uart_p=
ort *port)
>  	unsigned int result =3D 0;
>  	unsigned int status =3D pl011_read(uap, REG_FR);
> =20
> -#define TIOCMBIT(uartbit, tiocmbit)	\
> -	if (status & uartbit)		\
> -		result |=3D tiocmbit
> +	pl011_maybe_set_bit(status & UART01x_FR_DCD, &result, TIOCM_CAR);
> +	pl011_maybe_set_bit(status & uap->vendor->fr_dsr, &result, TIOCM_DSR);
> +	pl011_maybe_set_bit(status & uap->vendor->fr_cts, &result, TIOCM_CTS);
> +	pl011_maybe_set_bit(status & uap->vendor->fr_ri, &result, TIOCM_RNG);
> =20
> -	TIOCMBIT(UART01x_FR_DCD, TIOCM_CAR);
> -	TIOCMBIT(uap->vendor->fr_dsr, TIOCM_DSR);
> -	TIOCMBIT(uap->vendor->fr_cts, TIOCM_CTS);
> -	TIOCMBIT(uap->vendor->fr_ri, TIOCM_RNG);
> -#undef TIOCMBIT
>  	return result;
>  }
> =20
> +static void pl011_assign_bit(bool cond, unsigned int *ptr, unsigned int =
mask)
> +{
> +	if (cond)
> +		*ptr |=3D mask;
> +	else
> +		*ptr &=3D ~mask;
> +}
> +
>  static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
>  	struct uart_amba_port *uap =3D
> @@ -1622,23 +1631,16 @@ static void pl011_set_mctrl(struct uart_port *por=
t, unsigned int mctrl)
> =20
>  	cr =3D pl011_read(uap, REG_CR);
> =20
> -#define	TIOCMBIT(tiocmbit, uartbit)		\
> -	if (mctrl & tiocmbit)		\
> -		cr |=3D uartbit;		\
> -	else				\
> -		cr &=3D ~uartbit
> -
> -	TIOCMBIT(TIOCM_RTS, UART011_CR_RTS);
> -	TIOCMBIT(TIOCM_DTR, UART011_CR_DTR);
> -	TIOCMBIT(TIOCM_OUT1, UART011_CR_OUT1);
> -	TIOCMBIT(TIOCM_OUT2, UART011_CR_OUT2);
> -	TIOCMBIT(TIOCM_LOOP, UART011_CR_LBE);
> +	pl011_assign_bit(mctrl & TIOCM_RTS, &cr, UART011_CR_RTS);
> +	pl011_assign_bit(mctrl & TIOCM_DTR, &cr, UART011_CR_DTR);
> +	pl011_assign_bit(mctrl & TIOCM_OUT1, &cr, UART011_CR_OUT1);
> +	pl011_assign_bit(mctrl & TIOCM_OUT2, &cr, UART011_CR_OUT2);
> +	pl011_assign_bit(mctrl & TIOCM_LOOP, &cr, UART011_CR_LBE);
> =20
>  	if (port->status & UPSTAT_AUTORTS) {
>  		/* We need to disable auto-RTS if we want to turn RTS off */
> -		TIOCMBIT(TIOCM_RTS, UART011_CR_RTSEN);
> +		pl011_assign_bit(mctrl & TIOCM_RTS, &cr, UART011_CR_RTSEN);
>  	}
> -#undef TIOCMBIT
> =20
>  	pl011_write(cr, uap, REG_CR);
>  }
>=20
> --=20
> 2.41.0
>=20
