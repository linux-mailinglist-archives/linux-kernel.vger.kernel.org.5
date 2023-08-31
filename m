Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E464F78EC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346125AbjHaLvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjHaLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:51:49 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B24E40;
        Thu, 31 Aug 2023 04:51:46 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7923ae72111so27401239f.0;
        Thu, 31 Aug 2023 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693482706; x=1694087506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+kNWrgmNs4s12nz1ZRGpluVgBLXFMVQIrdkMeSABd4=;
        b=LNtfyBKr9imRQww2QDK40UJ3gLi1vdsxrTJTyC9JVwLkuhqb70+rZNdwHb+YF3BRUG
         kVJhidwm6Lh1tJ3l98WbE07ADgr0G/WRPg5rYzHqx+oZnoMt99hKDti5+yUvBFl/gYOU
         0mdhiUCVX2KFybgkv+j/95lqKU+k1zirJLVKCAgdWC3GneNZP5CNpkohiuy2Yeig/C0I
         wtTx32sCgAvNVxBxN2ZGx5rgtib9neVOD8F0sXsQ4D4q/kcCnncpeiqpcM2nfS9vE/8d
         XJtuhIry7VlCjG3Iqum+JVvmaroihU0hXLdpKZPOD/gZVgVS2+XBtlLbQxG+RusV3QRT
         bfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693482706; x=1694087506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+kNWrgmNs4s12nz1ZRGpluVgBLXFMVQIrdkMeSABd4=;
        b=NDJqbGZL46AM0cFMdzKeP5/oyHdGMqWRn3RXVfCAFwhjAKjVkAAVzP0l6EFJUOqr08
         F6QGJa/wRaLoIRJPEwQ/FWL9UMTjOVx24VGozyUwJdfNPhJ8fZcS6h2u/2HMgjceVT62
         VBPvEU/pHDt5hVNtaJNGqLk7ip0KyjKIrbDHPXRgxm9d2sBIN6xlie/CEhEb8ifFnXX/
         TBLWAMgk9DzFc7QI+W7oii+py8V4PDK1AtxGImHhBTPF8OPAAOm0HE/OSYr7wmh8xbAH
         M6NMllKmP9/OGBM8W2s6uh9VGO5eDnoM3+GpZNd/A1W3dy6RJ2XAZtZfhngrm+/twcjT
         hTiA==
X-Gm-Message-State: AOJu0YyAoOvSYE6f439twyir31T9LP0HDf/vaTeNDfUmFqUJyleDsSa7
        kPNBP0NdCe6g0DQHRhrEiaM=
X-Google-Smtp-Source: AGHT+IFqcrNSlFBq1FDUlcMdCiwIg1ohn3weVauam3YbXpkxgZTUk93HsxScIFm8E5LyyojQ0lUOBA==
X-Received: by 2002:a6b:d902:0:b0:790:fab3:2052 with SMTP id r2-20020a6bd902000000b00790fab32052mr5174751ioc.5.1693482706145;
        Thu, 31 Aug 2023 04:51:46 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2a0f:e1d5:3688:f2b8])
        by smtp.gmail.com with ESMTPSA id o28-20020a02cc3c000000b0042b1d495aecsm353529jap.123.2023.08.31.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:51:45 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: imx8mn-beacon: Add DMIC support
Date:   Thu, 31 Aug 2023 06:51:27 -0500
Message-Id: <20230831115128.254226-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831115128.254226-1-aford173@gmail.com>
References: <20230831115128.254226-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The baseboard has a connector for a pulse density microphone.
This is connected via the micfil interface and uses the DMIC
audio codec with the simple-audio-card.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 16761975f56e..0b51c0c71423 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -4,6 +4,12 @@
  */
 
 / {
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <1>;
+		#sound-dai-cells = <0>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -74,6 +80,22 @@ reg_usb_otg_vbus: regulator-usb {
 		enable-active-high;
 	};
 
+	sound-dmic {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "dmic";
+		simple-audio-card,format = "pdm";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+
+		dailink_master: simple-audio-card,cpu {
+			sound-dai = <&micfil>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&dmic_codec>;
+		};
+	};
+
 	sound-wm8962 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "wm8962";
@@ -221,6 +243,16 @@ mipi_csi_in: endpoint {
 	};
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MN_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <49152000>;
+	status = "okay";
+	#sound-dai-cells = <0>;
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -311,6 +343,13 @@ MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI5_RXC_PDM_CLK	0xd6
+			MX8MN_IOMUXC_SAI5_RXD0_PDM_BIT_STREAM0	0xd6
+		>;
+	};
+
 	pinctrl_reg_usb_otg: reg-otggrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
-- 
2.39.2

