Return-Path: <linux-kernel+bounces-29307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D37830C80
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAB31F23EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA5E22F06;
	Wed, 17 Jan 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRO51As9"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0A22EE0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515161; cv=none; b=IVM1whR5e3ClSZNNEQi/35cy7d3KwTNKoT9xIoQufiawyG+30JKYMhsF4QhmddzTYj0DQP2hdbJ1dwz+zAUxZIK02gOrAAYylPgtXkd1laO0TEqptRezpC2T71hcHroFccT/FdUrdWt7d2ucCSz/kNesd7YlNcB8Jr+Vl2iAMtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515161; c=relaxed/simple;
	bh=Fd/c6fJ7aFOX++ciY1b9gKkkQk9F17oGqhjYtNROr5w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=q/GdMOAYywgeUnWG2i8tc9S77YHU7t03RegYI/2DYGTKfj6AefcRxJb7U2QyhCEdiCKCS7RS046v8coDYdYqpzTcqTkugrGZR0ATXv+eDi7rd8tKPdDwAMLtIh4X1KfufktJ/J60Eb7gDk34ii71j/B77+9Qc4PTAhwlsft5OD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RRO51As9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso116049517b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705515159; x=1706119959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ9iGp7KbU9YOI2Xiw/kWOiOOP5HwW765+PQKI9u1WY=;
        b=RRO51As9CG2KtU7mqEflX4x5EJNc2BpBeBtJOtAFOKhKnhMoeseSYbfgSrkepSaaYb
         qevvSYbCetAs/dWz4uK5mKznxFOwhTw0KU3R0PbnidKPfD+44/U7ooLBREibR8pXPELI
         k6i4Y/+rWTgT8M3b6Bsb7jqEhr2HP12joYgx5o3tAVv3H6zuXnE36SRe32t4ckXFEa5x
         yYa14sNhQE8ldWCjG+HVHR7wqIoTz6NLUXo0VhvsFbS1cddhirmhbybTXboPVsqZXsP6
         UGY26Jje+4zDTSI6t/CsbgoPvAw7s6OEMyd9mYj/vXO0Bg/WgboHnQ/mmewAjt/5cqhb
         sLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705515159; x=1706119959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZ9iGp7KbU9YOI2Xiw/kWOiOOP5HwW765+PQKI9u1WY=;
        b=o6RmYDAKiu+SuSBeWzDuwCWKmiMq+7o4/ikyYjcpyoaveUDVu4gQ4bukDrTDW3ag/S
         Uwj7r4PxEXJOjkOCX8JQLAKeBuTRPH0Hy9bj1XNtU91itKjjuQTP1KvWoAUGtg6noDZK
         oL7r0PxO9LA08BZVU+ZMrJuq856RtnfdRMdrKpOZ88ymtffhRfoIZgZVkUZ7MHxUEsg7
         gNhZg5xwHviQQOAg6NSnDi48PO05wfhLCJWycor9CTv34a8L5ndEY1FBCklGEq/2W66v
         Z88V98CNZ6CYjasVlwv0pQCSOKNOpDF1JnRtxupIevNRtN1ltNvUGiKrcacKAVD8UYb3
         E1Rg==
X-Gm-Message-State: AOJu0Yx6OUQxCCdes6YDuJgt4qv9HVV9hcs7U08l87t7qH+rOorrM9h3
	1kSYzIr00Iq8SlHZgDQ2Oux++qqR5hU0Jag9RjCQ314u10ETlA==
X-Google-Smtp-Source: AGHT+IFkh7uNNJqFCQZmQOQJTDWfRSauz7es7f6BhnoY9dO+BCxZs4hu5/U9+DmfwNxH1z70lQy1YBaP6HpodK4efr4=
X-Received: by 2002:a81:99c3:0:b0:5ea:1eb8:c37 with SMTP id
 q186-20020a8199c3000000b005ea1eb80c37mr6327524ywg.24.1705515159162; Wed, 17
 Jan 2024 10:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705514068-22394-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1705514068-22394-1-git-send-email-quic_khsieh@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jan 2024 20:12:28 +0200
Message-ID: <CAA8EJpqO+SWYcCtH1hOVow18ZTbJ=qh0D68CEP1sGObdd3=ciA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: correct configure Colorimetry Indicator
 Field at MISC0
To: Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run, 
	swboyd@chromium.org, dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch, 
	airlied@gmail.com, agross@kernel.org, andersson@kernel.org, 
	quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com, 
	quic_sbillaka@quicinc.com, marijn.suijten@somainline.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 19:54, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> MSA MISC0 bit 1 to 7 contains Colorimetry Indicator Field. At
> current implementation, at DP_TEST_DYNAMIC_RANGE_CEA case the

In the current implementation, in the ... case

> Colorimetry Indicator Field is mistakenly left shifted one extra
> bit.

This doesn't make sense. You say that the value is mistakenly shifted,
but the shift is still in place in dp_catalog_ctrl_config_misc().

> This patch return correct value of colorimetry at
> dp_link_get_colorimetry_config() to fix this problem.

See Documentation/process/submitting-patches.rst#_describe_changes

>
> Changes in V2:
> -- drop retrieving colorimetry from colorspace
> -- drop dr = link->dp_link.test_video.test_dyn_range assignment
>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_link.c | 11 ++++++-----
>  drivers/gpu/drm/msm/dp/dp_link.h |  3 +++
>  2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
> index 98427d4..2e1bdaf 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.c
> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> @@ -1082,7 +1082,7 @@ int dp_link_process_request(struct dp_link *dp_link)
>
>  int dp_link_get_colorimetry_config(struct dp_link *dp_link)
>  {
> -       u32 cc;
> +       u32 cc = DP_MISC0_LEGACY_RGB;
>         struct dp_link_private *link;
>
>         if (!dp_link) {
> @@ -1096,10 +1096,11 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
>          * Unless a video pattern CTS test is ongoing, use RGB_VESA
>          * Only RGB_VESA and RGB_CEA supported for now
>          */
> -       if (dp_link_is_video_pattern_requested(link))
> -               cc = link->dp_link.test_video.test_dyn_range;
> -       else
> -               cc = DP_TEST_DYNAMIC_RANGE_VESA;
> +       if (dp_link_is_video_pattern_requested(link)) {
> +               if (link->dp_link.test_video.test_dyn_range &
> +                                       DP_TEST_DYNAMIC_RANGE_CEA)
> +                       cc = DP_MISC0_CEA_RGB;
> +       }
>
>         return cc;
>  }
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
> index 9dd4dd9..fe8f716 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.h
> +++ b/drivers/gpu/drm/msm/dp/dp_link.h
> @@ -12,6 +12,9 @@
>  #define DP_TEST_BIT_DEPTH_UNKNOWN 0xFFFFFFFF
>  #define DP_LINK_CAP_ENHANCED_FRAMING (1 << 0)
>
> +#define DP_MISC0_LEGACY_RGB            0
> +#define DP_MISC0_CEA_RGB               0x04

These should go to dp_reg.h and should start with DP_MISC0_COLORIMETRY_CFG

> +
>  struct dp_link_info {
>         unsigned char revision;
>         unsigned int rate;
> --
> 2.7.4
>


-- 
With best wishes
Dmitry

