Return-Path: <linux-kernel+bounces-123124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060C4890275
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9947A1F24465
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB47128383;
	Thu, 28 Mar 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLQ1kzBs"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3B80028
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637940; cv=none; b=ovPrWQo4Cc7g7TMVUaYTcy4J5lVw1iL3nDck5KmnkqZNdnh0+MoT+t3Nq2EAwnKxbKGCxqDoGtXAYOJDPQN+8af8OztDTLFBoV+4jT2fIH8AYDjNNHNxXKEyJ4/Se/JKVHQJ9a453NUbgUdmD1kKAqo+7GEZ572MZj6pmcjMCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637940; c=relaxed/simple;
	bh=S07WbAKWwFFlgqynVgWzUcXXhp61OG6T360LNk25blE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fdok6XWvojLwutba6sCzJJqeFukTeODYI0VazQFa9XWA+WR2Xiuox+pwf6Wrz81YYGexe1x65OwNCauBdIJzcI6t6rl8xPcf4/swHFZ3DEEUbeINUrf7YboVP59IPHIJvLA4ll0gtisMHOMazpAx2ttuWvdbopkESPH0EhXKsGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sLQ1kzBs; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso1047007276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711637938; x=1712242738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lVCKoZbBGmgPMba+uygt1ZNYOjbI400KcrPMv9qgScQ=;
        b=sLQ1kzBsTmHL5IfhfKnUNn0TSOLyPnK8sKWIsbcr3wbpf9N9OOb1ZxoqQ+b13lO35T
         HPR6ErZpFcWiPi3msAZoOtWKCkzaxK3jot9yAEFsgY8YvgFVzrZzSOmAKEQLaGnBa2gK
         XPT9TWZ4vmCaQyvEr3CY5aGhO9e0jnBlss7ChJH/UlZ1IfkMOE+i+0Dp21O2Q+4vTrbB
         byKMtdazigPmGuEGhWfB3AnFHSyEp9xyj1QPf/Bj333AfLfJuW/iSSGcskdE9Rf3rX+f
         2tIcuv6ONoNAJxro5QuY7FCZauOYjErrU109LIj9CoNKaO1OlAJAxxzV7JOAKOENzDlf
         QjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711637938; x=1712242738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVCKoZbBGmgPMba+uygt1ZNYOjbI400KcrPMv9qgScQ=;
        b=IOj8uX4gfhJewYpXrv9QJum2GR9XTFynJmlj6qm0S0mUalYQBV4YM4eiDxGWVTMo3T
         onvLQTh+sQXqfDVTyazz+ZsOk405nJFX31l5QwAgfeTayEvVnRYlGF6wo60i5t5j2X5R
         sNqF47gMXdqLf8CF1t0CUZVfkGzDqIU/aMehcsTtbBE8pBbpnVwIqoNcsPnnGZjtB6K4
         HEFUShh1Mt/Nk6+sD1WO/RtM1+aHAzELRogV6j6RWqJMJyrf505yR0FK/7F8VV15Ng0t
         Erod8/oJ6gF5PMiI8Iz9ZUwioGxjlnK+nXPdpR9q+QfjSeXYPVURvC5xTPtBJfoFG7oL
         YGgw==
X-Forwarded-Encrypted: i=1; AJvYcCWfTJ7DvWi9v8OtkkCjCrxFpYSe9R8xDDilT2ZHKTbSN/SDwnzCJp7Ga4u0FoPT4Fywp7bzVDpDXVXyGKS0Twol520SkN2GRD3RDlSs
X-Gm-Message-State: AOJu0YxDnJer6voCHNY+3tKDebtgwaMwXwOQCso1cZm8rLUE4cZ/4NYx
	hZ+yFAWNkFunCqMTgQR5Yw93cVrgmih5RdZpuoBCMOFLa0gXwvBoFDSleD5syNzbN2JFfAOrZiT
	ZquXtgBKdNdLGJlAczJcWTHRKy1dBH1lhnSPQhQ==
X-Google-Smtp-Source: AGHT+IF+BfSq3vmTR71It1RsEmYi9x9S3nf8WUR4Z19wo3uyG6m3RAGGX4yROeCZyzIC+VlGw62uQlxPCj6DGfxVw0Y=
X-Received: by 2002:a25:ddc6:0:b0:dcb:38d3:3c6a with SMTP id
 u189-20020a25ddc6000000b00dcb38d33c6amr3189252ybg.46.1711637937782; Thu, 28
 Mar 2024 07:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328-msm-dp-cleanup-v2-0-a5aed9798d32@quicinc.com> <20240328-msm-dp-cleanup-v2-1-a5aed9798d32@quicinc.com>
In-Reply-To: <20240328-msm-dp-cleanup-v2-1-a5aed9798d32@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 28 Mar 2024 16:58:47 +0200
Message-ID: <CAA8EJpqr=SE_-9JMNd+QksTkVsPJGk-F2tJcAyH95t4RAW5aoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drm/msm/dp: Drop unused dp_debug struct
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 16:35, Bjorn Andersson <andersson@kernel.org> wrote:
>
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> The members of struct dp_debug are no longer used, so the only purpose
> of this struct is as a type of the return value of dp_debug_get(), to
> signal success/error.
>
> Drop the struct in favor of signalling the result of initialization
> using an int, then merge dp_debug_get() with dp_debug_init() to avoid
> the unnecessar boilerplate code.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_debug.c   | 59 +++++++++++--------------------------
>  drivers/gpu/drm/msm/dp/dp_debug.h   | 38 +++++++-----------------
>  drivers/gpu/drm/msm/dp/dp_display.c | 10 ++-----
>  3 files changed, 31 insertions(+), 76 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

