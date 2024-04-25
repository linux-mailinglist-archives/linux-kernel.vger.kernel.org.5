Return-Path: <linux-kernel+bounces-158332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF778B1E78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DD41C246FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2085624;
	Thu, 25 Apr 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="H2pvX2M9"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62508614D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038649; cv=none; b=TF0JaWOk2xWNH3TZS+oyCvT+QL+7tewzDPHGkR3+KNgXuvSOAlKSG726C5Uy1Dbcz/+7eOVG6U+B8w785ERvDKvywdZFseuP3oIgyWWprXAoe6KXnTUZ/fw5qxASog3+joyH8slHujmBcGe1JI6goCe7jM4xfkUJI63lu6wBAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038649; c=relaxed/simple;
	bh=qdRiSYw8YShEsbcnjovffFj4XN41isfrJsatmjc2y5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5t/9fLteZajqlnHXquLyPPB0BoQCTFmQfp/QxIX24IUmp5vCYCiwFYGAjJiJTsJiLH+xMldyrqatsGhF1jksiIJBvMtlfn8vL8Dg7xbVu2cF5/qsUQm3Rt5ZofxOtxXB4ES0OGgIFjmddpPkc3uKmPf9WDNAMOP36SVHs0K+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=H2pvX2M9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so619465a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1714038646; x=1714643446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rk5LPWQLoL0mOBXdRCO3wblAuxieiGS9nszgRdpKbTE=;
        b=H2pvX2M96rZ3oBI+OY4Pw8a3jIvv0yC+/wikhfeddZdOrykrgvCCKG826HnKq5zo0K
         eS1ag1C3zvZEZQbcoSG3/T+64cVdSpDkPHNRSZHg/Sr57SFs42NDn3skD+McXE9znlX7
         QFhVpHC0bBI1/zfK4y768U/CHnRCGzPoMy6qvvmq/Tt4EbafJ9bhRuhGnyE2y7kjOPrY
         Lav4nrAMzQUScajTlJyg+9ra9OUrSAdczL1aGB/fMkH9fHFEP9Ho3b/gxXci3ssDY5eg
         +VnTkoV30BcHHK6lYFDcQxTVtKMW5dIwt4COoPFZBsyazO93wIU7IjteaaZRn94kYnOQ
         O3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714038646; x=1714643446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rk5LPWQLoL0mOBXdRCO3wblAuxieiGS9nszgRdpKbTE=;
        b=KaS09eggCDTX+D0DqI1UpftPe5l9tl41RWQtaNGAu6mxuFkh/3ZseBggl9yFroj2Oz
         2nkYzqY0B7rJ9jhrAc1f+XfL6iE2iCrLpYiJ2rUo7/JOCntP4QETP4Uw7Dm3uNGdw1+O
         jCSibkEWiCNZjrlGeDaw9zrzdf+1ug52l3pBXkCMTDYPm0Lp8IQikudVg8X/Y+9wPvHY
         0QULkwYhaqplieBzoQ7OIjc27lv1hUw0vMTf977YrwouMv41ZvJiVsk1CX2SfU9+LEGQ
         fkhUhAwLQFAS5bpBajt+Zu5IDlENjriKKj8xLhtkVl+uLH3QEhjtpPYus5D6w7AG8wt8
         G72A==
X-Forwarded-Encrypted: i=1; AJvYcCUKYabWkWoofqWv05rsaN8ZQH53omjdNW0Q0qrLZTGbLbKO3PyNDxFuc5SZOt+uvbQD6qCN4RPruzsbeuVbN6LrZxgYzQyjcxYJdMtw
X-Gm-Message-State: AOJu0YyU5x0edtNiY60mJXGqcuI8ykhguOdEW7W9n2/PjrpDrqfffB2W
	Zps9AVXw16t0WkHofyZTYerH/eZZuIx6KdUEEvquciGc2XbRhbAVTnE6FZs9zwx+F5uRwwmkCq0
	nxwTToa9eEWu7SN8IMrIeHoC843kYiCLwy2qb+Q==
X-Google-Smtp-Source: AGHT+IH9ZkLYCUxIVmOFgcwspasMhuq7JJpPgx+HXsloRwnu3Nya4ej9oaE/72n5CzDqvjTkH0bP+hhaGfbYey9CPc4=
X-Received: by 2002:a17:90a:6808:b0:2a2:55de:93eb with SMTP id
 p8-20020a17090a680800b002a255de93ebmr4873824pjj.33.1714038646123; Thu, 25 Apr
 2024 02:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <65607114-89f8-4f48-83fc-b89d87fee247@roeck-us.net> <CABqG17jveAdxN+tCcPq4hNqWDy1YCJ1z0+kLpM+ect0XEyqBcA@mail.gmail.com>
 <116aeea1-c648-4abe-9ab2-693bf64000fc@roeck-us.net>
In-Reply-To: <116aeea1-c648-4abe-9ab2-693bf64000fc@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 25 Apr 2024 15:20:35 +0530
Message-ID: <CABqG17jHYymH02hAH0z-uqk2HjemL_-aLr9EyOUNR=uQ7U_wtA@mail.gmail.com>
Subject: Re: [PATCH 1/4] hwmon (max6639): Use regmap
To: Guenter Roeck <linux@roeck-us.net>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de, 
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,


On Mon, 22 Apr 2024 at 21:32, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Apr 22, 2024 at 04:06:16PM +0530, Naresh Solanki wrote:
> > Hi Guenter,
> >
> > On Wed, 17 Apr 2024 at 02:55, Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Tue, Apr 16, 2024 at 10:47:14PM +0530, Naresh Solanki wrote:
> > > > Add regmap support.
> > > >
> > >
> > > Missing (and not really utilizing) the benefits of using regmap.
> > This is just replacing with regmap support
> > >
> > > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > > ---
> > > >  drivers/hwmon/Kconfig   |   1 +
> > > >  drivers/hwmon/max6639.c | 157 ++++++++++++++++++++--------------------
> > > >  2 files changed, 80 insertions(+), 78 deletions(-)
> > > >
> > > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > > index c89776d91795..257ec5360e35 100644
> > > > --- a/drivers/hwmon/Kconfig
> > > > +++ b/drivers/hwmon/Kconfig
> > > > @@ -1223,6 +1223,7 @@ config SENSORS_MAX6621
> > > >  config SENSORS_MAX6639
> > > >       tristate "Maxim MAX6639 sensor chip"
> > > >       depends on I2C
> > > > +     select REGMAP_I2C
> > > >       help
> > > >         If you say yes here you get support for the MAX6639
> > > >         sensor chips.
> > > > diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> > > > index aa7f21ab2395..1af93fc53cb5 100644
> > > > --- a/drivers/hwmon/max6639.c
> > > > +++ b/drivers/hwmon/max6639.c
> > > > @@ -20,6 +20,7 @@
> > > >  #include <linux/err.h>
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/platform_data/max6639.h>
> > > > +#include <linux/regmap.h>
> > > >
> > > >  /* Addresses to scan */
> > > >  static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> > > > @@ -57,6 +58,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> > > >
> > > >  #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED 0x40
> > > >
> > > > +#define MAX6639_NDEV                         2
> > > > +
> > > >  static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> > > >
> > > >  #define FAN_FROM_REG(val, rpm_range) ((val) == 0 || (val) == 255 ? \
> > > > @@ -67,7 +70,7 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> > > >   * Client data (each client gets its own)
> > > >   */
> > > >  struct max6639_data {
> > > > -     struct i2c_client *client;
> > > > +     struct regmap *regmap;
> > > >       struct mutex update_lock;
> > > >       bool valid;             /* true if following fields are valid */
> > > >       unsigned long last_updated;     /* In jiffies */
> > > > @@ -95,9 +98,8 @@ struct max6639_data {
> > > >  static struct max6639_data *max6639_update_device(struct device *dev)
> > > >  {
> > > >       struct max6639_data *data = dev_get_drvdata(dev);
> > > > -     struct i2c_client *client = data->client;
> > > >       struct max6639_data *ret = data;
> > > > -     int i;
> > > > +     int i, err;
> > > >       int status_reg;
> > > >
> > > >       mutex_lock(&data->update_lock);
> > > > @@ -105,39 +107,35 @@ static struct max6639_data *max6639_update_device(struct device *dev)
> > >
> > > Conversions to regmap should drop all local caching and use regmap
> > > for caching (where appropriate) instead.
> > max6639_update_device deals with volatile registers & caching isn't
> > available for these.
> >
>
> So ? Unless you replace caching (and accept that volatile registers
> are not cached) I do not see the value of this patch. Replacing direct
> chip accesses with regmap should have a reason better than "because".
> Using regmap for caching would be a valid reason. At the same time,
> the value of caching volatile registers is very much questionable.
This driver has 27 regmap accesses. Except volatile registers, others are
cached by regmap.
Some function which only access volatile registers will not be able to take
advantage of caching. This is also the case in various other drivers for similar
devices.
Also regmap offers bit handling which makes the code much cleaner.

Regards,
Naresh

>
> Guenter

