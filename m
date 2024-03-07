Return-Path: <linux-kernel+bounces-96115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E6D875752
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D37B21CAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF88136997;
	Thu,  7 Mar 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BcBMs+0X"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34081350D6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840119; cv=none; b=YoUjTSnhGWwTCw2OIiyZnLf2/6Vati63FPuD8UvH5pmRYcbeWd8R9mC8fjfEWltVCMFsiF4gygCayfIXdjqOJMwc6rwck70Kbep2Rtt0Kp97fwdXlwD+OdLMzNsP4Wn155jVJ+fCGmOj1kRW5MPibrL5mPpSMLqYvv4HnCaVwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840119; c=relaxed/simple;
	bh=YZa2Puc8dR/Q5Y07TuiOEY1RYfGUqbqG7yd3zOoMVZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTZyXqL2Fzk6tVim7P4e43tpY7leaxTjWWQ7DNpgab0LrMF8u1VCm+e7nih7uFCXCyLGMmwnVuivY/KtOBmpwvxE3TufHFN/tZIk7p/pu6gbs5hZb9Ayf9UzHwOySmDUzD+v6EE7vgkuZMs6rwI6kuqAlVCOeny2Rcy5Y/G49F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BcBMs+0X; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e5027608a9so612688a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709840117; x=1710444917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK3ZSwKK2C4Sgaq4Kpjc9c6oG9lJHBr2owryJEMOEvc=;
        b=BcBMs+0XrLfDL/EmMcfAOvAu6qDWrZxHB33kwPfVv8kUSJ2lk00pVzKVqwAZshkOWu
         B16tAqKCR6b77FGU5WriO2gKAIsgOZkE1DnPFUL3xl1j862pCuPZ4eXDHh4VD6j+foOc
         zzCMePUzwL/uL0+Hcps5ks7Hczkp5blj0lXnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709840117; x=1710444917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK3ZSwKK2C4Sgaq4Kpjc9c6oG9lJHBr2owryJEMOEvc=;
        b=F0UgP8qy5tLPmjTA1h62MA5fV7iSzxMf9fRV+4hVlRdMpy8+IxjUbYPPr0icqNv74i
         cG6wCNErAT8sLH6wMEZZy3WPVUGdyw5Aht6uj34gksHNEyf+eR3EnrZt4P07uK2uo+Ve
         HIKkxADgKPuOuwXl0TBrJ8K9XQMeFejEzZ9hSV5bDZQDOhdY6/n7YoqZZLkHzMLbyyo5
         aUFN4KtZYH7zqz8SvAWRb4svOdDm2k9T9vFdMReaaDcmIkYg2jCgiVSbJ3y+n0q+CpYd
         TR9wkyRW7zc04uYMj+R5DaItn5zHSlEs6DIWWhk5wBZ3g5xIjofnS8KPH0qCvEV8zBdq
         WvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdjvaU4vT5WwS3IGpYJGoZQCe2vQoYt3rH5KdL2LClQTQdVf28hBwDOgaEpWgdxYHQfOU8YkfyeTGTzAppIZFWchFwmd/HU6mxOEYz
X-Gm-Message-State: AOJu0YxYbBKJLv3XjtCZ9k11bdl3TihLR5HW+jV0z816l41DZTP0eWpd
	U6r+JZVcN7xB7lG1VvtFERJ+iGzsayypc7muLadCydp4dNsda7tZEtuccKIocVQgW65net9qLeJ
	Shsj0xefvJyK6efhaqzjmSXc53l4JiDMb8V/m
X-Google-Smtp-Source: AGHT+IEa7Z6B5cOslGdycgOfQrqUbifAuF6iyS6t6w765cGIbVMH6LPjb9/MiG331Yt0RpMjBp9oH47As6PW+ZAKdpc=
X-Received: by 2002:a05:6830:3449:b0:6e5:253:1af8 with SMTP id
 b9-20020a056830344900b006e502531af8mr5990484otu.22.1709840117072; Thu, 07 Mar
 2024 11:35:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-4-hsinyi@chromium.org>
 <CAD=FV=W2CKoOyhN49RBU0FdzcRC6SEwvVQYdJRnBBK16Lp-=FQ@mail.gmail.com>
 <CAJMQK-i=0COuMGW+PGv3zT4+JgwJc_Qj9oQHva6EQys_n3xoHA@mail.gmail.com>
 <CAD=FV=VHaU4HZHGp6tSoVuJRbYD9nrMZfNdnOait=ApRcvcmug@mail.gmail.com> <87r0gmw544.fsf@intel.com>
In-Reply-To: <87r0gmw544.fsf@intel.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Thu, 7 Mar 2024 11:34:51 -0800
Message-ID: <CAJMQK-igm-OXa=L-Bb0hdm5+KL98sk9UAznvAR7SptP9iwWAoA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/edid: Add a function to match EDID with identity
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Doug Anderson <dianders@chromium.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:20=E2=80=AFAM Jani Nikula <jani.nikula@linux.intel=
com> wrote:
>
> On Wed, 06 Mar 2024, Doug Anderson <dianders@chromium.org> wrote:
> > Hi,
> >
> > On Wed, Mar 6, 2024 at 4:20=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.or=
g> wrote:
> >>
> >> On Wed, Mar 6, 2024 at 3:30=E2=80=AFPM Doug Anderson <dianders@chromiu=
m.org> wrote:
> >> >
> >> > Hi,
> >> >
> >> > On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromiu=
m.org> wrote:
> >> > >
> >> > > +static void
> >> > > +match_identity(const struct detailed_timing *timing, void *data)
> >> > > +{
> >> > > +       struct drm_edid_match_closure *closure =3D data;
> >> > > +       unsigned int i;
> >> > > +       const char *name =3D closure->ident->name;
> >> > > +       unsigned int name_len =3D strlen(name);
> >> > > +       const char *desc =3D timing->data.other_data.data.str.str;
> >> > > +       unsigned int desc_len =3D ARRAY_SIZE(timing->data.other_da=
ta.data.str.str);
> >> > > +
> >> > > +       if (name_len > desc_len ||
> >> > > +           !(is_display_descriptor(timing, EDID_DETAIL_MONITOR_NA=
ME) ||
> >> > > +             is_display_descriptor(timing, EDID_DETAIL_MONITOR_ST=
RING)))
> >> > > +               return;
> >> > > +
> >> > > +       if (strncmp(name, desc, name_len))
> >> > > +               return;
> >> > > +
> >> > > +       /* Allow trailing white spaces and \0. */
> >> > > +       for (i =3D name_len; i < desc_len; i++) {
> >> > > +               if (desc[i] =3D=3D '\n')
> >> > > +                       break;
> >> > > +               if (!isspace(desc[i]) && !desc[i])
> >> > > +                       return;
> >> > > +       }
> >> >
> >> > If my code analysis is correct, I think you'll reject the case where=
:
> >> >
> >> > name =3D "foo"
> >> > desc[13] =3D "foo \0zzzzzzzz"
> >> >
> >> > ...but you'll accept these cases:
> >> >
> >> > desc[13] =3D "foo \nzzzzzzzz"
> >> > desc[13] =3D "foo \0\0\0\0\0\0\0\0\0"
> >> >
> >> > It somehow seems weird to me that a '\n' terminates the string but n=
ot a '\0'.
> >>
> >> I'm also not sure about \0... based on
> >> https://git.linuxtv.org/edid-decode.git/tree/parse-base-block.cpp#n493=
,
> >> they use \n as terminator. Maybe we should also reject \0 before\n?
> >> Since it's not printable.
> >
> > Ah, OK. I guess the EDID spec simply doesn't allow for '\0' in there.
> > I guess in that case I'd prefer simply removing the code to handle
> > '\0' instead of treating it like space until we see some actual need
> > for it. So just get rid of the "!desc[i]" case?
>
> The spec text, similar for both EDID_DETAIL_MONITOR_NAME and
> EDID_DETAIL_MONITOR_STRING:
>
>         Up to 13 alphanumeric characters (using ASCII codes) may be used
>         to define the model name of the display product. The data shall
>         be sequenced such that the 1st byte (ASCII code) =3D the 1st
>         character, the 2nd byte (ASCII code) =3D the 2nd character,
>         etc. If there are less than 13 characters in the string, then
>         terminate the display product name string with ASCII code =E2=80=
=980Ah=E2=80=99
>         (line feed) and pad the unused bytes in the field with ASCII
>         code =E2=80=9820h=E2=80=99 (space).
>
> In theory, only checking for '\n' for termination should be enough, and
> this is what drm_edid_get_monitor_name() does. If there's a space
> *before* that, it should be considered part of the name, and not
> ignored. (So my suggestion in reply to the previous version is wrong.)
>
> However, since the match name uses NUL termination, maybe we should
> ignore NULs *before* '\n'? Like so:
>
> for (i =3D name_len; i < desc_len; i++) {
>         if (desc[i] =3D=3D '\n')
>                 break;
>         if (!desc[i])
>                 return;
> }
>
Allow trailing white spaces so we don't need to add the trailing white
space in edp_panel_entry.

https://lore.kernel.org/lkml/CAA8EJpr7LHvqeGXhbFQ8KNn0LGDuv19cw0i04qVUz51TJ=
eSQrA@mail.gmail.com/

>
> BR,
> Jani.
>
>
> >
> > -Doug
>
> --
> Jani Nikula, Intel

