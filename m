Return-Path: <linux-kernel+bounces-54648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD9884B1F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0E1286C04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3312D77F;
	Tue,  6 Feb 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RpgoC6OP"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0FC12C7E1;
	Tue,  6 Feb 2024 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213994; cv=none; b=f9pg5tT091NlJI6HpGQ7P1KNMVmusv/tXnUWG/04e7agpLVoDQWqQt68QqL9m15wy2McsvzDKz/yVa7dvPlu9ZdrMbZs0E9ZQoFFuf7bKlAh0BcqkF0PHpXx+vWprHfrrUxAK5UF/hx+3FQDVDM/pVRwGuIYGIVJx44OosOQgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213994; c=relaxed/simple;
	bh=4qz64tUjM43uwH0ysX/H72XJXr3htSRe/bPxBIixDuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skKWfQhwQbCtvihiKgXHO3ZJ1SVSnSY5XnWO3Ku74bUYi+F9hqSHTNfRdlpiaQKIqXvMTo3B1LwkR2EvRFlNnTeYIgAhaZOr4gZ4EA13TxEvHgMujNlFOui+BOw54qUhBx0Rygaf98UhMMPrlkTYM585JwAU6YIg1VvYF9FsOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RpgoC6OP; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416A6LJA109513;
	Tue, 6 Feb 2024 04:06:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707213981;
	bh=LRvdigaOf26+urly2C4NLurxlDvrtNRgxuQwOJ6FB9s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RpgoC6OPUMmP6031FJ1yb0QSjUbIZUICVI5r8RDYWWswtmQoJZkmRkoraStdJd/eF
	 sgBkFqbYw8B0jzd5lLBKyaQu5OX7bi7EGxf0dNe2NJN8ZgIMBlPeaC8l4PN9UrrZ87
	 +UuF78o3J/ghzJxDAi9eeDq/keC96SsJ4wBolF4M=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416A6Ln4065323
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 04:06:21 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 04:06:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 04:06:20 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416A68qu054893;
	Tue, 6 Feb 2024 04:06:17 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <j-choudhary@ti.com>
Subject: [PATCH v2 2/3] arm64: dts: ti: Introduce J722S family of SoCs
Date: Tue, 6 Feb 2024 15:36:07 +0530
Message-ID: <20240206100608.127702-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206100608.127702-1-vaishnav.a@ti.com>
References: <20240206100608.127702-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The J722S is a family of  application processors built for Automotive and
Linux Application development. J722S family of SoCs is a superset of the
AM62P SoC family and shares similar memory map, thus the nodes are being
reused from AM62P includes instead of duplicating the definitions.

Some highlights of J722S SoC (in addition to AM62P SoC features) are:
    * Two Cortex-R5F for Functional Safety or general-purpose usage and
      two C7x floating point vector DSP with Matrix Multiply Accelerator
      for deep learning.
    * Vision Processing Accelerator (VPAC) with image signal processor
      and Depth and Motion Processing Accelerator (DMPAC).
    * 7xUARTs, 3xSPI, 5xI2C, 2xUSB2, 2xCAN-FD, 3xMMC and SD, GPMC for
      NAND/FPGA connection, OSPI memory controller, 5xMcASP for audio,
      4xCSI-RX for Camera, 1 PCIe Gen3 controller, USB3.0 eCAP/eQEP,
      ePWM, among other peripherals.

For those interested, more details about this SoC can be found in the
Technical Reference Manual here:
	https://www.ti.com/lit/zip/sprujb3

Co-developed-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

checkpatch error is ignored for arch/arm64/boot/dts/ti/k3-pinctrl.h:
ERROR: Macros with complex values should be enclosed in parentheses

However, we do not need parentheses enclosing the values for this
macro as we do intend it to generate two separate values as has been
done for other similar platforms.

V1->V2:
  * Address feedback from Nishanth to reuse by including AM62P5 dtsi.
  * Remove bootph-all from root nodes.
  * Change License to GPL-2.0-only OR MIT as followed for other
    K3 files.

 arch/arm64/boot/dts/ti/k3-j722s.dtsi | 89 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-pinctrl.h  |  3 +
 2 files changed, 92 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
new file mode 100644
index 000000000000..c75744edb143
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for J722S SoC Family
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+#include "k3-am62p5.dtsi"
+
+/ {
+	model = "Texas Instruments K3 J722S SoC";
+	compatible = "ti,j722s";
+
+	cbass_main: bus@f0000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x00 0x000f0000 0x00 0x000f0000 0x00 0x00030000>, /* Main MMRs */
+			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
+			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
+			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
+			 <0x00 0x0070c000 0x00 0x0070c000 0x00 0x00000200>, /* USB1 debug trace */
+			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
+			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
+			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
+			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIE_0 */
+			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
+			 <0x00 0x0fd80000 0x00 0x0fd80000 0x00 0x00080000>, /* GPU */
+			 <0x00 0x0fd20000 0x00 0x0fd20000 0x00 0x00000100>, /* JPEGENC0_CORE */
+			 <0x00 0x0fd20200 0x00 0x0fd20200 0x00 0x00000200>, /* JPEGENC0_CORE_MMU */
+			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
+			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
+			 <0x00 0x301C0000 0x00 0x301C0000 0x00 0x00001000>, /* DPHY-TX */
+			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00080100>, /* CSI window */
+			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
+			 <0x00 0x30210000 0x00 0x30210000 0x00 0x00010000>, /* VPU */
+			 <0x00 0x30220000 0x00 0x30220000 0x00 0x00010000>, /* DSS1 */
+			 <0x00 0x30270000 0x00 0x30270000 0x00 0x00010000>, /* DSI-base1 */
+			 <0x00 0x30500000 0x00 0x30500000 0x00 0x00100000>, /* DSI-base2 */
+			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
+			 <0x00 0x31200000 0x00 0x31200000 0x00 0x00040000>, /* USB1 DWC3 Core window */
+			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA3UL */
+			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
+			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
+			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
+			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06408000>, /* DMSS */
+			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
+			 <0x00 0x68000000 0x00 0x68000000 0x00 0x08000000>, /* PCIe0 DAT0 */
+			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00040000>, /* OCSRAM */
+			 <0x00 0x78400000 0x00 0x78400000 0x00 0x00008000>, /* MAIN R5FSS0 ATCM */
+			 <0x00 0x78500000 0x00 0x78500000 0x00 0x00008000>, /* MAIN R5FSS0 BTCM */
+			 <0x00 0x7e000000 0x00 0x7e000000 0x00 0x00200000>, /* C7X_0 L2SRAM */
+			 <0x00 0x7e200000 0x00 0x7e200000 0x00 0x00200000>, /* C7X_1 L2SRAM */
+			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
+			 <0x06 0x00000000 0x06 0x00000000 0x01 0x00000000>, /* PCIe0 DAT1 */
+
+			 /* MCU Domain Range */
+			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
+			 <0x00 0x79000000 0x00 0x79000000 0x00 0x00008000>,
+			 <0x00 0x79020000 0x00 0x79020000 0x00 0x00008000>,
+			 <0x00 0x79100000 0x00 0x79100000 0x00 0x00040000>,
+			 <0x00 0x79140000 0x00 0x79140000 0x00 0x00040000>,
+
+			 /* Wakeup Domain Range */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>,
+			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
+			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>,
+			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>,
+			 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>;
+	};
+};
+
+/* Main domain overrides */
+
+&inta_main_dmss {
+	ti,interrupt-ranges = <7 71 21>;
+};
+
+&oc_sram {
+	reg = <0x00 0x70000000 0x00 0x40000>;
+	ranges = <0x00 0x00 0x70000000 0x40000>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 2a4e0e084d69..591be4489f37 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -59,6 +59,9 @@
 #define J721S2_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define J721S2_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
+#define J722S_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
+#define J722S_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
+
 #define J784S4_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define J784S4_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
-- 
2.34.1


