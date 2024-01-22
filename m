Return-Path: <linux-kernel+bounces-33210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6727836623
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FEC28DC52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA683FE43;
	Mon, 22 Jan 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P/tvF7iX"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10E3E477;
	Mon, 22 Jan 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935370; cv=none; b=BC0jGFxcjGXvOAFR6qFqb0UK1M027qZ3nEQhz6tIvY/qPpXUDRtpfDBIzs/ExPcOe1WK6G9rIStnYonNre4C/+VBL17/mY5R714on4o2bxIDMds9O1BV0qK1vPscxAKKBLoOmVAKKlmPNMMiIoLp07z4LAApTyJ/oUWVOs3RXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935370; c=relaxed/simple;
	bh=yn1d0VNKAyAV7lkKjKKhZxzzmDLqIJ320J6JzxiyEA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlDiQ/K32HiLzlVAnyVY50OSLKQKTyZa9B/SGFW6MhdIYnibuGm/O61Wefy+c/qRljryaKr0B4X6Esn6RnXemaJljKsAoyBVLja+dUFsUzawoXOPp4ABM1kN5OEQVb6niMgBfR3KRhmrZ6bmjSAEa8WJxrr4jmV8lhZhM9fwCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P/tvF7iX; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MEtiYn038208;
	Mon, 22 Jan 2024 08:55:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705935344;
	bh=IgLvqQ2esFmcvHXcKzHz/ujO3qKLVrVyC+W5YB13SoI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=P/tvF7iX5uJNgw1APxrX9oVWInZ0rO5C0TI4M2ROeMNa+PQ12QrZj8fVrQ/zj6Ml9
	 uFdg7kiJMQilPCGJqpqX+PWX9jC8bvApIrPLmxuGn3pxZIXIJfo0mOjhAfF0RzbW1W
	 UmwXxYSRLNnteKDuRHlaPW5umvlHfkjNV07hICdw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MEtiaC126210
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 08:55:44 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 08:55:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 08:55:44 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MEtiYE014469;
	Mon, 22 Jan 2024 08:55:44 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>, Ayush Singh <ayushdevel1325@gmail.com>,
        Jason
 Kridner <jkridner@beagleboard.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Wadim Egorov <w.egorov@phytec.de>
Subject: [PATCH V2 13/16] arm64: dts: ti: beagle*: Add MIT license along with GPL-2.0
Date: Mon, 22 Jan 2024 08:55:36 -0600
Message-ID: <20240122145539.194512-14-nm@ti.com>
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
license for device trees belonging to BeagleBoard.org Foundation
platforms. This allows for Linux kernel device tree to be used in
other Operating System ecosystems such as Zephyr or FreeBSD.

While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
with latest SPDX conventions (GPL-2.0 is deprecated).

While at this, update the copyright year to sync with current year
to indicate license change.

Cc: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Jason Kridner <jkridner@beagleboard.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Wadim Egorov <w.egorov@phytec.de>

Acked-by: Ayush Singh <ayushdevel1325@gmail.com>
Acked-by: Jason Kridner <jkridner@beagleboard.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Robert Nelson <robertcnelson@gmail.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Wadim Egorov <w.egorov@phytec.de>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v1:
* Picked up acks - all acks recieved

V1: https://lore.kernel.org/r/20240110140903.4090946-14-nm@ti.com

 .../boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso      | 4 ++--
 .../boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts            | 6 +++---
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts        | 8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso
index 5e80ca7033ba..3b4643b7d19c 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * ALINX AN5641 & Digilent PCam 5C - OV5640 camera module
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
index 5e1cbbc27c8f..81a2763d43c6 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Technexion TEVI-OV5640-*-RPI - OV5640 camera module
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index eadbdd9ffe37..600db09b8ad3 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -1,9 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * https://beagleplay.org/
  *
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
- * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Robert Nelson, BeagleBoard.org Foundation
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 2f954729f353..dfc9adacd511 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -1,9 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * https://beagleboard.org/ai-64
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
- * Copyright (C) 2022 Jason Kridner, BeagleBoard.org Foundation
- * Copyright (C) 2022 Robert Nelson, BeagleBoard.org Foundation
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Jason Kridner, BeagleBoard.org Foundation
+ * Copyright (C) 2022-2024 Robert Nelson, BeagleBoard.org Foundation
  */
 
 /dts-v1/;
-- 
2.43.0


