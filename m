Return-Path: <linux-kernel+bounces-97897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938E877147
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCB51C20B1B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062F93C467;
	Sat,  9 Mar 2024 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gl5a69X9"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762D3BBD4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709990112; cv=none; b=n5f78Y4R/Ui1E8MqyMmzfc5Q5ERs3xyWKAxmZ72mw4g3l11yEWOhKfedpA/QRkBCm7cuSuovqQ69TrYvHy1TtandhUChPG0wvJsp3jfLkhya6UQt3cuS3bFn88NnlOepMyXoIprjQXrsDuCiM4NQ1mMfSq6g1ucznecw4CFpfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709990112; c=relaxed/simple;
	bh=/rLOqxDCtOy3ZBTqzS2uqhC7GkbdJSaFH0Cz3NiHJsg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HNaO/TLhZ8l35u6zJrNZqmfH56kXjlna7bh9pb8XU7yuaM/9gM03G1SQ/2uOEVLdyOsrnBXoFwxKwCbipcE9d+kx+PKF2BDAa5MRsujEtthFyVIFc4U7HzNnB9/U6wbPOBq7UjIWcNXzttFp/eTiYSUngQWrnkmdDs/ikhQPXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gl5a69X9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d3fae963a8so27635601fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 05:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709990108; x=1710594908; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8UXQrDYYySZ4GwBvs13x7kXsVlrNox4c3TscAN1nzQ=;
        b=Gl5a69X95JNBrPn6aU9qjECmzg99NIN+cuoG0lXE16NVxEPBEtZI/8d9YuH07GDiEm
         RUwMcLfh4Z3Fal91vXJT+o/sMN5MOrT334HkpSre7YuhqeGRX+scK8qQkda+mYYItHO0
         sF9T/qh/nCLhHqncbe7mLCZBsp/CUS/AGcTHsS/nF64H3/CoFOpdsEvsG/RtOjYc/Zor
         LOAGESZdxXszhW91TxZGOKl2sTPfDHxACYpypoo0mldaB95JwyzlcRlGvyOfzivo5TGI
         vqHw8BsmLdNo+DdY1y3GZcz8bGnpLG0/hbJf5Sh8ACDKZsenVTUDcSrRAqjH2nUdZQQt
         P9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709990108; x=1710594908;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8UXQrDYYySZ4GwBvs13x7kXsVlrNox4c3TscAN1nzQ=;
        b=XfDrvkWqXQ1ONXXHoX3TgTD0SFjfgjw0YEso4rHTIA/orUR1sOQcnwWA8H9DEY3d4p
         DquITnVkgnXD7ton0vh2kfwmNprCqjyPY+CWt1UkRckR/4jD/C4ZYmIdWDZavqdqs32n
         M6HoFPjEnWWmxdU+i+hsEhHUvXesqIn9ciDeTVT1007LDp6mUkCnyb87aPnmDpN6itGb
         +BeAbZ5wgeLw5qYzCyJw9JzUiaACwBw5kE/rEEBOT1xlidTwTrI+naTwLc9RZkYHPA//
         5Mul9ryGVU+CMULH96tQUu8FVMi5TMY5X0MfYfFs6JtBdPceBFfleyUwurWERRO2YWSj
         3YNw==
X-Forwarded-Encrypted: i=1; AJvYcCWBVeLtQdsQB0cPd/mX0VBoxq7U+OLdASzIJoLnmilc6cG0dpYMUCQgQhIvrr4uAErkkUWFl5NDuvtaz07ZTF9hUTUEqpbj0i5kzTWH
X-Gm-Message-State: AOJu0YwOIEk7Qxg78wbUsmfG/HO+1BcIuWakPsLyw+vqS1YNavpUdHUr
	El1ZjVykc6aywKU7xXs9/H7JapqQr/louPcgtCDldmUXoQWZeP04Fdxbu7Pf7NA=
X-Google-Smtp-Source: AGHT+IEWGXl1OqAaIsm68n2Tg6uRWCj1l0pMavIibu7vuSi5KJe98gVk3MLtxz1Wy6w+1UxI7F+lVQ==
X-Received: by 2002:a2e:8810:0:b0:2d2:a2bf:4ae6 with SMTP id x16-20020a2e8810000000b002d2a2bf4ae6mr1185972ljh.31.1709990108433;
        Sat, 09 Mar 2024 05:15:08 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i26-20020a2ea37a000000b002d3e6ce75cesm297596ljn.70.2024.03.09.05.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 05:15:08 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/3] QCM2290 LMH
Date: Sat, 09 Mar 2024 14:15:01 +0100
Message-Id: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVg7GUC/3WNQQrCMBBFr1KyNjJJq6gr7yFFkjhpBmJSJrUop
 Xc3du/yPfj/LaIgExZxaRbBOFOhnCroXSNcMGlASY/KQoPuoIWTnPJITrJV9/gMUiH4rgPXnrU
 RdWNNQWnZJBfqKr1irHJk9PTeIre+cqAyZf5szVn97L/7WUmQB3BH8B6VauEaKRnO+8yD6Nd1/
 QIjnrNnwAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, stable@vger.kernel.org, 
 Loic Poulain <loic.poulain@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709990106; l=1019;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/rLOqxDCtOy3ZBTqzS2uqhC7GkbdJSaFH0Cz3NiHJsg=;
 b=BOLrerRTfO9qD2pMYZTSyidUuVlxPx1s/nqhfu0hHL9K1CWlmrREgogxESYonIzQ4bAtmcPVg
 lOFss0UIA3HBoU4bSm51iObSzjUIYSSt5wspLgsCMW4c69kv8eXhEn/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Wire up LMH on QCM2290 and fix a bad bug while at it.

P1-2 for thermal, P3 for qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Pick up tags
- Fix a couple typos in commit messages
- Drop stray msm8998 binding addition
- Link to v1: https://lore.kernel.org/r/20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org

---
Konrad Dybcio (2):
      dt-bindings: thermal: lmh: Add QCM2290 compatible
      thermal: qcom: lmh: Check for SCM availability at probe

Loic Poulain (1):
      arm64: dts: qcom: qcm2290: Add LMH node

 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 12 ++++++++----
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
 drivers/thermal/qcom/lmh.c                              |  3 +++
 3 files changed, 24 insertions(+), 5 deletions(-)
---
base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
change-id: 20240308-topic-rb1_lmh-1e0f440c392a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


