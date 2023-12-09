Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7BD80B5A2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjLIRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjLIRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:31:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EBA1FC2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:31:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c67b0da54so4078875a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143065; x=1702747865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G7cpU+ukIu1B7V2qz7kc1RiGDNV3d/6SfmS5MXR3hw=;
        b=BbI3AqKdoF5ucHA6mH67VF12pIDIkHmMWQnKebBNT8GKCQ2JoIc9UkjTgRx8EJhz49
         mqIKHtNfd5p2tuR/qK0Y7msaRxssnOYQNTZfiAPH4BGjCfW63C1o9t4K9gYjxbLcEojL
         70pyG2ys9fIPel/MRBp5XEYtP32kYr1FIQVm+me4Olmnl7k59IBeRMd3LVud0/rCeMpv
         Kg1KSD4iEQW4CR1/rfEH6l5Cfb0zdyB3gSfQWyKe0lZ1nsyg2L5sgCIC46lw02nKriB6
         GwaSifMS3fcwK3tGU7gtOpZaIiYRdQ9TB17+mNLaNH29EM1LdX6kOyxD6NTyBQz53i1c
         NwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143065; x=1702747865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G7cpU+ukIu1B7V2qz7kc1RiGDNV3d/6SfmS5MXR3hw=;
        b=gneV7cFl5/WxwBFHQ3L9SoarFVYEP/9rJNupgONAn4470PtKkAdfmFdCDPWXFtbZ4F
         HxTJ8tBUQIUE/R/uL3KGCqf9n2+B4ARFsqeqPjv6wsbeBrp1jWT6wAGGmeUbjFlgutwW
         Pa9dsq3EVBhYT7AmuV5gNQ08DJCen/ClIk0e4+qgz6GxquzDfP/y8MZ4mGyjJe6enx2g
         cVoY9HzKgke+T1mhq66K1Pn4advx4OTSVYFrhsQOnPXTEsQJM7EC9XEVWOFehW5VX8SS
         8UPGuY8uzVIsrmCGavv/h4j8gkHwyUSQ8F3rW3VnR52aBEXjVWEVWlkh/yB/0awrpkmS
         4zcw==
X-Gm-Message-State: AOJu0Yxdi6hxy17O1gDR5wwidmr9sZPV7YOIeTnQ9o1KoqWDJXEZ3Swi
        5ToFCoBkKL3zSMc6fVfvJm8gsA==
X-Google-Smtp-Source: AGHT+IEzPWkzMki8q5Ome70IpK1Tv91BRZgLtWdSdQNa/CjTLYydcL2Yznp39cwNh2g+fdJIMXDhIw==
X-Received: by 2002:a50:cc99:0:b0:54b:3edc:180 with SMTP id q25-20020a50cc99000000b0054b3edc0180mr1342713edi.11.1702143065319;
        Sat, 09 Dec 2023 09:31:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:31:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 14/15] arm64: dts: socfpga: agilex: add unit address to soc node
Date:   Sat,  9 Dec 2023 18:30:43 +0100
Message-Id: <20231209173044.257684-14-krzysztof.kozlowski@linaro.org>
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

The "soc" node has ranges with addresses, so it is should have unit
address  to fix dtc W=1 warnings like:

  socfpga_agilex.dtsi:152.6-674.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested.
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      | 2 +-
 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts | 2 +-
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 8792291a0175..76aafa172eb0 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -149,7 +149,7 @@ usbphy0: usbphy {
 		compatible = "usb-nop-xceiv";
 	};
 
-	soc {
+	soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
index 1a32840c74e0..d22de06e9839 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
@@ -26,7 +26,7 @@ memory@80000000 {
 		reg = <0 0x80000000 0 0>;
 	};
 
-	soc {
+	soc@0 {
 		bus@80000000 {
 			compatible = "simple-bus";
 			reg = <0x80000000 0x60000000>,
diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index de82a552dc26..f2e2346dd3c4 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -25,7 +25,7 @@ memory@80000000 {
 		reg = <0 0x80000000 0 0>;
 	};
 
-	soc {
+	soc@0 {
 		sdram_edac: memory-controller@f87f8000 {
 			compatible = "snps,ddrc-3.80a";
 			reg = <0xf87f8000 0x400>;
-- 
2.34.1

