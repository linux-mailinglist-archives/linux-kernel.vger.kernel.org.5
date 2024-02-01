Return-Path: <linux-kernel+bounces-48963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A4D8463D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34EC1F289B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD94644C;
	Thu,  1 Feb 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LQi/SdQG"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8741211;
	Thu,  1 Feb 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827830; cv=none; b=SO+chLuPgrX5bj0zutM94/uH3A3auUBQbH+118dsYFhAc13rWuXjZbcJDDdsgq+C/XAYIrvUU+BxqwO9IstydwVMLo/lbgypsRjqBybtXzKPg+fnAfohX9BUJlyRQ9QE/cA9d7JoKsBuRbEvQHKI5m4IZoZHUe1wmqnvIue6K0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827830; c=relaxed/simple;
	bh=M40w82G393MWoyZ27EB6SJ0A2OkBbmfdjU/T868ERGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWV7Aa8ejY+o0COYhsKi9S9ypUDcua9UGlMZD/OkiMGfPsOoqP41gU85e/qC/JzGxBA0qr6D0/viPsBrby2CXMlO1dlFSDvIN71ic0MoNKduBzpn6PNojU6GKwOfWFIjgHkvCAyw7apbbqVP3/97mY0oib6CCe3Uh5YzWoJOVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LQi/SdQG; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411MoOCd068936;
	Thu, 1 Feb 2024 16:50:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706827824;
	bh=i6CmkTYh23pJDur+/EJJvrX9QKtYRf4T4sSrBNh9+6U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LQi/SdQGMczrdcFolY7s4qOjlrL/rnqbsMxBv/Yu+fhLd3+pzRVQ00k8exgkGRMtS
	 rw484iZqOA+5hVwivu5k3tIp6VeQ+6rzKwUzIWbq5THGy4dQPocJegF2NuKh5CWrlU
	 GEbiRUQ9dvz5QhqWGBZhx5guABqN+AQmjrYwmp4w=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411MoOmZ094249
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 16:50:24 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 16:50:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 16:50:24 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411MoNUE109168;
	Thu, 1 Feb 2024 16:50:23 -0600
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
Subject: [PATCH v3 2/4] dt-bindings: clock: Convert keystone-gate.txt to YAML
Date: Thu, 1 Feb 2024 16:50:20 -0600
Message-ID: <20240201225022.144476-2-afd@ti.com>
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

Convert keystone-gate.txt to ti,keystone,psc-clock.yaml.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes for v3:
 - Add tags and rebase
 - Update reference in keystone-gate.txt

 .../bindings/clock/keystone-gate.txt          | 29 ---------
 .../bindings/clock/ti,keystone,psc-clock.yaml | 59 +++++++++++++++++++
 .../bindings/remoteproc/ti,keystone-rproc.txt |  2 +-
 3 files changed, 60 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/keystone-gate.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti,keystone,psc-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/keystone-gate.txt b/Documentation/devicetree/bindings/clock/keystone-gate.txt
deleted file mode 100644
index c5aa187026e3a..0000000000000
--- a/Documentation/devicetree/bindings/clock/keystone-gate.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Status: Unstable - ABI compatibility may be broken in the future
-
-Binding for Keystone gate control driver which uses PSC controller IP.
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : shall be "ti,keystone,psc-clock".
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : parent clock phandle
-- reg :	psc control and domain address address space
-- reg-names : psc control and domain registers
-- domain-id : psc domain id needed to check the transition state register
-
-Optional properties:
-- clock-output-names : From common clock binding to override the
-			default output clock name
-Example:
-	clkusb: clkusb {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk16>;
-		clock-output-names = "usb";
-		reg = <0x02350008 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/ti,keystone,psc-clock.yaml b/Documentation/devicetree/bindings/clock/ti,keystone,psc-clock.yaml
new file mode 100644
index 0000000000000..e65b7383ca4a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,keystone,psc-clock.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ti,keystone,psc-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Keystone gate control driver which uses PSC controller IP
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+properties:
+  compatible:
+    const: ti,keystone,psc-clock
+
+  reg:
+    items:
+      - description: PSC control registers
+      - description: Domain registers
+
+  reg-names:
+    items:
+      - const: control
+      - const: domain
+
+  domain-id:
+    description: PSC domain id needed to check the transition state register
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  clocks:
+    maxItems: 1
+
+  clock-output-names:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - domain-id
+  - clocks
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clkusb@2350008 {
+        compatible = "ti,keystone,psc-clock";
+        reg = <0x02350008 0xb00>, <0x02350000 0x400>;
+        reg-names = "control", "domain";
+        domain-id = <0>;
+        clocks = <&chipclk16>;
+        clock-output-names = "usb";
+        #clock-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
index 463a97c11eff3..08bc83ecfd3f9 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
+++ b/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
@@ -75,7 +75,7 @@ SoCs only:
 
 - clocks: 		Should contain the device's input clock, and should be
 			defined as per the bindings in,
-			Documentation/devicetree/bindings/clock/keystone-gate.txt
+			Documentation/devicetree/bindings/clock/ti,keystone,psc-clock.yaml
 
 The following are mandatory properties for Keystone 2 66AK2G SoCs only:
 
-- 
2.39.2


