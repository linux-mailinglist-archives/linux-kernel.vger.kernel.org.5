Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662237A1AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjIOJf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjIOJf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:35:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCFE171C;
        Fri, 15 Sep 2023 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694770522; x=1726306522;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UgXXbWdkQH1ECa9Ar2m27pqTIEtUL3zv5cVAncIx9xA=;
  b=GzU/R+l/VeqrxKSV4lmZ3EAwKftyJMUjsWcbKXrEOhQRrl8Zf++Cxclv
   DF6Q+pYt0/Wuu25yo10gry6OKR+NCIInr0DaUq7OExH0ui4ds9iOJj83o
   ZMRrfBv/mzXm0xGWsBoOiSGQ/cHIELmbyiv0TMmjdBouGRooCoYVZmsMl
   pRjvz2XvqGzjiYuE9Bk6txyRfXohX2+mfUDoymxkSkKoRwhSbOXcohkkN
   vho9n05Bzsj6RpZ1Qgq/3+g3gKo742kv/xNK1auukvFh1n+gp8cjOSD9p
   pDu0Ea6uFBXTv6Gc1KnJVoaHtsVPl2R6EJd0K3R9jdGLF/hw+wWy+K/w4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="445666742"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="445666742"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:35:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="868646146"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="868646146"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:35:19 -0700
Date:   Fri, 15 Sep 2023 12:35:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH tty v1 06/74] serial: 8250: Use port lock wrappers
In-Reply-To: <20230914183831.587273-7-john.ogness@linutronix.de>
Message-ID: <2045de5e-b7f8-18fe-dc92-e1d88a62f810@linux.intel.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de> <20230914183831.587273-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023, John Ogness wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> When a serial port is used for kernel console output, then all
> modifications to the UART registers which are done from other contexts,
> e.g. getty, termios, are interference points for the kernel console.
> 
> So far this has been ignored and the printk output is based on the
> principle of hope. The rework of the console infrastructure which aims to
> support threaded and atomic consoles, requires to mark sections which
> modify the UART registers as unsafe. This allows the atomic write function
> to make informed decisions and eventually to restore operational state. It
> also allows to prevent the regular UART code from modifying UART registers
> while printk output is in progress.
> 
> All modifications of UART registers are guarded by the UART port lock,
> which provides an obvious synchronization point with the console
> infrastructure.
> 
> To avoid adding this functionality to all UART drivers, wrap the
> spin_[un]lock*() invocations for uart_port::lock into helper functions
> which just contain the spin_[un]lock*() invocations for now. In a
> subsequent step these helpers will gain the console synchronization
> mechanisms.
> 
> Converted with coccinelle. No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250_core.c |  12 ++--
>  drivers/tty/serial/8250/8250_port.c | 100 ++++++++++++++--------------
>  2 files changed, 56 insertions(+), 56 deletions(-)


> @@ -3403,9 +3403,9 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  	touch_nmi_watchdog();
>  
>  	if (oops_in_progress)
> -		locked = spin_trylock_irqsave(&port->lock, flags);
> +		locked = uart_port_trylock_irqsave(port, &flags);
>  	else
> -		spin_lock_irqsave(&port->lock, flags);
> +		uart_port_lock_irqsave(port, &flags);

Not related to any problem (with this patch) but I'm a bit curious is this 
construct going to remain there after the follow-up work? And there's the 
similar one in some other drivers (with some variations related to 
local_irq_save()):

        if (port->sysrq) {
                locked = 0;
        } else if (oops_in_progress) {
                locked = spin_trylock(&port->lock);
        } else {
                spin_lock(&port->lock);
                locked = 1;
        }


-- 
 i.



>  	/*
>  	 *	First save the IER then disable the interrupts
> @@ -3475,7 +3475,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  		serial8250_modem_status(up);
>  
>  	if (locked)
> -		spin_unlock_irqrestore(&port->lock, flags);
> +		uart_port_unlock_irqrestore(port, flags);
>  }
>  
>  static unsigned int probe_baud(struct uart_port *port)
> 
