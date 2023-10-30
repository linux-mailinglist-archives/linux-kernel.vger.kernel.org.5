Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E0F7DB69B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjJ3Jt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjJ3Jsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:48:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BC910D1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:48:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso2928570f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698659302; x=1699264102; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPTZJaV/MjL39+P4h6OmYZujDec2OSDGxnH10oBPzHE=;
        b=eFMSckd0/jLbQXb/2AC3TIJ38GlssXXI9Ue8ucbscKvRoB5q/flk6Z2mzVAmjZaTHD
         x9LHViXpzEwik3JgQdB6v6ikTkFH3Nu+Q00/JbbeVyLzoozhY+iIVH36Lgdc6HewEfij
         Ict3rtMzRq6ZOdbarrgprTatJ+KsJgzr662KzuFPvmBDIwWorBlFlX5IyMGchf0uwyCG
         lJsu1C2CsACzcgjTqD1OxBF4SN5TZk3F4ZBopek5tfU6C8jFTg0vxkE5TkNKrAPLclOz
         R5uWfDv1KFUgftkhCA3yUWjJNf8xUIHOE81Gw+RIjiROIGKNTEbq3fKSGV6DECYKsXKM
         XnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659302; x=1699264102;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPTZJaV/MjL39+P4h6OmYZujDec2OSDGxnH10oBPzHE=;
        b=QlkTQ5wVRakztrztfWtENk2KBA/JoPW6opSDaul4i1fHgyGKH+h1XssNJ4Fgplia56
         Trd1RDgxr8x9ofkdOuhncdLWfamQEFXierliKre+QU66uZvbYboyrw//xw+Og686EAiX
         X7gNoTz8VkLkjrD+u3k+csVlr/cTiEqY4V5z/Hojv3GGvZHdZxCxbVlOL1EE9eCe10h0
         OhQ7Y028dHlYCHFzK4alyRu55ZX/R5WFAWVTxnTuj9Ts59/T+qv9trJvRc/3ivYqaKgx
         EQNr9W7Dy8hJaYVZ/e6aV82ccpt99i+EnD1iCLPWMMCXaljoVJtvQFZsFYcBqBQw4Z9g
         wmHw==
X-Gm-Message-State: AOJu0Ywpw+Dyqc+mFmefcHLS+IGlyI5Mcspz9V6ENEhlAYrhfthmY7tJ
        bz6qq1I3PLQj76mljq0yKWiV0Q==
X-Google-Smtp-Source: AGHT+IEi+2EnChCdXuC4BZnLb291jlsE8CMuY5f+RKFa/FzCVHA6umqZ7slvZXuTl1qatU8X6D5bTA==
X-Received: by 2002:a5d:588f:0:b0:32f:7e4e:535d with SMTP id n15-20020a5d588f000000b0032f7e4e535dmr4565173wrf.15.1698659302024;
        Mon, 30 Oct 2023 02:48:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d444e000000b0031980294e9fsm7854256wrr.116.2023.10.30.02.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:48:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/7] phy: qcom: Introduce PCIe, UFS & USB PHY support
 for SM8650
Date:   Mon, 30 Oct 2023 10:48:16 +0100
Message-Id: <20231030-topic-sm8650-upstream-phy-v2-0-a543a4c4b491@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOB7P2UC/32NQQ6CMBBFr0Jm7Zh2gAquvIdhQWqBSYQ2UyQSw
 t2txLXL95P/3gbRCbsI12wDcQtH9lMCOmVgh3bqHfIjMZCiXCttcPaBLcaxMqXCV4izuHbEMKx
 YKzKqoK6mooL0D+I6fh/ue5N44Dh7WY/Uor/rz0rlH+uiUaHR+SXVS1K2uD15asWfvfTQ7Pv+A
 VMar0zDAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2164;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=P+sEQT2Rv1FEwMjfBQ01O/6OblFcpIJuA1P/WnguyMc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP3vhUQVNRQTirHoI4ASs8izOOUwzDBGyfp5VSXYs
 TPF2zoqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT974QAKCRB33NvayMhJ0S8iEA
 CuqKVtPX8PmzsPKVHBPLVuzhDgroORz8sE72lh4OKElFlUNHHxoOHINYb4ovPfZRgI5OCrmcDxAGNX
 YF8G66klpXUREC/Csw/e52IfnnQe1Nf8F4hYu2UovITfjzwK2gon5mxZuvC2/zNGnltz2/8wy2NCOm
 bDYHHDgILnxi1FM747iRJs1NyfJ8BWGbTTo4a7b/y+H9XM759nY8kigheM6/QqL4ky0I8YwAoDBiXC
 9JycmtxsUsW63RLLmkIMZti8wmFcRBcsBLxC67XAxaHAYxqrXeRdSRGSRubZjSlUJ2eCCf+gYmC3vT
 JmUVuUN42fo+J0wEKN6tdkzi4YCZkLkCsfsLDA4zebASWoAu6LmRmrTQceVK7SNQYGFRYue0MVuejt
 XkeDFulmOEc4sTUS/73A95/9RJNKrdkXndNIaBUGlW+kHHzGgvy/d4e/Vzpcg1eeDw1dz20soCf681
 B0dj3+J2VEu1q6989TJGUt5NzcdX8tbjopn6qsJCI0BcZTIqOlPChWv2UyMLXfVPLNYYecJAQTdyJT
 xKQOQImrYoOHIVIhQui6jpSGbImts5ncT5xp3/+e97cfqeo/5ATxXCRXslRrlDFd5pr8freekAI8ST
 MjWxhrxzTy/Sk8us5yhyst3/+Nwdm1ld/6K1cjo2OGaRBZMQMVLnMsmEUauA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8650 PHYs are similar to very close to the ones found
on the SM8550 platform.

Only a few changes in the init tables are required for the
UFS, PCIe and USB3/DP Combo PHYs.

The Synopsys eUSB2 PHY is the same as SM8550, so only a fallback
is added in the bindings.

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- bindings: Add missing sm8650 entry in allOf:if:then
- Collected reviewed-by tags from Dmitry
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org

---
Neil Armstrong (7):
      dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: document the SM8650 QMP UFS PHY
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document the SM8650 QMP PCIe PHYs
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: document the SM8650 QMP USB/DP Combo PHY
      dt-bindings: phy: qcom,snps-eusb2: document the SM8650 Synopsys eUSB2 PHY
      phy: qcom: qmp-ufs: add QMP UFS PHY tables for SM8650
      phy: qcom: qmp-pcie: add QMP PCIe PHY tables for SM8650
      phy: qcom: qmp-combo: add QMP USB3/DP PHY tables for SM8650

 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  5 ++
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |  2 +
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |  2 +
 .../bindings/phy/qcom,snps-eusb2-phy.yaml          |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  4 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 65 ++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |  1 +
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  7 ++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 86 ++++++++++++++++++++++
 9 files changed, 173 insertions(+)
---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-phy-9026042f9248

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

