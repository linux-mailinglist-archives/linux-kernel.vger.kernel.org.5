Return-Path: <linux-kernel+bounces-154796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6425D8AE123
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DF71C21C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7C5914C;
	Tue, 23 Apr 2024 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyidxWIk"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD19224D7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865077; cv=none; b=tpkPIX+9r67q2u5cs9F9dhjs3oY6ZzTULdVeuJzebET4bvGmvCFiA8lTzsXtMaxDpf4Lpnwih0sFPtaC7brB+QV/i7vxb/mITl+cCQSyoiqi7ezHcO35rbi4OMhnF6PLrm3zLfZ2sszxYLpJSK7fyC6VKZogP5ASnfAL9fHMyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865077; c=relaxed/simple;
	bh=o0UF/opQcStCOkx3zfWgVYWw9S4Qct8KhuyRHKSbePs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvhnGr+Wi42ExJZQ+B5WEr6OYH2DCYBnStecFMjHgup8t/P9L+HA5GYFkWh44YSwxZSIBZqYVgtDzwxOyqdjEwEK24RX01yUg5nYyeEAFhMobhAhZtxz8WbT1hbLPDnqolUh5hiHNfE6ELoiwgpVgBkC0Ig4nKcO4vL4zs4JKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hyidxWIk; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6001399f22bso1443835a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713865074; x=1714469874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7qEzAeGQbSR+e0QLIBsBqx0r9aehVaKkSQghGhq9Bo=;
        b=hyidxWIkhSHMgkqOTLHGKRsl45Ey98uPyVwrZZJyafctX80qaubFbD+wyy6Wnfakd6
         P4iUauSErfTagj3vIRwOMeKBv3wWWEpya98NavejjBBwFeOmg3R63gQ4KMMZTljWeAoM
         BeuDUGJ0I8NKK1byFH27G4e1ttwijqY3q8ogqyNOej1uEet3dHfLJ+Hfk9A6GrHXcykc
         e3pJJuVDY51+HKlM54XcInGeo57dYWZHbs9NhpeASM4t9T6EKQM4V3Wau1Ag5mJZjyXH
         Q+MohqPdhmMNH6uXvDsWxITwXC1ypFeEEWY7S2eRUXJWq19f5/RBck897GUK6KP6GpzV
         cIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713865074; x=1714469874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7qEzAeGQbSR+e0QLIBsBqx0r9aehVaKkSQghGhq9Bo=;
        b=cEAz39fWHPcUnHajs8ep0f88IwkDTJPpX7Kb8sEyYJQB7hlTilLXBjYphhLKu2TsbF
         IBLC1bgTG1IaYxDLDb9mj54XZAXeKMyHyDdLusA+3OK5keGJZ3ywjLtLOH0PAZpCcD/7
         qdTGCh+giwi68PUQzjYRYqC/CAp2sf3ufWsYOfkGywJjY2gF+9ASbw/ruIFM2r8doapb
         0Id1tCzxkbQtx0tfNBjYRjzDOIYstRnSiNe1HRpxr2a7Y+9iA8IOGONvRE0Fr95Qd4rB
         41xhIQrXCDpuzGazt0fmuG4DfF37oZV1IpIm4h4M/M9M0nAUnVpGczsAb9uAfyAQqC5P
         7hCg==
X-Forwarded-Encrypted: i=1; AJvYcCWxpU1Q3LQJGl1KWf3L0anDK4nNLolcLjr++2Q58CKCTavfOL4GJ8u+12rCv6LcONl31dPm6Dm+/KwI+qoBaqtHMORLZmnSIGXWxZxz
X-Gm-Message-State: AOJu0YxiVz2lGBsdGcqrVtLOtkWBGW5aaR715ITuAFBDFRz0QK90BnE0
	BKQTDhbmq8dsOb7e5TR7EID1k8LZJGlxHdJgd29EKHPisBfjJc4cD9pytvpOP2EKWXAjaqCLABE
	q+ATotuNNpZJ7y2xy4/IKIDa8v8UUQupbNEGAKg==
X-Google-Smtp-Source: AGHT+IFFLdxyFRIq+ARQuf3JajFuxDy//Aasarf/dudwTIXRsO2jCILHM+5eWcUSmNYXIIy0MyPqrmkQ2ju0iGdDttE=
X-Received: by 2002:a17:90a:fe07:b0:2ac:3c42:5839 with SMTP id
 ck7-20020a17090afe0700b002ac3c425839mr9995209pjb.1.1713865074341; Tue, 23 Apr
 2024 02:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
 <20240422090310.3311429-3-yangcong5@huaqin.corp-partner.google.com> <CAD=FV=V2O2aFDVn5CjbXfgcOLkmNp-G3ChVqQKouB2mDB+NZug@mail.gmail.com>
In-Reply-To: <CAD=FV=V2O2aFDVn5CjbXfgcOLkmNp-G3ChVqQKouB2mDB+NZug@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Tue, 23 Apr 2024 17:37:43 +0800
Message-ID: <CAHwB_NJsDsTc=gjP8TJ+6ipo10uMYFLmuf+tKGVgxnznhuAcUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: Doug Anderson <dianders@chromium.org>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Thanks for review.

Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B44=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=8C 05:24=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Mon, Apr 22, 2024 at 2:03=E2=80=AFAM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > The Starry HX83102 based mipi panel should never have been part of the =
boe
> > tv101wum driver. Discussion with Doug and Linus in V1 [1], we need a
> > separate driver to enable the hx83102 controller.
> >
> > In hx83102 driver, add DSI commands as macros. So it can add some panel=
s
> > with same control model in the future.
> >
> > [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=3DzBQJUC4CB2wj4s1h6n6aS=
AZQvdMV95r3zRUw@mail.gmail.com
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> >  drivers/gpu/drm/panel/Makefile                |   1 +
> >  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  99 ---
> >  drivers/gpu/drm/panel/panel-himax-hx83102.c   | 567 ++++++++++++++++++
> >  4 files changed, 577 insertions(+), 99 deletions(-)
> >  create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83102.c
> >
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kcon=
fig
> > index d037b3b8b999..eb378c897353 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -145,6 +145,15 @@ config DRM_PANEL_LVDS
> >           handling of power supplies or control signals. It implements =
automatic
> >           backlight handling if the panel is attached to a backlight co=
ntroller.
> >
> > +config DRM_PANEL_HIMAX_HX83102
> > +       tristate "himax HX83102-based panels"
>
> Capital "h" for "Himax".

Got it, fix in V3. Thanks.

>
>
> > +#define DRV_NAME "panel-himax-hx83102"
>
> I don't think DRV_NAME buys you very much. Get rid of this #define and
> just use it below.

Got it, fix in V3. Thanks.

>
>
> > +struct hx83102 {
> > +       struct drm_panel base;
> > +       struct mipi_dsi_device *dsi;
> > +
> > +       const struct hx83102_panel_desc *desc;
> > +
> > +       enum drm_panel_orientation orientation;
> > +       struct regulator *pp1800;
> > +       struct regulator *avee;
> > +       struct regulator *avdd;
> > +       struct gpio_desc *enable_gpio;
> > +
> > +       bool prepared;
>
> We're trying to get rid of the tracking of "prepared" in panels. You
> should be able to delete this and remove the code dealing with it. The
> core DRM code should ensure that your prepare/unprepare functions are
> called appropriately.

Got it, fix in V3. Thanks.

>
>
>
> > +struct hx83102_panel_desc {
> > +       const struct drm_display_mode *modes;
> > +       unsigned int bpc;
> > +
> > +       /**
> > +        * @width_mm: width of the panel's active display area
> > +        * @height_mm: height of the panel's active display area
> > +        */
> > +       struct {
> > +               unsigned int width_mm;
> > +               unsigned int height_mm;
> > +       } size;
> > +
> > +       unsigned long mode_flags;
> > +       enum mipi_dsi_pixel_format format;
> > +       unsigned int lanes;
> > +       bool lp11_before_reset;
>
> Seems like you can remove "lp11_before_reset" since it's always true
> for this controller. If later you find someone using this controller
> that needs this false then we can always add it back in.
>
> I think you could also remove "bpc", "format", and "mode_flags". If
> these are all the same controller then that will be common between all
> the panels, right? So you shouldn't need to define those on a
> per-panel basis... You could maybe even remove "lanes" unless some
> people using this panel are expected to hook up fewer lanes...

Okay, remove =E2=80=9Clanes=E2=80=9D together.

>
>
> > +static int starry_init_cmd(struct hx83102 *ctx)
> > +{
> > +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> > +
> > +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETEXTC, 0x83, 0x10, 0x21, =
0x55, 0x00);
> > +
> > +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x2C, 0xB5, 0xB5,=
 0x31, 0xF1, 0x31, 0xD7, 0x2F,
> > +                                                 0x36, 0x36, 0x36, 0x3=
6, 0x1A, 0x8B, 0x11, 0x65, 0x00, 0x88, 0xFA, 0xFF,
> > +                                                 0xFF, 0x8F, 0xFF, 0x0=
8, 0x74, 0x33);
>
> I know this is a sticking point between Linus W. and me, but I'm
> really not a fan of all the hardcoded function calls since it bloats
> the code so much. I think we need to stick with something more table
> based at least for the majority of the commands. If I understand
> correctly, Linus was OK w/ something table based as long as it was in
> common code [1]. I think he also wanted the "delay" out of the table,
> but since those always seem to be at the beginning or the end it seems
> like we could still have the majority of the code as table based. Do
> you want to make an attempt at that? If not I can try to find some
> time to write up a patch in the next week or so.

Do you mean not add "delay" in the table?  However, the delay
required by each panel may be different. How should this be handled?
It would be great if you could help provide a patch. Thank you so much.

>
> [1] https://lore.kernel.org/r/CACRpkdYtM=3D5jdQddCqRFgBRXvcJEjk1ULJNKKFz7=
jhhkGxV59Q@mail.gmail.com
>
> ...also: nit that, in general, the Linux community prefers lowercase
> hex, so 0xfa instead of 0xFA, for instance.

Done. Fix in V3.

>
>
> > +static int hx83102_get_modes(struct drm_panel *panel,
> > +                           struct drm_connector *connector)
> > +{
> > +       struct hx83102 *ctx =3D panel_to_hx83102(panel);
> > +       const struct drm_display_mode *m =3D ctx->desc->modes;
> > +       struct drm_display_mode *mode;
> > +
> > +       mode =3D drm_mode_duplicate(connector->dev, m);
> > +       if (!mode) {
> > +               dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> > +                       m->hdisplay, m->vdisplay, drm_mode_vrefresh(m))=
;
> > +               return -ENOMEM;
> > +       }
>
> nit: no need for an error message when drm_mode_duplicate() fails. It
> is incredibly unlikely that the allocation will fail and the Linux
> kernel will already do a stack crawl in the case that it does fail.

Got it, fix in V3. Thanks.

>
>
> > +       /*
> > +        * TODO: Remove once all drm drivers call
> > +        * drm_connector_set_orientation_from_panel()
> > +        */
> > +       drm_connector_set_panel_orientation(connector, ctx->orientation=
);
>
> Pretty sure you can drop the call to
> drm_connector_set_panel_orientation() here. I believe that nearly
> everyone is using panel_bridge which will handle this for you.

Got it, fix in V3. Thanks.

>
>
> > +static int hx83102_panel_add(struct hx83102 *ctx)
> > +{
> > +       struct device *dev =3D &ctx->dsi->dev;
> > +       int err;
> > +
> > +       ctx->avdd =3D devm_regulator_get(dev, "avdd");
> > +       if (IS_ERR(ctx->avdd))
> > +               return PTR_ERR(ctx->avdd);
> > +
> > +       ctx->avee =3D devm_regulator_get(dev, "avee");
> > +       if (IS_ERR(ctx->avee))
> > +               return PTR_ERR(ctx->avee);
> > +
> > +       ctx->pp1800 =3D devm_regulator_get(dev, "pp1800");
> > +       if (IS_ERR(ctx->pp1800))
> > +               return PTR_ERR(ctx->pp1800);
> > +
> > +       ctx->enable_gpio =3D devm_gpiod_get(dev, "enable", GPIOD_OUT_LO=
W);
> > +       if (IS_ERR(ctx->enable_gpio)) {
> > +               dev_err(dev, "cannot get reset-gpios %ld\n",
>
> it's not "reset-gpios".
>
>
> > +                       PTR_ERR(ctx->enable_gpio));
> > +               return PTR_ERR(ctx->enable_gpio);
>
> Rather than the above, use "dev_err_probe" and combine into one line. Unt=
ested:
>
> if (IS_ERR(ctx->enable_gpio))
>   return dev_err_probe(dev, PTR_ERR(ctx->enable_gpio), "Cannot get
> enable GPIO\n");

Got it, fix in V3. Thanks.

>
>
> > +       }
> > +
> > +       gpiod_set_value(ctx->enable_gpio, 0);
>
> You don't need the above line. When you got the GPIO you already
> passed "GPIOD_OUT_LOW" which means that this is redundant.

Got it, fix in V3. Thanks.

>
>
> > +
> > +       ctx->base.prepare_prev_first =3D true;
> > +
> > +       drm_panel_init(&ctx->base, dev, &hx83102_drm_funcs,
> > +                      DRM_MODE_CONNECTOR_DSI);
> > +       err =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orient=
ation);
> > +       if (err < 0) {
> > +               dev_err(dev, "%pOF: failed to get orientation %d\n", de=
v->of_node, err);
> > +               return err;
> > +       }
>
> Could also use "dev_err_probe" to make the above one line. Not sure
> you really need the of_node name, too...

Okay, fix in V3. Thanks.

>
> if (err < 0)
>   return dev_err_probe(dev, err, "failed to get orientation\n");
>
> -Doug

