Return-Path: <linux-kernel+bounces-153405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C218ACDBC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AECC1F21211
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374AF14E2FC;
	Mon, 22 Apr 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLUUp6Bg"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BE414A4C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791082; cv=none; b=exarKI3c9OB5JbTOlVei/5RpwgC2QMK3hCdGWSpBgrwFd5xLnEm3XkZQK42ETJsb2ez2gPQVzq9fh7JQoDhwWJqQzDXbt34R1eKtnKh0N6JZxe8rUuwS1RlRuRE6NPOk5SWCK//oO/G95sVk3t/yhLfh1uLBFbw/uHYAuYPXkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791082; c=relaxed/simple;
	bh=A8rWCJ755aK/NQ0pCWuBPXg8gWo13fRFIsVRFtZBxOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owbZVdYuZvpyQZA9M0YNzYDJMAVpTazy+B80GAAHsekSvp0RziSnstVb9dOCbHBF6iN6klWz6rVzsGxYAIKfhyjo4Qt4loWiu7BsV8v6PY6qxmpYKd+5mO/5D1Scpw9FJNgV5kjCoW4bi/KnITv+vodAWxk8IWCWxAeSQN41yRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLUUp6Bg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2adce8f7814so823398a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713791077; x=1714395877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rssIs5Z4PDRLHwlKnxXtcDFwbhBTkpedIgqO4pjxlBA=;
        b=jLUUp6BgMI9h3fG1w62tlzG4bjAscgFo8ReVrapw0+R1sG61k48gvvatwasw+WZW9K
         NC0U1ci2FkuJZlgxeWsBZecT/2Pq5VO6nYZXk4pghl5a4FIkfYSwWrQU/3jCA+s03Q9G
         hUxMfmXRs0Vvky+zEAoK/QwJj/RNADK25VogF/t9TCWWQb8q5gpk9dPkwqkDAmUiF6Pg
         2hcaGlxM574YRuPpyI1PoyaFejJfYLJeFK1Qbrh76Jn9CjNt/9GVZwPgDQiP53CZZHTd
         9x236uDqbDPuDVs4vtUlZKYH2d2pbZ0IMaJ47ft64rlKeQYYFZNFLTXhLBZg+RPGIvnn
         ArXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713791077; x=1714395877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rssIs5Z4PDRLHwlKnxXtcDFwbhBTkpedIgqO4pjxlBA=;
        b=iRYT3O8wCcF4PnedQNxfACESm3pAUGzixZLVCpCLrMmN7xffsmJ8fhfWU8IqDYb1ry
         1/07uvCUXLM8XlesS4vXwwSVpv/qq71UVwi2VX48M1BsjB61x7UgC0+OETN1H1Q9afrm
         6nibf7FHI5MJasx5GsKEY2Fnu1GyZ6D36ulKaSyO2Wu9EgdOHWxoOjBY3McQYPF3FvJs
         +fdlLrvXr2ikR6pw86LLS6W06JdmFCJATwnDZtqkHSZm7znTfANu8xe2rp5IScNjUyrr
         Tdkpq1oaS7RPs3drP+oIeUwKRhIUcjWEXeTEfxsvtfWb1yETT2esI61adHfCcZ+yQ9zj
         EQuA==
X-Forwarded-Encrypted: i=1; AJvYcCXDg7UZ0C2i5VW9woeg6YQJiCUf5WMZmlJeJgn/FZajNxiTjZhV2/a1k3TROyCvNGBMjQSRoi6tXdoeoHv36/y+d7HJDzuGJ3IX3QS2
X-Gm-Message-State: AOJu0YzhbGG7D6+6bZcmASZ0NseJkiANlniqWwl+bKGwp1vllTseYoi9
	cfRQcIi1LZrduaMYvc4/eUzK0TBxrm5wDDqUdBE6+oOJToeIxq+QTOyNdFgs5xfISUt9dqLy3gv
	qU/Q8xBvmTal3Y45oKLP/wb9jNoPdoZ+h
X-Google-Smtp-Source: AGHT+IF1ksQignCW8zAnmCOI9fglM8+zEJqk8wCkLDa2hG4T31IAsm25alnnLSKjWG2VHZKc0xg72Ht8S/v613xvPiI=
X-Received: by 2002:a17:90a:cc15:b0:2a4:7133:7e02 with SMTP id
 b21-20020a17090acc1500b002a471337e02mr8467438pju.35.1713791077126; Mon, 22
 Apr 2024 06:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211230931.188194-1-aford173@gmail.com> <20240211230931.188194-2-aford173@gmail.com>
 <6111fe04-4ecb-428e-9a0c-dc02cadfe3e7@denx.de> <CAHCN7x+DwSSabhGYZ1dnZzwRe+BJfz2H-AXbxjUQWytrq3OMpQ@mail.gmail.com>
 <47b26a19-9aba-4380-9d05-f06bd8bc20b1@denx.de>
In-Reply-To: <47b26a19-9aba-4380-9d05-f06bd8bc20b1@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 22 Apr 2024 08:04:25 -0500
Message-ID: <CAHCN7x+R5t5o13tFrQ1trH1LTPshSOOvuerDpUTY++Umqwr=WA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
To: Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, aford@beaconembedded.com, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Marco Felsch <m.felsch@pengutronix.de>, Michael Tretter <m.tretter@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 8:01=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 4/22/24 2:09 PM, Adam Ford wrote:
> > On Sun, Apr 21, 2024 at 9:36=E2=80=AFAM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 2/12/24 12:09 AM, Adam Ford wrote:
> >>> When using video sync pulses, the HFP, HBP, and HSA are divided betwe=
en
> >>> the available lanes if there is more than one lane.  For certain
> >>> timings and lane configurations, the HFP may not be evenly divisible.
> >>> If the HFP is rounded down, it ends up being too small which can caus=
e
> >>> some monitors to not sync properly. In these instances, adjust htotal
> >>> and hsync to round the HFP up, and recalculate the htotal.
> >>>
> >>> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron B=
L i.MX8MM with HDMI monitor
> >>> Signed-off-by: Adam Ford <aford173@gmail.com>
> >>> ---
> >>> V2:  No changes
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/=
bridge/samsung-dsim.c
> >>> index 8476650c477c..52939211fe93 100644
> >>> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> >>> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> >>> @@ -1606,6 +1606,27 @@ static int samsung_dsim_atomic_check(struct dr=
m_bridge *bridge,
> >>>                adjusted_mode->flags |=3D (DRM_MODE_FLAG_PHSYNC | DRM_=
MODE_FLAG_PVSYNC);
> >>>        }
> >>>
> >>> +     /*
> >>> +      * When using video sync pulses, the HFP, HBP, and HSA are divi=
ded between
> >>> +      * the available lanes if there is more than one lane.  For cer=
tain
> >>> +      * timings and lane configurations, the HFP may not be evenly d=
ivisible.
> >>> +      * If the HFP is rounded down, it ends up being too small which=
 can cause
> >>> +      * some monitors to not sync properly. In these instances, adju=
st htotal
> >>> +      * and hsync to round the HFP up, and recalculate the htotal. T=
hrough trial
> >>> +      * and error, it appears that the HBP and HSA do not appearto n=
eed the same
> >>> +      * correction that HFP does.
> >>> +      */
> >>> +     if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->la=
nes > 1) {
> >>
> >> Does this also apply to mode with sync events (I suspect it does), so
> >> the condition here should likely be if (!...burst mode) , right ?
> >
> > Thanks for the review!
> >
> > I was only able to test it with the DSI->ADV6535 bridge, and I'll
> > admit I don't know a lot about DSI interface since I don't have a copy
> > of the spec to read.
> >
> > Are you proposing this should be:
> >
> >   if (!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) && dsi->lanes > 1)=
 {
> >
> > I just want to make sure I understand what you're requesting.
>
> Yes, exactly this.

Do you think it should also include checks for
MIPI_DSI_MODE_VIDEO_NO_HFP, MIPI_DSI_MODE_VIDEO_NO_HBP or
MIPI_DSI_MODE_VIDEO_NO_HSA?

It seems like if any of these are set, we should skip this rounding stuff.

adam

