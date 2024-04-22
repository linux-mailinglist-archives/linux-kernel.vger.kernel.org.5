Return-Path: <linux-kernel+bounces-153196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C2E8ACAD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06EE1C2144C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E91C1448DD;
	Mon, 22 Apr 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="CdaNymqS"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884114430B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782189; cv=none; b=O83I6PAHZK2DnWNc3zoyYNtArPbA/vR/+56P06A23OUJNH/uhzvynf2P89QNxdeWAcT1cd3siVk6IyfN459DmNi6vFmgCrUu/BCEGDsMf+3Z4vSDpfJG5+/rhh6ymP/imhoo/LbRUGv2EsGKk5AvbJ7Ecdh86FmZjrTjFr7fgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782189; c=relaxed/simple;
	bh=LEAgVPRS/v7QMqRe2lYOSIBa2FBbjKuZ1bzeNhjcAjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeUxY+BkgPcmWIhblejlATH2EQcoQZkZheBos0mw7NV3ZFt3yuvsC3+hyyRn0aZH01RB3CxrUW3oFNjIy9C4rQexgbnDCnUWwYS6F81ITm0z3kW0KuKOCcvAHisHYgG/MrfHYXUjzFxICy4S75WihojPGck0bBHxvxteSwE6ZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=CdaNymqS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2889078a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1713782187; x=1714386987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4bOgoi4dBCbRXc3BVmosIsW8tNXMI2zajK7wfOqMv4=;
        b=CdaNymqSWBnhi9O8hFXyPZ+1tRAXMzpVsCBdEb+3kMcBwQWTdIIE+hkAYROZoXQaNL
         frr6oq/pUtDqZMsoPOa1bjBJGhQCr3viPF1f7JBhSRljtOoH8NAweQoEj6m/qDdmXvPo
         jQqRqZLVNbGFcNXPXDn2lt5G334zj1JuJIrf+sBBlIxIcIlCBvj7mPFQ+eMLk7/8F/8+
         lzqtL3A2oaGkuo8tnR4oAagAk7yhBTUuNCqFZULd7qZhWCGbf4cB/SPo94RifWpjBiDs
         iqrofWei9OlDyA2MbPUvw1CgHGY2RKakH2/HJPWykyYIEcE8HJAqQTwQ30ZYvSj9WStH
         xMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782187; x=1714386987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4bOgoi4dBCbRXc3BVmosIsW8tNXMI2zajK7wfOqMv4=;
        b=oCSmgR9N4b+mAX94qtG7P/l/nEmpoMPd+rWCXmqgEm7Hc/Z7f6INEAaVWyLw+OHyix
         ptcd4sV1wabAQYQfYB/oWWC0/0zBr8UKkE8IMBChDKZkKT/QGiidGP+TTr2MtLnOQZFE
         QbrbTBZjlRgYEbwdmE+SycCQzOm+7+Dy9rBXWLAB/jd/Kysh7qzxEVSM0tY4CFImBi7p
         RSY7vmYfs2tnuF6jGJkretVnp9rCMnRri/O8LP7HWickUZzCUZh4yhXaD1VKKZuW868v
         g31rqLqrJNlUYWsFncC1I1AAXoj330a7YaBf1/UnNX3OP3srDXc05VM+liIq1/DD8ZGY
         3vig==
X-Forwarded-Encrypted: i=1; AJvYcCWQkWTXg3HTNG8PTf0Gx+L4gSCLB0JDOiqrbWOumVHxGPwSeg2q6hFCTPkuVRR2CMLXnkBARGn8xawRXxJHm3fZF30zgjFo8TdrwUJ0
X-Gm-Message-State: AOJu0Yy/Zc0nO/R3BpBRVLLmeU32rPfbZwKu0y3puxR2OMBLStawUeMU
	SUOo0QNBHK6n/ECZkFlLaePOG1NF/lB6daaV0N+jI4LTf3ZeGsObDDgg/vlb582HJEbE4bTFIbr
	83yB979jT2TMD+Ersv8ljP5PlSQUXqhUir9ciuA==
X-Google-Smtp-Source: AGHT+IHazBc0sRj+m/5muVKfbwOG9ihKE67/I/fj532JFu5vMsH6MbVYTZ/iULzXjdmvjaREaQX7NijQSIIDMVyYgrA=
X-Received: by 2002:a17:90a:de02:b0:2a5:275c:ed with SMTP id
 m2-20020a17090ade0200b002a5275c00edmr8787229pjv.23.1713782187244; Mon, 22 Apr
 2024 03:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416171720.2875916-1-naresh.solanki@9elements.com> <65607114-89f8-4f48-83fc-b89d87fee247@roeck-us.net>
In-Reply-To: <65607114-89f8-4f48-83fc-b89d87fee247@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Mon, 22 Apr 2024 16:06:16 +0530
Message-ID: <CABqG17jveAdxN+tCcPq4hNqWDy1YCJ1z0+kLpM+ect0XEyqBcA@mail.gmail.com>
Subject: Re: [PATCH 1/4] hwmon (max6639): Use regmap
To: Guenter Roeck <linux@roeck-us.net>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de, 
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Wed, 17 Apr 2024 at 02:55, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Apr 16, 2024 at 10:47:14PM +0530, Naresh Solanki wrote:
> > Add regmap support.
> >
>
> Missing (and not really utilizing) the benefits of using regmap.
This is just replacing with regmap support
>
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  drivers/hwmon/Kconfig   |   1 +
> >  drivers/hwmon/max6639.c | 157 ++++++++++++++++++++--------------------
> >  2 files changed, 80 insertions(+), 78 deletions(-)
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index c89776d91795..257ec5360e35 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1223,6 +1223,7 @@ config SENSORS_MAX6621
> >  config SENSORS_MAX6639
> >       tristate "Maxim MAX6639 sensor chip"
> >       depends on I2C
> > +     select REGMAP_I2C
> >       help
> >         If you say yes here you get support for the MAX6639
> >         sensor chips.
> > diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> > index aa7f21ab2395..1af93fc53cb5 100644
> > --- a/drivers/hwmon/max6639.c
> > +++ b/drivers/hwmon/max6639.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/err.h>
> >  #include <linux/mutex.h>
> >  #include <linux/platform_data/max6639.h>
> > +#include <linux/regmap.h>
> >
> >  /* Addresses to scan */
> >  static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> > @@ -57,6 +58,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> >
> >  #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED 0x40
> >
> > +#define MAX6639_NDEV                         2
> > +
> >  static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> >
> >  #define FAN_FROM_REG(val, rpm_range) ((val) == 0 || (val) == 255 ? \
> > @@ -67,7 +70,7 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> >   * Client data (each client gets its own)
> >   */
> >  struct max6639_data {
> > -     struct i2c_client *client;
> > +     struct regmap *regmap;
> >       struct mutex update_lock;
> >       bool valid;             /* true if following fields are valid */
> >       unsigned long last_updated;     /* In jiffies */
> > @@ -95,9 +98,8 @@ struct max6639_data {
> >  static struct max6639_data *max6639_update_device(struct device *dev)
> >  {
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct i2c_client *client = data->client;
> >       struct max6639_data *ret = data;
> > -     int i;
> > +     int i, err;
> >       int status_reg;
> >
> >       mutex_lock(&data->update_lock);
> > @@ -105,39 +107,35 @@ static struct max6639_data *max6639_update_device(struct device *dev)
>
> Conversions to regmap should drop all local caching and use regmap
> for caching (where appropriate) instead.
max6639_update_device deals with volatile registers & caching isn't
available for these.

Please let me know if there is specific optimization that you were looking for.

Regards,
Naresh
>
> Guenter

