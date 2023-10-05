Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109A07B9E98
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjJEOJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjJEOHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9201920E63;
        Thu,  5 Oct 2023 03:30:53 -0700 (PDT)
Received: from eugen-station.. (unknown [109.166.134.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 788FC660731C;
        Thu,  5 Oct 2023 11:30:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696501852;
        bh=2Mi1NddfuW/82kOV74BmtTvxR7wGV2+vD7ZiTomFj3s=;
        h=From:To:Cc:Subject:Date:From;
        b=TYXCAJR3AyXvczf81GZZtUgcV0C/ci0C7wgmO9FMs7Gjn8hm4FJZcHkKfPWq5B2/R
         0raXWsQBPpZibqTaBiINosn+XBaEv+lD5tWNBipMh7siQFrpu5gkQGDeMmInNBVj1s
         C70YnVETbXUGBirnVTRsUdjhsJKJLm/9L4lEebtwsRgSCoAhuKLHI6Qnm9MuEjFA6Y
         VlB3MnFk93N8sZ0UUp/p7zY+NVw/2qJfnQaeJOjgCV0p9U1OyHs9P+0wabbA3N3Ejh
         Wha03VdiaaWFvebCBu1UHqqraJHt3BaH1uhUTN3ouVQ138KIo5Ako8OJ+o53Nqbk/6
         ElNOcA1Pyn1cg==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     allen-kh.cheng@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] arm64: dts: mediatek: mt8186: fix clock names for power domains
Date:   Thu,  5 Oct 2023 13:30:41 +0300
Message-Id: <20231005103041.352478-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clocks for each power domain are split into big categories: pd clocks
and subsys clocks.
According to the binding, all clocks which have a dash '-' in their name
are treated as subsys clocks, and must be placed at the end of the list.
The other clocks which are pd clocks must come first.
Fixed the naming and the placing of all clocks in the power domains.
For the avoidance of doubt, prefixed all subsys clocks with the 'subsys'
prefix. The binding does not enforce strict clock names, the driver
uses them in bulk, only making a difference for pd clocks vs subsys clocks.

The above problem appears to be trivial, however, it leads to incorrect
power up and power down sequence of the power domains, because some
clocks will be mistakenly taken for subsys clocks and viceversa.
One consequence is the fact that if the DIS power domain goes power down
and power back up during the boot process, when it comes back up, there
are still transactions left on the bus which makes the display inoperable.

Some of the clocks for the DIS power domain were wrongly using '_' instead
of '-', which again made these clocks being treated as pd clocks instead of
subsys clocks.

Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 42 +++++++++++++++---------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index af6f6687de35..7121d4312bee 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -924,7 +924,8 @@ power-domain@MT8186_POWER_DOMAIN_CSIRX_TOP {
 					reg = <MT8186_POWER_DOMAIN_CSIRX_TOP>;
 					clocks = <&topckgen CLK_TOP_SENINF>,
 						 <&topckgen CLK_TOP_SENINF1>;
-					clock-names = "csirx_top0", "csirx_top1";
+					clock-names = "subsys-csirx-top0",
+						      "subsys-csirx-top1";
 					#power-domain-cells = <0>;
 				};
 
@@ -942,7 +943,8 @@ power-domain@MT8186_POWER_DOMAIN_ADSP_AO {
 					reg = <MT8186_POWER_DOMAIN_ADSP_AO>;
 					clocks = <&topckgen CLK_TOP_AUDIODSP>,
 						 <&topckgen CLK_TOP_ADSP_BUS>;
-					clock-names = "audioadsp", "adsp_bus";
+					clock-names = "audioadsp",
+						      "subsys-adsp-bus";
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -975,8 +977,11 @@ power-domain@MT8186_POWER_DOMAIN_DIS {
 						 <&mmsys CLK_MM_SMI_COMMON>,
 						 <&mmsys CLK_MM_SMI_GALS>,
 						 <&mmsys CLK_MM_SMI_IOMMU>;
-					clock-names = "disp", "mdp", "smi_infra", "smi_common",
-						     "smi_gals", "smi_iommu";
+					clock-names = "disp", "mdp",
+						      "subsys-smi-infra",
+						      "subsys-smi-common",
+						      "subsys-smi-gals",
+						      "subsys-smi-iommu";
 					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -993,15 +998,17 @@ power-domain@MT8186_POWER_DOMAIN_VDEC {
 
 					power-domain@MT8186_POWER_DOMAIN_CAM {
 						reg = <MT8186_POWER_DOMAIN_CAM>;
-						clocks = <&topckgen CLK_TOP_CAM>,
-							 <&topckgen CLK_TOP_SENINF>,
+						clocks = <&topckgen CLK_TOP_SENINF>,
 							 <&topckgen CLK_TOP_SENINF1>,
 							 <&topckgen CLK_TOP_SENINF2>,
 							 <&topckgen CLK_TOP_SENINF3>,
+							 <&camsys CLK_CAM2MM_GALS>,
 							 <&topckgen CLK_TOP_CAMTM>,
-							 <&camsys CLK_CAM2MM_GALS>;
-						clock-names = "cam-top", "cam0", "cam1", "cam2",
-							     "cam3", "cam-tm", "gals";
+							 <&topckgen CLK_TOP_CAM>;
+						clock-names = "cam0", "cam1", "cam2",
+							      "cam3", "gals",
+							      "subsys-cam-tm",
+							      "subsys-cam-top";
 						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -1020,9 +1027,9 @@ power-domain@MT8186_POWER_DOMAIN_CAM_RAWA {
 
 					power-domain@MT8186_POWER_DOMAIN_IMG {
 						reg = <MT8186_POWER_DOMAIN_IMG>;
-						clocks = <&topckgen CLK_TOP_IMG1>,
-							 <&imgsys1 CLK_IMG1_GALS_IMG1>;
-						clock-names = "img-top", "gals";
+						clocks = <&imgsys1 CLK_IMG1_GALS_IMG1>,
+							 <&topckgen CLK_TOP_IMG1>;
+						clock-names = "gals", "subsys-img-top";
 						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -1041,8 +1048,11 @@ power-domain@MT8186_POWER_DOMAIN_IPE {
 							 <&ipesys CLK_IPE_LARB20>,
 							 <&ipesys CLK_IPE_SMI_SUBCOM>,
 							 <&ipesys CLK_IPE_GALS_IPE>;
-						clock-names = "ipe-top", "ipe-larb0", "ipe-larb1",
-							      "ipe-smi", "ipe-gals";
+						clock-names = "subsys-ipe-top",
+							      "subsys-ipe-larb0",
+							      "subsys-ipe-larb1",
+							      "subsys-ipe-smi",
+							      "subsys-ipe-gals";
 						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
@@ -1061,7 +1071,9 @@ power-domain@MT8186_POWER_DOMAIN_WPE {
 						clocks = <&topckgen CLK_TOP_WPE>,
 							 <&wpesys CLK_WPE_SMI_LARB8_CK_EN>,
 							 <&wpesys CLK_WPE_SMI_LARB8_PCLK_EN>;
-						clock-names = "wpe0", "larb-ck", "larb-pclk";
+						clock-names = "wpe0",
+							      "subsys-larb-ck",
+							      "subsys-larb-pclk";
 						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
-- 
2.34.1

