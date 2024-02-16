Return-Path: <linux-kernel+bounces-68502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DC3857B45
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DF9284A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573B859B57;
	Fri, 16 Feb 2024 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ny1bGW5B"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522158236
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082090; cv=none; b=PLeMAfGiudRo+JtTkKE7mlR1rjZeB8nd3JMp3CRStUkKKw30HbDt9iyTLHudxRtDKtIOqVYIxcbOywMoCig51yYtgkjxH+I5k51/jI7XNRIgnbPUa+GNA2PWldS7ngGWx35itZhUBhp6oKacWSK7rAYA57uBkVJpCDPsiAv5Qm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082090; c=relaxed/simple;
	bh=Mb3O0r/ZDgnL5SsOM5Kxo3u/DkpD2rGMsl6RgDvEUvs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GHdWrGpglXeqNWr7H8s1qwBqTzAtiEUlivGSdiywEPLteAVIGIuEpgA0UXrIFxWS7Zwkx1HRzvfR9SRO27ZmXeBP3qoIOIVAVOroCFAIL7azZMiDgUxRNcMiV6nZRUj+EvOyLCqQf9Z+Ssoj2onRNcVBFZy1l+bNwXGvPXPpW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ny1bGW5B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so16874175e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 03:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708082086; x=1708686886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4ZT8wxOTMEaNAlp2WhGQd6HjKItKsveZMf5lqO1FcA=;
        b=ny1bGW5BU6N2a5c+Q+vWBaQsQdxN6KsbAKEHYh2VkcJEDmmeGLy31y2Oc+uGF+sDfa
         7PQLg2OnyGr/BGjlFNgkDMYEMAQqDC+PWd3gpiymaUPI1LmSKZZvfpz7YGz6SgGmwq4z
         R33noZhMton1+2zI9ojT3H3U3GOY0qRjXA564OvNzXb27/zGmxOaPAr6D1rcocnsKAgW
         4P8nhHmFCc3DYTQBCfr3fw6MRhug/j7dF/WH42UQDBWvT1p7gtPYUxi1c3fe8XlRxlyP
         2qBBoa7qiYtm1Uq6hPASxeMdAoehYnv1nO2hXdB6+D+Xn2ldZH+Ob9TugAdIJM5oMVO1
         ABug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708082086; x=1708686886;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4ZT8wxOTMEaNAlp2WhGQd6HjKItKsveZMf5lqO1FcA=;
        b=UIhxpCf2vsnWdyc4Bifb+DVDkCN5d9nhJPjHbkhAb2soxy7gZXuAdwI+Kmnqy39JI9
         5eVTG/xza4rq7sxo9rLUQSp78iBLOQKlharypAi8M74o2AWmCtGJX5yQ3XtUGEKo8qah
         q+4oRaIbobhsBosdtQkW266rVNus0h+qwOilIXzgO6ZTYYoFMY5QjcX/RjHSQudJJJay
         jmy+UEFOTHLQN3sISFuT2AUA5ie07VaBqnQiAOx/WFmyStNDdFWobpDrpGKfVRqVIqkk
         DD7/XKj4EOvArWWiQWHLbuzNuMviy0F+qbNwJM+dz2ePFKxb7BpnQEx9/f/7GuS84wce
         JZyw==
X-Forwarded-Encrypted: i=1; AJvYcCUMoL94hXxMNAwO7hPnGOXofyl00GPOT8Q2OoUj7lp5vJ0DBwRwaUJLESekUrkjotLBFTMVSp87eU4HO1YFGMPCpccMYPlekglqe0jO
X-Gm-Message-State: AOJu0YwLmJk2uPGbmFzkJcc4FzCPYWR/pWHLHJvgsrEtBZB9UAYRp9/f
	6CZ9yGCN96BTFQ8s6QIiYg/5+SuNmLxOdc3e2B2BUplu8jwTEmTj25dQhyhH8O8=
X-Google-Smtp-Source: AGHT+IHMW9EOiDBogGRBEw6/c9KN9vSHehtmGG0Sqpr8h98BQtKaE9M8TzBhHR4IQo9aOa3UMDmQKA==
X-Received: by 2002:a05:600c:4f8a:b0:412:4731:a5e9 with SMTP id n10-20020a05600c4f8a00b004124731a5e9mr1055108wmq.4.1708082085778;
        Fri, 16 Feb 2024 03:14:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b00412157dc70bsm2050270wmb.30.2024.02.16.03.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:14:45 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240216-fp4-panel-v3-0-a556e4b79640@fairphone.com>
References: <20240216-fp4-panel-v3-0-a556e4b79640@fairphone.com>
Subject: Re: (subset) [PATCH v3 0/4] Add display support for Fairphone 4
Message-Id: <170808208477.3157813.2988071781833358555.b4-ty@linaro.org>
Date: Fri, 16 Feb 2024 12:14:44 +0100
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

On Fri, 16 Feb 2024 11:10:47 +0100, Luca Weiss wrote:
> Introduce the bindings and panel driver for the LCD panel with the model
> number 9A-3R063-1102B from DJN which is using the HX83112A driver IC. It
> is used on the Fairphone 4 smartphone.
> 
> Then we can add the panel to the device dts and also enable the GPU.
> 
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/4] dt-bindings: display: panel: Add Himax HX83112A
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3b59787a5170e12beb636cf1a66e481526f293cc
[2/4] drm/panel: Add driver for DJN HX83112A LCD panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=654f26a0f43cfd35a5ebd19e008b6f065f2a1f92

-- 
Neil


