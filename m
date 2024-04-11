Return-Path: <linux-kernel+bounces-140061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52DD8A0AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A876286643
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E346413FD85;
	Thu, 11 Apr 2024 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHXNVtL2"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84E13FD7E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823251; cv=none; b=N4qPmKjo8lamF0X+7eUFdT1Mm+u6JNmaefqGkQi7920i5gRQf73Sj7GS+gnqaK1yPo6FjIkDtR7wEH1/VHT333MKlj1SQu9ohNIANT9wYZcnStZ7g9kbCPfSeWxFDdQhX0wz6sONc1KOL/HX9RzZH4GyWu9DEDXKQlKDEKAWvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823251; c=relaxed/simple;
	bh=SuQ9A/TU9cw8ZmAuHE6oNjwLuqELfBcS2nzurIFf/kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxWas/cVW4tZ3FOQO/jMAxdYS9GFATtBIzAucsHbWvBrHa1iuDA0nM7OEyrpODgELF+LMlDuMHvyW92Fp4s0GifCq2EihH05iJDU/mQXCVRM0kdHA2YiTcBeqmmrk3a/QPNhiuxP+3GDZYsQDYCJ+keFSneh5pI8adsHwlORIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHXNVtL2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so5785522a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712823249; x=1713428049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gPgcOXlZWvzL9hezqXATwov8+wUxqo6rMbClRd0AZQ=;
        b=LHXNVtL2Aji7o9jzRw99me2f8nFLz19sRBMLg4b1vv20A6ZGX1prahpDElaqgE/SlV
         LM7yK617MaYfYqSLM39jnJBvuY67FD0E7LK1R6NRLG9tSOteOrGUOKvvEhAfMNeTixWy
         OL8WasRBRE6y5pWWMiUQyGwrH2Fx7OLbBBnrAhJzP+R2qbuYy3KgXvoSPvy020mZAidB
         7kmQxzuagSydRATvaYMRpgrYZjm8EcGHu60s49bW+xsq0odgFLtTS+xgOth4yWVesIz8
         QyrlIFaBH+TrfXk1XJq16KucdWezrTGFQOtpCOX2CNZ1P4Hf1ilBLekUeuc8lkbYeTip
         CJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712823249; x=1713428049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gPgcOXlZWvzL9hezqXATwov8+wUxqo6rMbClRd0AZQ=;
        b=Cf5iyQAKUjz3E7d5mT1caYhnVpvqFQhrb6cRRZME+MyC/HYDSmsBmZWNm+xeRqVlrh
         fCtEM73HBObJ9YzNbBFfKLF3Bao+88vZcXWfcVlzDn/QgI0yv1SQoK5ohYbemUtMSRAH
         Oqgu/AtbGvX8CCcZRrIytuzpPBKEUeX9KJifqtHQxahbdiL0hqFaNC3R+Te1xhzWs64c
         7zFII9fVItmjnL+YswJx6chVaijC0y+9BlMuplv/07MwTeY9+qRYMSpsiwRrGaWZFhSV
         TYo96Man1dgCtuf+lLAc2CeeEPOmssknB8tpWEa7K1hb9smppxLLNiIGcWHHQbhtyOgJ
         QRQg==
X-Forwarded-Encrypted: i=1; AJvYcCUm3L4djFkApKe0YYpI1YL4VZC/AOCuPF833bZtTsjJF7Er+8B5E+SF7zAcT3aZlCc1MjwpllUU3bCmk+ltQBb/feCSn6wiOSBhhbHS
X-Gm-Message-State: AOJu0YxVqiveuSDmT+9L04wM84K6r3Rp1upckcMl54Sn3S5SBMOxHqY6
	7LgmutnN8Ig6BIJaLWQtejm2Rm1kk00qU0yCbA0cz2B945tf9JOfiq6pM23SM2d2353Aw+17Bpb
	Df6A1yobMO0BYiWgOqN8ErMPMfqAKgiGqPIkOMg==
X-Google-Smtp-Source: AGHT+IGcVDdqOTlwc3wkUZsuRF2Uh7jsC1fxkgbSC0WqLMKH4Jr4w1KEy1uXeIyrNghvA+2+ZMI6+uM5FVhNo39fx20=
X-Received: by 2002:a05:6a20:dca8:b0:1a7:7fbb:262d with SMTP id
 ky40-20020a056a20dca800b001a77fbb262dmr4902168pzb.36.1712823248684; Thu, 11
 Apr 2024 01:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
 <20240410071439.2152588-3-yangcong5@huaqin.corp-partner.google.com> <CAD=FV=V2J=Tth2zhpo-kPo4uvESt70mFneO2V6TV-haac0VZuQ@mail.gmail.com>
In-Reply-To: <CAD=FV=V2J=Tth2zhpo-kPo4uvESt70mFneO2V6TV-haac0VZuQ@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Thu, 11 Apr 2024 16:13:57 +0800
Message-ID: <CAHwB_NLgZDwX4PSrSDH+qPkjq=060Vx35BdX76iX3mpMRkHDcQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] drm/panel: boe-tv101wum-nl6: Support for BOE
 nv110wum-l60 MIPI-DSI panel
To: Doug Anderson <dianders@chromium.org>
Cc: LinusW <linus.walleij@linaro.org>, sam@ravnborg.org, neil.armstrong@linaro.org, 
	daniel@ffwll.ch, airlied@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B44=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B 15:48=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Wed, Apr 10, 2024 at 12:15=E2=80=AFAM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, which fits in nice=
ly
> > with the existing panel-boe-tv101wum-nl6 driver. Hence, we add a new
> > compatible with panel specific config.
>
> I guess we have the same question we've had with this driver in the
> past: do we add more tables here, or do we break this out into a
> separate driver like we ended up doing with "ili9882t". I guess the
> question is: what is the display controller used with this panel and
> is it the same (or nearly the same) display controller as other panels
> in this driver or is it a completely different display controller.
> Maybe you could provide this information in the commit message to help
> reviewers understand.

okay, I will add detailed information in V2 patch.Thanks.
>
>
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 115 ++++++++++++++++++
> >  1 file changed, 115 insertions(+)
>
> Maybe add Linus W to your patches since he has had opinions on this
> driver in the past. I've added him as CC here but you should make sure
> to CC him on future versions unless he says not to. ;-)

Got it,thanks.

>
>
> > diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/g=
pu/drm/panel/panel-boe-tv101wum-nl6.c
> > index 0ffe8f8c01de..f91827e1548c 100644
> > --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> > +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> > @@ -1368,6 +1368,91 @@ static const struct panel_init_cmd starry_himax8=
3102_j02_init_cmd[] =3D {
> >         {},
> >  };
> >
> > +static const struct panel_init_cmd boe_nv110wum_init_cmd[] =3D {
> > +       _INIT_DELAY_CMD(60),
> > +       _INIT_DCS_CMD(0xB9, 0x83, 0x10, 0x21, 0x55, 0x00),
>
> Given that the first command of "(0xB9, 0x83, 0x10, 0x21, 0x55, 0x00)"
> seems to be the same as "starry_himax83102_j02" maybe those two are
> the same controller? I'm just guessing, but if those are the same
> controller as the two new ones you're adding in this series, maybe all
> 3 of them should be in their own driver? Maybe we can do something to
> make more sense of some of these commands too? There certainly seem to
> be a lot of commonalities in the init sequences of all 3 and if we can
> define the init sequence more logically then we can share more of the
> code between the different panels and we don't have a giant duplicated
> blob.

Yes, your guess is correct. boe_nv110wum and ivo_t109nw41 and
starry_himax83102_j02
are the same controller (himax83102). They are equipped with different
glass panels (BOE/IVO/starry),
so there will be some differences in initial code and porch.

>
>
> > +       _INIT_DCS_CMD(0xB9, 0x00, 0x00, 0x00),
> > +       _INIT_DELAY_CMD(50),
> > +       _INIT_DCS_CMD(0x11),
> > +       _INIT_DELAY_CMD(110),
> > +       _INIT_DCS_CMD(0x29),
> > +       _INIT_DELAY_CMD(25),
> > +       {},
> > +};
> >  static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
>
> nit: should have a blank line between the end of your struct and the
> next function.

Got it,thanks.

>
>
> > +static const struct panel_desc boe_nv110wum_desc =3D {
> > +       .modes =3D &boe_tv110wum_default_mode,
> > +       .bpc =3D 8,
> > +       .size =3D {
> > +               .width_mm =3D 147,
> > +               .height_mm =3D 235,
> > +       },
> > +       .lanes =3D 4,
> > +       .format =3D MIPI_DSI_FMT_RGB888,
> > +       .mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_=
PULSE |
> > +                     MIPI_DSI_MODE_LPM,
> > +       .init_cmds =3D boe_nv110wum_init_cmd,
> > +       .lp11_before_reset =3D true,
> > +};
> >  static int boe_panel_get_modes(struct drm_panel *panel,
> >                                struct drm_connector *connector)
>
> nit: should have a blank line between the end of your struct and the
> next function.
>
>
> > @@ -1973,6 +2085,9 @@ static const struct of_device_id boe_of_match[] =
=3D {
> >         { .compatible =3D "starry,himax83102-j02",
> >           .data =3D &starry_himax83102_j02_desc
> >         },
> > +       { .compatible =3D "boe,nv110wum-l60",
> > +         .data =3D &boe_nv110wum_desc
> > +       },
>
> nit: the existing panels that are supported are sorted alphabetically.
> Please sort things alphabetically throughout your patch series.

Got it, fx net patch. Thanks.

>
> -Doug

