Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF86E77CA74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjHOJ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjHOJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:28:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CFDE63;
        Tue, 15 Aug 2023 02:28:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-319559fd67dso3847318f8f.3;
        Tue, 15 Aug 2023 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692091682; x=1692696482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwfzrnXrzs3srhIJvT0mhp0xOGZ4O82IIuIkbmzCw5w=;
        b=kpH0+vVgFu0XNZt2m6cDg7G6SmrMzwp/GgX+g0GuIL+CVr2BQx6zlBfyaBsb4MMzvb
         KOsZiZP4/IFdWBEa5TIb+BZAcsuLmj4qxvYnlB79lzxR87zTqmxLJSDPANSTz4JoMwt3
         x7vLY1SBDYle13X6Ev2o/8yx8RgQYsoiMOmTcEHr3FDbmKG2kFR2L6v3QAPvqqtNDW9V
         c89HLh7yjtPJAKTI5nngLMvcIErkZYI/Eh/TbbuVqBUEfuv+eFQU7obb3utpFz6kVS0+
         vs69o7QN2CJblnN9QWWEavsHBhJwn+7Um8NxQtYnNEY0WWUb+soe9YMFCpfZM/0WtZDf
         JwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091682; x=1692696482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwfzrnXrzs3srhIJvT0mhp0xOGZ4O82IIuIkbmzCw5w=;
        b=HtjTlVPPjRTEY/iCywYcX8VQ2Pr0/HFWDYzOLJs6IOn69Q4QStA80beDWxXHkOei63
         XETombbeETWzWgljvKLD5eLvjeNfpNXCsf9MOzfh9+AktvcqonlVdnDQG0FxHNvzVA7U
         fsXaZXaM7wSSbWNRG4Oip+96jE75YPfUdcSElipK78S+7xac1tvu5MTR6P1wKYhanUZ1
         4wakminZG4rKdQDNJOR+yiVW8uI9JFaUz6Sck9yMZ5eiY4DvHx6ydJr/2kUwAxddHgKJ
         JpKjs9tWaq4/uSJz5q5vu8DJ7slgc4k9MAwPCpyPDy8s7Qp7PnXeuLqJ8EwExB12LwrX
         OZ3w==
X-Gm-Message-State: AOJu0YxndXeigFzXgBwGQFklmL7VGWuggdkmr8Xm/4lcihaXi6nCQe2B
        BjiFy9Zcf1U+DzCqMi+mpy0=
X-Google-Smtp-Source: AGHT+IF2AQqeJrtG/7WlxfiZa445yC5atouzCZjTj2PShhJzRkZSg2tTZD5WWUIvGr+e32sTlD7Xyg==
X-Received: by 2002:adf:f281:0:b0:317:6a07:83a7 with SMTP id k1-20020adff281000000b003176a0783a7mr8573440wro.38.1692091681922;
        Tue, 15 Aug 2023 02:28:01 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm17230853wrj.33.2023.08.15.02.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 02:28:01 -0700 (PDT)
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
Subject: [PATCH 2/3] arm64: dts: meson: add audio playback to p201
Date:   Tue, 15 Aug 2023 09:27:50 +0000
Message-Id: <20230815092751.1791195-3-christianshewitt@gmail.com>
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

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-p201.dts      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
index 150a82f3b2d7..6f81eed83bec 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
@@ -8,10 +8,49 @@
 /dts-v1/;
 
 #include "meson-gxbb-p20x.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "amlogic,p201", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P201 Development Board";
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "P201";
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
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
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
 };
 
 &ethmac {
-- 
2.34.1

