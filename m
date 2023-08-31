Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AEA78E588
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346044AbjHaEoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242186AbjHaEot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:44:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C916D2;
        Wed, 30 Aug 2023 21:44:44 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-794c7d95ba5so17652339f.0;
        Wed, 30 Aug 2023 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693457083; x=1694061883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYCeRF7plttkP+pwt4k2tA+LB4kQ1QS+KcxQIuWcqqo=;
        b=qsEkvxeOP0ochyr42q7D4r6+AQxuGa8FfRE2Ql/8AfwqgKG+XFobS4dTSTlvygNsnS
         SxprEGIuGLzdGIcvHjVp11S+f+kCMvWInAunUo9xxYVgCSV9CTgleoTh5PsXO8YAtbvR
         WN+pdPUgtXyCLxcvXlroEnGR6XwSrLymG1pHH6QjXsU9KbUShMlWnuQEWLliLsjkzd4J
         2QgY5SXYQ80JQPOqh8LC/C1hE0G/QNEtEKidpETG9tcUTd2a2w+zFVW1uoBJLTe4cJUN
         P6//8B8mHtlOHuENJrq3DFB6IXkRn8eP+XGbzGwS1RYlZj8Km5HCMUPiYpBm0vS/ckBi
         bpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693457083; x=1694061883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYCeRF7plttkP+pwt4k2tA+LB4kQ1QS+KcxQIuWcqqo=;
        b=XD9wapYbOAXhMY5Mv4JeRgdfAOCPtQUDZPvAxHvsdCyymj0k2/7k1MxHyQWjsdFIt9
         YJGRzph9Te2ewJRrUqUc/K0Ty0F2xT//5i2ftLKZz3fWYqSTr7+UrnCvAu+2yDJfpLCd
         3UaJ64v4UyBNMHLwJEuYhJvoTF4Lg3Mq4SY6Ll+KksOzQESbolSV1++aKGZVMK/2uy7E
         EZjYwSy4YPhLsUaWH0lY+N3z6lSeY3q0dqbMyK1L5XVv+nxHiivOFjusRTSgKLrwJmlm
         u6hBgzhc2cKHggrYAIAv+H8jQJi4IgDy4nyNa44C5qKiYF8SsHb6d6TJ5Y+/QxOhqrxU
         ErhA==
X-Gm-Message-State: AOJu0Yz+9Gzb3OpX5vKUFMAz1yZEilmKTqeCS0hkzGZE/K9lWOMGaZyP
        BboKnNeWnTD+fncoYzsUh4Qq0FFVzZ0=
X-Google-Smtp-Source: AGHT+IFw2RAJRYGzSsO0cOfcseEMLaXDAiU7oqL/80x8eXZoUADCXqOjd91aSKM2uC47T1zqd5YU2Q==
X-Received: by 2002:a6b:e801:0:b0:791:1b1c:b758 with SMTP id f1-20020a6be801000000b007911b1cb758mr5110522ioh.19.1693457083494;
        Wed, 30 Aug 2023 21:44:43 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:d40b:6175:6beb:6448])
        by smtp.gmail.com with ESMTPSA id x6-20020a5e8306000000b0077a1d1029fcsm215006iom.28.2023.08.30.21.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 21:44:43 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH V3 2/3] arm64: dts: imx8mp: Add micfil node
Date:   Wed, 30 Aug 2023 23:44:30 -0500
Message-Id: <20230831044431.250338-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831044431.250338-1-aford173@gmail.com>
References: <20230831044431.250338-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MP has a micfil controller which is used for interfacing
with a pulse density microphone. Add the node and mark it as
disabled by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  The AUDIOMIX_PDM_ROOT doesn't exist and the real clock is
     called IMX8MP_CLK_AUDIOMIX_PDM_SEL, so swap it out.

V2:  No change

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3167706d81e1..341fd0369ce9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1479,6 +1479,27 @@ easrc: easrc@30c90000 {
 					fsl,asrc-format = <2>;
 					status = "disabled";
 				};
+
+				micfil: audio-controller@30ca0000 {
+					compatible = "fsl,imx8mp-micfil";
+					reg = <0x30ca0000 0x10000>;
+					#sound-dai-cells = <0>;
+					interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_IPG>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_SEL>,
+						 <&clk IMX8MP_AUDIO_PLL1_OUT>,
+						 <&clk IMX8MP_AUDIO_PLL2_OUT>,
+						 <&clk IMX8MP_CLK_EXT3>;
+					clock-names = "ipg_clk", "ipg_clk_app",
+						      "pll8k", "pll11k", "clkext3";
+					dmas = <&sdma2 24 25 0x80000000>;
+					dma-names = "rx";
+					status = "disabled";
+				};
+
 			};
 
 			sdma3: dma-controller@30e00000 {
-- 
2.39.2

