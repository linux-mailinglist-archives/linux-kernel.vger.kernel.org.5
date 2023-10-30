Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF827DBAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjJ3NZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjJ3NZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:25:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7120D97;
        Mon, 30 Oct 2023 06:25:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A18E066071A3;
        Mon, 30 Oct 2023 13:25:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698672329;
        bh=wz7abYmfV4HWaoeOBzSJ/u42aKuYiLe917d2C8mb5w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5d3n2kjct0RdiYJ2bIBv+u77xHD+a/Xe50Ftl6FrwLrmq6VJKBJHeZtux6N/oc3G
         8MP0yY2Y8pKZFBS3ZfiFylxV2MNqs8io8vMR1jbdiEbwu8LDds0tc16ksi984h36C+
         THCNL/LMtbUEUMn3hnqLk2NkMXb3b/+T49OP92oIJk3O5X1hyh+7sSZQgLAxKnPxQ0
         m2ag56ESKBdROQmUzVlokbKeYJRijBz1jql+jgpO/8/Sr/tdeLtcMcXigwTenbOjBC
         Iaf1ZhcwhMqaGa/usFd7w+DOcVIUePCtWf2qHiddEMWa2KKsSuAlKnKJw4naU7G8VS
         CTi0fs0zu8/6w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 1/2] arm64: dts: mediatek: mt8195-cherry: Add MFG0 domain supply
Date:   Mon, 30 Oct 2023 14:25:22 +0100
Message-ID: <20231030132523.86123-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030132523.86123-1-angelogioacchino.delregno@collabora.com>
References: <20231030132523.86123-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFG0 is the main power domain for the GPU and its surrounding glue
logic, and has a specific power rail.

Add its power supply on Cherry platforms and remove the now useless
(and wrong) regulator-always-on property from the vbuck1 regulator.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 2c2f079600ba..26213100419a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -478,6 +478,10 @@ pmic@34 {
 	};
 };
 
+&mfg0 {
+	domain-supply = <&mt6315_7_vbuck1>;
+};
+
 &mmc0 {
 	status = "okay";
 
@@ -1231,7 +1235,6 @@ mt6315_7_vbuck1: vbuck1 {
 				regulator-enable-ramp-delay = <256>;
 				regulator-ramp-delay = <6250>;
 				regulator-allowed-modes = <0 1 2>;
-				regulator-always-on;
 			};
 		};
 	};
-- 
2.42.0

