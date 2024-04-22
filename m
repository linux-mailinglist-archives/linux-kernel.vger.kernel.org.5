Return-Path: <linux-kernel+bounces-154035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692638AD66F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28000283281
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEBC1CAB5;
	Mon, 22 Apr 2024 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oY46gCLZ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6EF1C6B7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820653; cv=none; b=Hx3NK+OPlNbyxxDzeBZALPUuVguAE01MDa5DLDCpZ6lrmPtsx8iUn/OKEWB8JP47c4rMCxv2lqXzqqjeEqt7ez31Pqo7djTFW8QWBxenC7nsRQx7xbukTEWl7jXjBmYXLQanSENbq2MrFb9jw39hYjCCBuUmettON1pcb1Ls5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820653; c=relaxed/simple;
	bh=w3Q+wQOpav2gOZ+17YRsHwAWTy1x6MK2uY716ta7Fj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atLaQqLBYk2QTxmkEXobiAEQup2K+ztYehNfpGC7feFDTl5IigkTYpDB9wkHPisvPhkEWDZkM+djk9GYUrV51mcwYjt81hknZSUcTZekks7Dw+FTstuQNyvc3hnTs1c6PbnVCFgC2zls53h+2xaUUQyRIcMHP8eM32qs2W2H/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oY46gCLZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57215beb016so772647a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713820648; x=1714425448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0hAn5Mx/R8pfZ4somXg4+rh6iyVeFiKWQ6gBcIcmHA=;
        b=oY46gCLZnXbxrGdyuUM7e3LU9kouSRUA8zX8N3LfLXgko32ge894TqcQ+5jzKV5vAq
         ZUDrEUCygdVyUSFGU4L206k6ZKh4zOaiw26f5dXGieElSJTG1no2nW50KZvV+T0Cw8K/
         l/+XFikUDTfXhHRs8ymXaIv+8CJglNd63LMUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713820648; x=1714425448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0hAn5Mx/R8pfZ4somXg4+rh6iyVeFiKWQ6gBcIcmHA=;
        b=j7jnGrtIudyJXsoR/SLOpF7b/RpZqAZErvE5MvUb246TG8B3h/ry5VzlibOLuBzAjk
         L/OHkFnBZaDrZlUUdz+3oYgpBbF6HzzEFoXoXd2XqLdepzZWCSCib9eAj4bKmQG412bx
         8GkvLw62FL5AF9wGGX3m3rEBVqgORSO3xG9AInLrWWwOB7JioQiNidkok3Y9/CVlV96c
         IwWbChydiQ9upUVyDAlU1u87DSZPeb5YV67+oSqD1+COCp3+MBUvMXuo2gUnb4HDCgvI
         VJ5AFHilyuZXvFlJCuSUSlm4X7rIlI11S2/VLaS2yP/ZYvNV+7RfpgAqfm6A6LMVgksZ
         GtnA==
X-Forwarded-Encrypted: i=1; AJvYcCVGJAK3dHfQZp9W6lYaemksfq+5WEjggil4eDcjrfROOK2H87lsJ0axcKKMrAHWSt7lJQT/hpfFmkrfGxMT/pux+KnM02grT4b+cvGs
X-Gm-Message-State: AOJu0YzyMXL8AJBkSzGW7yWoIwMHD+k0y+UefdYZa2Enh/7c3lrqLmU4
	7G8WLRhJ8WB/Fy4fS3yf0+bY5qtUUxCBO/qgfNDxR07y3oQehjkFvfKP6ulmI8ooLShZfYIeLNC
	XLYuK
X-Google-Smtp-Source: AGHT+IGP7h6lqu1iMua8rXEer6/+6gfB/wjAPUwftdh8Q/5cDO36oiLUOHv2dRtTlbow2GGNZx5qkA==
X-Received: by 2002:a50:9553:0:b0:570:2198:b3ca with SMTP id v19-20020a509553000000b005702198b3camr7509688eda.14.1713820647955;
        Mon, 22 Apr 2024 14:17:27 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id w12-20020a056402128c00b005701550ddc5sm5915530edv.90.2024.04.22.14.17.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 14:17:27 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a428374b9so7585e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:17:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBRkzSBB+ZdjXBc3gH2xKqxlZPaMAGTW4Jen0SVwumPo/F3lFeCwO2mz3yIGRIGvnSNdSurp64x32tl1ZsMpenivVkacdqIA4pYbIv
X-Received: by 2002:a05:600c:4f15:b0:418:97c6:188d with SMTP id
 l21-20020a05600c4f1500b0041897c6188dmr14104wmq.7.1713820645655; Mon, 22 Apr
 2024 14:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
 <20240422090310.3311429-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240422090310.3311429-3-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 14:17:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2O2aFDVn5CjbXfgcOLkmNp-G3ChVqQKouB2mDB+NZug@mail.gmail.com>
Message-ID: <CAD=FV=V2O2aFDVn5CjbXfgcOLkmNp-G3ChVqQKouB2mDB+NZug@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 2:03=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The Starry HX83102 based mipi panel should never have been part of the bo=
e
> tv101wum driver. Discussion with Doug and Linus in V1 [1], we need a
> separate driver to enable the hx83102 controller.
>
> In hx83102 driver, add DSI commands as macros. So it can add some panels
> with same control model in the future.
>
> [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=3DzBQJUC4CB2wj4s1h6n6aSAZ=
QvdMV95r3zRUw@mail.gmail.com
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  99 ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c   | 567 ++++++++++++++++++
>  4 files changed, 577 insertions(+), 99 deletions(-)
>  create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83102.c
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfi=
g
> index d037b3b8b999..eb378c897353 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -145,6 +145,15 @@ config DRM_PANEL_LVDS
>           handling of power supplies or control signals. It implements au=
tomatic
>           backlight handling if the panel is attached to a backlight cont=
roller.
>
> +config DRM_PANEL_HIMAX_HX83102
> +       tristate "himax HX83102-based panels"

Capital "h" for "Himax".


> +#define DRV_NAME "panel-himax-hx83102"

I don't think DRV_NAME buys you very much. Get rid of this #define and
just use it below.


> +struct hx83102 {
> +       struct drm_panel base;
> +       struct mipi_dsi_device *dsi;
> +
> +       const struct hx83102_panel_desc *desc;
> +
> +       enum drm_panel_orientation orientation;
> +       struct regulator *pp1800;
> +       struct regulator *avee;
> +       struct regulator *avdd;
> +       struct gpio_desc *enable_gpio;
> +
> +       bool prepared;

We're trying to get rid of the tracking of "prepared" in panels. You
should be able to delete this and remove the code dealing with it. The
core DRM code should ensure that your prepare/unprepare functions are
called appropriately.



> +struct hx83102_panel_desc {
> +       const struct drm_display_mode *modes;
> +       unsigned int bpc;
> +
> +       /**
> +        * @width_mm: width of the panel's active display area
> +        * @height_mm: height of the panel's active display area
> +        */
> +       struct {
> +               unsigned int width_mm;
> +               unsigned int height_mm;
> +       } size;
> +
> +       unsigned long mode_flags;
> +       enum mipi_dsi_pixel_format format;
> +       unsigned int lanes;
> +       bool lp11_before_reset;

Seems like you can remove "lp11_before_reset" since it's always true
for this controller. If later you find someone using this controller
that needs this false then we can always add it back in.

I think you could also remove "bpc", "format", and "mode_flags". If
these are all the same controller then that will be common between all
the panels, right? So you shouldn't need to define those on a
per-panel basis... You could maybe even remove "lanes" unless some
people using this panel are expected to hook up fewer lanes...


> +static int starry_init_cmd(struct hx83102 *ctx)
> +{
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +
> +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETEXTC, 0x83, 0x10, 0x21, 0x=
55, 0x00);
> +
> +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x2C, 0xB5, 0xB5, 0=
x31, 0xF1, 0x31, 0xD7, 0x2F,
> +                                                 0x36, 0x36, 0x36, 0x36,=
 0x1A, 0x8B, 0x11, 0x65, 0x00, 0x88, 0xFA, 0xFF,
> +                                                 0xFF, 0x8F, 0xFF, 0x08,=
 0x74, 0x33);

I know this is a sticking point between Linus W. and me, but I'm
really not a fan of all the hardcoded function calls since it bloats
the code so much. I think we need to stick with something more table
based at least for the majority of the commands. If I understand
correctly, Linus was OK w/ something table based as long as it was in
common code [1]. I think he also wanted the "delay" out of the table,
but since those always seem to be at the beginning or the end it seems
like we could still have the majority of the code as table based. Do
you want to make an attempt at that? If not I can try to find some
time to write up a patch in the next week or so.

[1] https://lore.kernel.org/r/CACRpkdYtM=3D5jdQddCqRFgBRXvcJEjk1ULJNKKFz7jh=
hkGxV59Q@mail.gmail.com

..also: nit that, in general, the Linux community prefers lowercase
hex, so 0xfa instead of 0xFA, for instance.


> +static int hx83102_get_modes(struct drm_panel *panel,
> +                           struct drm_connector *connector)
> +{
> +       struct hx83102 *ctx =3D panel_to_hx83102(panel);
> +       const struct drm_display_mode *m =3D ctx->desc->modes;
> +       struct drm_display_mode *mode;
> +
> +       mode =3D drm_mode_duplicate(connector->dev, m);
> +       if (!mode) {
> +               dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> +                       m->hdisplay, m->vdisplay, drm_mode_vrefresh(m));
> +               return -ENOMEM;
> +       }

nit: no need for an error message when drm_mode_duplicate() fails. It
is incredibly unlikely that the allocation will fail and the Linux
kernel will already do a stack crawl in the case that it does fail.


> +       /*
> +        * TODO: Remove once all drm drivers call
> +        * drm_connector_set_orientation_from_panel()
> +        */
> +       drm_connector_set_panel_orientation(connector, ctx->orientation);

Pretty sure you can drop the call to
drm_connector_set_panel_orientation() here. I believe that nearly
everyone is using panel_bridge which will handle this for you.


> +static int hx83102_panel_add(struct hx83102 *ctx)
> +{
> +       struct device *dev =3D &ctx->dsi->dev;
> +       int err;
> +
> +       ctx->avdd =3D devm_regulator_get(dev, "avdd");
> +       if (IS_ERR(ctx->avdd))
> +               return PTR_ERR(ctx->avdd);
> +
> +       ctx->avee =3D devm_regulator_get(dev, "avee");
> +       if (IS_ERR(ctx->avee))
> +               return PTR_ERR(ctx->avee);
> +
> +       ctx->pp1800 =3D devm_regulator_get(dev, "pp1800");
> +       if (IS_ERR(ctx->pp1800))
> +               return PTR_ERR(ctx->pp1800);
> +
> +       ctx->enable_gpio =3D devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW)=
;
> +       if (IS_ERR(ctx->enable_gpio)) {
> +               dev_err(dev, "cannot get reset-gpios %ld\n",

it's not "reset-gpios".


> +                       PTR_ERR(ctx->enable_gpio));
> +               return PTR_ERR(ctx->enable_gpio);

Rather than the above, use "dev_err_probe" and combine into one line. Untes=
ted:

if (IS_ERR(ctx->enable_gpio))
  return dev_err_probe(dev, PTR_ERR(ctx->enable_gpio), "Cannot get
enable GPIO\n");


> +       }
> +
> +       gpiod_set_value(ctx->enable_gpio, 0);

You don't need the above line. When you got the GPIO you already
passed "GPIOD_OUT_LOW" which means that this is redundant.


> +
> +       ctx->base.prepare_prev_first =3D true;
> +
> +       drm_panel_init(&ctx->base, dev, &hx83102_drm_funcs,
> +                      DRM_MODE_CONNECTOR_DSI);
> +       err =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientat=
ion);
> +       if (err < 0) {
> +               dev_err(dev, "%pOF: failed to get orientation %d\n", dev-=
>of_node, err);
> +               return err;
> +       }

Could also use "dev_err_probe" to make the above one line. Not sure
you really need the of_node name, too...

if (err < 0)
  return dev_err_probe(dev, err, "failed to get orientation\n");

-Doug

