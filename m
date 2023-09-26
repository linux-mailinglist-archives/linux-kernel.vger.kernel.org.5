Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A077AEB86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjIZLdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZLdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:33:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69CEE9;
        Tue, 26 Sep 2023 04:33:07 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QBWhw9043460;
        Tue, 26 Sep 2023 06:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695727963;
        bh=KlSQQh3u11EgpSDDbXEWrJRLshXYW6EsKo55WM7AJz8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tSj+Hw5BATfgv84LpCnwE79TwBXvS4NbAKFfPstIsKcPTWNfhRAYo3KGXUdoQhNBC
         NSmtIv99ONltmsl0rPA7IJUjNtodgMj0HyAzlciWRIM/+yp3OkVLYbvlbgDJe6cRWV
         Bu1uSOXLlJgYGhSad1RLg4XBZnS/xGODUSdnGgSQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QBWh5C064580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 06:32:43 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 06:32:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 06:32:43 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QBWfp9080419;
        Tue, 26 Sep 2023 06:32:42 -0500
Date:   Tue, 26 Sep 2023 17:02:41 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Thomas Richard <thomas.richard@bootlin.com>
CC:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] serial: 8250_omap: Fix errors with no_console_suspend
Message-ID: <20230926113241.ws2tco3poeixhupi@dhruva>
References: <20230926061319.15140-1-tony@atomide.com>
 <652eb018-8e67-5f4b-8329-0f52159a27b1@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <652eb018-8e67-5f4b-8329-0f52159a27b1@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2023 at 09:51:30 +0200, Thomas Richard wrote:
> Hi Tony,
> 
> Thanks for the fix.
> 
> On 9/26/23 08:13, Tony Lindgren wrote:
> > We now get errors on system suspend if no_console_suspend is set as
> > reported by Thomas. The errors started with commit 20a41a62618d ("serial:
> > 8250_omap: Use force_suspend and resume for system suspend").
> > 
> > Let's fix the issue by checking for console_suspend_enabled in the system
> > suspend and resume path.
> > 
> > Note that with this fix the checks for console_suspend_enabled in
> > omap8250_runtime_suspend() become useless. We now keep runtime PM usage
> > count for an attached kernel console starting with commit bedb404e91bb
> > ("serial: 8250_port: Don't use power management for kernel console").
> > 
> > Fixes: 20a41a62618d ("serial: 8250_omap: Use force_suspend and resume for system suspend")
> > Cc: Udit Kumar <u-kumar1@ti.com>
> > Reported-by: Thomas Richard <thomas.richard@bootlin.com>

Don't we want a closes: tag?

> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Tested-by: Thomas Richard <thomas.richard@bootlin.com>

Thanks for testing Thomas

> 
> > ---
> >  drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++---------------
> >  1 file changed, 10 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> > --- a/drivers/tty/serial/8250/8250_omap.c
> > +++ b/drivers/tty/serial/8250/8250_omap.c
> > @@ -1617,7 +1617,7 @@ static int omap8250_suspend(struct device *dev)
> >  {
> >  	struct omap8250_priv *priv = dev_get_drvdata(dev);
> >  	struct uart_8250_port *up = serial8250_get_port(priv->line);
> > -	int err;
> > +	int err = 0;
> >  
> >  	serial8250_suspend_port(priv->line);
> >  
> > @@ -1627,7 +1627,8 @@ static int omap8250_suspend(struct device *dev)
> >  	if (!device_may_wakeup(dev))
> >  		priv->wer = 0;
> >  	serial_out(up, UART_OMAP_WER, priv->wer);
> > -	err = pm_runtime_force_suspend(dev);
> > +	if (uart_console(&up->port) && console_suspend_enabled)
> > +		err = pm_runtime_force_suspend(dev);
> >  	flush_work(&priv->qos_work);
> >  
> >  	return err;
> > @@ -1636,11 +1637,15 @@ static int omap8250_suspend(struct device *dev)
> >  static int omap8250_resume(struct device *dev)
> >  {
> >  	struct omap8250_priv *priv = dev_get_drvdata(dev);
> > +	struct uart_8250_port *up = serial8250_get_port(priv->line);
> >  	int err;
> >  
> > -	err = pm_runtime_force_resume(dev);
> > -	if (err)
> > -		return err;
> > +	if (uart_console(&up->port) && console_suspend_enabled) {
> > +		err = pm_runtime_force_resume(dev);
> > +		if (err)
> > +			return err;
> > +	}

LGTM, thanks for the fix Tony.

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> > +
> >  	serial8250_resume_port(priv->line);
> >  	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
> >  	pm_runtime_mark_last_busy(dev);
> > @@ -1717,16 +1722,6 @@ static int omap8250_runtime_suspend(struct device *dev)
> >  
> >  	if (priv->line >= 0)
> >  		up = serial8250_get_port(priv->line);
> > -	/*
> > -	 * When using 'no_console_suspend', the console UART must not be
> > -	 * suspended. Since driver suspend is managed by runtime suspend,
> > -	 * preventing runtime suspend (by returning error) will keep device
> > -	 * active during suspend.
> > -	 */
> > -	if (priv->is_suspending && !console_suspend_enabled) {
> > -		if (up && uart_console(&up->port))
> > -			return -EBUSY;
> > -	}
> >  
> >  	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
> >  		int ret;
> -- 
> Thomas Richard
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
