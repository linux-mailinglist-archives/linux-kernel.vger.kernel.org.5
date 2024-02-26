Return-Path: <linux-kernel+bounces-82414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB118683DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06ED51F25466
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195B5135411;
	Mon, 26 Feb 2024 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZSx7ci83"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6592134722
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987138; cv=none; b=rT9eIlfWC8nBHcM07uOIX4XUz5hErD7BThqwcHoHUaAYiRAfsSX0NvoM+/HmFC6hsyx9wtrtZMOlovQM7zwoCokW89+WF0lMPWprgH7xue2o1LRJxTd6ClLAvc3OAG90BqbMi6XSOvyqrg8kGBSJ/C7E/DTISwftiMY4jdkoU2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987138; c=relaxed/simple;
	bh=Kna95S8a5X5qYHXQaf0hY660SinfhcPH/VKsumHlEU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTc33Uoa5b6KtFjm1M1mpZxi0D/iMtRGsqJkinSwgd/9Iwno9krjJKbo/trywxHpKbbX+MUC+BJ/s449jcfKhbsg5njmeOFbf1Qnm9zhWPINgIGeW87KWT/kv764SrM5X9Zl7hgWQge0chi601aHcz9NBRS8U3ErcmOkmusF/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZSx7ci83; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ddca59e336so2047810a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708987136; x=1709591936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a91PQgJAkXhE3tI3QtihYX3shOIlngJRqPpCQigQ7j0=;
        b=ZSx7ci83tVHTXrit7Y0LLV7NSacAFI2+2cjqLXzM4mxHP8+EOCbs2O9Fo44VMqI5UV
         DmQuiXrAWv1Y3zbseaaTEkYWEF/ZX/DyDS/yVjLBTH3MW3v4rbsSs6i0nl5SXXOmVKYO
         2gpYB7w63mkGnUqRDJ87D+7EuWW4nCTJkqGh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708987136; x=1709591936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a91PQgJAkXhE3tI3QtihYX3shOIlngJRqPpCQigQ7j0=;
        b=tBoAoqnNV/rEif0sDpqLE+h8oVNR37KAR1JgPDnobCno5yOjvQWYxoNmoNjWJjB603
         CQXtfOap8WfIK90ZJr6mPEJmW08KBfAcwlqP3xV2rGsXEpgfX5qEyoEk0NRGbRaVnWGh
         maNOG8lLu1uWwunbiuqeIMj38tzC5bPYv6Ovx0h4CQf764SzKOwDAQfAqEuvVs0XiyRE
         D0dvCFCZ6IJKy82vDJD/YJ6vZBzekLRCiPj5v/Qntrm9Vr7FNzXjJWOo4mi2QFKBCRcP
         7XnllIJsmgzrQJ0+xCUru4GkBAt73/bUp8IFSR85uVV8h4i6R3EWfq8WtCh2rjDzgTcv
         V9bg==
X-Forwarded-Encrypted: i=1; AJvYcCUUc/Eu/P0M7F6ppP9GuVRScTjZLGmiy2MNPyc+7qlKmN09ej4Cl7LG04rPLXfVE6l2jy3lsBkM0Uit+7ZAA1LZsZGpTB2Tvd47s13w
X-Gm-Message-State: AOJu0YxU2ZiQtqW3EhKwyht0aCJD/TlAbPqiR9P2WlWvG8aQ74Uxywnv
	asxC9BJxU3fIHvlYSjAQpoVWvV3bzTwf3hA+MUcNi1eV9/2S1W3IgYDtm4rE9aWK9hBjK9jj4Tq
	0wSO5qY4g+KGt8HEpPara4YLCOY3Tc5udAgxb
X-Google-Smtp-Source: AGHT+IEJSF064zLDcy7THqsCR1Gu3viyZcgQ3FkbswHkFN3DhjMF+9ef6R6pAXqmZFZ5eIfckZ51AgUo6HsG2mo3Z7U=
X-Received: by 2002:a9d:7ccc:0:b0:6e4:779d:f8bc with SMTP id
 r12-20020a9d7ccc000000b006e4779df8bcmr3715976otn.19.1708987135817; Mon, 26
 Feb 2024 14:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-3-hsinyi@chromium.org>
 <CAD=FV=Xs4V7ei4NW0T0x0Bq6_dQF6sZKvFSy2WGQFQsHae=61Q@mail.gmail.com>
In-Reply-To: <CAD=FV=Xs4V7ei4NW0T0x0Bq6_dQF6sZKvFSy2WGQFQsHae=61Q@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Mon, 26 Feb 2024 14:38:30 -0800
Message-ID: <CAJMQK-jKuA_2Y+rQ5q4MkbmkQFJh4+DC98GhExuVt39DTfBwsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: panel-edp: Match with panel hash for
 overridden modes
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 2:29=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Feb 23, 2024 at 2:40=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org=
> wrote:
> >
> > It's found that some panels have variants that they share the same pane=
l id
> > although their EDID and names are different. One of the variants requir=
es
> > using overridden modes to resolve glitching issue as described in commi=
t
> > 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode"). Other variants sh=
ould
> > use the modes parsed from EDID.
> >
> > For example, AUO 0x405c B116XAK01.0, it has at least 2 different varian=
ts
> > that EDID and panel name are different, but using the same panel id. On=
e of
> > the variants require using overridden mode. Same case for AUO 0x615c
> > B116XAN06.1.
> >
> > Add such entries and use the hash of the EDID to match the panel needs =
the
> > overridden modes.
>
> As pointed out in an offline discussion, it's possible that we might
> want to "ignore" some of these bytes for the purpose of the CRC.
> Specifically, we might want to ignore:
> * byte 16 - Week of manufacture
> * byte 17 - Year of manufacture
> * byte 127 - Checksum
>
> That way if a manufacturer actually is updating those numbers in
> production we can still have one hash that captures all the panels. I
> have no idea if manufacturers actually are, but IMO the hash of the
> rest of the base block should be sufficient to differentiate between
> different panels anyway. It would be easy to just zero out those 3
> bytes before computing the CRC.
>
> What do you think?

Agreed that we can zero out these fields.

>
>
> > @@ -758,13 +762,13 @@ static void panel_edp_parse_panel_timing_node(str=
uct device *dev,
> >                 dev_err(dev, "Reject override mode: No display_timing f=
ound\n");
> >  }
> >
> > -static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
> > +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, u32 =
panel_hash);
> >
> >  static int generic_edp_panel_probe(struct device *dev, struct panel_ed=
p *panel)
> >  {
> >         struct panel_desc *desc;
> >         void *base_block;
> > -       u32 panel_id;
> > +       u32 panel_id, panel_hash;
> >         char vend[4];
> >         u16 product_id;
> >         u32 reliable_ms =3D 0;
> > @@ -796,15 +800,17 @@ static int generic_edp_panel_probe(struct device =
*dev, struct panel_edp *panel)
> >         base_block =3D drm_edid_get_base_block(panel->ddc);
> >         if (base_block) {
> >                 panel_id =3D drm_edid_get_panel_id(base_block);
> > +               panel_hash =3D crc32_le(~0, base_block, EDID_LENGTH) ^ =
0xffffffff;
>
> Any reason you need to XOR with 0xffffffff?
>
To be consistent with the crc32[1] command. It's more convenient to be
able to verify it with userspace tools.

[1] https://www.commandlinux.com/man-page/man1/crc32.1.html

>
> > @@ -2077,13 +2098,32 @@ static const struct edp_panel_entry edp_panels[=
] =3D {
> >         { /* sentinal */ }
> >  };
> >
> > -static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
> > +/*
> > + * Similar to edp_panels, this table lists panel variants that require=
 using
> > + * overridden modes but have the same panel id as one of the entries i=
n edp_panels.
> > + *
> > + * Sort first by vendor, then by product ID.
>
> Add ", then by hash" just in case we need it.
>
>
> > +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, u32 =
panel_hash)
> >  {
> >         const struct edp_panel_entry *panel;
> >
> > -       if (!panel_id)
> > +       if (!panel_id || !panel_hash)
> >                 return NULL;
>
> IMO just remove the check above. Not sure why it was there in the
> first place. Maybe I had it from some older version of the code?
> Callers shouldn't be calling us with a panel ID / hash of 0 anyway,
> and if they do they'll go through the loop and return NULL anyway.
>

Sure.

>
>
> -Doug

