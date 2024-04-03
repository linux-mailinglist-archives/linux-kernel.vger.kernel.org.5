Return-Path: <linux-kernel+bounces-129989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C08972EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF8428C37E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B753513AA52;
	Wed,  3 Apr 2024 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5x37iJ1"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244225CDC9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155461; cv=none; b=RNyVxhoONTGV05d3Smyl8tykwqp5JLUBOU/1J0I1TbBtm/OONbrJZm9VVLek9zvieCXzg2K4gIGIz/xMKzZfXanWf7bVtql07P6L61VattqJ79GZakMz1lc9hjMh5VsUMd9DIm+g1Fp/j6QMuHK7d9YnjB3JdWCqL2s8n3JFC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155461; c=relaxed/simple;
	bh=lsRpr/8jWj3lfSaJBM3ocC2GdBVv947x6Oo/jhR7VbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH5W/+jjcI6+qm0vrAXEWHqyco2yeIz/REDW3ykR2Uz9GmQcSciudyn8l9w/hIB3eCxvWwJPGYTBGSrCWJ39VK+fcj4AwWeEIR1RMFua3nWsMJgC5NnOv/s9yCUrL0mndjkCZIppmnhMynNWU5+PGqCTlYPWHXYX0JWbZ/G5yqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B5x37iJ1; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d68651e253so88636051fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712155457; x=1712760257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSvZ57t2p82ZJ1lio7M1iLNtxzJMWQfJlM+tiUoDpMs=;
        b=B5x37iJ1QquONlWtQ53VrAHxkHegSkepxHAT1zGfGPWwM6XJ5WlNhxaxargL0FtYhE
         ZiVX66PAbP0pGkCIlRB3I2Wlau2JakbjoJeVZb/P78tNjaqrZk34v+q5kxbgALl0E/Dt
         GjgsGDdxRmbn6zZTfUkkioqzqLUejGjz/ctxYcRaPsg3FpC3SIxniuU+f1CrONkzQVH7
         J4qFjXyOu/WXPo0GCD7+3o+inYmx19HmfD2+rCDQ8er2WiMHnnV5jtAae4KnwobO0/FT
         Fe0uKDScIimvebcWLYZRunRM2bbxMErdntHKHcdY02JdeKPhOFKT4oJ0+V/yCkDMFNAb
         ln5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712155457; x=1712760257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSvZ57t2p82ZJ1lio7M1iLNtxzJMWQfJlM+tiUoDpMs=;
        b=FwrP64RHvzg044s8I6GPLRtGJI5RICGQX3L9UpKOfFVjZsVcOfgADDOVHdIbEabjRp
         wHtCtnlugVdP+z3nHflQSnxnfz3kYYJpfwvLbpSSjrZYIXIwfQqHoz0YtKe9NY31K3Ha
         qKP51dWOJ1r433prqUnefPKoYNKSj15FLIr1Vn2eidYiqVALJ5a6yMzFqEzFzIYaMdn9
         HaHPyVpz+hQDovWrZX8+bucgykn5D6frH9xfka+avCFuVnHT5fZye3mFSqmPBk4hymTb
         Ym6Kfve6jamSU3IlrRJAfUQnRKE082SpSk+fpk3VpS3wvaxnnLpZPCaStYjewGay6UTY
         xNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZzCicpLEemJszMIewG7hxxU3g59wLhCZ1z42WA8FGgvfHqvKIsfHHsXRKW/iPaeZUHC73u31lj+JdmUjilPx0ToCbo4kHjYl9A6oT
X-Gm-Message-State: AOJu0Yx2bqPtUeJ6KljLtkHfaKxE6GvGew8kWS+gfgFRPacvg/b7XTJG
	fdb49r4lv658uVoPCL7aw5Jne/N7wonWA1kYfwCD+bgFL3m0X1gr+jkg/JGZZCBMfIWGTtnQvnW
	1WUbbT9X0xTQcp5mJT2NNgNBs2C35KLi0/+8rkg==
X-Google-Smtp-Source: AGHT+IF1xEeqYKajQd4WFoCF5CO9BwkZ/fZwROFlZBQ88tomzbj9vB/5AKqgIiLAJMNB7Y2JTjHkkgDcp+Ci9CqG+is=
X-Received: by 2002:a2e:8793:0:b0:2d8:3d62:da6c with SMTP id
 n19-20020a2e8793000000b002d83d62da6cmr1498179lji.52.1712155457181; Wed, 03
 Apr 2024 07:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
 <20240403-msm-drm-dsc-dsi-video-upstream-v1-1-db5036443545@linaro.org> <CAA8EJpqF4rVsWG=A1fNYWWi7rjHDmu_ftZttXH1v41v8wBgAiQ@mail.gmail.com>
In-Reply-To: <CAA8EJpqF4rVsWG=A1fNYWWi7rjHDmu_ftZttXH1v41v8wBgAiQ@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 3 Apr 2024 22:44:06 +0800
Message-ID: <CABymUCNNhFTQZ6NSOL8SmLzCSOktvR_Sj0s2TSmqa0_56CSvDg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] drm/msm/dpu: fix video mode DSC for DSI
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
=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 17:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 3 Apr 2024 at 12:11, Jun Nie <jun.nie@linaro.org> wrote:
> >
> > From: Jonathan Marek <jonathan@marek.ca>
> >
> > Add necessary DPU timing and control changes for DSC to work with DSI
> > video mode.
> >
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 9 +++++++++
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 8 ++++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/dri=
vers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > index d9e7dbf0499c..c7b009a60b63 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > @@ -115,6 +115,15 @@ static void drm_mode_to_intf_timing_params(
> >                 timing->h_front_porch =3D timing->h_front_porch >> 1;
> >                 timing->hsync_pulse_width =3D timing->hsync_pulse_width=
 >> 1;
> >         }
> > +
> > +       /*
> > +        * for DSI, if compression is enabled, then divide the horizona=
l active
> > +        * timing parameters by compression ratio.
> > +        */
> > +       if (phys_enc->hw_intf->cap->type !=3D INTF_DP && timing->compre=
ssion_en) {
> > +               timing->width =3D timing->width / 3; /* XXX: don't assu=
me 3:1 compression ratio */
> > +               timing->xres =3D timing->width;
> > +       }
> >  }
> >
> >  static u32 get_horizontal_total(const struct dpu_hw_intf_timing_params=
 *timing)
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_hw_intf.c
> > index 965692ef7892..079efb48db05 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> > @@ -167,6 +167,14 @@ static void dpu_hw_intf_setup_timing_engine(struct=
 dpu_hw_intf *ctx,
> >                 intf_cfg2 |=3D INTF_CFG2_DATABUS_WIDEN;
> >
> >         data_width =3D p->width;
> > +       if (p->wide_bus_en && !dp_intf)
> > +               data_width =3D p->width >> 1;
>
> How is wide_bus relevant to the DSC case?
> Is there a need for the Fixes tag?

48bit bus width should be used when DSC is enabled. Without the
widebus configuration,
a lot dsi error happens as below in DSC case.
[  206.275992] dsi_err_worker: status=3D4

For the Fixes tag, the previous patch mentioned to enable the widebus
mode for any DSC case. So it is fair to add the tag.
>
> > +
> > +       if (p->compression_en)
> > +               intf_cfg2 |=3D INTF_CFG2_DCE_DATA_COMPRESS;
> > +
> > +       if (p->compression_en && dp_intf)
> > +               DPU_ERROR("missing adjustments for DSC+DP\n");
> >
> >         hsync_data_start_x =3D hsync_start_x;
> >         hsync_data_end_x =3D  hsync_start_x + data_width - 1;
> >
> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry

