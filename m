Return-Path: <linux-kernel+bounces-107783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A566488019D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBEC2B23D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5581ADF;
	Tue, 19 Mar 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lM71VhRE"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED87FBAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864822; cv=none; b=sZDHqGsgxFlhlsciwTBXfLlcxP8P/Oly1j42lsWJUh21QIe/6+o9oYSa4BUrZOgRe1u1qeklbJyYkfgM0y2WfHVLMtiOBjm43vs87wCSLLwxk0Arv0k8z8CA+wpLR9bD3HE3OKQ80dlSlhMXR4gXNhe+5d1nbgMKv99zOOsxyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864822; c=relaxed/simple;
	bh=3OaHTjRWxVOFqq6QwFWr9Vf1yPoRQgChqqNEL0LMK/U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FQhrH4cTa0KtLQYI1HvJuIfQJ+lVUGUYKXxygCkiFMhxPfucIjOyzmssZljkEUD8e00fmSQiFLwrLJQMmNBtf5O2pK+DXsUFUNSlisSqStkUYFeFen1iMGPYU7SoNW+Vm4hJ26EnCA9gqydZDwtg5t0fTZdf+bn9zlzeD+5ccIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lM71VhRE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so7289984e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864819; x=1711469619; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4V4CmtBHIR1w/0/gGzCFIaeKfwz/9sDrWmne1XV4j0=;
        b=lM71VhRE4nSM5iYQUJlcvlj/LOczqOP06tRI30JKi8MxZ6HDPpLK5PD8YJjmAbIyOU
         SkHo97DDUujK3S6C4bB/3nA7gEaaT0Jiiqg6QRWZhRriVrVKK8xjoXz9FCbzTLL2CgiT
         FSjI/aDrx6RvNbLRyMwRTMq+iO0yTNTUgH7fZNcr/CO4NYhINmbhFVOi3SFa0wbQ7jh8
         CMhHdL0HkjvavHIfLeb2WdyC52so4YoWjBBycabov66QHD5E3ViiRz15gFhQst3aeeFr
         GnXON9KlzsBBw6upJEI2OSpd3CAfpBlFVkz2bFY6HgBoJsT1AkHpSJFVWRgjJ24/aRcE
         dRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864819; x=1711469619;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4V4CmtBHIR1w/0/gGzCFIaeKfwz/9sDrWmne1XV4j0=;
        b=RVcv6+8o+Z3v0pWef9H/fTbw8/tstqOdQD7baJrzM15+68y/8U1Dpi8eDuWbMlSy2q
         H4dvmaU9qsZ85jjL2JVG+sacAs2qqqk0lWsMXewLfdw5z+wdpbHQIbFx3Q7CLai1YVkf
         retKpzsIKZDa1beTjxCLYNY8svGsfXWnDO8rCeTDMb/FzL7R6W6Mnx0EyQapilWre8ty
         AUuIkDj91FVr4+11/xv7RREl9U9EjGj6H/W+j2Rj+bdnSdKm92s5YriqhVHxe7osHxr7
         EiBg8LfqdWTV28MYzsksX3ZwoVb6oz0+fhmakNnISLfMcGIsJ3wO+0bgMgHmB+99lHr1
         rUew==
X-Forwarded-Encrypted: i=1; AJvYcCUI7DoNEs7EEq7Tf54u4J47+4S08XUHTcpxfCL+uykuBk7xxQ4CPeRsYLDfaqBVBmLu06gX77ceV4+yVAUrkcgNxtbG7l7cqZl2e+6Z
X-Gm-Message-State: AOJu0YxlqxGEl1z5czvsiTRQ9xkl1z5c+XNULDPWY8t+TCoiowA4L7lS
	pnA+Zxob7iTyull0Q58KUfiLe4p5E1C8iljedMnqT3k9fbWqs8Wzw08wmHZ0W5E=
X-Google-Smtp-Source: AGHT+IFsaOH79x756pVmwPZU66WQtsB5zOqjXh2+A9Qk7o/xaEluA6voZuVxAdAmJ7G3RSQbJFaTmA==
X-Received: by 2002:a19:8c0f:0:b0:513:9da7:3792 with SMTP id o15-20020a198c0f000000b005139da73792mr9914687lfd.19.1710864818621;
        Tue, 19 Mar 2024 09:13:38 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:38 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/31] Clean up thermal zone polling-delay
Date: Tue, 19 Mar 2024 17:13:30 +0100
Message-Id: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK+5+WUC/x3MywrCMBBA0V8Js+5AEqU+fqV0EccxDuRF0opQ8
 u8Gl2dx7wGNq3CDuzqg8kea5DRgJgX0dskzynMYrLZnfTI33HIRwtgilhyCJI8U2KW9oJ3N7K4
 PJr5oGH2p/JLv/72svf8AFmdz9msAAAA=
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

A trivial follow-up on the changes introduced in Commit 488164006a28
("thermal/of: Assume polling-delay(-passive) 0 when absent").

Should probably wait until v6.9-rc1 so that the patch in question is
in the base tree, otherwise TZs will fail to register.

FWIW, Compile-tested only (except 8280).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (31):
      arm64: dts: qcom: ipq6018-*: Remove thermal zone polling delays
      arm64: dts: qcom: ipq8074-*: Remove thermal zone polling delays
      arm64: dts: qcom: ipq9574-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8916-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8939-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8953-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8976-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8996-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8998-*: Remove thermal zone polling delays
      arm64: dts: qcom: pm7550ba: Remove thermal zone polling delays
      arm64: dts: qcom: pms405: Remove thermal zone polling delays
      arm64: dts: qcom: pmx75: Remove thermal zone polling delays
      arm64: dts: qcom: qcm2290-*: Remove thermal zone polling delays
      arm64: dts: qcom: qcs404-*: Remove thermal zone polling delays
      arm64: dts: qcom: sa8775p-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc7180-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc7280-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc8180x-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc8280xp-*: Remove thermal zone polling delays
      arm64: dts: qcom: sdm660-*: Remove thermal zone polling delays
      arm64: dts: qcom: sdm845-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm6115-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm6125-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm6350-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm6375-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8150-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8250-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8350-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8450-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8550-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8650-*: Remove thermal zone polling delays

 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  14 --
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |  36 -----
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  26 ----
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  15 ---
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |  27 ----
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |  18 ---
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |  26 ----
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  42 ------
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  57 --------
 arch/arm64/boot/dts/qcom/pm6125.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pm6150.dtsi               |   2 -
 arch/arm64/boot/dts/qcom/pm6150l.dtsi              |   3 -
 arch/arm64/boot/dts/qcom/pm6350.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pm660.dtsi                |   3 -
 arch/arm64/boot/dts/qcom/pm660l.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              |   3 -
 arch/arm64/boot/dts/qcom/pm7325.dtsi               |   2 -
 arch/arm64/boot/dts/qcom/pm7550ba.dtsi             |   3 -
 arch/arm64/boot/dts/qcom/pm8010.dtsi               |   6 -
 arch/arm64/boot/dts/qcom/pm8150.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pm8150b.dtsi              |   3 -
 arch/arm64/boot/dts/qcom/pm8150l.dtsi              |   3 -
 arch/arm64/boot/dts/qcom/pm8350.dtsi               |   2 -
 arch/arm64/boot/dts/qcom/pm8350b.dtsi              |   2 -
 arch/arm64/boot/dts/qcom/pm8350c.dtsi              |   2 -
 arch/arm64/boot/dts/qcom/pm8450.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pm8550.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pm8550b.dtsi              |   3 -
 arch/arm64/boot/dts/qcom/pm8550ve.dtsi             |   3 -
 arch/arm64/boot/dts/qcom/pm8550vs.dtsi             |  12 --
 arch/arm64/boot/dts/qcom/pm8953.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pm8994.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pm8998.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pmi632.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi          |   3 -
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi          |   3 -
 arch/arm64/boot/dts/qcom/pmr735a.dtsi              |   2 -
 arch/arm64/boot/dts/qcom/pmr735b.dtsi              |   2 -
 arch/arm64/boot/dts/qcom/pmr735d_a.dtsi            |   3 -
 arch/arm64/boot/dts/qcom/pmr735d_b.dtsi            |   3 -
 arch/arm64/boot/dts/qcom/pms405.dtsi               |   3 -
 arch/arm64/boot/dts/qcom/pmx75.dtsi                |   3 -
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              |  30 -----
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  14 --
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |  30 -----
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |  10 --
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi        |   8 --
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 150 ---------------------
 .../arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi |   3 -
 .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi     |   3 -
 .../arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi |   3 -
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  |   3 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |   3 -
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  75 -----------
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  81 -----------
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi        |   6 -
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |  78 -----------
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |   2 -
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi       |   4 -
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |  33 -----
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |  27 ----
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |  12 --
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  63 ---------
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |  32 -----
 .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts   |   8 --
 .../boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts  |   6 -
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |  81 -----------
 arch/arm64/boot/dts/qcom/sm6375.dtsi               |  78 -----------
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  |   4 -
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  84 ------------
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts            |  14 --
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  75 -----------
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  87 ------------
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |  16 ---
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  64 ---------
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  82 -----------
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |  88 ------------
 77 files changed, 1722 deletions(-)
---
base-commit: 226d3c72fcde130a99d760895ebdd20e78e02cb5
change-id: 20240319-topic-msm-polling-cleanup-2616a8bece70

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


