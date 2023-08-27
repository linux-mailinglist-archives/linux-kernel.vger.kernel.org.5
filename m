Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA75B789DE5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjH0M3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 08:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjH0M2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 08:28:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6DF186
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 05:28:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bed101b70so282537466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693139327; x=1693744127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcVnzZ8MSOPSpFPMNqTfyeOLJhI+g+xFMbAA/QR3NNQ=;
        b=bQ+/of5oF4QEdpOByeDf+hUPyIAkVs/qAY5Dll4xIBx1/X5zD/K7itkdW4SXt9Mf5+
         UVsO0tV9n8BpMvZXBVYzpWjS1b98/BXM1Y8mhxXc+oHyVEBS6yNWLGlB8ftmhKjtXfrO
         sziU9lT/rNKxgNSlfp5Yothn2G1HaWRPM2kRhuxBpSQJqWa50OheIU3mUCavnIHgQuBp
         pK3OUPXYAUmXuqscR2dF82FrqvTBf2HSAHb9/RLdiSxqFuinTP4jUIkd3hMeuOJ4VzBq
         kKjKWVC06ogVdmqAUfX6aGlGG6P0JpVGu4jKDJmGQbXdCRMjjLi7o6mKgrv1u/PgsVq3
         NEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693139327; x=1693744127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcVnzZ8MSOPSpFPMNqTfyeOLJhI+g+xFMbAA/QR3NNQ=;
        b=L29aX3+BJLKCal9LsDWSWNhRwUAQkVmnuYCMSbo14qz4XSd4KZAUtqJqySLDf30GdK
         HETNueigCeGAA2AqfwQcqiLQA9i1DmlWjIFKEW841CRazkOjmsRr74sTIIuk6bj1manj
         Yoaor+1dLCjqNg5ez060prrvdDISgzGTo7cdPwMTRTthZGKL8l4aAtFofvMEO+yjbnIe
         pmjYgurDjeDrsfAfT/xsfGxG6swKrObV8mChhi6gq0V2ox2ns1CZwk2VFKnlexaccfD2
         qTM8pzmvIFA6FFZrtParVk+WFlDx8HvrQe26/k3yTQKWu2qaVWqjtzVj9QKL0OhkEujA
         o6QQ==
X-Gm-Message-State: AOJu0Yx3R1kxy4ZKYsj0ZHaU1AQvnFp0OYzQGxqM7O59QYfqkJ7nP8gp
        xf4tlrShqlaTfIv4XUTsFLhUgg==
X-Google-Smtp-Source: AGHT+IEaBWj4HoPwemXMp4e33SXcx4jTCKmnqkv2bgAxXf5aahwtKV9mCr+u6fWN5pWjvuQHS3nmXw==
X-Received: by 2002:a17:907:7888:b0:9a2:25a6:a42f with SMTP id ku8-20020a170907788800b009a225a6a42fmr7433519ejc.19.1693139326658;
        Sun, 27 Aug 2023 05:28:46 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id rp25-20020a170906d97900b00993150e5325sm3384826ejb.60.2023.08.27.05.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 05:28:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 3/3] arm64: dts: qcom: sm7225-fp4: Revert "arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695 haptics"
Date:   Sun, 27 Aug 2023 14:28:42 +0200
Message-Id: <20230827122842.63741-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827122842.63741-1-krzysztof.kozlowski@linaro.org>
References: <20230827122842.63741-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 413821b7777d062b57f8dc66ab088ed390cbc3ec because it
was never reviewed, was buggy (report from kernel test robot:
https://lore.kernel.org/all/202204090333.QZXMI2tu-lkp@intel.com/) and
used undocumented, broken bindings.  Half of the properties in this
device are questioned, thus adding DTS node causes only errors and does
not make the device usable without the bindings and driver part:

  sm7225-fairphone-fp4.dtb: haptics@5a: failed to match any schema with compatible: ['awinic,aw8695']
  sm7225-fairphone-fp4.dtb: haptics@5a: awinic,tset: b'\x12' is not of type 'object', 'array', 'boolean', 'null'
  sm7225-fairphone-fp4.dtb: haptics@5a: awinic,r-spare: b'h' is not of type 'object', 'array', 'boolean', 'null'

Since bindings were abandoned (4 months since review), revert the commit
to avoid false sense of supporting something which is not supported.

Cc: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    | 28 +------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 18171c5d8a38..568165f4f9e4 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -386,36 +386,10 @@ &i2c8 {
 };
 
 &i2c10 {
-	clock-frequency = <400000>;
-	status = "okay";
-
 	/* PM8008 PMIC @ 8 and 9 */
 	/* PX8618 @ 26 */
 	/* SMB1395 PMIC @ 34 */
-
-	haptics@5a {
-		compatible = "awinic,aw8695";
-		reg = <0x5a>;
-		interrupts-extended = <&tlmm 85 IRQ_TYPE_EDGE_FALLING>;
-		reset-gpios = <&tlmm 90 GPIO_ACTIVE_HIGH>;
-
-		awinic,f0-preset = <2350>;
-		awinic,f0-coefficient = <260>;
-		awinic,f0-calibration-percent = <7>;
-		awinic,drive-level = <125>;
-
-		awinic,f0-detection-play-time = <5>;
-		awinic,f0-detection-wait-time = <3>;
-		awinic,f0-detection-repeat = <2>;
-		awinic,f0-detection-trace = <15>;
-
-		awinic,boost-debug = /bits/ 8 <0x30 0xeb 0xd4>;
-		awinic,tset = /bits/ 8 <0x12>;
-		awinic,r-spare = /bits/ 8 <0x68>;
-
-		awinic,bemf-upper-threshold = <4104>;
-		awinic,bemf-lower-threshold = <1016>;
-	};
+	/* awinic,aw8695 @ 5a */
 };
 
 &ipa {
-- 
2.34.1

