Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B7E7BCED4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbjJHODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344864AbjJHOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:02:57 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A17E4;
        Sun,  8 Oct 2023 07:02:56 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3515aad4a87so15692245ab.3;
        Sun, 08 Oct 2023 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696773775; x=1697378575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeyjdW8u16yegotDnSCZCKulMzcwtuKO9IQY/3/chxk=;
        b=ODFspaIsFEKn0Sp3cDy0Vk4G0hGt/z0HVwMqHEwOGtDD7380V+EVmGRrOsqsgMo6hc
         c58cPSFKC8f/WRmC33PhZmptlCwV5to9BhdMNW8jQoJj/W6TIgJovui7SDeMhgEt1o1d
         FSw11F/ZyWZEW58PdKJGGf79VF8HNoUDDee3ZDkabPiL+nxPziA71MQEtnAzhz99eLPt
         96V5QYfwsuFsGIQEjAckvkcDlp4HRAUvGMWDLJ+25DWYHhs8WUccBZIPk4bpWPkYrbBA
         10XxXTNlgIzKoCZQmiN1dXQEtMbiPRGq0KHejJxicLnyhm5hOubswH57rGMYYjzV9XTj
         oKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696773775; x=1697378575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeyjdW8u16yegotDnSCZCKulMzcwtuKO9IQY/3/chxk=;
        b=WrvzJvgd3MIfVRqGEpfdQbFAVQJ5aOaVHR004sxpgYIZPCYBvfQRjZKp8wwtI2JCER
         jQodwFYnmpl6dsbNfKWHaik/qy6mZ7ROtv9oiYNhX1zRMcjIfP44l6sum7nYYqZ/rfH3
         gWOVsF3cJO9F1unVQHMzis9hD3lVdVIeinFOtwxpW3QyS3DORlJFFgOE80QdA2FBL/gQ
         RTgC/v4cp2fRkmXGctM8dMRK5KVibAbdBHk5XszhELxjE/E2TU1L7rRjyRvg1nz3RtBz
         mS8+ve4qF4zm+pQkmnFsdlWuFeItzyJU6+Ea8Ocr+l/P313ZhzHCSQaAvTo0nlFC/dCC
         ue7w==
X-Gm-Message-State: AOJu0YwOzy5LRKln7GL1dQKn9Zv2xEppgsywouGslyx369xzq8Yl0+fU
        7gqgQ5Hbvv9bBVFbNWxWS64=
X-Google-Smtp-Source: AGHT+IGplamwSERc2ILth4+Q1zSQcJ80lOf9usqGVtmWE5J0YzDjORtyRMadvGb1VIqozKA934WDPQ==
X-Received: by 2002:a05:6e02:c62:b0:351:e6e:7723 with SMTP id f2-20020a056e020c6200b003510e6e7723mr12047296ilj.25.1696773775435;
        Sun, 08 Oct 2023 07:02:55 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:a2fe:632a:2360:50d3])
        by smtp.gmail.com with ESMTPSA id 2-20020a921302000000b0035134f1a240sm2272901ilt.86.2023.10.08.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:02:55 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] arm64: dts: imx8mp-beacon: Add DMIC support
Date:   Sun,  8 Oct 2023 09:02:38 -0500
Message-Id: <20231008140239.6601-4-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008140239.6601-1-aford173@gmail.com>
References: <20231008140239.6601-1-aford173@gmail.com>
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
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  No Change
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

