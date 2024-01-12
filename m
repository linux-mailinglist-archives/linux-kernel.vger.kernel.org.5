Return-Path: <linux-kernel+bounces-24488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCB82BD53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6A7B23352
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661A56B99;
	Fri, 12 Jan 2024 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qj2MGsgf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3B56B67;
	Fri, 12 Jan 2024 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705051997; x=1736587997;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bLdj0zzoFG21ehP1rGlfaxviFDj2Ujv35EFd0uix1TI=;
  b=Qj2MGsgfH8Qmsu0t/42izEPMaiOpaOq/jKJQmtb7+oHSOwColW+l17rg
   6xltu7qOigEhMASNQR9EIx7rSEW35ikpGpxnogUl5yjzHwQrBmvrOZoaV
   g610ocni4n33CSHOF41tFId3b/OLNntz+G7H6i+HFSw2rRIay42JvdxXT
   DdOQVsf90H985comDK9jT9/Xyr4C7YX4+wYC4v9HpSuiRNTywnCY7CBM3
   ZRjqRdU2TgaZxacc3VjVBv1oiAh/11+zoA3Xf7IWBszNGe2ygn2Ci5fWs
   6jebLrndBqlcfWa6rXA/TZ6JtG7lKcznHLGWl9m0J6xykwXzUaOB2gSr+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5852365"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="5852365"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 01:33:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="926335030"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="926335030"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.141])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 01:33:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Jan 2024 11:33:06 +0200 (EET)
To: Gui-Dong Han <2045gemini@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>, 
    l.sanfilippo@kunbus.com, john.ogness@linutronix.de, tglx@linutronix.de, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, baijiaju1990@outlook.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix atomicity violation in uart_tiocmget
In-Reply-To: <20240112075732.16730-1-2045gemini@gmail.com>
Message-ID: <7e05a189-1d5d-51da-4ae8-c2b4b8b8b25e@linux.intel.com>
References: <20240112075732.16730-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Jan 2024, Gui-Dong Han wrote:

> In uart_tiocmget():
>     result = uport->mctrl;
>     uart_port_lock_irq(uport);
>     result |= uport->ops->get_mctrl(uport);
>     uart_port_unlock_irq(uport);
>     ...
>     return result;
> 
> In uart_update_mctrl():
>     uart_port_lock_irqsave(port, &flags);
>     ...
>     port->mctrl = (old & ~clear) | set;
>     ...
>     uart_port_unlock_irqrestore(port, flags);
> 
> An atomicity violation is identified due to the concurrent execution of
> uart_tiocmget() and uart_update_mctrl(). After assigning
> result = uport->mctrl, the mctrl value may change in uart_update_mctrl(),
> leading to a mismatch between the value returned by
> uport->ops->get_mctrl(uport) and the mctrl value previously read.
> This can result in uart_tiocmget() returning an incorrect value.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations. The above
> possible bug is reported when our tool analyzes the source code of
> Linux 5.17.
> 
> To address this issue, it is suggested to move the line
> result = uport->mctrl inside the uart_port_lock block to ensure atomicity
> and prevent the mctrl value from being altered during the execution of
> uart_tiocmget(). With this patch applied, our tool no longer reports the
> bug, with the kernel configuration allyesconfig for x86_64. Due to the
> absence of the requisite hardware, we are unable to conduct runtime
> testing of the patch. Therefore, our verification is solely based on code
> logic analysis.
> 
> [1] https://sites.google.com/view/basscheck/
> 
> Fixes: 559c7ff4e324 ("serial: core: Use port lock wrappers")

This is clearly incorrect, also pre-559c7ff4e324 kernels have the 
assignment outside the critical section.

It's also non-sensical given that 559c7ff4e324 is quite recent. You 
claim to have found the issue in Linux 5.17. How come can you seriously 
claim that 559c7ff4e324 that isn't even present in Linux 5.17 is the 
commit that needs to be fixed?

> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 80085b151b34..a9e39416d877 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1085,8 +1085,8 @@ static int uart_tiocmget(struct tty_struct *tty)
>  		goto out;
>  
>  	if (!tty_io_error(tty)) {
> -		result = uport->mctrl;
>  		uart_port_lock_irq(uport);
> +		result = uport->mctrl;
>  		result |= uport->ops->get_mctrl(uport);
>  		uart_port_unlock_irq(uport);
>  	}
> 

The change itself looks quite harmless but it provides no quarantees that 
the result is up-to-date after uart_port_unlock_irq(), so while it solves 
the data race on paper it cannot fundamentally prevent racing after 
unlock. And again "result" variable containing stale information.

-- 
 i.


