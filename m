Return-Path: <linux-kernel+bounces-94775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41587451B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6189285ECA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04703800;
	Thu,  7 Mar 2024 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FcJlHJ8Q"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F636C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709770836; cv=none; b=pYTnnPObeBfSUvs49nGupmHI36Im+N/b+rvjlJz50mvVOloAGylKv1vRvHMB44GaSJQ7WpoHTEd9bcd7wC0j95qMErCuTQJjtVJTTxMMVcXdMhpecXlxkMDaRLa/SP7kdi/ghUO1Hog9CxEKNh3dnGpg6rI/kH9ynC/dt4BNYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709770836; c=relaxed/simple;
	bh=SqWY2hqL1dYNKJu9j0CXZZripAdMjo3AmY7yqabxZO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAvXdGo5WZ26gpGC0dDAVlFDttRgTiWiFRqDa6ANwpnNdT3SHpvo55gibffMY4WvvXbEexUqiUtHVnaBBTwueTsTGm9z8g8w1WSH6q52qDBgn7Prnsi1PjXcydGdtBp1umGiSCX+BlFCYYaGSFOBkdt1uOlnjkjyw4af3jf1Azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FcJlHJ8Q; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e432514155so183561a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709770834; x=1710375634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gKocubseZGXNLUpd/fuBD9DCeE26SidITG4A2LjDvY=;
        b=FcJlHJ8QU21OTe2ccTAGqJzf9zAv6I5Rv2qO/lQ9rSBdgDSyJfvVrdCk3S/spWNwmn
         mIRFO/TQby61AjzlQvGfbukLCXaO4bOpuiQ/YOzgTuIvqtadBc1jLTh743qfGu2syAzS
         LypyxfG4rePTuxrQ7Tk8LxT/0cWtzAQUTgwdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709770834; x=1710375634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gKocubseZGXNLUpd/fuBD9DCeE26SidITG4A2LjDvY=;
        b=IGdA1i88hoLO38BxV6i37q7QYQ9SPMSRvfAXYfPLf+p+6T0gZr7BLj3gco1YxMZftU
         F2IaP84aWFmgGjH4iq3QDg0AXI1I6bhhG429We0S6Z1F0o+uhUu8T/ZcncRQZQWIZOvw
         KE3W83S3elIQgR9SUaO+BI+xmfS90kH7kwdxh19do0wj+7j6itETbzEPm8NQq/UK/fxu
         +Gnt6nExpopyQhZeXlEumthCEPvpCG9YmCDq7c8kB1sNvC9qT0B3/b2T35Ag65Soi3kI
         HEaWBL/02EGCMebYqgcH4Gvm/gRj5/kVyrKrw5aYoJaIhcoa/Y9qwh6KZ4q4AdEp9uJX
         bkww==
X-Forwarded-Encrypted: i=1; AJvYcCXi+qPvOBWHvDhhEWPRk5R19G/v8tu5S1I/ymVHH/XX08jqf0Z1DhKQkS0IiMJao6/knOAcQxdIDzy+u52jJ4B0gZY1dbNhCLHDIcZ8
X-Gm-Message-State: AOJu0YxvUFOlGFLR1c5pfw3UmhC+91IMzapm6581c/d60PwU58H+AdsO
	iS36xB48ExFnEYquqRnRSA+oC4fLnhWSI4ZrmImjIIYV7dq2ReCqVaXNUFVAQ8EIM9nnY86Ocre
	fVO1JxGBttMtaj3SDBCeGb3yA44NsQxEVHng4
X-Google-Smtp-Source: AGHT+IEtHB+kPDonI5+YXi6phytTz0mQ8M6d6xl7sVU+dvIAdH7vTdbZeVC/9dkBONN5lN0edTkf6SiICAK4HTDXcJM=
X-Received: by 2002:a05:6830:920:b0:6e4:e63e:f5ab with SMTP id
 v32-20020a056830092000b006e4e63ef5abmr8407257ott.17.1709770833789; Wed, 06
 Mar 2024 16:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-4-hsinyi@chromium.org>
 <CAD=FV=W2CKoOyhN49RBU0FdzcRC6SEwvVQYdJRnBBK16Lp-=FQ@mail.gmail.com>
In-Reply-To: <CAD=FV=W2CKoOyhN49RBU0FdzcRC6SEwvVQYdJRnBBK16Lp-=FQ@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 6 Mar 2024 16:20:08 -0800
Message-ID: <CAJMQK-i=0COuMGW+PGv3zT4+JgwJc_Qj9oQHva6EQys_n3xoHA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/edid: Add a function to match EDID with identity
To: Doug Anderson <dianders@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 3:30=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org=
> wrote:
> >
> > +static void
> > +match_identity(const struct detailed_timing *timing, void *data)
> > +{
> > +       struct drm_edid_match_closure *closure =3D data;
> > +       unsigned int i;
> > +       const char *name =3D closure->ident->name;
> > +       unsigned int name_len =3D strlen(name);
> > +       const char *desc =3D timing->data.other_data.data.str.str;
> > +       unsigned int desc_len =3D ARRAY_SIZE(timing->data.other_data.da=
ta.str.str);
> > +
> > +       if (name_len > desc_len ||
> > +           !(is_display_descriptor(timing, EDID_DETAIL_MONITOR_NAME) |=
|
> > +             is_display_descriptor(timing, EDID_DETAIL_MONITOR_STRING)=
))
> > +               return;
> > +
> > +       if (strncmp(name, desc, name_len))
> > +               return;
> > +
> > +       /* Allow trailing white spaces and \0. */
> > +       for (i =3D name_len; i < desc_len; i++) {
> > +               if (desc[i] =3D=3D '\n')
> > +                       break;
> > +               if (!isspace(desc[i]) && !desc[i])
> > +                       return;
> > +       }
>
> If my code analysis is correct, I think you'll reject the case where:
>
> name =3D "foo"
> desc[13] =3D "foo \0zzzzzzzz"
>
> ...but you'll accept these cases:
>
> desc[13] =3D "foo \nzzzzzzzz"
> desc[13] =3D "foo \0\0\0\0\0\0\0\0\0"
>
> It somehow seems weird to me that a '\n' terminates the string but not a =
'\0'.

I'm also not sure about \0... based on
https://git.linuxtv.org/edid-decode.git/tree/parse-base-block.cpp#n493,
they use \n as terminator. Maybe we should also reject \0 before\n?
Since it's not printable.

>
> I would have done:
>
>       for (i =3D name_len; i < desc_len; i++) {
>               /* Consider \n or \0 to terminate the string */
>               if (desc[i] =3D=3D '\n' || desc[i] =3D=3D '\0')
>                       break;
>               /* OK for spaces at the end, but non-space is a fail */
>               if (!isspace(desc[i]))
>                       return;
>       }
>
>
> > @@ -367,6 +367,12 @@ struct edid {
> >         u8 checksum;
> >  } __attribute__((packed));
> >
> > +/* EDID matching */
> > +struct drm_edid_ident {
> > +       u32 panel_id;
> > +       const char *name;
>
> Might not hurt to have a comment for panel_id saying that it's encoded
> by drm_edid_encode_panel_id() so it's obvious what this random u32 is.
>
>
> -Doug

