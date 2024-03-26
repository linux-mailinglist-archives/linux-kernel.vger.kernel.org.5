Return-Path: <linux-kernel+bounces-119605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F195788CAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75DB3B2805A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8791CFBE;
	Tue, 26 Mar 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJd69fCR"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E81F94D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474417; cv=none; b=SGOMq9YLkGvf1URBjmmjfUReKjORWr8eeF4GR9WARVxw7bUHDMoVMg9w8044iXKm6pwjFrBOIqaPoX+HAx4nyv2K6QMUanexgUMqB3Ttk/gg0WvBRgQ/eE20AHoVxJl6LB6ttKStUrrMipyycFvJWnSlo4W7LorvlqMN3Y2q3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474417; c=relaxed/simple;
	bh=toPGKCLdvyO+G6kSM1fO3+IGKMtdUEo5PJHkjmfdbho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXnDXqYen1Uriezt/nFU1cxuog83+tZ/4zN4d26CdSEqCKjfoMtYsnvTagf68cGAMNQzrNPEZSL6gmgaZg7GJuLHyAoIy5FCJ+ww6JeqYJeJAIm3QXVEeMTwJ7xhcatitjqXddXZR14fPjskY1tdj5UFJjd6CcDVx1KdTC/4WvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJd69fCR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6098a20ab22so53098797b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711474415; x=1712079215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XbZMB0HLDo6UlcT3wdFgHAD3bu+yuJSpDvNYyyVm5Bo=;
        b=pJd69fCRlgx566PAz5+ArreEhN9HOwXbqVZyxqp0t0GzzW0Xm+RJjQLlDhJ0YWhFpf
         MNFu5JHjVugIHqGdqGMLUFB/ckMnrmzEpzSwbbAJTRa9AAjX3vBN/KNGfAfDF/EOIsou
         kkfQHlyHFwVfrnKD2gGniASHKAsEgBAXKwxr6gzhn+1YN0qVYnKR8di83+xr6BHSU8/F
         iXMkjTi/Bmfv+8fpkpx9pF1qDglP3J8QgbZgNZOTP3UXQ0B+cq/Jt3ezRvlTA1rYiuGB
         v8fR/mTXIlGxSaw/LVtEt+8f9gfeAcEloi53k6k5KLUUxtmcDsspSgXCnfAoC1shLAbh
         cZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474415; x=1712079215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbZMB0HLDo6UlcT3wdFgHAD3bu+yuJSpDvNYyyVm5Bo=;
        b=RFqGWBxd9ipwUbx425pMwkLZcsOZMfrs/X5vsS7RLgHhvaUZut2hgn2+bDwWHhilv0
         Ljdwef8a16bubAMxXIR1qIQvm35bpW6eNsNKwn3ozQX2y3aQd8ovmoTNnTMCio4SFhGO
         YD/WJ3F6mAji5YiFef+sofvctjCU1VhVMJAmIli97dLTH8/WobSmYrwURrM3Gee12caw
         /uGv5Ikzo5ePYs+p9i0QGMDQ/+yrdMdrlgckLAPCq8vjliIWbMlOTHqQUqGdY0ufXZQ8
         g1y3z83AXe6ESWOTrg4/HZKDkYGJ35HfIZ381tEt2nlKkNEzZBTaf7sQm7ubPX7f6l7/
         b4hw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Nd8tpyO+Gpdb78lb69bD9wgGAi0xQBeNBoi1jrNJVILru0aLZR2mYmPb4BX4fhdEPWnul8CMD3jJ3A6ES7XQfjvxOGDZFdB8tBEE
X-Gm-Message-State: AOJu0Yw5frqP3q6DZ6tSF42AtiiiCCIEpucquBELvCa272zf51Erq2Ii
	jtVEqwaCfxPFLDl4Mlzbv4QaR1irKSua1YtXBnWANfqtIgZwoCGOaY8u4KkD7IrTuUVq5rrSj6i
	8AkpDo5GV7jUWmmsfiPmYp9ilZalHfMVPtk5zNA==
X-Google-Smtp-Source: AGHT+IEMWwGPSGxVa+7DBZhN3tDl31SG+GYGcvvUKD2ClPTIyhd+KW7hJPpl34yQMv0yUTu8mGIcSU6SoV3jibi+RjM=
X-Received: by 2002:a81:5f55:0:b0:60a:5031:2de9 with SMTP id
 t82-20020a815f55000000b0060a50312de9mr1681149ywb.51.1711474414901; Tue, 26
 Mar 2024 10:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-msm-dp-cleanup-v1-0-e775556ecec0@quicinc.com> <20240326-msm-dp-cleanup-v1-5-e775556ecec0@quicinc.com>
In-Reply-To: <20240326-msm-dp-cleanup-v1-5-e775556ecec0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Mar 2024 19:33:24 +0200
Message-ID: <CAA8EJpqxxuu+EK3W55EbhiZyGqnB6DGdH7jU5fP--bZpUHSx9A@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/msm/dp: Use function arguments for timing configuration
To: Bjorn Andersson <andersson@kernel.org>
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
> dp_catalog_panel_timing_cfg() takes 4 arguments, which are passed from
> the calling function through members of struct dp_catalog.
>
> No state is maintained other than across this call, so switch to
> function arguments to clean up the code.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 14 ++++++--------
>  drivers/gpu/drm/msm/dp/dp_catalog.h |  7 ++-----
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 14 +++++++++-----
>  3 files changed, 17 insertions(+), 18 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

