Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32F9781EC4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHTPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjHTPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:40:07 -0400
X-Greylist: delayed 94 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Aug 2023 08:39:07 PDT
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A13D10F;
        Sun, 20 Aug 2023 08:39:06 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id 574CE5FA81;
        Sun, 20 Aug 2023 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1692545513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SsbtKnqEZS1SBS/BTwtYQes3zVkGyGBksUmpnFniAzM=;
        b=l28ZjGGRxA5usxJSSUCcuQvQ7eQvPtZIwgHBByGOmuaT2HIhcbulcN37G/BI8a/I6nWCj9
        1QTDhBJv6zVQRwsOPIABFI/LZ9hOujh/4zWdZ4uVFnnt3Si5Drbfolatd0fTFM5Vky79iL
        tNQesKw2oC1/IGRH5nkVDgOkLWES5Hg=
Received: from frank-G5.. (fttx-pool-80.245.78.65.bambit.de [80.245.78.65])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id AC639406E2;
        Sun, 20 Aug 2023 15:31:52 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/3] arm64: dts: mt7986: change cooling trips
Date:   Sun, 20 Aug 2023 17:31:34 +0200
Message-Id: <20230820153135.42588-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820153135.42588-1-linux@fw-web.de>
References: <20230820153135.42588-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 146a06ab-4984-4ce9-abad-c731e52ad8a3
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
Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 207510abda89..36d8945400df 100644
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

