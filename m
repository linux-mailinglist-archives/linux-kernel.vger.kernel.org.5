Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48DD812DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443786AbjLNKxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443780AbjLNKwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:52:54 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A26126
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:52:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c2a444311so76939465e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551174; x=1703155974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uni2IevXVLxWfb8CoVcIQYuHYfYSTP7QTj2/YzSprck=;
        b=GO+aZo3RWFDSo5tZ2ULlCkNMhOx2dZxSfN30vKiOzxIBML6P8IKVVXAmpv5jsjPbLy
         q2u6SNwmPBZWETwM1jIalirh+M3JTP6RjUAIfJE9bPp496d2J9Qqt6t4bf1hzQ3kxk+1
         XJKgUnViYwWrZmbfev5uorBqKluIGqmhOn6r5zdL6BcZvscAmX+bU/SAmP6m/htKHFk3
         N1pvU7FK++i54OQCgiSvqxL3/5lTOgGamfAdZld8+UO6MMj0I1OK1JgmJFP9K17d/DfP
         XK4KtputzM8dlIE0a5h/srmgoSl8ykxswjd7GwKGAZS2Xiw++DWuP++nYdNL4WgdZ2lz
         Xl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551174; x=1703155974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uni2IevXVLxWfb8CoVcIQYuHYfYSTP7QTj2/YzSprck=;
        b=PXeL2Oq361xCVUUynaDX2mTokAjh5bQI33Q9GnTW+4Axnqo/6lrPdi1VJ0nFtPcLGO
         tdkBvhZEuI3Dx1UwWqCgfdaReektyh/U+n2AESM/jUpobGbOq6Z0nKpdxNpNOj3knA+m
         XdLM3GVaZFe4tOkZmaBHHSRhjEl9mCH1pc0/lnaSj9x70NEfIXdIMsw7RCTljeE1dysN
         YJsck6NXGiIvH3S+RMrNb+Cgi91Y0qSVx405rbEjDq7+lzkWe2lS1fwiKpHMLRgYOogM
         g8Sy6KmUe5T4aHvgrQ2apP8cLQe1jKeQTunwjCPFIqM6A4yQDJcshfp6C3efx1f5tLn0
         eMJw==
X-Gm-Message-State: AOJu0YycW0eaOlf9WxlFKMWuvnlCNhuMGXoTOuPu0erEg7Dxe3sD4edV
        Rn1iWgiu1g4juFFs/Capvfi8ig==
X-Google-Smtp-Source: AGHT+IF/dpPnC1aOyxsiIUbpq+FHwoAHeLKTjdup8H0ycPqMEYCePvIF5ZRoGWvsLq6ZxBMBrAWDWg==
X-Received: by 2002:a05:600c:917:b0:40b:4b67:3028 with SMTP id m23-20020a05600c091700b0040b4b673028mr2492400wmp.34.1702551173928;
        Thu, 14 Dec 2023 02:52:53 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:52:53 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org
Cc:     andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 02/13] dt-bindings: clock: google,gs101-clock: add PERIC0 clock management unit
Date:   Thu, 14 Dec 2023 10:52:32 +0000
Message-ID: <20231214105243.3707730-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-schema documentation for the Connectivity Peripheral 0 (PERIC0)
clock management unit.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/clock/google,gs101-clock.yaml    | 25 +++++-
 include/dt-bindings/clock/google,gs101.h      | 86 +++++++++++++++++++
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
index 3eebc03a309b..ba54c13c55bc 100644
--- a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
@@ -30,14 +30,15 @@ properties:
       - google,gs101-cmu-top
       - google,gs101-cmu-apm
       - google,gs101-cmu-misc
+      - google,gs101-cmu-peric0
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   clock-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   "#clock-cells":
     const: 1
@@ -88,6 +89,26 @@ allOf:
             - const: dout_cmu_misc_bus
             - const: dout_cmu_misc_sss
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: google,gs101-cmu-peric0
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24.576 MHz)
+            - description: Connectivity Peripheral 0 bus clock (from CMU_TOP)
+            - description: Connectivity Peripheral 0 IP clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_cmu_peric0_bus
+            - const: dout_cmu_peric0_ip
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/clock/google,gs101.h b/include/dt-bindings/clock/google,gs101.h
index 21adec22387c..7d7a896416a7 100644
--- a/include/dt-bindings/clock/google,gs101.h
+++ b/include/dt-bindings/clock/google,gs101.h
@@ -389,4 +389,90 @@
 #define CLK_GOUT_MISC_WDT_CLUSTER1_PCLK			73
 #define CLK_GOUT_MISC_XIU_D_MISC_ACLK			74
 
+/* CMU_PERIC0 */
+/* CMU_PERIC0 MUX */
+#define CLK_MOUT_PERIC0_BUS_USER			1
+#define CLK_MOUT_PERIC0_I3C_USER			2
+#define CLK_MOUT_PERIC0_USI0_UART_USER			3
+#define CLK_MOUT_PERIC0_USI14_USI_USER			4
+#define CLK_MOUT_PERIC0_USI1_USI_USER			5
+#define CLK_MOUT_PERIC0_USI2_USI_USER			6
+#define CLK_MOUT_PERIC0_USI3_USI_USER			7
+#define CLK_MOUT_PERIC0_USI4_USI_USER			8
+#define CLK_MOUT_PERIC0_USI5_USI_USER			9
+#define CLK_MOUT_PERIC0_USI6_USI_USER			10
+#define CLK_MOUT_PERIC0_USI7_USI_USER			11
+#define CLK_MOUT_PERIC0_USI8_USI_USER			12
+
+/* CMU_PERIC0 Dividers */
+#define CLK_DOUT_PERIC0_I3C				13
+#define CLK_DOUT_PERIC0_USI0_UART			14
+#define CLK_DOUT_PERIC0_USI14_USI			15
+#define CLK_DOUT_PERIC0_USI1_USI			16
+#define CLK_DOUT_PERIC0_USI2_USI			17
+#define CLK_DOUT_PERIC0_USI3_USI			18
+#define CLK_DOUT_PERIC0_USI4_USI			19
+#define CLK_DOUT_PERIC0_USI5_USI			20
+#define CLK_DOUT_PERIC0_USI6_USI			21
+#define CLK_DOUT_PERIC0_USI7_USI			22
+#define CLK_DOUT_PERIC0_USI8_USI			23
+
+/* CMU_PERIC0 Gates */
+#define CLK_GOUT_PERIC0_IP				24
+#define CLK_GOUT_PERIC0_PERIC0_CMU_PERIC0_PCLK		25
+#define CLK_GOUT_PERIC0_CLK_PERIC0_OSCCLK_CLK		26
+#define CLK_GOUT_PERIC0_D_TZPC_PERIC0_PCLK		27
+#define CLK_GOUT_PERIC0_GPC_PERIC0_PCLK			28
+#define CLK_GOUT_PERIC0_GPIO_PERIC0_PCLK		29
+#define CLK_GOUT_PERIC0_LHM_AXI_P_PERIC0_I_CLK		30
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_0		31
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_1		32
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_10		33
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_11		34
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_12		35
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_13		36
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_14		37
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_15		38
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_2		39
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_3		40
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_4		41
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_5		42
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_6		43
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7		44
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_8		45
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_9		46
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_0		47
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_1		48
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_10		49
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_11		50
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_12		51
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_13		52
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_14		53
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_15		54
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_2		55
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_3		56
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_4		57
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_5		58
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_6		59
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_7		60
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_8		61
+#define CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_9		62
+#define CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0		63
+#define CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_2		64
+#define CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0		65
+#define CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_2		66
+#define CLK_GOUT_PERIC0_CLK_PERIC0_BUSP_CLK		67
+#define CLK_GOUT_PERIC0_CLK_PERIC0_I3C_CLK		68
+#define CLK_GOUT_PERIC0_CLK_PERIC0_USI0_UART_CLK	69
+#define CLK_GOUT_PERIC0_CLK_PERIC0_USI14_USI_CLK	70
+#define CLK_GOUT_PERIC0_CLK_PERIC0_USI1_USI_CLK		71
+#define CLK_GOUT_PERIC0_CLK_PERIC0_USI2_USI_CLK		72
+#define CLK_GOUT_PERIC0_CLK_PERIC0_USI3_USI_CLK		73
+#define CLK_GOUT_PERIC0_CLK_PERIC0_USI4_USI_CLK		74
+#define CLK_GOUT_PERIC0_CLK_PERIC0_USI5_USI_CLK		75
+#define CLK_GOUT_PERIC0_CLK_PERIC0_USI6_USI_CLK		76
+#define CLK_GOUT_PERIC0_CLK_PERIC0_USI7_USI_CLK		77
+#define CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK		78
+#define CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK		79
+
 #endif /* _DT_BINDINGS_CLOCK_GOOGLE_GS101_H */
-- 
2.43.0.472.g3155946c3a-goog

