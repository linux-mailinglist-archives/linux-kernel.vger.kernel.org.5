Return-Path: <linux-kernel+bounces-6165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 970B6819544
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246C31F26009
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF48440B;
	Wed, 20 Dec 2023 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="skT5ltiL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB4567D;
	Wed, 20 Dec 2023 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703032115;
	bh=60WvtqZegeWvB0tamY/8ektCCEV6OJAa6Oke2f1GXLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skT5ltiLsjQGqvughCqz7YutY0JwGX80oJ7EYNjWxm1TbfNEPEBja3kh5TKsWKeZ/
	 8HXk7NcRSWZllkKAGw78Jl/bkug5AtGTpeLKUX/7l5Xg8nTlRExIZvX1CPPyJtaj4x
	 +M2wnE07064EccN4PC7Q1m05uCwawGioszgw4BCvR5XPpqSkXL/gL3HqMuqKmqiWpF
	 J7DFdAXizOUgthwhMFAeuSujgy/nUvMI6DocMfO+Pj/IMdSAbje/Z4KnJUxGkMIUuv
	 xQkUhVoHD9j7yYQIFOsbpAI7yITLE4MgqjKBycUhAdNkUeDm+lhGtxtRjZR+MZ69yN
	 YpIgF/+2OVPnA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D55593781F86;
	Wed, 20 Dec 2023 00:28:34 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
Date: Wed, 20 Dec 2023 02:28:22 +0200
Message-ID: <20231220002824.2462655-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220002824.2462655-1-cristian.ciocaltea@collabora.com>
References: <20231220002824.2462655-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Synopsys DesignWare MAC found on StarFive JH7100 SoC is mostly
similar to the newer JH7110, but it requires only two interrupts and a
single reset line, which is 'ahb' instead of the commonly used
'stmmaceth'.

Since the common binding 'snps,dwmac' allows selecting 'ahb' only in
conjunction with 'stmmaceth', extend the logic to also permit exclusive
usage of the 'ahb' reset name.  This ensures the following use cases are
supported:

  JH7110: reset-names = "stmmaceth", "ahb";
  JH7100: reset-names = "ahb";
  other:  reset-names = "stmmaceth";

Also note the need to use a different dwmac fallback, as v5.20 applies
to JH7110 only, while JH7100 relies on v3.7x.

Additionally, drop the reset description items from top-level binding as
they are already provided by the included snps,dwmac schema.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   | 11 ++-
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 75 +++++++++++++------
 2 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..90c4db178c67 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -95,6 +95,7 @@ properties:
         - snps,dwmac-5.20
         - snps,dwxgmac
         - snps,dwxgmac-2.10
+        - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
 
   reg:
@@ -144,10 +145,12 @@ properties:
       - description: AHB reset
 
   reset-names:
-    minItems: 1
-    items:
-      - const: stmmaceth
-      - const: ahb
+    oneOf:
+      - items:
+          - enum: [stmmaceth, ahb]
+      - items:
+          - const: stmmaceth
+          - const: ahb
 
   power-domains:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 5e7cfbbebce6..f5f0bff5be0f 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -16,16 +16,20 @@ select:
     compatible:
       contains:
         enum:
+          - starfive,jh7100-dwmac
           - starfive,jh7110-dwmac
   required:
     - compatible
 
 properties:
   compatible:
-    items:
-      - enum:
-          - starfive,jh7110-dwmac
-      - const: snps,dwmac-5.20
+    oneOf:
+      - items:
+          - const: starfive,jh7100-dwmac
+          - const: snps,dwmac
+      - items:
+          - const: starfive,jh7110-dwmac
+          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -46,24 +50,6 @@ properties:
       - const: tx
       - const: gtx
 
-  interrupts:
-    minItems: 3
-    maxItems: 3
-
-  interrupt-names:
-    minItems: 3
-    maxItems: 3
-
-  resets:
-    items:
-      - description: MAC Reset signal.
-      - description: AHB Reset signal.
-
-  reset-names:
-    items:
-      - const: stmmaceth
-      - const: ahb
-
   starfive,tx-use-rgmii-clk:
     description:
       Tx clock is provided by external rgmii clock.
@@ -94,6 +80,51 @@ required:
 allOf:
   - $ref: snps,dwmac.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7100-dwmac
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 2
+
+        interrupt-names:
+          minItems: 2
+          maxItems: 2
+
+        resets:
+          maxItems: 1
+
+        reset-names:
+          const: ahb
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-dwmac
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          maxItems: 3
+
+        interrupt-names:
+          minItems: 3
+          maxItems: 3
+
+        resets:
+          minItems: 2
+          maxItems: 2
+
+        reset-names:
+          items:
+            - const: stmmaceth
+            - const: ahb
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


