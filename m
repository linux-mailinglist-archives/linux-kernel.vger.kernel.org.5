Return-Path: <linux-kernel+bounces-168437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F618BB897
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5C2B2324A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE26A2A;
	Sat,  4 May 2024 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKav6bia"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C277386
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714780966; cv=none; b=q9klmXrbKxER57K221O2W4sjuwBwW/QlDbljptzjVJsQf2XsM2qe3HP8j5MRxm1fuKVituqHI4QIMsodK7B5+kun1/AeoCixz9l31+GqgIdExz4c3ft5Zy8kdIOvc2avHt49XnfAR3GCdHIgW0UpsDkZpzLWh2eG0vS8hr/C3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714780966; c=relaxed/simple;
	bh=4sg/lBQu8VG3Cr09wLGU0B8qR+LX6xNYsDshh5/gdu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/I+wh59vR8OAhwGSJ32ktx3UJfwrX7jPc2wp623c1HlglcKY4YU/OQAYRIMlQTpRf0V1JW80qnTI4Vc2dsXLSJc3QOqBrJGulILURKUuXoNjszEzruRwen/vabJDPS7mTyAmHdV1Ob4kFFRdatuK+mqsYpig88RHpCa9DIyHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKav6bia; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61e0c1ec7e2so22813277b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 17:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714780964; x=1715385764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IWfUOzDKDaHyvvHIKdIupNeybV1v+hpH82Kvs33JOtQ=;
        b=kKav6biaPFSA50efpdYKhsRCAAjrDYxAf3/RCUNDQu049c3V256gM4rOrZMmSe7MAQ
         YIwaZnbX9hqSyJOsiw+POToqUSoCYx67ASoTnh0DK7m1fxKYHcctbKOPGrkW0Nh7T9Z6
         TNdAIUx8YqWF1Uhyu7McrvVXlz/VrE10UvVlvHpOl7/pVMEh+UL5w+FfIVfb3yFVDk43
         oyxbXQo+XsMVmm9AnhcUV3AQZbsCHi76eABVgMnW0/T0nNFi4b3z11YYxA91q9OZmVk0
         wY4A8ssCqZdEFTGdnaGWkRcXoXjOooJw5ysOgab9n1XEjWIs+9iVakKApfOO5tGhIgf+
         lrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714780964; x=1715385764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWfUOzDKDaHyvvHIKdIupNeybV1v+hpH82Kvs33JOtQ=;
        b=IvF28ZtpghqyfzvsuzytI0xZJCf3Y9dFZog0M4VpX3SlAwWtJCYh+kCtH6fdBL7cqc
         2Ki0/Zm391XCWIdS1iNCbabd7rmKupRp4oKTkw4wJhrS+VDyocZkFnpzYh8CJGHo0cPy
         m0XGFzrTuM0aG7BbgxtMzPx9RvV1b13CBgqdhoQ4w6Bi7C3oF49mCGD7pNILsu8qHKWh
         Seu3BJmZEJwEirnfD+KL7xVaG7+4WmuCZfesjsQHl6JIsFEhrBrhtFreLFttDR8YTwYF
         AKA7Uys+iXctwzsno+FwlqddQ42EBR/iOgSAFmk2V76Zaonsc0HWkgXN9wNbv47Q0ygG
         JOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLNZHQ923m8mUFZrf1U2YO5AkbJ29ZFe0JsDm7aUNYqYEz2dr0XzM10p8w+Gjdx5Axh3vHJUC4/z91fugefr729VuRp1lOGVfwJ6Yk
X-Gm-Message-State: AOJu0YzM4Nkbiv8o7WOgQxXYkGUCnrhwUzfREBRpp8fIEg4jepzh9Qd3
	DLkJ471IpXS+q7wBWSFZ8iTiCLWrMI5jBjEFzyn8wu5CZvIiPg9CmNtaDzBpkX+ihXSP7bWOPCn
	0cK71FuUL22oODZFyJVkCyAv5m9YnTxRDRc7BDQ==
X-Google-Smtp-Source: AGHT+IEymS5X5ig3FJMTRZ56tRBGiOhi2tDbas/Tb524ePf/hM4/Xj702HYCnq1FuYFayU9Ud8U1yzDouq4Mi2oXsKk=
X-Received: by 2002:a0d:ea54:0:b0:618:5c6e:9291 with SMTP id
 t81-20020a0dea54000000b006185c6e9291mr3221458ywe.17.1714780963901; Fri, 03
 May 2024 17:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
 <20240503-fd-fix-lxml-v2-2-f80a60ce21a1@linaro.org> <69b593b7-109c-825f-3dbb-5e8cce63ff01@quicinc.com>
 <CAA8EJpp4x+NEpMAGtgOmu-0NY8ycTu0iQX6-1Vv76mkKPea_Cw@mail.gmail.com> <24fb0b07-af03-1341-d98c-46f4f167fbbb@quicinc.com>
In-Reply-To: <24fb0b07-af03-1341-d98c-46f4f167fbbb@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 4 May 2024 03:02:32 +0300
Message-ID: <CAA8EJporB9jjKtT-XS4PcRSYzi+FJh1smsjnBCgy8f5JvDtjAg@mail.gmail.com>
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

On Sat, 4 May 2024 at 01:38, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 5/3/2024 1:20 PM, Dmitry Baryshkov wrote:
> > On Fri, 3 May 2024 at 22:42, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 5/3/2024 11:15 AM, Dmitry Baryshkov wrote:
> >>> In order to validate drm/msm register definition files against schema,
> >>> reuse the nodebugfs build step. The validation entry is guarded by
> >>> the EXPERT Kconfig option and we don't want to enable that option for
> >>> all the builds.
> >>>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >>>    drivers/gpu/drm/ci/build.sh  | 3 +++
> >>>    drivers/gpu/drm/ci/build.yml | 1 +
> >>>    2 files changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> >>> index 106f2d40d222..28a495c0c39c 100644
> >>> --- a/drivers/gpu/drm/ci/build.sh
> >>> +++ b/drivers/gpu/drm/ci/build.sh
> >>> @@ -12,6 +12,9 @@ rm -rf .git/rebase-apply
> >>>    apt-get update
> >>>    apt-get install -y libssl-dev
> >>>
> >>> +# for msm header validation
> >>> +apt-get install -y python3-lxml
> >>> +
> >>>    if [[ "$KERNEL_ARCH" = "arm64" ]]; then
> >>>        GCC_ARCH="aarch64-linux-gnu"
> >>>        DEBIAN_ARCH="arm64"
> >>> diff --git a/drivers/gpu/drm/ci/build.yml b/drivers/gpu/drm/ci/build.yml
> >>> index 17ab38304885..9c198239033d 100644
> >>> --- a/drivers/gpu/drm/ci/build.yml
> >>> +++ b/drivers/gpu/drm/ci/build.yml
> >>> @@ -106,6 +106,7 @@ build-nodebugfs:arm64:
> >>>      extends: .build:arm64
> >>>      variables:
> >>>        DISABLE_KCONFIGS: "DEBUG_FS"
> >>> +    ENABLE_KCONFIGS: "EXPERT DRM_MSM_VALIDATE_XML"
> >>>
> >>
> >> Wouldnt this end up enabling DRM_MSM_VALIDATE_XML for any arm64 device.
> >>
> >> Cant we make this build rule msm specific?
> >
> > No need to. We just need to validate the files at least once during
> > the whole pipeline build.
> >
>
> ah okay, today the arm64 config anyway sets all arm64 vendor drm configs
> to y.
>
> A couple of more questions:
>
> 1) Why is this enabled only for no-debugfs option?
> 2) Will there be any concerns from other vendors to enable CONFIG_EXPERT
> in their CI runs as the arm64 config is shared across all arm64 vendors.

I don't get the second question. This option is only enabled for
no-debugfs, which isn't used for execution.

I didn't want to add an extra build stage, just for the sake of
validating regs against the schema, nor did I want EXPERT to find its
way into the actual running kernels.

-- 
With best wishes
Dmitry

