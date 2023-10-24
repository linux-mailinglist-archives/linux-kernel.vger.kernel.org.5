Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104427D5032
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjJXMsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjJXMsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:48:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF41D90;
        Tue, 24 Oct 2023 05:48:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB66C433C8;
        Tue, 24 Oct 2023 12:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698151716;
        bh=LnrL2yfzGVg4sIenkOpUYqQHA/djZgb+WbIlUzSlrJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9nueoFl1ofosx00OlKeHdcbGrbWORJpO+SiMaF+Knb+VCDG24zZewxxMTT+D6Mvr
         jYZHvrFGnt5hjRtgOreucZunIKkCmwQ23hDfzvI74Ggt8rSZIf425uPZpIp7SiK5eO
         bu3nPbziYKnRsjQpxT+5xKpGnb3eyZtKsdihyHnbURRc2j1dzEGuvtBLNuKD+ErI77
         2FEdYIlEeQ5RIs1iOgvuMI0EXnX8dwwtcADLSPI2dR/B7QD/6CiYmr7p6rZl43u0w2
         kDXdajp7YyIJkM3VAeURsGk3cmmNhP3ya0526fFlNnTC5pFup1PGVyHSEdol8/ZdRO
         NsAxkimHrjK4Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvGq5-0005c4-1L;
        Tue, 24 Oct 2023 14:48:53 +0200
Date:   Tue, 24 Oct 2023 14:48:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children
 of serial core port device
Message-ID: <ZTe9NdS160EU1RJJ@hovoldconsulting.com>
References: <20231024113624.54364-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024113624.54364-1-tony@atomide.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 02:36:18PM +0300, Tony Lindgren wrote:
> Let's move tty and serdev controller to be children of the serial core port
> device. This way the runtime PM usage count of a child device propagates
> to the serial hardware device.

> The tty device moves happily with just a change of the parent device.

> @@ -3153,7 +3153,8 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
>  	 * setserial to be used to alter this port's parameters.
>  	 */
>  	tty_dev = tty_port_register_device_attr_serdev(port, drv->tty_driver,
> -			uport->line, uport->dev, port, uport->tty_groups);
> +			uport->line, uport->dev, &uport->port_dev->dev, port,
> +			uport->tty_groups);
>  	if (!IS_ERR(tty_dev)) {
>  		device_set_wakeup_capable(tty_dev, 1);
>  	} else {

>  struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
>                 struct tty_driver *driver, unsigned index,
> -               struct device *device, void *drvdata,
> +               struct device *host, struct device *parent, void *drvdata,
>                 const struct attribute_group **attr_grp)
>  {
>         struct device *dev;
> 
>         tty_port_link_device(port, driver, index);
> 
> -       dev = serdev_tty_port_register(port, device, driver, index);
> +       dev = serdev_tty_port_register(port, host, parent, driver, index);
>         if (PTR_ERR(dev) != -ENODEV) {
>                 /* Skip creating cdev if we registered a serdev device */
>                 return dev;
>         }
> 
> -       return tty_register_device_attr(driver, index, device, drvdata,
> +       return tty_register_device_attr(driver, index, parent, drvdata,
>                         attr_grp);
>  }

Looks like this patch breaks the wakeup-irq hack in uart_suspend_port():

	tty_dev = device_find_child(uport->dev, &match, serial_match_port);
	if (tty_dev && device_may_wakeup(tty_dev)) {
		enable_irq_wake(uport->irq);
		put_device(tty_dev);
		mutex_unlock(&port->mutex);
		return 0;
	}

There may be more of these hard-coded assumptions, this one I happened
to be aware of.

Johan
