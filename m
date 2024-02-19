Return-Path: <linux-kernel+bounces-71312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CBF85A364
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D607283AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C98536114;
	Mon, 19 Feb 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMnKzNO1"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7F3418B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345854; cv=none; b=bfFL/y56vXh/H0UfEdtvgDYnmkMWrEKx44ON6aG/b6j5gFWPxCJXIy3jMPmzMO7fe4XmHkKAirT6fikzjqIin6Ia4XIITCdXfCO9oj84Fzv3UTxcij+yUjiUNjnbHQr+NisXbwprmD1W4mLSo8ZQmnFiTH69ULmuArasPxNgfGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345854; c=relaxed/simple;
	bh=CIqMEmdgqI3t82Rv2T7Lko+CSlpgqA71kulwLGRRhy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJt/YrD1VbKeSQu+vRB1SkUmGFDBfY3+zJf1NTDcxjBlR9RiKqUhUoPwVORBoWKvWmh760u8UHibNeIFlcE1YRBMAx1LFSRPGbdfSUUWAv6uLvKnO7tDmmlFVSteLOfZb9fY7nlaiQzo9aMsukJrp4Y6KSRkYMX4owLykU45nI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xMnKzNO1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512bb2ed1f7so600168e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708345851; x=1708950651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpAohRwTwYbAuMyXNWeiGCD6UdiTEgdchbEGaanHYJ8=;
        b=xMnKzNO1Haz7g7XhiQW7ec3cPruY48C+JJCqaspPX0Hh1R+VfmHddfxqmFkywdou+E
         Uvsmae7EY9LU9X7R8MrY3RICNbmqa1KEo9MV3Sh+VVAOYLvEFMtFdU4OWX/DTMNoJS2x
         zuNOYxMnYqdhcr+RK2X32HgKoZNEUAIJxyIJlXOjzmCOwloSlzoJQ90ewJylbyrWo4Tl
         xxAum3W3fdcSwfC/L9gtmGACLUdMVpt/W+MUMrM5GnaogBGNk0WI6XXC1X/atkYMPst5
         UTDl9k6La+hDSbkHY1hibbtKd+mua34OQQt2RNdyCv3e5LO2QDVS+67oFDmc4Cql/k/P
         IJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345851; x=1708950651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpAohRwTwYbAuMyXNWeiGCD6UdiTEgdchbEGaanHYJ8=;
        b=NSyldRH4BpA+JgMqOkb5INnomSTzKNmeFYmyaeYq+GS0zRpk7i2fsri4Y2BBC/A7OU
         KJKdNB6XjcDigg7rwPC5jwOwPpV68mkyiwco9+gb9Nk2k58T9tztr0IFkMCFoMhEad+F
         5u1MZ88+Oh0H5/AQvssWKrEC91tHYncxceYQktSOZjO81Egn2yzfdZABxuZ7EDdeay9s
         iMUp1pk2W+3Z46e5AohePBVK2xENmGX53iIn6KOVfwLr3c2EFek33+315gqBHCvmc3hM
         LmgmJQyJl3kRHIkd+NbivsEGrv8WhbynRBdNll1q3xYbHajvOoEQbJJ4A8JbfpAMaubk
         SDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuaNzRiANIT4p3w6ZRK5WxvSTF1pku1/YEb6GP2xoo0gBPqvJv81RrrahQMwdIYvT4wTyyVh8T7+u7LC21SrblrPj0scRvn1MnKpoD
X-Gm-Message-State: AOJu0YzU/DehanbTolioqMK56iMa9rRsPRW98BhIvEDM7PrbUWSjsg41
	ApKSPUqVN8eP70QvIwrSplTY6PpvLchlH6v6itzopCk4tktGm6SPHX5NYzlsHTLkr75T0gDYLmY
	U
X-Google-Smtp-Source: AGHT+IFlu6VTSkvuiYZTha+WVDfU9F1rby9AFqQIs6ooFgMJwGVOj+HHMKyt94DNvUTyn3MOK1rWAg==
X-Received: by 2002:ac2:489a:0:b0:511:5f38:76e with SMTP id x26-20020ac2489a000000b005115f38076emr7448667lfc.1.1708345850792;
        Mon, 19 Feb 2024 04:30:50 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i6-20020ac25226000000b00512bde4cddfsm90466lfl.148.2024.02.19.04.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:30:50 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH] drm/msm/dpu: Only enable DSC_MODE_MULTIPLEX if dsc_merge is enabled
Date: Mon, 19 Feb 2024 14:30:38 +0200
Message-Id: <170834569503.2610898.6715741555434645771.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240204-dpu-dsc-multiplex-v1-1-080963233c52@somainline.org>
References: <20240204-dpu-dsc-multiplex-v1-1-080963233c52@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 04 Feb 2024 18:45:27 +0100, Marijn Suijten wrote:
> When the topology calls for two interfaces on the current fixed topology
> of 2 DSC blocks, or uses 1 DSC block for a single interface (e.g. SC7280
> with only one DSC block), there should be no merging of DSC output.
> 
> This is already represented by the return value of
> dpu_encoder_use_dsc_merge(), but not yet used to correctly configure
> this flag.
> 
> [...]

Applied, thanks!

[1/1] drm/msm/dpu: Only enable DSC_MODE_MULTIPLEX if dsc_merge is enabled
      https://gitlab.freedesktop.org/lumag/msm/-/commit/06267d22f9ee

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

