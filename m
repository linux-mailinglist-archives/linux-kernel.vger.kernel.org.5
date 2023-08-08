Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4792774A68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHHU13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjHHU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:26:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4767DB2;
        Tue,  8 Aug 2023 12:44:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3784jZS3035097;
        Mon, 7 Aug 2023 23:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691469935;
        bh=8TvvH3vVLz1caYe+mRMACPv8Abe/WkjKw7gend+67a8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=phSki+lTpB9e7K5VsheydqQ+iQPxhARIo3FEn3Q3tErZkOOg5xeT6cguMwm5T89Sj
         TzGnue+VjDak0RCZBY9iFe1SCT8U0tF7DH1VSTopUC7qIBFXreI1CgCFe/E3k2VskW
         vJgeKiaOYYzYz5bs2unjVq+/135RFxpIuCewwjt0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3784jZ3J073754
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 23:45:35 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 23:45:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 23:45:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3784jYps098643;
        Mon, 7 Aug 2023 23:45:34 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 2/5] arm64: dts: ti: k3-am62 : Add M4F remote proc node
Date:   Mon, 7 Aug 2023 23:45:26 -0500
Message-ID: <20230808044529.25925-3-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808044529.25925-1-hnagalla@ti.com>
References: <20230808044529.25925-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM62x SoCs of the TI K3 family have a Cortex M4F core in the MCU
domain. This core can be used by non safety applications as a remote
processor. When used as a remote processor with virtio/rpmessage IPC,
two carveout reserved memory nodes are needed. The first region is used
as a DMA pool for the rproc device, and the second region will furnish
the static carveout regions for the firmware memory.

The current carveout addresses and sizes are defined statically for
each rproc device. The M4F processor do not have an MMU, and as such
require the exact memory used by the firmware to be set-aside.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
Changes in v5:
 - Add the M4F device tree node patches to the patch list 

 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       | 12 ++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index 80a3e1db26a9..4b55df1da751 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -171,4 +171,16 @@ mcu_mcan1: can@4e18000 {
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 		status = "disabled";
 	};
+
+	mcu_m4fss: m4fss@5000000 {
+		compatible = "ti,am64-m4fss";
+		reg = <0x00 0x5000000 0x00 0x30000>,
+		<0x00 0x5040000 0x00 0x10000>;
+		reg-names = "iram", "dram";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <9>;
+		ti,sci-proc-ids = <0x18 0xff>;
+		resets = <&k3_reset 9 1>;
+		firmware-name = "am62-mcu-m4f0_0-fw";
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 34c8ffc553ec..ffca61fcf9ba 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -47,6 +47,18 @@ ramoops@9ca00000 {
 			pmsg-size = <0x8000>;
 		};
 
+		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9cb00000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9cc00000 0x00 0xe00000>;
+			no-map;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
@@ -362,6 +374,13 @@ mbox_m4_0: mbox-m4-0 {
 	};
 };
 
+&mcu_m4fss {
+	mboxes = <&mailbox0_cluster0>, <&mbox_m4_0>;
+	memory-region = <&mcu_m4fss_dma_memory_region>,
+			<&mcu_m4fss_memory_region>;
+	sram = <&oc_sram>;
+};
+
 &usbss0 {
 	status = "okay";
 	ti,vbus-divider;
-- 
2.34.1

