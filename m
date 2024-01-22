Return-Path: <linux-kernel+bounces-33197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF218365E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2511F223CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3753D57C;
	Mon, 22 Jan 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sr3GRr+F"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092A3CF45;
	Mon, 22 Jan 2024 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935360; cv=none; b=QybjGWQ2bpGCjqu4g8gzBLO5K1dauPKoqMnPphbBQh1HzgZ2ld2KpLJ4zLrGikPM4Vn34KcwYj5XXz2dkOK18228VUvd8QJGsRuzcw5WQBX7Tz4XPj2ZGRt3sOsCvDg2pGfraO8OylkGhW2ruqktt7VsH6iVjl70L4FIwQHDWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935360; c=relaxed/simple;
	bh=PAbio/agq2JeBhY0Nz4bvSnf/3VVn121onf6wpKJeuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvCOtLE/oFRwAId1IAq3bMgPAKB22frqqC2sgOOgMPqHknMAL9wqrgbm76eUAX9V11nSUTlShVO0isLQmkfHmi/Dnpa90UuWS+Im4ta1UkMIN9EhLyngIcAq3DzuzLKEEyAoKoxlYZ3hoHrlRBtuQdwA5X3k33FN9lQgSiIfoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sr3GRr+F; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MEtjJq045424;
	Mon, 22 Jan 2024 08:55:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705935345;
	bh=boGJjrJeLQa81r8lwI4Pesuw8g6i+d8lW/ce2StQqcI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Sr3GRr+FaQuVJfRnQp7qlDf/0mHs80XW8ngxabCgZEE4G0X1bzKFZzFZ1Ve8marH8
	 oPeHQ76MoVEAlZNclSKh1KmkCoami8M3sHSn/1o6j0Pwx2mBNeuMWJ4/C+WV8a8sop
	 vtToqxVpcL4L7MsrNP3kagwbmR9T0eakgcr4Uiuc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MEtjuw005343
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 08:55:45 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 08:55:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 08:55:43 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MEthh2022003;
	Mon, 22 Jan 2024 08:55:43 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>, Esteban Blanc <eblanc@baylibre.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre Gondois
	<pierre.gondois@arm.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH V2 07/16] arm64: dts: ti: k3-j7200: Add MIT license along with GPL-2.0
Date: Mon, 22 Jan 2024 08:55:30 -0600
Message-ID: <20240122145539.194512-8-nm@ti.com>
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

Cc: Esteban Blanc <eblanc@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Esteban Blanc <eblanc@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Pierre Gondois <pierre.gondois@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v1:
* Picked up acks - all acks recieved

V1: https://lore.kernel.org/r/20240110140903.4090946-8-nm@ti.com

 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts      | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi            | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi                | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi               | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi                       | 4 ++--
 7 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index cee2b4b0eb87..1c87271971f3 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso b/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
index 32d905235ed7..6432ca08ee8e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
@@ -1,9 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /**
  * DT Overlay for CPSW5G in QSGMII mode using J7 Quad Port ETH EXP Add-On Ethernet Card with
  * J7200 board.
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index da67bf8fe703..2d9eda7b3132 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for J7200 SoC Family Main Domain peripherals
  *
- * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 / {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 60b26374ae0c..7596ecc0f683 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for J7200 SoC Family MCU/WAKEUP Domain peripherals
  *
- * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_mcu_wakeup {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index ea47f10d393a..7a06797b5e80 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
index e7e3a643a6f0..2d22a95a6fdb 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
@@ -1,4 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
 
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
index ef73e6d7e858..d411911fdf71 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for J7200 SoC Family
  *
- * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.43.0


