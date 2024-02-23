Return-Path: <linux-kernel+bounces-78195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE94861009
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C5C1F23281
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E8665189;
	Fri, 23 Feb 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bu2bSaoE"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A678B43
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686144; cv=none; b=VHX2sMgm9vf+Aq/uFlYiAteCHJ6mcGA0GXncUiMbE/Kj02GAPItGiW0JHqIZcNnoGJgxzTs4c9aRjp/CoSqn8pZmc+qIGLY8hfG7nxtHk6lLzbvfok876VPLasL9uYsQp3rnkxPEDWefJbvA0iYAYeXzLKN46FIQvmzebByH/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686144; c=relaxed/simple;
	bh=wL0UIFN1kPjAIbrcrCSUt3uAuqWY+aQURJT/6KDoWw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BugV/17gmhGEgbTizI/eNcrFyAPebBi55u57GnDQuJnYZL9jzmoS7f3MzlQTJE/EkpXygFS7dGM9jSQSwVAlU3T1zu7v7QQWBl4b7j1Y1DW4PyHxq4aHzALX5HEXoTfsIp58NDldJU5wu0W7DSvw2ZnogIzH5M3tXsIEI7EO7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bu2bSaoE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d204e102a9so6989351fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708686140; x=1709290940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvppDhK0MZnY3jxpyEm3NEhvlxl2cwohWdYTB048HdY=;
        b=Bu2bSaoEg0JWxM3JvjEiebBSlp9cix4TvG9Ak0DAR3mkaYxYBPOhO9AqKlINi7sG3A
         KOBkHuHplmQZPbGSmdkeR2+5Zc+vYXa96UKOOwwKG9rGWr1Yi5Ve35+UeUoRDyTcSPtH
         oSibD6x3t00tjdoulzogeTLrLpNPHrDK8FB+3n3LgSF0i8VJuFBubsF8jsJrgKLyhZtg
         5yjWe8/uomVVUpWJB82pxchrmNMoUDYR00azyXs9zKKPgFijtHpb4q1Cj1YLSWHrthG1
         +Eltj0a0wMgIRT2POZe06a7DidNAWZ5+fxVXGf9Qpj5J/GqOARbbBHBV2Qp+OGR4fPrW
         XO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708686140; x=1709290940;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvppDhK0MZnY3jxpyEm3NEhvlxl2cwohWdYTB048HdY=;
        b=wLWCsmdPy8+09zcjnqpDLvr55l/unX4trH9gcdyAApOG0xepojS8FN2bUdQCWzqRZw
         ENcuwLfsdiCI8rXhNYTj83tMs/c4vQXltljwVy1QPVDRyqJWrNBCq+tkp3wprwOBaInW
         kUQOfndDJPAj0eGEuQBbv3093nhuNF6WFBaUM4juZ3ltnf67Z7lh37IxuSfsrgFBfyfs
         xcx9LfEM1KgmBXC58RgMSlAMgqbm4bkbjTkRn7uag8wYbQhVv2O8Rr7Eteasd098lTqr
         JxjGF2PWqoxL4ORY2BTN98LWuuuC+uFfKSHggTfjald+vcf5F2AAkhZDvwr3I3LW09eD
         nrgw==
X-Forwarded-Encrypted: i=1; AJvYcCUCVKxH1yDM4osMkjnfQyBqt9tAlimJXwE5butRpurxTp5+9u2yagtRYjGTwK/NIwIQyshZdgmoBI6TzhtGALyOYCPQxW5ePATOWdxA
X-Gm-Message-State: AOJu0YznyrNm1/DeKgpQA6UktJQsC+1b5UJoaHgFHfqguVschk90qk8k
	gAWBzbbqlL2Pmki74OBpEAPJV+K4MQpd1IcnkW/ZlTIvVFjnmL6iQL3UsfxP05s=
X-Google-Smtp-Source: AGHT+IHe13buZN2Z7XrUYfFH4yqhm26u3xIH5iaX49WfRIDSgqwB8o5s9c1/EMHFIlWHOBSHytQA6Q==
X-Received: by 2002:a2e:969a:0:b0:2d2:402d:2239 with SMTP id q26-20020a2e969a000000b002d2402d2239mr1063430lji.25.1708686140304;
        Fri, 23 Feb 2024 03:02:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c35c800b0041214ff06cesm1990363wmq.42.2024.02.23.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:02:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20240217150228.5788-1-johan+linaro@kernel.org>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
Subject: Re: [PATCH 0/6] soc: qcom: pmic_glink_altmode: fix drm bridge
 use-after-free
Message-Id: <170868613914.4029284.5549880672870201262.b4-ty@linaro.org>
Date: Fri, 23 Feb 2024 12:02:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Sat, 17 Feb 2024 16:02:22 +0100, Johan Hovold wrote:
> Starting with 6.8-rc1 the internal display sometimes fails to come up on
> machines like the Lenovo ThinkPad X13s and the logs indicate that this
> is due to a regression in the DRM subsystem [1].
> 
> This series fixes a race in the pmic_glink_altmode driver which was
> exposed / triggered by the transparent DRM bridges rework that went into
> 6.8-rc1 and that manifested itself as a bridge failing to attach and
> sometimes triggering a NULL-pointer dereference.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/6] drm/bridge: aux-hpd: fix OF node leaks
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9ee485bdda68d6d3f5728cbe3150eb9013d7d22b
[2/6] drm/bridge: aux-hpd: separate allocation and registration
      (no commit info)
[3/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
      (no commit info)
[4/6] soc: qcom: pmic_glink: Fix boot when QRTR=m
      (no commit info)
[5/6] phy: qcom-qmp-combo: fix drm bridge registration
      (no commit info)
[6/6] phy: qcom-qmp-combo: fix type-c switch registration
      (no commit info)

-- 
Neil


