Return-Path: <linux-kernel+bounces-33203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B18083662A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D955B22EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3013EA78;
	Mon, 22 Jan 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FpICclBf"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F183DBBF;
	Mon, 22 Jan 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935368; cv=none; b=M0sC1jA7x7VSDH/wEPFXO9sJpAJXNcRQiLyrmXKgLK/5LKN5q91j4FHvQlT6CC6xQnO/quOS1HmmPx4pGqJ7E6FX5Lzr8DhpzFT+q1TuJABPqU/cQ4t+bQqJEGA5/kj+FLzy5aZ0xyqiQrAvdagkp8NUVoadAFkGZwSqY0uxgl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935368; c=relaxed/simple;
	bh=hEcNpcJ4FU6Xe8WVU7tlxIJKdvo1pqWum95E5rC4dxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZ21Vf8aTRxoanb/xE6BqUt1fnC8gXCPNaOop4i7kKqT5GUfzAptHGR44/4DEP5WTLQON+4/HskKl2G79i5lWs3VlZgnqgeXWtvc4F1c4eP8f5gkjFipd6yrKo/eLU6ZKlYn6BLzwfS+p/uQXkc/vmry2zChzzka8zokNdtGKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FpICclBf; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MEtiax068546;
	Mon, 22 Jan 2024 08:55:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705935344;
	bh=1fVzmXZQGiRGeVvP23sJv3ZpWXKdIPBpwDON/0DwU+8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FpICclBfoFAwF9+17L4KOwpvDpcUALhmZRP0xcvdxO7TPLToYn4cjX+fNr1Ndu4n7
	 YKRy2afbNIP5zyyRrIaQKK3X38VbZns8RZnfLX5bDIDbHd01LkhrtQ0LinqvXqtjTy
	 74HQ415K9VHyC6eWEUkCPnwRKbZPo54v74gAHlZ4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MEtiRq126209
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 08:55:44 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 08:55:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 08:55:44 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MEtipK014472;
	Mon, 22 Jan 2024 08:55:44 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>, Garrett Giordano <ggiordano@phytec.com>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: [PATCH V2 14/16] arm64: dts: ti: phycore*: Add MIT license along with GPL-2.0
Date: Mon, 22 Jan 2024 08:55:37 -0600
Message-ID: <20240122145539.194512-15-nm@ti.com>
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
license for device trees belonging to PHYTEC Messtechnik GmbH and
PHYTEC America, LLC platforms. This allows for Linux kernel device
tree to be used in other Operating System ecosystems such as Zephyr or
FreeBSD.

While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
with latest SPDX conventions (GPL-2.0 is deprecated).

While at this, update the copyright year to sync with current year
to indicate license change.

Cc: Garrett Giordano <ggiordano@phytec.com>
Cc: Wadim Egorov <w.egorov@phytec.de>

Acked-by: Garrett Giordano <ggiordano@phytec.com>
Acked-by: Wadim Egorov <w.egorov@phytec.de>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v1:
* On request from Phytec folks[1], switch over to GPL-2.0-only OR MIT
* Picked up acks - all acks recieved

V1: https://lore.kernel.org/r/20240110140903.4090946-16-nm@ti.com

[1] https://lore.kernel.org/all/fb8232b1-9708-4b57-b67c-92ec6ccf9fd0@phytec.de/

 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi          | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts    | 4 ++--
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi          | 6 +++---
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 6 +++---
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index aa43e7407eee..3372a256c90f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
+ * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
  * Author: Wadim Egorov <w.egorov@phytec.de>
  *
  * Product homepage:
diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index 4bc0134c987d..086bd9421687 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
+ * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
  * Author: Wadim Egorov <w.egorov@phytec.de>
  *
  * Product homepage:
diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 1678e74cb750..0a4426229321 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -1,9 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
+ * Copyright (C) 2021-2024 PHYTEC America, LLC - https://www.phytec.com
  * Author: Matt McKee <mmckee@phytec.com>
  *
- * Copyright (C) 2022 PHYTEC Messtechnik GmbH
+ * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
  * Author: Wadim Egorov <w.egorov@phytec.de>
  *
  * Product homepage:
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 53b64e55413f..6f7b8d368724 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -1,9 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
+ * Copyright (C) 2021-2024 PHYTEC America, LLC - https://www.phytec.com
  * Author: Matt McKee <mmckee@phytec.com>
  *
- * Copyright (C) 2022 PHYTEC Messtechnik GmbH
+ * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
  * Author: Wadim Egorov <w.egorov@phytec.de>
  *
  * Product homepage:
-- 
2.43.0


