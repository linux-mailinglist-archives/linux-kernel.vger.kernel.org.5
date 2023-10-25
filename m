Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42F27D721F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjJYRJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjJYRIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:08:51 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E461184
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:08:46 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id D58D61025C5;
        Wed, 25 Oct 2023 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1698253725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fN/MQV6dwt8BvtYNvMR12qWNERnV7Wj49zgD8ObeVA=;
        b=VtFrx0zcDRKK20SYDAD7XyFziUjVNDiy8fI2lqOyiXFo2zn/v/Lb4HySL4Nm7AzyvioUHH
        Qp6MFraRa39+17LVkKPqEraI6BEs5NNdcq3KuxV73pdSZS0R3BqtJ7WWG9QlOUXmE6pZ4a
        LkWnawYUAcSUKkekMCnOaROufBtkM3Q=
Received: from frank-G5.. (fttx-pool-217.61.159.50.bambit.de [217.61.159.50])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 2AB493608ED;
        Wed, 25 Oct 2023 17:08:44 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 3/5] arm64: dts: mt7986: change cooling trips
Date:   Wed, 25 Oct 2023 19:08:30 +0200
Message-Id: <20231025170832.78727-4-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025170832.78727-1-linux@fw-web.de>
References: <20231025170832.78727-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: eafcfba0-3d01-49d2-bf58-32026e9a4c7d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add Critical and hot trips for emergency system shutdown and limiting
system load.

Change passive trip to active to make sure fan is activated on the
lowest trip.

Fixes: 1f5be05132f3 ("arm64: dts: mt7986: add thermal-zones")
Fixes: c26f779a2295 ("arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts")
Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- squash patch for bpi-r3 as suggested by angelo
---
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 10 +++++-----
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 20 +++++++++++++++----
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index f9702284607a..b876e501216b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -152,16 +152,16 @@ cpu-active-high {
 			trip = <&cpu_trip_active_high>;
 		};
 
-		cpu-active-low {
+		cpu-active-med {
 			/* active: set fan to cooling level 1 */
 			cooling-device = <&fan 1 1>;
-			trip = <&cpu_trip_active_low>;
+			trip = <&cpu_trip_active_med>;
 		};
 
-		cpu-passive {
-			/* passive: set fan to cooling level 0 */
+		cpu-active-low {
+			/* active: set fan to cooling level 0 */
 			cooling-device = <&fan 0 0>;
-			trip = <&cpu_trip_passive>;
+			trip = <&cpu_trip_active_low>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 77ddd9e44ed2..fc751e049953 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -614,22 +614,34 @@ cpu_thermal: cpu-thermal {
 			thermal-sensors = <&thermal 0>;
 
 			trips {
+				cpu_trip_crit: crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+
+				cpu_trip_hot: hot {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
 				cpu_trip_active_high: active-high {
 					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "active";
 				};
 
-				cpu_trip_active_low: active-low {
+				cpu_trip_active_med: active-med {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "active";
 				};
 
-				cpu_trip_passive: passive {
-					temperature = <40000>;
+				cpu_trip_active_low: active-low {
+					temperature = <60000>;
 					hysteresis = <2000>;
-					type = "passive";
+					type = "active";
 				};
 			};
 		};
-- 
2.34.1

