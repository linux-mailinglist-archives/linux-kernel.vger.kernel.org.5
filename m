Return-Path: <linux-kernel+bounces-91316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD496870DD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EBD1F21B61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9E547A5D;
	Mon,  4 Mar 2024 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HQVhsdkm"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684898F58
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588287; cv=none; b=NvbE6QhS/OhVvZHjvaVGS7lYx0LVAmQlyj7qj/hUhAPYzHezteO5Aw7CPxdLj0vPYbhOkKiIh2vjZVBhylPf0SSWorA+7PGzYy7RtMr9Q030Lf5aYKPlaLBGq47v3Ui8vFT6vAr9rS0FED82sFE1oDY2a2iakAcv1RGDgInjWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588287; c=relaxed/simple;
	bh=bEeluja2wt43rMonaMlY3Ipk5PwOYatagCTG7W0iKq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRaDX7RvjxcPWPrx4Enac2vVBw2UkcDTTHUhav1uEb/FXc1VeJTaNY6bVPOQSSCqaslCEjXqvVNCBqyDxrdZAL0nFImyAc9VbdzdAxs3JbUtAZ/yx7pbUI+PksHnItq5TzKDR1hD/q1wEnz6PJlJ7G7HND4uV9xsYKgV2RUE84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HQVhsdkm; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21eea6aab5eso28925fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709588284; x=1710193084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zllh0qjRXcCCFX37PpZEtxqzl5R3qbc1KL3e6oevK4=;
        b=HQVhsdkmpPfMuZrPAa/YyFzCRi0DKHoX4QpDAKepjliU+txyjo184GjnyCYrh/mIoz
         pikMifYDvxNGdbmFlG9ZIlFVPpXI6J2RXkCvB1643Bz/W+8TGDv1MK4kX4CI+a/hyB1A
         kPbx3OVHKpzl8X83+2rfWV0nJyQK4IX5gC4jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709588284; x=1710193084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zllh0qjRXcCCFX37PpZEtxqzl5R3qbc1KL3e6oevK4=;
        b=aHHn+Tgi4fo+8Jm6G5V60bkhWBW5uHMFUPsmJ0hgTF8bvZoSwkJTy6GWcsA5Ml/Q5T
         7VtjDwulBe/nF2J4mzoVzcqFZxmjlzvX2w5lpTm+ApUabMqMAwboz426Z/fftXfeX/MG
         D/Q91utzZzEFP/TSp8SwGPuErnCUqrQLNxsH1f05iMadbwKfi3SEcEoA2oBIbq3Wnknm
         SVqr1IiYkU7J1f6yVPevkbhkqxPgWzViJc1BMS082Nr1JUrbgO8VHPLXO2E+Xi+5C2FE
         bdH2jJ8uK4YzVFoPG15gEPcnSjGkvyaUOUPcd3HaoYzOLi7B1wDT1vzM0RCvbCPYajFd
         zqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnvmM/wpj167i26uzguis4rMYU3DtV9APE6YXv5wDGIC+LlVd+KEqyRFKx9mXIQrPYSnf5LdcYaI9QWcZLfG3JsPGHVYQCgTXUALHq
X-Gm-Message-State: AOJu0YyrH3OC+AuEWgTbbJl+nj96u/TsdeSnNIKbqGg7eILnkYB9//rK
	cEWhx8GY8+2kn3/Qlzh2M4h/TpO09qzowW2MVGiRI65QfnIikCHjAd5ZujSuQpk0xt3YezcQnr1
	+v7y4Uea5Rj+lLjfIkrUCNwR0Jmg0GSuPi85r
X-Google-Smtp-Source: AGHT+IHV7Mz+ohK3UdKzTdVvn41CHMJQdqnwQyxqrrWmzdlKaHc5w5Wsqs7RjBSe4RBMiaaCmIUUlbzf5NLUec3a7UE=
X-Received: by 2002:a05:6871:80e:b0:21f:4fe:9ee8 with SMTP id
 q14-20020a056871080e00b0021f04fe9ee8mr12682869oap.4.1709588284302; Mon, 04
 Mar 2024 13:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304195214.14563-1-hsinyi@chromium.org> <20240304195214.14563-3-hsinyi@chromium.org>
 <87a5nd4tsg.fsf@intel.com>
In-Reply-To: <87a5nd4tsg.fsf@intel.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Mon, 4 Mar 2024 13:37:38 -0800
Message-ID: <CAJMQK-j4wGah=szyUW53hu-v6Q4QjgR7WMLKnspoFaO9oPfaQw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/edid: Add a function to check monitor string
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 12:38=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Mon, 04 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > Add a function to check if the EDID base block contains a given string.
> >
> > One of the use cases is fetching panel from a list of panel names, sinc=
e
> > some panel vendors put the monitor name after EDID_DETAIL_MONITOR_STRIN=
G
> > instead of EDID_DETAIL_MONITOR_NAME.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v2->v3: move string matching to drm_edid
> > ---
> >  drivers/gpu/drm/drm_edid.c | 49 ++++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_edid.h     |  1 +
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 13454bc64ca2..fcdc2bd143dd 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -2789,6 +2789,55 @@ u32 drm_edid_get_panel_id(struct edid_base_block=
 *base_block)
> >  }
> >  EXPORT_SYMBOL(drm_edid_get_panel_id);
> >
> > +/**
> > + * drm_edid_has_monitor_string - Check if a EDID base block has certai=
n string.
> > + * @base_block: EDID base block to check.
> > + * @str: pointer to a character array to hold the string to be checked=
.
> > + *
> > + * Check if the detailed timings section of a EDID base block has the =
given
> > + * string.
> > + *
> > + * Return: True if the EDID base block contains the string, false othe=
rwise.
> > + */
> > +bool drm_edid_has_monitor_string(struct edid_base_block *base_block, c=
onst char *str)
> > +{
> > +     unsigned int i, j, k, buflen =3D strlen(str);
> > +
> > +     for (i =3D 0; i < EDID_DETAILED_TIMINGS; i++) {
> > +             struct detailed_timing *timing =3D &base_block->edid.deta=
iled_timings[i];
> > +             unsigned int size =3D ARRAY_SIZE(timing->data.other_data.=
data.str.str);
> > +
> > +             if (buflen > size || timing->pixel_clock !=3D 0 ||
> > +                 timing->data.other_data.pad1 !=3D 0 ||
> > +                 (timing->data.other_data.type !=3D EDID_DETAIL_MONITO=
R_NAME &&
> > +                  timing->data.other_data.type !=3D EDID_DETAIL_MONITO=
R_STRING))
> > +                     continue;
> > +
> > +             for (j =3D 0; j < buflen; j++) {
> > +                     char c =3D timing->data.other_data.data.str.str[j=
];
> > +
> > +                     if (c !=3D str[j] ||  c =3D=3D '\n')
> > +                             break;
> > +             }
> > +
> > +             if (j =3D=3D buflen) {
> > +                     /* Allow trailing white spaces. */
> > +                     for (k =3D j; k < size; k++) {
> > +                             char c =3D timing->data.other_data.data.s=
tr.str[k];
> > +
> > +                             if (c =3D=3D '\n')
> > +                                     return true;
> > +                             else if (c !=3D ' ')
> > +                                     break;
> > +                     }
> > +                     if (k =3D=3D size)
> > +                             return true;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
>
> So we've put a lot of effort into converting from struct edid to struct
> drm_edid, passing that around in drm_edid.c, with the allocation size it
> provides, and generally cleaning stuff up.
>
> I'm not at all happy to see *another* struct added just for the base
> block, and detailed timing iteration as well as monitor name parsing
> duplicated.
>
> With struct drm_edid you can actually return an EDID that only has the
> base block and size 128, even if the EDID indicates more
> extensions. Because the whole thing is *designed* to handle that
> gracefully. The allocated size matters, not what the blob originating
> outside of the kernel tells you.
>
> What I'm thinking is:
>
> - Add some struct drm_edid_ident or similar. Add all the information
>   that's needed to identify a panel there. I guess initially that's
>   panel_id and name.
>
>     struct drm_edid_ident {
>         u32 panel_id;
>         const char *name;
>     };
>
> - Add function:
>
>     bool drm_edid_match(const struct drm_edid *drm_edid, const struct drm=
_edid_ident *ident);
>
>   Check if stuff in ident matches drm_edid. You can use and extend the
>   existing drm_edid based iteration etc. in
>   drm_edid.c. Straightforward. The fields in ident can trivially be
>   extended later, and the stuff can be useful for other drivers and
>   quirks etc.
>
> - Restructure struct edp_panel_entry to contain struct
>   drm_edid_ident. Change the iteration of edp_panels array to use
>   drm_edid_match() on the array elements and the edid.
>
> - Add a function to read the EDID base block *but* make it return const
>   struct drm_edid *. Add warnings in the comments that it's only for
>   panel and for transition until it switches to reading full EDIDs.
>
>     const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter *a=
dapter);
>
>   This is the *only* hackish part of the whole thing, and it's nicely
>   isolated. For the most part you can use drm_edid_get_panel_id() code
>   for this, just return the blob wrapped in a struct drm_edid envelope.

To clarify:
struct drm_edid currently is only internal to drm_edid.c. So with
change we will have to move it to the header drm_edid.h

>
> - Remove function:
>
>     u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
>

Probably change to u32 drm_edid_get_panel_id(const struct drm_edid
*);? Given that we still need to parse id from
drm_edid_read_base_block().

> - Refactor edid_quirk_list to use the same id struct and match function
>   and mechanism within drm_edid.c (can be follow-up too).
>

edid_quirk currently doesn't have panel names in it, and it might be a
bit difficult to get all the correct names of these panels without
having the datasheets.
One way is to leave the name as null and if the name is empty and skip
matching the name in drm_edid_match().

> - Once you change the panel code to read the whole EDID using
>   drm_edid_read family of functions in the future, you don't have to
>   change *anything* about the iteration or matching or anything, because
>   it's already passing struct drm_edid around.
>
>
> I hope this covers everything.
>
> BR,
> Jani.
>
>
> >  /**
> >   * drm_edid_get_base_block - Get a panel's EDID base block
> >   * @adapter: I2C adapter to use for DDC
> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> > index 2455d6ab2221..248ddb0a6b5d 100644
> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> > @@ -416,6 +416,7 @@ struct edid *drm_get_edid(struct drm_connector *con=
nector,
> >                         struct i2c_adapter *adapter);
> >  struct edid_base_block *drm_edid_get_base_block(struct i2c_adapter *ad=
apter);
> >  u32 drm_edid_get_panel_id(struct edid_base_block *base_block);
> > +bool drm_edid_has_monitor_string(struct edid_base_block *base_block, c=
onst char *str);
> >  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
> >                                    struct i2c_adapter *adapter);
> >  struct edid *drm_edid_duplicate(const struct edid *edid);
>
> --
> Jani Nikula, Intel

