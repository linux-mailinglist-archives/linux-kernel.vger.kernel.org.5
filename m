Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4472A77E0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244912AbjHPLwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244899AbjHPLwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:52:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA2F2121
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:52:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so58454865e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692186722; x=1692791522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gfwLJHeXq1r3D11R/xOSfSzEcmiqa5uyfuPQt3SmpI=;
        b=LEu7DaJ6/W6HEKpjQqhCfrzlmeUJEg+Uwq9V7LmfIgR0ZmPZsr3B0eaLixEkAI6hzI
         5IRz5jD3aITjms8MV86DveXJP2kmAKhl8r1SRy0g1mpadYIWjDgLEGidtzV1oNmm9sGn
         Ke2HTahRAFczgELwSu4aK6uRxDU07xORFLMxMdG9Ka3VM8aVqSAScUU8adRu9a9+9AtS
         4np4612imfC84tYlOoosDjxY6heiJmsEBFaEFz2UeYCU1tKGVdwLYmR8i6Et1C7FHU/D
         t5OsH2gWqMs7mLA2KA1fDiNm5ZL2VRp00oySc2i38xGlDWqLMMzDjCvzQ8yF8x0JwVGn
         Ng7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692186722; x=1692791522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gfwLJHeXq1r3D11R/xOSfSzEcmiqa5uyfuPQt3SmpI=;
        b=Wd8cnTZYD6Jv8GfgPBqX+mUEdK6JRPoeBqXESl6lo08HCmezRsD4PavlWACH/cE6vA
         spvWKz2MMVFLjFZmjeO5SViSptz5oaFjI0IoWOXzMJktjGqT1sN6Yvg4EqQhC//b3med
         ljuYRB6gmaaJz0eZR2fT2x+faAxRUvl8xPuQx2HEODu20sgFw7ojN/TQtGMJJNvwQCZb
         DLahAR7v8QtKUUicUmx5A8YYbaWhJqibySkaw2Ilg7ktedPngZlefO0inxK0xdt4z+8M
         v8M4E7VpYB/YmC+M3URRLe70yMv6AJADd9+4uCNSC7vzDLJahA187f52KzP/9EhBOnIw
         IWYg==
X-Gm-Message-State: AOJu0Yx7BK0MKzq12wJaAFkMxRNLtf784Z3d9QH86lBeurGDYhVoiAJY
        8bGC7PmTlV1zjXlnWf6SoB1TYw==
X-Google-Smtp-Source: AGHT+IFQKJ680LNckCDPVIoFQksMzyH5xIITwYP1ML9Nuk0oOLaVn7BDnACWSmdXA0n9BMVoGvpTgQ==
X-Received: by 2002:a05:600c:228d:b0:3fb:fca1:1965 with SMTP id 13-20020a05600c228d00b003fbfca11965mr1093292wmf.18.1692186721984;
        Wed, 16 Aug 2023 04:52:01 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id fk3-20020a05600c0cc300b003fc05b89e5bsm21280663wmb.34.2023.08.16.04.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:52:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        sboyd@kernel.org, luca.weiss@fairphone.com
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/7] arm64: dts: qcom: qrb5165-rb5: Switch on TCPM usb-role-switching for usb_1
Date:   Wed, 16 Aug 2023 12:51:50 +0100
Message-ID: <20230816115151.501736-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816115151.501736-1-bryan.odonoghue@linaro.org>
References: <20230816115151.501736-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch on usb-role-switching for usb_1 via TCPM. We need to declare
usb-role-switch in &usb_1 and associate with the remote-endpoint in TCPM
which provides the necessary signal.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 19 ++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi     |  4 ++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 55389f8903b5c..3e34f4e2af14a 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1269,7 +1269,12 @@ &usb_1 {
 };
 
 &usb_1_dwc3 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	usb-role-switch;
+};
+
+&usb_1_role_switch_out {
+	remote-endpoint = <&pm8150b_role_switch_in>;
 };
 
 &usb_1_hsphy {
@@ -1358,5 +1363,17 @@ connector {
 					 PDO_FIXED_DUAL_ROLE |
 					 PDO_FIXED_USB_COMM |
 					 PDO_FIXED_DATA_SWAP)>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				pm8150b_role_switch_in: endpoint {
+					remote-endpoint = <&usb_1_role_switch_out>;
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c79173504a3fd..733de2fd5e753 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3780,6 +3780,10 @@ usb_1_dwc3: usb@a600000 {
 				snps,dis_enblslpm_quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
+
+				port {
+					usb_1_role_switch_out: endpoint {};
+				};
 			};
 		};
 
-- 
2.41.0

