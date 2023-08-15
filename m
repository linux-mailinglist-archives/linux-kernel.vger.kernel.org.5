Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A438577CA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbjHOJ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbjHOJ2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:28:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48A1FF2;
        Tue, 15 Aug 2023 02:28:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3180fd48489so4286581f8f.3;
        Tue, 15 Aug 2023 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692091679; x=1692696479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxLmACEq8DwvR1DlwOAwmK1lXNm1dEuNHjSmvA+D3D4=;
        b=FX/o1rqpRFL5xfRi+6HUlHxU7IDdu2pvJrfL9KhKIugOtkau9zCJWta7/bgjIjy5gr
         NJ6YmwtZoqg/38MW+rvT6YScskVPl9bXtRpQ2+aXIESLHWXzl1SXm9obfSGegZdp6BMV
         ptGrowxXbEmPRW1lto1CEbCLkbkEFqeanwWjKuslJdJ00p2s9Pz/IcXqI7MCtN0PT428
         L00qB8LpjOeYbBpG112XMcB42ZipYVB0PURgihWjmnqrd1WPUWzDk5y9RRTbmHpqFcuS
         /8jKBvVkxCF4dkahYzeQKyJ5zxEXmbuxnoj77LDwdTiywJounhqHlbohX3VSOK+k3hc+
         esTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091679; x=1692696479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxLmACEq8DwvR1DlwOAwmK1lXNm1dEuNHjSmvA+D3D4=;
        b=d0xY33IVZQrhzHjuCHEWRjMIxX9qj+qJHEVRmBz1rxuqs45gTbWl6DC4EfRmzg31O0
         zU23Jra/QkRpSNVmqmADjZddLqKhy1gfNAjaFU9oHbBdmlGim1uf/g5pMoh+MUB1G+jT
         8puhcmvZMFyqj7oan3iHe7vRM0eqH0jMEdfPUrCxAuzQnkxS9c1M49Zogm7hIBFWUjQ8
         zFyzIKXc9A1ic0TofjptzJNFzMs4NSJckjtgy5XFvWgMGQnxdBMTkpePVWqntIF8Yt3j
         BAkC32C+I4Dg6aFuF2wKzw9tp7aVuHWeaSa82bBlj+j+t0OwbMpgY/wNGMGRZYIpinFV
         Usrw==
X-Gm-Message-State: AOJu0YxQtKLXI94sRQKD/RAJ4V4uT2PcTlO8cUvA05sgdtJLqCq0kRFm
        mirMNgF0t4REHLX+QbITzjW/6DNpbJs=
X-Google-Smtp-Source: AGHT+IF3cQZNWTyrBIiA0J/8Z5kQ+jSt3gu7hM9b3t2zxfiduxi/iEYIwMYG2mEkwrEV480a99XxAA==
X-Received: by 2002:a05:6000:110f:b0:317:6fff:c32b with SMTP id z15-20020a056000110f00b003176fffc32bmr8660548wrw.53.1692091679216;
        Tue, 15 Aug 2023 02:27:59 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm17230853wrj.33.2023.08.15.02.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 02:27:58 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/3] arm64: dts: meson: add audio playback to p200
Date:   Tue, 15 Aug 2023 09:27:49 +0000
Message-Id: <20230815092751.1791195-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815092751.1791195-1-christianshewitt@gmail.com>
References: <20230815092751.1791195-1-christianshewitt@gmail.com>
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

Add initial support limited to HDMI i2s and SPDIF (LPCM).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-p200.dts      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 3c93d1898b40..292c718ee19c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -9,11 +9,19 @@
 
 #include "meson-gxbb-p20x.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "amlogic,p200", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P200 Development Board";
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	avdd18_usb_adc: regulator-avdd18_usb_adc {
 		compatible = "regulator-fixed";
 		regulator-name = "AVDD18_USB_ADC";
@@ -57,6 +65,58 @@ button-menu {
 			press-threshold-microvolt = <0>; /* 0% */
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "P200";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
+	pinctrl-0 = <&spdif_out_y_pins>;
+	pinctrl-names = "default";
 };
 
 &ethmac {
-- 
2.34.1

