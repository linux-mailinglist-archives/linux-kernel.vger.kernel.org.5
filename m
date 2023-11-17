Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC16A7EF86D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbjKQURr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjKQURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:17:45 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0EDA8;
        Fri, 17 Nov 2023 12:17:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9e2838bcb5eso341210766b.0;
        Fri, 17 Nov 2023 12:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700252260; x=1700857060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jO4FinG60TptnJlL0I/aBKs5ITFw+rqL2aoAvZdWzlg=;
        b=URIXmqwFFm/Oasuc+0e1EMPjIVCgLSKKLCl/Z+60Z7FQnrDS+hkG3zQ1kdn7RJVWCb
         kAcHXoxGoB7bIaTsuGvw7TBH9x+5uY6aCmqi57+HdIgsj2f9KSPq7heuSt9sAaHRZV8y
         Tx+hsBUagf3PpgDNtEiMSjWisdFmxWNt+bLjKZnM0JY3//eGTlDow9YOi3UuNBDoUPYP
         VEmLsi2uqaq8MDtbKVvU5j17G/x8XwWyAAV+yIi2mDRN6dt7Jn6XMC9xNKn3A8fHOVKc
         2eBWb/gUQTkec9jIU7+3zRlVk05Mi5aS8IdRhqeKHDkpfHaO2ap2eWd26nRJP45mlRoC
         1J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252260; x=1700857060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jO4FinG60TptnJlL0I/aBKs5ITFw+rqL2aoAvZdWzlg=;
        b=G8queFXYj+aGW/GKqq3hys340D2hC2fgwz4eJwgvSzrjc2eZJngc5pBDWYeFzoL/Bd
         JJbNAHLiDtpXrZ9hPUcAPm5oTeggi2VG/nX94ropNy8VgyVu/7Yq2fI4631CKeFp1TWf
         mN2vKDvWwOTM8K5z27Mrj452PYA/vXfva27maBwnQMW/ip7GckvwPnmm8OAduaHDBF5J
         T99vMnzVizAwT4NiB0HT9BP/VY/WwnCeSoJU+W3BLtoFXtuh1AAoIOkSyv3t5sYDaQog
         odfn0PfWC86y5vnSJSWzxf3pScnGX0l3QnLdl5lyDZj4Zp8W0fOMJ57KBnH7GUpBS+g9
         WZZA==
X-Gm-Message-State: AOJu0Yw0dTNRs1raqY0oltWdf168JgeUVxaLgtF7DELEfjh62hNFfjS0
        7fogxN3wsXMyyKFupnHtUj0=
X-Google-Smtp-Source: AGHT+IGBtBUbtAsV/vAYb+ntpU2hrBW9x5wudUtgIOuOFs8V1oWXMInP7DvsvQycY/b65fJ4JKgGWQ==
X-Received: by 2002:a17:906:2ce:b0:9e4:716:4e32 with SMTP id 14-20020a17090602ce00b009e407164e32mr147592ejk.11.1700252259887;
        Fri, 17 Nov 2023 12:17:39 -0800 (PST)
Received: from david-ryuzu.fritz.box ([188.195.169.6])
        by smtp.googlemail.com with ESMTPSA id e7-20020a1709062c0700b0099d804da2e9sm1130630ejh.225.2023.11.17.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:17:39 -0800 (PST)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>, hexdump0815@googlemail.com
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, David Wronek <davidwronek@gmail.com>
Subject: [PATCH v2 0/8] Add UFS support for SC7180/SM7125
Date:   Fri, 17 Nov 2023 21:08:32 +0100
Message-ID: <20231117201720.298422-1-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces UFS support for SC7180 and SM7125, as well as
support for the Xiaomi Redmi Note 9S.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
Changes in v2:
 - Fix device tree binding for QMP PHY
 - Separate ICE into its own node
 - Fix style problems in sc7180.dtsi

--
David Wronek (7):
  dt-bindings: crypto: ice: Document SC7180 inline crypto engine
  dt-bindings: ufs: qcom: Add SC7180 compatible string
  dt-bindings: phy: Add QMP UFS PHY compatible for SC7180
  dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
  phy: qcom: qmp-ufs: Add SC7180 support
  arm64: dts: qcom: sc7180: Add UFS nodes
  arm64: dts: qcom: sm7125-xiaomi-common: Add UFS nodes

Joe Mason (1):
  arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S

 .../devicetree/bindings/arm/qcom.yaml         |  1 +
 .../crypto/qcom,inline-crypto-engine.yaml     |  1 +
 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |  2 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |  2 +
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 69 +++++++++++++++++++
 .../boot/dts/qcom/sm7125-xiaomi-common.dtsi   | 16 +++++
 .../boot/dts/qcom/sm7125-xiaomi-curtana.dts   | 16 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |  3 +
 9 files changed, 111 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts

-- 
2.42.1

