Return-Path: <linux-kernel+bounces-24722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B67C82C156
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16108B24136
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332976D1CC;
	Fri, 12 Jan 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKDDUd8r"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43D59175;
	Fri, 12 Jan 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705068342; x=1736604342;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=77qUhIk8UEJUQ4AxK+DOYzJtZ9F/QPegLGP5CRgl2gg=;
  b=oKDDUd8rXYobRYrhlRWSI5vhQ3NY9pzP5eAym6h7km4dG6AZKtWxFI9H
   awtaanxcXxnycq8+AxE8GVS16z+FlSXiyiNdNsZ/oNpNmQKWgoBLqEAUo
   7vgvs+Jns8yoDrktkIFcccCX9OFyL1dZrhT1CqdB9z/708H5opbXKOBd+
   Rj/h21ZKZPUOqH0saz5vOiOya29+/i8ewpkT7VsP0pG1vImFcaQZZJhMg
   VO+yLU6xz4QLlMGWtumASkhZIFPKVA2U/texz7RATNz7RdKOgx3gmjewi
   hsJvb6k4beCSt0aFB5pEKE9gzEY/F17iK3b7v5zGopei8ZnRHX6bC50UV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="398862244"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="398862244"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="786357248"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="786357248"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.141])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:05:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Jan 2024 16:05:34 +0200 (EET)
To: Gui-Dong Han <2045gemini@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>, 
    l.sanfilippo@kunbus.com, john.ogness@linutronix.de, tglx@linutronix.de, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, baijiaju1990@outlook.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix double fetch in
 uart_throttle/uart_unthrottle
In-Reply-To: <20240112121844.17580-1-2045gemini@gmail.com>
Message-ID: <3bbabf34-1eba-8983-439e-f23e811e80a8@linux.intel.com>
References: <20240112121844.17580-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Jan 2024, Gui-Dong Han wrote:

> In uart_throttle() and uart_unthrottle():
>     if (port->status & mask) {
>         port->ops->throttle/unthrottle(port);
>         mask &= ~port->status;
>     }
>     // Code segment utilizing the mask value to determine UART behavior
> 
> In uart_change_line_settings():
>     uart_port_lock_irq(uport);
>     // Code segment responsible for updating uport->status
>     uart_port_unlock_irq(uport);
> 
> In the uart_throttle() and uart_unthrottle() functions, there is a double
> fetch issue due to concurrent execution with uart_change_line_settings().
> In uart_throttle() and uart_unthrottle(), the check
> if (port->status & mask) is made, followed by mask &= ~port->status,
> where the relevant bits are cleared. However, port->status may be modified
> in uart_change_line_settings(). The current implementation does not ensure
> atomicity in the access and modification of port->status and mask. This
> can result in mask being updated based on a modified port->status value,
> leading to improper UART actions.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations. The above
> possible bug is reported when our tool analyzes the source code of
> Linux 5.17.
> 
> To resolve this double fetch, it is suggested to add a uart_port_lock pair
> in uart_throttle() and uart_unthrottle(). With this patch applied, our
> tool no longer reports the bug, with the kernel configuration allyesconfig
> for x86_64. Due to the absence of the requisite hardware, we are unable to
> conduct runtime testing of the patch. Therefore, our verification is
> solely based on code logic analysis.
> 
> [1] https://sites.google.com/view/basscheck/
> 
> Fixes: 391f93f2ec9f ("serial: core: Rework hw-assisted flow control support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 80085b151b34..9d905fdf2843 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -723,11 +723,13 @@ static void uart_throttle(struct tty_struct *tty)
>  		mask |= UPSTAT_AUTOXOFF;
>  	if (C_CRTSCTS(tty))
>  		mask |= UPSTAT_AUTORTS;
> -
> +
> +	uart_port_lock_irq(port);
>  	if (port->status & mask) {
>  		port->ops->throttle(port);
>  		mask &= ~port->status;
>  	}
> +	uart_port_unlock_irq(port);
>  
>  	if (mask & UPSTAT_AUTORTS)
>  		uart_clear_mctrl(port, TIOCM_RTS);
> @@ -753,10 +755,12 @@ static void uart_unthrottle(struct tty_struct *tty)
>  	if (C_CRTSCTS(tty))
>  		mask |= UPSTAT_AUTORTS;
>  
> +	uart_port_lock_irq(port);
>  	if (port->status & mask) {
>  		port->ops->unthrottle(port);
>  		mask &= ~port->status;
>  	}
> +	uart_port_unlock_irq(port);
>  
>  	if (mask & UPSTAT_AUTORTS)
>  		uart_set_mctrl(port, TIOCM_RTS);

Hi,

This is very bogus "fix". While change to the local variable gets 
"protected", uart_change_line_settings() can race after unlock and the 
value held in mask is again stale.

If, and it's a big if, this is a real problem, the patch does not fix 
anything! It proves your tool is flawed because it doesn't detect the 
race with uart_change_line_settings() issue still exists after this 
non-fix.

So NAK from me. Please provide a real fix instead if you think there is
a real issue.

Also, don't use vague wording like "leading to improper UART action" but 
describe precisely what goes wrong!

-- 
 i.


