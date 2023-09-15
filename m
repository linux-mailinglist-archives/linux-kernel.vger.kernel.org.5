Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227087A1A86
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjIOJ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjIOJ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:27:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF13E1700;
        Fri, 15 Sep 2023 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694770000; x=1726306000;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yl5Skd55X/lYjofp9pJE8uI3m8maxabpQwNbSQvXLsA=;
  b=IgrFkrYKxrRq/AUAD8qfLGIFFm/jyJUMfoSHwpwG3kP9mt96AcLaznVk
   FsWwak3+aM5+S0sfoct2ytIN5PZBXGIkb2py4VNInpH07zB+mSGe5Oh1u
   9PykF6pCDRTE1ps3Jf/9ELBkRPfUcT2M1rask3zev+k3H1be4+ZmJZIsx
   SCrSuL3+NF98gkXiTGY64qAdISZbbS26PQDeiijjzmde2P+YU+lejjT9A
   7i9PFhVuoc90uudmYwjo0dgSJ3F7wI8lto5+92043tIzkOChETWm9zKBa
   kcZBynP756Oqv6IZuTqfnIBgG6SRXgrrc1MmBv/PxLTHedn/t6JsZTW00
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378122551"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="378122551"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="888167296"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="888167296"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:26:03 -0700
Date:   Fri, 15 Sep 2023 12:26:35 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH tty v1 02/74] serial: core: Use lock wrappers
In-Reply-To: <20230914183831.587273-3-john.ogness@linutronix.de>
Message-ID: <bd5a9e3e-711a-ba47-e47a-e3fcf8812086@linux.intel.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de> <20230914183831.587273-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1914440644-1694769999=:2347"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1914440644-1694769999=:2347
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

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
>  include/linux/serial_core.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index f1d5c0d1568c..3091c62ec37b 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -1035,14 +1035,14 @@ static inline void uart_unlock_and_check_sysrq(struct uart_port *port)
>  	u8 sysrq_ch;
>  
>  	if (!port->has_sysrq) {
> -		spin_unlock(&port->lock);
> +		uart_port_unlock(port);
>  		return;
>  	}
>  
>  	sysrq_ch = port->sysrq_ch;
>  	port->sysrq_ch = 0;
>  
> -	spin_unlock(&port->lock);
> +	uart_port_unlock(port);
>  
>  	if (sysrq_ch)
>  		handle_sysrq(sysrq_ch);
> @@ -1054,14 +1054,14 @@ static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port
>  	u8 sysrq_ch;
>  
>  	if (!port->has_sysrq) {
> -		spin_unlock_irqrestore(&port->lock, flags);
> +		uart_port_unlock_irqrestore(port, flags);
>  		return;
>  	}
>  
>  	sysrq_ch = port->sysrq_ch;
>  	port->sysrq_ch = 0;
>  
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  	if (sysrq_ch)
>  		handle_sysrq(sysrq_ch);
> @@ -1077,12 +1077,12 @@ static inline int uart_prepare_sysrq_char(struct uart_port *port, u8 ch)
>  }
>  static inline void uart_unlock_and_check_sysrq(struct uart_port *port)
>  {
> -	spin_unlock(&port->lock);
> +	uart_port_unlock(port);
>  }
>  static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port,
>  		unsigned long flags)
>  {
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	uart_port_unlock_irqrestore(port, flags);
>  }
>  #endif	/* CONFIG_MAGIC_SYSRQ_SERIAL */
>  
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1914440644-1694769999=:2347--
