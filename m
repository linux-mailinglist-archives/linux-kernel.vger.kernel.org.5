Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4D7BA993
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjJES5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjJES5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:57:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED5510B;
        Thu,  5 Oct 2023 11:57:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848FCC433CA;
        Thu,  5 Oct 2023 18:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696532223;
        bh=gizQqh1m+4W+weyiowQQxLoR5ACpd0WvekMq4t9ZbJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B31dv1Ow/PkeVGqh25lYleAADB7Ut8jocSfbrUqZPHTdnwIaORG0Gk7A/xL/4ef5q
         wRSo/qIEbk2Dewt/rEMKRmPyl0jnwcCgsF3E6OV+zFncxXb5Z27cp1QjI6eDybI9xY
         Fc4b7a+lq16Bx8Si3GQXqm+Yn4YdkFfSZ9WBgWbw=
Date:   Thu, 5 Oct 2023 20:57:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4 5/5] drivers/tty/serial: add ESP32S3 ACM device driver
Message-ID: <2023100544-rendering-identify-e0ad@gregkh>
References: <20230928151631.149333-1-jcmvbkbc@gmail.com>
 <20230928151631.149333-6-jcmvbkbc@gmail.com>
 <2023100326-crushing-septic-4856@gregkh>
 <CAMo8BfJgpP-=tNEChcyR3z6i_QeJ9Ywq7EOjjC5i7Uq4OrgXNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfJgpP-=tNEChcyR3z6i_QeJ9Ywq7EOjjC5i7Uq4OrgXNA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 12:46:46PM -0700, Max Filippov wrote:
> > > Hardware specification is available at the following URL:
> > >
> > >   https://www.espressif.com/sites/default/files/documentation/esp32-s3_technical_reference_manual_en.pdf
> > >   (Chapter 33 USB Serial/JTAG Controller)
> >
> > I don't understand this driver, "ACM" is a USB host <-> gadget protocol,
> > why do you need a platform serial driver for this?
> 
> The USB part of this piece of hardware is fixed and not controllable, so
> all we have is a very limited UART interface. But to the outside world
> it's a USB device with the CDC-ACM interface.

Where is the "outside world" here?  The other end of the tty connection?
So this is a "ACM gadget"?  If so, please try to use that term as that's
what we use in the kernel to keep things straight.

> > > diff --git a/drivers/tty/serial/esp32_acm.c b/drivers/tty/serial/esp32_acm.c
> > > new file mode 100644
> > > index 000000000000..f02abd2ac65e
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/esp32_acm.c
> > > @@ -0,0 +1,459 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> >
> > Why "or later"?  I have to ask, sorry.
> 
> I don't really have a preference here. Is there a reason to choose
> GPL-2.0 only for a new code?

It's your call, you need to pick that, but I can provide recommendations
if you want :)

> > And no copyright information?  That's fine, but be sure your company's
> > lawyers are ok with it...
> 
> There's no company behind this, just myself.

Great, it's your copyright, be proud, put it on there!

> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/console.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/io.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/serial_core.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/tty_flip.h>
> > > +#include <asm/serial.h>
> > > +
> > > +#define DRIVER_NAME  "esp32s3-acm"
> > > +#define DEV_NAME     "ttyACM"
> >
> > There is already a ttyACM driver in the kernel, will this conflict with
> > that one?  And are you using the same major/minor numbers for it as
> > well?  If so, how is this going to work?
> 
> I'll rename it to ttyS. I see that it coexists with the other driver that calls
> its devices ttyS just fine.

Great.  But if you are going to be like a ACM gadget, use ttyGS like
that driver does?

> > > +static void esp32s3_acm_set_mctrl(struct uart_port *port, unsigned int mctrl)
> > > +{
> > > +}
> >
> > Do you have to have empty functions for callbacks that do nothing?
> 
> The serial core has unconditional calls to these callbacks.

Ah, good catch, maybe we should fix up the serial core.

> > > --- a/include/uapi/linux/serial_core.h
> > > +++ b/include/uapi/linux/serial_core.h
> > > @@ -248,4 +248,7 @@
> > >  /* Espressif ESP32 UART */
> > >  #define PORT_ESP32UART       124
> > >
> > > +/* Espressif ESP32 ACM */
> > > +#define PORT_ESP32ACM        125
> >
> > Why are these defines needed?  What in userspace is going to require
> > them?  If nothing, please do not add them.
> 
> I don't understand what the alternatives are. The comment for the
> uart_ops::config_port() callback says that port->type should be set
> to the type of the port found, and I see that almost every serial driver
> defines a unique PORT_* for that.

Yes, but not all do.  If you don't need to do anything special, it can
just claim to be a normal device, we've had threads about this on the
list before.  If you don't need to determine in userspace from the tty
connection what device it is, just use the default one instead.

thanks,

greg k-h
