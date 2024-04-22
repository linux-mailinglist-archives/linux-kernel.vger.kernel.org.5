Return-Path: <linux-kernel+bounces-153762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576198AD2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1301D282CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68661153833;
	Mon, 22 Apr 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXFHNh7S"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632515382C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805073; cv=none; b=mJa5DTWUbU04kfVTk86Q2zPak9BibNBTiirhFJH3qQ+Eq+7SUlNMa03rD1W2LblNSLKlQ3dvDR0GRQDxkpIHiCNYm1BX80Y7iZCzsjqAjDOm0ONULh8Kx2gYqSR26L/4mhktMi2FU0RDvxNFibwWrVWhAzkD0JLq1NOIoaNUe4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805073; c=relaxed/simple;
	bh=Ptp2ftOZAGscOLVcZ1Evx+agdRuYHjLibG7LykakzGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GfFbpxIlpQ48fiHjoV7wWSL3604ScOjdJloIlaGX7IG8NPvuj+cEB6Vd65+hfm68QB2lJE6FWd19vVHkoLMMd4ihLbmk5V7lEOEQyS9iI9ytk0p5KOAarUgMi7KcJuJ2yEd4OMkFt0SPuds0Z15Se28G7tKTAN79+V1cgHiVN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cXFHNh7S; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34b1e35155aso1186030f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713805070; x=1714409870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFejkMe0OVlEaHFS27AO4JIPaFi1PczIDcBY/+c6L4w=;
        b=cXFHNh7SikVSS7Q+R+Bg0ZL+ccO4WcBLsmjuZd8zgoBczvlriEP+jDRqbjfmVLvbR9
         dgLHm/Jxuq1sGUZsNyKIcfDAzwDpQJQaJYxXPTWIi4yQAF52CKDCvsv18ULFhV/y6LAj
         GSgQl7yzWNgU1VdbgWxWLMxWD1eEXYXas6uIPXjD2mkVcikqgchVFSbH/EsrQhNWaxTe
         BJBdhkitIm/bPYIZML5PXJBU2tjP/5dLi4ghrLqWU5VnNFvzK4hiXHHAKI0pAX8lFUn9
         +uuemcEPUMgXwVTfvoU6vniAfQi6cdp87WNItPkd+et34VBGSJu415D5e0Pxu2N3DvTL
         mC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805070; x=1714409870;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFejkMe0OVlEaHFS27AO4JIPaFi1PczIDcBY/+c6L4w=;
        b=N82gF6pwzXG0dahms3qC6OlEMJQ89GvKoYj/LWt4KjEXHkS+TQMVFVlKDrj3KgeOSS
         RNe9q3GThiNlrkwJsQZIUq9qUF2c+SSxb7aPXQUUUd6wewPd1mIOIZAqH8vKSI4ZByWC
         Ell9aXPEQjRPT9+hKsJIvzv2Az9/uISYSrYFYpYlEIfg9+6pMRSnU3rLtXNo8RIAVXth
         tca88LWqfGZdocHdwWIekA4+AIQ6XMH4608qv6HDsYpxwbPaiYtnFXFMGTI5xtdtprju
         NmCmT5djzAqAfoT5UhoeRjF+0jWsf5yhTRqqtpis+OoK1I2sSsvDMjU2K3dj25sL7Sjm
         HcBA==
X-Forwarded-Encrypted: i=1; AJvYcCXY4jyg8a9riwHII7rwFybIKIUujs7DdUYEuSiQZMeXxD3rDdiouGzfK0vsS15TQpADmcMveaA9ZRLxZt1MnaL+YjVuUcL6ZdRY/pkP
X-Gm-Message-State: AOJu0Yw13xoUgWgOTHvy59eMUtsmIp0pLTRGqBrhUeRg00E/TcgtROon
	eIW5BfvzKo0iA4r8rTw2byL15/ULZkqlJoG4tVnc8bslM3OImjhB3Cscbln3OcE=
X-Google-Smtp-Source: AGHT+IFPgoNY7jL28vA9FqUBo9t0jArnUgL+gophkF/W85BBll+VXJnnlKToYJDSJz0chYDGNDGGmw==
X-Received: by 2002:a5d:4082:0:b0:34a:2c89:8517 with SMTP id o2-20020a5d4082000000b0034a2c898517mr7612659wrp.10.1713805070257;
        Mon, 22 Apr 2024 09:57:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d6207000000b00346f9071405sm12509330wru.21.2024.04.22.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:57:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>
In-Reply-To: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
References: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
Subject: Re: (subset) [PATCH v12 0/7] drm/meson: add support for MIPI DSI
 Display
Message-Id: <171380506905.4152979.12753297685732463141.b4-ty@linaro.org>
Date: Mon, 22 Apr 2024 18:57:49 +0200
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

On Wed, 03 Apr 2024 09:46:31 +0200, Neil Armstrong wrote:
> The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
> glue on the same Amlogic SoCs.
> 
> This is a follow-up of v5 now the DRM patches are applied, the clk & DT changes
> remains for a full DSI support on G12A & SM1 platforms.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[4/7] drm/meson: gate px_clk when setting rate
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/5c9837374ecf55a1fa3b7622d365a0456960270f

-- 
Neil


