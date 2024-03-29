Return-Path: <linux-kernel+bounces-124155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C336891327
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924A3B22EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17032C85A;
	Fri, 29 Mar 2024 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxEAibZs"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2793C8494
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711689802; cv=none; b=nFaBqLH0fWfpXieCVztYu2192jcTggvwKNYa53cnoUOiI70yXmu6Ut71SMAQnER969XBS9/PS2HXVRAJC9p22gq86xvx7/e9lnuYqC6Uynw31+4sefGT9H2Yv0bm7iDnv3zX80jFMVET4QcI9yNmV65BfIzhnIi+pNfP6zf+fFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711689802; c=relaxed/simple;
	bh=mJ5LsSO6W1N7YY1WyTTwcvcNL5EQd+avC7w6e5xz4gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoPSrXELPwfz2wBAeg7HEP3aHUOzYfgxIHmRmwyB2+Nt860zou2ptCUypa3ya1dG9IiBSJsuf9fBE7ZJQFkkQwIp4Qchj21VqjDQ0Cbjn61a3frcsndhcJxI0rIlz3l5xOlF3R0G37aRNJhP8MnVZd2hP5JqYosshk+zJu9LKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxEAibZs; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dd045349d42so1611997276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711689799; x=1712294599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y1cnsQ+TYX5gevtZTdSvBbUB7ZdNL1NVBjO5UpPgLkY=;
        b=zxEAibZspcZYo4HmzwyX5kEia6PonCJcSPjBaC2GeTskCOOX05nqTsqYGVyLklFgqI
         19+wPgbbq4pjThoQjZgZbqZSDSoYnqanY1hCERJrlIRHj/IXRZfsZyjrqv8PfL2Zff0I
         gQ+wDwHOMAczqKdlaaI5tzO7ZLwv+aipK1B3Vy7XKjN3i8zMp1j7zoJBV28E+vFmltv4
         mmijwrBFKyCgcUnOclI8gyvQW47PdLgtzkzEpHQ5E/4N99aCtYtXrV/DhDWOk/AFThHm
         ScGz7tJZUY5Hi72V2UufN8+8bYR5597pTmwCQYUcsJFLM968zBz6sxrQ3VvAYxbH9uZF
         a+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711689799; x=1712294599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1cnsQ+TYX5gevtZTdSvBbUB7ZdNL1NVBjO5UpPgLkY=;
        b=R5cOSfVXmcOdH3O0kFo8klkXFrHRD0myij1+voTkcVykIZR00JwPwoz+Ftp4nxibuZ
         LbpZnNp85BYzrhhcNyw4XZ4FklNNDMde9OU/H8eFuNcFxtziAbhSxU0VXzsSLZVB7nNB
         rGWSEbNatE4qknwXRytzVbNZYBr0i4UcNhHfA9E3obolDnK9/ftM61M79p7lLUeRokbg
         gZCP2D/PXNdWYuQqJjBvn7mxHJhy7NbaEL3cMjf/5v8C/jM40Hx9OHOn4DqnEU/wSWXk
         u8u28r+fjNCXkOZAXmM2/nU2B7UNthBxSGmvaP9gYctwbW21/Wi9MvbS32kWawaN93Dd
         7mRw==
X-Forwarded-Encrypted: i=1; AJvYcCX5YcbNfd/aMg/izol17KgYbLf1RePoHFlcXeXdTCiB9UX+Wh4hDh2jJ4pZMbpxNV4fYZ7kw6ggr50HhJyBgmtIvcMb1suU41G5Ga3R
X-Gm-Message-State: AOJu0YwDKpQYVTGLiNJi5rWVenKvuI8arJEy1AzhFITVX0kA/tuG4JFa
	/iz/mL4lRbLt1AMfCbK0dC+ODY62yU/cTVsIvdQsAMt5jLWUX5ZQMuYI2It6AG18NU8yiHAdnTD
	s3CNO7lFvRlEoHcSwVpYsDi3CVQjW+2yf1kf4Yg==
X-Google-Smtp-Source: AGHT+IHnJYTaJIdFKWO6mQBmk67+u6vknOcIRVk7XoYypNIe5sbgqFqIgY39n1Yb+IQT5e5iuAOhWt+sHM/xZb5wm1g=
X-Received: by 2002:a25:8110:0:b0:dd0:76e:d630 with SMTP id
 o16-20020a258110000000b00dd0076ed630mr1272196ybk.53.1711689798692; Thu, 28
 Mar 2024 22:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328-dp-connector-type-cleanup-v1-1-9bf84c5a6082@quicinc.com>
In-Reply-To: <20240328-dp-connector-type-cleanup-v1-1-9bf84c5a6082@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 29 Mar 2024 07:23:07 +0200
Message-ID: <CAA8EJpoNBA7L3FMqf+4korbbYfrptHq3Fke86DpfNcbpiBaqzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Remove now unused connector_type from desc
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 06:02, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> Now that the connector_type is dynamically determined, the
> connector_type of the struct msm_dp_desc is unused. Clean it up.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> This cleans up after, and hence depends on,
> https://lore.kernel.org/all/20240324-x1e80100-display-refactor-connector-v4-1-e0ebaea66a78@linaro.org/
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 41 ++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 521cba76d2a0..a18fb8b32c16 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -119,55 +119,54 @@ struct dp_display_private {
>  struct msm_dp_desc {
>         phys_addr_t io_start;
>         unsigned int id;
> -       unsigned int connector_type;
>         bool wide_bus_supported;
>  };
>
>  static const struct msm_dp_desc sc7180_dp_descs[] = {
> -       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
>         {}
>  };
>
>  static const struct msm_dp_desc sc7280_dp_descs[] = {
> -       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -       { .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
> +       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +       { .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
>         {}
>  };
>
>  static const struct msm_dp_desc sc8180x_dp_descs[] = {
> -       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> -       { .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> -       { .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP },
> +       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
> +       { .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1 },
> +       { .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2 },
>         {}
>  };
>
>  static const struct msm_dp_desc sc8280xp_dp_descs[] = {
> -       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -       { .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -       { .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -       { .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -       { .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -       { .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -       { .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -       { .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> +       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +       { .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +       { .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
> +       { .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
> +       { .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +       { .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +       { .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
> +       { .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
>         {}
>  };
>
>  static const struct msm_dp_desc sc8280xp_edp_descs[] = {

This can now be merged with sc8280xp_dp_descs

> -       { .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
> -       { .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
> -       { .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
> -       { .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
> +       { .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
> +       { .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
> +       { .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
> +       { .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
>         {}
>  };
>
>  static const struct msm_dp_desc sm8350_dp_descs[] = {

same as sc7180_dp

> -       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
>         {}
>  };
>
>  static const struct msm_dp_desc sm8650_dp_descs[] = {
> -       { .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +       { .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0 },
>         {}
>  };
>


-- 
With best wishes
Dmitry

