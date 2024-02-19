Return-Path: <linux-kernel+bounces-71314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34E285A369
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6172837AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86010364BF;
	Mon, 19 Feb 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yO180yNd"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD9F2E642
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345855; cv=none; b=B825Udp/bd4RJZu66N/T8yYe1Wti9M9XxgtoQHQy/Q2+6rbEmhCgfslkxxgFhdN7taCvjJoz0A/qxoJkxPrVT3MoNjmHQhzH1a/8syluljqn2RBHr4IHpPwrvqQXiaKNH7FC5HgD6Tlmnyp1zWYHXcV5zJGlLdwaORtqw18RJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345855; c=relaxed/simple;
	bh=EKLaxwBrB50GWRQ1WzeDT80GjWtojq6PlSBGlmCj6QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+9i5fd8hsdg1eNVhHs/PrjTNnVnNxlet2Th0rZ8311AnUcMrloxZGzEsylgp8as6BCmfJLYLG5je4pNLDXufU741zrde9hQK4j3jJY2h9UA4W+due2rB8F5FVhQSFuEzrRBlw3/yh0v2wyCAhxV2uZ8Vd01H4dMGk1w0k0Ptvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yO180yNd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511ac32fe38so6385907e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708345852; x=1708950652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hlwtv8HHmQzS575dzwLezHfUxs6dYPZU5AK2+ElAWo=;
        b=yO180yNd8gKpXtgxd63ucXZ88wv8e3ShiJ/uLAjAaaXuIOM00/T/M6LyeVcIyD49eB
         4MGMdJRG6Pm/MClaxH6ONQ8kvGc8+wkvrTTKQJVgbOKVSffbXAZmxQ14hzJSBIAAvNDg
         SFbp8U8PeJdnWgEDB1CQeyj9pf22X5RTi1Evqcc6iE5Yw2dZMHZpRMaGqqziLe+opSAp
         JtoOohbMxq4RNcydSL/1MDqcwG7Y5VQncLaeh0OEIf/Ct11cBDCP6cvzrYtFB1yqHRg2
         24cVEOqt/Ar/wn72IYEoDFKQykQCeI/x4TLp5cVgyi2gECZufnH5kDg+xP628e4+q9fp
         S5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345852; x=1708950652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hlwtv8HHmQzS575dzwLezHfUxs6dYPZU5AK2+ElAWo=;
        b=h2Nc5X4PJp2W2tpzKu6TbT4LNYPxE22Ynlovw7FTl3m5/85aOk17A/8kFzkYS/P2wt
         xFhcv20Dcs00KBDJ+FouRQSHS/qOXBiLLuaKbH57VvS5y+EDZ4GGaJ60sqtEHPkT7/ok
         X+MDChI/56IhDK0gMNwzsZFglOWqvY2fKiel6X+zXdGV1gG66H2NWA5U+Lscpqb+MA3r
         tzTQJsu3Nnugpm4r42ZM3TOHXK0tPXtcqsHpy+lGW6Y1NnBjNZWMYwtVCGodSxbtZnzy
         Ndbr7ZlT4ZdJrq6TLdQkHkeUSFgw2WOCYS2XWVoYqBhmrKEf+4pBYCiefod2wRRB836R
         ZlUg==
X-Forwarded-Encrypted: i=1; AJvYcCU/E+GyiqRO5xA6+rKOXIwDOGBOT4uiUx3tNFN1hWgxhjOiOfWEc4RRQFK8Gv8bsu27ezLTwpo31cMyMtLF0/Jg9xSedCdNM1zkxSD6
X-Gm-Message-State: AOJu0YyTigERlm1EAJKhHhY1+8kdGslPDLbbzPpftlyPEINdjDgCspV8
	pTljQqH4AT6QRb48yeGGNfbipPfnT+Jpp9BhF3bP5Z2nCIX6cfZF/5UBLED6RB8=
X-Google-Smtp-Source: AGHT+IE0jfz4yHK3if/jDmCGu5CgI0XKOOQubHh6KWwBe8w3ElmHhuCgl7ia1FSM7je4L7aFLoWbQg==
X-Received: by 2002:ac2:5f70:0:b0:512:aa1f:669 with SMTP id c16-20020ac25f70000000b00512aa1f0669mr3244373lfc.16.1708345852317;
        Mon, 19 Feb 2024 04:30:52 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i6-20020ac25226000000b00512bde4cddfsm90466lfl.148.2024.02.19.04.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:30:51 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Stephen Boyd <swboyd@chromium.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: dri-devel@lists.freedesktop.org,
	seanpaul@chromium.org,
	quic_jesszhan@quicinc.com,
	quic_parellan@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: fix the programming of INTF_CFG2_DATA_HCTL_EN
Date: Mon, 19 Feb 2024 14:30:40 +0200
Message-Id: <170834569504.2610898.9861209755234701937.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201004737.2478-1-quic_abhinavk@quicinc.com>
References: <20240201004737.2478-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 31 Jan 2024 16:47:36 -0800, Abhinav Kumar wrote:
> Currently INTF_CFG2_DATA_HCTL_EN is coupled with the enablement
> of widebus but this is incorrect because we should be enabling
> this bit independent of widebus except for cases where compression
> is enabled in one pixel per clock mode.
> 
> Fix this by making the condition checks more explicit and enabling
> INTF_CFG2_DATA_HCTL_EN for all other cases when supported by DPU.
> 
> [...]

Applied, thanks!

[1/1] drm/msm/dpu: fix the programming of INTF_CFG2_DATA_HCTL_EN
      https://gitlab.freedesktop.org/lumag/msm/-/commit/2f4a67a3894e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

