Return-Path: <linux-kernel+bounces-126560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE86893977
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9DF282476
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B16F10961;
	Mon,  1 Apr 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V/2l8Ud+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93495101CE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964359; cv=none; b=G2aHiiDzPYrJ8eKcmlIaqjbtmEPaSrynU0AT6cQkLr3Ye1mx2kFKV/5bO0poy0cT47AoXSephLaj8Nk2M5tm5/tWxG/GLkngPwQCDmiPzQjSOx8wHqdHS1xEVbTkIDT8uqlpJIhxM+XyHuxcp/quuh0ioKIUeyHiKEZfsYIZz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964359; c=relaxed/simple;
	bh=e9xEhCEi0Wtt1EeHOlTmbaOt5pzWnrErrDEVF5RY/ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD6qWBAEtW6qv9QOmExFUZ8IP7P3iIUJw/JJc2MRw9DXh3IByuY9DkqU5hBqLxjKS64jcihcDzTwRA2/x/Q49aL7R4Bn3XmvgreZ4x0O70XejcE6MXdMXisJlTgF+mAM7x0xodrcxb8ZN4JTM3qUBffqyLG/orLnzUMPamwdAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V/2l8Ud+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4950C43394;
	Mon,  1 Apr 2024 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711964359;
	bh=e9xEhCEi0Wtt1EeHOlTmbaOt5pzWnrErrDEVF5RY/ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/2l8Ud++wgLSA7gVLLno4a7JkmzknoJCif03klo+JuKyAoOQ/4TogWoVxMOoYlvp
	 s2OdWKOuz2ao5CPoV8Bb2jmYZpm0BcXI5Um46F4QkIRN9tf10LDqTDJCwpd8lrxthd
	 o1srCw5Jz1sGqJhCyGnm07XikOJXmjEwlYmcXe8E=
Date: Mon, 1 Apr 2024 11:39:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "fengchunguo@126.com" <fengchunguo@126.com>
Cc: ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	"chunguo.feng" <chunguo.feng@semidrive.com>
Subject: Re: [PATCH] tty: serial: fixed uart irq maybe cause irq storm
Message-ID: <2024040147-stinging-payback-04f5@gregkh>
References: <1711963801-184362-1-git-send-email-fengchunguo@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711963801-184362-1-git-send-email-fengchunguo@126.com>

On Mon, Apr 01, 2024 at 05:30:01PM +0800, fengchunguo@126.com wrote:
> From: "chunguo.feng" <chunguo.feng@semidrive.com>

Please use your name, which is not with a "." in it, right?

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

Space needed after '*', right?

> +		 * disabled clk immediately, then cause irq storm.
> +		 */
> +		if (p->irq)
> +			disabled_irq(p->irq);

This feels wrong, the irq should not be turned off here, what happens if
some data comes in while this function is running?  Will it be lost?

thanks,

greg k-h

