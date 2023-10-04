Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D747B98DD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbjJDXr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243211AbjJDXrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:47:46 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0420C0;
        Wed,  4 Oct 2023 16:47:42 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79faba5fe12so19075139f.3;
        Wed, 04 Oct 2023 16:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696463262; x=1697068062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvKzcw6kAiBcbkeqMYP32mbpOXiT4xaGw7IdDJk9+NA=;
        b=czqYeRQQZQBCEeP/ItM/hFvdLpsrHV8LIDUeMPc/g5K5VovMejmgXMUVoRp2qtFwdW
         DKn4p9aAslY/DfNaPtPE0iqDzW/wI1t3VNGgPzg9dj82IhluD0dpac52fJtkpHRYQLBY
         VrEGCZgkjqMWOC3S15yZODB6hE+InoC6hI4x73BwMRcZycqO7VtswgxNAtsYg1hdffWx
         kDQ6uJQu9CYb789DqYxrq17NqzhNIJlXq7xALPACp8X5yhhKt9N3GIct7NnlCyNjhvK/
         ZsoDO+/edKp4RcXdMU1YIXgBUQYpoEl80uzNP5GdGco0wSOAQmn1N2RL/4DUMz8v+KGv
         NIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696463262; x=1697068062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvKzcw6kAiBcbkeqMYP32mbpOXiT4xaGw7IdDJk9+NA=;
        b=e9apZ52cK02x8UbJiBFpJ1BClzorbrgcj4RJcJBnqyzUh7Qp7utIJaQcbYy3GawVUt
         VdriK4CZpwzeemJKalYzpkS3K/LCHyDc2UwHzc/95NhP4dYs6tzOEixUNqRETJFWLZix
         zt/9aZ1IpwWR4oAz5In14b9zhkPJCjqtOesU8l9X8nVOpj2PMyO9dyOzuVfXEBQVwpfk
         CAIQkiJAU8ARD6OTR/QdJSGSqEnle7W+zTkS7iq0Q79SPJnWwqoF7xWzplr6BLhxqJEK
         rf0t5EkIabNVfig8nrvwvnbln96x1vzFfwmazl96gtX8Q45W1gLrdNJkXNrcr3abaDWr
         AI6g==
X-Gm-Message-State: AOJu0YzKNkUlMbEMq654D5bSFy5RA+V20Mh8Aai/AoQ0PhM9jxNankfh
        3PxYcgPGU6iAt3g8PzYxX+w=
X-Google-Smtp-Source: AGHT+IERgrYzaJpuc7jM4/PCOFndZn8k1/2YZm7ZCTSH1+VQD/f3kQln9HlU0YN5aZqa9r3pfC1ycg==
X-Received: by 2002:a05:6602:2012:b0:7a2:ac5a:89c3 with SMTP id y18-20020a056602201200b007a2ac5a89c3mr4094534iod.1.1696463261844;
        Wed, 04 Oct 2023 16:47:41 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id l13-20020a5e880d000000b0079fa3d0d790sm50062ioj.31.2023.10.04.16.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 16:47:41 -0700 (PDT)
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
Subject: [PATCH V2 4/4] arm64: dts: imx8mp-beacon: Add DMIC support
Date:   Wed,  4 Oct 2023 18:46:57 -0500
Message-Id: <20231004234657.44592-4-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004234657.44592-1-aford173@gmail.com>
References: <20231004234657.44592-1-aford173@gmail.com>
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
---
V2:  No Change

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index acd265d8b58e..ee64c6ffb551 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -49,6 +49,12 @@ ss_ep: endpoint {
 		};
 	};
 
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <1>;
+		#sound-dai-cells = <0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -147,6 +153,22 @@ reg_usb1_host_vbus: regulator-usb1-vbus {
 		enable-active-high;
 	};
 
+	sound-dmic {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sound-pdm";
+		simple-audio-card,format = "i2s";
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
@@ -174,6 +196,11 @@ simple-audio-card,codec {
 	};
 };
 
+&audio_blk_ctrl {
+	assigned-clocks = <&clk IMX8MP_AUDIO_PLL1>, <&clk IMX8MP_AUDIO_PLL2>;
+	assigned-clock-rates = <393216000>, <135475200>;
+};
+
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
@@ -364,6 +391,15 @@ hd3ss3220_out_ep: endpoint {
 	};
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MP_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <49152000>;
+	status = "okay";
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
@@ -545,6 +581,13 @@ MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21 0x10	/* PCIe_nRST */
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXC__AUDIOMIX_PDM_CLK		0xd6
+			MX8MP_IOMUXC_SAI5_RXD0__AUDIOMIX_PDM_BIT_STREAM00	0xd6
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-- 
2.40.1

