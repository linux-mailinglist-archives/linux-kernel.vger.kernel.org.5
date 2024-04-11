Return-Path: <linux-kernel+bounces-140005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE4A8A0A39
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FFC1F222A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB41013DDC7;
	Thu, 11 Apr 2024 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hAHeFNwU"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56A13D623
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821260; cv=none; b=FX7rw3BUkUrApCm16Oll2dEYX20vVJaGxVKsbL4pm78BkSvQ0vpoBZEsnsoL6XVVXxxwmarb2wkDzE2skIvQ2lgXHKGFkTfxqM3ww0136iXRMhZGRehp24MlXkI139SlztAnkbximIkwj9WrMWJJEl1akDjDtU6wiZtH1IZOMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821260; c=relaxed/simple;
	bh=R0uX/xVvn2RVjrdPRgwj4lLpQHY6VHsNg+Od2h8Mims=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1lK9t1jlXANAcBylnMav9WFVttZwhxL8Pcc397nunFmjmIVeT4KFYplV6AqTGmIcC1taQDkFU7i2EG9NJ2oCRrBjB8shvaatM6vlBgotQY7nCKDaDnrSlZlQpBx/0U7NWyTXPIKxAxTI4PXnA5SGSMGiHRz0DTHchQLHdya898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hAHeFNwU; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78d61a716ddso319980085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712821256; x=1713426056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nNN6WlUUNGTzkwo1N4M16DUFdPJ6ZM0diRivpuzi2Y=;
        b=hAHeFNwU4CeQv6OpWsp2FsHgq22Rh2zXkWdmubu6jgwWh2iZdVkyhZ3tg2aEDXTGHK
         3V4xfZBaeIqg6YlXUONy0t8wvXwVb2EJSAxJ4RXOya58N97M8snW0vbTs1dk0eFo7Sbf
         3UWPoex5Kr44wZF9TvUNKSze3AWN70f3yz6hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821256; x=1713426056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nNN6WlUUNGTzkwo1N4M16DUFdPJ6ZM0diRivpuzi2Y=;
        b=L6eYm8ytuJaqXTWXwzWjw7kF1nYhA95HT8bCVpinZUA3+VuiJ52M6t+sYiU+Z1IZfM
         G8aSJas00txWokmouXrQqYlaaKvb1KsJp5yZm0zOsE9ZlaGMse8IKuGkWgBQNiCM6Hhr
         T1rVVLBmuVDTyo3xWwhimKHLcmIFEggj5zTYzX48R+AackKe9/+TimgR9/C03S1wQ4jN
         hHsCvqAigNlrSQKKl18CZDCaSPtAH5QsiWvZfDQOhZ2P+8WNMPhxVaaeOlWnVksSFb45
         5orJKQvWuVte7Jx8uaBlQbic7X8rLDuG0GflJt7FQxg2KhVJ1cSOveSlUmrqn6jPqrwk
         STAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG1BfXSVDU3Y2PhNzZwLEDjizRwPrE86a5xXxjXLSUCADGEUY6vKtSar/GIyc6Wkf3p+pPI40gpRQ6vbLoNReU39rv4vSx9RghjJJt
X-Gm-Message-State: AOJu0YzYNui0L3J20yElq1e+brNCHyCSO3tViHE6z/3kGp2nccrpvaPK
	rr+b7f3n9T67Zu5/YJ+mKAI9GAfapdX9VJd8f+ca3JjVFu9a/aIfTO++ISCD0nUK+dx/kBNgqK0
	wig==
X-Google-Smtp-Source: AGHT+IH5euYPxXUZXXjsxMGaih3pl79ck64Edh4G6lVBruFm4nryWOOrC/E9TX3ZQtl/y+7U3yb7zQ==
X-Received: by 2002:a05:620a:14b3:b0:78a:af3:23b3 with SMTP id x19-20020a05620a14b300b0078a0af323b3mr4543119qkj.32.1712821256525;
        Thu, 11 Apr 2024 00:40:56 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id po3-20020a05620a384300b0078ec5d53404sm99783qkn.93.2024.04.11.00.40.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:40:55 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-434b5abbb0dso162001cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:40:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtZ3PFhTaUu88FygUuSZ+IUCJfQkh0GL1WaV0yX4f5p9vxxExN1fDFCg02mGILPUd5+qI/M6zgPHqNmxPzIVycR4u8tG3dPoCDPIEP
X-Received: by 2002:a05:622a:4c12:b0:434:7a13:2e7e with SMTP id
 ey18-20020a05622a4c1200b004347a132e7emr198846qtb.24.1712821254947; Thu, 11
 Apr 2024 00:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
 <20240410071439.2152588-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240410071439.2152588-3-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 11 Apr 2024 00:40:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2J=Tth2zhpo-kPo4uvESt70mFneO2V6TV-haac0VZuQ@mail.gmail.com>
Message-ID: <CAD=FV=V2J=Tth2zhpo-kPo4uvESt70mFneO2V6TV-haac0VZuQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] drm/panel: boe-tv101wum-nl6: Support for BOE
 nv110wum-l60 MIPI-DSI panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	LinusW <linus.walleij@linaro.org>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	airlied@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 10, 2024 at 12:15=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, which fits in nicely
> with the existing panel-boe-tv101wum-nl6 driver. Hence, we add a new
> compatible with panel specific config.

I guess we have the same question we've had with this driver in the
past: do we add more tables here, or do we break this out into a
separate driver like we ended up doing with "ili9882t". I guess the
question is: what is the display controller used with this panel and
is it the same (or nearly the same) display controller as other panels
in this driver or is it a completely different display controller.
Maybe you could provide this information in the commit message to help
reviewers understand.


> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)

Maybe add Linus W to your patches since he has had opinions on this
driver in the past. I've added him as CC here but you should make sure
to CC him on future versions unless he says not to. ;-)


> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu=
/drm/panel/panel-boe-tv101wum-nl6.c
> index 0ffe8f8c01de..f91827e1548c 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1368,6 +1368,91 @@ static const struct panel_init_cmd starry_himax831=
02_j02_init_cmd[] =3D {
>         {},
>  };
>
> +static const struct panel_init_cmd boe_nv110wum_init_cmd[] =3D {
> +       _INIT_DELAY_CMD(60),
> +       _INIT_DCS_CMD(0xB9, 0x83, 0x10, 0x21, 0x55, 0x00),

Given that the first command of "(0xB9, 0x83, 0x10, 0x21, 0x55, 0x00)"
seems to be the same as "starry_himax83102_j02" maybe those two are
the same controller? I'm just guessing, but if those are the same
controller as the two new ones you're adding in this series, maybe all
3 of them should be in their own driver? Maybe we can do something to
make more sense of some of these commands too? There certainly seem to
be a lot of commonalities in the init sequences of all 3 and if we can
define the init sequence more logically then we can share more of the
code between the different panels and we don't have a giant duplicated
blob.


> +       _INIT_DCS_CMD(0xB9, 0x00, 0x00, 0x00),
> +       _INIT_DELAY_CMD(50),
> +       _INIT_DCS_CMD(0x11),
> +       _INIT_DELAY_CMD(110),
> +       _INIT_DCS_CMD(0x29),
> +       _INIT_DELAY_CMD(25),
> +       {},
> +};
>  static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)

nit: should have a blank line between the end of your struct and the
next function.


> +static const struct panel_desc boe_nv110wum_desc =3D {
> +       .modes =3D &boe_tv110wum_default_mode,
> +       .bpc =3D 8,
> +       .size =3D {
> +               .width_mm =3D 147,
> +               .height_mm =3D 235,
> +       },
> +       .lanes =3D 4,
> +       .format =3D MIPI_DSI_FMT_RGB888,
> +       .mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PU=
LSE |
> +                     MIPI_DSI_MODE_LPM,
> +       .init_cmds =3D boe_nv110wum_init_cmd,
> +       .lp11_before_reset =3D true,
> +};
>  static int boe_panel_get_modes(struct drm_panel *panel,
>                                struct drm_connector *connector)

nit: should have a blank line between the end of your struct and the
next function.


> @@ -1973,6 +2085,9 @@ static const struct of_device_id boe_of_match[] =3D=
 {
>         { .compatible =3D "starry,himax83102-j02",
>           .data =3D &starry_himax83102_j02_desc
>         },
> +       { .compatible =3D "boe,nv110wum-l60",
> +         .data =3D &boe_nv110wum_desc
> +       },

nit: the existing panels that are supported are sorted alphabetically.
Please sort things alphabetically throughout your patch series.

-Doug

