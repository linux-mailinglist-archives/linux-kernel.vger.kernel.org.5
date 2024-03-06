Return-Path: <linux-kernel+bounces-94460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618487401F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412781C23429
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAE113E7EF;
	Wed,  6 Mar 2024 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jt037xmd"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3E13F430
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752135; cv=none; b=uVoO61cWcBYDBTpqtXCA5suCVR6Zq9JRGF3i8LMwWvTV6V9sXIYpm58DWc2sFf3K+BlWc0sir+0nQyYByBC6VrLBf6QrSP0Up2VmX4g+/CagSHQ7KX2NsZLTQGoXMCsYKqMYv5F5/fyc2ZIXmULT6XuIDr+Yidj7n/Tv3Q2EWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752135; c=relaxed/simple;
	bh=iTUH3z/flhAY8RMNE6n6VW11efsRJxXmfj0J2mBfM0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6Inc5vkGQwV3QCWfv8vcajMCM3PZh8yCV5sIGNA95K0cFiMu+fWIjwaVA1RDGxjH3S5Jj03LSvyTYLYpOqxWdnY8cmCfg0ZQ1Y2p7Rr+ClumiSLVz0jjyUkJuf0XzpabU/bo6CQqCCABWN0VrdJC3G65T26LTtYl1kBZg+0bS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jt037xmd; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e4efdf31c9so45057a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709752133; x=1710356933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe0QNgBhtWSfWE1nNZBiS0+/mEaaikyx4+HhVVMA5h8=;
        b=Jt037xmdUz/NjOfjq7w5Yy4sjFPtkcbwI8kuSaEohku79pyjio8QhDnM3yYk8UCfbR
         6LF+rYOfQ2spd5g+aYkV/Ci3yDrEunnpL8X4ffesMLDTaDd7OLWX5EYK2w1VkmvkyLHf
         DHVTFq8ZrML8JL4yeKSDQL8RT+8oMUFth/bh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752133; x=1710356933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe0QNgBhtWSfWE1nNZBiS0+/mEaaikyx4+HhVVMA5h8=;
        b=OTlUYLt+Lr4NawSx3AyImSi3JSRqjcVf6j3YHtl7YTq/gCTQss1DKBOF/c3HskX024
         D4P+vYgG6M3Gyen1udaFGAFo57ee8++lq4Dr4Ochzv+nMmgyX67XQ+DbFCt039q+K5aP
         vja6wWj8FBl44GFLlhsLKyVX0fKoeBgfADkzWUyC6jpTThQI2kSnOn2ge5ce5HVtknS6
         fFQdFJiL+xXRcdjhN2mueJ1bj4oZTdHdfWOlG/csDyyYKNhoJJgUZQd8SMfAOqn2g6Rm
         woUEwX7GuovZCrKrJhu7RKAyA2UqCu42a4P1w29Wf2SMbxAo7TddESAyYFb5cnNsLCyB
         yynA==
X-Forwarded-Encrypted: i=1; AJvYcCU3pqbz2Bbf2K0NF/623Wfm+8P1ZIK+1AOq4MsiD+9s7MqGhbjtLGlbm0bypTA7ODDXbqwt3XQjgQLd5HZXXfiG2x2e0xO9+/KDjlCg
X-Gm-Message-State: AOJu0Yw+uU966o+HIKcgZIwrMoJZzU1h5FzxyO+EwIRtFvF2upEKBjru
	Ij4PYvAxebRT8JS//OweTUqkMAzjd9kpfuMnEbz7dEIO/6kAjfZqot+zno6M/ymxFaiCYlIMYPI
	+rk10cb1zEZVwlIXfFRlA9IAu1yJ7nfO66mlm
X-Google-Smtp-Source: AGHT+IEw+KB3tMPtIPFAOIzu2uRC4E+jpfyWg1B1uV1j9J8CxOl4tulHG2bobO9eW5yqEYg/RjVVFspNaKfxFHhwn8w=
X-Received: by 2002:a9d:6a11:0:b0:6e5:789:8337 with SMTP id
 g17-20020a9d6a11000000b006e507898337mr64849otn.8.1709752133085; Wed, 06 Mar
 2024 11:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306004347.974304-1-hsinyi@chromium.org> <20240306004347.974304-3-hsinyi@chromium.org>
 <87sf13zpmc.fsf@intel.com>
In-Reply-To: <87sf13zpmc.fsf@intel.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 6 Mar 2024 11:08:27 -0800
Message-ID: <CAJMQK-gTuPRCJ2y4ErGcv6T74JgGjtzuWyeDxU2uX+=0+yYq9Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] drm/edid: Add a function to match EDID with identity
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Douglas Anderson <dianders@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 1:17=E2=80=AFAM Jani Nikula <jani.nikula@linux.intel=
com> wrote:
>
> On Tue, 05 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > Create a type drm_edid_ident as the identity of an EDID. Currently it
> > contains panel id and monitor name.
> >
> > Create a function that can match a given EDID and an identity:
> > 1. Reject if the panel id doesn't match.
> > 2. If name is not null in identity, try to match it in the detailed tim=
ing
> >    blocks. Note that some panel vendors put the monitor name after
> >    EDID_DETAIL_MONITOR_STRING.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v3->v4:
> > 1. add a type drm_edid_ident
> > 2. match name -> match identity. Modify function to use edid iterators.
> > ---
> >  drivers/gpu/drm/drm_edid.c | 76 ++++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_edid.h     |  8 ++++
> >  2 files changed, 84 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index f9e09f327f81..5e7e69e0e345 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -102,6 +102,11 @@ struct detailed_mode_closure {
> >       int modes;
> >  };
> >
> > +struct drm_edid_ident_closure {
> > +     const struct drm_edid_ident *ident;
> > +     bool matched;
> > +};
>
> More like drm_edid_match_closure.
>
> > +
> >  #define LEVEL_DMT    0
> >  #define LEVEL_GTF    1
> >  #define LEVEL_GTF2   2
> > @@ -5455,6 +5460,77 @@ drm_parse_hdmi_vsdb_audio(struct drm_connector *=
connector, const u8 *db)
> >                   connector->audio_latency[0], connector->audio_latency=
[1]);
> >  }
> >
> > +static void
> > +match_identity(const struct detailed_timing *timing, void *data)
> > +{
> > +     struct drm_edid_ident_closure *closure =3D data;
> > +     unsigned int i, j;
> > +     const char *str =3D closure->ident->name;
> > +     unsigned int buflen =3D strlen(str);
> > +     unsigned int size =3D ARRAY_SIZE(timing->data.other_data.data.str=
str);
> > +
> > +     if (buflen > size ||
> > +         !(is_display_descriptor(timing, EDID_DETAIL_MONITOR_NAME) ||
> > +           is_display_descriptor(timing, EDID_DETAIL_MONITOR_STRING)))
> > +             return;
> > +
> > +     for (i =3D 0; i < buflen; i++) {
> > +             char c =3D timing->data.other_data.data.str.str[i];
> > +
> > +             if (c !=3D str[i] ||  c =3D=3D '\n')
> > +                     break;
> > +             }
> > +
> > +             if (i =3D=3D buflen) {
>
> This will never be true.

It should be

for (i =3D 0; i < buflen; i++) {
..
}

if (i=3D=3Dbuflen) {
..
}

But okay we can use strcmp.

>
> > +                     /* Allow trailing white spaces. */
> > +                     for (j =3D i; j < size; j++) {
> > +                             char c =3D timing->data.other_data.data.s=
tr.str[j];
> > +
> > +                             if (c =3D=3D '\n') {
> > +                                     closure->matched =3D true;
> > +                                     return;
> > +                             } else if (c !=3D ' ') {
> > +                                     break;
> > +                             }
> > +                     }
> > +                     if (j =3D=3D size) {
> > +                             closure->matched =3D true;
> > +                             return;
> > +                     }
> > +     }
>
> Please let's use strcmp and friends instead of reinventing our own:
>
> const char *name =3D closure->ident->name;
> int name_len =3D strlen(name);
> const char *desc =3D timing->data.other_data.data.str.str;
> int desc_len =3D ARRAY_SIZE(timing->data.other_data.data.str.str);
>
> if (name_len > desc_len)
>         return;
>
> if (strncmp(name, desc, name_en))
>         return;
>
> for (i =3D name_len; i < desc_len; i++) {
>         if (!isspace(desc[i]) && !desc[i])
>                 return;
> }
>
> closure->matched =3D true;
>
>
> > +}
> > +
> > +/**
> > + * drm_edid_match_identity - match drm_edid with given identity
> > + * @drm_edid: EDID
> > + * @ident: the EDID identity to match with
> > + *
> > + * Check if the EDID matches with the given identity.
> > + *
> > + * Return: True if the given identity matched with EDID, false otherwi=
se.
> > + */
> > +bool drm_edid_match_identity(const struct drm_edid *drm_edid,
> > +                          const struct drm_edid_ident *ident)
>
> Can we please just call this drm_edid_match()? Is the _identity in the
> name somehow helpful?
>
> > +{
> > +     if (!drm_edid || edid_extract_panel_id(drm_edid->edid) !=3D ident=
->panel_id)
> > +             return false;
>
> Side note, edid_extract_panel_id() could now be made to take struct
> drm_edid.
>
> > +
> > +     /* Match with name only if it's not NULL. */
> > +     if (ident->name) {
> > +             struct drm_edid_ident_closure closure =3D {
> > +                     .ident =3D ident,
> > +                     .matched =3D false,
> > +             };
> > +
> > +             drm_for_each_detailed_block(drm_edid, match_identity, &cl=
osure);
> > +
> > +             return closure.matched;
> > +     }
> > +
> > +     return true;
> > +}
> > +EXPORT_SYMBOL(drm_edid_match_identity);
> > +
> >  static void
> >  monitor_name(const struct detailed_timing *timing, void *data)
> >  {
> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> > index 9686a7cee6a6..01825a8954b6 100644
> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> > @@ -312,6 +312,12 @@ struct edid {
> >       u8 checksum;
> >  } __packed;
> >
> > +/* EDID matching */
> > +struct drm_edid_ident {
> > +     u32 panel_id;
> > +     const char *name;
> > +};
> > +
> >  #define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1] << =
8))
> >
> >  /* Short Audio Descriptor */
> > @@ -412,6 +418,8 @@ struct edid *drm_get_edid(struct drm_connector *con=
nector,
> >                         struct i2c_adapter *adapter);
> >  const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter *ad=
apter);
> >  u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid);
> > +bool drm_edid_match_identity(const struct drm_edid *drm_edid,
> > +                          const struct drm_edid_ident *ident);
> >  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
> >                                    struct i2c_adapter *adapter);
> >  struct edid *drm_edid_duplicate(const struct edid *edid);
>
> --
> Jani Nikula, Intel

