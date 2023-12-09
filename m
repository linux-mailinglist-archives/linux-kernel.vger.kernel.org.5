Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C180B80B598
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjLIRbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjLIRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:31:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4D81710
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:30:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54f4b31494fso3649280a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143057; x=1702747857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nz0+QTmuWJpjrxtMkvTR4cUE7CkcEwzXWpj+dRMFNm0=;
        b=eXs0E3bM0nbHfDr6A9YGnrBBlcVTET25/SgHQLBlmpdpXZ5JT0TUZ+Aof5U9fmrs6M
         oE/IXYloFB2NblPqNqg1K8C6Ze0RUZgDYNLXFK+4j1H2AsbaTFZYBaQLXMfuk4Jf8C/P
         JqSL7oa2IbiDChRFelZaT0Qu17F2e0tcFnSczhIY1Ncuo+K/7+xz7o324KI3zSMjEicT
         jxt3ub1n+6laZk6lLqKCBQqiguumPaAMqzGUXqDHtWrdc8Q3d7ANGeDyG1+avpPFMCzs
         EaYUFueKHECxSvk4+Vp2u8LLCR/inbfCNFWWgRnEkfvRnJgS3q022atk+bpeTSjWve5u
         +P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143057; x=1702747857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nz0+QTmuWJpjrxtMkvTR4cUE7CkcEwzXWpj+dRMFNm0=;
        b=nEaorz2U0cEzWBRvPEBOalQMWcvtxku7M3SXrD/jC//WnAIYl9q7BUP2TrZLqt8s5v
         e6QpYwmKXiv9mXB6E4pI+GhH63p6eMq1nTjzr2WPQOke2STOpOMdvJJ9S7+BuxdjP2lY
         +eCbmFAl1LcE6FN0YKHzGI9irMPJlve+A4VbZWzd8DBc5CX66znYxFQkt7JbP+YlrrnE
         dkZFcFxqUXBoPM5dMDvriKZ+KnpiTKjhn6STx3icjL5P9s6dNWQnWs3PX2+BIeg23n0n
         n/m8v6YW3SqoD/Z1bI9G5hWNZSl3VwzGyRYpeZv0MoEqm7sTEv8qV6pTT2JpzjSYZoDh
         0D0A==
X-Gm-Message-State: AOJu0YxqbXCPVvVg/UcsrmZIBun6iDb/7ytS5qbXYJ5Ea41zK0D5W5Iu
        mWMVFjHuwJAwOWPukOkYdxxm0A==
X-Google-Smtp-Source: AGHT+IFUA1879uAgQjnkiufK8G7uVtyFCXn4vdxPJGq07KVbBpUZTzenvszTvQMf5dIP3RRgxsEDQA==
X-Received: by 2002:a50:8712:0:b0:54c:aa1c:205e with SMTP id i18-20020a508712000000b0054caa1c205emr1855782edb.17.1702143057414;
        Sat, 09 Dec 2023 09:30:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:30:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/15] arm64: dts: socfpga: stratix10: add unit address to soc node
Date:   Sat,  9 Dec 2023 18:30:37 +0100
Message-Id: <20231209173044.257684-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "soc" node has ranges with addresses, so it is should have unit
address  to fix dtc W=1 warnings like:

  socfpga_stratix10.dtsi:128.6-636.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested.
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi           | 2 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts      | 2 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 59075b958048..072fe20cfca0 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -144,7 +144,7 @@ qspi_clk: qspi-clk {
 		};
 	};
 
-	soc {
+	soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 5578196a2c9a..26173f0b0051 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -51,7 +51,7 @@ ref_033v: regulator-v-ref {
 		regulator-max-microvolt = <330000>;
 	};
 
-	soc {
+	soc@0 {
 		eccmgr {
 			sdmmca-ecc@ff8c8c00 {
 				compatible = "altr,socfpga-s10-sdmmc-ecc",
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index 4e73e6656d72..88e1afdb2583 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -51,7 +51,7 @@ ref_033v: regulator-v-ref {
 		regulator-max-microvolt = <330000>;
 	};
 
-	soc {
+	soc@0 {
 		eccmgr {
 			sdmmca-ecc@ff8c8c00 {
 				compatible = "altr,socfpga-s10-sdmmc-ecc",
-- 
2.34.1

