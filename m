Return-Path: <linux-kernel+bounces-94784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7899874531
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A251F25836
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAAB1848;
	Thu,  7 Mar 2024 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JDLDKPiM"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4311373
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709771882; cv=none; b=al49x7Vd1dl8jW1J6vJD4EIm54ty0xuDVA+vXl17Br7wdwFa53nE0tH0kRiplbVjcnXaOKAdHsUzxGCDX7EPE9Qg1MhR5PKW8syanrOIXwJy8E3EW7vkvLdfZU3yk0x2Ami2/GGWsafVAw554xejqS0XhvnNK4dhrAaK65Yn8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709771882; c=relaxed/simple;
	bh=bPheLYGDXhnA7EPoFKPre7/5a/mryXSmKzIhEsD2wmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J13im8d09UXNm5C8OyHB7yI3NSEo/xOYPf5+3+dj0LAt3U+MZadFiBekyxJR1ygbJS3zaIcxrpka5ajj6bfLc58kZBezwmSFGdmAqNgFU1g+fuSV1V/R4TtGUT3Rg0shtL9tH5S27vzhD+DO7s7d9POnJDG3AZSkbG9EGkm2sNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JDLDKPiM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42f13eebabbso1397581cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709771879; x=1710376679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7/zi3CCS/AlP7Knl+RPHO7eIgrqMmuL7/+zYnH8IaA=;
        b=JDLDKPiMBr6455Sv+mfD6C6+w/938h0SVuzOVZgeyOaslfJ3DRjTmJ/lGhCYhLAvoE
         87UWbDw3tIaDXFmHtJX2X5bUKeAhG23lnMj1U+V9lWVkuws0hafN0Lv5zwPChzVXXwAE
         38MJibc52WIOln4PfSbVsrmLFT/+IhcYL7h/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709771879; x=1710376679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7/zi3CCS/AlP7Knl+RPHO7eIgrqMmuL7/+zYnH8IaA=;
        b=ewj6khk0m9TJMWPCVpg0Hz4hypZV9zOmKeKRB4XvaAOr8KFlyR4JhIHZiyoRKrJY+2
         btKuwGJPiW0/R0yMvMotIiFT3yiXFy6ifqgwzFglPbKKUef42cmmegRs5dNWvN2xrAW3
         e+07fgCGyYZnGJH2tYT1gHvyQLbFFz+CWmLuMybAeRSTRizeAnPLd7Dwk/gNkV5b//Qb
         7qFUPj8H+LLXqed28IBmPck0CJFbpODbKFAq58by7MXjiLBYaOx0H2TExwsVmTQSkc/d
         Lfn9ARVTwDUx5oYdFF8pX69Uho5MOpzSdAGirGj1gvOQ3h3zzvDKEyyAcSKIEPFuU3yk
         Ui2A==
X-Forwarded-Encrypted: i=1; AJvYcCUdycQM2JixgY9pNhDBqQDmGVlCZuRwKrddGuzX3X3wZ5fpHrTkjJgDz1fEecLhp+pjiNUJ6vWFw9bbBXN3poiQPdpMO5NChnOgMYeo
X-Gm-Message-State: AOJu0YwiwZPy0ws4KMNgbHQ6pi40SaCmLeeqYM8oOJIN3q0wql4RkT+X
	PshnrSF3EHdEk6zUZdpkGoTJd7DltRwqYFqlwCNacWjZujyizM6fWj3NS9/iKDC6nGhb79o1Bz0
	=
X-Google-Smtp-Source: AGHT+IFHzrrVjIl3/YAA816I5S/VXm6ZQOhjf2H6QtqELWV8IQ4dRa4BDfvwco4uQl/H5ZiBnzxYAw==
X-Received: by 2002:a05:622a:1191:b0:42e:d4c7:4e1 with SMTP id m17-20020a05622a119100b0042ed4c704e1mr6544458qtk.44.1709771879540;
        Wed, 06 Mar 2024 16:37:59 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id x18-20020ac87ed2000000b0042ef4d442bcsm3284755qtj.82.2024.03.06.16.37.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 16:37:59 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42ee0c326e8so134551cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:37:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXU2gp3yv5t+yuT6GcFvboWnJnvIn7W50vZIBJsDwBppLwg5LQs52Rf9T++abAevf67Zh7qzHnFhf9XIzVj8zQOSTU3Cyxor0cU37Jb
X-Received: by 2002:a05:622a:1a0e:b0:42f:a3c:2d46 with SMTP id
 f14-20020a05622a1a0e00b0042f0a3c2d46mr97100qtb.7.1709771878386; Wed, 06 Mar
 2024 16:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-4-hsinyi@chromium.org>
 <CAD=FV=W2CKoOyhN49RBU0FdzcRC6SEwvVQYdJRnBBK16Lp-=FQ@mail.gmail.com> <CAJMQK-i=0COuMGW+PGv3zT4+JgwJc_Qj9oQHva6EQys_n3xoHA@mail.gmail.com>
In-Reply-To: <CAJMQK-i=0COuMGW+PGv3zT4+JgwJc_Qj9oQHva6EQys_n3xoHA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Mar 2024 16:37:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VHaU4HZHGp6tSoVuJRbYD9nrMZfNdnOait=ApRcvcmug@mail.gmail.com>
Message-ID: <CAD=FV=VHaU4HZHGp6tSoVuJRbYD9nrMZfNdnOait=ApRcvcmug@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/edid: Add a function to match EDID with identity
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 6, 2024 at 4:20=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> On Wed, Mar 6, 2024 at 3:30=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.o=
rg> wrote:
> > >
> > > +static void
> > > +match_identity(const struct detailed_timing *timing, void *data)
> > > +{
> > > +       struct drm_edid_match_closure *closure =3D data;
> > > +       unsigned int i;
> > > +       const char *name =3D closure->ident->name;
> > > +       unsigned int name_len =3D strlen(name);
> > > +       const char *desc =3D timing->data.other_data.data.str.str;
> > > +       unsigned int desc_len =3D ARRAY_SIZE(timing->data.other_data.=
data.str.str);
> > > +
> > > +       if (name_len > desc_len ||
> > > +           !(is_display_descriptor(timing, EDID_DETAIL_MONITOR_NAME)=
 ||
> > > +             is_display_descriptor(timing, EDID_DETAIL_MONITOR_STRIN=
G)))
> > > +               return;
> > > +
> > > +       if (strncmp(name, desc, name_len))
> > > +               return;
> > > +
> > > +       /* Allow trailing white spaces and \0. */
> > > +       for (i =3D name_len; i < desc_len; i++) {
> > > +               if (desc[i] =3D=3D '\n')
> > > +                       break;
> > > +               if (!isspace(desc[i]) && !desc[i])
> > > +                       return;
> > > +       }
> >
> > If my code analysis is correct, I think you'll reject the case where:
> >
> > name =3D "foo"
> > desc[13] =3D "foo \0zzzzzzzz"
> >
> > ...but you'll accept these cases:
> >
> > desc[13] =3D "foo \nzzzzzzzz"
> > desc[13] =3D "foo \0\0\0\0\0\0\0\0\0"
> >
> > It somehow seems weird to me that a '\n' terminates the string but not =
a '\0'.
>
> I'm also not sure about \0... based on
> https://git.linuxtv.org/edid-decode.git/tree/parse-base-block.cpp#n493,
> they use \n as terminator. Maybe we should also reject \0 before\n?
> Since it's not printable.

Ah, OK. I guess the EDID spec simply doesn't allow for '\0' in there.
I guess in that case I'd prefer simply removing the code to handle
'\0' instead of treating it like space until we see some actual need
for it. So just get rid of the "!desc[i]" case?

-Doug

