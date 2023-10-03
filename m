Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB17B68BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjJCMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJCMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:12:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A004A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:12:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so895624f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696335134; x=1696939934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndmM4JbR+kmn5XX/WNfIjfT5Y4Gu1IiD0B/toAwyHcg=;
        b=xObIzQhTXlIe4EE/ixIfSmE6P2LVWz/8+Fn00lBJVtLn46m+50bqywm3ShWx6Y0HJ0
         SK2GVDP9AryB0e48G3FRBj/kXWBrPHIzuiiY0aC9OXFNeEDYSeN9lmrK5WqCuug6icpZ
         n8Ut39vr6jzTj6unxSraUwH6UqxcHaBwZOFPhsJPqvV4ET7qw932SgcuDo06J2yhTW/U
         mOd8QFGxvSlhx5AnDzDE0V4+o+Bmo5bQAnFMz9W2MQrNw3pc/wRKmOXuaFtrVCm5zh0U
         Ky13XJY8VdxUXbw6eHO5CORmxKbIeIm0YlTiAtkNwpuUJYh9APtQd3kNAnEL/XAFBgRa
         3Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696335134; x=1696939934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndmM4JbR+kmn5XX/WNfIjfT5Y4Gu1IiD0B/toAwyHcg=;
        b=N1k3HiPAvVnPdKzQKLXAZbAfwSZETuaewl4hGxxDgnQUM1FNU7vxgpOwU17xwABBwN
         M7DCMIFY1kFTiTAsTMVVPVGPon9EAIGi1dCjFwg0uG4eIb64oLWSwUD1PFjBPMiRlUee
         +gNahVnXYs/qaShH5U3P0Xy0A+5O2hdsk5+7LVMjUeU4mltMoI6nJ5M612UyabU5s3zb
         ItbuM1hxHtVP3cB0HyOqUDQhyVHHlL4P75j9+8KR9I1wGu0vA7RfzmbTTBU2zqpZUliX
         gQw5gk0nRyB3bFPOqLMgkX+MNQPGR8x4T5mbmkozGcxNaqPZDk6qmhI/wso1Bee8WewP
         g7Dg==
X-Gm-Message-State: AOJu0YxUOie+oXFnp/DnFC3d1oF1n5U/JJXwmn+RzlhOSn+AD/42hlVF
        2X5NpGpD1f2KAVTn4t1OIqRiuQ==
X-Google-Smtp-Source: AGHT+IGxM9GQG5hZXhtn4gzyjVX9e5VJ9hbuqnhWi1ArsHR5MP/tYUrn4k11rz6jZV4/HWXFyPRcRA==
X-Received: by 2002:a5d:4385:0:b0:321:677d:98b0 with SMTP id i5-20020a5d4385000000b00321677d98b0mr12588341wrq.11.1696335134390;
        Tue, 03 Oct 2023 05:12:14 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:15bf:5b59:3e24:71fe])
        by smtp.googlemail.com with ESMTPSA id p3-20020a05600c204300b0040648217f4fsm9269649wmg.39.2023.10.03.05.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 05:12:13 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da.xue@libretech.co>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH] arm64: dts: amlogic: add spdifout on libretech potatoes
Date:   Tue,  3 Oct 2023 14:12:04 +0200
Message-Id: <20231003121205.2870923-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDIF output is available libretech's Potato v1 and v2, on a dedicated
header. Add the codec, pinmux and dai link to enable it on the sound card.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../amlogic/meson-gxl-s905x-libretech-cc-v2.dts | 17 +++++++++++++++++
 .../amlogic/meson-gxl-s905x-libretech-cc.dts    | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
index 2825db91e462..ca6f922d162d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
@@ -23,6 +23,13 @@ aliases {
 		spi0 = &spifc;
 	};
 
+	spdif_dit: audio-codec {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "9J2";
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -189,11 +196,21 @@ codec-0 {
 				sound-dai = <&hdmi_tx>;
 			};
 		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+		};
 	};
 };
 
 &aiu {
 	status = "okay";
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
 };
 
 &cec_AO {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 27093e6ac9e2..8b3234a9cb45 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -29,6 +29,13 @@ dio2133: analog-amplifier {
 		enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
 	};
 
+	spdif_dit: audio-codec {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "9J1";
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -183,6 +190,14 @@ codec-0 {
 				sound-dai = <&acodec>;
 			};
 		};
+
+		dai-link-4 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+		};
 	};
 };
 
@@ -193,6 +208,8 @@ &acodec {
 
 &aiu {
 	status = "okay";
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
 };
 
 &cec_AO {
-- 
2.40.1

