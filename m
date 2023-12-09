Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3490780B5A1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjLIRby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjLIRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:31:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E51BFF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:31:10 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54d048550dfso4407564a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143064; x=1702747864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eyf5zSHhrESy35WP6ODF7XXeRocJ2QbCnaJvEWXeVR0=;
        b=n9/eXagboFcBcmki2/4KIVWSQfAwffi3l3zrUbyf3yGDgMrneTVEeTJD0zyptDXi9Z
         Tdrt1BYJMu5yrWzPpKJSpm7kvw+e/J16cE6j74HsS1dBBY/0p3bplKD0EZf1ultjSf2s
         JQs4N4O+Z3nheLHwgHH+gv76BAOBiDCL/zNALmrBAS2qEVazPum/1cq1Rg1mkJ11FILH
         jDJ4MA22oMUXB/tQUC+Ko66lBKzw2SMb+48RJAWZt3bS6gbjwkRDItCgo03ovYQgygI3
         +JTSFVaQ7gSoDyVLLrsLMUohrxQsobaBuKrABfhgymNIRBZDrbN6wCDX9fwUcG7HgqsN
         joFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143064; x=1702747864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eyf5zSHhrESy35WP6ODF7XXeRocJ2QbCnaJvEWXeVR0=;
        b=qIHjOO+fagkFkctNy5yfzWdm7LTw0aTmfigD9Y2XJfDwSa5aMUpvuj5CDeHzYhUQVw
         zh5MdmBNTGhFkxwMd+IXbLqhlwlsuuYCrlCNOWWDoBNyRnChufxRvPXivBNKVhMTr0yc
         G5XhX6hZQT3mQMby5hD0gNKw/61d+deCMIp7IBjg/+fnrVHioIBra9R2BwAT3L8zTvQR
         Iw3C6AVxE/IRUiEMzdLj7/F6ocEpH7vsc/QkBT+vhwrUUeffQMUjM+DfFB6KBi6ia0E/
         051aRvBg2b2cgBqPmolZUNMZrwMDSk+n7tFTJk045y0Ru6dZRyAt911uM+CHziWfJa+m
         2ZnQ==
X-Gm-Message-State: AOJu0YyZRwQ63Fghfretz8tMsJ6O2TBHO7+NN/5JxFjlDoaTCZiAj7LG
        Q/BlotdsHsCKBo4gSdjk47inuQ==
X-Google-Smtp-Source: AGHT+IHrhWmyYQL3VvZY8EmD7GfZasmKJeHT9KtnwPfWAyJory1uMiDSwVtatPvCnRw9HOl0GmLbEw==
X-Received: by 2002:a50:aad5:0:b0:54f:46dc:8594 with SMTP id r21-20020a50aad5000000b0054f46dc8594mr850472edc.111.1702143064055;
        Sat, 09 Dec 2023 09:31:04 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:31:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 13/15] arm64: dts: socfpga: agilex: move firmware out of soc node
Date:   Sat,  9 Dec 2023 18:30:42 +0100
Message-Id: <20231209173044.257684-13-krzysztof.kozlowski@linaro.org>
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

The "soc" node is supposed to have only MMIO children, so move the
firmware/svc node to top level to fix dtc W=1 warnings like:

  socfpga_agilex.dtsi:663.12-673.5: Warning (simple_bus_reg): /soc@0/firmware: missing or empty reg/ranges property

The node should still be instantiated by drivers/of/platform.c, just
like in all other platforms.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 77d03caea25b..8792291a0175 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -60,6 +60,18 @@ cpu3: cpu@3 {
 		};
 	};
 
+	firmware {
+		svc {
+			compatible = "intel,agilex-svc";
+			method = "smc";
+			memory-region = <&service_reserved>;
+
+			fpga_mgr: fpga-mgr {
+				compatible = "intel,agilex-soc-fpga-mgr";
+			};
+		};
+	};
+
 	fpga-region {
 		compatible = "fpga-region";
 		#address-cells = <0x2>;
@@ -659,17 +671,5 @@ qspi: spi@ff8d2000 {
 
 			status = "disabled";
 		};
-
-		firmware {
-			svc {
-				compatible = "intel,agilex-svc";
-				method = "smc";
-				memory-region = <&service_reserved>;
-
-				fpga_mgr: fpga-mgr {
-					compatible = "intel,agilex-soc-fpga-mgr";
-				};
-			};
-		};
 	};
 };
-- 
2.34.1

