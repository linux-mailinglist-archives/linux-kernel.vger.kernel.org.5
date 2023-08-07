Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743FC772EDA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjHGTfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjHGTf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:35:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D7C173E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:35:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so40435465e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436925; x=1692041725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LebC+myOlLmykS4W+Y7ctD4uKN283qPMgfMX9hv9nf8=;
        b=LA6Fl4t6AwvmgzmENpEmeB8dQNmCo2PrTio6WHxqkPaetvTgDdifxIXdA5l0uRPGIw
         fC6VroUhA9ADYeu0D7GYyAU8G/aMKLHrdHv1gg3/eNdWvw3tJnDEtLMz1xHkpcgHRCPQ
         Z9Glhim3LhfUCd0Qtn5xEsTINklbPDEbAsv/rQ37JP1qdSd6UsP55SYBRo1euKrOAgir
         ibTnEP6SBc4VSjqUoO7gZOHDBeV97n/9/jclcjmnXzYXd8B6WQcRhRr+Pmpb1ZucBWu2
         JPwtVeCwoFIeFdzuwGNnJwuFWrCnYU12Ct6vuC5SlgC0PnL0ihLPCHPiISf1/oLTn5Pw
         t48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436925; x=1692041725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LebC+myOlLmykS4W+Y7ctD4uKN283qPMgfMX9hv9nf8=;
        b=LMi3NrIisHKIr8p5rjAlaQvL/Cb4jBN38rWFLHBH9wiJJpSOxVU5Ylk1G/rWXF+2sU
         0948yBUjRi23gmp3i+l38A6hJ0eYgjorWP0j7aD2bTXBA7TVqvxZ6KSC0PqUiZbjaNCZ
         usMNTBGokn4KzGpkQ4ButyJaYqgViU41aaIxFcY1lZquK456+S4xS0GXDkdY6+DzVDx5
         Fq5GCXLFrNkWJ1w3pjBTuLMGamQvWzR8cV6HAvvr4hzxycB7caLFYQxGYAuj0SVuA7uC
         Nh1TjN5p9O9KBQgWPsGdxBQoyNAFCUN5FD9ggk1v6gec9t4lQ8fGoC/TF6g+fA1rLI35
         Ne9w==
X-Gm-Message-State: AOJu0YxvqkmPip1Bh85Q4d+pGWq18u3ORGQ8OXAq46JB1IoFROfd4fvx
        Vfw//6UN/NX1ByNeLaUKJjWeMQ==
X-Google-Smtp-Source: AGHT+IEa5xMYxzrMt+Lr/UP/jseRvhNem/bSlbwT2xHuhRdhe9LhTLnhVHPXAsLmaH5HAd4Ik3OhsA==
X-Received: by 2002:a05:600c:3641:b0:3fb:b1fd:4183 with SMTP id y1-20020a05600c364100b003fbb1fd4183mr7781173wmq.12.1691436924911;
        Mon, 07 Aug 2023 12:35:24 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm16061488wmc.0.2023.08.07.12.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:35:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6/9] arm64: dts: qcom: sa8775p-ride: index the first SGMII PHY
Date:   Mon,  7 Aug 2023 21:35:04 +0200
Message-Id: <20230807193507.6488-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807193507.6488-1-brgl@bgdev.pl>
References: <20230807193507.6488-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We'll be adding a second SGMII PHY on the same MDIO bus, so let's index
the first one for better readability.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 1c471278d441..55feaac7fa1b 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -263,7 +263,7 @@ vreg_l8e: ldo8 {
 
 &ethernet0 {
 	phy-mode = "sgmii";
-	phy-handle = <&sgmii_phy>;
+	phy-handle = <&sgmii_phy0>;
 
 	pinctrl-0 = <&ethernet0_default>;
 	pinctrl-names = "default";
@@ -279,7 +279,7 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		sgmii_phy: phy@8 {
+		sgmii_phy0: phy@8 {
 			compatible = "ethernet-phy-id0141.0dd4";
 			reg = <0x8>;
 			device_type = "ethernet-phy";
-- 
2.39.2

