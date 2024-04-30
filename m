Return-Path: <linux-kernel+bounces-164634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685F8B8072
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E3F1F23CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59941A0AE6;
	Tue, 30 Apr 2024 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LLXZhjCu"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA44194C92
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714504778; cv=none; b=GcWwYLrvURAjwcoIwp+Ynle4bf/+XvSl45rOhMiMhKoeU3YdF3MHnYxV9XDrYpRQj6EAKfGP4l+iPT7RBlAYv6N/yDopSnYqeKFYKRGycfL2A226FlSqCbFlPBlJDGEINX6FERH98eF4h7Beq089/EzjUzuz9azDNosITN/fW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714504778; c=relaxed/simple;
	bh=5pSVtC2ksg2Mok+LHTEgFdOKuFldFG7+niyA1NtDAbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pY/ehBwI3s42eyl6zKY6PR8AJ6+OzKyP4wpbS+L8VZsFe4kxBdmoBaqfim7BpJi/AhrvSaCNrRVBeZL0sTuVFQ2hJbT0xVWiITCICVl63oIe6hZk+cL0TB7g1ZnAA25y6kMkg6bQetz+bmgJCrJToCBF4Tej6LrNwJXcY+Vuw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LLXZhjCu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6a04bb4f6d5so38518496d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714504772; x=1715109572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbZQq10/Z/JPNfAxQJ6o70za+zNWi0Nqkl9SjN1VaTg=;
        b=LLXZhjCuqzRTIGQPMCxh+mmfc1r4JKyYv9yp2fy6+QLpW/aLAfuwT84jh2fO5Hohm3
         hUhl5LpVReNXaNYrDXWUveDpDivoFZGPUrF/loSGBbOBKa3zU5L3GeadXugUCm21Z4OO
         GN0a3n5BTJySwdeC3PP3CrVp2VUXOrKqC7l7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714504772; x=1715109572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbZQq10/Z/JPNfAxQJ6o70za+zNWi0Nqkl9SjN1VaTg=;
        b=UM2EpzzcuNS89jTkdstMDLxHm1aoE7epkZAfEfB4ALJc56NMCpOavKbPUIqhkfdYHN
         Mf8bodcF5bd18vdmiR5wGj5V50qSllCW8fxYM7kplbd43iBdTtIx8alcRYP6aDjyyI74
         hniRwHIG2iwT4u5Jg77OiBk1yiCMtirf+BKM+sYezYbRgVhFGHrRZlmWHorlr9Yhp2Mu
         Fx9Jf5Xj7EO/M3rV0+Bp1mCLBNFvV6ecNMCKeVf6lSPZ4UZNr7VS24g68BFjY/3MWL17
         y2TCKFGc9SuSOpkvmUxn+44Vo7YJYY+qo7nd7kbuRjRC4YsNLLdEKYuOvdNjKYlPKopx
         DwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW32aaFIO1/KPuuBAg6F4dq7KaUaLt3LyyTKRhxbScXYGZQl4GXbvVlbza6bDEcku9lMHqEloRi1QmwDbvFLpUTlQj9piqcdSDBMhr
X-Gm-Message-State: AOJu0YxrkOYN8n0XMS1HMpJt1UQOyH17P454WiJtwzTT0T+Lyjs0+FGz
	TrSGlw2E4mnxGJ9ibLsydEdcDYzKKHWIz1u+xQU/jjny00FKx02faRt4a3Dfmv07toyZvc6MyO0
	=
X-Google-Smtp-Source: AGHT+IFdn34aB5dumrsiemZkLi6O0WQjpLgPHSFbWaRRo0ZiU9+tDm+yHiJ7zC55QEGLIsSYoGOGNQ==
X-Received: by 2002:a05:6214:485:b0:69b:2aa8:dc5d with SMTP id pt5-20020a056214048500b0069b2aa8dc5dmr321057qvb.64.1714504771783;
        Tue, 30 Apr 2024 12:19:31 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id y7-20020a056214016700b006a0e8c1d7a5sm381127qvs.120.2024.04.30.12.19.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 12:19:31 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-436ed871225so58071cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:19:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlTXlryGkZ3e1x68nltSexdTtiZBuEQz+IL09UaTpL+f757Y/FCDuowqDS/sWgnd3xqgYc/gCqkToEljk3bZjoYJluZ27feBGzKOLS
X-Received: by 2002:a05:622a:1183:b0:43a:e2ea:bfa5 with SMTP id
 m3-20020a05622a118300b0043ae2eabfa5mr42527qtk.17.1714504768727; Tue, 30 Apr
 2024 12:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
 <20240424023010.2099949-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240424023010.2099949-3-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Apr 2024 12:19:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VFk3epSxksh+n_LupTiZp=gK=LB2NESGy5iNF=5xFAmg@mail.gmail.com>
Message-ID: <CAD=FV=VFk3epSxksh+n_LupTiZp=gK=LB2NESGy5iNF=5xFAmg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2024 at 7:30=E2=80=AFPM Cong Yang
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
> Chage since V3:
>
> -  Drop excess flags and function, inital cmds use lowercasehex.
>
> V2: https://lore.kernel.org/all/20240422090310.3311429-3-yangcong5@huaqin=
corp-partner.google.com
>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  99 ----
>  drivers/gpu/drm/panel/panel-himax-hx83102.c   | 525 ++++++++++++++++++
>  4 files changed, 535 insertions(+), 99 deletions(-)

It probably makes sense to base your series upon mine that reduces
bloat / introduces a better way to do these init sequences. I'm going
to wait one more day in case anyone else has any more comments on my
v2 and then I'll post my v3. So far everyone has been on-board with
the overall goal and so all we need to do is iron out the small
details, so I don't expect it to take too long.

If you want to wait a day or two and then post your patches atop my v3
(once I post it) then that would be OK by me.


> @@ -0,0 +1,525 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for panels based on Himax HX83102 controller, such as:
> + *
> + * - Starry 10.51" WUXGA MIPI-DSI panel
> + *
> + * Based on drivers/gpu/drm/panel/panel-boe-tv101wum.c

The above file doesn't exist? Maybe you forgot the "-nl6" suffix? I
would also say that this driver appears to be more similar to
`panel-himax-hx8394.c` even if the data came from
`panel-boe-tv101wum-nl6.c`.

..also, since this is based on `panel-himax-hx8394.c`, it seems like
you're making pretty significant changes here. For instance, when this
code was part of `panel-boe-tv101wum-nl6.c` it used to do the "init
commands" as part of prepare. With the new driver it does it as part
of "enable". IMO even if the new code based on `panel-himax-hx8394.c`
is more correct, I'd rather see you change that in a separate change.
In this change, which is supposed to be more about code refactoring, I
think you should focus on keeping the behavior before and after your
patch identical.


> +/* Manufacturer specific DSI commands */
> +#define HX83102_SETPOWER       0xb1
> +#define HX83102_SETDISP                0xb2
> +#define HX83102_SETCYC         0xb4
> +#define HX83102_SETEXTC                0xb9
> +#define HX83102_SETMIPI                0xba
> +#define HX83102_SETVDC         0xbc
> +#define HX83102_SETBANK                0xbd
> +#define HX83102_UNKNOWN1       0xbe

I'm not sure that the "unknown" define helps much, but I guess it's
fine. One nit would be to call this UNKNOWN_BE based on the address so
that if we can later replace some of the unknowns then there won't be
gaps in the numbering.


> +#define HX83102_SETPTBA                0xbf
> +#define HX83102_SETSTBA                0xc0
> +#define HX83102_SETTCON                0xc7
> +#define HX83102_SETRAMDMY      0xc8
> +#define HX83102_SETPWM         0xc9
> +#define HX83102_SETCLOCK       0xcb
> +#define HX83102_SETPANEL       0xcc
> +#define HX83102_SETCASCADE     0xd0
> +#define HX83102_SETPCTRL       0xd1
> +#define HX83102_UNKNOWN2       0xd2
> +#define HX83102_SETGIP0                0xd3
> +#define HX83102_SETGIP1                0xd5
> +#define HX83102_UNKNOWN3       0xd6

Given everything surrounding it and given a datasheet I have for a
similar panel, I'm going to guess UNKNOWN3 is "GIP2".


> +#define HX83102_SETGIP3                0xd8
> +#define HX83102_UNKNOWN4       0xe0

I think UNKNOWN4 is SETGMA to set the gamma curve.


> +static int starry_init_cmd(struct hx83102 *ctx)
> +{
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +
> +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETEXTC, 0x83, 0x10, 0x21, 0x=
55, 0x00);

As far as I can tell from looking at a different (but similar)
datasheet, the above means "enable extended command set". Assuming I'm
correct, maybe you could abstract out:

static int hx83102_enable_extended_cmds(struct hx83102 *ctx, bool enable)
{
  if (enable)
    mipi_dsi_dcs_write_seq(dsi, HX83102_SETEXTC, 0x83, 0x10, 0x21, 0x55, 0x=
00);
  else
    mipi_dsi_dcs_write_seq(dsi, HX83102_SETEXTC, 0x00, 0x00, 0x00);
}

Then your panel-specific init functions could call that?

Speaking of which, some of the panels that you add to this driver seem
to disable extended commands at the end of their init sequence, but
this one doesn't. Should it?


> +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x2c, 0xb5, 0xb5, 0=
x31, 0xf1, 0x31, 0xd7, 0x2f,
> +                                                 0x36, 0x36, 0x36, 0x36,=
 0x1a, 0x8b, 0x11, 0x65, 0x00, 0x88, 0xfa, 0xff,
> +                                                 0xff, 0x8f, 0xff, 0x08,=
 0x74, 0x33);

nit: Can you make your indentation cleaner? Right now when a function
call extends to multiple lines the subsequent lines are indented a
somewhat random amount of space that probably has to do with how much
they needed to be indented before.

..though if you base on my v3 series that I'll send out tomorrow then
probably you'd just move this over and the indentation would be right.


> +
> +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETDISP, 0x00, 0x47, 0xb0, 0x=
80, 0x00, 0x12, 0x72, 0x3c,
> +                                                 0xa3, 0x03, 0x03, 0x00,=
 0x00, 0x88, 0xf5);
> +
> +       mipi_dsi_dcs_write_seq(dsi, HX83102_SETCYC, 0x76, 0x76, 0x76, 0x7=
6, 0x76, 0x76, 0x63, 0x5c,
> +                                                 0x63, 0x5c, 0x01, 0x9e)=
;

nit: I wouldn't have put a blank line between every function call.


> +static int hx83102_enable(struct drm_panel *panel)
> +{
> +       struct hx83102 *ctx =3D panel_to_hx83102(panel);
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       struct device *dev =3D &dsi->dev;
> +       int ret;
> +
> +       ret =3D ctx->desc->init_cmds(ctx);
> +       if (ret) {
> +               dev_err(dev, "Panel init cmds failed: %d\n", ret);
> +               return ret;
> +       }

nit: don't call it "init_cmds" now that it's not a cmdlist anymore. In
my patch series converting things I called it "init". Seems like
"hx8394.c" calls it "init_sequence". Either would be fine.

nit: the init function already prints errors so you don't need to.
Just return the error without printing.


> +       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> +       if (ret) {
> +               dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> +               return ret;
> +       }
> +
> +       msleep(120);
> +
> +       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> +       if (ret) {
> +               dev_err(dev, "Failed to turn on the display: %d\n", ret);
> +               goto sleep_in;
> +       }
> +
> +       msleep(130);
> +
> +       return 0;
> +
> +sleep_in:
> +       ret =3D mipi_dsi_dcs_enter_sleep_mode(dsi);
> +       if (!ret)
> +               msleep(50);

The above is broken (but it's also broken in the driver that you
copied this from). Specifically imagine that the call to
mipi_dsi_dcs_set_display_on() above failed. "ret" will have an error
code and you'll jump to "sleep_in". Now, imagine that
mipi_dsi_dcs_enter_sleep_mode() _didn't_ fail. Since you store the
result in the same variable "ret" you'll clobber the error code that
mipi_dsi_dcs_set_display_on() returned and you'll return "0" (no
error) from this function. That's not right.


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
> +               return dev_err_probe(dev, PTR_ERR(ctx->enable_gpio), "Can=
not get enable GPIO\n");
> +       }

nit: remove braces since the above is now one line.

