Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF3D788205
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbjHYI0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbjHYI0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FF519AD;
        Fri, 25 Aug 2023 01:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF44B62450;
        Fri, 25 Aug 2023 08:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F02C433C8;
        Fri, 25 Aug 2023 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692951979;
        bh=ts5HB3fsEAvz/IHDvRXzAguzRjGtOKEZeGKIr2Jrr1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctm6F/jH3AqMWKu0TLsONGa9iQ2O+BSpeT3Z11mO4oibVN5lJU+BJSsMWxjfLO9+y
         SXvYWgibzLj085+QV9NveefiiipdZ+80gLYhnvt9D03Rj8lUFDCoVCZ0A7XRyBN7U6
         YpR36vh+tgOB2CCSRSYy7KOWzkP/4eBXmG1xKYfg=
Date:   Thu, 24 Aug 2023 21:22:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Simon Arlott <simon@octiron.net>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] USB: cdc-acm: expose serial close_delay and closing_wait
 in sysfs
Message-ID: <2023082442-arose-jitters-00bb@gregkh>
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <2023082403-masculine-scuttle-f0ad@gregkh>
 <d313a1a9-833e-981e-b9d7-920989458d37@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d313a1a9-833e-981e-b9d7-920989458d37@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 07:02:40PM +0100, Simon Arlott wrote:
> On 24/08/2023 15:48, Greg Kroah-Hartman wrote:
> > On Wed, Aug 23, 2023 at 09:37:45PM +0100, Simon Arlott wrote:
> >> This can happen with the ESP32-H2/ESP32-C6 USB serial interface. Instead of
> >> changing all userspace applications to flush (discard) their output in this
> >> specific scenario it would be easier to adjust the closing_wait timeout
> >> with udev rules but the only available interface is the TIOCGSERIAL ioctl.
> > 
> > Then why not use that?
> 
> It's not practical to use TIOCGSERIAL from a udev rule. Instead of a
> sysfs attribute (that udev has built-in support for writing) it would
> require a separate compiled process or other non-trivial dependencies
> (e.g. Python) to modify the closing_wait value. There's no shell script
> support for read-modify-write of a complex ioctl struct.

It's this way for all serial ports, cdc-acm is not "special" here,
sorry.

> The ioctl can't be used without opening and closing the tty, which has
> side effects. On open() it'll raise DTR/RTS and activate it. For cdc-acm
> that will indicate to the device that the serial port has been opened
> which will be visible to the software running on the USB device. On
> close() it'll be delayed by the close_delay if any process is currently
> doing a blocking open() and there's no carrier, then the closing_wait
> time if there's been any incomplete transmitted data (by any process).
> 
> I want to be able to automatically set close_delay to 0 and closing_wait
> to 65535 ("no waiting") on all USB serial devices without these kind of
> side effects. I'm sure these have a purpose when connected to a real tty
> but forcing a process to wait 30 seconds before it can close the port
> (or exit) if the USB device isn't reading data properly is inconvenient.
> 
> Those two values require CAP_SYS_ADMIN to modify (which is separately
> enforced by many of the tty drivers) so user applications can't change
> them even if they're aware of them.

So this looks like you feel there should be a way to modify serial port
values without the ioctl api.  That's good, maybe we do need to do this,
but then, if so, it needs to happen for all serial ports, not just one
single device type.

Note that the tty api is really really old, so modifications and
enhancements need to be done carefully.  And be sure that there isn't
already another way to do this.  The open/close DTR/RTS issue has been
brought up many times, and I thought that there was ways to prevent it
already, are you sure that modern tools don't already take this into
consideration?

Or better yet, don't make any change until you actually open the port
for access.  Why wory about these values until you need to use it?  Why
insist on doing it from a udev rule when there is no real user of the
port yet?  Who are you setting the port up for, and why can't they do it
when they open and set the other values that they want?

> > If any apis are needed, let's make them for all tty devices, through the
> > existing ioctl api, so they work for all devices and userspace doesn't
> > have to try to figure out just exactly what type of tty/serial device it
> > is talking to (as that will not scale and is exactly the opposite of
> > what common apis are for.)
> 
> Are you ok with adding the same two attributes to sysfs for all ttys?

Why just these attributes, why not tty settings?  :)

> I'd use a different name (appending "_centisecs") because serial_core
> already uses those names on the tty device and I think it's better to
> define "infinite wait" and "no wait" as -1 and 0 instead of 0 and 65535.

Ah, so this already is an api?  Or is it a different one?

confused,

greg k-h
