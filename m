Return-Path: <linux-kernel+bounces-126596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056A8893A32
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B487A281EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9422019452;
	Mon,  1 Apr 2024 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L4rEMlVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932DD52B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711967562; cv=none; b=bKrT726TFzlyUlW8k1sr/IZjTL31I6/JRwN6iBAO+vLSvWE0Kg2uZ0MdbnrfS7aIgFoS1Q+FRYJWaRwDMdQPOD2Mp5jD1Qdt5+/zyEa/1ZwOXw0tmnJQzJ8yROUdzkDOPeAW0vohp9lc+NAUNsNMotBrfBuCelaBkjTXGMcW+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711967562; c=relaxed/simple;
	bh=VKbhvGB/H5FPJQ4BNky4cRNh9erO4bHex9ypDk2lDLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDbbWbCYM1LZR/a0oPOsVo+McgQkyKe8e8UYtJujTjPF5A9COznAB12k45ldbeEG7otx5s0lur4vSHORkbzn5rjPlY8wB2py4FKe/ShqweM55t92REBlL5EKXbDIPNwGcjP1XHJIY00MCYs/XrO4h0oVHpdG4j5SaE6c8WYFFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L4rEMlVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B156C433F1;
	Mon,  1 Apr 2024 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711967562;
	bh=VKbhvGB/H5FPJQ4BNky4cRNh9erO4bHex9ypDk2lDLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4rEMlVhaiXICSdBbXs20/xxLo6F3xmA1yEc/AsibVoFKHBlhs1K2vBzIsZQRo6j3
	 Xy9eJlF1TJ9f4UFDqGBPwabWrxGQ/NAJaiY3VfT2uRou8Kl8cplafH6HgmcgD0gq5i
	 mUMTubSHyJ2TkWy04PTBqDP3iNEpUQocal+8AxNk=
Date: Mon, 1 Apr 2024 12:32:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "fengchunguo@126.com" <fengchunguo@126.com>
Cc: ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	Gary Feng <chunguo.feng@semidrive.com>
Subject: Re: [PATCH] tty: serial: fixed uart irq maybe cause irq storm
Message-ID: <2024040124-gone-retreat-6596@gregkh>
References: <1711966746-225228-1-git-send-email-fengchunguo@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711966746-225228-1-git-send-email-fengchunguo@126.com>

On Mon, Apr 01, 2024 at 06:19:06PM +0800, fengchunguo@126.com wrote:
> From: "Gary Feng" <chunguo.feng@semidrive.com>
> 
> if not disable uart irq before disable clk,  uart irq maybe triggered after
> disabled clk immediately, then maybe cause irq storm.
> 
> Reproduced the below call trace, see i2c not be connected, but irq storm
> was triggered.
> 
> i2c_designware 30b70000.i2c: controller timed out
> CPU: 2 PID: 2932 Comm: gnss@1.0-servic 
> Tainted: G O 5.14.61-00094-geaa0149416cc-dirty #8
> Hardware name: Semidrive kunlun x9 REF Board (DT)
> Call trace:
> [<ffff00000808a3cc>] dump_backtrace+0x0/0x3c0
> [<ffff00000808a7a0>] show_stack+0x14/0x1c
> [<ffff000008cef43c>] dump_stack+0xc4/0xfc
> [<ffff00000814eb80>] __report_bad_irq+0x50/0xe0
> [<ffff00000814eaec>] note_interrupt+0x248/0x28c
> [<ffff00000814c0e8>] handle_irq_event+0x78/0xa4
> [<ffff00000814fcb8>] handle_fasteoi_irq+0xe4/0x1b4
> [<ffff00000814b060>] __handle_domain_irq+0x7c/0xbc
> [<ffff00000808176c>] gic_handle_irq+0x4c/0xb8
> [<ffff000008083230>] el1_irq+0xb0/0x124
> [<ffff000008d09f5c>] _raw_spin_unlock_irqrestore+0x10/0x44
> [<ffff00000865b784>] dw8250_set_termios+0x48/0xf4
> [<ffff0000086545a4>] serial8250_set_termios+0x14/0x28
> [<ffff00000864c4f4>] uart_change_speed+0x38/0x10c
> [<ffff00000864e458>] uart_set_termios+0xd0/0x17c
> [<ffff000008630ad4>] tty_set_termios+0x160/0x1e4
> [<ffff00000863165c>] set_termios+0x32c/0x3bc
> [<ffff000008631248>] tty_mode_ioctl+0x6f0/0x7d8
> [<ffff000008631a6c>] n_tty_ioctl_helper+0x10c/0x1e8
> [<ffff00000862d2c4>] n_tty_ioctl+0x120/0x194
> [<ffff00000862a724>] tty_ioctl+0x658/0xa34
> [<ffff0000082a8f40>] do_vfs_ioctl+0x554/0x810
> [<ffff0000082a9368>] SyS_ioctl+0x88/0x94
> Exception stack(0xffff00000ccf3ec0 to 0xffff00000ccf4000
> 
> Signed-off-by: chunguo.feng <chunguo.feng@semidrive.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index c1d43f0..133c24e 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -359,6 +359,12 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>  
>  	rate = clk_round_rate(d->clk, newrate);
>  	if (rate > 0 && p->uartclk != rate) {
> +		/*Need disable uart irq before disabled clk, because uart irq maybe triggered after
> +		 * disabled clk immediately, then cause irq storm.
> +		 */
> +		if (p->irq)
> +			disabled_irq(p->irq);
> +
>  		clk_disable_unprepare(d->clk);
>  		/*
>  		 * Note that any clock-notifer worker will block in
> @@ -368,6 +374,9 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>  		if (!ret)
>  			p->uartclk = rate;
>  		clk_prepare_enable(d->clk);
> +
> +		if (p->irq)
> +			enable_irq(p->irq);
>  	}
>  
>  	dw8250_do_set_termios(p, termios, old);
> -- 
> 2.7.4
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

