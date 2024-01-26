Return-Path: <linux-kernel+bounces-40549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A446F83E24B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F11C1C23173
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016922630;
	Fri, 26 Jan 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A9VAkVUQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E7F225CD;
	Fri, 26 Jan 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296406; cv=none; b=Q+g/8ZrumXW6EWeRx6zCNlufD4LNlmDpFpzGdu7soEd4y5mthfAre7tU1tL+EX7heOX2YJRM4s6tIpyMFZX7k0EaEYNQN6q88JkiajTEhWAetzYL1CekKHSkPw5Fvh3lzXLv9IlCUBlTou/jf3YmmpKp3LFKSRTLGhyW1Xi9hbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296406; c=relaxed/simple;
	bh=uWnUGLE/quS8brRKKnW9+bEaKmmv9xeEiJDJO/bueIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNdZr4FHIQbkLfrlGIzqJ349/+ZNr+jZA8LTm8Iij4lnaTMLDbGg53hsI2OvaxbpHnXboYdfkTXBrBPunF3E/5MZwO5BPohVa2VEPtiyjud/TQlLnfOPzzFkb3B2IF+D8dRS/WHaam/RnB/Y6l2DLngDZDhX9dxMAyLkOJlsxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A9VAkVUQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706296402;
	bh=uWnUGLE/quS8brRKKnW9+bEaKmmv9xeEiJDJO/bueIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9VAkVUQc7/Kh7UUa59Cy0SYU2VbCZW71P2fv/xWYQIdhj21ngy9hBjlK7gotdN5v
	 V5Hi35J3uHRA9nMEaWSi4JUI6KBBYDf/jHEyZPItOaDM8JTwIt3LBjPe1jByszkQSE
	 /rfjAkYjqoo6pS4P5c6Pb6dv48Lsr3R2MCfrOV3qfSBMRWKDsXcJ2x3hMLUqhQyPsF
	 2iFkjdhON5SbaeiNhIHEAhloARVHsK8VBqj6vlZGt/D/p0BbbFphm6RDTCV1D9tu0e
	 a2OZWZH6yIW3C82OTlNEvxbNksAI4tboSwyjnWcjIBBOoHWYRLQD5M2B+3N/xv1P2X
	 N2JLzIlhr2QMg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6205D37814B0;
	Fri, 26 Jan 2024 19:13:22 +0000 (UTC)
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
Subject: [PATCH v4 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
Date: Fri, 26 Jan 2024 21:13:16 +0200
Message-ID: <20240126191319.1209821-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
References: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   | 11 +--
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 72 +++++++++++++------
 2 files changed, 57 insertions(+), 26 deletions(-)

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
index 5e7cfbbebce6..0d1962980f57 100644
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
@@ -94,6 +80,48 @@ required:
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
+
+        reset-names:
+          minItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


