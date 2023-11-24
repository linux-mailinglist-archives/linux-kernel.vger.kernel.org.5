Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960B67F704D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbjKXJqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:46:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D1D68
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:46:29 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ffb5a4f622so239665066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819187; x=1701423987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0QF0pK62CGzX1dbKOGvu49OtUUhFLm+Kt8hr+OBwDAk=;
        b=Rqd1oUdO7UK56SK6/RL/yYWEHtRqbxsd7yD9eA3wdKWwitb92fMLo2gaPakDn+4d1f
         igu+/qZHFgt4H2XfHkc7xGqXHZua3N60v28fX6BOfVwE2xKxjXWnoKjisBdaNGlMieXi
         6ZpaSeQZ8XZ1yUWJxg+nm/WW9PbYsvKB71/cJpZcC+/phMvwHPbYIJr16kde+D7jHNHV
         y592zOpcEzRTIMpNw3aDLYouLTtOi3Jdu1QFVzVG4ORW4vk5hozbFKbjbbGxk/z99nRg
         i251TCp+5sLXzrMFHAcqlrF1BHcvHiFacz4jSn9rUnejwxmaUb1tsVg9nU4zJbI58iII
         fcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819187; x=1701423987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QF0pK62CGzX1dbKOGvu49OtUUhFLm+Kt8hr+OBwDAk=;
        b=PkQ1MNQzOucpMlIUk0Tx244t89lJphcEfn5j/NXUUH5Tj45GTL8ZG1YP1Nc0o4YA9v
         /4DCfhVG61xn+HnJJ2P87gAWXKJ/WpxjWoYDAwWn9KWJsqT/UgmNvC+51/7OA3I9HIN+
         Vp5I1OCa/MTR8NJ1RncnvHiKv5kDW19edy5+Dqt3vz3OyeHMSLhYjUwIQLrecmLKKq9O
         tb0A9BZoBo+Vgx7nQD1i+r99tfx0cHkrUSZ0ZYHz4S58erXAPWj+CAnrqzm+Llc/sFUb
         Don1QLmctq38dSaZ3g5NDeQz05LM07T6YDonMmX/2QoY1j10SUlanY6YJQJCaYntzFW4
         7Ttg==
X-Gm-Message-State: AOJu0Yze8Vva05cVipxXHUiFxMAcgzV/b0UeULvqBUiFcu0KeoJW8DHI
        ftIT/mIkJA3/O5q1152bRBpsPQ==
X-Google-Smtp-Source: AGHT+IGHU1g0j7+TtCvkg1FvPUSqMrrpDxYvMPRX3FDrVqA7+vUSxKjvSyL9yAs2vkKhdEmVcdQGag==
X-Received: by 2002:a17:906:3b5b:b0:a01:d383:8ba8 with SMTP id h27-20020a1709063b5b00b00a01d3838ba8mr1591374ejf.22.1700819187491;
        Fri, 24 Nov 2023 01:46:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id kg16-20020a17090776f000b00a0371c6cc23sm1860524ejc.95.2023.11.24.01.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:46:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: intel: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:46:20 +0100
Message-Id: <20231124094620.58017-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index dcdaf7064953..d66d425e45b7 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -73,7 +73,7 @@ intc: interrupt-controller@1d000000 {
 		ranges;
 		#interrupt-cells = <3>;
 		#address-cells = <2>;
-		#size-cells =<2>;
+		#size-cells = <2>;
 		interrupt-controller;
 		#redistributor-regions = <1>;
 		redistributor-stride = <0x0 0x20000>;
@@ -315,7 +315,7 @@ spi0: spi@10da4000 {
 			num-cs = <4>;
 			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>;
 			dmas = <&dmac0 2>, <&dmac0 3>;
-			dma-names ="tx", "rx";
+			dma-names = "tx", "rx";
 			status = "disabled";
 
 		};
-- 
2.34.1

