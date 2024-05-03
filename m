Return-Path: <linux-kernel+bounces-168173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710728BB4B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26E91C22F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC43158D99;
	Fri,  3 May 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLIYyQ5A"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD2158A1B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767619; cv=none; b=LOYKn2Egt0ecintIL0gMncAuUrdpVYR946Z0LN36sP7zZYhUv9a12PuDYD6SJCj0SF+FyJVPK5ikYPIioEOYKIrafaFZHAbnifhrHLIzaMVuQhgqonFGLM/Y7TllZCoMXu8LnODayF9W5eZZpY0dPNWJVWMz+jUMyuNWrLStTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767619; c=relaxed/simple;
	bh=cT3b01kZzeSTYi58+b1yPoeLYZaiAkjUIG74P8fjFiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bToqYNbtiqfa5J/hMX5A2X7Q879VjLlxh22QqOk3OlSdDbA4S2IWpF+GfdiRw7mpXSocIC5Dit0rE+5qQBVGLk5MycTx1rAmQvKJqjrUsyphTZepznMP516qf3JtBDUFfPHrtpByDT1I2p7vHOi5UlSy0dGQbMxxEPDo/IM1SNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BLIYyQ5A; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de462f3d992so117782276.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714767616; x=1715372416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i/q/SogMvCoOqZoAt+GfE+x38sUg5iDJ97SmB2A6bj8=;
        b=BLIYyQ5A1k6OvsN2cN9hbR+s75gmk5qD7wxFDF3V3vz5q53gO8rUGeHX6fxqOotyvX
         h9mJyzDE2tXA+GVBuOpPuV/Acz/c0RtP+iGrv4ctJeawV4YyLdvTNJJkv6+CzSswB/5T
         wn2TgdgQri8InI07R0XjJGnqtAJkbIYpAcJPUlPTX0ccU5Yx+NSM3ZyBSTdPHqAfx3ji
         kFii4TFKEY+hbskaWU2RXg2zlju5ag0vi5lJ+y0z08VuOl9dZvMglGxaMq5f21KZvg2w
         P5G+7ud3fCF+MGa0IgNCzo6Saf1xRp6EMGSM1iTotG5RplftmMYCm6hJiD8W+SHUQ7DF
         MUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714767616; x=1715372416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/q/SogMvCoOqZoAt+GfE+x38sUg5iDJ97SmB2A6bj8=;
        b=V5m6WUWIdvg6uUFJGcr/LR76/w/JVBjsTWDLRxOt8B/V3Clxs4oN1Qaf+GCXpk9xWw
         nQ8Rsz9LEbuX/DLWU9Mj/BSQ6TYskkzKF4kr2lw4YPwz+JvwwYw3UgWeZ2hbiQDrebsI
         j4K70ROiSx13KUFOfZ2EP75Xx9G51YBWCvQYYCcT2Y3roJRPJTQgHpzT43yTo3CYSNxe
         BPj+LN7Z4fYmyqdcuWYJXT8VvQbTvbymwhT1mvKWN/FMDEdJSBt5VLrxK7Wzv2uAmV51
         +z5B0Am6eOFVQ/cTkqq+wQS+8dzdFZJqiy1Naz6YSv31z3F0LDk8bEn+v8R/wqvINgT2
         JGSg==
X-Forwarded-Encrypted: i=1; AJvYcCVwv7hRAk5w/fGaw02VmM1rpxVVVXtJ1fQrPFYJFSJBOhv1b/NZDwaIwtydM20W1W9pCJURluzoTJUehMCTEx/7QLmIHJcB8+aqea3W
X-Gm-Message-State: AOJu0YxOdCESuLF5aQUe1GA28jDtQngEaojX2L3ZUiGFlG/3AG3DtOWv
	YQeNueP7uXTr3xqrrv9ZKwwCUdpWYx6c8kFzqYUMGhaxR+PSt5nFXc59xN3YauoT0WL/MsUtJkW
	725W0cVZwjyXZW8/mrcINfX2vZ/W0zfbpYdIG7w==
X-Google-Smtp-Source: AGHT+IF12FMQpgSacsvMJfXaH57exZcVdrXcTVSS3Xjq/IP0kmCZmWj8nzgcfH/Kp8QpD6oWbL2jBz3ac6XWQ05VSLQ=
X-Received: by 2002:a5b:acd:0:b0:de6:1c59:bdaa with SMTP id
 a13-20020a5b0acd000000b00de61c59bdaamr4064323ybr.40.1714767616600; Fri, 03
 May 2024 13:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
 <20240503-fd-fix-lxml-v2-2-f80a60ce21a1@linaro.org> <69b593b7-109c-825f-3dbb-5e8cce63ff01@quicinc.com>
In-Reply-To: <69b593b7-109c-825f-3dbb-5e8cce63ff01@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 3 May 2024 23:20:05 +0300
Message-ID: <CAA8EJpp4x+NEpMAGtgOmu-0NY8ycTu0iQX6-1Vv76mkKPea_Cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/ci: validate drm/msm XML register files
 against schema
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Helen Koike <helen.koike@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 22:42, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 5/3/2024 11:15 AM, Dmitry Baryshkov wrote:
> > In order to validate drm/msm register definition files against schema,
> > reuse the nodebugfs build step. The validation entry is guarded by
> > the EXPERT Kconfig option and we don't want to enable that option for
> > all the builds.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/ci/build.sh  | 3 +++
> >   drivers/gpu/drm/ci/build.yml | 1 +
> >   2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> > index 106f2d40d222..28a495c0c39c 100644
> > --- a/drivers/gpu/drm/ci/build.sh
> > +++ b/drivers/gpu/drm/ci/build.sh
> > @@ -12,6 +12,9 @@ rm -rf .git/rebase-apply
> >   apt-get update
> >   apt-get install -y libssl-dev
> >
> > +# for msm header validation
> > +apt-get install -y python3-lxml
> > +
> >   if [[ "$KERNEL_ARCH" = "arm64" ]]; then
> >       GCC_ARCH="aarch64-linux-gnu"
> >       DEBIAN_ARCH="arm64"
> > diff --git a/drivers/gpu/drm/ci/build.yml b/drivers/gpu/drm/ci/build.yml
> > index 17ab38304885..9c198239033d 100644
> > --- a/drivers/gpu/drm/ci/build.yml
> > +++ b/drivers/gpu/drm/ci/build.yml
> > @@ -106,6 +106,7 @@ build-nodebugfs:arm64:
> >     extends: .build:arm64
> >     variables:
> >       DISABLE_KCONFIGS: "DEBUG_FS"
> > +    ENABLE_KCONFIGS: "EXPERT DRM_MSM_VALIDATE_XML"
> >
>
> Wouldnt this end up enabling DRM_MSM_VALIDATE_XML for any arm64 device.
>
> Cant we make this build rule msm specific?

No need to. We just need to validate the files at least once during
the whole pipeline build.

-- 
With best wishes
Dmitry

