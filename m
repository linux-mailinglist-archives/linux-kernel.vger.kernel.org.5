Return-Path: <linux-kernel+bounces-80414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5E866843
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF651F21579
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06DDFBE8;
	Mon, 26 Feb 2024 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gABuLbM8"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE91C36;
	Mon, 26 Feb 2024 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914766; cv=none; b=Wqg1hVJz4HWi0cvhuipIQj/W50tYoLUgIfdW5COFyO4yudC+QbPptXGmJ/WIFExEpPSBOrhmfFXgyGr3lKi0SgoUqjywSBc9H+dIdxXcIZ/VkX+tbL1NcIG9xqm48DCVBPRhqJCOv1tLrBDeE/5NGlM75TSpxhVZcVM0Jg//0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914766; c=relaxed/simple;
	bh=x7ypNxuGV0GH5Mw5X+epyYf/1KvgE5foo/xUlEq57q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNwjojXCX4FSHZMd9inf3DcCPVo5R4xH+pxhYxddWYvB8nsav42VVi5iyOLZ0YsQ7dIiVQLJ0chtDiRkH96kMfHcKxxm3KJ1E3sgT+01V1p1tKl5yDdxcVNftHkwFEPbFppD/MrN2wzOFpiIyajB283qEm7DNEz/BUG49+G2+wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gABuLbM8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26fa294e56so445914566b.0;
        Sun, 25 Feb 2024 18:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708914763; x=1709519563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7592ePgFkZ3wf9F+9GErNDj+Zj7BmuSGb1sohltj17U=;
        b=gABuLbM8qyCXA3WYSB1y0Lzh+4WOJff6fVJ/PYSBCbnsStyxLGg9hv6eCDLfD67hNs
         w5zoLJkuzu194VBXzbL8/JL9o94JAVorymkWDSL7ToJmHt+f/y4U5iGEwFTo5820Oq96
         eHHWP+LigdHi6ZIG9ZaEAC0O8+iBUAA54RXVS8vZpjA65Pevnm0rxQe304E5cDm/+pXP
         uowgqpAW7TuMUtgMe/6BGDucHEsDzRhXqAPWc4rt9nHtevibVv5P3Bwx8CA2wZisN4us
         j4jSNFwf94vibKJY9NSRQVPcH/eDAGgAEBll+nbr02RkL+5D7/YfyizpuTndHGQqBhD4
         xlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708914763; x=1709519563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7592ePgFkZ3wf9F+9GErNDj+Zj7BmuSGb1sohltj17U=;
        b=N0iRzGqYGQ7mU1O2AbAliO7JQCpt0aTpGolZEkHQm3aQLLnjGcUblzjqQstJ0J9oH+
         UZga/8h6BHlpAI/vWIsfEJnuKfspsbTCMcH9S8U/yFUgBjHSmK1GAyjrdsYTNThICazr
         +alntovf8wRUzwwob/Mw4yAB7MrRm92mfBsYHDSRulVUUsuzXaF0qh/5FPc4/IxipU0z
         D5JKijzfxGBMNqp2o6nwSnoh3mmdSOgTzW3qrTuy6zJhO9ZMyCvuQl3/SpdKY07Ov94A
         kf/gUAkNmNlJEJUDfdAdhE0f7d6oMntsEF5k3EnYfXuc0oaApHaYhb2oxTzX2xZL5OQx
         wgpA==
X-Forwarded-Encrypted: i=1; AJvYcCXI9QUDr7fKTg0Hsb10dNawTmPTmmQd5N/Ib4p6oj+plObMVZwQKec+oRfHubOIxI0jLIi9rBgpsq+qLpde9NqrV3Kx8v8gGb5IemnDChIY+51ENCME0s0+0UMa8du27BfRiTRARJHBODT/uOSHbY6vbhbkBWwseTocoYw0XJ871Sgk4Sw=
X-Gm-Message-State: AOJu0YwVDuHV4tV+a+WSwPodBASvF7c0r40Ga3b4RA3RTIgfwQjguNhe
	ZHykoPGxZfwmP5kpjZgcBjm5jiUy8z+gd/E9ty11E7/RbKncCrSfFWvzWEhEttOQAav2l0vMnYo
	fGcW+Se5RN0WkXHQHoe1Yn2FSgGs=
X-Google-Smtp-Source: AGHT+IHnaT8hfKJ0sl8AaIF7tdmFSVtvG+39OIa6yBrdbdGh2soTFXymSLCzHrDoXET5hGP/zeEGKGmAocKtHUBcEZA=
X-Received: by 2002:a17:906:7fc9:b0:a3f:ac54:5aa1 with SMTP id
 r9-20020a1709067fc900b00a3fac545aa1mr3497099ejs.21.1708914762641; Sun, 25 Feb
 2024 18:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz> <20240225213423.690561-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240225213423.690561-2-chris.packham@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2024 04:32:06 +0200
Message-ID: <CAHp75Vcntz68xdr20JuXpHjM6vog=FZm2qGYPxOTRsFhmVe32Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: Add 7 segment LED display driver
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: ojeda@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, geert@linux-m68k.org, pavel@ucw.cz, 
	lee@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 11:34=E2=80=AFPM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add a driver for a 7 segment LED display. At the moment only one
> character is supported but it should be possible to expand this to
> support more characters and/or 14 segment displays in the future.

(I try to comment only on the things that will remain after rebasing
on top of auxdisplay:for-next)

..

> +config SEG_LED
> +       bool "Generic 7 segment LED display"

Why can't it be a module?

> +       select LINEDISP
> +       help
> +         This driver supports a generic 7 segment LED display made up
> +         of GPIO pins connected to the individual segments.

Checkpatch wants 3+ lines of help, I would add the module name (after
changing it to be tristate, etc).

..

> + * The GPIOs are wired to the 7 segments in a clock wise fashion startin=
g from

clockwise

> + * the top.

..

> + * The decimal point LED presnet on some devices is currently not

present

> + * supported.

..

> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/map_to_7segment.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

This is not used. And actually shouldn't be in a new code like this
with rare exceptions.

> +#include <linux/platform_device.h>

This is rather semirandom, please use IWYU (Include What You Use)
principle. We have, among others, container_of.h, types.h, err.h,
bitmap.h, mod_devicetable.h.

..

With

    sturct device *dev =3D &pdev->dev;

the below code will be neater.

> +       priv =3D devm_kzalloc(&pdev->dev, struct_size(priv, curr, 1), GFP=
_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +       priv->num_char =3D 1;
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       priv->segment_gpios =3D devm_gpiod_get_array(&pdev->dev, "segment=
", GPIOD_OUT_LOW);
> +       if (IS_ERR(priv->segment_gpios))
> +               return PTR_ERR(priv->segment_gpios);

..

> +static struct platform_driver seg_led_driver =3D {
> +       .probe =3D seg_led_probe,
> +       .remove =3D seg_led_remove,
> +       .driver =3D {
> +               .name =3D "seg-led",
> +               .of_match_table =3D seg_led_of_match,
> +       },
> +};

> +

Redundant blank line.

> +module_platform_driver(seg_led_driver);
> +
> +MODULE_AUTHOR("Chris Packham <chris.packham@alliedtelesis.co.nz>");
> +MODULE_DESCRIPTION("7 segment LED driver");
> +MODULE_LICENSE("GPL");

> +

Seems like a redundant blank line at the end of the file.

--=20
With Best Regards,
Andy Shevchenko

