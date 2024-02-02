Return-Path: <linux-kernel+bounces-50672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C686D847C5D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49ED61F24D7D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3786126F27;
	Fri,  2 Feb 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF9t6KSP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBA685954;
	Fri,  2 Feb 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913307; cv=none; b=MbRcELY9HCoe7uDMebox6qQtbajU7bhjDQoQ55eLZtcI7pg7cRAFa4y9dKnP7VDimPYcqG84OaoMzjo4OVY6QpKrKGed3axCZy9hT1RCkju5KP0pH52gx7nxFuhSohYv+fIwC9qzmZE2Du2RFYSHAliBWtevQ9aWXv/sRaQl7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913307; c=relaxed/simple;
	bh=piSJZV9wP11DN45leIZQLdOe8OAXQLdIK19f/zlcWl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TN1aigFomZkzZid/f7CBN4XuU+yESioe87Tye4a+zppZL96W+3qcqzOdHk4AWTAchAyy5sWDAOo7YVD1b/4y0EWB3AgThYmGteyA0dNnzOExA9zIsR4MCd2gzar7KJm1pL27EC0vUk4CADF/3Bg5VolF0FaPlcZVIVBJXKBMOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF9t6KSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1EAC433F1;
	Fri,  2 Feb 2024 22:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706913307;
	bh=piSJZV9wP11DN45leIZQLdOe8OAXQLdIK19f/zlcWl4=;
	h=From:To:Cc:Subject:Date:From;
	b=jF9t6KSPmMvMVh1V9fW20wY/mwPs4yjcFfPG1BffzLlhv/w0/nHcX8v58Y9ztZIrp
	 GFxS/7N/aEfGij7jg5zy9l84eu1gVAQloefohZhnUJFwD42M0wUo0VLR696txWpT3i
	 xx5F9BEQhAhSFZfNd5rFVhKc4N5Lx1ZTvcwnZilOE+IMb/38zUI2e7BhFtT6cnKr/U
	 qzcFm9BvFUxtTcY40dym3jov6+J6WwrVbzNhrxJ1NxU6sdHOnxvv21RBF/Q1BmFERS
	 g0LGxkyuwnHERO1Y8rq1Al8K9KqHXzs/iQEh6WzC+G4ThXeKXZkBJiBElPyhFYbw4G
	 uKTDgsm1Ozqkw==
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: nvidia,tegra234-pinmux: Restructure common schema
Date: Fri,  2 Feb 2024 16:34:53 -0600
Message-ID: <20240202223454.1667383-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The structure of the NVIDIA Tegra234 common pinmux schema doesn't work
for restricting properties because a child node schema can't be extended
with additional properties from another schema defining the same child
node. The 2 child node schemas are evaluated independently as the
schemas are not recursively combined in any way.

As the common schema is almost all the child node schema anyways, just
remove the parent node from the common schema. Then add 'reg' and adjust
the $ref's in the users of the common schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/nvidia,tegra234-pinmux-aon.yaml   |  7 +-
 .../nvidia,tegra234-pinmux-common.yaml        | 84 ++++++++-----------
 .../pinctrl/nvidia,tegra234-pinmux.yaml       |  7 +-
 3 files changed, 45 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-aon.yaml b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-aon.yaml
index f3deda9f7127..db8224dfba2c 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-aon.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-aon.yaml
@@ -10,18 +10,21 @@ maintainers:
   - Thierry Reding <thierry.reding@gmail.com>
   - Jon Hunter <jonathanh@nvidia.com>
 
-$ref: nvidia,tegra234-pinmux-common.yaml
-
 properties:
   compatible:
     const: nvidia,tegra234-pinmux-aon
 
+  reg:
+    maxItems: 1
+
 patternProperties:
   "^pinmux(-[a-z0-9-]+)?$":
     type: object
 
     # pin groups
     additionalProperties:
+      $ref: nvidia,tegra234-pinmux-common.yaml
+
       properties:
         nvidia,pins:
           items:
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-common.yaml b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-common.yaml
index 4f9de78085e5..8cf9e4c915ff 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux-common.yaml
@@ -10,57 +10,43 @@ maintainers:
   - Thierry Reding <thierry.reding@gmail.com>
   - Jon Hunter <jonathanh@nvidia.com>
 
-properties:
-  reg:
-    items:
-      - description: pinmux registers
-
-patternProperties:
-  "^pinmux(-[a-z0-9-]+)?$":
-    type: object
-
-    # pin groups
-    additionalProperties:
-      $ref: nvidia,tegra-pinmux-common.yaml
-      # We would typically use unevaluatedProperties here but that has the
-      # downside that all the properties in the common bindings become valid
-      # for all chip generations. In this case, however, we want the per-SoC
-      # bindings to be able to override which of the common properties are
-      # allowed, since not all pinmux generations support the same sets of
-      # properties. This way, the common bindings define the format of the
-      # properties but the per-SoC bindings define which of them apply to a
-      # given chip.
-      additionalProperties: false
-      properties:
-        nvidia,function:
-          enum: [ gp, uartc, i2c8, spi2, i2c2, can1, can0, rsvd0, eth0, eth2,
-                  eth1, dp, eth3, i2c4, i2c7, i2c9, eqos, pe2, pe1, pe0, pe3,
-                  pe4, pe5, pe6, pe7, pe8, pe9, pe10, qspi0, qspi1, qpsi,
-                  sdmmc1, sce, soc, gpio, hdmi, ufs0, spi3, spi1, uartb, uarte,
-                  usb, extperiph2, extperiph1, i2c3, vi0, i2c5, uarta, uartd,
-                  i2c1, i2s4, i2s6, aud, spi5, touch, uartj, rsvd1, wdt, tsc,
-                  dmic3, led, vi0_alt, i2s5, nv, extperiph3, extperiph4, spi4,
-                  ccla, i2s1, i2s2, i2s3, i2s8, rsvd2, dmic5, dca, displayb,
-                  displaya, vi1, dcb, dmic1, dmic4, i2s7, dmic2, dspk0, rsvd3,
-                  tsc_alt, istctrl, vi1_alt, dspk1, igpu ]
+$ref: nvidia,tegra-pinmux-common.yaml
 
-        # out of the common properties, only these are allowed for Tegra234
-        nvidia,pins: true
-        nvidia,pull: true
-        nvidia,tristate: true
-        nvidia,schmitt: true
-        nvidia,enable-input: true
-        nvidia,open-drain: true
-        nvidia,lock: true
-        nvidia,drive-type: true
-        nvidia,io-hv: true
-
-      required:
-        - nvidia,pins
+properties:
+  nvidia,function:
+    enum: [ gp, uartc, i2c8, spi2, i2c2, can1, can0, rsvd0, eth0, eth2,
+            eth1, dp, eth3, i2c4, i2c7, i2c9, eqos, pe2, pe1, pe0, pe3,
+            pe4, pe5, pe6, pe7, pe8, pe9, pe10, qspi0, qspi1, qpsi,
+            sdmmc1, sce, soc, gpio, hdmi, ufs0, spi3, spi1, uartb, uarte,
+            usb, extperiph2, extperiph1, i2c3, vi0, i2c5, uarta, uartd,
+            i2c1, i2s4, i2s6, aud, spi5, touch, uartj, rsvd1, wdt, tsc,
+            dmic3, led, vi0_alt, i2s5, nv, extperiph3, extperiph4, spi4,
+            ccla, i2s1, i2s2, i2s3, i2s8, rsvd2, dmic5, dca, displayb,
+            displaya, vi1, dcb, dmic1, dmic4, i2s7, dmic2, dspk0, rsvd3,
+            tsc_alt, istctrl, vi1_alt, dspk1, igpu ]
+
+  # out of the common properties, only these are allowed for Tegra234
+  nvidia,pins: true
+  nvidia,pull: true
+  nvidia,tristate: true
+  nvidia,schmitt: true
+  nvidia,enable-input: true
+  nvidia,open-drain: true
+  nvidia,lock: true
+  nvidia,drive-type: true
+  nvidia,io-hv: true
 
 required:
-  - compatible
-  - reg
+  - nvidia,pins
+
+# We would typically use unevaluatedProperties here but that has the
+# downside that all the properties in the common bindings become valid
+# for all chip generations. In this case, however, we want the per-SoC
+# bindings to be able to override which of the common properties are
+# allowed, since not all pinmux generations support the same sets of
+# properties. This way, the common bindings define the format of the
+# properties but the per-SoC bindings define which of them apply to a
+# given chip.
+additionalProperties: false
 
-additionalProperties: true
 ...
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux.yaml
index 17b865ecfcda..f5a3a881dec4 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra234-pinmux.yaml
@@ -10,18 +10,21 @@ maintainers:
   - Thierry Reding <thierry.reding@gmail.com>
   - Jon Hunter <jonathanh@nvidia.com>
 
-$ref: nvidia,tegra234-pinmux-common.yaml
-
 properties:
   compatible:
     const: nvidia,tegra234-pinmux
 
+  reg:
+    maxItems: 1
+
 patternProperties:
   "^pinmux(-[a-z0-9-]+)?$":
     type: object
 
     # pin groups
     additionalProperties:
+      $ref: nvidia,tegra234-pinmux-common.yaml
+
       properties:
         nvidia,pins:
           items:
-- 
2.43.0


