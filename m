Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B878C78CB06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbjH2RTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbjH2RSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF951A4;
        Tue, 29 Aug 2023 10:18:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bdcade7fbso601535766b.1;
        Tue, 29 Aug 2023 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329469; x=1693934269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bC2y7VdPt+gQZ4niYJX9yvKSEdfcPfq9HIkHksvZpA=;
        b=lGLyFsRElGEyypnxgJ4cyR1W3hhI3uGn2LWWryaunAyjg3zzlBD6lYgb2VqOuweM/f
         jlnz5i7MN9x/62/CizSh/qRJ01spkv2EsJ77tFZut26Fo98bA2BZM9KGCIcqTwcI09/C
         uTwZrqD2OQSi5QVBYAvRbYmwNOGPIZklud3uK6FoPPetpDm3970xygUGihojNpbHYfEm
         OmPprpzEjklTYdU2YsMhAoe8/6MBGrKa1SBgJG8bBNWlV5TmuOEQmp60a1Zx1g0ZOTJ2
         YZ59q4K1hQc1QSLkCN+4hVD9sOyL0gePkGu7LUVrYCVxB6Xnm8pkTBXN6sz2O3cNTiCT
         YdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329469; x=1693934269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bC2y7VdPt+gQZ4niYJX9yvKSEdfcPfq9HIkHksvZpA=;
        b=SMUdTwYzBw4UjqKIKwxioDHQtKVijxjKmF1Ezzi6d+fthbO2UooOppbAc9fpa6ATPI
         9OotIC2DDZf29BnlDBAW1cOV0Gd6EnzbPEo9LqkJbc/CJVs8WzpwoJYsZ4cmvZAwn7Eu
         TnGjsEyxfD0anr6a3ioXQBK5aToEmyyc1BAAx3XhihwaWjhsykI1Pe5psnfW8p+jwh+z
         lpPn7GdxiXVe9ZpAWygoym4PdIChsIsMKAHMh9fmkjO7cmh9ANeXaQrbEn0EQYJlf0N8
         RDMNM5w6H6C4HdJHFBw6ac++A1C4lO8ShggSQ8QUXtspwOC45ZyTxHtQs8JLpctY3FvJ
         4f+Q==
X-Gm-Message-State: AOJu0YyR7mzMI8EGxHF0gkN91qeG4izWZhT4l6C1rEw0AXJezm59vaXx
        IXvUplWvGVx8P2BEpGFjoA==
X-Google-Smtp-Source: AGHT+IHmXDVIaV6yhzoHdttsh1bCbntYH5kT5qx7a1c+aLWU6X2nsxuyymCHftiQpUNhOc4FPkF4/w==
X-Received: by 2002:a17:907:b11:b0:9a4:88af:b77 with SMTP id h17-20020a1709070b1100b009a488af0b77mr9110577ejl.60.1693329469044;
        Tue, 29 Aug 2023 10:17:49 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:48 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 25/31] ARM: dts: rockchip: Add spdif for RK3128
Date:   Tue, 29 Aug 2023 19:16:41 +0200
Message-ID: <20230829171647.187787-26-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the S/PDIF block for RK3128 SoC.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 2339232ae2d7..874c97297c63 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -21,6 +21,20 @@ i2s_8ch: i2s@10200000 {
 		status = "disabled";
 	};
 
+	spdif: spdif@10204000 {
+		compatible = "rockchip,rk3128-spdif", "rockchip,rk3066-spdif";
+		reg = <0x10204000 0x1000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF>;
+		clock-names = "mclk", "hclk";
+		dmas = <&pdma 13>;
+		dma-names = "tx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_tx>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	i2c3: i2c@2005e000 {
 		compatible = "rockchip,rk3128-i2c", "rockchip,rk3288-i2c";
 		reg = <0x2005e000 0x1000>;
-- 
2.42.0

