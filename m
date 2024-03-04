Return-Path: <linux-kernel+bounces-91203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A89870B28
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE821F25427
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956D7A139;
	Mon,  4 Mar 2024 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BEiLH2++"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CC6166B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582759; cv=none; b=Mf7RNkMcRyueq4b15W5QT6ze3FxLb6svmigqEhGWJIiOK371PqMLVzQbWMHCEb1+jmAZNmaGiNEcIJAn6oL0Co+5f+1OxNls7CcyzNKttDcVnZI0S7w7wEvF9yvPf6DfbVOl9oVtv8XUSoe/YdzFnAjOzCXJ7/r5dwl9zCWodkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582759; c=relaxed/simple;
	bh=/rdOwsjcGqmfBPcXazsZzCzftV7WvYKs9f2a1DMaOPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdxNup1TUIE9il01MVXwc5Aam8xg2tO4cNzWMwCMo47d1ZXzk90uala9Rw6C1yVFkD9ODT3z7+yRpjgnoyDfAWneHekYDZShzp91nChjlHyVbnkoY3jkVrOM+GMOFaS6AmWc7gX9IL7vmRBukTHGKK6+8twMGYFTakF5jnKo13k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BEiLH2++; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a136ac89b3so904691eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709582757; x=1710187557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nxf/mA/VgPtg2OrsbLLlCUBuEWdcx/aWwnqkxYTHIhA=;
        b=BEiLH2++wbNb+ahud+g8RuP0NZdXQTvOo0wPD/Lhai+jk3zeYicUujuOsnqkKfRGQN
         oZv07HfjPXmrw04iJ/nj1WEnTeQ9HdKR9DaZoGgQB55AsWxetohK8KdMX5qPC9ogMggZ
         wZ8L6n2DITZ7q0VIni5UJKB+l5nJ/jtSEe6bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709582757; x=1710187557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nxf/mA/VgPtg2OrsbLLlCUBuEWdcx/aWwnqkxYTHIhA=;
        b=wLTRPH2MO0Wraw3vuZ4Ft/L+ylUH2WnJx4u02GD5CTAwPOgLa7gmWimK3hM7nMURFi
         OlXwdG+FamVeWdFfTqjT3hBgEB3pR/eAuW3sDj9BU1zf6wwFTno4JxK32Bm2tDu2ElQr
         vz05QZt+u2bOqkvWk3epGheV3QphW9hqw82GPgNNA6OXUTw7PG+mQNh3nAyWcExHrpBX
         arcN95w8LwAISBlfBX2uVYwmkknX/kazGiARlApzv4DU/8OeoF39drsru9d4DAj796SF
         PwQODkbulnxLdhlpgW9+kh632LUAISC3oA+k0uR7bVBy2Qt0pDlvS9Wny2QICp500E2r
         jyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHEq2svaaaonMevAO8+cVIMzeY+WM+XN60PtvJCAW8xlXlSJpTgtm9cGlUzqjI+YOqsJTYSiFwL1b6dx1jPCLqXt0cMbLrIEIB18ed
X-Gm-Message-State: AOJu0YzUMRNcJ/T69aIQptnqFQW4aIhE+fHXmexry/FTAEoOVfNjupy9
	4YzL34urakvRCNX5glYHg1b8qjCWX3NNRD124W7KkMDgcZFqueX5/Jj+vFZgaIh/dmnpRSN5hez
	fDVVDLZj25tn/3Gt/SUJeqt6XHybSyNjUt1Nh
X-Google-Smtp-Source: AGHT+IE97L3oTLhc1yeQSjlUUd8Y0K4I0glbVsOWyXn/G7S75Iw50C7dw0+Pn1PVvGHgaApTgYqbPPxFxk5s3UdWknY=
X-Received: by 2002:a05:6871:206:b0:21f:1f78:adc9 with SMTP id
 t6-20020a056871020600b0021f1f78adc9mr12265436oad.29.1709582757348; Mon, 04
 Mar 2024 12:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228011133.1238439-1-hsinyi@chromium.org> <20240228011133.1238439-4-hsinyi@chromium.org>
 <CAD=FV=VV6fprky=v9koiVGmWcXKL3V4F2LOu7FriPbT_zT6xyA@mail.gmail.com>
In-Reply-To: <CAD=FV=VV6fprky=v9koiVGmWcXKL3V4F2LOu7FriPbT_zT6xyA@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Mon, 4 Mar 2024 12:05:31 -0800
Message-ID: <CAJMQK-gMvTVWr7b_+3+KLWCAMNQQEtoXg6qZLVset7GLRgeVqQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: panel-edp: Fix AUO 0x405c panel naming
 and add a variant
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:22=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Feb 27, 2024 at 5:11=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org=
> wrote:
> >
> > There are 2 different AUO panels using the same panel id. One of the
> > variants requires using overridden modes to resolve glitching issue as
> > described in commit 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode"=
).
> > Other variants should use the modes parsed from EDID.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v2: new
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
>
> The previous version of this patch that we reverted also had an
> override for AUO 0x615c. Is that one no longer needed?
>

I currently don't have the exact panel to verify at hand. If the
dependent code is agreed and accepted, I will send out a patch for
this panel later.


>
> > @@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B11=
6XAN06.1"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B11=
6XTN02.5"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B14=
0HAN04.0"),
> > -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B=
116XAK01.0"),
> > +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B=
116XAN04.0 "),
> > +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "=
B116XAK01.0 ",
> > +                        &auo_b116xa3_mode),
>
> The name string now has a space at the end of it. I _guess_ that's OK.
> Hmmm, but I guess you should update the kernel doc for "struct
> edp_panel_entry". The name field is described as "Name of this panel
> (for printing to logs)". Now it should include that it's also used for
> matching EDIDs in some cases too.

