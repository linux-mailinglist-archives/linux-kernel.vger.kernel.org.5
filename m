Return-Path: <linux-kernel+bounces-165555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848928B8DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7AC51C20FCE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11CB1304B1;
	Wed,  1 May 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIESdWjt"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759E53368
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580384; cv=none; b=m6N8MNV9OqUwelHJXJgtCvgIO9QLhVnnF/ipwMB7kqO+qpDna2xiD3Ud1i4rG8wpqaLOkiZU8CR5QgsS5MfX32+pk3YWA8QNKYmyOTIHZDgrZYJdpChJeivWew5j6+sK+y5uZsSNqXMpEUB6dH8Wnjd+Xlx2ghHiGF8FvsKhqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580384; c=relaxed/simple;
	bh=Hial4NE0MI1OOXFbCphdaD+gWgv6Gib1/wJMCCUVjAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oIJ+iG6cWzBgYuyZZD+QjI6ZqHAfsReDFiFeALfxDSmCN1aQsukQRXF9ImSlUXBaXAw+QtLg6s4qrAFg4aRgHSjkPfuy5W/vvRqt8ehw3zuIqa0zPgaJoU5z5++gSm4ozKsmY+grSpsT/5joxWPWsLLwantJbmUpJxnIyt7N+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CIESdWjt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so9534898e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714580381; x=1715185181; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9MplgDZslzUh6Bxa/uOXel4exzaD4mou494VCSMeydc=;
        b=CIESdWjt1YLIsKegZN/eElev0lqmGJG5YztZiHJmQOwoDsjCgCgQL4gbqbg6qWtMAk
         IYcyqzGss9wRq5hwB72V92lttF2qDs4rKf38Bb3TBmkFgIPfOX7TB7HpkbVCLXEO/Jtn
         imuIHRXbB+u8AUXS3KtZpm/HBuOH830IFc2sLh8nOOMUylzaEIBBlaTWQ2IiiqufODr3
         j67pdSKdZbZK3B2TtiO0graoAlIUQJIgoJn2/0oWtTZmzzLqZVBbgsMLmoayKXHVd72d
         hAm/20nyDA16Ug58UE2Aj5FB937wXVkAa/MxAT0lPFyWKI6HumFEMlFq2pQBzqaxyxDC
         GKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580381; x=1715185181;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MplgDZslzUh6Bxa/uOXel4exzaD4mou494VCSMeydc=;
        b=cgrtNyMEkGgy7jFD24WXgg1WOidC+zwZyy+KmgKULUr1sNGinsfwFWN8atIMgnhg8n
         gl7/qWoz/pwdBCnkudBpJiSnSv98EK9K4GcWcqbaWXhPYxbd1/T/XvjjKTTz/a/G/rMB
         jcszv/+ImwtuLImZqAuphugsQRvVJP6zGFgEJ1s2qZjTqwFgR7h6iu9IYVb3Myi9fjpR
         JcRKn0ZZAv2i7JceFF6DrLH/ZfEZYzGXYPHhahpYsQ5A7g9rFWB+2MzQDwoPc9/fCXFC
         c5i9zl5ZWfgEyInIiogHaaea90iwsleYwWCvMW8gfVO3NyN1Oz+Hx2KmrL7RiXGkmhyk
         4yGw==
X-Forwarded-Encrypted: i=1; AJvYcCXfjgAco5v0fhk2uCdKYmfZXR9EqmKrt/++7ZDvDED0nnLTpAeSRUyP6xYL7GWa7hnOirWSLo0+IU8GlwfJGkToDkl6mIVtwCRkPWFH
X-Gm-Message-State: AOJu0YzvA27NynbQctNtrdcQO7Ao9Z0oWQzwLtrsLPjL7oUlSioo4Owz
	no1OKrnEtVZrme7CJu2g4CTzljAl0TRstnzfdiL21kdHZgdM88vj84xDm7uSMr0=
X-Google-Smtp-Source: AGHT+IHKgc6t8AxmFEjtGVZj9pN8xREsNV095xi7ULMS3j0aWhAOjeM9gooTZzTH17vCV6aP1Opmgw==
X-Received: by 2002:a05:6512:1327:b0:518:b144:9020 with SMTP id x39-20020a056512132700b00518b1449020mr2027238lfu.61.1714580379137;
        Wed, 01 May 2024 09:19:39 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d30-20020a0565123d1e00b00516d0029383sm4909306lfv.28.2024.05.01.09.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:19:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 00/13] arm64: dts: qcom: fix PHY-related warnings
Date: Wed, 01 May 2024 19:19:26 +0300
Message-Id: <20240501-qcom-phy-fixes-v1-0-f1fd15c33fb3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI5rMmYC/x3LQQqAIBBA0avIrBtQE6yuEi2kppxFaQpRhHdPW
 j4+/4VMiSnDIF5IdHHmcFSoRsDs3bER8lINWmojje7xnMOO0T+48k0ZO6OsdLZTpFqoU0z0h/q
 MUykfrN8er2AAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>, cros-qcom-dts-watchers@chromium.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 David Wronek <davidwronek@gmail.com>, Andy Gross <andy.gross@linaro.org>, 
 Evan Green <evgreen@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
 Iskren Chernev <me@iskren.info>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Hial4NE0MI1OOXFbCphdaD+gWgv6Gib1/wJMCCUVjAg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmMmuYC89DTsZQEAbgf6DFMcHa/L9r+P3mo6w85
 3oQZsH3C+iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZjJrmAAKCRCLPIo+Aiko
 1TDyB/9f7iKmEdPEB6C4kT/zJ99cFcuSZWzOx8+V9w57WQeiBqBFY/bkqVzzkUaHdX2zTNqt/da
 rZb8oWmlxnGTGMsJSvvPe0U8Of5vl6vVQLAPOWbzUDVKxCw91eB4zHFGQWY7bISTTp/bRWpmUAG
 38Kqx3/U8rE9DYFh/igu5mgE+JuCgTofGQN6Gs8LnoOH84oDZlPqSq0Z6O1fRdo2j/gRGKTaGEd
 rkPi5Ddeu8dG1cpWzUqaT0JfDvYl5wbWdvpgKIMbhvM5UHXDOUGkiDyuS4evqZiZGxBLDeK2VQm
 57ufOYQWbUaDu+toQRoL7KHHeKouL+AOsbWBZyv8q4ua3IxY
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

This series goes over Qualcomm PHY bindings and device DTs and fixes
obvious errors and warnings reported by dt-validate.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (13):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: fix x1e80100-gen3x2 schema
      dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: fix msm899[68] power-domains
      dt-bindings: phy: qcom,usb-snps-femto-v2: use correct fallback for sc8180x
      arm64: dts: qcom: sc7180: drop extra UFS PHY compat
      arm64: dts: qcom: sc8180x: add power-domain to UFS PHY
      arm64: dts: qcom: sdm845: add power-domain to UFS PHY
      arm64: dts: qcom: sm6115: add power-domain to UFS PHY
      arm64: dts: qcom: sm6350: add power-domain to UFS PHY
      arm64: dts: qcom: sm8250: add power-domain to UFS PHY
      arm64: dts: qcom: sm8350: add power-domain to UFS PHY
      arm64: dts: qcom: sm8450: add power-domain to UFS PHY
      arm64: dts: sda660-ifc6560: document missing USB PHY supplies
      arm64: dts: qcom: msm8996-xiaomi-common: drop excton from the USB PHY

 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml         |  1 -
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml          | 16 +++++++++++++++-
 .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml  |  4 +---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi      |  1 -
 arch/arm64/boot/dts/qcom/sc7180.dtsi                     |  3 +--
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                    |  2 ++
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts      | 15 +++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi                     |  2 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi                     |  2 ++
 arch/arm64/boot/dts/qcom/sm6350.dtsi                     |  2 ++
 arch/arm64/boot/dts/qcom/sm8250.dtsi                     |  2 ++
 arch/arm64/boot/dts/qcom/sm8350.dtsi                     |  2 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi                     |  2 ++
 13 files changed, 46 insertions(+), 8 deletions(-)
---
base-commit: f0282d40f30868d986d9c94201949e5d1d44acc9
change-id: 20240429-qcom-phy-fixes-84170a781e13

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


