Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6601979B210
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353693AbjIKVsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbjIKPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:46:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BB2FB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:45:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so49013715e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694447156; x=1695051956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8GmnivYIya/kXsBEnAOi5/Fi2lHPHk3tyJN33w5ic4=;
        b=MdFBr7kuYpRk46PzUng5XfTQtMhFRQxb7PZcy4EkbiX1GyUq2TByswGx5SfNOBmIF0
         QITv7kS+Iep0XRHcnT2j4UYugK1qBZx0D7570nyXIaSerpJqlpGgDh49OFJ5KEyC1ANu
         m8U8iFwng0y0xg7jGdzFg+YJLKkhorid2YhHS1sdL4XEzgKrnUYswHiWGvfzKeuggSqD
         C/AF9AYAw6e5ssM5qTxAXeepH23TMNEVTcuuvJaLlQ9vBbNDt3oltY/Gn000ivSaQaKI
         fp4oq5yHTTUuz3QedWbU5L1OQFe4YZrWY82yt7x18JUY685Mdrj90cmMxnvwXytoWBs5
         hbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694447156; x=1695051956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8GmnivYIya/kXsBEnAOi5/Fi2lHPHk3tyJN33w5ic4=;
        b=QMkO5ciXvOYh+0gtYu33Bw587RX3lx9nLyb0cypi26/VbPm+m401C1F1DVMLpPi5ca
         Ulfw5QPd6v4m53ZnH7zYM+u31iSpR3Cv01PI04aNMarq7/ZjpI3zVcICY67GFenqf12L
         sKtn+k8vHHYH1nEST0DN/aTOHzHAMEN1BiOwPXP6PiFZQpALGNSpUeaaynIzmrY7iAf8
         m8IHa/+YmtdZwnJWKPjmEj5gTzLYWjTKFbD0Zg/tcI5Sk3/bomSTNN8YJ+bzoaRgb6w/
         9G9iK/wC0d0bAdPefuuwULKsJclEa2EdLclCDt2a6qXVokEvRoSIZ2e45zQdo9fF4dHC
         QQqQ==
X-Gm-Message-State: AOJu0YwkUm0PoLO+bZGaO7RPRcWzCfIFpyZ0mzWD7e5z8h4ahNOAqoA4
        JsBgInP587h7p6ZjwITkWxmwww==
X-Google-Smtp-Source: AGHT+IEOdC6N4yffuUJH7WsfrdAEJ+HeWUa6KJ6KGJQUIHAReIzAkUYcbtQ2ckSxfrRuPEHZZd+3aQ==
X-Received: by 2002:a05:600c:2294:b0:401:b204:3b98 with SMTP id 20-20020a05600c229400b00401b2043b98mr8950146wmf.19.1694447155928;
        Mon, 11 Sep 2023 08:45:55 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:55be:8f7e:5f59:7ed1])
        by smtp.googlemail.com with ESMTPSA id q12-20020a05600c040c00b003fe539b83f2sm13616255wmb.42.2023.09.11.08.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:45:55 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 4/5] arm64: dts: meson: u200: use TDM C for HDMI
Date:   Mon, 11 Sep 2023 17:45:40 +0200
Message-Id: <20230911154541.471484-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230911154541.471484-1-jbrunet@baylibre.com>
References: <20230911154541.471484-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the u200, TDM B is wired to the onboard AD82584F i2c speaker codec.
This makes TDM B a poor choice for the interface dedicated to HDMI which
uses 4 i2s lanes.

TDM A is not a good choice either as it is connected to the SDIO wifi/bt
chip.

TDM C is not used externally by default, which makes it a better choice for
the HDMI interface.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 921b62c5ab33..da66e2e1dffb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -159,10 +159,10 @@ vddcpu: regulator-vddcpu {
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "U200";
-		audio-aux-devs = <&tdmout_b>;
-		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
-				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
-				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+		audio-aux-devs = <&tdmout_c>;
+		audio-routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
+				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
 				"TDM_B Playback", "TDMOUT_B OUT",
 				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
 				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
@@ -193,7 +193,7 @@ dai-link-2 {
 
 		/* 8ch hdmi interface */
 		dai-link-3 {
-			sound-dai = <&tdmif_b>;
+			sound-dai = <&tdmif_c>;
 			dai-format = "i2s";
 			dai-tdm-slot-tx-mask-0 = <1 1>;
 			dai-tdm-slot-tx-mask-1 = <1 1>;
@@ -202,7 +202,7 @@ dai-link-3 {
 			mclk-fs = <256>;
 
 			codec {
-				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
 			};
 		};
 
@@ -412,11 +412,11 @@ &spdifout_b {
 	status = "okay";
 };
 
-&tdmif_b {
+&tdmif_c {
 	status = "okay";
 };
 
-&tdmout_b {
+&tdmout_c {
 	status = "okay";
 };
 
-- 
2.40.1

