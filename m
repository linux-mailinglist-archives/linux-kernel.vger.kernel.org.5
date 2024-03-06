Return-Path: <linux-kernel+bounces-94449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB8873FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674C61C232C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265D13E7C1;
	Wed,  6 Mar 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C4Uq6hy4"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746313DBA8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750962; cv=none; b=GzFGJT0xaC3sqhF7QgXYKSCLiB3VvTgBT3R/tvXET096FKN9VUzXypKqU7grHajj0S4c35WGIYsDRP9PA3iu8Jq9pKl/56n05k+Famze8ExTZ21bJQr2AF5ep6y8+ghR84UC0d2louIl8VoOYJkHx4KHuv4v+UUEKTEiDRSfjOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750962; c=relaxed/simple;
	bh=+qY0kt5Rk1927EzfH9DPpPHazgLVPLlObcZ/M3eEStU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3OWTTxmqr7nAsw9E6x3T68B1oe2oDsnB0BKbsOfYnB2qWLYrhWz4nbNWdOIuGIKb5pODyM43bHsmcO5TDfP3HfMmEShCTpTbUXmlomwws2hZFEunk3MKmW0ynaSnlJDMbCmMyv5jBM21xey0JCDjw4AC9AvNJcXer+/Qd3Ctvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C4Uq6hy4; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e4e51b0bfcso64177a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709750959; x=1710355759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjUrG2lbRlJ8KCqAukVlSqLRmVsUn2Ri9jzi1i+w1xg=;
        b=C4Uq6hy409CgUAIwxcNskdPxNlri00IbpDMKcnoo6cFpu2mXyXx23QukbtX/YZMGLD
         eX4A7lNc9DU/i0nSSSRhW5lcWDaUZ1kBbmnvw6PqIqzcOhrPKAOZAtkFEhpl/Spk5zYK
         vi4EIqikFofK8asJFLuPmWCJS8pWAf98+JAEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709750959; x=1710355759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjUrG2lbRlJ8KCqAukVlSqLRmVsUn2Ri9jzi1i+w1xg=;
        b=eh/wOivb/evRQdq01USCyeVdcb2aVRzRmOxlFz2gRJdmj25UdM6IELKH95d4jo1WgV
         KWznGmAf5xQmVGgTP1izkUKjIFvn+QOZTqNR1UVdw5W3HPbx80ELf7q5RwltRtSDAT3B
         3Hbg1hjEk9SuFHHzFUx/axYUbQ4JqHfkJnVavIpWjtye5VlhYtFC+/wXSthhzZaVYXTI
         CqWQfZgRomDvQD4ttZ3SIVcaciWZFu94OYgmQ/D15RbWpc2Y4+i2DeHrQowkd+chkCGJ
         AgKTtXXVUj60wothSXrEkDz51lSuYrCEtueD+Wz/AhFkX4qBoxWDIoX0DIB2ZPmK1pCh
         3cVA==
X-Forwarded-Encrypted: i=1; AJvYcCWSj/nlG387GxwQwokszbE/jxB6ecyNVFe87t/IG/zGePJb7nR5bvNNjiYGHpUYMMGEx6ZaI7+A8xk+xv4KSL1fByeh2siizLBow3Xo
X-Gm-Message-State: AOJu0Yzgx0yD64rxijlHS8OlzvQ88YD18HLHkPmwHvigS4q1Pyp5uYmP
	a/h+r2t5LAInKw/qYOQfqx0mYv116jDpm3VCAtk4h3c0gswLbCwwR53g4OaNjH/4hPE7NM3p9id
	kYnU/2nLur2vKG8p2RqioEjreavARE3N69A7n
X-Google-Smtp-Source: AGHT+IH8ZO7kEQM/WJhdlmJw3N6phXcH22pWt3F99LyFnfAdBKtfzj/askpKhpFhZoDEo7JaVu8N4lHJ8cQednL/rIk=
X-Received: by 2002:a05:6830:22f0:b0:6e4:8a65:a222 with SMTP id
 t16-20020a05683022f000b006e48a65a222mr5642213otc.5.1709750959502; Wed, 06 Mar
 2024 10:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306004347.974304-1-hsinyi@chromium.org> <20240306004347.974304-5-hsinyi@chromium.org>
 <87msrbzpba.fsf@intel.com>
In-Reply-To: <87msrbzpba.fsf@intel.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 6 Mar 2024 10:48:53 -0800
Message-ID: <CAJMQK-jU6mROM8W00_Ps31Hk3S6+gj7dOSuEj7jHJfUSKx+MVA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] drm/panel-edp: Match edp_panels with panel identity
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Douglas Anderson <dianders@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 1:23=E2=80=AFAM Jani Nikula <jani.nikula@linux.intel=
com> wrote:
>
> On Tue, 05 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > It's found that some panels have variants that they share the same pane=
l id
> > although their EDID and names are different. When matching generic edp
> > panels, we should first match with both panel identity, which contains =
both
> > panel id and panel name. If not found, match with panel id only.
>
> Do you want to start matching also with name, for all panels? That's
> totally up to you, but that's the big functional change here.
>

It might be difficult to find all the datasheets for all the panels to
verify the names. Also, some of the names in the panels are also
marked as "Unknown", so I think we still want to keep the matching
with id only.

Without really testing on the exact panel, I'm afraid that this might
break them.


> BR,
> Jani.
>
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v3->v4: combine name and id to identity.
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 45 ++++++++++++++++---------------
> >  1 file changed, 24 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index d094cfc43da8..fb70e97a2e71 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -210,15 +210,12 @@ struct panel_desc {
> >   * struct edp_panel_entry - Maps panel ID to delay / panel name.
> >   */
> >  struct edp_panel_entry {
> > -     /** @panel_id: 32-bit ID for panel, encoded with drm_edid_encode_=
panel_id(). */
> > -     u32 panel_id;
> > +     /** @ident: edid identity used for panel matching. */
> > +     const struct drm_edid_ident ident;
> >
> >       /** @delay: The power sequencing delays needed for this panel. */
> >       const struct panel_delay *delay;
> >
> > -     /** @name: Name of this panel (for printing to logs). */
> > -     const char *name;
> > -
> >       /** @override_edid_mode: Override the mode obtained by edid. */
> >       const struct drm_display_mode *override_edid_mode;
> >  };
> > @@ -691,7 +688,7 @@ static int detected_panel_show(struct seq_file *s, =
void *data)
> >       else if (!p->detected_panel)
> >               seq_puts(s, "HARDCODED\n");
> >       else
> > -             seq_printf(s, "%s\n", p->detected_panel->name);
> > +             seq_printf(s, "%s\n", p->detected_panel->ident.name);
> >
> >       return 0;
> >  }
> > @@ -761,7 +758,7 @@ static void panel_edp_parse_panel_timing_node(struc=
t device *dev,
> >               dev_err(dev, "Reject override mode: No display_timing fou=
nd\n");
> >  }
> >
> > -static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
> > +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, cons=
t struct drm_edid *edid);
> >
> >  static int generic_edp_panel_probe(struct device *dev, struct panel_ed=
p *panel)
> >  {
> > @@ -799,7 +796,6 @@ static int generic_edp_panel_probe(struct device *d=
ev, struct panel_edp *panel)
> >       base_block =3D drm_edid_read_base_block(panel->ddc);
> >       if (base_block) {
> >               panel_id =3D drm_edid_get_panel_id(base_block);
> > -             drm_edid_free(base_block);
> >       } else {
> >               dev_err(dev, "Couldn't identify panel via EDID\n");
> >               ret =3D -EIO;
> > @@ -807,7 +803,9 @@ static int generic_edp_panel_probe(struct device *d=
ev, struct panel_edp *panel)
> >       }
> >       drm_edid_decode_panel_id(panel_id, vend, &product_id);
> >
> > -     panel->detected_panel =3D find_edp_panel(panel_id);
> > +     panel->detected_panel =3D find_edp_panel(panel_id, base_block);
> > +
> > +     drm_edid_free(base_block);
> >
> >       /*
> >        * We're using non-optimized timings and want it really obvious t=
hat
> > @@ -840,7 +838,7 @@ static int generic_edp_panel_probe(struct device *d=
ev, struct panel_edp *panel)
> >               panel->detected_panel =3D ERR_PTR(-EINVAL);
> >       } else {
> >               dev_info(dev, "Detected %s %s (%#06x)\n",
> > -                      vend, panel->detected_panel->name, product_id);
> > +                      vend, panel->detected_panel->ident.name, product=
_id);
> >
> >               /* Update the delay; everything else comes from EDID */
> >               desc->delay =3D *panel->detected_panel->delay;
> > @@ -1930,17 +1928,21 @@ static const struct panel_delay delay_200_500_e=
50_po2e200 =3D {
> >
> >  #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id=
, _delay, _name) \
> >  { \
> > -     .name =3D _name, \
> > -     .panel_id =3D drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, ve=
nd_chr_2, \
> > -                                          product_id), \
> > +     .ident =3D { \
> > +             .name =3D _name, \
> > +             .panel_id =3D drm_edid_encode_panel_id(vend_chr_0, vend_c=
hr_1, vend_chr_2, \
> > +                                                  product_id), \
> > +     }, \
> >       .delay =3D _delay \
> >  }
> >
> >  #define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_i=
d, _delay, _name, _mode) \
> >  { \
> > -     .name =3D _name, \
> > -     .panel_id =3D drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, ve=
nd_chr_2, \
> > -                                          product_id), \
> > +     .ident =3D { \
> > +             .name =3D _name, \
> > +             .panel_id =3D drm_edid_encode_panel_id(vend_chr_0, vend_c=
hr_1, vend_chr_2, \
> > +                                                  product_id), \
> > +     }, \
> >       .delay =3D _delay, \
> >       .override_edid_mode =3D _mode \
> >  }
> > @@ -2087,15 +2089,16 @@ static const struct edp_panel_entry edp_panels[=
] =3D {
> >       { /* sentinal */ }
> >  };
> >
> > -static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
> > +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, cons=
t struct drm_edid *edid)
> >  {
> >       const struct edp_panel_entry *panel;
> >
> > -     if (!panel_id)
> > -             return NULL;
> > +     for (panel =3D edp_panels; panel->ident.panel_id; panel++)
> > +             if (drm_edid_match_identity(edid, &panel->ident))
> > +                     return panel;
> >
> > -     for (panel =3D edp_panels; panel->panel_id; panel++)
> > -             if (panel->panel_id =3D=3D panel_id)
> > +     for (panel =3D edp_panels; panel->ident.panel_id; panel++)
> > +             if (panel->ident.panel_id =3D=3D panel_id)
> >                       return panel;
> >
> >       return NULL;
>
> --
> Jani Nikula, Intel

