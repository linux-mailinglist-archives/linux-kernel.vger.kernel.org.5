Return-Path: <linux-kernel+bounces-148444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B33D8A82A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4489F286FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E613C3D3;
	Wed, 17 Apr 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EM7HsFgi"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447013A24A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355187; cv=none; b=GQIPSSIcFVQQLZ0VzLsLWtVWGw7C8jRBeFjaKUAZyVsHlI61Nft3XPboeuFaqAMknircmRaLLlVpRn07sZ6Z/4chCENIhrX3lo+HR46WEjdmQ4EJ1V/hafCj+zU4ufiES1Bjxet0+bno9f7XlaWYfWbGSPoqOUTfAIUoCuqzyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355187; c=relaxed/simple;
	bh=ynVd21xe4kHy0pnYMDjSr0GDMyeh1LPBT7NXsK9/MLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI8O4OnqonXKNa2RaTPosMsMknpCAkXX2llwi0Mb/qIuwRAPcQDOeQXw7ZQ2AAnadeDsxMmnhNn8KueCw8RsjERUEqfRhJB4x2z6bqOhvfO687BeuqHpEO0+G2ihczpBZln181j9O4SEgK1ydks17CePD0AAw/yJz1DFpR5LACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EM7HsFgi; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ddaebc9d6c9so5013019276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713355185; x=1713959985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka4Traa7ftszXUlTUn8V8lFxKGAbUY9Jgg8OQaEdzk0=;
        b=EM7HsFgi5DOtYHFGRkKlbmCf4iNqTJUD9Bxlf72lRnoF9lOKTe75/agaAGIW6CIUfO
         TXSnAWWM3P+CEn4l1Us02pImlczoQ6VkNrl5CXa8hZdXqNuBdidDenSvpvyLKIG0kdCb
         asBe/GQAFV2zKuA4LuZv3EzNE0vlUwEn/ZUYXAFwLfgLMS1DDU1O/4uZtalPNiOmfToi
         qW8e3hN9tefgZgZ3v9eFQ/Q/g4VXyyhb2yafj+ol7GCVc/RUtHiABvII/u+28c4vWMk0
         4ZuVuIU4bEUuNXQ/X+fH4YKmyYu4re9mQ6486g2/2Bm6Aj/Spq9lOnB7lgKmC5wKA6lW
         f8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713355185; x=1713959985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ka4Traa7ftszXUlTUn8V8lFxKGAbUY9Jgg8OQaEdzk0=;
        b=aZDLZI7zjMW6Bf1jlyWIhUMlx3lfDiIhMqSyKVz17WsOL/xVSmrsp2NhHFd+jhhvTs
         PzC0n1HyQpJZpdg0loGC1g0rz/C/pwnedCmu9Bw1GZh0+18xZZmcdronkt8WVmw+gULJ
         hSMsSCRljAsuIxAf+8q+T8Q8X/VboRW5oFKm3wHsMqxIEDRRU9OHMCajVCC0Z9OP9fFU
         dUevKMhSQXmlrSPs+LZJb4R7hXsiAh4KCBmPHcwoFAeYiZKCW85eaNU1+OYvwrAfkv42
         gOYXzz7MI2L5lfv3tOByHkMm2DVvur/5oCMfK7WbrwivqFfhBXaDpGwUyoiuBPjTfkIp
         iTWw==
X-Forwarded-Encrypted: i=1; AJvYcCUXOS/rGOygec2cpjPZj9JZ1+ntMj41eR+la8LBxmb8eAPwvrSVA3qOXs9Z+sxBEYxYie7iXMuaAiuK3FniYvsi8seJO7cJNYdRaE2f
X-Gm-Message-State: AOJu0YxKmicTgEzXuYir6O8S+HSZ8BDB/J2yfmghh+JgcBzbst5rghU3
	XqdTY0vpVuDFWMBc40IS1cO1FLvGMYTFzo2gqiHigXU6T70Xelp1gRSk7sXYBn6TcgAm8BUcNog
	d3JEOeJ/mIlzZMGGpSsGNjFXpKdLTlP1lhp69pg==
X-Google-Smtp-Source: AGHT+IFIYioWeJvin6gmStJ8KBQcUCJDKaGylQGDoJsTxsTjK1zWYmQIPOgobokhDNprh6Xmzq0t0x4PNZ8rgZDheDE=
X-Received: by 2002:a25:aca0:0:b0:dd1:2f58:292b with SMTP id
 x32-20020a25aca0000000b00dd12f58292bmr16998050ybi.9.1713355185554; Wed, 17
 Apr 2024 04:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
 <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-4-78ae3ee9a697@somainline.org>
In-Reply-To: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-4-78ae3ee9a697@somainline.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 14:59:34 +0300
Message-ID: <CAA8EJprJ2zY=MoHt6YnFV7qU3H=who+YPAzXG+bUZHHmFLzyxg@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/msm/dpu: Allow configuring multiple active DSC blocks
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Archit Taneja <architt@codeaurora.org>, Chandan Uddaraju <chandanu@codeaurora.org>, 
	Vinod Koul <vkoul@kernel.org>, Sravanthi Kollukuduru <skolluku@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jordan Crouse <jordan@cosmicpenguin.net>, Rajesh Yadav <ryadav@codeaurora.org>, 
	Jeykumar Sankaran <jsanka@codeaurora.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Martin Botka <martin.botka@somainline.org>, 
	Jami Kettunen <jami.kettunen@somainline.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 02:57, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Just like the active interface and writeback block in ctl_intf_cfg_v1(),
> and later the rest of the blocks in followup active-CTL fixes or
> reworks, multiple calls to this function should enable additional DSC
> blocks instead of overwriting the blocks that are enabled.
>
> This pattern is observed in an active-CTL scenario since DPU 5.0.0 where
> for example bonded-DSI uses a single CTL to drive multiple INTFs, and
> each encoder calls this function individually with the INTF (hence the
> pre-existing update instead of overwrite of this bitmask) and DSC blocks
> it wishes to be enabled, and expects them to be OR'd into the bitmask.
>
> The reverse already exists in reset_intf_cfg_v1() where only specified
> DSC blocks are removed out of the CTL_DSC_ACTIVE bitmask (same for all
> other blocks and ACTIVE bitmasks), leaving the rest enabled.
>
> Fixes: 77f6da90487c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

