Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06697F8153
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjKXS53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKXS51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:57:27 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ABB1FDB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:57:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r6bMl-0007D6-1n; Fri, 24 Nov 2023 19:57:27 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r6bMj-00BKHf-VY; Fri, 24 Nov 2023 19:57:25 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r6bMj-003gIb-Sq; Fri, 24 Nov 2023 19:57:25 +0100
Date:   Fri, 24 Nov 2023 19:57:25 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <20231124185725.GA872366@pengutronix.de>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023112453-flagstick-bullring-8511@gregkh>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:26:30PM +0000, Greg Kroah-Hartman wrote:
> On Fri, Nov 24, 2023 at 05:32:34PM +0100, Oleksij Rempel wrote:
> > On Fri, Nov 24, 2023 at 03:56:19PM +0000, Greg Kroah-Hartman wrote:
> > > On Fri, Nov 24, 2023 at 03:49:46PM +0000, Mark Brown wrote:
> > > > On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
> > > > > On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
> > > > 
> > > > > > This came out of some discussions about trying to handle emergency power
> > > > > > failure notifications.
> > > > 
> > > > > I'm sorry, but I don't know what that means.  Are you saying that the
> > > > > kernel is now going to try to provide a hard guarantee that some devices
> > > > > are going to be shut down in X number of seconds when asked?  If so, why
> > > > > not do this in userspace?
> > > > 
> > > > No, it was initially (or when I initially saw it anyway) handling of
> > > > notifications from regulators that they're in trouble and we have some
> > > > small amount of time to do anything we might want to do about it before
> > > > we expire.
> > > 
> > > So we are going to guarantee a "time" in which we are going to do
> > > something?  Again, if that's required, why not do it in userspace using
> > > a RT kernel?
> > 
> > For the HW in question I have only 100ms time before power loss. By
> > doing it over use space some we will have even less time to react.
> 
> Why can't userspace react that fast?  Why will the kernel be somehow
> faster?  Speed should be the same, just get the "power is cut" signal
> and have userspace flush and unmount the disk before power is gone.  Why
> can the kernel do this any differently?
> 
> > In fact, this is not a new requirement. It exist on different flavors of
> > automotive Linux for about 10 years. Linux in cars should be able to
> > handle voltage drops for example on ignition and so on. The only new thing is
> > the attempt to mainline it.
> 
> But your patch is not guaranteeing anything, it's just doing a "I want
> this done before the other devices are handled", that's it.  There is no
> chance that 100ms is going to be a requirement, or that some other
> device type is not going to come along and demand to be ahead of your
> device in the list.
> 
> So you are going to have a constant fight among device types over the
> years, and people complaining that the kernel is now somehow going to
> guarantee that a device is shutdown in a set amount of time, which
> again, the kernel can not guarantee here.
> 
> This might work as a one-off for a specific hardware platform, which is
> odd, but not anything you really should be adding for anyone else to use
> here as your reasoning for it does not reflect what the code does.

I see. Good point.

In my case umount is not needed, there is not enough time to write down
the data. We should send a shutdown command to the eMMC ASAP.

@Ulf, are there a way request mmc shutdown from user space?
If I see it correctly, sysfs-devices-power-control support only "auto" and
"on". Unbinding the module will not execute MMC shutdown notification.
If user space is the way to go, do sysfs-devices-power-control "off"
command will be acceptable?

The other option I have is to add a regulator event handler to the MMC
framework and do shutdown notification on under-voltage event.

Are there other options?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
