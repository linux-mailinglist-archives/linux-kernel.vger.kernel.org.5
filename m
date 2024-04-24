Return-Path: <linux-kernel+bounces-157583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB5D8B1331
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238621F28359
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23551D545;
	Wed, 24 Apr 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZbbfHqQk"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDB1FDD;
	Wed, 24 Apr 2024 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985595; cv=none; b=sqbORk1vmyBYRCF2r7/pVmQX2RSsxnQZyduOQ77k/Kq04a1ivKh4j+rYRdYmW6fZyqPn7cw4tbdRaf/jheNADfnj3B/1Qfs/KY2Ozx03bjSdAa+f9Ei+Etf9uIMs3K1ocYPkhVrMxl0NqYHLl4ck2bt0JxRoMd6HK0Y65jqucks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985595; c=relaxed/simple;
	bh=SWi698zF+BZdijoz1De2x7itihQIogUwFgQiH4l+iFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2oKiP0X3I24O/CRmAhcjT2BbzrcgFJQ06L5oMrZRhkTNLR9sAeLACE8DjRE/kZZwYnnNZ0v+oFXIw9ahwTB+vvRE6aCjV4xXTj4nHkuZN6Z8EWozwfMSP+QHVZF1q+uI3UdHTlCeBlvM/bdNA4O+IVtvbJmDSSz7yansM7DsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZbbfHqQk; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43OJ6E5G051404;
	Wed, 24 Apr 2024 14:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713985574;
	bh=zWDlDlmucuUnfBdvu41xX0KB/r0eFHTBC5jIEonL9Oc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZbbfHqQkM9kxkSC4iLrb8y80JrSxBrND6TEcvirqEtT55wsJ/ZKBletOJj1dc8S/5
	 +ZAVr/ZO2oKbmIkpdoJLcxw1AZAjhCUmKlTBcMlcFoNoifI027+I+oXue5ek6sYcP3
	 tSCf4q0tV6qQFVR1YkYR1N1UIviybSJgCBGP/Yak=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43OJ6Eke106507
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 14:06:14 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 14:06:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 14:06:13 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [10.219.51.241])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43OJ6DqO067070;
	Wed, 24 Apr 2024 14:06:13 -0500
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth
 Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hari Nagalla
	<hnagalla@ti.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v8 1/4] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
Date: Wed, 24 Apr 2024 14:06:09 -0500
Message-ID: <20240424190612.17349-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424190612.17349-1-afd@ti.com>
References: <20240424190612.17349-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Hari Nagalla <hnagalla@ti.com>

K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
The remote processor's life cycle management and IPC mechanisms are
similar across the R5F and M4F cores from remote processor driver
point of view. However, there are subtle differences in image loading
and starting the M4F subsystems.

The YAML binding document provides the various node properties to be
configured by the consumers of the M4F subsystem.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
new file mode 100644
index 0000000000000..3629ddd6efa8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI K3 M4F processor subsystems
+
+maintainers:
+  - Hari Nagalla <hnagalla@ti.com>
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+
+description: |
+  Some K3 family SoCs have Arm Cortex M4F cores. AM64x is a SoC in K3
+  family with a M4F core. Typically safety oriented applications may use
+  the M4F core in isolation without an IPC. Where as some industrial and
+  home automation applications, may use the M4F core as a remote processor
+  with IPC communications.
+
+$ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,am64-m4fss
+
+  power-domains:
+    maxItems: 1
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  reg:
+    items:
+      - description: IRAM internal memory region
+      - description: DRAM internal memory region
+
+  reg-names:
+    items:
+      - const: iram
+      - const: dram
+
+  resets:
+    maxItems: 1
+
+  firmware-name:
+    maxItems: 1
+    description: Name of firmware to load for the M4F core
+
+  mboxes:
+    description: |
+      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
+      communication with the remote processor. This property should match
+      with the sub-mailbox node used in the firmware image.
+    maxItems: 1
+
+  memory-region:
+    description: |
+      phandle to the reserved memory nodes to be associated with the
+      remoteproc device. The reserved memory nodes should be carveout nodes,
+      and should be defined with a "no-map" property as per the bindings in
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+      Optional memory regions available for firmware specific purposes.
+    maxItems: 8
+    items:
+      - description: regions used for DMA allocations like vrings, vring buffers
+                     and memory dedicated to firmware's specific purposes.
+    additionalItems: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,sci-proc-ids
+  - resets
+  - firmware-name
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
+            compatible = "shared-dma-pool";
+            reg = <0x00 0x9cb00000 0x00 0x100000>;
+            no-map;
+        };
+
+        mcu_m4fss_memory_region: m4f-memory@9cc00000 {
+            compatible = "shared-dma-pool";
+            reg = <0x00 0x9cc00000 0x00 0xe00000>;
+            no-map;
+        };
+    };
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mailbox0_cluster0: mailbox-0 {
+            #mbox-cells = <1>;
+        };
+
+        remoteproc@5000000 {
+            compatible = "ti,am64-m4fss";
+            reg = <0x00 0x5000000 0x00 0x30000>,
+                  <0x00 0x5040000 0x00 0x10000>;
+            reg-names = "iram", "dram";
+            ti,sci = <&dmsc>;
+            ti,sci-dev-id = <9>;
+            ti,sci-proc-ids = <0x18 0xff>;
+            resets = <&k3_reset 9 1>;
+            firmware-name = "am62-mcu-m4f0_0-fw";
+            mboxes = <&mailbox0_cluster0>, <&mbox_m4_0>;
+            memory-region = <&mcu_m4fss_dma_memory_region>,
+                            <&mcu_m4fss_memory_region>;
+         };
+    };
-- 
2.39.2


