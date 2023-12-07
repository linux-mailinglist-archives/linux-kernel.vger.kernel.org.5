Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5280813C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377682AbjLGGw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377826AbjLGGwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:52:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27F173C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:52:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA06C433C9;
        Thu,  7 Dec 2023 06:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701931924;
        bh=Jgvkdt55R4jwOTmeK7TgfLh1AEzeBbcP2a+N+0WhhKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCxkGoVtrKOxBDYbFXzbEwUrQaBkI55Mm1b+Pb1HCoor+OHtpzpFaJLxyDN339xgl
         svPqHzGtbUt8E5XKS/+UEvC2DJgk9VkzjktF5sVtRSEAfeyubq4qWFcm09cDcYLDXY
         rNdQa6gFxEdWWj51AMU9Y/LChTU74ukQcuaBesQA=
Date:   Thu, 7 Dec 2023 11:29:22 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Gow <davidgow@google.com>
Cc:     Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/4] kunit: Add APIs for managing devices
Message-ID: <2023120717-dangle-wrath-7bb3@gregkh>
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-1-635036d3bc13@google.com>
 <2023120602-vaguely-primarily-b6b2@gregkh>
 <CABVgOSnW7et1aonnsSLcS1LHHztXVyagAFe-U3=JX7c7xi2P4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSnW7et1aonnsSLcS1LHHztXVyagAFe-U3=JX7c7xi2P4g@mail.gmail.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:44:08PM +0800, David Gow wrote:
> > But really, why is this a "raw" device_driver pointer and not a pointer
> > to the driver type for your bus?
> 
> So, this is where the more difficult questions start (and where my
> knowledge of the driver model gets a bit shakier).
> 
> At the moment, there's no struct kunit_driver; the goal was to have
> whatever the minimal amount of infrastructure needed to get a 'struct
> device *' that could be plumbed through existing code which accepts
> it. (Read: mostly devres resource management stuff, get_device(),
> etc.)
> 
> So, in this version, there's no:
> - struct kunit_driver: we've no extra data to store / function
> pointers other than what's in struct device_driver.
> - The kunit_bus is as minimal as I could get it: each device matches
> exactly one driver pointer (which is passed as struct
> kunit_device->driver).
> - The 'struct kunit_device' type is kept private, and 'struct device'
> is used instead, as this is supposed to only be passed to generic
> device functions (KUnit is just managing its lifecycle).
> 
> I've no problem adding these extra types to flesh this out into a more
> 'normal' setup, though I'd rather keep the boilerplate on the user
> side minimal if possible. I suspect if we were to return a struct
> kunit_device, everyone would be quickly grabbing and passing around a
> raw 'struct device *' anyway, which is what the existing tests with
> fake devices do (via root_device_register, which returns struct
> device, or by returning &platform_device->dev from a helper).
> 
> Similarly, the kunit_bus is not ever exposed to test code, nor really
> is the driver (except via kunit_device_register_with_driver(), which
> isn't actually being used anywhere yet, so it may make sense to cut it
> out from the next version). So, ideally tests won't even be aware that
> their devices are attached to the kunit_bus, nor that they have
> drivers attached: it's mostly just to make these normal enough that
> they show up nicely in sysfs and play well with the devm_ resource
> management functions.

Ok, this makes more sense, thank you for the detailed explaination.
Making this "generic" like you have done here seems reasonable for now.

> > > -                                     attributes.o
> > > +                                     attributes.o \
> > > +                                     device.o
> >
> > Shouldn't this file be "bus.c" as you are creating a kunit bus?
> >
> 
> I've sort-of grouped this as "device helpers", as it handles KUnit
> devices, drivers, and the kunit_bus, but devices are the most
> user-facing part. Indeed, the bus feels like an 'implementation
> detail'. Happy to rename it if that makes things more consistent,
> though.

Nah, device.o makes sense for now, thanks.

> > >  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
> > >  kunit-objs +=                                debugfs.o
> > > diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> > > new file mode 100644
> > > index 000000000000..93ace1a2297d
> > > --- /dev/null
> > > +++ b/lib/kunit/device.c
> > > @@ -0,0 +1,176 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * KUnit basic device implementation
> >
> > "basic bus/driver implementation", not device, right?
> >
> 
> Given that the users of this really only care about getting their
> "device", and the bus/driver are more implementation details, I'd
> rather go with something like "KUnit-managed device implementation" or
> "KUnit device-model helpers". How do those sound?

Either would be good, thanks.

> > > + *
> > > + * Implementation of struct kunit_device helpers.
> > > + *
> > > + * Copyright (C) 2023, Google LLC.
> > > + * Author: David Gow <davidgow@google.com>
> > > + */
> > > +
> > > +#include <linux/device.h>
> > > +
> > > +#include <kunit/test.h>
> > > +#include <kunit/device.h>
> > > +#include <kunit/resource.h>
> > > +
> > > +
> > > +/* Wrappers for use with kunit_add_action() */
> > > +KUNIT_DEFINE_ACTION_WRAPPER(device_unregister_wrapper, device_unregister, struct device *);
> > > +KUNIT_DEFINE_ACTION_WRAPPER(driver_unregister_wrapper, driver_unregister, struct device_driver *);
> > > +
> > > +static struct device kunit_bus = {
> > > +     .init_name = "kunit"
> > > +};
> >
> > A static device as a bus?  This feels wrong, what is it for?  And where
> > does this live?  If you _REALLY_ want a single device for the root of
> > your bus (which is a good idea), then make it a dynamic variable (as it
> > is reference counted), NOT a static struct device which should not be
> > done if at all possible.
> 
> Will do. Would root_device_register() make more sense here?

Yes.

> > > +
> > > +/* A device owned by a KUnit test. */
> > > +struct kunit_device {
> > > +     struct device dev;
> > > +     struct kunit *owner;
> > > +     /* Force binding to a specific driver. */
> > > +     struct device_driver *driver;
> > > +     /* The driver is managed by KUnit and unique to this device. */
> > > +     bool cleanup_driver;
> > > +};
> >
> > Wait, why isn't your "kunit" device above a struct kunit_device
> > structure?  Why is it ok to be a "raw" struct device (hint, that's
> > almost never a good idea.)
> >
> > > +static inline struct kunit_device *to_kunit_device(struct device *d)
> > > +{
> > > +     return container_of(d, struct kunit_device, dev);
> >
> > container_of_const()?  And to use that properly, why not make this a #define?
> >
> > > +}
> > > +
> > > +static int kunit_bus_match(struct device *dev, struct device_driver *driver)
> > > +{
> > > +     struct kunit_device *kunit_dev = to_kunit_device(dev);
> > > +
> > > +     if (kunit_dev->driver == driver)
> > > +             return 1;
> > > +
> > > +     return 0;
> >
> > I don't understand, what are you trying to match here?
> >
> 
> This is just to make sure that the match function will use whatever
> driver is passed through. When I originally started writing this,
> there were some resource cleanup problems if there was no driver
> associated with a device, though that's fixed now.

As it's fixed, no need for this, so let's not be confused going forward :)

thanks,

greg k-h
