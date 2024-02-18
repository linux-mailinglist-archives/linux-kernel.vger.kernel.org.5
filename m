Return-Path: <linux-kernel+bounces-70470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955EC85985E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAA1281312
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146306F06C;
	Sun, 18 Feb 2024 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hz3mcp9q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E329401;
	Sun, 18 Feb 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708279181; cv=none; b=RfKzqOTrZAsalqpZ0Kl8cZ8Em58HaqcFgGkKDN4BoYMjWiNrEc5gRkhAl19Mws0BMKcs7JqSTBDE1UKOnSBbTrTv0vcKa/4cS3dmGx7GQH2kbLEABG5hlbwpfpP7cxeFpXeHZO0GKQtbIdx2UYg6AAizQne+JiJer5KEfNBM/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708279181; c=relaxed/simple;
	bh=sGnaOwL737S+kRj7YV7UEO53mnW/ESMniXC/a9CnV8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBAo18ljt1bMSxbPUwEZaLAi4nTq7WrjlDrJp+SCGYLQL66pNcht+0npALNLA2yJewCvfQgJtsoouHxpGotNH7RvJ5Aleypbr40JzVeHaOJPypdcKfXxfQv+SB6/Qy7/EsGvTnkK1H/8HTcz0aF0e6wmXuyXnLhI+aZ9gxvxEnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hz3mcp9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59104C433C7;
	Sun, 18 Feb 2024 17:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708279180;
	bh=sGnaOwL737S+kRj7YV7UEO53mnW/ESMniXC/a9CnV8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hz3mcp9qSGs0/vs+7b46eQwzPMyH7me2NEclwq7Wiz2p9z57WO3U4SDfq9zRiZ+4s
	 eoHxL1rOcOjw4VzA94cyB8z646+hIPr7LaxxquJl3itnZam2hF6F+0NGjZ82vZArC9
	 gZoGWHEa9RflQ6vJeet7wg30LHWBfa/PeWrkRZlg=
Date: Sun, 18 Feb 2024 18:59:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] serial: st-asc: don't get/put GPIOs in atomic context
Message-ID: <2024021851-amniotic-trimester-89af@gregkh>
References: <20240214092438.10785-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214092438.10785-1-brgl@bgdev.pl>

On Wed, Feb 14, 2024 at 10:24:38AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Since commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with
> SRCU") gpiod_set_consumer_name() calls synchronize_srcu() which led to
> a "sleeping in atomic context" smatch warning.
> 
> This function (along with gpiod_get/put() and all other GPIO APIs apart
> from gpiod_get/set_value() and gpiod_direction_input/output()) should
> have never been called with a spinlock taken. We're only fixing this now
> as GPIOLIB has been rebuilt to use SRCU for access serialization which
> uncovered this problem.
> 
> Move the calls to gpiod_get/put() outside the spinlock critical section.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-gpio/deee1438-efc1-47c4-8d80-0ab2cf01d60a@moroto.mountain/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/tty/serial/st-asc.c | 40 ++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index bbb5595d7e24..52a20277df98 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -467,6 +467,7 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
>  	struct asc_port *ascport = to_asc_port(port);
>  	struct gpio_desc *gpiod;
>  	unsigned int baud;
> +	bool manual_rts;
>  	u32 ctrl_val;
>  	tcflag_t cflag;
>  	unsigned long flags;
> @@ -517,26 +518,12 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
>  		ctrl_val |= ASC_CTL_CTSENABLE;
>  
>  		/* If flow-control selected, stop handling RTS manually */
> -		if (ascport->rts) {
> -			devm_gpiod_put(port->dev, ascport->rts);
> -			ascport->rts = NULL;
> -
> -			pinctrl_select_state(ascport->pinctrl,
> -					     ascport->states[DEFAULT]);
> -		}
> +		if (ascport->rts)
> +			manual_rts = false;
>  	} else {
>  		/* If flow-control disabled, it's safe to handle RTS manually */
> -		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL]) {
> -			pinctrl_select_state(ascport->pinctrl,
> -					     ascport->states[NO_HW_FLOWCTRL]);
> -
> -			gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
> -			if (!IS_ERR(gpiod)) {
> -				gpiod_set_consumer_name(gpiod,
> -						port->dev->of_node->name);
> -				ascport->rts = gpiod;
> -			}
> -		}
> +		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL])
> +			manual_rts = true;
>  	}
>  
>  	if ((baud < 19200) && !ascport->force_m1) {
> @@ -595,6 +582,23 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
>  	asc_out(port, ASC_CTL, (ctrl_val | ASC_CTL_RUN));
>  
>  	uart_port_unlock_irqrestore(port, flags);
> +
> +	if (manual_rts) {
> +		pinctrl_select_state(ascport->pinctrl,
> +				     ascport->states[NO_HW_FLOWCTRL]);
> +
> +		gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
> +		if (!IS_ERR(gpiod)) {
> +			gpiod_set_consumer_name(gpiod,
> +						port->dev->of_node->name);
> +			ascport->rts = gpiod;
> +		} else {
> +			devm_gpiod_put(port->dev, ascport->rts);
> +			ascport->rts = NULL;
> +			pinctrl_select_state(ascport->pinctrl,
> +					     ascport->states[DEFAULT]);
> +		}
> +	}
>  }

The 0-day bot rightly points out that manual_rts could be uninitialized
by this change, so I'm dropping it from my tree.  Please fix up and
resend.

thanks,

greg k-h

