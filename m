Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38180B594
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjLIRbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjLIRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:30:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4AC10FC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:30:57 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50c222a022dso3063559e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143056; x=1702747856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSzsCw66aSx0p8zyn0VK/qCKSJ0A7CHuboWFkgEIMeA=;
        b=RIHIjysmXSNb68kY08YBUU0DLaTUMCeLCbyULUyRK2ST+CLdFnFDQ76vHEF0LkepSD
         dPVNh26cYLE+yDni6xjOrdgb1KMFXICOUhS2i3CVa5YQMrZDO1gDFql470Asow23g8Vk
         eeKM1aEzW1TV5NUpwWQj7llPttN925oYQwYaosTZV/j7BzpbooL7VR6MiVLYs5JSAEUE
         cVYnw3tJ3OvLaj37wEUv5yH8ik2nkaPD/5bCFMwHz4eq5f+yHZMmr8oOTc5XwQBJ6OQg
         A1/iJVO1E03fygTfRB5lSwXo94aZn+xHyX9+oRKLZBIt0Tz+Dmp30eucTtnthsIWIiM1
         dxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143056; x=1702747856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSzsCw66aSx0p8zyn0VK/qCKSJ0A7CHuboWFkgEIMeA=;
        b=QnkiD2tZ3ZF5hb++2HWNcgI8snH5nY2HR9bJN6KbWG00notgwZxxqAzxUYl+BAosH2
         4kxsR+nmnQmfIFTa8ZyB47vy0tA+pCpV7oZaowsx5XTo3KRKQihfnfaiXN626xOYT44q
         zbT1hi298duBvqIUpgTbAk+RBbzv09rk3DUbOl2yVfEozXMyzffysbpJZTz3msvw/u5K
         dbitoB66Wwn/G8Am/atuhe5UgBNN/eInPtKY5r2KtucPXct5HCN59iCDqe9tZ9wiuN4g
         4G/ouL9xjhJ9U8wOnvD0bG/D+D90ZWWib1Oqcf5dx6YPz2K71n7NbRwK9c5KeHB2bSgH
         SXgA==
X-Gm-Message-State: AOJu0YzescQx92V/w8vo7nS5I0VmtrmM+z5yrIlGFdujRKrg/bijgRWw
        7L4mELNEzmyecNulzSlkaXaIDZUzU4VIscAcjGI=
X-Google-Smtp-Source: AGHT+IH37fvpHOxSIqMWeEpJnkik2YGLxE0uj4jQysdexjzsLxTYKLmEYueBZgUiZEBRex6tPwCnpQ==
X-Received: by 2002:a05:6512:1595:b0:50b:f78a:37c8 with SMTP id bp21-20020a056512159500b0050bf78a37c8mr1124964lfb.95.1702143056120;
        Sat, 09 Dec 2023 09:30:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:30:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/15] arm64: dts: socfpga: stratix10: move firmware out of soc node
Date:   Sat,  9 Dec 2023 18:30:36 +0100
Message-Id: <20231209173044.257684-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
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

The "soc" node is supposed to have only MMIO children, so move the
firmware/svc node to top level to fix dtc W=1 warnings like:

  socfpga_stratix10.dtsi:625.12-635.5: Warning (simple_bus_reg): /soc@0/firmware: missing or empty reg/ranges property

The node should still be instantiated by drivers/of/platform.c, just
like in all other platforms.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested
---
 .../boot/dts/altera/socfpga_stratix10.dtsi    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index ec086ffcc4a2..59075b958048 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -59,6 +59,18 @@ cpu3: cpu@3 {
 		};
 	};
 
+	firmware {
+		svc {
+			compatible = "intel,stratix10-svc";
+			method = "smc";
+			memory-region = <&service_reserved>;
+
+			fpga_mgr: fpga-mgr {
+				compatible = "intel,stratix10-soc-fpga-mgr";
+			};
+		};
+	};
+
 	fpga-region {
 		compatible = "fpga-region";
 		#address-cells = <0x2>;
@@ -621,18 +633,6 @@ qspi: spi@ff8d2000 {
 
 			status = "disabled";
 		};
-
-		firmware {
-			svc {
-				compatible = "intel,stratix10-svc";
-				method = "smc";
-				memory-region = <&service_reserved>;
-
-				fpga_mgr: fpga-mgr {
-					compatible = "intel,stratix10-soc-fpga-mgr";
-				};
-			};
-		};
 	};
 
 	usbphy0: usbphy0 {
-- 
2.34.1

