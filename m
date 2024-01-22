Return-Path: <linux-kernel+bounces-33209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7352B836628
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252AAB283B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370A3FB3D;
	Mon, 22 Jan 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cq3rmssA"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE83E47F;
	Mon, 22 Jan 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935369; cv=none; b=sN7sLgppKR6EBQUwWzmPX20BvpeT51TjpLlr1eTAX65Xxs7C8xGe5gKFOeHekClHqYfxY7cA4Sd85SZVaQxu8cqkwqgDaxCsx/mj28DDiW+N9adct2hv8T+AbH2Gs7KaMAYprf98hq/CBo4q7OBY68KberaZFgAc8EnRN1OJo2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935369; c=relaxed/simple;
	bh=+qWD+LJsRRXJdlCPhHWaImCZvjjy/+g7HseuzOsgmVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpGsVEooF5NSCJXlkzgDNlPp6yg0RC6Pm3KY38j9IT4EizmiuLYfA4kugYBAFuKXjmcCTXOddXmd2R/jt+F1euENdy0Q+dqVWTjH/V2PTb5TeQ3i+IufUDTLd6/08It29GMCo3NIHdWTi47LVUWijltS5tB/yR+0Kbvwi1Ig+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cq3rmssA; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MEtiIG038199;
	Mon, 22 Jan 2024 08:55:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705935344;
	bh=/c10mgEhss9QNb4GLkftdw19N1nYRGYPeGLVbD1DDS0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cq3rmssAWur2/TydQf+DnCtR8rTDzIbnpJWQtTu0tVKbLQlfRX8NEXeDWyQpmuybD
	 Hoou7/a//MvvTXUanftodMDIIf+MWk2ultsH9jV7h9rbTne+t5isZ8/Y8rDKdwHvj9
	 neAz0SxARzawkJSo9snzkiTqItjvXtaRxSiBu9a8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MEtiC7012935
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 08:55:44 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 08:55:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 08:55:44 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MEthMg022007;
	Mon, 22 Jan 2024 08:55:43 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jerome Neanne <jneanne@baylibre.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Pierre Gondois
	<pierre.gondois@arm.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH V2 08/16] arm64: dts: ti: k3-j721e: Add MIT license along with GPL-2.0
Date: Mon, 22 Jan 2024 08:55:31 -0600
Message-ID: <20240122145539.194512-9-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145539.194512-1-nm@ti.com>
References: <20240122145539.194512-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Modify license to include dual licensing as GPL-2.0-only OR MIT
license for SoC and TI evm device tree files. This allows for Linux
kernel device tree to be used in other Operating System ecosystems
such as Zephyr or FreeBSD.

While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
with latest SPDX conventions (GPL-2.0 is deprecated).

While at this, update the TI copyright year to sync with current year
to indicate license change (and add it at least for one file which was
missing TI copyright).

Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Jerome Neanne <jneanne@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Pierre Gondois <pierre.gondois@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v1:
* Picked up acks

Pending Acks:
- "Alexander A. Klimov" <grandmaster@al2klimov.de>
- Peng Fan <peng.fan@nxp.com>
- Jerome Neanne <jneanne@baylibre.com>

V1: https://lore.kernel.org/r/20240110140903.4090946-9-nm@ti.com

 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts      | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso    | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso          | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi            | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi               | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi                       | 4 ++--
 10 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index fe5207ac7d85..8230d53cd696 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2019-2024 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Product Link: https://www.ti.com/tool/J721EXCPXEVM
  */
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
index 6a7d37575da1..f84aa9f94547 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
@@ -1,11 +1,11 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /**
  * DT Overlay for CPSW9G in RGMII mode using J7 GESI EXP BRD board with
  * J721E board.
  *
  * GESI Board Product Link: https://www.ti.com/tool/J7EXPCXEVM
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
index 0c82a13b65a4..4062709d6579 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
@@ -1,11 +1,11 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /**
  * DT Overlay for enabling PCIE0 instance in Endpoint Configuration with the
  * J7 common processor board.
  *
  * J7 Common Processor Board Product Link: https://www.ti.com/tool/J721EXCPXEVM
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
index d4c51ffc3d6b..8376fa4b6ee1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
@@ -1,9 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /**
  * DT Overlay for CPSW9G in QSGMII mode using J7 Quad Port ETH EXP Add-On Ethernet Card with
  * J721E board.
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 2569b4c08ffb..062a6fca5a31 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for J721E SoC Family Main Domain peripherals
  *
- * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/phy/phy-ti.h>
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index a74912d9e4da..40caa86e600f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for J721E SoC Family MCU/WAKEUP Domain peripherals
  *
- * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_mcu_wakeup {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 188dfe291a32..d49f433b356a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
  *
  * J721E SK URL: https://www.ti.com/tool/SK-TDA4VM
  */
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index a75611eec791..aaec8a0ef983 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2019-2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2019-2024 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Product Link: https://www.ti.com/tool/J721EXSOMXEVM
  */
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
index c2523279001b..927f7614ae7a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
@@ -1,4 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
 
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index a200810df54a..5a72c518ceb6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for J721E SoC Family
  *
- * Copyright (C) 2016-2019 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.43.0


