Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19AC80B59F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjLIRbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjLIRbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:31:12 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCF11BCF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:31:06 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54c5ed26cf6so4044189a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143063; x=1702747863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6m7JKD+ylF3U0pXdJ9z4W2nTldRa7P9helTdI7kd4Q=;
        b=FU/wWcCYyD2j7+2hPvCbhImpxDFcdC2oDhvV+UhGvIP89x1ynor5m9Y5hsjB2oiNRl
         IRc45RqxM97JzVaC0L+8MUHiDpZfYqMioLab/urqC23bEjk+Sm65KS+MYicBraIe3yMG
         1xLCudcOKqxZgryXqRHY7m5eQl5iEGgxQzZ+W0hF+IS3bZYV95JPRo/ZpmFQB/8lrN0U
         zJN2KyJ3IFhkBUAHSRTb3ZKyDvf8b9xXy9MkQkpU73tGEYCe6i/67jxImSDnbmQcY55N
         Y/D4HcS77LOSaZ2+mnnPWWUBqs5y/2DLZNwF4SYFkMgIleyZMV26MSC8ucpjqMwoOFmV
         /TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143063; x=1702747863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6m7JKD+ylF3U0pXdJ9z4W2nTldRa7P9helTdI7kd4Q=;
        b=tJDKz7y48ZKKnFB/lBPsOke3A+mvFOjzQ6yo/G0fIfsJFcdxLXAbBR6ux7RQz+/sYj
         apxJk2LHbSuBwfdOV2czKJEDL6gL3Lg5drze7uaiIOVnA9wvtw5fLtMmQyHIFlz5MDsT
         l+DQyyvUwBNvsN6Zf853mix2gI76tEn6r3RZE3Xbq4QmPKbr/9EnecLY4g22IwKIJ1iV
         ljdvvyO4sWiPhb/Aud7ZmVld/zwU7qo08oCRLS7Iw876dvmXXh6YEBduemqE+wDK6/Oq
         op30HfKZDLoUD3LKyNjCa3SVxAa3D1PCmAF0z3RPbTw79f2fhPUl8M5v9aFrL7c90oJU
         EUrg==
X-Gm-Message-State: AOJu0YzMpT7NPZfppCPAe/ZCfX5C+DtXKClGY2koDKBCxRHuI+N5sltp
        2NC5+QH+KJ6TfjrKnhwnTf4ZYA==
X-Google-Smtp-Source: AGHT+IH6ZkkVtGtOYkc22zNVYOtpSdrQusw9pZ9+MrrUsIVB9zDgvzdpcvpX5Sjl0P75kbNp7USZpA==
X-Received: by 2002:a50:c94d:0:b0:54c:4837:81e0 with SMTP id p13-20020a50c94d000000b0054c483781e0mr940765edh.49.1702143062791;
        Sat, 09 Dec 2023 09:31:02 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:31:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 12/15] arm64: dts: socfpga: agilex: move FPGA region out of soc node
Date:   Sat,  9 Dec 2023 18:30:41 +0100
Message-Id: <20231209173044.257684-12-krzysztof.kozlowski@linaro.org>
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

The "soc" node is supposed to have only MMIO children, so move the FPGA
region node to top level to fix dtc W=1 warnings like:

  socfpga_agilex.dtsi:141.20-146.5: Warning (simple_bus_reg): /soc@0/base_fpga_region: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index de1453a951d6..77d03caea25b 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -60,6 +60,13 @@ cpu3: cpu@3 {
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
 		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
@@ -138,13 +145,6 @@ soc {
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
 			compatible = "intel,agilex-clkmgr";
 			reg = <0xffd10000 0x1000>;
-- 
2.34.1

