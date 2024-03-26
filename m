Return-Path: <linux-kernel+bounces-119596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E088CAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F140FB20E50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FE684D35;
	Tue, 26 Mar 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJBmIaUa"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC42823B8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474166; cv=none; b=pAwB1i1o5UZyPcqimUW7zuJOHtMHNsFp24vCyjXQm8rRyMJhSZdJXX6J3PP6xyoCEPAQvza2vhAWvldOpuxsMqk/W9zJ9ErkPaZKL3JeVQkQaCqSWGRct5OTiKO38gttReiJhMqNsy3dJTGuRyoA24pSvUz1H01EuPVISFBgCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474166; c=relaxed/simple;
	bh=dHAy3DwfdrKuyZt4hmgGEpXz9cl+D2CijNaa+rzyADA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOqdRLKvJqFdq2wIwK7enDBUvZx576G98kekI8ln962Hcjx1cEmOfDE2FWL5osxBgr3BPtc+68TgOvM4In780N+4TuIPc3zrmEWSgsp3jiHU/f/fp5iuDJLgxDICyz2oDOwnLeGxodR7yQoDU9LZhjxM7DBCtLnu6qymL03yZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJBmIaUa; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db3a09e96daso5404035276.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711474163; x=1712078963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=11p0UMmKH1MnLtrO/gYwy55UQmZhc7eSQzB1zZ0+1Y8=;
        b=aJBmIaUaE9mwcj3Sa0fx2b46aKJ25XoZcBEaiP1KmTmXq82plw9MFuklP8QdVQXibJ
         DNTpFgZvlAm6eMHN8CFrju2K0bu/6NFbbDynzUVIrVPrmgRHRhl/sdDn8kYqVzTZA0pd
         WgXDOePQlQPM1ArD+klUau+OUjJdujKPPXR6pR7l9x3MMC5HhnyZffgMh/Z7fSK9x9aY
         TgtkKfLgwSwsceKIKikpeqL+4wu5E4yQ2ZS0nb9mM4YWeV82FxnUJQVR0xdByMdYtVwA
         YT4ehlogpda2QemYWgbthJ6qHnbqut0bv7/oIMxWsABa+H6c0fA2M4LmD15zuq3a0cW+
         CBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474163; x=1712078963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11p0UMmKH1MnLtrO/gYwy55UQmZhc7eSQzB1zZ0+1Y8=;
        b=SEgZknKMKHKeTCd2jXvmao6ldKdszJ7trfodQaR7LlzhmdG33pFbh0jZy/UnN1uvoo
         7pRskzyqIxMgiKX7lGyuCHGNY9uU0vmjVI03wcVk+xhtsMMHc3IZtDSqZj5t33EimTEJ
         eTHiIJjummy+KvuNVv/W157nmrD/sOPLxbTAFgd2IkLMHz8vAKLccMkwxvFKc7edOQ7o
         p2b+vw7W+xbZrRni5HEhB7PJxRZuktJ/JEdsn+Xy0z8XhKtdfxc9xVqDvdForb+zmvDa
         5ZuB2UjkrBdkSIWukF8FQxu5tNQ5p92OCXCBkXwgUdxdAQDadGT72UyH+Ys/Dvx5e8ca
         cI2A==
X-Forwarded-Encrypted: i=1; AJvYcCVFUxBVPrZ+hagj3z/kVSGinIFO88nQw72X2Icte+LZkarf9+XfdI1/oLqiAQGX1yo+LEwBgtVOOeWGmTbO4iNSgYFFHSzvEU1NUjGi
X-Gm-Message-State: AOJu0Yy05HQj+CIhPro2ziSoRxE4irWZhV5MSU5u2cpgcb/1DYPAR0YT
	boh41c2jyhaPRHPFQ8lHMeXFyQYmKir676bYWV+zDf8QlqHzYnLnRrYnk9Uki5VCOZr+pbIJ7Yc
	LcOqXfKNBT1Zwq9qjAqxK4QHNR0ZcpgiQX1RPQQ==
X-Google-Smtp-Source: AGHT+IEOabZ1Kz0WgVjOqqWDaky7HSvouC3ZuU/CFz3IlxB6Zt/5TpK+icVIpdKPsEQ3pgI240eYE6V09+ITV2S47Yg=
X-Received: by 2002:a5b:98f:0:b0:dc7:42b8:2561 with SMTP id
 c15-20020a5b098f000000b00dc742b82561mr9218122ybq.34.1711474163590; Tue, 26
 Mar 2024 10:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-msm-dp-cleanup-v1-0-e775556ecec0@quicinc.com> <20240326-msm-dp-cleanup-v1-2-e775556ecec0@quicinc.com>
In-Reply-To: <20240326-msm-dp-cleanup-v1-2-e775556ecec0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Mar 2024 19:29:12 +0200
Message-ID: <CAA8EJpqeV-GCizJ5t-BvLDt_O0k6qQ+omma+8KkwFtX3PP_uxw@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/msm/dp: Removed fixed nvid "support"
To: Bjorn Andersson <andersson@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 17:06, Bjorn Andersson <andersson@kernel.org> wrote:
>
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> The "desc" member of struct dp_panel is zero-initialized during
> allocation and never assigned, resulting in dp_ctrl_use_fixed_nvid()
> never returning true. This returned boolean value is passed around but
> never acted upon.
>
> Perform constant propagation and remove the traces of "fixed nvid".
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c |  2 +-
>  drivers/gpu/drm/msm/dp/dp_catalog.h |  2 +-
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 17 +----------------
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  1 -
>  4 files changed, 3 insertions(+), 19 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Kuogee could you possibly comment, why was this necessary at all?

-- 
With best wishes
Dmitry

