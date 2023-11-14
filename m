Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C9B7EB863
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjKNVSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjKNVSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:18:31 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8F9CB;
        Tue, 14 Nov 2023 13:18:27 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d13ac2796so35356536d6.2;
        Tue, 14 Nov 2023 13:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699996707; x=1700601507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XB1eCxoA2vuTUBTuM8vj0+SNQVnxi+8b0Lh3KPIadtw=;
        b=PX+BSrgFgDaPvyd6dzA2OLCvc72/9iW/wJZNo04ou7jVvjjkSER9HqIkjquckM8k0a
         DjZ7DFo5fTJ0vGKz3DOxAVmX2/kHap2ECLsBj2g97hJ3abg/7rpeGri06aq1cS+AoGyJ
         dAOnOCTj8uNuH7nsSjBt9qMnWDfbBy1CTflv99C/GDqetLZExMdlRzK038YWfSmzaKUG
         aFRie79wvq3pHFeU3qMDdzwd5G9N38nknZfogUKyqAXQtT2P+tV0418DggdH8tB46LEy
         ig99ulunTlSJ7fXCRUAn0r5S5n/TFCmbrpW/C8Rldb5X8Tr6difi4GeynWgBi2L8bFGS
         VQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996707; x=1700601507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XB1eCxoA2vuTUBTuM8vj0+SNQVnxi+8b0Lh3KPIadtw=;
        b=izJ2Mk1MBenw8dAO0nzmOhgXK10/c+hViNbeyTHTmzElcTdcaGdJ3VbGLTGfQODZ5B
         M5FsmzaylPT+CYp8DKOYlWLH811EMtOT58DUKsO7ffGZeAy0w7M70/5d2pCZLwzAEKV6
         Yinb82yvMua/SOprF+hbN3VVK4AtjckX70a+RTpzHyGWpW9Ub7hUcGd3i6Lu/2JQ+o2l
         K18w98UNyHfbMlla6LB7j53EmLKTVezhZbNgG16rUjMcZ05hbyxKOyJTlL2Fqlc73cku
         lDCeRhYexd2UY5Ue83aA1d0nvKsJePizTwArNxIlmQOeX/6qC7/lFL+ore13t2kzCyMt
         XvNQ==
X-Gm-Message-State: AOJu0Yx40854Jj65kWfQh3v2yCiBWud5SPXfQfxDScF/OkBwhVOrA+FJ
        y/A0LYm7cFdz1RAEWYuGbaA=
X-Google-Smtp-Source: AGHT+IH5Oq9UPb4/sO5jkuaNKXwe9VywpTHHEQwboO5a7h25qwx6cGqHh+uzwICD8euB8Gjz7yadJg==
X-Received: by 2002:ad4:498d:0:b0:677:a207:8770 with SMTP id u13-20020ad4498d000000b00677a2078770mr3432190qvx.0.1699996706739;
        Tue, 14 Nov 2023 13:18:26 -0800 (PST)
Received: from google.com ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m10-20020a0cee4a000000b0066cf2423c79sm3217723qvs.139.2023.11.14.13.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:18:26 -0800 (PST)
Date:   Tue, 14 Nov 2023 21:18:24 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 2/3] gpiolib: Fix debug messaging in
 gpiod_find_and_request()
Message-ID: <ZVPkIOk6gvnwkp9F@google.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
 <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
 <ZTGBqEUzgGCcZP1B@google.com>
 <ZVOSd62yCz4lFIP1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVOSd62yCz4lFIP1@smile.fi.intel.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 05:29:59PM +0200, Andy Shevchenko wrote:
> On Thu, Oct 19, 2023 at 12:21:12PM -0700, Dmitry Torokhov wrote:
> > On Thu, Oct 19, 2023 at 08:34:56PM +0300, Andy Shevchenko wrote:
> > > When consolidating GPIO lookups in ACPI code, the debug messaging
> > > had been broken and hence lost a bit of sense. Restore debug
> > > messaging in gpiod_find_and_request() when configuring the GPIO
> > > line via gpiod_configure_flags().
> > 
> > Could you give an example of the before/after messages to show exavtly
> > what is being improved?
> 
> Before your patch:
> 
> [    5.266823] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> [   14.182994] gpio-40 (?): no flags found for gpios
> 
> After your patch:
> 
> [    5.085048] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> [   13.401402] gpio-40 (?): no flags found for (null)
> 
> After this patch:
> 
> [    3.871185] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> [   12.491998] gpio-40 (?): no flags found for gpios
> 
> ...
> 
> Looking at this it's definitely a fix.

If this ("(null)" vs static "gpios" string) is important, can we reduce
the patch to:

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 76e0c38026c3..b868c016a9be 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4151,7 +4151,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 
 	/* No particular flag request, return here... */
 	if (!(dflags & GPIOD_FLAGS_BIT_DIR_SET)) {
-		gpiod_dbg(desc, "no flags found for %s\n", con_id);
+		gpiod_dbg(desc, "no flags found for %s\n", con_id ?: "gpios");
 		return 0;
 	}
 

instead of plumbing the names through?

Although this (and the original fix patch) are losing information, in
the sense that "(null)" explicitly communicates that caller used
default/NULL conn_id, and not something like "gpios-gpios".

Thanks.

-- 
Dmitry
