Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17F57EBAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjKOBiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOBiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:38:06 -0500
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92720D1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 17:38:03 -0800 (PST)
Received: from localhost (88-113-24-34.elisa-laajakaista.fi [88.113.24.34])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 9b57977f-8357-11ee-b972-005056bdfda7;
        Wed, 15 Nov 2023 03:37:59 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Wed, 15 Nov 2023 03:37:58 +0200
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 2/3] gpiolib: Fix debug messaging in
 gpiod_find_and_request()
Message-ID: <ZVQg9hTQwGtNwIhv@surfacebook.localdomain>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
 <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
 <ZTGBqEUzgGCcZP1B@google.com>
 <ZVOSd62yCz4lFIP1@smile.fi.intel.com>
 <ZVPkIOk6gvnwkp9F@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVPkIOk6gvnwkp9F@google.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Nov 14, 2023 at 09:18:24PM +0000, Dmitry Torokhov kirjoitti:
> On Tue, Nov 14, 2023 at 05:29:59PM +0200, Andy Shevchenko wrote:
> > On Thu, Oct 19, 2023 at 12:21:12PM -0700, Dmitry Torokhov wrote:
> > > On Thu, Oct 19, 2023 at 08:34:56PM +0300, Andy Shevchenko wrote:


> > > > When consolidating GPIO lookups in ACPI code, the debug messaging
> > > > had been broken and hence lost a bit of sense. Restore debug
> > > > messaging in gpiod_find_and_request() when configuring the GPIO
> > > > line via gpiod_configure_flags().
> > > 
> > > Could you give an example of the before/after messages to show exavtly
> > > what is being improved?
> > 
> > Before your patch:
> > 
> > [    5.266823] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> > [   14.182994] gpio-40 (?): no flags found for gpios
> > 
> > After your patch:
> > 
> > [    5.085048] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> > [   13.401402] gpio-40 (?): no flags found for (null)
> > 
> > After this patch:
> > 
> > [    3.871185] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> > [   12.491998] gpio-40 (?): no flags found for gpios
> > 
> > ...
> > 
> > Looking at this it's definitely a fix.
> 
> If this ("(null)" vs static "gpios" string) is important, can we reduce
> the patch to:
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 76e0c38026c3..b868c016a9be 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4151,7 +4151,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
>  
>  	/* No particular flag request, return here... */
>  	if (!(dflags & GPIOD_FLAGS_BIT_DIR_SET)) {
> -		gpiod_dbg(desc, "no flags found for %s\n", con_id);
> +		gpiod_dbg(desc, "no flags found for %s\n", con_id ?: "gpios");
>  		return 0;
>  	}
>  
> 
> instead of plumbing the names through?

Definitely no, because how can you guess that this is "gpios" and not "gpio"?

> Although this (and the original fix patch) are losing information, in
> the sense that "(null)" explicitly communicates that caller used
> default/NULL conn_id, and not something like "gpios-gpios".

This is not true, there was no such information before your patch and NULL
pointer printing is simply a bad style programming. We already had the cases
when users were scary by "NULL device *" and other similar stuff when it's
practically no problems in the flow. This has to be fixed anyway.

And what's the practical meaning of gpios-gpios / gpio-gpios / gpios-gpio /
gpio-gpio? I believe they are so weird that thinking about them would be lowest
priority over the issues with the messaging there.

-- 
With Best Regards,
Andy Shevchenko


