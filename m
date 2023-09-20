Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EF37A77C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjITJl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjITJlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:41:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815C293;
        Wed, 20 Sep 2023 02:41:44 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38K9fWQW080462;
        Wed, 20 Sep 2023 04:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695202892;
        bh=9fp9OF36S/XXnEBcCGrs7kEJkJhySv6EG42Vubf+KlY=;
        h=From:To:CC:Subject:Date;
        b=Dq2FT2DUs9AvxYXJSA3W4TKU3rS26jdlBR7u8iN3bkM4P6j3/1rdxHAgYN69Op7yG
         0kkaEDKNYU54F6Ig11sjqXh0+UmXXG/eyNkxL0BiBIYYWNoVZ9b0azluCbJZ7u4w0w
         YH4dg3mn/2gud4R2DcgdPm+q8A/wBvUKdyqAKvVM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38K9fWuR027160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Sep 2023 04:41:32 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Sep 2023 04:41:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Sep 2023 04:41:31 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38K9fUSj021166;
        Wed, 20 Sep 2023 04:41:31 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <a-govindraju@ti.com>, <kishon@ti.com>, <b-kapoor@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mode
Date:   Wed, 20 Sep 2023 15:11:30 +0530
Message-ID: <20230920094130.20279-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to TRM for J721S2, SDR104 speed mode is supported by the SoC
but its capabilities were masked in device tree. Remove sdhci-caps-mask
to enable support for SDR104 speed mode for SD card in J721S2 SoC. Also
add itap delay select value for DDR50 High Speed Mode.

[+] Refer to : section 12.3.6.1.1 MMCSD Features, in J721S2 TRM
- https://www.ti.com/lit/zip/spruj28

Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---

Changelog v2->v3:
 - Add Itap Delay Select value for DDR50 SD High Speed Mode

Link to v2 patch : https://lore.kernel.org/all/20230412121415.860447-1-b-kapoor@ti.com/

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 084f8f5b6699..a5ab301b14f1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -766,11 +766,10 @@ main_sdhci1: mmc@4fb0000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,itap-del-sel-ddr50 = <0x2>;
 		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
-		/* Masking support for SDR104 capability */
-		sdhci-caps-mask = <0x00000003 0x00000000>;
 		status = "disabled";
 	};
 
-- 
2.39.2

