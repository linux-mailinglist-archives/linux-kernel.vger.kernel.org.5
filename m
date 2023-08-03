Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9076E68C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjHCLPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjHCLPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:15:09 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C61A5;
        Thu,  3 Aug 2023 04:15:05 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373BEv1g095445;
        Thu, 3 Aug 2023 06:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691061297;
        bh=Me/6ZJVB8QBwCQFOpcmLDOu+F661wRbjDCNT/Gw3BTU=;
        h=From:To:CC:Subject:Date;
        b=NN7s+ao+IokQP2fGCa31nN7Kszf6no8Hc/SLI0q08/ZXZj9kynH3BSq1skV5sd0HM
         y191z1bSwwYKrOddAXS3t8wH+OadZB5YSkLA/3pprVzjfQMRIZqoyqCs4WCAu4RUMa
         QYUxsZY6K7CXn1rgnUGqGvLZVXd6iPzyulK+5iVA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373BEv6Y037080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 06:14:57 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 06:14:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 06:14:56 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373BEukW036047;
        Thu, 3 Aug 2023 06:14:56 -0500
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <a-bhatia1@ti.com>, <j-luthra@ti.com>, <praneeth@ti.com>,
        <j-choudhary@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
Date:   Thu, 3 Aug 2023 16:44:55 +0530
Message-ID: <20230803111455.811339-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve 128MiB of global CMA which is also marked as re-usable
so that OS can also use the same if peripheral drivers are not using the
same.

AM62x supports multimedia components such as GPU, dual Display and Camera.
Assuming the worst-case scenario where all 3 are run in parallel below
is the calculation :

1) OV5640 camera sensor supports 1920x1080 resolution
-> 1920 width x 1080 height x 2 bytesperpixel x 8 buffers
   (default in yavta) : 32MiB

2) 1920x1200 Microtips LVDS panel supported
-> 1920 width x 1080 height x 4 bytesperpixel x 2 buffers :
   16 MiB

3) 1920x1080 HDMI display supported
-> 1920 width x 1080 height x 4 bytesperpixel x 2 buffers :
   15.82 MiB which is ~16 MiB

4) IMG GPU shares with display allocated buffers while rendering
   but in case some dedicated operation viz color conversion,
   keeping same window of ~16 MiB for GPU too.

Total is 80 MiB and adding 32 MiB for other peripherals and extra
16 MiB to keep as buffer for fragmentation thus rounding total to 128
MiB.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Acked-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 34c8ffc553ec..9dd6e23ca9ca 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -47,6 +47,14 @@ ramoops@9ca00000 {
 			pmsg-size = <0x8000>;
 		};
 
+		/* global cma region */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00 0x8000000>;
+			linux,cma-default;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
-- 
2.34.1

