Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADFA7727E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjHGOfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjHGOfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:35:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF1810DD;
        Mon,  7 Aug 2023 07:35:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so631682366b.2;
        Mon, 07 Aug 2023 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691418937; x=1692023737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyTj/EAHU86MCmjIDTneVFZ/F0zuNFke5LJEBRUozL0=;
        b=d+b9Bgxt8jjhWPSZN8YGF+VhD2yHLtLkBYtZCPk9VS2usI+5pUfv1lOceCn2jCEhU3
         bIXRbL27djBDBnqqN6oEN6+zL5NYrceLq0i488o53TZCGQ9g+F5ut9NM7WVJghK8/Fw/
         /JKY5z3wXjvNJXPIKVJ7ZLq/o+GCim1f3WomPX3IWHCesbIGdoYgh2uynrRgvUZThunI
         VBZvOvrsOHt7Kw79NU8zNgc7dZtR4lngga+ZXSMu7xyzTdTwpA2Cv8OPxmnQ1md4kEQ9
         tNHTLcXku1SrjPQqHtGPMl9UCg74r3bE1LZXfXjSsVqaZaF/8z7yHDyd14E8WfburjHE
         AZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418937; x=1692023737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyTj/EAHU86MCmjIDTneVFZ/F0zuNFke5LJEBRUozL0=;
        b=Civ82Bggp8UthH2005D1brhFcPCLOr91mDxuB/FVjTMJjTSnh/QqVTKjGvOdHYi7tT
         H/3r4rgT2Yyc8NlCb33nFgCKrM6ZLsdMxyh3cSs8MTP6D2c3QE3+WRJXWTYyh3GaMG/3
         WPyhoK2BpI9sqHro6bO3HDl1HGG1HxmtPnlEIwYzIvJLJU/AYLACX+iq5HacT3X20scL
         64YJsguXeYXLYnTBP8HA6+w4JPbu2Nu4FeAnWM/ARxtwxPFCYjNAQ4+TNDBgNWt4hJuV
         9UNV6LhUl1C2Gt908gdr7FpEoofkM6cBCZT+/kb7jdZmcowmLnOjKftr4wovu4kOUOwX
         bEtw==
X-Gm-Message-State: AOJu0YyVFNArFxRfLMdvHtgKE9IMI0bmarctIi++SGud/G+rcYIV6Sgg
        eAud4mTnoBjBoQvWbtrOJ5M=
X-Google-Smtp-Source: AGHT+IEBOTjjQty4GTArfLewTs7sbydLqR0FAVIlgxNIR8H11ce7m0dYpelCzN4OBZskoCwE97nmYA==
X-Received: by 2002:a17:906:51c8:b0:991:c566:979 with SMTP id v8-20020a17090651c800b00991c5660979mr8427229ejk.36.1691418937036;
        Mon, 07 Aug 2023 07:35:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b0099329b3ab67sm5323292ejk.71.2023.08.07.07.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:35:36 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] ARM: tegra: transformers: add connector node
Date:   Mon,  7 Aug 2023 17:35:15 +0300
Message-Id: <20230807143515.7882-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807143515.7882-1-clamor95@gmail.com>
References: <20230807143515.7882-1-clamor95@gmail.com>
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

All ASUS Transformers have micro-HDMI connector directly available.
After Tegra HDMI got bridge/connector support, we should use connector
framework for proper HW description.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS TF T30
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101 T20
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201 T30
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../boot/dts/nvidia/tegra20-asus-tf101.dts    | 22 ++++++++++++++++---
 .../tegra30-asus-transformer-common.dtsi      | 21 ++++++++++++++++--
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
index e118809dc6d9..cd6acbea0318 100644
--- a/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
@@ -82,9 +82,11 @@ hdmi@54280000 {
 			pll-supply = <&hdmi_pll_reg>;
 			hdmi-supply = <&vdd_hdmi_en>;
 
-			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
-			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
-				GPIO_ACTIVE_HIGH>;
+			port {
+				hdmi_out: endpoint {
+					remote-endpoint = <&connector_in>;
+				};
+			};
 		};
 	};
 
@@ -967,6 +969,20 @@ clk32k_in: clock-32k-in {
 		#clock-cells = <0>;
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		hpd-gpios = <&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+		ddc-i2c-bus = <&hdmi_ddc>;
+
+		port {
+			connector_in: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
+
 	cpus {
 		cpu0: cpu@0 {
 			cpu-supply = <&vdd_cpu>;
diff --git a/arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi
index ead95306840f..9b658b3de7a4 100644
--- a/arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra30-asus-transformer-common.dtsi
@@ -80,8 +80,11 @@ hdmi: hdmi@54280000 {
 			pll-supply = <&vdd_1v8_vio>;
 			vdd-supply = <&vdd_3v3_sys>;
 
-			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
+			port {
+				hdmi_out: endpoint {
+					remote-endpoint = <&connector_in>;
+				};
+			};
 		};
 	};
 
@@ -1494,6 +1497,20 @@ clk32k_in: clock-32k {
 		clock-output-names = "pmic-oscillator";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		hpd-gpios = <&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+		ddc-i2c-bus = <&hdmi_ddc>;
+
+		port {
+			connector_in: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
+
 	cpus {
 		cpu0: cpu@0 {
 			cpu-supply = <&vdd_cpu>;
-- 
2.39.2

