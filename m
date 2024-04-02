Return-Path: <linux-kernel+bounces-127881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F089522E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AB81C228C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D63D6997A;
	Tue,  2 Apr 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3KDF5r+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D18664AB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058321; cv=none; b=tDypdVt6agNwTwkErdjcN+zho2qPEn6mqfiB/BDqU731024WIukuEgIiVpaFGKsj2jcrze4Vn9HLn/6ozokLtINT4Xj/vdpizxUQXTfG0+cW8b1hNavNvSLWSSdPug4y1xEHJd1AzaVtpiWJjDOCHVH7runpdfWXwuZ8rWiToIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058321; c=relaxed/simple;
	bh=J3vcQZxpdCuFkFzGgNmgmy5MLAq/HWsIDZHYrStWpC0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aFWu+71JspDr0i4kfIp6fHfPhgnw+d23wTcAWIA9IT3icKaBNWlPdJ5W7lYizR48jn10IkfW+nAGFKD0Za5JOiAID3FwhPNvxToRSPZb+Xs1E5Wsf34aNxPbK2YV7hglm6OpRtTisgqoJUlyNTW/MjJdhK5qityO7rh69YAatNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3KDF5r+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712058320; x=1743594320;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J3vcQZxpdCuFkFzGgNmgmy5MLAq/HWsIDZHYrStWpC0=;
  b=B3KDF5r+zLP/n1LbOJwXfpshdxPgtCwPqm4OmKvgPIT7UjwTG3xQdlbX
   Or4I8YNtd770zI+EJglvJXUNjqp/PEyNA8pzU620sc4isema6B1jf11Hp
   nCpVsDuwv8tcPL29WPUUgEJ4/RmfBdUM+QbMT67dtXMn304Z5XI4yl/ln
   X1UtTf+jezwLdCFOCQUriX/aEJa52f9uWS559eSkXzv1+UdHETBmBvT0y
   YdpXYW/ho+IMH+L0EOw/x8o7EibyTgowcWjW51T6J9Q4uPDCqp8UoCU2V
   SjWpEgu4d8l6KkR+ORJs9PPLCbkjpuS2pNMwUBIywMf41TksMXxgGPjR8
   Q==;
X-CSE-ConnectionGUID: WC73gDX3QhWDQEj03bETyg==
X-CSE-MsgGUID: 7GrwS8vTQcGT2blo0inCmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10185374"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="10185374"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 04:45:19 -0700
X-CSE-ConnectionGUID: uGgf1K3ASECt5D83I2EHwA==
X-CSE-MsgGUID: jstpzW8eQhe2y+qgl1SR6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22737103"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 04:45:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 14:45:12 +0300 (EEST)
To: "fengchunguo@126.com" <fengchunguo@126.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    Gary Feng <chunguo.feng@semidrive.com>
Subject: Re: [PATCH] tty: serial: fixed uart irq maybe cause irq storm
In-Reply-To: <1711966746-225228-1-git-send-email-fengchunguo@126.com>
Message-ID: <d7bf7c90-1d02-3058-3e8e-a5770010e52e@linux.intel.com>
References: <1711966746-225228-1-git-send-email-fengchunguo@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Apr 2024, fengchunguo@126.com wrote:

> From: "Gary Feng" <chunguo.feng@semidrive.com>
> 
> if not disable uart irq before disable clk,  uart irq maybe triggered after
> disabled clk immediately, then maybe cause irq storm.
> 
> Reproduced the below call trace, see i2c not be connected, but irq storm
> was triggered.

This doesn't really explain what's going on here. Why is the irq being 
triggered? You even seem to imply that nothing is connected so what 
triggers is triggering that irq? Can we selectively disable only that 
part, if it's e.g. empty tx condition or something?

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

Use your real name on signed-off line too. On From line you seem to 
provide different name as here.

-- 
 i.

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
> 

