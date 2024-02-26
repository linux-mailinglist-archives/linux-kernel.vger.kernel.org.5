Return-Path: <linux-kernel+bounces-82405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB708683C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982611F24C51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1141332A8;
	Mon, 26 Feb 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="af5UOfVa"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01530133297
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986576; cv=none; b=gNihK53A2777egmmHH3OBXyG+r8GtR5mcsJ0IFgBEz/lWJZGslF+Jg9DMP8i6DL5cdnARVgvoStzxPBpali1gPnpTpdfkiw/nGCe1ovAereaACtm/AipVnwHZ9kP2SdiUgUYCr74ESpD3Cbsdb6BaoGk+xaIX6and0KGtyW1qEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986576; c=relaxed/simple;
	bh=DsDDSyPBgZqnY3CSzZlOLHq/B5mOa9M41a1se4ku2zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OU0TN4FlS7D6xJPxmzCegqYiuT+x0dxNL9E5RhhBBDUl/Uoq46Lw8Fp0foYGrcT5MgaZhyJU2XvuIGH8NeR2ORAYtK6oVSkvaxrXpk3DrmoosNWNzfgiSrRfMvgW0rb9C7+17WMew27ufNdX3RxNgKOdjh/YbqMGsvDJHU5qoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=af5UOfVa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so556487066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708986572; x=1709591372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuIzu435dlmGo3lOGVsPepILsYzogjK0C5/lBC0KUtk=;
        b=af5UOfVaWAxaDugkaTnj7y6IhKiWNZnYd+pfuqUbrSNgNf/9RUV/V/1gOzpl/+QXxA
         upjJMaTea1s7sfOxn9knRN2lIrDN/E+TwMw39Pdd+RSVpiF7NPC8Cwe0jquLiIwBnlWO
         LWVGqr6LVigqUjmDJDz055/zspHsKgV1xYr9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708986572; x=1709591372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuIzu435dlmGo3lOGVsPepILsYzogjK0C5/lBC0KUtk=;
        b=PCtGAG/xIbhWJCUxrgcLuWFOyAP4KsYiSNOclZiokCJqXNGRYOwNCU9RJvjy4ONgnO
         mBh2zPn8M+ydoN5fd3OZDeSrR9g6neM1280esx0yA8zbjwApnkK25ErOnIodLd5PV5qr
         qUD2ktjka2htGrzp4xnEArfykF4pmMRMs3F+RLd7hLaUU18YZqFKo2nmT6oQqYJHJY+6
         XmRTBWkcfL9kpCajs3RkFeMvHloiISSC3A1NvkeKtdafZvlx2aFDvjvtTouJwBXqR+UI
         FJ2M0aNkOM3pewgdIJQX0Tbw93zsCCYrXNcymU8DXos+W/am7anGcOlMSTv6LrmJqU2n
         XbTA==
X-Forwarded-Encrypted: i=1; AJvYcCWPhCdTPBaMKcbQa6idPDWMRArp5vkY3efwI9h8GKGl5ck3UIVamGoq4a2JCoQqDwndhuYUZVQQ4yLC1Oj7kAaajWucT7oGcqIzAWc/
X-Gm-Message-State: AOJu0YzeAXe1hOCpTa12ntXtVSHYM3N5jDVTwSd1YqnSMsOxnWrRsfrj
	SnIJFvdGdwg+J8F8yZs1PP0tOQvoDN9dGvYArVCInrUmDW34v53mKJyU7M2+Uo2xy2Nm08Jo0l0
	U+qBW
X-Google-Smtp-Source: AGHT+IGuWVCr9UD9yyS57ndMSsbvdqN0ybajdJ3ef9ZmtVCHMyZR/SsXQVUln00TEV+ktNtpatDCAQ==
X-Received: by 2002:a17:906:5841:b0:a42:e756:23ef with SMTP id h1-20020a170906584100b00a42e75623efmr4902955ejs.7.1708986572470;
        Mon, 26 Feb 2024 14:29:32 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id hu11-20020a170907a08b00b00a3fcbd4eb2esm157498ejc.1.2024.02.26.14.29.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:29:31 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so4455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:29:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUywyrLDep7Iae5CGOqwyDuv44ynSdJCqHWz3RpikrbMkumFcsu4lZyQAI3L5C0erX1JG1TluponU2hQF0f6uW2mnO16JdoZlA3SohE
X-Received: by 2002:a05:600c:1d8b:b0:412:a80e:a5cc with SMTP id
 p11-20020a05600c1d8b00b00412a80ea5ccmr28353wms.1.1708986571269; Mon, 26 Feb
 2024 14:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-3-hsinyi@chromium.org>
In-Reply-To: <20240223223958.3887423-3-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 14:29:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xs4V7ei4NW0T0x0Bq6_dQF6sZKvFSy2WGQFQsHae=61Q@mail.gmail.com>
Message-ID: <CAD=FV=Xs4V7ei4NW0T0x0Bq6_dQF6sZKvFSy2WGQFQsHae=61Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: panel-edp: Match with panel hash for
 overridden modes
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2024 at 2:40=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> It's found that some panels have variants that they share the same panel =
id
> although their EDID and names are different. One of the variants requires
> using overridden modes to resolve glitching issue as described in commit
> 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode"). Other variants shou=
ld
> use the modes parsed from EDID.
>
> For example, AUO 0x405c B116XAK01.0, it has at least 2 different variants
> that EDID and panel name are different, but using the same panel id. One =
of
> the variants require using overridden mode. Same case for AUO 0x615c
> B116XAN06.1.
>
> Add such entries and use the hash of the EDID to match the panel needs th=
e
> overridden modes.

As pointed out in an offline discussion, it's possible that we might
want to "ignore" some of these bytes for the purpose of the CRC.
Specifically, we might want to ignore:
* byte 16 - Week of manufacture
* byte 17 - Year of manufacture
* byte 127 - Checksum

That way if a manufacturer actually is updating those numbers in
production we can still have one hash that captures all the panels. I
have no idea if manufacturers actually are, but IMO the hash of the
rest of the base block should be sufficient to differentiate between
different panels anyway. It would be easy to just zero out those 3
bytes before computing the CRC.

What do you think?


> @@ -758,13 +762,13 @@ static void panel_edp_parse_panel_timing_node(struc=
t device *dev,
>                 dev_err(dev, "Reject override mode: No display_timing fou=
nd\n");
>  }
>
> -static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
> +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, u32 pa=
nel_hash);
>
>  static int generic_edp_panel_probe(struct device *dev, struct panel_edp =
*panel)
>  {
>         struct panel_desc *desc;
>         void *base_block;
> -       u32 panel_id;
> +       u32 panel_id, panel_hash;
>         char vend[4];
>         u16 product_id;
>         u32 reliable_ms =3D 0;
> @@ -796,15 +800,17 @@ static int generic_edp_panel_probe(struct device *d=
ev, struct panel_edp *panel)
>         base_block =3D drm_edid_get_base_block(panel->ddc);
>         if (base_block) {
>                 panel_id =3D drm_edid_get_panel_id(base_block);
> +               panel_hash =3D crc32_le(~0, base_block, EDID_LENGTH) ^ 0x=
ffffffff;

Any reason you need to XOR with 0xffffffff?


> @@ -2077,13 +2098,32 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         { /* sentinal */ }
>  };
>
> -static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
> +/*
> + * Similar to edp_panels, this table lists panel variants that require u=
sing
> + * overridden modes but have the same panel id as one of the entries in =
edp_panels.
> + *
> + * Sort first by vendor, then by product ID.

Add ", then by hash" just in case we need it.


> +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, u32 pa=
nel_hash)
>  {
>         const struct edp_panel_entry *panel;
>
> -       if (!panel_id)
> +       if (!panel_id || !panel_hash)
>                 return NULL;

IMO just remove the check above. Not sure why it was there in the
first place. Maybe I had it from some older version of the code?
Callers shouldn't be calling us with a panel ID / hash of 0 anyway,
and if they do they'll go through the loop and return NULL anyway.



-Doug

