Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5228D811F72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjLMTvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379048AbjLMTv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:51:28 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7608DE3;
        Wed, 13 Dec 2023 11:51:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c317723a8so63811025e9.3;
        Wed, 13 Dec 2023 11:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497093; x=1703101893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=res/nVyNjutOW8BN3aTB9WUo0BBvwS0hIxu7mxFR92s=;
        b=GtzYy5AQksozX2hqpeZqEIxm96LRjRWw7mx8aOVY3rnWzcURY6/+dhrotzeLtEwOS0
         0HsOk1Poh8KgQGK5Mb8zno8UrfklFqwrBeMR2KoJy9nmhjFHUpNHEXAkej5Ru+Sj7vTK
         YNlkIMc6fIUjarAMVO9BY5JnzAtquSPbeSffedxC4MOvBUkx4gmVqimkadDNw2nUnWoT
         YPz5G1efQhYlnMDxqtd2oAD2gHqr3mQmrkRrO0yfHrKQOS3rK8+nbjuszD4k6pFrsl9j
         rLOVV6ETwoMjad3uhz240dlRBGvByV3RZ+Pug5ckJ6fFXWo9FM7TE6suQoWQxOCxQrLL
         0QAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497093; x=1703101893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=res/nVyNjutOW8BN3aTB9WUo0BBvwS0hIxu7mxFR92s=;
        b=Rli2fVXov1UlAjWXqxbAHBptO9d7lvtYCV/dlfyfHrErIIuizaomAgU6hvad88p8Xi
         DhGPsDhluBBTAPBApgXjNR9k6k+Kaq96keT0F2046ytJgOQnJo3DEwtWiKjEfLWgqQTW
         Zr0MqWR8c6LSgpM6qRY4EUcP5nlSTgOvfi6E0trnUBRdr/gonvndaFwTU1HUkvw9q/FA
         aXhg7677S4IlGcUvmynYt/GL2fhvvyo+ChFC9PrwC3Z7hZ/Pz4uyxf9tbijMVdo58YtO
         3MG/+kuKgIWoNYHaNbReGubqeOe6K9+E1Y2V8wuRetgRLHdlBB5UgNJCHj9Ik77GI2/B
         gw2g==
X-Gm-Message-State: AOJu0YylG2io5DMfFZ3sMs/gFocrykuir3sz5k6d9k/wBpTeRst0K6/w
        e4ecm8Ck1eMp0/9jCADAIdS10jPTzg==
X-Google-Smtp-Source: AGHT+IFItZMtGB3SuUCkRPeMfs6P+z1aUcgQiQ9jDlsw7JgTG7OibMvG1NdHIBA0UOpU4R1v8MTSAg==
X-Received: by 2002:a7b:cc8e:0:b0:40c:613a:8364 with SMTP id p14-20020a7bcc8e000000b0040c613a8364mr39998wma.134.1702497092872;
        Wed, 13 Dec 2023 11:51:32 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:92dc:8b1c:e01c:b93c])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm24050698wmb.27.2023.12.13.11.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:51:32 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 09/11] ARM: dts: rockchip: Add display subsystem for RK3128
Date:   Wed, 13 Dec 2023 20:51:23 +0100
Message-ID: <20231213195125.212923-10-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213195125.212923-1-knaerzche@gmail.com>
References: <20231213195125.212923-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vop and display-subsysem nodes to RK3128's device tree.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index e2264c40b924..1a3bc8b2bc6e 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -115,6 +115,12 @@ opp-1200000000 {
 		};
 	};
 
+	display_subsystem: display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop_out>;
+		status = "disabled";
+	};
+
 	gpu_opp_table: opp-table-1 {
 		compatible = "operating-points-v2";
 
@@ -246,6 +252,27 @@ power-domain@RK3128_PD_GPU {
 		};
 	};
 
+	vop: vop@1010e000 {
+		compatible = "rockchip,rk3126-vop";
+		reg = <0x1010e000 0x300>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_LCDC0>, <&cru DCLK_VOP>,
+			 <&cru HCLK_LCDC0>;
+		clock-names = "aclk_vop", "dclk_vop",
+			      "hclk_vop";
+		resets = <&cru SRST_VOP_A>, <&cru SRST_VOP_H>,
+			 <&cru SRST_VOP_D>;
+		reset-names = "axi", "ahb",
+			      "dclk";
+		power-domains = <&power RK3128_PD_VIO>;
+		status = "disabled";
+
+		vop_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	qos_gpu: qos@1012d000 {
 		compatible = "rockchip,rk3128-qos", "syscon";
 		reg = <0x1012d000 0x20>;
-- 
2.43.0

