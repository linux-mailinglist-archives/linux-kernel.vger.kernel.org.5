Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB0C7B787E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbjJDHOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjJDHOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:14:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284F2AC;
        Wed,  4 Oct 2023 00:14:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85A1C433C8;
        Wed,  4 Oct 2023 07:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696403681;
        bh=m/p7K2IFOIG74E7oqwH/WUHUmY/+kpgIUGYxIeReDzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmzeidEz6oct6O0sOTET90kRCSuaFqJwEDgllPvzjDUGhuboeanV/feQg0Q/iWJCv
         bypM0eZECkZcEGFL9wENMgyrMUkfXE/sVAKGlxcnClDsmHiFTIeHpVmMwPGZdZfeaG
         CuefXGfLSNmuT0lAiuE4k9e+P/Lq2sYWD1Wc0KZDqqZzhHP82E8PstP2Fl4x4dfnWi
         ipYhYTaI32aAUNDuyeFdbj6JbzQeUsuIv8v85iDbcfyEv8rvgUfRfLMFdsapGiHuGF
         8bviCT1Kn0qJ7xRcY2myuK8CTPxxkjmCloZwl8HGkZwAuexigzk4mPeTlDT6wmoNBD
         s5Uwoua4DFeoA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qnw5t-0000QG-22;
        Wed, 04 Oct 2023 09:14:53 +0200
Date:   Wed, 4 Oct 2023 09:14:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZR0Q7YUwgQV5TLhQ@hovoldconsulting.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <62d3678a-a23d-4619-95de-145026629ba8@gmail.com>
 <20231003121455.GB34982@atomide.com>
 <20231003122137.GC34982@atomide.com>
 <dc7af79d-bca8-4967-80fe-e90907204932@gmail.com>
 <20231004061708.GD34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004061708.GD34982@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 09:17:08AM +0300, Tony Lindgren wrote:
> * Maximilian Luz <luzmaximilian@gmail.com> [231003 22:09]:

> > Unfortunately that doesn't quite line up with what I can see on v6.5.5. The
> > serdev controller seems to be a child of dw-apb-uart.4, a platform device. The
> > serial-base and serdev devices are siblings. According to sysfs:
> > 
> >     /sys/bus/platform/devices/dw-apb-uart.4
> >     ├── driver -> ../../../../bus/platform/drivers/dw-apb-uart
> >     ├── subsystem -> ../../../../bus/platform
> >     │
> >     ├── dw-apb-uart.4:0
> >     │  ├── driver -> ../../../../../bus/serial-base/drivers/ctrl
> >     │  ├── subsystem -> ../../../../../bus/serial-base
> >     │  │
> >     │  └── dw-apb-uart.4:0.0
> >     │     ├── driver -> ../../../../../../bus/serial-base/drivers/port
> >     │     └── subsystem -> ../../../../../../bus/serial-base
> >     │
> >     └── serial0
> >        ├── subsystem -> ../../../../../bus/serial
> >        │
> >        └── serial0-0
> >           ├── driver -> ../../../../../../bus/serial/drivers/surface_serial_hub
> >           └── subsystem -> ../../../../../../bus/serial
> 
> The hierachy above is correct. Looks like I pasted the wrong device above,
> I meant dw-apb-uart.4, sorry about the extra confusion added. Eventually
> the serdev device could be a child of dw-apb-uart.4:0.0 at some point as
> it's specific to a serial port instance, but for now that should not be
> needed.
> 
> If serial0-0 is runtime PM active, then dw-apb-uart.4 is runtime PM active
> also unless ingore_children is set.
> 
> > Runtime suspend on serial0-0 is disabled/not set up at all. So I assume that if
> > it were a descendent of dw-apb-uart.4:0.0, things should have worked
> > out-of-the-box.
> 
> Hmm yes so maybe the issue is not with surface_serial_hub, but with serial
> port device being nable to resume after __device_suspend_late() has
> disabled runtime PM like you've been saying.
> 
> If the issue is with the serial port not being able to runtime resume, then
> the patch below should help. Care to give it a try?

> 8< ------------------
> diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
> --- a/drivers/tty/serial/serial_port.c
> +++ b/drivers/tty/serial/serial_port.c
> @@ -46,8 +46,27 @@ static int serial_port_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,
> -				 NULL, serial_port_runtime_resume, NULL);
> +/*
> + * Allow serdev devices to talk to hardware during system suspend.
> + * Assumes the serial port hardware controller device driver calls
> + * pm_runtime_force_suspend() and pm_runtime_force_resume() for
> + * system suspend as needed.
> + */
> +static int serial_port_prepare(struct device *dev)
> +{
> +	return pm_runtime_resume_and_get(dev);
> +}
> +
> +static void serial_port_complete(struct device *dev)
> +{
> +	pm_runtime_put_sync(dev);
> +}
> +
> +static const struct dev_pm_ops __maybe_unused serial_port_pm = {
> +	SET_RUNTIME_PM_OPS(NULL, serial_port_runtime_resume, NULL)
> +	.prepare = serial_port_prepare,
> +	.complete = serial_port_complete,
> +};
>  
>  static int serial_port_probe(struct device *dev)
>  {

Just a drive-by comment: The above looks like a too big of a hammer and
the wrong place to fix this.

The serdev runtime PM implementation is supposed to just work for serdev
drivers that do not want to use it, and otherwise those drivers manage
the runtime PM state of the serdev (serial) controller directly (e.g.
see c3bf40ce2c20 ("serdev: add controller runtime PM support")).

Without having time to look at this regression (or the rework) in
detail, it seems like the serial core rework has broken the serdev
runtime PM implementation if the serial controller is now suspended
without the serdev driver having asked for it.

The pm_runtime_get_sync() in serdev_device_open() is supposed to prevent
that from happening by default and if that now longer works, then that
needs to be fixed.

Johan
