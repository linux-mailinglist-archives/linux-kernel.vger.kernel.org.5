Return-Path: <linux-kernel+bounces-30458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E63831EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A081F23AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482012D615;
	Thu, 18 Jan 2024 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aoj79fWd"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACA2D609
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601341; cv=none; b=bXiNIFoIM081UcjkA+65Xe8QY/GNT46vNUx5TCzVa8Furl5e6w9zfCa4mKjl6gd4iMEd1PZBj8bA0goiYAXfv5C4+LsJTGGhRgsXdumHFtNMXlJvkXyVrSWE0sa4FJP8q652dVzKFraxaGNC43vuzfvT/Wk/OIhakHpsuuIZ4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601341; c=relaxed/simple;
	bh=RMqQaWvLqB41ECbCTYty/IcvQOVvSwpGHE1rgWvynwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NY4oobvq22MIHWtfz327rsFg7b0MMAmj+Nx8t9ytYHvXtrAL1bb27ko3GWmBDQk0EgvLDRGh2xApkl4OipvNkLZYs8thvRpxHJzVO571c/AJPOhO0tOsauWLzazB4gPntsAEXt7K3XUaFojPMor0/rRzB54qcG4/td4s/d5+5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Aoj79fWd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso140724881fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705601336; x=1706206136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLDkXCdFHXn5PBBz4YQ/t5RP5Zgjmq4eX2yzjc8Qo+U=;
        b=Aoj79fWdDrtPryfF8O9/hY5BNBsr5A70cVKFspcutZwliLOzkBboXxbkOiPsY/nxV6
         j87pUFvVHx/JB8qmU8XiqjP6VagJI+MCAixejq2r/Z0B6b523Ceb+PIIo4iNdVOjSIbw
         ms8XXtz7uSwxPBlLbvJPyNLhA5QEDAb4Ae+Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601336; x=1706206136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLDkXCdFHXn5PBBz4YQ/t5RP5Zgjmq4eX2yzjc8Qo+U=;
        b=h97r40Ap8C2IeJFhP2m5CY2ZXv99rPvxHMg8jkKW207Mad4TPv9yP683YuQpzn8US9
         +tIccL1tEYV59Ls6ApZ5Y82Ert0tG+I2bzDDyvAkG0R3iv6iiU/64+kiskyQ/OADOMIe
         pw7HtCfYXMkLLllN8STrfRM19SK8sBXN4CUoPpdU47ZkZqK9Incmk5Y0wQEaE5JLDCx+
         86r5J9XCXBPqZ2Bs0M1h7D4zgIM1fJiEt/jh1YRpFah+F86bFxaGdpuivHjtHOUvrnwf
         VqsOqhMAwAmGCSw5JEuOB2EgFAYq9qfPntZRTe9HqshEhW+qLbkfVRsLxcpL7GpxEQeF
         XBYA==
X-Gm-Message-State: AOJu0YwfiVQo/X+exX+y9+r9cfH33kj/n7t0dUnas9wzyVE/SIyE+d6c
	kgn/W2GqHyf2nmQ+Z2trt6ZME3iXuXmQXSws3dDnnBAEmSvwDJlXdjnN1iR7s7RTyY4Vcb+Dd6D
	fjz58XqUY2xnaubYOm5HHsG6a7YyX3kmpN0lo
X-Google-Smtp-Source: AGHT+IFLqSQQcI9hnrnhRq4vMHgNbpBY83s3SVOGYNaWgVbF8nvtjuCtXr/8Of2OSNw0TkggPKazRycEaD9hMsuVSsg=
X-Received: by 2002:a2e:934f:0:b0:2cc:e3ae:1ca9 with SMTP id
 m15-20020a2e934f000000b002cce3ae1ca9mr703500ljh.1.1705601336266; Thu, 18 Jan
 2024 10:08:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117102450.4080839-1-lma@chromium.org> <6b1190af-7b28-461d-bcd0-2aaeb0a1fa38@roeck-us.net>
In-Reply-To: <6b1190af-7b28-461d-bcd0-2aaeb0a1fa38@roeck-us.net>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Thu, 18 Jan 2024 19:08:45 +0100
Message-ID: <CAE5UKNpLmN0sKktML1+hEzgRkHKS_X_wv==MPV8G5djeG+B9FA@mail.gmail.com>
Subject: Re: [PATCH] drivers: watchdog: Add ChromeOS EC watchdog
To: Guenter Roeck <linux@roeck-us.net>
Cc: Gwendal Grignou <gwendal@chromium.org>, Lee Jones <lee@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Radoslaw Biernacki <biernacki@google.com>, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter

Please see my comments below

On Wed, Jan 17, 2024 at 5:23=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 1/17/24 02:24, Lukasz Majczak wrote:
> > This adds EC-based watchdog support for ChromeOS
> > based devices equipped with embedded controller (EC).
> >
> > Signed-off-by: Lukasz Majczak <lma@chromium.org>
>
> checkpatch --strict says:
>
> total: 0 errors, 0 warnings, 14 checks, 455 lines checked
>
> Please fix.

ACK, Although I would keep uint16_t/uint32_t types in
cros_ec_commands.h as those are shared with EC firmware.

> > ---
> >   MAINTAINERS                                   |   6 +
> >   drivers/mfd/cros_ec_dev.c                     |   9 +
> >   drivers/watchdog/Kconfig                      |  15 +
> >   drivers/watchdog/Makefile                     |   3 +
> >   drivers/watchdog/cros_ec_wdt.c                | 303 +++++++++++++++++=
+
> >   .../linux/platform_data/cros_ec_commands.h    |  78 ++---
> >   6 files changed, 370 insertions(+), 44 deletions(-)
> >   create mode 100644 drivers/watchdog/cros_ec_wdt.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 391bbb855cbe..55cd626a525f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4952,6 +4952,12 @@ R:     Sami Ky=C3=B6stil=C3=A4 <skyostil@chromiu=
m.org>
> >   S:  Maintained
> >   F:  drivers/platform/chrome/cros_hps_i2c.c
> >
> > +CHROMEOS EC WATCHDOG
> > +M:   Lukasz Majczak <lma@chromium.org>
> > +L:   chrome-platform@lists.linux.dev
> > +S:   Maintained
> > +F:   drivers/watchdog/cros_ec_wdt.c
> > +
> >   CHRONTEL CH7322 CEC DRIVER
> >   M:  Joe Tessler <jrt@google.com>
> >   L:  linux-media@vger.kernel.org
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index 79d393b602bf..60fe831cf30a 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -91,6 +91,10 @@ static const struct mfd_cell cros_usbpd_notify_cells=
[] =3D {
> >       { .name =3D "cros-usbpd-notify", },
> >   };
> >
> > +static const struct mfd_cell cros_ec_wdt_cells[] =3D {
> > +     { .name =3D "cros-ec-wdt-drv", }
> > +};
> > +
> >   static const struct cros_feature_to_cells cros_subdevices[] =3D {
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
> >   };
> >
> >   static const struct mfd_cell cros_ec_platform_cells[] =3D {
>
> The above should be a separate patch.
>
ACK, I will create a separate one for this.

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
> Pointless comment.
>
ACK
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
> > +
>
> In other words, it is a watchdog driver. I don't think it adds value
> to describe how a watchdog works here, nor to describe what other (unused=
)
> functionality the hardware may have.
>
> Also, please try to insert in alphabetic order.
ACK
>
> >   endif # WATCHDOG
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 7cbc34514ec1..8295c209ddb0 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -234,3 +234,6 @@ obj-$(CONFIG_MENZ069_WATCHDOG) +=3D menz69_wdt.o
> >   obj-$(CONFIG_RAVE_SP_WATCHDOG) +=3D rave-sp-wdt.o
> >   obj-$(CONFIG_STPMIC1_WATCHDOG) +=3D stpmic1_wdt.o
> >   obj-$(CONFIG_SL28CPLD_WATCHDOG) +=3D sl28cpld_wdt.o
> > +
> > +# Cros EC watchdog
>
> We don't add individual comments for each watchdog, and we should not sta=
rt
> doing so. Also, please try to insert in alphabetic order.
>
ACK
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
>
> Alphabetic include file order, please. Also, I don't immediately see wher=
e
> uaccess.h or of_device.h are used. Please drop unused includes.
>
ACK, in fact uaccess.h or of_device.h are unnecessary
> > +
> > +#define CROS_EC_WATCHDOG_DEFAULT_TIME 30 /* seconds */
> > +
> > +#define DEV_NAME "cros-ec-wdt-dev"
> > +#define DRV_NAME "cros-ec-wdt-drv"
>
> One of those is unused.
>
ACK
> > +
> > +static int cros_ec_wdt_ping(struct watchdog_device *wdd);
> > +static int cros_ec_wdt_start(struct watchdog_device *wdd);
> > +static int cros_ec_wdt_stop(struct watchdog_device *wdd);
> > +static int cros_ec_wdt_set_timeout(struct watchdog_device *wdd, unsign=
ed int t);
> > +
>
> Please rearrange to avoid forward declarations.
>
ACK
> > +struct cros_ec_wdt_data {
> > +     bool start_on_resume;
> > +     bool keepalive_on;
> > +     struct cros_ec_device *cros_ec;
> > +     struct watchdog_device *wdd;
> > +};
> > +static struct cros_ec_wdt_data wd_data;
>
> Please allocate and avoid static variables.
>
ACK
> > +
> > +static const struct watchdog_info cros_ec_wdt_ident =3D {
> > +     .options          =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WD=
IOF_MAGICCLOSE,
> > +     .firmware_version =3D 0,
> > +     .identity         =3D DRV_NAME,
> > +};
> > +
> > +static const struct watchdog_ops cros_ec_wdt_ops =3D {
> > +     .owner           =3D THIS_MODULE,
> > +     .ping            =3D cros_ec_wdt_ping,
> > +     .start           =3D cros_ec_wdt_start,
> > +     .stop            =3D cros_ec_wdt_stop,
> > +     .set_timeout =3D cros_ec_wdt_set_timeout,
> > +};
> > +
> > +static struct watchdog_device cros_ec_wdd =3D {
> > +     .info =3D &cros_ec_wdt_ident,
> > +     .ops =3D &cros_ec_wdt_ops,
> > +     .timeout =3D CROS_EC_WATCHDOG_DEFAULT_TIME,
> > +     .bootstatus =3D EC_HANG_DETECT_AP_BOOT_NORMAL
>
> Consider allocating and embedding in struct cros_ec_wdt_data.
> .timeout and .bootstatus are overwritten anyway, and it does not make sen=
se
> to initialize those elements here.
>
ACK, Agree, in fact cros_ec_wdt_data might be not necessary at all and
I might be able to drop it.
> > +};
> > +
> > +static int cros_ec_wdt_send_hang_detect(struct cros_ec_wdt_data *wd_da=
ta,
>
> Seems to me that cros_ec_wdt_send_cmd or similar would be a better functi=
on name,
> but your call.
ACK, cros_ec_wdt_send_cmd looks better - thank you,
>
> > +                                     uint16_t command,
> > +                                     uint16_t reboot_timeout_sec,
> > +                                     uint32_t *status)
> > +{
> > +     int ret;
> > +
> > +     struct {
> > +             struct cros_ec_command msg;
> > +             union {
> > +                     struct ec_params_hang_detect req;
> > +                     struct ec_response_hang_detect resp;
> > +             };
> > +     } __packed buf =3D {
> > +             .msg =3D {
> > +                     .version =3D 0,
> > +                     .command =3D EC_CMD_HANG_DETECT,
> > +                     .insize  =3D (command =3D=3D EC_HANG_DETECT_CMD_G=
ET_STATUS) ?
> > +                                sizeof(struct ec_response_hang_detect)=
 :
> > +                                0,
> > +                     .outsize =3D sizeof(struct ec_params_hang_detect)=
,
> > +             },
> > +             .req =3D {
> > +                     .command =3D command,
> > +                     .reboot_timeout_sec =3D reboot_timeout_sec,
> > +             }
> > +     };
> > +
> > +     ret =3D cros_ec_cmd_xfer_status(wd_data->cros_ec, &buf.msg);
> > +     if (ret < 0) {
> > +             dev_warn(wd_data->wdd->parent,
>
> Given that wdd is needed anyway,
>
> > +                              "cros_ec_cmd_xfer_status failed(%d) comm=
and (%04x) reboot_timeout_sec(%ds)",
> > +                              ret, command, reboot_timeout_sec);
>
> That message, if ever seen, does not make much sense if the command was
> one that does not set the timeout. On top of that, this code
> dumps a warning, and the calling code dumps an error message. Is the EC
> really that fragile that it is necessary to dump all those error messages=
 ?
>
> If not, please consider replacing most if not all of those log messages
> with dev_dbg().
ACK, I will revisit log messages (and levels)
>
> > +             return ret;
> > +     }
> > +
> > +     if (status && (command =3D=3D EC_HANG_DETECT_CMD_GET_STATUS)) {
>
> Unnecessary (). Besides, it doesn't make much sense. Why provide
> a status pointer but only use it if the command is a specific one ?
>
ACK, I will rework the whole function to be more generic.
> > +             *status =3D buf.resp.status;
> > +             dev_info(wd_data->wdd->parent, "EC Watchdog boot status (=
%d)",
> > +                              buf.resp.status);
>
> That message does not belong here.
>
ACK
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int cros_ec_wdt_ping(struct watchdog_device *wdd)
> > +{
> > +     struct cros_ec_wdt_data *wd_data =3D watchdog_get_drvdata(wdd);
> > +     int ret;
> > +
> > +     ret =3D cros_ec_wdt_send_hang_detect(wd_data, EC_HANG_DETECT_CMD_=
RELOAD,
> > +                                        0, NULL);
> > +     if (ret < 0)
> > +             dev_err(wdd->parent, "%s failed (%d)", __func__, ret);
>
> return here and drop the else.
>
ACK
> Nore that this driver is extremely noisy. If the EC for some reason doesn=
't
> respond as expected the error messages will drown all other kernel messag=
es.
> I really do not see the point of this.
>
ACK, I will try to clean it up.
> > +     else
> > +             wd_data->keepalive_on =3D true;
>
> This is odd and needs a detailed explanation. More on that see below.
>
I have revisited the code again and I think I can drop struc
cros_ec_wdt_data and rely purely on structures provided by framework.
> > +
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_wdt_start(struct watchdog_device *wdd)
> > +{
> > +     struct cros_ec_wdt_data *wd_data =3D watchdog_get_drvdata(wdd);
> > +     int ret =3D 0;
> > +
> > +     /* Prepare watchdog on EC side */
> > +     ret =3D cros_ec_wdt_send_hang_detect(wd_data,
> > +                                     EC_HANG_DETECT_CMD_SET_TIMEOUT,
> > +                                     wdd->timeout,
> > +                                     NULL);
> > +     if (ret < 0)
> > +             dev_err(wdd->parent, "%s failed (%d)", __func__, ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +     struct cros_ec_wdt_data *wd_data =3D watchdog_get_drvdata(wdd);
> > +     int ret =3D 0;
> > +
> > +     if (wd_data->keepalive_on) {
> > +             wd_data->keepalive_on =3D false;
> > +             ret =3D cros_ec_wdt_send_hang_detect(wd_data, EC_HANG_DET=
ECT_CMD_CANCEL,
> > +                                             0, NULL);
>
> This needs explanation. Why is it only needed here after the first ping i=
s sent,
> but on suspend it is unconditional ? In other words, why does the watchdo=
g
> behave differently after the first ping ? Why does the watchdog not have =
to be
> stopped if it never received a ping ? Logically that seems odd, if not pl=
ain
> wrong. The watchdog should behave exactly the same after it was started, =
no matter
> if it ever received a ping or not.
>
ACK, Same as with "keepalive_on" I will drop the struct
cros_ec_wdt_data. Agree with the confusion here, sorry for that, I
will simplify it.
> > +             if (ret < 0)
> > +                     dev_err(wdd->parent, "%s failed (%d)", __func__, =
ret);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_wdt_set_timeout(struct watchdog_device *wdd, unsign=
ed int t)
> > +{
> > +     struct cros_ec_wdt_data *wd_data =3D watchdog_get_drvdata(wdd);
> > +     int ret;
> > +
> > +     if (t < EC_HANG_DETECT_MIN_TIMEOUT) {
> > +             dev_err(wdd->parent,
> > +                             "%s failed, requested timeout is lower th=
an min(%d < %d)",
> > +                             __func__, t, EC_HANG_DETECT_MIN_TIMEOUT);
> > +             return -EINVAL;
>
> This should be handled in the watchdog core. If it isn't the driver is mi=
sconfigured.
>
ACK, yes, both min and max values should be set.
> > +     }
> > +
> > +     ret =3D cros_ec_wdt_send_hang_detect(wd_data,
> > +                                        EC_HANG_DETECT_CMD_SET_TIMEOUT=
,
> > +                                        t, NULL);
> > +     if (ret < 0)
> > +             dev_err(wdd->parent, "%s failed (%d)", __func__, ret);
>
> return here.
>
ACK
> > +     else
> > +             wdd->timeout =3D t;
> > +
> > +     return ret;
> > +}
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
>
>
> Other cros drivers get struct cros_ec_dev from dev->parent and then use
> ec->ec_dev. Please explain why you don't use the same pattern; dereferenc=
ing
> parent->parent and assuming to know its driver data seems to be (much) mo=
re
> risky than the existing pattern.
>
ACK, I will look at other cros_ec driver as an example.
> Also, the comment seems obvious. None of the other cros_ec drivers needed=
 it,
> and I don't see why it would add value here.
>
ACK
> > +     int ret =3D 0;
> > +     uint32_t bootstatus;
> > +
> > +     if (!cros_ec) {
> > +             ret =3D -ENODEV;
> > +             dev_err_probe(dev, ret, "There is no coresponding EC devi=
ce!");
> > +             return ret;
>
> return dev_err_probe(). Same elsewhere.
>
ACK
> > +     }
> > +
> > +     cros_ec_wdd.parent =3D &pdev->dev;
> > +     wd_data.cros_ec =3D cros_ec;
> > +     wd_data.wdd =3D &cros_ec_wdd;
> > +     wd_data.start_on_resume =3D false;
> > +     wd_data.keepalive_on =3D false;
> > +     wd_data.wdd->timeout =3D CROS_EC_WATCHDOG_DEFAULT_TIME;
>
> Ah, I guess the reason for the error handling when setting the timeout is
> the lack of setting boundaries here. That is wrong. min_timeout
> and max_timeout need to be set.
>
ACK
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
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * If bootstatus is not EC_HANG_DETECT_AP_BOOT_NORMAL
> > +      * it mens EC has rebooted the AP due to watchdog timeout.
>
> means
>
ACK
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
> Wrong error message.
>
ACK
> > +
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_wdt_remove(struct platform_device *pdev)
> > +{
> > +     struct cros_ec_wdt_data *wd_data =3D platform_get_drvdata(pdev);
> > +
> > +     watchdog_unregister_device(wd_data->wdd);
>
> Why not use devm_watchdog_register_device() ? Please explain.
ACK, good point, thank you.
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
>
> Why is this necessary if the watchdog is stopped ?
>
ACK, The idea was to clear the bootstatus (on EC side) when AP was
shutting down gracefully, to address the scenario:
1. EC kicks AP and sets bootstatus for doing so
2. AP boots and in sometime gracefully shutdown/reboot (EC still keeps
bootstatus that it's kicked AP)
3. AP boots again and read the bootstatus from EC and thinks it was kicked =
by EC
..but yeah much easier is to read-and-clear the boot status during
probe and keep it in the "bootstatus" field of thestruct
watchdog_device (where it was meant to be ) that will simplify the
code.
> > +     ret =3D cros_ec_wdt_send_hang_detect(wd_data,
> > +                                        EC_HANG_DETECT_CMD_CLEAR_STATU=
S, 0, NULL);
> > +     if (ret < 0)
> > +             dev_err(dev, "%s failed (%d)", __func__, ret);
> > +
> > +     watchdog_unregister_device(wd_data->wdd);
>
> This doesn't make sense to me. Explain why it is necessary.
>
ACK,  this will be removed.
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
>
> Needs explanation. See below.
>
ACK, same as with "keepalive_on" - will drop the struct
cros_ec_wdt_data and rely on watchdog_active().
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
>
> Please use standard multi-line comments. This is not the networking subsy=
stem.
> Even more important, use _consistent_ multi-line comments.
>
ACK
> > +     if (wd_data->start_on_resume) {
>
> Please explain why watchdog_active() does not work here.
>
> > +             /* On resume we just need to setup a EC watchdog the same=
 way as
> > +              * in cros_ec_wdt_start(). When userspace resumes from su=
spend
> > +              * the watchdog app should just start petting the watchdo=
g again.
> > +              */
>
> Isn't that obvious ?
ACK, Right
>
> > +             ret =3D cros_ec_wdt_start(wd_data->wdd);
> > +             if (ret < 0)
> > +                     dev_err(dev, "%s failed (%d)", __func__, ret);
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
> > +MODULE_DESCRIPTION("Cros EC Watchdog Device Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/l=
inux/platform_data/cros_ec_commands.h
> > index 7dae17b62a4d..35a7a2d32819 100644
> > --- a/include/linux/platform_data/cros_ec_commands.h
> > +++ b/include/linux/platform_data/cros_ec_commands.h
> > @@ -3961,60 +3961,50 @@ struct ec_response_i2c_passthru {
> >   } __ec_align1;
> >
> >   /********************************************************************=
*********/
> > -/* Power button hang detect */
> > -
> > +/* AP hang detect */
> >   #define EC_CMD_HANG_DETECT 0x009F
> >
> > -/* Reasons to start hang detection timer */
> > -/* Power button pressed */
> > -#define EC_HANG_START_ON_POWER_PRESS  BIT(0)
> > -
> > -/* Lid closed */
> > -#define EC_HANG_START_ON_LID_CLOSE    BIT(1)
> > -
> > - /* Lid opened */
> > -#define EC_HANG_START_ON_LID_OPEN     BIT(2)
> > -
> > -/* Start of AP S3->S0 transition (booting or resuming from suspend) */
> > -#define EC_HANG_START_ON_RESUME       BIT(3)
> > -
> > -/* Reasons to cancel hang detection */
> > +#define EC_HANG_DETECT_MIN_TIMEOUT 5
> >
> > -/* Power button released */
> > -#define EC_HANG_STOP_ON_POWER_RELEASE BIT(8)
> > +/* EC hang detect commands */
> > +enum ec_hang_detect_cmds {
> > +     /* Reload AP hang detect timer. */
> > +     EC_HANG_DETECT_CMD_RELOAD =3D 0x0,
> >
> > -/* Any host command from AP received */
> > -#define EC_HANG_STOP_ON_HOST_COMMAND  BIT(9)
> > +     /* Stop AP hang detect timer. */
> > +     EC_HANG_DETECT_CMD_CANCEL =3D 0x1,
> >
>
> This is making unrelated changes. Please make those in a separate patch.
> It might be best to update this file in a separate patch to start with.
>
ACK, I will create a separate one for this.
> > -/* Stop on end of AP S0->S3 transition (suspending or shutting down) *=
/
> > -#define EC_HANG_STOP_ON_SUSPEND       BIT(10)
> > +     /* Configure watchdog with given reboot timeout and
> > +      * cancel currently running AP hand detect timer.
> > +      */
> > +     EC_HANG_DETECT_CMD_SET_TIMEOUT =3D 0x2,
> >
> > -/*
> > - * If this flag is set, all the other fields are ignored, and the hang=
 detect
> > - * timer is started.  This provides the AP a way to start the hang tim=
er
> > - * without reconfiguring any of the other hang detect settings.  Note =
that
> > - * you must previously have configured the timeouts.
> > - */
> > -#define EC_HANG_START_NOW             BIT(30)
> > +     /* Get last hang status - whether the AP boot was clear or not */
> > +     EC_HANG_DETECT_CMD_GET_STATUS =3D 0x3,
> >
> > -/*
> > - * If this flag is set, all the other fields are ignored (including
> > - * EC_HANG_START_NOW).  This provides the AP a way to stop the hang ti=
mer
> > - * without reconfiguring any of the other hang detect settings.
> > - */
> > -#define EC_HANG_STOP_NOW              BIT(31)
> > +     /* Clear last hang status. Called when AP is rebooting/shutting d=
own
> > +      * gracefully.
> > +      */
> > +     EC_HANG_DETECT_CMD_CLEAR_STATUS =3D 0x4
> > +};
> >
> >   struct ec_params_hang_detect {
> > -     /* Flags; see EC_HANG_* */
> > -     uint32_t flags;
> > -
> > -     /* Timeout in msec before generating host event, if enabled */
> > -     uint16_t host_event_timeout_msec;
> > -
> > -     /* Timeout in msec before generating warm reboot, if enabled */
> > -     uint16_t warm_reboot_timeout_msec;
> > -} __ec_align4;
> > +     uint16_t command; /* enum ec_hang_detect_cmds */
> > +     /* Timeout in seconds before generating reboot */
> > +     uint16_t reboot_timeout_sec;
> > +} __ec_align2;
> >
> > +/* Status codes that describe whether AP has boot normally or the hang=
 has been
> > + * detected and EC has reset AP
> > + */
> > +enum ec_hang_detect_status {
> > +     EC_HANG_DETECT_AP_BOOT_NORMAL =3D 0x0,
> > +     EC_HANG_DETECT_AP_BOOT_EC_WDT =3D 0x1,
> > +     EC_HANG_DETECT_AP_BOOT_COUNT,
> > +};
> > +struct ec_response_hang_detect {
> > +     uint8_t status; /* enum ec_hang_detect_status */
> > +} __ec_align1;
> >   /********************************************************************=
*********/
> >   /* Commands for battery charging */
> >
>

Thank you Guenter for all the comments, I will try to address them
best I can sith V2 and thank you for your time reading all of this and
answering.

Best regards,
Lukasz

