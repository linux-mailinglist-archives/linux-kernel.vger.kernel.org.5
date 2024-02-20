Return-Path: <linux-kernel+bounces-73742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C385CA55
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62F51F2333E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11EA152E0D;
	Tue, 20 Feb 2024 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvTAzlQ9"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09555152DEA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466742; cv=none; b=Vf1HgMXWC+hjRYLjlOAHeFh2AxH6h2Tyce5xsQRiqzvO11UpwW1dlgDHXfLU4B0yOD2PxUeRMQC5iZrJG6neda998SHaE+UygvjuD/mrRVu1p4GGPtyngvi6FSjo2sFp/uf3UAkiploXm4lnlHZ5Mx2yb6rjs6PnXUIpuR44twA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466742; c=relaxed/simple;
	bh=1oxELfa5Io+hWvP4lYNlRYww+1oOBVHgYby3WJ7/TvY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rGDiKSj5gZtLw++Mm+uBEYoXeV0g82GNV8miKhLl6K8RJJuztuZvK/GrIDZn8YS/r2eugok6SmIcAl6WPZ9pCSzy0w0iSUXCQ6ACg65qrOGTttKVUYmo/1+50BifLMGD8jfZRAkH/FpfBDkxm9Co+Ld2oNl7qipmupH63usn/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kvTAzlQ9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2a17f3217aso793190366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708466738; x=1709071538; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2NZQ995q1n6y2saPHdpsUCNcAuhvmdDn6o1P9oEDhc=;
        b=kvTAzlQ9Db/8oSZHSIAjNFU6Moz9PeeHoa6xZ6VB03f+n8bfbak5CUbw1ZoIPcAdsA
         wEAALm/IGN3L1skA83ZhQ40AyC2PA2XMI3LVjNGW8SQBP2aiTZRn7cU4dKFZuYfqKJkt
         vepf0Fb8Pby87DGf3c+IqN0ehXQ7dZ8a+L6/TUDqwiGPB23SFzQ4Rgj1uFFmaJjSC7be
         vFY81dyWIQC4c9UYlc0hyS9XXVvjIHCiOZ2RKxk9XQXCzWPhsvJ/1dGv5ucSLjrPBRGv
         ZOuucj1tSKg9VP7GSgB1TUE/dgOLt+G0HsP95fRvhw/zoaUfwjWtJL7LKbyYtzeWO5o8
         vFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708466738; x=1709071538;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2NZQ995q1n6y2saPHdpsUCNcAuhvmdDn6o1P9oEDhc=;
        b=ZGuWy4wZHihvQIlExxYs0TP2xunAca8cmFuEvMpB6lXuhxXcOM6HEETNa8vv8XWdr5
         Nz8ovujU28iTlhXEisZF+wp7DdKOq3GQais5M5cV9nT7HKum7qlSJvLSrEnFB5TbOaLC
         rF33buLVPCv0dyK/gm540EnEyVd+rU18HmkH7fWllWqvGRwM1HlRV8NpN795gWm+RJ8x
         xCt2VVFvZws7IBhcPrkJj1i/vTyCTCIA/okTmtZ2qusrEVGqwNq3P+e+N98eI8AoGuJ0
         OeTkoITW4VxNFtxXuAZuV2tG9M5oebzXGJdpOp7bkqIFZ8ZPEDiV2JciN97h135EEJQ+
         R3aA==
X-Forwarded-Encrypted: i=1; AJvYcCXYGGJXPuBuRziekfslhmFKqaMXEO6N46mCg1bxCwJJYElUkU/kc8NpaKwNuO6nH/MnVNlIpWf6z02UuGIKPbUVSnpkEkqBO7Qyz3MG
X-Gm-Message-State: AOJu0YyFd3lrpQYFRxtN39DFdOp6N+F/mnSXyFXknBX1BETvpw9ec3Ud
	OJe1G/ypKOacePT1kekgJDwKXAkETItrn3WGJdlE4imRQ2IHDMRknRLFYv15taZPf96S9eiEgQU
	g
X-Google-Smtp-Source: AGHT+IGq8w26car/zCBj8sM11UVgZmMu/oeBlMNzOADVp/kghBUvQRxRPpbJdwNPnlCCguPjcvHlag==
X-Received: by 2002:a17:906:16da:b0:a3e:7dbe:298b with SMTP id t26-20020a17090616da00b00a3e7dbe298bmr5256779ejd.24.1708466738287;
        Tue, 20 Feb 2024 14:05:38 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id jw15-20020a170906e94f00b00a3e86a9c55asm2716087ejb.146.2024.02.20.14.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:05:37 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v4 0/3] phy: qcom: edp: Add support for X1E80100
Date: Wed, 21 Feb 2024 00:05:20 +0200
Message-Id: <20240221-phy-qualcomm-edp-x1e80100-v4-0-4e5018877bee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAi1WUC/43NQQ7CIBCF4asY1mIYKLa48h7GBaWDJalQwTYa0
 7s7ujNuunyTzPe/WMEcsLDD5sUyzqGEFGlU2w1zvY0X5KGjzaSQCkBKPvZPfpvs4NL1yrEb+QO
 wESAEt7p2oL33SraM/ltbkLfZRteTEKdhoOOY0YfHN3g60+5Duaf8/PZn+FzXpGbg1DNGNcYI7
 Fp1HEK0Oe1SvrAPO8vVlCQKoMK6MV6A0X+UWk0ponS9965Co7XpfqhlWd4ieOA0bgEAAA==
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=1oxELfa5Io+hWvP4lYNlRYww+1oOBVHgYby3WJ7/TvY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1SIncVPlsgjmGMiKi5Am9MB1tLfLvopEg/u8I
 UTw4JMiIfmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdUiJwAKCRAbX0TJAJUV
 VgzqD/0RT6oWi1E9rr1Wan0LcYpK17jYKw9iC5T8LueGuDSeA51L02HHNZRR1JCAAsbqGf1lPYw
 iqO1GkkThYLg/+hOmbDmDX1NQQpfK9l5gUUhB6sj0UTAXXPcid1OLc7xdGg9+YXRbDyOJkD/UGk
 CXUIijUsnlSYbDMCUoT3djHoICbVDg6JbZeK3QYKQd9F1tafV8pjAtsdrWBuqeTO68BUqY7zTx3
 2LDbzX3xpCt1qa1OzwdK3JyPTevPr9kFA3S754BJsGtmD6nVobXwdJR9wmpL8w7bBTNlwlTHVk3
 CM6USYEJx9DYsPcWGeS3I2LChXVuYos4BqgoL5p/1wOuBvlm3P1t0/LMWRb3eBo9GUFjoKIrnrN
 rcEW2bsPhBx1vEJA9JdD8oFL00sW1GiSU1KIIKVqYu71VkFcEWtcoT60+r7wyeHHoqLLZ0JrCwp
 WKx5BRldLlipBvNlipDBrL8JgM79N4RtZEhVQGVYhJTwtia/t6LHph4zTFn6jh/W+N38ktIT20/
 w/IfLdB2T103rl3bbDRSkDPAHFLcmc8vSGLE9TyqcFP0gy/X7/odWKvz//CvQ0XNjEau9mjU0/M
 ONvcJYSl12V+VasTc5NnxOt04nfFYck1KnuGM4/jWeO5zk9KIhVHZMU50SD5dpWTU4N/cOVpGXd
 0L8BVi9UxI5fs8A==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset moves the v4 specific bits into version specific ops,
adds the v6 specific version ops and the compatible for X1E80100.

This patchset is dependent on:
[1] https://lore.kernel.org/all/20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Changes in v4:
- Moved out the mode setting to a different patchset [1]
- Switched to per-version functions approach, like Dmitry suggested
- Link to v3: https://lore.kernel.org/r/20231122-phy-qualcomm-edp-x1e80100-v3-0-576fc4e9559d@linaro.org

Changes in v3:
- The whole support for COM v6 register offsets has been reworked from scratch.
- The bindings now document the phy-type property. (dropped Krzysztof's R-b tag)
- New patch for adding PHY_TYPE_EDP into bindings header file.
- Link to v2: https://lore.kernel.org/r/20231122-phy-qualcomm-edp-x1e80100-v2-0-114e789f0195@linaro.org

Changes in v2:
- Added Krzysztof's R-b tag
- Re-worded commit message for bindings to suggest same PHY can work in
  both eDP and DP mode rather than being different PHY types.
- Implemented different qcom_edp_configure_ssc and
  qcom_edp_configure_pll for each version of the PHY.
- Dropped the cfg8 override in qcom_edp_phy_init
- Used enum instead of defines for PHY versions
- Link to v1: https://lore.kernel.org/r/20231122-phy-qualcomm-edp-x1e80100-v1-0-a9938990edb3@linaro.org

---
Abel Vesa (3):
      dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles
      phy: qcom: edp: Move v4 specific settings to version ops
      phy: qcom: edp: Add v6 specific ops and X1E80100 platform support

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   1 +
 drivers/phy/qualcomm/phy-qcom-edp.c                | 321 ++++++++++++++++++---
 2 files changed, 278 insertions(+), 44 deletions(-)
---
base-commit: f11d52ee9ab66205a0c9d1b936f6d9842e766bca
change-id: 20231122-phy-qualcomm-edp-x1e80100-a57c15fff32b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


