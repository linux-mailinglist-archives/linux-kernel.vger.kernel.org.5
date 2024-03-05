Return-Path: <linux-kernel+bounces-91541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C767871360
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3046F1C21D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518FA18026;
	Tue,  5 Mar 2024 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="adOyu57+"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A017C79
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604741; cv=none; b=Jdy5FX2G3fN2Umbq+hc6Af4hQCEKjoXpR6+liwNs8HjpeirffaM0XzCH2pdIGPTbDcDlhkokKSC0cWdA1wPLsGFJPpp4aZ1mMQb/IFi35fI8len0iU4CSrbgochLa2AQURhAMsC17LvbZ0W8m9SLIDpusZebstpCc8dn4wSmRPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604741; c=relaxed/simple;
	bh=IXSwZcTybLtfve1wbLkmJ2Vzz1c6u6Vv9etl6W+lVRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNWQunG4//d6R5BCW7nu+S7VquF3mSydcWRZakS1YcTqPtoKQ00g3lDavRf7MU9BXj1ONzlygzRmg+GA0Wv66pcuGtMcwFJweSuSWc+kC4CcQFn57cnaR/iBju5onaeCwqviGIV/EbidHybuY3JHbFMxx8Xh6xbGhTK7+0rXrx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=adOyu57+; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e4b34f2455so2843835a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 18:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709604739; x=1710209539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF+fEVjSH5v4rFI4iZimQ3ZeTa/4LGoYI8GB9M78M10=;
        b=adOyu57+7eMVCQJREAOxCpdBiPOSfrNUVtutAz+LJWEJas4Mtl1qsKt57NxdWu0Cmu
         tSAawirdEuYiZasCIq4hPuiBbZogrD8GbossXRhQqsuqWgV/+5QIFJElJa/npz2AaODL
         XdfSBzTripkBA7CsSvMvx65cTVN/t5LdttvOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604739; x=1710209539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CF+fEVjSH5v4rFI4iZimQ3ZeTa/4LGoYI8GB9M78M10=;
        b=XH7sBBZauwvDcxlDT8qpEQjhetRxj5CeoW94oAl7Z9PT+gjJDgNu202iAGuXWfCGV7
         23502YGDzTOeSvdasCG2BlWgPeeY4Euk1yIQQnfPezv0yClL9Oui8MF41Gh4Z1fVXfg2
         yWG8ENEq7iEK6pbqVqQ4hKtsrcTCmoECwfvYsbyED/0uvlhc8s6cavkvO9eowsDyOH2o
         C0tlJWkn3p2sNch6NW1zIRSC8dG1uT/PMvOY+cbDR1n1Iv7LuqpciQCLYZcZm8rEwTbJ
         MLsE4ifRpazbrIfm2BYjhSMj6BTZCPl/iiZvXoQ0YiMxUvWvRnWllh7/xN3dUkafMFR1
         9Uwg==
X-Forwarded-Encrypted: i=1; AJvYcCXOk/4zpNaNu/apecx42Snqa+fJhoBX81yEKpK2+8fNxthi15v9wWRXZa27rV7Vurj2kQEEhUNkDhav4sD7Tcn2+x/BJRMzmaNeEFOK
X-Gm-Message-State: AOJu0Ywbghf48sYq4W3CsOqUacoap8ETfDQEkuZ+NqUDbjnp9A15zW87
	nfcVhBZshuEgxm8TijqHWGP5ah4ZF5smZGpZFFlPIYJ+cImKAbxZ7M1bbCtUjU2QdV1LgdJF38z
	GYOLNI+Hv9fiStJZksUNJxpAjdxv4fYScORNR
X-Google-Smtp-Source: AGHT+IGQXOyx1de033pAPnzJObrTw4uLW6N5nNSAQeaF4CnzaxgBhDz/k4lSXBcbRD7WW0jUiJ2y1jrfIQgkZEpGppg=
X-Received: by 2002:a05:6830:6d08:b0:6e4:d884:40d0 with SMTP id
 dz8-20020a0568306d0800b006e4d88440d0mr1095179otb.0.1709604738800; Mon, 04 Mar
 2024 18:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304195214.14563-1-hsinyi@chromium.org> <20240304195214.14563-3-hsinyi@chromium.org>
 <87a5nd4tsg.fsf@intel.com> <CAJMQK-j4wGah=szyUW53hu-v6Q4QjgR7WMLKnspoFaO9oPfaQw@mail.gmail.com>
 <874jdl4k01.fsf@intel.com>
In-Reply-To: <874jdl4k01.fsf@intel.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Mon, 4 Mar 2024 18:11:52 -0800
Message-ID: <CAJMQK-i284bO=dSOZTsgJaMMWDCqXmYB_SDJbhx3U1s-U==S2A@mail.gmail.com>
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

On Mon, Mar 4, 2024 at 4:09=E2=80=AFPM Jani Nikula <jani.nikula@linux.intel=
com> wrote:
>
> On Mon, 04 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > On Mon, Mar 4, 2024 at 12:38=E2=80=AFPM Jani Nikula <jani.nikula@linux.=
intel.com> wrote:
> >>
> >> On Mon, 04 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >> > Add a function to check if the EDID base block contains a given stri=
ng.
> >> >
> >> > One of the use cases is fetching panel from a list of panel names, s=
ince
> >> > some panel vendors put the monitor name after EDID_DETAIL_MONITOR_ST=
RING
> >> > instead of EDID_DETAIL_MONITOR_NAME.
> >> >
> >> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >> > ---
> >> > v2->v3: move string matching to drm_edid
> >> > ---
> >> >  drivers/gpu/drm/drm_edid.c | 49 +++++++++++++++++++++++++++++++++++=
+++
> >> >  include/drm/drm_edid.h     |  1 +
> >> >  2 files changed, 50 insertions(+)
> >> >
> >> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> >> > index 13454bc64ca2..fcdc2bd143dd 100644
> >> > --- a/drivers/gpu/drm/drm_edid.c
> >> > +++ b/drivers/gpu/drm/drm_edid.c
> >> > @@ -2789,6 +2789,55 @@ u32 drm_edid_get_panel_id(struct edid_base_bl=
ock *base_block)
> >> >  }
> >> >  EXPORT_SYMBOL(drm_edid_get_panel_id);
> >> >
> >> > +/**
> >> > + * drm_edid_has_monitor_string - Check if a EDID base block has cer=
tain string.
> >> > + * @base_block: EDID base block to check.
> >> > + * @str: pointer to a character array to hold the string to be chec=
ked.
> >> > + *
> >> > + * Check if the detailed timings section of a EDID base block has t=
he given
> >> > + * string.
> >> > + *
> >> > + * Return: True if the EDID base block contains the string, false o=
therwise.
> >> > + */
> >> > +bool drm_edid_has_monitor_string(struct edid_base_block *base_block=
, const char *str)
> >> > +{
> >> > +     unsigned int i, j, k, buflen =3D strlen(str);
> >> > +
> >> > +     for (i =3D 0; i < EDID_DETAILED_TIMINGS; i++) {
> >> > +             struct detailed_timing *timing =3D &base_block->edid.d=
etailed_timings[i];
> >> > +             unsigned int size =3D ARRAY_SIZE(timing->data.other_da=
ta.data.str.str);
> >> > +
> >> > +             if (buflen > size || timing->pixel_clock !=3D 0 ||
> >> > +                 timing->data.other_data.pad1 !=3D 0 ||
> >> > +                 (timing->data.other_data.type !=3D EDID_DETAIL_MON=
ITOR_NAME &&
> >> > +                  timing->data.other_data.type !=3D EDID_DETAIL_MON=
ITOR_STRING))
> >> > +                     continue;
> >> > +
> >> > +             for (j =3D 0; j < buflen; j++) {
> >> > +                     char c =3D timing->data.other_data.data.str.st=
r[j];
> >> > +
> >> > +                     if (c !=3D str[j] ||  c =3D=3D '\n')
> >> > +                             break;
> >> > +             }
> >> > +
> >> > +             if (j =3D=3D buflen) {
> >> > +                     /* Allow trailing white spaces. */
> >> > +                     for (k =3D j; k < size; k++) {
> >> > +                             char c =3D timing->data.other_data.dat=
a.str.str[k];
> >> > +
> >> > +                             if (c =3D=3D '\n')
> >> > +                                     return true;
> >> > +                             else if (c !=3D ' ')
> >> > +                                     break;
> >> > +                     }
> >> > +                     if (k =3D=3D size)
> >> > +                             return true;
> >> > +             }
> >> > +     }
> >> > +
> >> > +     return false;
> >> > +}
> >> > +
> >>
> >> So we've put a lot of effort into converting from struct edid to struc=
t
> >> drm_edid, passing that around in drm_edid.c, with the allocation size =
it
> >> provides, and generally cleaning stuff up.
> >>
> >> I'm not at all happy to see *another* struct added just for the base
> >> block, and detailed timing iteration as well as monitor name parsing
> >> duplicated.
> >>
> >> With struct drm_edid you can actually return an EDID that only has the
> >> base block and size 128, even if the EDID indicates more
> >> extensions. Because the whole thing is *designed* to handle that
> >> gracefully. The allocated size matters, not what the blob originating
> >> outside of the kernel tells you.
> >>
> >> What I'm thinking is:
> >>
> >> - Add some struct drm_edid_ident or similar. Add all the information
> >>   that's needed to identify a panel there. I guess initially that's
> >>   panel_id and name.
> >>
> >>     struct drm_edid_ident {
> >>         u32 panel_id;
> >>         const char *name;
> >>     };
> >>
> >> - Add function:
> >>
> >>     bool drm_edid_match(const struct drm_edid *drm_edid, const struct =
drm_edid_ident *ident);
> >>
> >>   Check if stuff in ident matches drm_edid. You can use and extend the
> >>   existing drm_edid based iteration etc. in
> >>   drm_edid.c. Straightforward. The fields in ident can trivially be
> >>   extended later, and the stuff can be useful for other drivers and
> >>   quirks etc.
> >>
> >> - Restructure struct edp_panel_entry to contain struct
> >>   drm_edid_ident. Change the iteration of edp_panels array to use
> >>   drm_edid_match() on the array elements and the edid.
> >>
> >> - Add a function to read the EDID base block *but* make it return cons=
t
> >>   struct drm_edid *. Add warnings in the comments that it's only for
> >>   panel and for transition until it switches to reading full EDIDs.
> >>
> >>     const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter=
 *adapter);
> >>
> >>   This is the *only* hackish part of the whole thing, and it's nicely
> >>   isolated. For the most part you can use drm_edid_get_panel_id() code
> >>   for this, just return the blob wrapped in a struct drm_edid envelope=
.
> >
> > To clarify:
> > struct drm_edid currently is only internal to drm_edid.c. So with
> > change we will have to move it to the header drm_edid.h
>
> Absolutely not, struct drm_edid must remain an opaque type. The point is
> that you ask drm_edid.c if there's a match or not, and the panel code
> does not need to care what's inside struct drm_edid.
>

Sorry I might be misunderstanding about the requests here:

If drm_edid should remain opaque, then struct drm_edid remains opaque,
drm_edid_match() should take struct edid *edid as a parameter? just as
other exposed functions in drm_edid.

If panel edp doesn't hold drm_edid returned from
drm_edid_read_base_block(), what should it use to iterate the
edp_panels array?

for (panel =3D edp_panels; panel->panel_id; panel++)
    if(drm_edid_match(drm_edid, panel->ident))
        ...

> >
> >>
> >> - Remove function:
> >>
> >>     u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
> >>
> >
> > Probably change to u32 drm_edid_get_panel_id(const struct drm_edid
> > *);? Given that we still need to parse id from
> > drm_edid_read_base_block().
>
> No, we no longer need to parse the id outside of drm_edid.c. You'll have
> the id's in panel code in the form of struct drm_edid_ident (or
> whatever), and use the match function to see if the opaque drm_edid
> matches.
>
> >
> >> - Refactor edid_quirk_list to use the same id struct and match functio=
n
> >>   and mechanism within drm_edid.c (can be follow-up too).
> >>
> >
> > edid_quirk currently doesn't have panel names in it, and it might be a
> > bit difficult to get all the correct names of these panels without
> > having the datasheets.
> > One way is to leave the name as null and if the name is empty and skip
> > matching the name in drm_edid_match().
>
> Exactly. NULL in drm_edid_ident would mean "don't care". I think most of
> the ones in panel code also won't use the name for matching.
>
> BR,
> Jani.
>
> >
> >> - Once you change the panel code to read the whole EDID using
> >>   drm_edid_read family of functions in the future, you don't have to
> >>   change *anything* about the iteration or matching or anything, becau=
se
> >>   it's already passing struct drm_edid around.
> >>
> >>
> >> I hope this covers everything.
> >>
> >> BR,
> >> Jani.
> >>
> >>
> >> >  /**
> >> >   * drm_edid_get_base_block - Get a panel's EDID base block
> >> >   * @adapter: I2C adapter to use for DDC
> >> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> >> > index 2455d6ab2221..248ddb0a6b5d 100644
> >> > --- a/include/drm/drm_edid.h
> >> > +++ b/include/drm/drm_edid.h
> >> > @@ -416,6 +416,7 @@ struct edid *drm_get_edid(struct drm_connector *=
connector,
> >> >                         struct i2c_adapter *adapter);
> >> >  struct edid_base_block *drm_edid_get_base_block(struct i2c_adapter =
*adapter);
> >> >  u32 drm_edid_get_panel_id(struct edid_base_block *base_block);
> >> > +bool drm_edid_has_monitor_string(struct edid_base_block *base_block=
, const char *str);
> >> >  struct edid *drm_get_edid_switcheroo(struct drm_connector *connecto=
r,
> >> >                                    struct i2c_adapter *adapter);
> >> >  struct edid *drm_edid_duplicate(const struct edid *edid);
> >>
> >> --
> >> Jani Nikula, Intel
>
> --
> Jani Nikula, Intel

