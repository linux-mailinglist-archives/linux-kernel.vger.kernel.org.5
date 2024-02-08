Return-Path: <linux-kernel+bounces-58167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41A784E229
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DB928CC3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2235E768F3;
	Thu,  8 Feb 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7EJLL/q"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0B76414
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399738; cv=none; b=IMZaQYuuiD1qz3lNmMy17SiTnug+wP7PYD2zuisl9ufgh4hCr6axWbCflrzKBuDrHnbXndAWVwtrBVwQXwaPhuvd2MZUGwmoeJZzCNYb8wCD2qxFDzYJkn/08gbmDoGzQdu7Mx+oKl+lfv74oyXzER1+/n1HydRfltmPFUniiLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399738; c=relaxed/simple;
	bh=uOtHfrhPnXPwIZuQZ5NE0SeFsssyRsrHFdlNR/E7aF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHil6ZPdkMY3IC4T3pBAk8YayxidCF3dsyOHHknaX9miWCgUw3URg+LUHV2nr9RpSL3MgxzWoiK6iHDxwGfzOjcBEkCYH0/4+swxqAiRdFTvnN8LzJsCLinw4rfNhF3nU77nUk3amdG46H1NCqrBLIG25tBcX+csP2ITN2A/b+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7EJLL/q; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6de8a699dso1788511276.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707399736; x=1708004536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o3L07Zaa/U0Hl10b3niyIyLHQRXKQ0pEwtrFSrjTmGc=;
        b=D7EJLL/qHu/Je6IxHNUN/0yHMTW5F725vlEWZguXXiMieCLYI0WY3KwEnaccNLbBGr
         g3g9hpHKOjEQid99P/cALB64043r5/nKQFIRKWw9d8bzL41C0OLTS5PUQPw92QGwd8a7
         CRVyRbNNKJMOCYjAhqD4nSZ/YQBPBT2Qne4yg6H/NgiDLmvWcXhNYbZ3jOgRABA0pydA
         dffU+c8vukitSIHj9QhWuj8UkeqrMqbbbQSO60kbnXiquofdUHBleNE0qfdvotTxgXTY
         OP/D6FRYwWFRzBbQ/RDqxWdwmh9hvAqajpLFBReTybn+fKEBZT1qihPSMhHIQ95xZg+G
         PL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399736; x=1708004536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3L07Zaa/U0Hl10b3niyIyLHQRXKQ0pEwtrFSrjTmGc=;
        b=g5CqZsbAKSrElOfM6/947rGyeMjoYvw1UwAXQAWBFbcg8rW1ReXUnt9dyDx8cUNTQm
         9gh+LB1u9TuU/mh39/umkq6K58XP/ppsG2iM/OzTMrcPDGSHxhhMABMqHHktjRIN4ac6
         ug7XOfCdAcOolNqU3e/qSAfDBDefrSYs63TEh5lT7RZTpI/zEN7EWhDnenATfdUs52gk
         r/U+gCygWHYi+PWvGxKdc+Ooc35POZ2r3NpWnrOQHEwbOmpNziMVjWVhSFsr9110ibXU
         j0DX0wl+TkaOChwrDzHuKfUGeD+elQs3s8j7gi6+ZC4lbESQnhvT5BHZ2yTpug5hN194
         ICBA==
X-Gm-Message-State: AOJu0YwZKMC6sHM+w7F9UxZ7POIVYPUydMGEML0BTtgeKyOJyAHbBvsF
	Xr6r4pszmvZGDt06tRI9zFQqpCUZt95Nd2p1n3My1PAjlHNZ7Q3nh7DgDAWvnyk4sE4WZEGxGgB
	7dNNIjQUos6vASeqJBaRtf+90KE7Kvv5MIU7KKw==
X-Google-Smtp-Source: AGHT+IF7a6DN/3MmFz1RM6AZhkpDQ4lVtxHHUav0Cuj2WGI8kn65F++9hx3M+kVNGIRqQ/jr0jj40W+GNOPvctN6WRg=
X-Received: by 2002:a5b:bc4:0:b0:dc6:dc58:8793 with SMTP id
 c4-20020a5b0bc4000000b00dc6dc588793mr7751830ybr.45.1707399735707; Thu, 08 Feb
 2024 05:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129-x1e80100-display-v1-0-0d9eb8254df0@linaro.org>
 <20240129-x1e80100-display-v1-3-0d9eb8254df0@linaro.org> <CAA8EJponbo2vvuj2ftCQuxtrZp0w7JQqJ_ADF80Wd2y1V74BzA@mail.gmail.com>
 <ZcTZL+fls7A8O9P0@linaro.org>
In-Reply-To: <ZcTZL+fls7A8O9P0@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 8 Feb 2024 15:42:04 +0200
Message-ID: <CAA8EJpr3p286ff1pHhhBdF7GA=g8Pnv9yWDukwnnNaOuykPcTQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/msm: mdss: Add X1E80100 support
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 15:37, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 24-01-29 17:11:25, Dmitry Baryshkov wrote:
> > On Mon, 29 Jan 2024 at 15:19, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > Add support for MDSS on X1E80100.
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/msm_mdss.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> > > index 455b2e3a0cdd..eddf7fdbb60a 100644
> > > --- a/drivers/gpu/drm/msm/msm_mdss.c
> > > +++ b/drivers/gpu/drm/msm/msm_mdss.c
> > > @@ -564,6 +564,15 @@ static const struct msm_mdss_data sdm670_data = {
> > >         .highest_bank_bit = 1,
> > >  };
> > >
> > > +static const struct msm_mdss_data x1e80100_data = {
> > > +       .ubwc_enc_version = UBWC_4_0,
> > > +       .ubwc_dec_version = UBWC_4_3,
> > > +       .ubwc_swizzle = 6,
> > > +       .ubwc_static = 1,
> > > +       .highest_bank_bit = 2,
> > > +       .macrotile_mode = 1,
> >
> > Missing .reg_bus_bw, LGTM otherwise
>
> Dmitry, I do not have the exact value yet.
>
> Can I come back with a subsequent (different) patch to add it at a later stage
> when I have that information?
>
> I see no point in holding display support any further since it works
> fine with the default bandwith.
>
> If yes, I'll respin this series right away, but without the reg_bus_bw.

Please add a TODO or FIXME comment there.

>
> >
> > > +};
> > > +
> > >  static const struct msm_mdss_data sdm845_data = {
> > >         .ubwc_enc_version = UBWC_2_0,
> > >         .ubwc_dec_version = UBWC_2_0,
> > > @@ -655,6 +664,7 @@ static const struct of_device_id mdss_dt_match[] = {
> > >         { .compatible = "qcom,sm8450-mdss", .data = &sm8350_data },
> > >         { .compatible = "qcom,sm8550-mdss", .data = &sm8550_data },
> > >         { .compatible = "qcom,sm8650-mdss", .data = &sm8550_data},
> > > +       { .compatible = "qcom,x1e80100-mdss", .data = &x1e80100_data},
> > >         {}
> > >  };
> > >  MODULE_DEVICE_TABLE(of, mdss_dt_match);
> > >
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

