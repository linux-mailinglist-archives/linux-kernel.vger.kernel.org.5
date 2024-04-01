Return-Path: <linux-kernel+bounces-127035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC5894609
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C7A1C21B63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414D5579F;
	Mon,  1 Apr 2024 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFvTVURC"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1184683
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003628; cv=none; b=Rl6n2p6+F+6Dkk1m9jzJOkFpLq/SzC7DM5toNtx/dlwoXEvDVVj52QEWMhh3rJD30rFFngCmvTU7zyBy3ijnRDQygs7dDE7rTqXrUUWSBh+9lg28X9mZBbCk0DBcwd1K3xe/9KH7ARMu7Mr/reiYH2jXDCbwGse7bWFVFIHBbs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003628; c=relaxed/simple;
	bh=yzl3goeSmHuxekh8j1nwToQpTeHL6BZ3u1FULJIKq10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bMZgTp1MBLDvlymoRorXykyqrFY8fF4f+ggDzy+d2lHJFR2rUaPejhLTd0Mi06xOUobuTfj3yjyvaSm0bWx9HsVXbvv1BMeFoIp8RsqARBXuQshTLDBEX5slUS1Jcu9XTnMuNclLlMwl7/jvzlQFk49HBiH+yAowaHK2+ymbbbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vFvTVURC; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-515a97846b5so4674582e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712003623; x=1712608423; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wlaXjLO3lJw1mdJDgOpmPIwDq+5gWC5iSvOljuMWC/s=;
        b=vFvTVURCoYl1Z9iJ62ZYGua0ezFUe2UUjutB9enHA48qCDUc0ll/kbKRoS8VhsuWWc
         TnDK1tv9K2MRl2fNx+fwY7EiSzn2waWBfw+o6yuFx9auaIjucLDLIKVZPN7+8BL9snKy
         ALF0hJIBAOgJo8VGPMHePZt65xGCphqBZI926CPfTAqW1CW6QhEzdAmt4jM2Dxadqxee
         kzwvn/f8hLPP7hnGOKyge1vze+3Krmb2OY6qUhqqSNTO5vWitfhts4cKMWW+UM6HoiV6
         WdQI/4chPBmlKy/OKcg8St1M8+RNVvJwr5CQ3F7UfFtJ1jR2YYyh9w74a/cq/4DlZVvG
         Kx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003623; x=1712608423;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlaXjLO3lJw1mdJDgOpmPIwDq+5gWC5iSvOljuMWC/s=;
        b=Pt64YnzxYjxYkTgdaljvFK0jKipCI+0WUExKt7IMf1bATY/gZXh9JbTmxw9mF+pQNq
         bBZDQWtMLSuumTUdv0PMoCU0U2+uHD8vQDRA70/b6OOCCbqreTl4l+t8WFSrv+TbW7JL
         jqqgKBibK2xKqMm3thqqkUboATozziOyAQOvrbRAsAR+odfSsuPAnSi6baaX3Tq8Hqca
         AWgTooDTVlIDfAlVSk1XEs+VoE/7d797LhDCuSp8fldk8+ler9jqr1lRrEFsG/PqkolB
         1qbbkrHOe0XoInIRJilEDIDhp6MGsIFL2kVglg51NTWobRHE0yvDsbWeU1Nqgx78BRqr
         UCFg==
X-Forwarded-Encrypted: i=1; AJvYcCW9CeiUKBnovIlvjRrGszAhJ31rIaV5JVz06iYh8dIqB0z0UHoOF4Fa/vt+F7FbsWRhepYz77zV5hNydmaAcdriSRnrpOsy8pw8UaxM
X-Gm-Message-State: AOJu0YyepTRmT469anCTHwqaWsrD49l/QpAGFPm+a0H8zCOwgP2lE0s/
	zr7XzE7qVq2ubfXCe6pCez+k7U+8O/kSv64MZSDYbi/jjM4jcstYSAJTqOE3G48=
X-Google-Smtp-Source: AGHT+IGA1rc9IfVZxEDlIfv8mUTWYpSnRFaiJzJr90xIO/AooxbhkfnfLYzgq8nWO68x1QTh7PDuFg==
X-Received: by 2002:ac2:58cc:0:b0:516:9ee2:9977 with SMTP id u12-20020ac258cc000000b005169ee29977mr4024200lfo.33.1712003622850;
        Mon, 01 Apr 2024 13:33:42 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b00515a6e4bdbdsm1478342lfk.250.2024.04.01.13.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:33:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 0/9] arm64: dts: qcom: fix description of the Type-C
 signals
Date: Mon, 01 Apr 2024 23:33:39 +0300
Message-Id: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACMaC2YC/33NzQrCMAzA8VcZPVtpk31UT76HeGi7uBV0He0oj
 rF3t9tJQTz+E/LLwiIFR5Gdi4UFSi46P+TAQ8Fsr4eOuGtzMxBQCgTg0zyS5Xf34vGpoBIc0Za
 NFqhFVbN8NgbK25283nL3Lk4+zPuHJLfpHyxJLrjUFsAgIunT5eEGHfzRh45tWoIPAeUPAbKgq
 kZbU5tWKfoS1nV9Aw2MQtXzAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2267;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=yzl3goeSmHuxekh8j1nwToQpTeHL6BZ3u1FULJIKq10=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCxok7Qc+ahBwgQptj/bJdLDpoeNelEUlm7uFQ
 zN+rOvGp9iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgsaJAAKCRCLPIo+Aiko
 1SA1B/9Ck4E3hM5XDzjEFGlOQ1hH1RaOORV5rHciU2HPIzQGad+Bf/kL9ZD/+MOtxAXllonwp2d
 7K4prBgQg8G3xMEfih4AbFlVHRA5mZyqC5b4VXzHf/GjO30Avj53+6zU3L+vzGcdmHwfn0KmA4q
 Q6wUpxj6/jYOp+Ih3hpfdqnBqLPCaLvg9RBzBQqPATP5DJsV97WvM4Y/ax1AGANImiQxCndHO0u
 sai8PPZzO4mwDGNvGFU969IXtq7wvpBBfMS1hVPPMD0zF7O9Ii1Z75FiBTbsUG1q3Pw9PxUQ9tD
 Rha30wupABEmOFFOtLaMdiMKQDjszMadmpp8MEImc8FyBAdV
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Rename the HS link between usb-c-connector and the DWC3 USB controller.
Add missing graph connection between the QMP PHY and DWC3 USB
controller.

Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v3:
- Fixed dispcc bindings / clock inputs on sc8180x (Rob Herring)
- Link to v2: https://lore.kernel.org/r/20240331-typec-fix-sm8250-v2-0-857acb6bd88e@linaro.org

Changes in v2:
- Fixed other platforms in addition to sm8250 (Bryan)
- Link to v1: https://lore.kernel.org/r/20240322-typec-fix-sm8250-v1-0-1ac22b333ea9@linaro.org

---
Dmitry Baryshkov (9):
      dt-bindings: clk: qcom,dispcc-sm8x50: describe additional DP clocks
      arm64: dts: qcom: sc8180x: correct dispcc clocks
      arm64: dts: qcom: sm8250: describe HS signals properly
      arm64: dts: qcom: sm8250: add a link between DWC3 and QMP PHY
      arm64: dts: qcom: sc8180x: switch USB+DP QMP PHYs to new bindings
      arm64: dts: qcom: sc8180x: describe USB signals properly
      arm64: dts: qcom: sc8280xp: describe USB signals properly
      arm64: dts: qcom: x1e80100: describe USB signals properly
      arm64: dts: qcom: sm8150-hdk: rename Type-C HS endpoints

 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |  28 ++++
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   8 +-
 .../arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts |  16 +-
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts        |  20 +--
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 182 ++++++++++-----------
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |  20 +--
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  20 +--
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |  54 +++++-
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            |   4 +-
 .../boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi  |   8 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  24 ++-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 149 ++++++++++++++++-
 12 files changed, 380 insertions(+), 153 deletions(-)
---
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
change-id: 20240322-typec-fix-sm8250-33c47a03a056

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


