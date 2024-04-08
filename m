Return-Path: <linux-kernel+bounces-135172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D40389BC28
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5384C282E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D094D9F5;
	Mon,  8 Apr 2024 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="addyEJG1"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54A4D10A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569427; cv=none; b=fltIPcHoIAFM7Je3ZU1p58U7V9H3YclCg5CBM6J2G8K//6yMrMEJPq/UoLhY75lejVcgnzZNTjA4t8kqaGVPDDxDR2Sj5vzG1xp0310PZQTXaSnnhOzz0jy+LTj2q8PYzBK9Ju9ZaksNEKqnok7jmi9M61no/DIEiN/cRamPXX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569427; c=relaxed/simple;
	bh=DfcDS/24EHie0GBAOzBRJj0oeiC4e1RiJwh83Aj89FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1msF+ua5HVq7ndSjzDK4RE0rCz/T8XSQbaBw5d4AZbLdOZF7pV13iZMJ3Q82CffmcnsGvQUye0RG+F2uvk7z5BXKd7g6GZy/zg6KwazG5YWSte46fEeosPX257NM37gme/v9JEuxfsKyGF+GAnrSPdhcXJjjAN4HFS+Q/ZKNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=addyEJG1; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso5584961fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712569424; x=1713174224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPya01S6Zk3ZrZqtvKApfiBgMxDUZyecK666tWaDBy8=;
        b=addyEJG10oCH/UuWgmolduq3Hg9H0HzOUmP24Bl9Yv4ZrTZUTMZOtsH+zxCc6K3fpt
         3yMnDLwvn7PdxjByq5gqbX88/8eDsaMomyDr2mWtX+ujnlara1AgORklhT7tNUtfZWk0
         cIMmspoZXD5NVCQDDFDDJGtbd4ghcwWuL205WCp7qmcdRTo0B1wOprOFc+xVN/C86w8u
         sdQIftvlGmd0NgWDXO8xVqBmhhgvonYRhPo/3hSxwG5LFqYZpGU/WsARUjxlr5/LNqzp
         z2jib7vLGY1NaEO/7Jz7dx7ofy+3jwPfs0pUqPBI/nvczJwKaIxZKQgW71vhZIloZIFH
         ICRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712569424; x=1713174224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPya01S6Zk3ZrZqtvKApfiBgMxDUZyecK666tWaDBy8=;
        b=BKs++3DQJ/VSIvs4wPds92qhl8RyNAc9qj3lPwxEhkDC/qzWvUJbBoqUp0itdy4YiR
         vcJZh4uRGW9BeIhI6alB0h+evl0/0xHmpDXyTYw+yfdS/FswJwoao5UM32GdVEAW2FYm
         CpEFUHplzxg6L49x8b7oyIehHhlJSQ30KxLUsisXZYkt4ETdBe9EhTqkeszwO97ANfUZ
         Vpu+HDaGaOFDQ7am8qohwPVJrVjp1uC5A53LlDp/LorQGKI63Qt+4FSDFhUmimK/2ir7
         XxstNL88mpp9CJfZAP5Fzi+3PS3qAppANwzs+wEbR3SabH+bfn6/MKVvBvierUOqzK1Q
         j3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV7o06UCINgcbOG8J3aVIr6NgGneLRLQt3RtPPwwjzBJK0TeOiGdbIvMRqwrDEhS54Cu1PNDjiOE+9YkaabnYMN1OsBHoAMojoj/Ofw
X-Gm-Message-State: AOJu0YwsPi2vsSYbCDhaZHSo4HABxC9jzHpNra3BrNmodMs5B0i5b06N
	mpyglOkhRdU2z3sb2rlSmJFcq16XbQk9jrFp0cvNDm/tUAN3DiX0mTgJA9pLD/iZQ/XhVs0ubKX
	TJ8xkDmx1zZhdehkyZ2bsG8nkRYiZixEDI/mGxKzck7coG7Y3lpU7/g==
X-Google-Smtp-Source: AGHT+IG02loiXTH2/8F9IqgC2gGyD1D1+rLbDNMI3wgXR6zMfH2ZR1scOgp/QJMJ+mhu/mYbcsEBISkQp7KwOmIrIAM=
X-Received: by 2002:a2e:90d6:0:b0:2d8:729f:cf3a with SMTP id
 o22-20020a2e90d6000000b002d8729fcf3amr4666714ljg.32.1712569423895; Mon, 08
 Apr 2024 02:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
 <20240403-msm-drm-dsc-dsi-video-upstream-v1-2-db5036443545@linaro.org> <CAA8EJpo-tZSOD+B+4znyBmFPVOjc6yocsVwYMXPN5d3WQfbr=Q@mail.gmail.com>
In-Reply-To: <CAA8EJpo-tZSOD+B+4znyBmFPVOjc6yocsVwYMXPN5d3WQfbr=Q@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 8 Apr 2024 17:43:43 +0800
Message-ID: <CABymUCOFxHLE5QTiW4cVuSgmOhH5ZJd=G0VPZkHzQR==tew8gA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] drm/msm/dsi: set video mode widebus enable bit
 when widebus is enabled
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B44=E6=
=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 18:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 3 Apr 2024 at 12:11, Jun Nie <jun.nie@linaro.org> wrote:
> >
> > From: Jonathan Marek <jonathan@marek.ca>
> >
> > The value returned by msm_dsi_wide_bus_enabled() doesn't match what the
> > driver is doing in video mode. Fix that by actually enabling widebus fo=
r
> > video mode.
> >
> > Fixes: efcbd6f9cdeb ("drm/msm/dsi: Enable widebus for DSI")
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
>
> You have ignored all the review comments that were provided for v1.
> None of the tags were picked up either.
Just find that It was an accident that I cherry-picked wrong patch.
>
> Have you posted this for internal review like I have explicitly asked you=
?
Sorry, I guess I skipped your word in depression when I read the email.
>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi.xml.h  | 1 +
> >  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/ds=
i/dsi.xml.h
> > index 2a7d980e12c3..f0b3cdc020a1 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
> > +++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> > @@ -231,6 +231,7 @@ static inline uint32_t DSI_VID_CFG0_TRAFFIC_MODE(en=
um dsi_traffic_mode val)
> >  #define DSI_VID_CFG0_HSA_POWER_STOP                            0x00010=
000
> >  #define DSI_VID_CFG0_HBP_POWER_STOP                            0x00100=
000
> >  #define DSI_VID_CFG0_HFP_POWER_STOP                            0x01000=
000
> > +#define DSI_VID_CFG0_DATABUS_WIDEN                             0x02000=
000
> >  #define DSI_VID_CFG0_PULSE_MODE_HSA_HE                         0x10000=
000
>
> From the top of the file:
>
> /* Autogenerated file, DO NOT EDIT manually!
This is my fault, I did not notice the top of this file totally. Will
fix it in next version.

>
> >
> >  #define REG_DSI_VID_CFG1                                       0x00000=
01c
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/d=
si/dsi_host.c
> > index 9d86a6aca6f2..2a0422cad6de 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > @@ -754,6 +754,8 @@ static void dsi_ctrl_enable(struct msm_dsi_host *ms=
m_host,
> >                 data |=3D DSI_VID_CFG0_TRAFFIC_MODE(dsi_get_traffic_mod=
e(flags));
> >                 data |=3D DSI_VID_CFG0_DST_FORMAT(dsi_get_vid_fmt(mipi_=
fmt));
> >                 data |=3D DSI_VID_CFG0_VIRT_CHANNEL(msm_host->channel);
> > +               if (msm_dsi_host_is_wide_bus_enabled(&msm_host->base))
> > +                       data |=3D DSI_VID_CFG0_DATABUS_WIDEN;
> >                 dsi_write(msm_host, REG_DSI_VID_CFG0, data);
> >
> >                 /* Do not swap RGB colors */
> >
> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry

