Return-Path: <linux-kernel+bounces-167613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B328BABFD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64DF1F22B28
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC4152E05;
	Fri,  3 May 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ee3ChdEh"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236E152DF0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737443; cv=none; b=rnQhZ2WqwAalnVAa//2Lq8RUwoHsChZGBhXLh7jxLalteAFA+NhG0pHgqyW/dv9qXefyJa3quj/UzIZt89xRH5jc+uAg8LreQbHDPxyBt4zQmB/IDM4AMcrfU7pd4leoJgi2dCM4GJzWiELoye6vv/YREz3fHj300p0zPDtW6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737443; c=relaxed/simple;
	bh=CmcuBbTVhho6EBimKTWKrm1lTdbe7FzUQrr9f+yUs1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTjzt9VGsyKswrehhmmZbW/1qCd13ergMJAbj7Tvp1PZQ93jjJUt+sAfOx6MEiGfsHDSl0vWqTHUCsX4hyn5rENu/NLYEugIKbQW3YeqP4M4OcCuAzkdGCwbAx171APAT/ixaNihMTSVQnDtj1BwJjEp2AEIS88+Z6ID0AO1s4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ee3ChdEh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso326570b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714737440; x=1715342240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7hPKV3HF7+4pxzh8EgR7k2JkSmFNYuW+tKLwH6I0Lg=;
        b=Ee3ChdEhqgMcMnYD+98HDx2vIaePiS4F8ej72udYqhX68vnFv7st5bt2/2MPVLsXR8
         jOIM3PdJNsZy/omnxG4Uz5S3OJN9ebb710IRuYS7eS5l+h1iIGUGsuP6UVfHwaghY3xY
         DYChXe3C90vExbTk1fbB0ndJBWVPaVz5GBRNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714737440; x=1715342240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7hPKV3HF7+4pxzh8EgR7k2JkSmFNYuW+tKLwH6I0Lg=;
        b=UjwNsbW7WVv2fcliiOzvikCH6CVJ3LP8m5Or/VdTWWa4r1n2tOnB18x5Q/VxFFCmhP
         EsGssrTYatRqjNX3wSaOdf3dY8+uG1dfn/IM2YJTG7aW4lOzYgTneETAuRtA2bFv6BYK
         19xO4JhQipnElfONpTwDoZlXB6aWftPYHbPDr8AdGSU/N8cljpUlc78UUEZbxeGqVgxM
         NoJ+1j0fK7U/505MNiF292D+a7tnOMeReDl9VwOQzwxx+vUsmewWFrylM6aKIc9PhN59
         l6tvTYo7wTWqEN/sXg3uIM1V8VRBuSH+KohoV9QpubyWc06Nwt4nxOcaSujNhoY0F0Mt
         P4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMhNdi/ZNi6f9n7TMcpaaqAkNgajpN1rRr9wqMM3szMDwC+HK2spC7l9Mz46UWr/f94pVOu4r2SdjWssIsuBl9MpA6FSFIi987lSx+
X-Gm-Message-State: AOJu0YwupISpWfClk4hdZOyIyqFuYDgzIM4tF3KdwtYa8QHOYBewDGES
	WWlkTn2KQ7ZHQ/fAlwMcOb27FJ7VYkg7WkDV+r3tyffba9FAXnJKoh4qXKjnAZwESBKB4IkWfJw
	DIw==
X-Google-Smtp-Source: AGHT+IHKQ6JPcE22hviAwZgz4gQZZDgFc+0w+hO7WXJ6mla3dcNffreanwXDbTRbMMxHss90ykqRLA==
X-Received: by 2002:a05:6a00:2287:b0:6f3:ee4f:e28a with SMTP id f7-20020a056a00228700b006f3ee4fe28amr2306793pfe.32.1714737439786;
        Fri, 03 May 2024 04:57:19 -0700 (PDT)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com. [209.85.214.171])
        by smtp.gmail.com with ESMTPSA id p8-20020a056a000a0800b006ecc6c1c67asm2892448pfh.215.2024.05.03.04.57.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 04:57:17 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so89514005ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:57:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCgD96Ul0LW4v5LX0T2fcgeXOAmFuVv/99V2TymEW9vlAbRP+sRO4aje+mTjqwNP6mlUry/Lpill4IZDcQ3942zJFGYTFebO+LuFEm
X-Received: by 2002:a05:6102:2329:b0:47b:d717:b689 with SMTP id
 b9-20020a056102232900b0047bd717b689mr2266975vsa.4.1714737415965; Fri, 03 May
 2024 04:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429-fix-cocci-v3-0-3c4865f5a4b0@chromium.org>
 <20240429-fix-cocci-v3-26-3c4865f5a4b0@chromium.org> <20240503112758.763d8d31@sal.lan>
 <c4287024-8012-458d-9829-15ffbceb25cf@moroto.mountain>
In-Reply-To: <c4287024-8012-458d-9829-15ffbceb25cf@moroto.mountain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 3 May 2024 13:56:44 +0200
X-Gmail-Original-Message-ID: <CANiDSCsU+jgYkUmHZOC8xPsL2DbgU7_sWrby1bQAXQNnp+g6Bg@mail.gmail.com>
Message-ID: <CANiDSCsU+jgYkUmHZOC8xPsL2DbgU7_sWrby1bQAXQNnp+g6Bg@mail.gmail.com>
Subject: Re: [PATCH v3 26/26] media: dvb-frontends: tda10048: Make the range
 of z explicit.
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Martin Tuma <martin.tuma@digiteqautomotive.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hugues Fruchet <hugues.fruchet@foss.st.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Osipenko <digetx@gmail.com>, 
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am trying to get the DS, but
https://www.nxp.com/acrobat_download/literature/9397/75015931.pdf is a
dead links now.

Anyone have access to the datasheet?

Thanks!

On Fri, 3 May 2024 at 13:55, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Fri, May 03, 2024 at 11:27:58AM +0100, Mauro Carvalho Chehab wrote:
> > Em Mon, 29 Apr 2024 15:05:05 +0000
> > Ricardo Ribalda <ribalda@chromium.org> escreveu:
> >
> > > We do not expect the sample_freq to be over 613MHz.
> > >
> > > Found by cocci:
> > > drivers/media/dvb-frontends/tda10048.c:345:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/dvb-frontends/tda10048.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
> > > index 3e725cdcc66b..1886f733dbbf 100644
> > > --- a/drivers/media/dvb-frontends/tda10048.c
> > > +++ b/drivers/media/dvb-frontends/tda10048.c
> > > @@ -328,7 +328,8 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
> > >                          u32 bw)
> > >  {
> > >     struct tda10048_state *state = fe->demodulator_priv;
> > > -   u64 t, z;
> > > +   u32 z;
> > > +   u64 t;
> > >
> > >     dprintk(1, "%s()\n", __func__);
> > >
> > > @@ -341,6 +342,7 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
> > >     /* t *= 2147483648 on 32bit platforms */
> > >     t *= (2048 * 1024);
> > >     t *= 1024;
> > > +   /* Sample frequency is under 613MHz */
> >
> > Are you sure about that? Some DVB devices have very high frequency
> > clocks, specially if they're also used for satellite, so I can't
> > be sure by just looking at the driver's code.
> >
> > Also, we had already a bunch of regressions with "fixes" like this
> > that actually broke frontend drivers.
>
> This patch preserves the existing behavior. The sample_freq_hz variable
> is a u32 so, in the original code, z couldn't have been more than
> U32_MAX even though it was declared as a u64.
>
> It's possible that the original code was wrong.  We have seen that in
> other places in this patchset.  Adding a note about the datasheet is
> also a good idea.
>
> regards,
> dan carpenter
>


-- 
Ricardo Ribalda

