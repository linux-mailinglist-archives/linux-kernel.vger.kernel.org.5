Return-Path: <linux-kernel+bounces-30417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E40831E68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2DF28AF31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D692D047;
	Thu, 18 Jan 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HIQa1pvf"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A692D03B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598945; cv=none; b=hiLoj9nng535jaG/HSiK+Dg9ljhIXQw/2aRsleMxRX3wN1kKZLoTEBagCufJ7slQUG5iF/szM9PAkeYoA0zW1YfdMzoYDFhkSkZqjR9BuutUfUsJLwruPog2bWmSO+8cOS4L+Qli/U6tPLqLxyZXE/VE0qxclVQ9uOiXOqakVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598945; c=relaxed/simple;
	bh=qUrX/8tzgVWIru/9cI9VQjcVMo2tb65XKY5Bbr9TC6Y=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=H/gKwuyZ1IxeGdG3CUuKeIyBC+LQb1szsCvk2OctYx/whjaWxwlAdY+mCpxMPcymwhkRnflq2QexnA4KNHMVz2F9xuuceTsnYTQAQMTYFi7WJUAqK1X8qmPZXAZiBdj+XEE/zVQ+cnQZzy5EWiviAxLaMD99YNHO0I/NZw1sdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HIQa1pvf; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso145014161fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705598941; x=1706203741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TG8awMxnaXlYghJMwpn1QRDYilzhzTATthRsKlv51E=;
        b=HIQa1pvf48ynvrG8egoNi41CvH0AVL+6eXpLdNBFSLzTrfY1QtcDgPBITGLnLNTQpz
         qiN0/fxJQPF0wtheo4hnnNmo1dV4V4TNwobpcMxQJYgxNcSvHmCvM9mI6amh3OQOn+LK
         +Yrme4A+dqNXVg9OS+R4O3YkO0O0gIZo9s3to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705598941; x=1706203741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TG8awMxnaXlYghJMwpn1QRDYilzhzTATthRsKlv51E=;
        b=Rg9/a/JYpSw+88evVLpONGcLW4f0/Z66zWYBUOLpuwRHKGHyc1DkiiKKGf8BkkgLZu
         Ersbs0x9X0HyVNTkjsLF0he/CQIrUeUXuX4RmMnVnaawKUFu28Pv68wngWdyN3E68XgB
         P7ekafHYjGjoE5cG0nRHzwW9LxeteByHznMj2uCH7+xNg+pSSimAwUUPUzYNg9MsBys1
         gw9mHV+Du83gdjviWujRqJH5/hBz6PYfdMr4SCzyosr0piPIbFA6Z4DOSn+cjYHXyrtY
         rzAebWxztyjSpa47A/9W2yVX4R5LNHjJ9O+HY5+QVm2EDxcne6G/CxNmCjOvgBFuAYbr
         Xf1w==
X-Gm-Message-State: AOJu0YwTbXbyHyOdwHDX1304DyzV3ldcKbW1DcPpoQHdku7MlAvWIG5C
	38jDvcFE5sPGWDkd2+D4eECC8atbnxU1QtGflXnWK4myDAjKu3HJHRMGZEGoKrx68UpYlC47qVD
	HJxAmgAfV8RSCuWB6Qa5eyJcChzksN5Jyo2s8FGsIbukJN7ir4Q==
X-Google-Smtp-Source: AGHT+IEvzuHp1w0ZzuXaRd0Ni29bKufEb4d3XxqcXGD2ndQ5YMeHo9T38nrKDU3S0dwWXT6cmP9/9R1i3E1BpnhGUUY=
X-Received: by 2002:a2e:a583:0:b0:2cc:e766:eeec with SMTP id
 m3-20020a2ea583000000b002cce766eeecmr869046ljp.45.1705598940741; Thu, 18 Jan
 2024 09:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117102450.4080839-1-lma@chromium.org> <8afd7bda-a600-4abb-95fc-ee70c6f89749@kernel.org>
In-Reply-To: <8afd7bda-a600-4abb-95fc-ee70c6f89749@kernel.org>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Thu, 18 Jan 2024 18:28:49 +0100
Message-ID: <CAE5UKNp8KYgohe4D_Esrpzi4V-Koi8r1frBedGJk1AnKvQc+Uw@mail.gmail.com>
Subject: Re: [PATCH] drivers: watchdog: Add ChromeOS EC watchdog
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Lee Jones <lee@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Radoslaw Biernacki <biernacki@google.com>, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Please find the answers below.

On Wed, Jan 17, 2024 at 4:27=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 17/01/2024 11:24, Lukasz Majczak wrote:
> > This adds EC-based watchdog support for ChromeOS
> > based devices equipped with embedded controller (EC).
> >
> > Signed-off-by: Lukasz Majczak <lma@chromium.org>
> > ---
> >  MAINTAINERS                                   |   6 +
> >  drivers/mfd/cros_ec_dev.c                     |   9 +
> >  drivers/watchdog/Kconfig                      |  15 +
> >  drivers/watchdog/Makefile                     |   3 +
> >  drivers/watchdog/cros_ec_wdt.c                | 303 ++++++++++++++++++
> >  .../linux/platform_data/cros_ec_commands.h    |  78 ++---
> >  6 files changed, 370 insertions(+), 44 deletions(-)
> >  create mode 100644 drivers/watchdog/cros_ec_wdt.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 391bbb855cbe..55cd626a525f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4952,6 +4952,12 @@ R:     Sami Ky=C3=B6stil=C3=A4 <skyostil@chromiu=
m.org>
> >  S:   Maintained
> >  F:   drivers/platform/chrome/cros_hps_i2c.c
> >
> > +CHROMEOS EC WATCHDOG
> > +M:   Lukasz Majczak <lma@chromium.org>
> > +L:   chrome-platform@lists.linux.dev
> > +S:   Maintained
> > +F:   drivers/watchdog/cros_ec_wdt.c
> > +
> >  CHRONTEL CH7322 CEC DRIVER
> >  M:   Joe Tessler <jrt@google.com>
> >  L:   linux-media@vger.kernel.org
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index 79d393b602bf..60fe831cf30a 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -91,6 +91,10 @@ static const struct mfd_cell cros_usbpd_notify_cells=
[] =3D {
> >       { .name =3D "cros-usbpd-notify", },
> >  };
> >
> > +static const struct mfd_cell cros_ec_wdt_cells[] =3D {
> > +     { .name =3D "cros-ec-wdt-drv", }
> > +};
> > +
> >  static const struct cros_feature_to_cells cros_subdevices[] =3D {
> >       {
> >               .id             =3D EC_FEATURE_CEC,
> > @@ -107,6 +111,11 @@ static const struct cros_feature_to_cells cros_sub=
devices[] =3D {
> >               .mfd_cells      =3D cros_usbpd_charger_cells,
> >               .num_cells      =3D ARRAY_SIZE(cros_usbpd_charger_cells),
> >       },
> > +     {
> > +             .id             =3D EC_FEATURE_HANG_DETECT,
> > +             .mfd_cells      =3D cros_ec_wdt_cells,
> > +             .num_cells      =3D ARRAY_SIZE(cros_ec_wdt_cells),
> > +     },
> >  };
> >
> >  static const struct mfd_cell cros_ec_platform_cells[] =3D {
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 7d22051b15a2..1da4be661be8 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -2251,4 +2251,19 @@ config KEEMBAY_WATCHDOG
> >         To compile this driver as a module, choose M here: the
> >         module will be called keembay_wdt.
> >
> > +#
> > +# ChromeOS EC-based Watchdog
> > +#
>
> Drop comment, useless, copies what's below.

ACK

>
> > +
> > +config CROS_EC_WATCHDOG
> > +     tristate "ChromeOS EC-based watchdog driver"
> > +     select WATCHDOG_CORE
> > +     depends on CROS_EC
> > +     help
> > +       This is the watchdog driver for ChromeOS devices equipped with =
EC.
> > +       The EC watchdog - when enabled - expects to be kicked within a =
given
> > +       time (default set to 30 seconds) otherwise it will simple reboo=
t
> > +       the AP. Priori to that it can also send an event (configurable =
timeout)
> > +       about upcoming reboot.
>
> Instead you could say what will be the name of the module.
>

ACK

> > +
> >  endif # WATCHDOG
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 7cbc34514ec1..8295c209ddb0 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -234,3 +234,6 @@ obj-$(CONFIG_MENZ069_WATCHDOG) +=3D menz69_wdt.o
> >  obj-$(CONFIG_RAVE_SP_WATCHDOG) +=3D rave-sp-wdt.o
> >  obj-$(CONFIG_STPMIC1_WATCHDOG) +=3D stpmic1_wdt.o
> >  obj-$(CONFIG_SL28CPLD_WATCHDOG) +=3D sl28cpld_wdt.o
> > +
> > +# Cros EC watchdog
>
> Drop comment.
>
> Also, are you sure you placed it in appropriate place, not just at the
> end of both files?
>

ACK, I will find a better place for above (both in Makefile and
Kconfig) and will try to keep alphabetic order.

> > +obj-$(CONFIG_CROS_EC_WATCHDOG) +=3D cros_ec_wdt.o
> > diff --git a/drivers/watchdog/cros_ec_wdt.c b/drivers/watchdog/cros_ec_=
wdt.c
> > new file mode 100644
> > index 000000000000..b461c0613269
> > --- /dev/null
> > +++ b/drivers/watchdog/cros_ec_wdt.c
> > @@ -0,0 +1,303 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <linux/slab.h>
> > +#include <linux/err.h>
> > +#include <linux/of_device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_data/cros_ec_commands.h>
> > +#include <linux/platform_data/cros_ec_proto.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/watchdog.h>
> > +#include <linux/uaccess.h>
> > +
> > +#define CROS_EC_WATCHDOG_DEFAULT_TIME 30 /* seconds */
> > +
> > +#define DEV_NAME "cros-ec-wdt-dev"
>
> Drop unused defines.

ACK

>
> > +#define DRV_NAME "cros-ec-wdt-drv"
> > +
> > +static int cros_ec_wdt_ping(struct watchdog_device *wdd);
> > +static int cros_ec_wdt_start(struct watchdog_device *wdd);
> > +static int cros_ec_wdt_stop(struct watchdog_device *wdd);
> > +static int cros_ec_wdt_set_timeout(struct watchdog_device *wdd, unsign=
ed int t);
> > +
>
> ...
>
> > +
> > +static int cros_ec_wdt_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     /* We need to get a reference to cros_ec_devices
> > +      * (provides communication layer) which is a parent of
> > +      * the cros-ec-dev (our parent)
> > +      */
> > +     struct cros_ec_device *cros_ec =3D dev_get_drvdata(dev->parent->p=
arent);
> > +     int ret =3D 0;
> > +     uint32_t bootstatus;
> > +
> > +     if (!cros_ec) {
> > +             ret =3D -ENODEV;
> > +             dev_err_probe(dev, ret, "There is no coresponding EC devi=
ce!");
>
> Syntax is return dev_err_probe
>

ACK

> > +             return ret;
> > +     }
> > +
> > +     cros_ec_wdd.parent =3D &pdev->dev;
> > +     wd_data.cros_ec =3D cros_ec;
> > +     wd_data.wdd =3D &cros_ec_wdd;
> > +     wd_data.start_on_resume =3D false;
> > +     wd_data.keepalive_on =3D false;
> > +     wd_data.wdd->timeout =3D CROS_EC_WATCHDOG_DEFAULT_TIME;
> > +
> > +     watchdog_stop_on_reboot(&cros_ec_wdd);
> > +     watchdog_stop_on_unregister(&cros_ec_wdd);
> > +     watchdog_set_drvdata(&cros_ec_wdd, &wd_data);
> > +     platform_set_drvdata(pdev, &wd_data);
> > +
> > +     /* Get current AP boot status */
> > +     ret =3D cros_ec_wdt_send_hang_detect(&wd_data, EC_HANG_DETECT_CMD=
_GET_STATUS, 0,
> > +                                        &bootstatus);
> > +     if (ret < 0) {
> > +             dev_err_probe(dev, ret, "Couldn't get AP boot status from=
 EC");
>
> Syntax is return dev_err_probe

ACK

>
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * If bootstatus is not EC_HANG_DETECT_AP_BOOT_NORMAL
> > +      * it mens EC has rebooted the AP due to watchdog timeout.
> > +      * Lets translate it to watchdog core status code.
> > +      */
> > +     if (bootstatus !=3D EC_HANG_DETECT_AP_BOOT_NORMAL)
> > +             wd_data.wdd->bootstatus =3D WDIOF_CARDRESET;
> > +
> > +     ret =3D watchdog_register_device(&cros_ec_wdd);
> > +     if (ret < 0)
> > +             dev_err_probe(dev, ret, "Couldn't get AP boot status from=
 EC");
>
> Syntax is return dev_err_probe
>

ACK

> > +
> > +     return ret;
>
> return 0
>

ACK

> > +}
> > +
> > +static int cros_ec_wdt_remove(struct platform_device *pdev)
> > +{
> > +     struct cros_ec_wdt_data *wd_data =3D platform_get_drvdata(pdev);
> > +
> > +     watchdog_unregister_device(wd_data->wdd);
> > +
> > +     return 0;
> > +}
> > +
> > +static void cros_ec_wdt_shutdown(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct cros_ec_wdt_data *wd_data =3D platform_get_drvdata(pdev);
> > +     int ret;
> > +
> > +     /*
> > +      * Clean only bootstatus flag.
> > +      * EC wdt is are already stopped by watchdog framework.
> > +      */
> > +     ret =3D cros_ec_wdt_send_hang_detect(wd_data,
> > +                                        EC_HANG_DETECT_CMD_CLEAR_STATU=
S, 0, NULL);
> > +     if (ret < 0)
> > +             dev_err(dev, "%s failed (%d)", __func__, ret);
> > +
> > +     watchdog_unregister_device(wd_data->wdd);
> > +}
> > +
> > +static int __maybe_unused cros_ec_wdt_suspend(struct platform_device *=
pdev, pm_message_t state)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct cros_ec_wdt_data *wd_data =3D platform_get_drvdata(pdev);
> > +     int ret;
> > +
> > +     if (watchdog_active(wd_data->wdd)) {
> > +             ret =3D cros_ec_wdt_send_hang_detect(wd_data,
> > +                                                EC_HANG_DETECT_CMD_CAN=
CEL, 0, NULL);
> > +             if (ret < 0)
> > +                     dev_err(dev, "%s failed (%d)", __func__, ret);
> > +             wd_data->start_on_resume =3D true;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused cros_ec_wdt_resume(struct platform_device *p=
dev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct cros_ec_wdt_data *wd_data =3D platform_get_drvdata(pdev);
> > +     int ret;
> > +
> > +     /* start_on_resume is only set if watchdog was active
> > +      * when device was going to sleep
> > +      */
> > +     if (wd_data->start_on_resume) {
> > +             /* On resume we just need to setup a EC watchdog the same=
 way as
>
> Use comment style from Linux coding style.
>

ACK

> > +              * in cros_ec_wdt_start(). When userspace resumes from su=
spend
> > +              * the watchdog app should just start petting the watchdo=
g again.
> > +              */
> > +             ret =3D cros_ec_wdt_start(wd_data->wdd);
> > +             if (ret < 0)
> > +                     dev_err(dev, "%s failed (%d)", __func__, ret);
>
> That's not really helpful. This applies everywhere. You have all over
> the place debugging prints with __func__. This is not useful pattern.
> Print something useful, not function name.
>

ACK, I will revisit the logs messages (both the meanings and log levels)

> > +
> > +             wd_data->start_on_resume =3D false;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver cros_ec_wdt_driver =3D {
> > +     .probe          =3D cros_ec_wdt_probe,
> > +     .remove         =3D cros_ec_wdt_remove,
> > +     .shutdown       =3D cros_ec_wdt_shutdown,
> > +     .suspend        =3D pm_ptr(cros_ec_wdt_suspend),
> > +     .resume         =3D pm_ptr(cros_ec_wdt_resume),
> > +     .driver         =3D {
> > +             .name   =3D DRV_NAME,
> > +     },
> > +};
> > +
> > +module_platform_driver(cros_ec_wdt_driver);
> > +
> > +MODULE_ALIAS("platform:" DRV_NAME);
>
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong (e.g. misses either
> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
> for incomplete ID table.
>
>

ACK, I will use MODULE_DEVICE_TABLE().

> > +MODULE_DESCRIPTION("Cros EC Watchdog Device Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/l=
inux/platform_data/cros_ec_commands.h
> > index 7dae17b62a4d..35a7a2d32819 100644
> > --- a/include/linux/platform_data/cros_ec_commands.h
> > +++ b/include/linux/platform_data/cros_ec_commands.h
> > @@ -3961,60 +3961,50 @@ struct ec_response_i2c_passthru {
> >  } __ec_align1;
> >
> >  /*********************************************************************=
********/
> > -/* Power button hang detect */
> > -
> > +/* AP hang detect */
>
> I don't understand how this change is related to the new driver. This
> entire hunk is confusing.
>

Yes, that updates the API and definition for embedded controller (EC).
It should go in the separate patch.

>
> Best regards,
> Krzysztof
>

Best regards,
Lukasz

