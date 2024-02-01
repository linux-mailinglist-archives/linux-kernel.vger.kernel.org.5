Return-Path: <linux-kernel+bounces-48964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD08463DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D5F28F2B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6A46537;
	Thu,  1 Feb 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e9c+F9MA"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C5405DB;
	Thu,  1 Feb 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827830; cv=none; b=Q6vWLlZ4bmt3Xw4mzBRGjG7d/Bnj1PLqZ2tF2pSHfqtv5e2IPpOHGhSRkSYd1zIDf+2qY46nizgm3eljs1tyO8Lofdl91bAOkp2OVq1r/P2I/+sEwXq1BBUjkM2oG8WMOp/zye6c3lY41fUEass3OCgprjnKxbY8g+kUwKNNXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827830; c=relaxed/simple;
	bh=G2qSnOue1vz/bMoi3dP9DCO/Deav6jrebRbh580fEOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrB9oavNwWNuBGEzZx4ClxpSj7hpKT06Crg6N7bUz1eKDVt2S2PV6uYDoDrfNJRoXWrQeMcOlHkLIxgEFGJ6dzCo7RBjh8D3K/rQGnA1B7+BZVcRq+zI1apRDVEs95hoCYf8qNOvsf58sWFBpp5qI967vV/coq2Ti4JFZYBd5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e9c+F9MA; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411MoOVx122751;
	Thu, 1 Feb 2024 16:50:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706827824;
	bh=EX4JeqpOf8I5Bdq4Od0/aYEyJhU67KFm3OIq7h0w9AI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=e9c+F9MA89eAZpKCzGvqGcuNzvIIrqNVPasf97KcYSHR1YtRg9cyocL3XjSbxoYeN
	 iSqBM38jJPm+S8MI5yYnjBJLG8pvede0geap3Hygzj6J5GgzxgETJk5D9lDNuIdnmZ
	 9jCVn09jq27Gex9iM05xu4CFeEtSnOmGsu/syaPY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411MoO8C038365
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 16:50:24 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 16:50:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 16:50:24 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411MoNUF109168;
	Thu, 1 Feb 2024 16:50:24 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v3 3/4] dt-bindings: arm: keystone: Convert keystone.txt to YAML
Date: Thu, 1 Feb 2024 16:50:21 -0600
Message-ID: <20240201225022.144476-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201225022.144476-1-afd@ti.com>
References: <20240201225022.144476-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Convert keystone.txt to ti,keystone.yaml.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes for v3:
 - Add tags and rebase

 Documentation/arch/arm/keystone/overview.rst  |  2 +-
 .../bindings/arm/keystone/keystone.txt        | 42 ---------------
 .../bindings/arm/keystone/ti,keystone.yaml    | 53 +++++++++++++++++++
 3 files changed, 54 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/keystone/keystone.txt
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,keystone.yaml

diff --git a/Documentation/arch/arm/keystone/overview.rst b/Documentation/arch/arm/keystone/overview.rst
index cd90298c493c7..6d8896ba9a6e2 100644
--- a/Documentation/arch/arm/keystone/overview.rst
+++ b/Documentation/arch/arm/keystone/overview.rst
@@ -65,7 +65,7 @@ specified through DTS. Following are the DTS used:
 
 The device tree documentation for the keystone machines are located at
 
-        Documentation/devicetree/bindings/arm/keystone/keystone.txt
+        Documentation/devicetree/bindings/arm/keystone/ti,keystone.yaml
 
 Document Author
 ---------------
diff --git a/Documentation/devicetree/bindings/arm/keystone/keystone.txt b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
deleted file mode 100644
index f310bad044830..0000000000000
--- a/Documentation/devicetree/bindings/arm/keystone/keystone.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-TI Keystone Platforms Device Tree Bindings
------------------------------------------------
-
-Boards with Keystone2 based devices (TCI66xxK2H) SOC shall have the
-following properties.
-
-Required properties:
- - compatible: All TI specific devices present in Keystone SOC should be in
-   the form "ti,keystone-*". Generic devices like gic, arch_timers, ns16550
-   type UART should use the specified compatible for those devices.
-
-SoC families:
-
-- Keystone 2 generic SoC:
-   compatible = "ti,keystone"
-
-SoCs:
-
-- Keystone 2 Hawking/Kepler
-   compatible = "ti,k2hk", "ti,keystone"
-- Keystone 2 Lamarr
-   compatible = "ti,k2l", "ti,keystone"
-- Keystone 2 Edison
-   compatible = "ti,k2e", "ti,keystone"
-- K2G
-   compatible = "ti,k2g", "ti,keystone"
-
-Boards:
--  Keystone 2 Hawking/Kepler EVM
-   compatible = "ti,k2hk-evm", "ti,k2hk", "ti,keystone"
-
--  Keystone 2 Lamarr EVM
-   compatible = "ti,k2l-evm", "ti, k2l", "ti,keystone"
-
--  Keystone 2 Edison EVM
-   compatible = "ti,k2e-evm", "ti,k2e", "ti,keystone"
-
--  K2G EVM
-   compatible = "ti,k2g-evm", "ti,k2g", "ti-keystone"
-
--  K2G Industrial Communication Engine EVM
-   compatible = "ti,k2g-ice", "ti,k2g", "ti-keystone"
diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,keystone.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,keystone.yaml
new file mode 100644
index 0000000000000..60af461af5ff9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,keystone.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/keystone/ti,keystone.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Keystone SoC architecture
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+description: |
+  Platforms based on Texas Instruments Keystone2 Multicore SoC architecture
+  shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: Keystone 2 Hawking/Kepler
+        items:
+          - enum:
+              - ti,k2hk-evm # Keystone 2 Hawking/Kepler EVM
+          - const: ti,k2hk
+          - const: ti,keystone
+
+      - description: Keystone 2 Lamarr
+        items:
+          - enum:
+              - ti,k2l-evm # Keystone 2 Lamarr EVM
+          - const: ti,k2l
+          - const: ti,keystone
+
+      - description: Keystone 2 Edison
+        items:
+          - enum:
+              - ti,k2e-evm # Keystone 2 Edison EVM
+          - const: ti,k2e
+          - const: ti,keystone
+
+      - description: K2G
+        items:
+          - enum:
+              - ti,k2g-evm # K2G EVM
+              - ti,k2g-ice # K2G Industrial Communication Engine EVM
+          - const: ti,k2g
+          - const: ti,keystone
+
+additionalProperties: true
+
+...
-- 
2.39.2


