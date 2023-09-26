Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E7C7AE726
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjIZHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjIZHvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:51:42 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21C0DC;
        Tue, 26 Sep 2023 00:51:34 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2842A240008;
        Tue, 26 Sep 2023 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695714693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7a5K1aAKuIj2iEvxprQZUE+LucC50eyHmU2MT85uylA=;
        b=CLGB9apBwexIdVNECBBS9V0PnB4y8ocCvgQ4qFRIbu8UcFc7sir6TV0M3ws76qKGl/siSa
        psuC7TAJwEoNrX55Q5evdslyP+wSjOssom4UVXPNEbANZQotVuc33ajteUO925Yfx9VIVk
        LML9KPYSLVrKntr/wk5Vd0GHBbRMgz1RNiBb6ISY48qpuiNHLYRQf4W++QB/JsiT9r4w/8
        9HNz95+c1GMD7CnFgYYsekmY/YKRbOSUqjrrOf5jcxY0vwSqvBn3rL3ofJBslsM4UZ8dYe
        hP2B62LTdH+WfPXlXUDJ7xEB4BO/0NxdOBJucRQxpWkaTdNvehw022yAq0f5MQ==
Message-ID: <652eb018-8e67-5f4b-8329-0f52159a27b1@bootlin.com>
Date:   Tue, 26 Sep 2023 09:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] serial: 8250_omap: Fix errors with no_console_suspend
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Udit Kumar <u-kumar1@ti.com>
References: <20230926061319.15140-1-tony@atomide.com>
From:   Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20230926061319.15140-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Thanks for the fix.

On 9/26/23 08:13, Tony Lindgren wrote:
> We now get errors on system suspend if no_console_suspend is set as
> reported by Thomas. The errors started with commit 20a41a62618d ("serial:
> 8250_omap: Use force_suspend and resume for system suspend").
> 
> Let's fix the issue by checking for console_suspend_enabled in the system
> suspend and resume path.
> 
> Note that with this fix the checks for console_suspend_enabled in
> omap8250_runtime_suspend() become useless. We now keep runtime PM usage
> count for an attached kernel console starting with commit bedb404e91bb
> ("serial: 8250_port: Don't use power management for kernel console").
> 
> Fixes: 20a41a62618d ("serial: 8250_omap: Use force_suspend and resume for system suspend")
> Cc: Udit Kumar <u-kumar1@ti.com>
> Reported-by: Thomas Richard <thomas.richard@bootlin.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tested-by: Thomas Richard <thomas.richard@bootlin.com>

> ---
>  drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1617,7 +1617,7 @@ static int omap8250_suspend(struct device *dev)
>  {
>  	struct omap8250_priv *priv = dev_get_drvdata(dev);
>  	struct uart_8250_port *up = serial8250_get_port(priv->line);
> -	int err;
> +	int err = 0;
>  
>  	serial8250_suspend_port(priv->line);
>  
> @@ -1627,7 +1627,8 @@ static int omap8250_suspend(struct device *dev)
>  	if (!device_may_wakeup(dev))
>  		priv->wer = 0;
>  	serial_out(up, UART_OMAP_WER, priv->wer);
> -	err = pm_runtime_force_suspend(dev);
> +	if (uart_console(&up->port) && console_suspend_enabled)
> +		err = pm_runtime_force_suspend(dev);
>  	flush_work(&priv->qos_work);
>  
>  	return err;
> @@ -1636,11 +1637,15 @@ static int omap8250_suspend(struct device *dev)
>  static int omap8250_resume(struct device *dev)
>  {
>  	struct omap8250_priv *priv = dev_get_drvdata(dev);
> +	struct uart_8250_port *up = serial8250_get_port(priv->line);
>  	int err;
>  
> -	err = pm_runtime_force_resume(dev);
> -	if (err)
> -		return err;
> +	if (uart_console(&up->port) && console_suspend_enabled) {
> +		err = pm_runtime_force_resume(dev);
> +		if (err)
> +			return err;
> +	}
> +
>  	serial8250_resume_port(priv->line);
>  	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
>  	pm_runtime_mark_last_busy(dev);
> @@ -1717,16 +1722,6 @@ static int omap8250_runtime_suspend(struct device *dev)
>  
>  	if (priv->line >= 0)
>  		up = serial8250_get_port(priv->line);
> -	/*
> -	 * When using 'no_console_suspend', the console UART must not be
> -	 * suspended. Since driver suspend is managed by runtime suspend,
> -	 * preventing runtime suspend (by returning error) will keep device
> -	 * active during suspend.
> -	 */
> -	if (priv->is_suspending && !console_suspend_enabled) {
> -		if (up && uart_console(&up->port))
> -			return -EBUSY;
> -	}
>  
>  	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
>  		int ret;
-- 
Thomas Richard

