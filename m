Return-Path: <linux-kernel+bounces-155299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E318AE889
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF501F2519A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405D13959B;
	Tue, 23 Apr 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgH/8sDd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD0136983;
	Tue, 23 Apr 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880012; cv=none; b=j/07sEKk1+yPvRuqE/4SUcHG1ePk2i6E3aZwNbgVccEk3KvXKjVS8rsSGDEDEv0R18DwbVcBxNP6WUUpEeN4HiotF3q/SzQD0/fBsMxhUKPpzRBB2Du2FfcQKXmWZ4luwzYQw9Z2lb2oZjsB3DxFPpKTkJdPeCsY48n11D1H38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880012; c=relaxed/simple;
	bh=1fUfoe4zZBmvWWiSJkd0f4oR3lZr2TQcJzLpPSJYlVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYc3EYFIu0Is0qtgAjkuv7vdkMu3i5Rs8dUy6SBxYSCEUur0/o10oggCXaCb9d1dHgrmfo3AgeIpKEH2fF5spM6dUebtb2SWF0eFstosLvV8FR4POlcDzSiQYeScYzns+e+KiE9CRu+m3RZkF6mOaMHAikwZft3SNJupWB7K4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgH/8sDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DA4C32782;
	Tue, 23 Apr 2024 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880012;
	bh=1fUfoe4zZBmvWWiSJkd0f4oR3lZr2TQcJzLpPSJYlVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgH/8sDdwhaeLtvbmI78nqoTtpQStgP8MFrzaAJUUNeNS4PleoYJG/4u7obcPN340
	 gt2Jt3zS6KF/aDEIg6nlV0vQ7vccKGmF6N3misp9r3GHxODtW9TO58d9S5Jnb6W3tf
	 YeUF0tY+zkOnBVXF2/xxwRgx3BALMnS8bfJVsh45i32IVUvQ7RDFHVoaNjroGa1AHU
	 +eNjm0GNMPUheLb0xqR/WK1fpsk8nGSb2KjXuClhVjL7qaZ+cModmPM9mdTsT41krG
	 6hKE6N8v78E36wky6D0qs/MsPs07Gmhw3/j5yabiFJmonuhSXF4LtZOcmZFJ+JrXz1
	 Oya8pd6Tdg5UA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rzGTy-000000008Kg-0QDi;
	Tue, 23 Apr 2024 15:46:50 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH 1/6] dt-bindings: HID: i2c-hid: add dedicated Ilitek ILI2901 schema
Date: Tue, 23 Apr 2024 15:46:06 +0200
Message-ID: <20240423134611.31979-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423134611.31979-1-johan+linaro@kernel.org>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Ilitek ILI2901 touch screen controller was apparently incorrectly
added to the Elan eKTH6915 schema simply because it also has a reset
gpio and is currently managed by the Elan driver in Linux.

The two controllers are not related even if an unfortunate wording in
the commit message adding the Ilitek compatible made it sound like they
were.

Add a dedicated schema for the ILI2901 which does not specify the I2C
address (which is likely 0x41 rather than 0x10 as for other Ilitek touch
controllers) to avoid cluttering the Elan schema with unrelated devices
and to make it easier to find the correct schema when adding further
Ilitek controllers.

Fixes: d74ac6f60a7e ("dt-bindings: HID: i2c-hid: elan: Introduce Ilitek ili2901")
Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/input/elan,ekth6915.yaml         |  5 +-
 .../bindings/input/ilitek,ili2901.yaml        | 66 +++++++++++++++++++
 2 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili2901.yaml

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
index dc4ac41f2441..3e2d216c6432 100644
--- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -18,9 +18,8 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - elan,ekth6915
-      - ilitek,ili2901
+    items:
+      - const: elan,ekth6915
 
   reg:
     const: 0x10
diff --git a/Documentation/devicetree/bindings/input/ilitek,ili2901.yaml b/Documentation/devicetree/bindings/input/ilitek,ili2901.yaml
new file mode 100644
index 000000000000..1abeec768d79
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ilitek,ili2901.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ilitek,ili2901.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI2901 touchscreen controller
+
+maintainers:
+  - Jiri Kosina <jkosina@suse.com>
+
+description:
+  Supports the Ilitek ILI2901 touchscreen controller.
+  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ilitek,ili2901
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  panel: true
+
+  reset-gpios:
+    maxItems: 1
+
+  vcc33-supply: true
+
+  vccio-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vcc33-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen@41 {
+        compatible = "ilitek,ili2901";
+        reg = <0x41>;
+
+        interrupt-parent = <&tlmm>;
+        interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+        reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+        vcc33-supply = <&pp3300_ts>;
+      };
+    };
-- 
2.43.2


