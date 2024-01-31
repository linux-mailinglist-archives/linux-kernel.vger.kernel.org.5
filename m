Return-Path: <linux-kernel+bounces-47244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09240844AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B183F1F2BB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4353AC14;
	Wed, 31 Jan 2024 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tjvEzXJd"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F83383A4;
	Wed, 31 Jan 2024 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739609; cv=none; b=el4IgLZlNUz2o3m2UNUSIDwFteyFlGe9B/0ZpeCTyEB9mBtCPB4d0z1uYYEdxPlEJHaDmB/ELw8IWbXx/OO8Zpx5C9Gve0/hFLSfLlith0JPMg6EMCtw8AsQxxvGUx9PyG/kSadLDeikfdNqRbXrrccka+R7zXzEjlWcP0yYQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739609; c=relaxed/simple;
	bh=bTBSyAWO+uR3Dr01EJDzUVOpbsMhuSfmMb5DDrgVaWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=os5kNUn2JVSyETplaKaUNpc3W8HhDFDyCKrAQQdRzd+/NPV8ux7kvs7NH4nEy9ZhCKN1FLym2jJ48e0cClbaaXQ0yqCJfE+OCTM0nNYzMQMAMu6qi5UrZN/G4XejVx/ZPtjRMQrLrWJotg/JTpmBx2quPnC/4W8D0vQ0lFeMVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tjvEzXJd; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VMK0VA010373;
	Wed, 31 Jan 2024 16:20:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706739600;
	bh=eN3oPr+M4EypKKu046DK8GJ27aJRTrtTuWvBbhbnFeE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tjvEzXJdiVDGJgIzny2vLrGdXFezokbLAiE3Vu/6kJCU5vwE1uNKPin+sid+0S6Rt
	 jOHCdbEJKAjO5BwsMdaSw5IPr5F8/C20IKSrDX+0Vaa6dSxp7mG7nTIb3uW1bw07e3
	 DIAL77wHFiU5aEXCdRXPNEHdvb5Cl92cUl0vtJmk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VMK0Wd080790
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 16:20:00 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 16:19:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 16:19:59 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VMJwx3102504;
	Wed, 31 Jan 2024 16:19:59 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 01/12] dt-bindings: power: reset: Document ti,sci-reboot compatible
Date: Wed, 31 Jan 2024 16:19:46 -0600
Message-ID: <20240131221957.213717-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131221957.213717-1-afd@ti.com>
References: <20240131221957.213717-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This calls into the system firmware using TI-SCI to reboot the system.
Used as a fallback when PSCI is unable or not available to reboot
the system.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../bindings/power/reset/ti,sci-reboot.yaml   | 33 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ti,sci-reboot.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/ti,sci-reboot.yaml b/Documentation/devicetree/bindings/power/reset/ti,sci-reboot.yaml
new file mode 100644
index 0000000000000..aa628be33d122
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/ti,sci-reboot.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/ti,sci-reboot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI-SCI reboot controller
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+description: |
+  Some TI SoCs contain a system controller (like the Power Management Micro
+  Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for controlling
+  the state of the various hardware modules present on the SoC. Communication
+  between the host processor running an OS and the system controller happens
+  through a protocol called TI System Control Interface (TI-SCI protocol).
+
+  This reboot controller node uses the TI SCI protocol to perform a device reboot.
+
+  Must be a child node of the associated TI-SCI system controller node.
+
+properties:
+  compatible:
+    const: ti,sci-reboot
+
+additionalProperties: false
+
+examples:
+  - |
+    k3_reboot: reboot-controller {
+        compatible = "ti,sci-reboot";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8999497011a26..45983bb174fe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21751,6 +21751,7 @@ F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
+F:	Documentation/devicetree/bindings/power/reset/ti,sci-reboot.yaml
 F:	Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
 F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
 F:	drivers/clk/keystone/sci-clk.c
-- 
2.39.2


