Return-Path: <linux-kernel+bounces-155841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E498AF7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287511F23CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6DF142E65;
	Tue, 23 Apr 2024 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHIaoAWX"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3013FD8E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903589; cv=none; b=DhG+jJIUk2kiRmAyl7DZIF6MNJkBAr90meCMzQcUn2FXuhCUImEPs8Gwu5u4ol9tp2ILcgJ7GzjGBOd+YDrnvXABCl9TMYhYITxTC5Fq4v5PvcBvUy9DBzp/1TXthOw4+JPwTxY1kgJ8p+1b2kF0eMjx/j3ZjTj6GqxKqN8CzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903589; c=relaxed/simple;
	bh=3O7BXnUsDX8ukBf3kywe0wHWEfDlM8avhl1AO6/1pQk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZLhAAfhcHeGJIiA5frxwD+h8zS03SRlTrA3nwf4IngBl6r6ySINwM51XVVwvtEhFgeZKKeobR8pAT8P/vgXKXz2OcbV4ub8ODkHXE2hGgOJ10Aw9UzNW+13lAqSE9TFsjoARFFFAmm83f/P86E8tF8uUgEYYCuFcG0fAVpEqSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kHIaoAWX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a55b93f5540so316192466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713903586; x=1714508386; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+do+sS5zXVZ8W0CIVva6X+uSo3qaE6aX4OfqXyq/5zc=;
        b=kHIaoAWXwvRM6APjvVkAUXYSh7D06dZ1Tzw0y8bXwmN09rtaS8GBCfije4zJdjT4at
         9cQN33NNDWbM0mUPBq1sDQ2qrnpPEN9di00vIy9PdGRQCZ3Lo7AuqqXpuFyqibAkbWtU
         xz4Oq0CTiT9/Ag8PFdNIWB2CwlQFjAVtQqMWj+DF2mG7sg+QgGHxfhxBPWvPPFr7Jxlh
         Yk4WfpsJirMpAwoqn8jAidq2uWBR56fSXKTOujPnKQsixSM5BJLL7YlxhNxEHoloC8uC
         w8azOL4lOpWITfG422dfVgtaHsaZ7HkPRkXuBFJv+efXNpCeo+6tyj/2Wkt2a6waXcRy
         xUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713903586; x=1714508386;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+do+sS5zXVZ8W0CIVva6X+uSo3qaE6aX4OfqXyq/5zc=;
        b=IEU9s2dUjam54/GaJPNmeQioDL7qkQL97krCwMzHiO+qnnVocLHptAD3BAeVZOPMij
         A4Id2IjXUBvni4bEWt/ep2v8Dg3IHRznpRhA0GnoHAotR0QI1Q7bv2bEujchxPKs9XTK
         pvnMteMBZzT/+dXk1TOkuNC/rmRsduYmXnsNQpnKMz5pwl+CBMlor2s04Val/MrSPyWd
         7+wKyKGe/wwzQ13Yrs2qSEMLurJvyTRbSuZTvJiPlGoMMmTpqznYJys7DNT+klWJJL80
         Qw4ER2vGgPRxASvaWqPQH1ZB9AaIliTdqSNFl4Z6JlnQGLDMywDxt9D3SSiTura06xpm
         /lHA==
X-Forwarded-Encrypted: i=1; AJvYcCX6egZWtGizK6dZwyT/lpxdVlF0SE/MJ7Nw1DDtZclgg3j1oeGaPA4Ddu10BqTdoTg5Vjyqu8Tl27qi3qZYVHrbsoEi0QVXrE2pC5lQ
X-Gm-Message-State: AOJu0Yzrmx5OBFHG50VhDrZ/joctuT+Eys0vMBo3laA2DYkxFQYMuR48
	8XWJSyOOnAj8Q0hamCvxdhCtAIGubCTdSNU541oDkB5+2vEcPjMGo24LmEhkn8Q=
X-Google-Smtp-Source: AGHT+IGdOsUjr0vw61OFmMtWTH1FBxLLoYGz76G1VI9CIdDARt2oojq6AQjBqT/RxUpia0y4IXYtuw==
X-Received: by 2002:a17:906:7c56:b0:a58:832d:c3e8 with SMTP id g22-20020a1709067c5600b00a58832dc3e8mr228603ejp.58.1713903586261;
        Tue, 23 Apr 2024 13:19:46 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709061e4700b00a52244ab819sm7552431ejj.170.2024.04.23.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:19:45 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/2] USB (dwc3-glue) support for Google Tensor gs101
Date: Tue, 23 Apr 2024 21:19:44 +0100
Message-Id: <20240423-usb-dwc3-gs101-v1-0-2f331f88203f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOAXKGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyNj3dLiJN2U8mRj3fRiQwNDXcM0UwszkzQDs+RESyWgpoKi1LTMCrC
 B0bG1tQC5VkjRYAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

The Google Tensor gs101 SoC embeds a DWC3 USB 3.1 DRD controller.

This patch series enables the existing dwc3-exynos glue layer to work on
this SoC.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (2):
      dt-bindings: usb: samsung,exynos-dwc3: add gs101 compatible
      usb: dwc3: exynos: add support for Google Tensor gs101

 .../devicetree/bindings/usb/samsung,exynos-dwc3.yaml   | 18 ++++++++++++++++++
 drivers/usb/dwc3/dwc3-exynos.c                         |  9 +++++++++
 2 files changed, 27 insertions(+)
---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240423-usb-dwc3-gs101-1f5864f06ca9

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


