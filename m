Return-Path: <linux-kernel+bounces-148442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1558A829F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D531C20B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D113CFB7;
	Wed, 17 Apr 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBRwF4Rt"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73E13C8FB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355118; cv=none; b=FnmhCbcruftTFmx8gL0mTej6epay2udHEFQPP7QBb5LU+u+jysIFT9fENMfurl2VHiI5HAsB40C92CWxqNb+2Ip0DJi80sdG4Wg8goFa6N6NSzfRlX/3wEhv1ncDPm8wIaBTKJHcQxuJPUmrGFeZEzgqKZPutRP1kkdhm8xvjXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355118; c=relaxed/simple;
	bh=n3E7Lzw4xFNf9xuprek+3okMw/w892dRTyoP/dcO1Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W61rfZ0OCJBjVUFONmBQ2WWH6LTq1cnZCfcEnxKu/dAd4i6JrMubO1FB4iumruq552bnba+1OaqIZQRGt5GbeTypNgkx8y74Fk+uN6iCvcbAZB6g9WkB883/PnVDGg/FDO6l32HCBqKt0mKTTkifXwNRxqGNyGQ9Qk6UvKbYVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBRwF4Rt; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so4778156276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713355116; x=1713959916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ox5LPkHgtGr2/XHUCfFXXYvppG+HqbU+7l8WZ9khYtU=;
        b=MBRwF4Rt43DhVpdTLDXWW6zo7lKA/MV4W28NTk+6IDUp0wuMSeKZdHfYHf99RF3Mzz
         xUwvHCH7SEf2npZy03ANQ852kEFy/qG21M/3O1tAbWYtX6Yc39jerL9WSEA5G6kBp1Wh
         CEoIe3JV/dy8csAuCUbx84vkseglGQqNF86CorHcHl8z92SFVvshHt7A0nH6to5N7nPC
         +7JZ+7vxlGnFXSme2ZP4/eBYWmMh9BMFADaODPbSaYZIGNT42NgbDkGRgENP9Xwm6iK3
         UHmuKMjDGn+N4V+4HumpvKuym/fLLf5fk7ODQnSABIeZr08PB2z7gqGKjbdNIRj0Wb3u
         1Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713355116; x=1713959916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ox5LPkHgtGr2/XHUCfFXXYvppG+HqbU+7l8WZ9khYtU=;
        b=KF8NxQzeB06/OaYS3cnRc1GpZuun58NTX0USX2k2B/PW8T4jmiDHiohJbH8s2Tz7qa
         NJ2bDfG0CatQTwXb2zIGQQ1wJ2GOI5yCkGNjbsWniqqN9OHzi5TA2jvy6Rofu9RTxQ0j
         /pOGj0AFVHNgxyaLmwZpzjZQnPm+qs1oDNhC+f3lY8iQtQw4x7IG5eAIFpxMC1S5LdJd
         oIIBr3CLmbWlC4f8V/Lmbvv/vZv+BLsfzctHQUAHK+OZtCYeSDiZG8W7UkHChOgm5Tbv
         mOcNmRKZ+M9+nG+tv+o0YPNcwI4PJpmYUwBwEL6ckUEqYkqs3xUeylA1QV7ysJmi5Wfo
         9iBA==
X-Forwarded-Encrypted: i=1; AJvYcCV/5RZOJl5+tzdjJbRYUzxsiQBShozNgm213UGZjGreWrhqQBDC1Tq+tW0FwdQ3p+1f0W7gkhxkc/j3zSvuwdz2jS9uLBvCV1sP47uu
X-Gm-Message-State: AOJu0YxrQgWC0gwbrBlcEzjiWN6YxPGZcOsNqRdM1Hl8arf8Lu0vHDEv
	71FD8zNVzFxvRbitFcqVDnNbqlhXFd+iO4cltNoDx4t9PgdPV0p4aseBM1I9pkfKuYTbK8mhNt5
	VSrmvHHZqU4F8TPv1/VipjKD+/24m+1De/DVH3Q==
X-Google-Smtp-Source: AGHT+IHroa6k1HZ0B1EjkdHyvkWVW2/keRVisrkhSaTkSXI+Xy1B+n4dLICjNC9Mn6XDdWwQWSgpT8LgLcWwaM+pobs=
X-Received: by 2002:a25:3d05:0:b0:dc6:d093:8622 with SMTP id
 k5-20020a253d05000000b00dc6d0938622mr15444148yba.15.1713355116056; Wed, 17
 Apr 2024 04:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
 <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-2-78ae3ee9a697@somainline.org>
In-Reply-To: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-2-78ae3ee9a697@somainline.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 14:58:25 +0300
Message-ID: <CAA8EJpq-1QwoM2hEyegpfKnVH+qrswjmTd_hpYs9d9B7gikHjg@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/msm/dsi: Pass bonded-DSI hdisplay/2 to DSC timing configuration
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
> When configuring the timing of DSI hosts (interfaces) in
> dsi_timing_setup() all values written to registers are taking bonded
> DSI into account by dividing the original mode width by 2 (half the
> data is sent over each of the two DSI hosts), but the full width
> instead of the interface width is passed as hdisplay parameter to
> dsi_update_dsc_timing().
>
> Currently only msm_dsc_get_slices_per_intf() is called within
> dsi_update_dsc_timing() with the `hdisplay` argument which clearly
> documents that it wants the width of a single interface (which, again,
> in bonded DSI mode is half the total width of the mode).  Thus pass the
> bonded-mode-adjusted hdisplay parameter into dsi_update_dsc_timing()
> otherwise all values written to registers by this function (i.e. the
> number of slices per interface or packet, and derived from this the EOL
> byte number) are twice too large.
>
> Inversely the panel driver is expected to only set the slice width and
> number of slices for half the panel, i.e. what will be sent by each
> host individually, rather than fixing that up like hdisplay here.
>
> Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

