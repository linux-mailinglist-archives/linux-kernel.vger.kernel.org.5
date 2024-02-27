Return-Path: <linux-kernel+bounces-83253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 119408690DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B984B25022
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A20813A88B;
	Tue, 27 Feb 2024 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IblYYfJ/"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035174A29;
	Tue, 27 Feb 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038054; cv=none; b=s3OWx5AUDTyld2HR8jae5yuW/na0yQ+XJg99VJb06lsfFdHRIaLVo9zmcp27MRtvMd1GEv888Rx0pcZ7PJLiVXlm7so/LnvTPc5zLLzVn8R2nm4XBheGDNBmHDGhFfsoHdOjOSUOkMh7QDFxplkyUIfduh9ZXHXY7tJwS0u9hNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038054; c=relaxed/simple;
	bh=KVltK0dA4Qbvlw7zDfodkzm1N5V8wKDxf19GCiM6gq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDEN76S1f0dMj44i0WcbFibL03/qhuNa8kGAghwTShVLItdyXw9BvmoAc5QBGpY1y72pMfWwDCjxmDdMr8MiGgsjPayfb5y6o566IkTExfLe43OjRVDxiaXsTzd12GXGl2Msl9ly7RIZbCDuOGAz28JGx8Umx+u/xBlIeR7oqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IblYYfJ/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so431138566b.3;
        Tue, 27 Feb 2024 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709038051; x=1709642851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpPioA8mjFfPElR4akQZjgY40MOrULuf/vpjJ/rxUr8=;
        b=IblYYfJ/rLRpHl+OjWWBeiXECZtOa4tzfoJmRU1WdUNwSMv5TYBS6wx5bmzaL62R6Z
         SpGjD2c1OxRR5owvohVjf3g5wBteX+ui8Xx+jrjNwniINKoVGRaosmcGcVlCkQ69hvk2
         ErV+Vk37b8pDA7wELoaWDw1aNoyKBvPTYIBwcY6u1G/4tvp2xfW1m8PhotmeMLC+/hXA
         yE/AfxMnX/5pOvopVQ0Dy1KcEGYRCxhnam65mp1zwSYpwdFVfSEkly2Xo2ccyOHZ7DwJ
         vCeduzl3USNxpTTSyb0WQ5+FcXO7LUz7BVVv+vNzZjy/av1zhYhKjw3tKhicCxU+aLT+
         ftpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038051; x=1709642851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpPioA8mjFfPElR4akQZjgY40MOrULuf/vpjJ/rxUr8=;
        b=cWThNgkOsfaBEue1rdxDHHWQYrGkYGjUHHMn3SP3RZhDk6wOITE9sFagIRJbErx+m2
         cY7KSAHJ3nrhCs7s1VFOCbp9LGTVaCp6IfvNec71yiuq7rjKV1/5q5A+eUvXzVLwLuZA
         rNJ8IerOVmsi1QQ1MBkGUbOQg0uxiEZIQvX2tzt3HGxvR4jyYZBR5doWJ5MdhifpUiSb
         SBJWhjenDV1dPovAddzt56glp1Yf1YecYFofVr20PndwwGZBBh6jS7m5YJ88zcDhMI0G
         anXUFZHy0wSl6poThO85pkyqNdceDu7UapDLZ5FzCRpz8KNOOPHs4oYP+OO7vwCwQJ8A
         m/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKWd9ugbS9eAaBs6tbF2got8pFuKF8+lc8Vnf8JlWVLuZBzmmHiUmQoU4ps9wgYg0ccTcDh7QTmHZKdBNzRgIErix+tNcbdV3iclrnVRE+i2oo+vNfFOJSKateJHORtcfutdpErPy6lD7r35HRZ0bUiDicfK+yC8dnboQuEAgtrSwTnLfX
X-Gm-Message-State: AOJu0Yy7HgRSB0q1bO/jQ34A7QcsyQgjENspm+5Tjn1Z8Z/cn1sXRHco
	dfoWoZvft4Q181SKYhFTPGqh+1OzZ5cB2KdA1LOWpVWFGAcfLY95uI4BUu5eQDTLwVmSDn84jRk
	D1HpJ5FutfmAfixscm9JhD8ztoD0=
X-Google-Smtp-Source: AGHT+IFrh/8pgurQdSvgoM/FQw8kwQcem4PV9asiC18rj6sJlIga3mn5rCQUYEgp4rHMJmd1VYL9xMjVRdG002WnAHk=
X-Received: by 2002:a17:906:3e4b:b0:a3f:6513:1489 with SMTP id
 t11-20020a1709063e4b00b00a3f65131489mr5774318eji.55.1709038051151; Tue, 27
 Feb 2024 04:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227013221.21512-1-zhi.mao@mediatek.com> <20240227013221.21512-3-zhi.mao@mediatek.com>
In-Reply-To: <20240227013221.21512-3-zhi.mao@mediatek.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2024 14:46:54 +0200
Message-ID: <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: mchehab@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com, 
	shengnan.wang@mediatek.com, yaya.chang@mediatek.com, 10572168@qq.com, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, yunkec@chromium.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, jacopo.mondi@ideasonboard.com, 
	hverkuil-cisco@xs4all.nl, heiko@sntech.de, jernej.skrabec@gmail.com, 
	macromorgan@hotmail.com, linus.walleij@linaro.org, hdegoede@redhat.com, 
	tomi.valkeinen@ideasonboard.com, gerald.loacker@wolfvision.net, 
	bingbu.cao@intel.com, dan.scally@ideasonboard.com, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 3:33=E2=80=AFAM Zhi Mao <zhi.mao@mediatek.com> wrot=
e:
>
> Add a V4L2 sub-device driver for Galaxycore GC08A3 image sensor.

..

> +/*
> + * gc08a3.c - gc08a3 sensor driver

Drop the filename from the file, it's impractical (esp. if the file
will be renamed for some reason in the future).

> + *
> + * Copyright 2023 MediaTek
> + *
> + * Zhi Mao <zhi.mao@mediatek.com>
> + */

..

> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/units.h>

This is a semi-random list of inclusions. Please, follow the IWYU
(Include What You Use) principle. *At least* this list misses the
following:  array_size.h, bits.h, container_of.h, device.h, err.h,
i2c.h, math64.h, module.h, mod_devicetable.h, property.h, types.h.

..

> +       /*update crop info to subdev state*/

Missing spaces.

..

> +       /*update fmt info to subdev state*/

Ditto.

..

> +static int gc08a3_test_pattern(struct gc08a3 *gc08a3, u32 pattern_menu)
> +{
> +       u32 pattern =3D 0;

No, please use the default case for this assignment.

> +       int ret;
> +
> +       if (pattern_menu) {
> +               switch (pattern_menu) {
> +               case 1:
> +                       pattern =3D 0x00;
> +                       break;
> +               case 2:
> +                       pattern =3D 0x10;
> +                       break;
> +               case 3:
> +               case 4:
> +               case 5:
> +               case 6:
> +               case 7:
> +                       pattern =3D pattern_menu + 1;
> +                       break;
> +               }
> +
> +               ret =3D cci_write(gc08a3->regmap, GC08A3_REG_TEST_PATTERN=
_IDX,
> +                               pattern, NULL);
> +               if (ret)
> +                       return ret;
> +

> +               ret =3D cci_write(gc08a3->regmap, GC08A3_REG_TEST_PATTERN=
_EN,
> +                               GC08A3_TEST_PATTERN_EN, NULL);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               ret =3D cci_write(gc08a3->regmap, GC08A3_REG_TEST_PATTERN=
_EN,
> +                               0x00, NULL);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;

'else' is redundant, but you can deduplicate code above with

  return cci_write(...);
} else {
  return cci_write(...);
}

Of course you can go even further, but I think with the above it will
be balanced to the way that it's easy to understand how branches
behave ('else' in this case helps to indent semantically coupled
lines).

> +}


> +       /*
> +        * Applying V4L2 control value only happens
> +        * when power is on for streaming
> +        */

Respect English grammar and punctuation, i.e. don't forget periods at
the end of sentences in multi-line comments.

..

> +       endpoint =3D
> +               fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> +                                               FWNODE_GRAPH_ENDPOINT_NEX=
T);
> +       if (!endpoint) {

Strictly speaking dev_fwnode(dev) might be NULL or an error pointer. I
dunno how the graph is implemented there and if it's possible to get
an error pointer out of it. At least this probably needs to be aligned
there at some point.

> +               dev_err(dev, "endpoint node not found\n");
> +               return -EINVAL;
> +       }

..

> +static const struct dev_pm_ops gc08a3_pm_ops =3D {
> +       RUNTIME_PM_OPS(gc08a3_power_off, gc08a3_power_on, NULL)
> +};

There is a DEFINE_* PM macro, use it.

..

> +

Redundant blank line.

> +module_i2c_driver(gc08a3_i2c_driver);

--=20
With Best Regards,
Andy Shevchenko

