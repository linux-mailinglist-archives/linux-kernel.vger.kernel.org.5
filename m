Return-Path: <linux-kernel+bounces-133816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372B89A938
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A41B218F1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E59F208A1;
	Sat,  6 Apr 2024 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="LWXsbhf+"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB8200B7;
	Sat,  6 Apr 2024 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712382403; cv=none; b=Md2CaxG4O/rGpXORNqkp+gF9nM6U+1pIetrh+2WzaIHR7UqWmIolHO5Gh084zeo5t0cWE+MqrifNq25CXdstKM0v5XmYYFAt8Ce/xlaytzd0Pg21/hkaIpiouwQhCuKGE5bMMKx3P0HiJtS2CXVS5uZJJ8UBDIhBw4GOMG6P61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712382403; c=relaxed/simple;
	bh=vZ1pg4vbgxQBMvnUbk+bAxA9uplTaeoZ1SLa48DCmB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eueaiclsh+5VPRNd7Vplba18N6ZVHblPDGnl2HW2algqO3/M/1A8BNt+BIZDdzHXbjsAsMPq/dlF5LwpPkE9m7dDUtGaMkGxhlK5ESAbadFocQwQjFkB9XQcmmTcLbzbixi2QIdYzdYY6iBg+DTln3oR38jrD4wwr5w/YQDFhkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=LWXsbhf+; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 2E7F960339;
	Sat,  6 Apr 2024 05:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712382393;
	bh=vZ1pg4vbgxQBMvnUbk+bAxA9uplTaeoZ1SLa48DCmB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWXsbhf+CRF31iWm9i8TY/haZFCQ4mUaXjcmiYgOgkmpOyeyPMyw+8XkEXZUmWfM7
	 gQK8acTpyyUuEcyJfw5C7w5nwOM/HrfER0KzfJmq0su+FDxybx5cQTx+HUTyR1I0+/
	 s1RksCMZk4cbCes9uaQXFr53Fcy7Wb21E82hhlcNOOIBcs6iR88LJviCDNm7wIaDro
	 T9/Smwe7zfedweIw38ksX3DfZaY9BBgiGErRiK/5so9F/fN8exNCnlFyZ5zmWtVhMW
	 WUxvC9vunbNcLD6fhGrM80Jrhuv2gRwFILPOi5RfBbK17x2cBdKM33ceqQXkUBNKOD
	 Q2jQ5M3zv3P5w==
Date: Sat, 6 Apr 2024 08:46:17 +0300
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/1] serial: core: Clearing the circular buffer before
 NULLifying it
Message-ID: <20240406054617.GR5132@atomide.com>
References: <20240404150034.41648-1-andriy.shevchenko@linux.intel.com>
 <f0f200b0-34dc-430b-b55e-b133faf4db44@kernel.org>
 <ZhAWIThfejjbmj8u@smile.fi.intel.com>
 <ZhB9M8C9IhXtJIXR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhB9M8C9IhXtJIXR@smile.fi.intel.com>

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240405 22:37]:
> On Fri, Apr 05, 2024 at 06:17:54PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 05, 2024 at 07:25:03AM +0200, Jiri Slaby wrote:
> > > BTW cannot be x_char en/queued at that time too (the other check in the if)?
> > > But again, serial8250_start_tx() should not be called after shutdown().
> > 
> > Yes, and I have no clue how we can check this as startup can be called again
> > and so on. The PM callback is timer based AFAIU, meaning it may happen at any
> > time.

So below is an incomplete pseudo patch just showing where we could disable
tx for runtime PM.

The patch won't compile, and assumes we only disable tx for runtime PM.

However, if we need it elsewhere also, then we may want to set up some
UPF_TX_ENABLED type flag instead of serial_base_port specific calls.

My preference would be to limit it to serial_port.c if we can get away
with that.

Anybody have better ideas for enabling and disabling tx?

> > But do you agree that this patch has value on its own?
> 
> FWIW, https://lore.kernel.org/all/0000000000009e2dd805ffc595a3@google.com/T/

No objections from me for clearing the xmit. But should it also be done for
uart_shutdown() in addition to uart_tty_port_shutdown()?

Regards,

Tony

8< -----------------------
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -345,16 +345,23 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
 			bool init_hw)
 {
 	struct tty_port *port = &state->port;
+	struct uart_port *uport;
 	int retval;
 
 	if (tty_port_initialized(port))
-		return 0;
+		goto enable_tx;
 
 	retval = uart_port_startup(tty, state, init_hw);
-	if (retval)
+	if (retval) {
 		set_bit(TTY_IO_ERROR, &tty->flags);
+		return retval;
+	}
 
-	return retval;
+enable_tx:
+	uport = uart_port_check(state);
+	serial_base_port_enable_tx(uport);
+
+	return 0;
 }
 
 /*
@@ -377,6 +384,9 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 
+	if (uport)
+		serial_base_port_disable_tx(uport);
+
 	if (tty_port_initialized(port)) {
 		tty_port_set_initialized(port, false);
 
@@ -1821,6 +1831,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	uport->ops->stop_rx(uport);
 	uart_port_unlock_irq(uport);
 
+	serial_base_port_disable_tx(uport);
 	uart_port_shutdown(port);
 
 	/*

