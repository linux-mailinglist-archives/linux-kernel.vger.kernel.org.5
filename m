Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3F7FD09F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjK2IXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2IXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:23:48 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37C19B1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:23:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bc39dcbcbso896197e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701246232; x=1701851032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7+haveSoq7m2f2Pj8HBweyY+n64mswSOvsdXSe1aV8=;
        b=hjdvXDGDD08RCKyP1WgixBq2jpGt75z1x6E/hpnjKvO7mKkV9cul30JkBYKnQ8FVV3
         rL9BZ0tLuidlItrJOCVz+4pzpl7A9pD0LR0NcsdWdJlcMg9fYT+1y52vF+S345lXc8Da
         Gxql1X2l8GdOWSv/ZL9gGe2uMW7kc2aPHmfko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701246232; x=1701851032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7+haveSoq7m2f2Pj8HBweyY+n64mswSOvsdXSe1aV8=;
        b=iYB7kNMfyk6eiVaMnqB3KLkHeDV/E6Z+Z/oeD2S8+EmWS31SFgxQgmYtMTQFwyeBoN
         gpiks4vVf5s5Dm3aeNzK7ACepdodhD68JXVFHLXya3nY1MsfT+FFERl7G1eTZshy0pDC
         aTJcbMvTPTW1n9xQ6kKO2Na+PJpBMnHTMB6eC6hR0YPp8/jGdiCnxj/dv0ve1vZxdlaK
         GDnNpHk7TDy+hDpxhUZdbFGKSi9sgkNQkCSQNoMW/uBeAF4NrnTc/HRLIflrWJ+CjiJZ
         6crs/L+irPWUTH6JNro6laeXS1zdr/lTHEBLKYxsuHpsVg6rv98vuAbz6/CyuOw3OxLM
         G/1w==
X-Gm-Message-State: AOJu0Yxbaj4thVAiE+oeWv0NaOb86I0RNR3RARshbVVG6yZBJDTwkj4D
        SQT/l4RK9RrQRwqDg+obpzH6ZAtP9fGuH2ykYsRdKw==
X-Google-Smtp-Source: AGHT+IEtWhB/1EU4Pgqrnwxww3bANfSl0NJ1NAjrSVHkHzZ34kpFTEDs7eij5sHcmcrKNah8R2KVsBjvlDihDkrrAjY=
X-Received: by 2002:a05:6512:3081:b0:507:a1dd:5a86 with SMTP id
 z1-20020a056512308100b00507a1dd5a86mr12720343lfd.13.1701246232561; Wed, 29
 Nov 2023 00:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20231128084236.157152-1-wenst@chromium.org> <20231128084236.157152-4-wenst@chromium.org>
 <ZWYUi3Q5ptQXR0uQ@smile.fi.intel.com>
In-Reply-To: <ZWYUi3Q5ptQXR0uQ@smile.fi.intel.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 29 Nov 2023 16:23:41 +0800
Message-ID: <CAGXv+5EG4wO2sD0f_j1VDTkOcyN46oyfTYs3nf7cP7xFPg1fYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/5] platform/chrome: Introduce device tree
 hardware prober
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wolfram Sang <wsa@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hovold <johan@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linus.walleij@linaro.org,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, james.clark@arm.com, james@equiv.tech,
        keescook@chromium.org, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:26=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 28, 2023 at 04:42:32PM +0800, Chen-Yu Tsai wrote:
> > Some devices are designed and manufactured with some components having
> > multiple drop-in replacement options. These components are often
> > connected to the mainboard via ribbon cables, having the same signals
> > and pin assignments across all options. These may include the display
> > panel and touchscreen on laptops and tablets, and the trackpad on
> > laptops. Sometimes which component option is used in a particular devic=
e
> > can be detected by some firmware provided identifier, other times that
> > information is not available, and the kernel has to try to probe each
> > device.
> >
> > This change attempts to make the "probe each device" case cleaner. The
> > current approach is to have all options added and enabled in the device
> > tree. The kernel would then bind each device and run each driver's prob=
e
> > function. This works, but has been broken before due to the introductio=
n
> > of asynchronous probing, causing multiple instances requesting "shared"
> > resources, such as pinmuxes, GPIO pins, interrupt lines, at the same
> > time, with only one instance succeeding. Work arounds for these include
> > moving the pinmux to the parent I2C controller, using GPIO hogs or
> > pinmux settings to keep the GPIO pins in some fixed configuration, and
> > requesting the interrupt line very late. Such configurations can be see=
n
> > on the MT8183 Krane Chromebook tablets, and the Qualcomm sc8280xp-based
> > Lenovo Thinkpad 13S.
> >
> > Instead of this delicate dance between drivers and device tree quirks,
> > this change introduces a simple I2C component prober. For any given
> > class of devices on the same I2C bus, it will go through all of them,
> > doing a simple I2C read transfer and see which one of them responds.
> > It will then enable the device that responds.
> >
> > This requires some minor modifications in the existing device tree.
> > The status for all the device nodes for the component options must be
> > set to "failed-needs-probe". This makes it clear that some mechanism is
> > needed to enable one of them, and also prevents the prober and device
> > drivers running at the same time.
>
> ...
>
> > +#include <linux/array_size.h>
> > +#include <linux/i2c.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
>
> init.h for init calls.

Added to next version.

> > +static int chromeos_of_hw_prober_probe(struct platform_device *pdev)
> > +{
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(hw_prober_platforms); i++)
> > +             if (of_machine_is_compatible(hw_prober_platforms[i].compa=
tible)) {
> > +                     int ret;
>
> Perhaps
>
>                 if (!of_machine_is_compatible(hw_prober_platforms[i].comp=
atible))
>                         continue;
>
> ?

Works for me. One less level of indentation.

Thanks
ChenYu

> > +                     ret =3D hw_prober_platforms[i].prober(&pdev->dev,
> > +                                                         hw_prober_pla=
tforms[i].data);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +
> > +     return 0;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
