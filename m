Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3493D80B592
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjLIRbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjLIRau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:30:50 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E4A10E7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:30:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54cfb03f1a8so4147604a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143055; x=1702747855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMHzi0J79reXquigIs38sIEcotTqteBVvUo2J65iMZM=;
        b=A78nVxSRJY/3eK/SifI0hdtaASHaEBFb89W9j73t4n7qigQV/vT0YxNPXrGKWWnJ1e
         SIz0KEEVgX6zbYrGl2yakAGwpdfLyzpU4/EGPkwJL9a6by0Zcdh7+9hlWZCXXYZlNxC+
         DU1I9n9NCXXbt2Rp8MRIf7c/QQD1w6AgFEo6XlAlbd7Ydv4QGcx14ojDBxyUwjvV8KI6
         wPb2XnAFmAQBu3luG6vGavLMj6/IUOzT58wBU8VNinyq2vMVgbgABz1Ew4OrqAGLQlZZ
         kGGBLz4bgyJiaRcBJBQg3FVZ2HubdxeMDL/GCm71je1PUMInieB8eJepKWrRFk4kEj08
         vM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143055; x=1702747855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMHzi0J79reXquigIs38sIEcotTqteBVvUo2J65iMZM=;
        b=Tbvg8VshEOH6v/tyPsDcBjUmmQ+hP+LIJVjE6cQtWAiNADQNkSM94ZJE5RB1Tlu733
         HTbA3WYuuI6eiwR1bz2GJwjZ45f5xY3IrPSjYVnJXsxCi8HjIVQzNJ+IMdReEBV5u+vy
         27cTAOiZI0I4MXThiE8BO1SSeJj5aIYKcc5FJ/2pGwQMmEaGT12Ch/Lkqf/csSsD0cor
         E7VDzQQ+mD/sMGdGNTLiCYYh2WQAsaLTcOrZn5vm46qfJjXt9o/l1WgYgpwd1e+Dtz0+
         AUa1//7d4jNr7THRD56gZHq0YiqBASLaWFxY5WZnlzioofvot+NCzJ27x/e6YGj6KGyZ
         khqQ==
X-Gm-Message-State: AOJu0YwRRCi/afWC2Wg0vTxbOCwVRK1WqswOwyqgYVARTQO4fweBf9YC
        61+COENOgXmn7qIiI6pQFwlXfA==
X-Google-Smtp-Source: AGHT+IHP7Nxeq+soWYuyj+nZVx+aEdcacAFdOlSGp9+y5qd/rGVytp8afEnLPtCa/qSID3T/mLj1HQ==
X-Received: by 2002:a50:d759:0:b0:54f:4882:cb2a with SMTP id i25-20020a50d759000000b0054f4882cb2amr1022643edj.41.1702143054733;
        Sat, 09 Dec 2023 09:30:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:30:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/15] arm64: dts: socfpga: stratix10: move FPGA region out of soc node
Date:   Sat,  9 Dec 2023 18:30:35 +0100
Message-Id: <20231209173044.257684-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "soc" node is supposed to have only MMIO children, so move the FPGA
region node to top level to fix dtc W=1 warnings like:

  socfpga_stratix10.dtsi:136.20-141.5: Warning (simple_bus_reg): /soc@0/base_fpga_region: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 1a743787fef6..ec086ffcc4a2 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -59,6 +59,13 @@ cpu3: cpu@3 {
 		};
 	};
 
+	fpga-region {
+		compatible = "fpga-region";
+		#address-cells = <0x2>;
+		#size-cells = <0x2>;
+		fpga-mgr = <&fpga_mgr>;
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <0 170 4>,
@@ -133,13 +140,6 @@ soc {
 		interrupt-parent = <&intc>;
 		ranges = <0 0 0 0xffffffff>;
 
-		base_fpga_region {
-			#address-cells = <0x2>;
-			#size-cells = <0x2>;
-			compatible = "fpga-region";
-			fpga-mgr = <&fpga_mgr>;
-		};
-
 		clkmgr: clock-controller@ffd10000 {
 			compatible = "intel,stratix10-clkmgr";
 			reg = <0xffd10000 0x1000>;
-- 
2.34.1

