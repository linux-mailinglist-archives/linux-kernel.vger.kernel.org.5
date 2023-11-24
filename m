Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869A37F7073
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbjKXJuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjKXJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:50:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A0110EB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:05 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a02d91ab199so233816466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819404; x=1701424204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpyMkj9rIOxFufcTixULVIGcsYSV0aiDmd49Bw6R3/g=;
        b=P28ZUuDABaWgCVP8QMll4OdkFrI8nCp71hECCok2McoozZh8oTTolyYkhl3KejoGv9
         Mn00wiBZrCzHKtzvXXcX0Z8PofJTXFjuWb4B49XOvK6CH+5If5IKPQpcbhsAxhNZby0w
         Bbqch2DYmU60zNNAOPxllcsgFK5eA9TwDpbb7y22I4qPeVtaLwovVvEqLYBZ8h35KgWN
         5vtefFlouicLgKTrcvsCkhpuk3vgLrTeJqGgIVb4C6o54X0WeLaCKbCWcK+lTJMgRP3+
         st+3DqZcAxToajvvA2Lr3P+0fMLB2Ee4r5fI6f1EFdzbuR7esyaLu7d2MzC+BX1fqqIq
         6BBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819404; x=1701424204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpyMkj9rIOxFufcTixULVIGcsYSV0aiDmd49Bw6R3/g=;
        b=EzLm0tJ9UcrVnpB7HFo/EyeMRvEU1R6eNGdEv4uby0wSxJS05ZGqINRYC7pl7SJHM+
         dFCQhxI0C/XpaEoF5a4Xf9SnuuZcHBQbMfL6Ob+3JMuupPO0rcqUtx7T/44UR5YfzpAl
         gE/xxl8AHuxc7AfsMu9OdOEqOzP9fcfDtaWwgXyuAzyTLzVeNVAv3XM9YpUIKPbGUHy3
         +ZRHUsT6+BlKF1GVRcxV1ZFndS/vBG/p0cffI3b+kUDAafPNvMcuRRaXFGT8hmn0a5D3
         cKTagreIMyr55M5r9lpSYF/tHP2bAS81/ds/RqWFE+FWFmMYdsO2Th/la31sqeFXXVge
         /Wzw==
X-Gm-Message-State: AOJu0YwXBempQlZOT2L4iYsrl+zmsNaGJ5XHd7LfMz7CiIUZtDc3xLMO
        DE3QlV4YKLFmenjAs+api78qeA==
X-Google-Smtp-Source: AGHT+IE44CvRd7huP5K1kbKioWOYzZq53bZNxLqU10LfWLL1Nl2hIXqt10gjOxDR28df2LaDRVHVkg==
X-Received: by 2002:a17:907:2993:b0:a00:185a:a150 with SMTP id eu19-20020a170907299300b00a00185aa150mr1074654ejc.38.1700819404352;
        Fri, 24 Nov 2023 01:50:04 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b009fd727116b4sm1839941eji.129.2023.11.24.01.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:50:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] ARM: dts: ti: keystone: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:49:59 +0100
Message-Id: <20231124095000.58487-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi  | 6 +++---
 arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts     | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi  | 6 +++---
 arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts    | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi | 6 +++---
 arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi  | 6 +++---
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi
index bff73a0ed10b..5c88a90903b8 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi
@@ -36,9 +36,9 @@ queue-pools {
 		qpend {
 			qpend-0 {
 				qrange = <658 8>;
-				interrupts =<0 40 0xf04 0 41 0xf04 0 42 0xf04
-					     0 43 0xf04 0 44 0xf04 0 45 0xf04
-					     0 46 0xf04 0 47 0xf04>;
+				interrupts = <0 40 0xf04 0 41 0xf04 0 42 0xf04
+					      0 43 0xf04 0 44 0xf04 0 45 0xf04
+					      0 46 0xf04 0 47 0xf04>;
 			};
 			qpend-1 {
 				qrange = <528 16>;
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts
index 7bfc80f1af26..f0ddbbcdc972 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts
@@ -9,7 +9,7 @@
 #include "keystone-k2g.dtsi"
 
 / {
-	compatible =  "ti,k2g-evm", "ti,k2g", "ti,keystone";
+	compatible = "ti,k2g-evm", "ti,k2g", "ti,keystone";
 	model = "Texas Instruments K2G General Purpose EVM";
 
 	memory@800000000 {
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi
index f6306933ff42..7109ca031617 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi
@@ -37,9 +37,9 @@ queue-pools {
 		qpend {
 			qpend-0 {
 				qrange = <77 8>;
-				interrupts =<0 308 0xf04 0 309 0xf04 0 310 0xf04
-					     0 311 0xf04 0 312 0xf04 0 313 0xf04
-					     0 314 0xf04 0 315 0xf04>;
+				interrupts = <0 308 0xf04 0 309 0xf04 0 310 0xf04
+					      0 311 0xf04 0 312 0xf04 0 313 0xf04
+					      0 314 0xf04 0 315 0xf04>;
 				qalloc-by-id;
 			};
 		};
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
index 206df8a8d9dd..8dfb54295027 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
@@ -10,7 +10,7 @@
 #include "keystone-k2hk.dtsi"
 
 / {
-	compatible =  "ti,k2hk-evm", "ti,k2hk", "ti,keystone";
+	compatible = "ti,k2hk-evm", "ti,k2hk", "ti,keystone";
 	model = "Texas Instruments Keystone 2 Kepler/Hawking EVM";
 
 	reserved-memory {
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi
index 8a421c65f920..c2ee775eab6a 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi
@@ -49,9 +49,9 @@ queue-pools {
 		qpend {
 			qpend-0 {
 				qrange = <658 8>;
-				interrupts =<0 40 0xf04 0 41 0xf04 0 42 0xf04
-					     0 43 0xf04 0 44 0xf04 0 45 0xf04
-					     0 46 0xf04 0 47 0xf04>;
+				interrupts = <0 40 0xf04 0 41 0xf04 0 42 0xf04
+					      0 43 0xf04 0 44 0xf04 0 45 0xf04
+					      0 46 0xf04 0 47 0xf04>;
 			};
 			qpend-1 {
 				qrange = <8704 16>;
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi
index 5ec6680a533d..1afebd7458c1 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi
@@ -36,9 +36,9 @@ queue-pools {
 		qpend {
 			qpend-0 {
 				qrange = <658 8>;
-				interrupts =<0 40 0xf04 0 41 0xf04 0 42 0xf04
-					     0 43 0xf04 0 44 0xf04 0 45 0xf04
-					     0 46 0xf04 0 47 0xf04>;
+				interrupts = <0 40 0xf04 0 41 0xf04 0 42 0xf04
+					      0 43 0xf04 0 44 0xf04 0 45 0xf04
+					      0 46 0xf04 0 47 0xf04>;
 			};
 			qpend-1 {
 				qrange = <528 16>;
-- 
2.34.1

