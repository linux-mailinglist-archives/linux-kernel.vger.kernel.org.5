Return-Path: <linux-kernel+bounces-33199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8998365EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA7D1F25119
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801BA3D993;
	Mon, 22 Jan 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CfWgaLKK"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AB3D960;
	Mon, 22 Jan 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935362; cv=none; b=KJGXr9nMzCModqcoGe2tWQaLFNKW/foHiaiK1hTpmDHV8JptoUlPPIw3kINp4Lu6J1yXFpvKT3SGws1rk34c7nSkwptxAhiIAhLL+uKJAkZ3P4mrOL5JvEojUvKK7fL8xUN9zIXR/C1ubX1ufTa1ixx0H6dzM4mesg368w8fMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935362; c=relaxed/simple;
	bh=syEHF+sB/EqvKnmAygQVyOBV3Th0rG1TeF+ThAqiFNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TD7WQeV7oVKm4gGEX+SO2wkwk9IbwD8zzot1ecwD5ze3RaE3LjrmCIbEtVDj4dBtA5xxNBO+JcnzrNGjbKdZDxtWaLIy8PadfyQD6Hb3RitD3PgVgA6Uv71t7oOi6c1wn7NE7UTWa6NLSqLNzcBqnXlUZhkUR9+yvP6CArdureY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CfWgaLKK; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MEtiXc045416;
	Mon, 22 Jan 2024 08:55:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705935344;
	bh=gBlcI2wvTDBYfoYHdYu6nnxF8xzhDRpb9NYUIlilTYs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CfWgaLKKkwWftLY8E83/QPioSd2o1jODmntLqFS6hdb13w/xXejhIdkmZ/ojWHA9k
	 b7otAu15u6goCjFyIKPQ8hHM6EBkIMwjOvS+Oh7GfDUvxyBsxQNMtxHqixme0mcGiM
	 h77ziFqOcdBoo1E7PAmLPohJVpIUkk1LO2/6fLmo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MEti24126215
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 08:55:44 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 08:55:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 08:55:44 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MEtiB3022013;
	Mon, 22 Jan 2024 08:55:44 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>, Chao Zeng <chao.zeng@siemens.com>,
        Jan Kiszka
	<jan.kiszka@siemens.com>, Le Jin <le.jin@siemens.com>,
        Tony Lindgren
	<tony@atomide.com>
Subject: [PATCH V2 15/16] arm64: dts: ti: iot2050*: Clarify GPL-2.0 as GPL-2.0-only
Date: Mon, 22 Jan 2024 08:55:38 -0600
Message-ID: <20240122145539.194512-16-nm@ti.com>
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

SPDX identifier GPL-2.0 has been deprecated since license list version
3.0. Use GPL-2.0-only to be specific.

Cc: Chao Zeng <chao.zeng@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Le Jin <le.jin@siemens.com>

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v1:
* Picked up acks - all acks recieved

V1: https://lore.kernel.org/r/20240110140903.4090946-15-nm@ti.com

 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi        | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi        | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi            | 2 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi    | 2 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts        | 2 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts            | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts      | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts     | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts         | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
index 1d1979859583..c424fef19d5f 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2021-2023
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
index e9b57b87e42e..5eeeca27dee6 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 61a634afaa4f..00520c75e0f5 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
index 1d6cddb11991..c927c8679017 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
index c62549a4b436..ec62dd7921d6 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
index 87928ff28214..4968a47f31ea 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
index 3864ec54e371..ae842b85b70d 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
index bd6f2e696e94..8f559f4e7dda 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2023
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
index f00dc86d01b9..173c941b1c4b 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
index 077f165bdc68..48b908c19ef7 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
-- 
2.43.0


