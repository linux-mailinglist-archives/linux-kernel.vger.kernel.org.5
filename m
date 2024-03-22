Return-Path: <linux-kernel+bounces-111233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0F88697E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE32828B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A421A2869A;
	Fri, 22 Mar 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2ZbBBL9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8AE20B27
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100569; cv=none; b=H42BYuSIEMRM1Fdhb+EUZtJ1PoS5CLaYId4PaA55/hQNjvAy+GKn2UWGQ65eviGEJNYyzecW7YfvyQJwfhODWtd31XgE4AcVq8Ey78N5AEhhUSZvJd+6dy6IlDPEO+iF6H1ekmhXmRJMw5WL54yR081YvjpMsSZRRCkauH3wDQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100569; c=relaxed/simple;
	bh=G8pd+NuPs5MqnbmyhqPPxvHeK1Ch8m4ANkNZoIRgcfs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o7e+ih7BGww63FqZuDoZt09/C6tD1N+rD5SNbAhHppbwPo8sd5G80LgQ2BYon2wKGfpxW2P526eP6vlv7jsBcIypFM3ZMVQrU0B7TJ/XqFmYapHWWrz/PnokzsU/vgHTu9JVkXTRdeOWduj/kf+8inKsLjMkTd7YzGtQzMDfKyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2ZbBBL9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4147d09eb8aso1670605e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711100565; x=1711705365; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4RXUamy+6CkwKat2pJqrkrmGSUlooaGAioyYCp0zXP4=;
        b=s2ZbBBL9SIn4ONIZnoOHtuj6cgUMjN1Ao8cP6ETe4GFeIbYxKp2673XmwerYU8UMo5
         JUXLxKZ35zIvO6ezwsCoPhZg909Unf4F++7eiNcGpG5Pel327IzR1nl6BCRofV3ac/9c
         t8G6mkEPpjsdh21V6Qr0fJJtvBE3Yf7tb9N1sPwfHY/VgAm7rsZELOwn7duyli2QbxaT
         Hc04hHJ8jsbkfoOSSqfEr3Q+7X8Iroh13AlDLdcy8LB9jjaFtvRuunuKUoxMtSuBaib9
         xz+qqeQrs0TkEctd7AC0h57yxRKpyJo2FynYJ+RSh++pOaON7p6M8ZoIx/mjMUBKebIZ
         0ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100565; x=1711705365;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RXUamy+6CkwKat2pJqrkrmGSUlooaGAioyYCp0zXP4=;
        b=LNzGDbHafZt8ZH09/KZFfq3dAbHJl6w6H2uEowecgQgEA2jRqs/ZAIwhkKxHiiWSNB
         Gxocvkm5nZJtiwTvJ/N7L0TndxtxTQffvkWr/IsK9WLjHCwrAoAJ3toRD7WeUbv9QllD
         MOdFaoUabnRtZI5TL/lhVEcVPFPtDfjKAs3q4dg+yd+KnpRsgHnWIizSiUEn/Ncfp2kq
         MaO4fU53rlnHB5HfjP+1MWTSO01u1j1bI1EdjBda9SFyP4a0xix2DC+xImmRfmfF/HWj
         D2eFvY4EpMIaxcF32JD8IPZfLb4wOru2zRNx7fDy39PiIvreHSFWklL7891XFGaaCvcV
         Reqg==
X-Forwarded-Encrypted: i=1; AJvYcCXeNQ6uZd1XSASZ5zxCXZyfDXh500848dBLY5QeKBAX8q/IDGTT3TqU95eUqs8pV/krBZpkyQ8BlX+AbXfWG40aTCCTd2102Mz4qart
X-Gm-Message-State: AOJu0Yy992judtmuc5A9OaULSD9mflifgx5ht4k+pOTRXbPBDcBE9UfB
	DKvvDI84ClsRlACL461WdN16P63/dgLYW8QNCnb0KQj+DhiCfDz+gMuW25jJtU4=
X-Google-Smtp-Source: AGHT+IFvFez6XpEdmElSBdTd28NiEtgQWa0kTLpjpyGjYG+2mzUaQ/ueca7v5bEWNR5vKrFD70r4zg==
X-Received: by 2002:a05:600c:511c:b0:414:5ee1:76f0 with SMTP id o28-20020a05600c511c00b004145ee176f0mr1056656wms.25.1711100564758;
        Fri, 22 Mar 2024 02:42:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b0041461a922c2sm2547845wmq.5.2024.03.22.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:42:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/7] arm64: qcom-sm8[456]50: properly describe the PCIe
 Gen4x2 PHY AUX clock
Date: Fri, 22 Mar 2024 10:42:37 +0100
Message-Id: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI1S/WUC/53NSw6DIBSF4a2YO+5tAN+Ouo/GAQWqN1UhoEZj3
 HupS+jwP4PzHRCMJxOgSQ7wZqVAdoohbgmoXk6dQdKxQTCRsZTXOFtHCsNYbTnDxYXZGzmiU2S
 Qo+t3lMuGavhg9kpzXtQlK7WGeOe8edN2Uc82dk9htn6/5JX/1j+QlSPDWhS6lJlSumKPgSbp7
 d36DtrzPL8srLCR4QAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2765;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=G8pd+NuPs5MqnbmyhqPPxvHeK1Ch8m4ANkNZoIRgcfs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl/VKQY3StH+jEwpw0M1pXqo7GMpn11tZX0YBLeImy
 +tEzA+WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZf1SkAAKCRB33NvayMhJ0cmfD/
 43RVVhmBkKNKtrJqcw01/Ex2PuZ1/tEfhcU6tMva8RiVUTErXCkXoIh1vzmbewfzljQiwalOyS642/
 0U+uL2p4Lnd+rsEA6kAnUzo3poTCgpXSlw9GPpkYhS2zRisbv/iyp02K/xsommpzxhMWV7dcXRZyd/
 fdEl2BG2/na5UtKk1dUfnpbdD7fVTZCBykaDWw9swjEktvqmc/OEE6sx3YFQ2f9huFabPk4VxVqNOk
 UcD4QA/apXJmJxQ+8YJk+FYDyWODWWNNfAz5o6MXVLN7lKmbSUvH7IE0frTj+m26lXCx2URRtQCXPt
 y4R6stZiWkbP+vwUGbBJsGhya7P3Y3jZvIf5Eb6kttaEq9VjiVwD4gtxDI7c9DCKLCDhmOm3pB6TfG
 2fhBdvRkrxi/AE1TlcIPIMKZPhmqhfdVdRdDd7D79za/cGZyliJuXeKQEAefeFNTsmbCnoQa+E/vV9
 Zhdt8WxUbS8K2Q3zP0IT5c1TEffm6xLMXyKBregitQAs9osNyKHQcKFUbvHOl+Z8Yyv4LpYKn7SeQ1
 w6Hx02dAZe/spQT+zeuevepNGv8IgFpBC2FxZUr+QyV99/T4DGR9tS/eYxoUnAlsj+WINequ5j+/ud
 kFIVpkhTR6YIT4KgDItN9UugWUOdSwY284uccjQx/TpcEsqiX2P2RmPOlkwg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock named
"PHY_AUX_CLK" which is an input of the Global Clock Controller (GCC) which
is muxed & gated then returned to the PHY as an input.

Document the clock IDs to select the PIPE clock or the AUX clock,
also enforce a second clock-output-names and a #clock-cells value of 1
for the PCIe Gen4x2 PHY found in the SM8[456]50 SoCs.

The PHY driver needs a light refactoring to support a second clock,
and finally the DT is changed to connect the PHY second clock to the
corresponding GCC input then drop the dummy fixed rate clock.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Collected review tags
- Switched back to of_clk_add_hw_provider/devm_add_action_or_reset to maintain compatibility
- Tried to use generic of_clk_hw_onecell_get() but it requires to much boilerplate code
  and would still need a local qmp_pcie_clk_hw_get() to support the current #clock-cells=0
  when exposing 2 clocks, so it's simpler to just return the clocks in qmp_pcie_clk_hw_get()
- Link to v1: https://lore.kernel.org/r/20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org

---
Neil Armstrong (7):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document PHY AUX clock on SM8[456]50 SoCs
      phy: qcom: qmp-pcie: refactor clock register code
      phy: qcom: qmp-pcie: register second optional PHY AUX clock
      phy: qcom: qmp-pcie: register PHY AUX clock for SM8[456]50 4x2 PCIe PHY
      arm64: dts: qcom: sm8450: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
      arm64: dts: qcom: sm8550: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
      arm64: dts: qcom: sm8650: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk

 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 27 +++++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  8 +-
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts            |  4 -
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |  4 -
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |  8 --
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 13 +--
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts            |  4 -
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |  4 -
 arch/arm64/boot/dts/qcom/sm8650.dtsi               | 13 +--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 98 ++++++++++++++++++++--
 include/dt-bindings/phy/phy-qcom-qmp.h             |  4 +
 11 files changed, 133 insertions(+), 54 deletions(-)
---
base-commit: 2e93f143ca010a5013528e1cfdc895f024fe8c21
change-id: 20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-4b35169707dd

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


