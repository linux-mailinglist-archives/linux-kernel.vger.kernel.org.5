Return-Path: <linux-kernel+bounces-30532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA00831FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA0A28389E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4572E82B;
	Thu, 18 Jan 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fvI5p/Pn"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F12E630
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607667; cv=none; b=J+VC+OcbmRRseCmrmWYFzhWfIwcNgm9kdVDFhalcYDn19NZo4gN115+aOkjRh9/IVhpmB4o/HX1fZi7NQdMxAoyHztK7G3MyLFJbLxNfkkrpbG9yZO8hW5qaxlzny+f2JlNnRfyJv/McaRdG+gRByxPBt3KzfQ1ZFFnaty+z0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607667; c=relaxed/simple;
	bh=uHKk+xokRpnLbIS+v0V7v/UWZ2+XmvxUQ9xR0XOGAi4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5mwevOhw6logNpz3sONaIWa3EVEPKb3xkzp4xcWfdjeUpHKBoSpS6IhOnB+ooEq2/NppBcebGfRUFCGMfx2MOtGVgJBVI1UQVdbnKcbsTQFKl7dXeLCR4F0KA+mepDEw0zQKt5uP0JNBs8hyxvo+wk9LNcLZz/YtFFEjM2cK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fvI5p/Pn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28be8ebcdc1so87170a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705607664; x=1706212464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+1SWW+Ig8UbJFSMxb59hrypayblGZkJ0hxIP2opRhk=;
        b=fvI5p/PnoWHIWI94TWdyu4xJ6KlSp/qmazATN5xTZfZSDWfJUJ0Dzt7IqSqs/KQV9c
         wRz7iYR3zwjBJFkSVU3EsyEZNgfpQpLUQXDjYczK91DZOlaD3ovsXW5SUl5vj60+46a8
         wZ5lrqIv0JDmHul2Bk1LZQTgQtb6CHQFVQ/5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607664; x=1706212464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+1SWW+Ig8UbJFSMxb59hrypayblGZkJ0hxIP2opRhk=;
        b=F0yuw0SfHz0A7mw8Jsz3un3dcy5Kt1vNURQw+lIGMT0cGf8cFDl680XPPrFJRDDCaG
         gDRSBXnMoEl0ed5BrrQHTZjlXGiIjKhQ1247p4+gdYm3UE/7nxsi9+HXItkng7lB5+bH
         MnhBIjCxwb4MV8ye2BSvXuuEpOL5N0E4F+IiCa6iLNKP14yUdye+OfWPxs2rksI74yY3
         rATJib0fQsEYN4yIvaKrZVnmR60E03Yv4tLCC6Vdbq8IEECHunCpo9tWLTPcXRDx+I7j
         +WYcg227WQxUUrg9l1FaBT+MNg7xyIYmJA4aJSMPHU5M8CKEBGOqAW9tXR2l+lY6wOuZ
         ZI5g==
X-Gm-Message-State: AOJu0YyTtPSEwLApNMGkyXA/0JDyCcJFs11R9z29JNliA3cCIU5/2hBk
	G7UMcTnJdun6d6NuLV3AlA6xUueNNwe5bTURBJsFf7Yl7a5VVhNWuPG7Z6dpXA==
X-Google-Smtp-Source: AGHT+IFJN5qdqCj4U1EPyvoOMfY4T24rq4BxUvtFH94/vWLwCV5OWIm6tnON7+tYz1c8hDwFg68IcQ==
X-Received: by 2002:a17:90a:9a94:b0:290:4a:bfc0 with SMTP id e20-20020a17090a9a9400b00290004abfc0mr1068043pjp.4.1705607664535;
        Thu, 18 Jan 2024 11:54:24 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id rr12-20020a17090b2b4c00b0028d9b5d41edsm2263805pjb.38.2024.01.18.11.54.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:54:24 -0800 (PST)
From: dregan@broadcom.com
To: dregan@broadcom.com,
	dregan@mail.com,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	computersforpeace@gmail.com,
	kdasu.kdev@gmail.com,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joel.peshkin@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	william.zhang@broadcom.com,
	anand.gore@broadcom.com,
	kursad.oney@broadcom.com,
	florian.fainelli@broadcom.com,
	rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com,
	andre.przywara@arm.com,
	baruch@tkos.co.il,
	linux-arm-kernel@lists.infradead.org,
	dan.carpenter@linaro.org
Subject: [PATCH v2 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
Date: Thu, 18 Jan 2024 11:53:47 -0800
Message-Id: <20240118195356.133391-2-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240118195356.133391-1-dregan@broadcom.com>
References: <20240118195356.133391-1-dregan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Zhang <william.zhang@broadcom.com>

Update the descriptions to reflect different families of broadband SoC and
use the general name bcmbca for ARM based SoC.

Add brcm,nand-use-wp property to have an option for disabling this
feature on broadband board design that does not use write protection.

Add brcm,nand-ecc-use-strap to get ecc setting from board boot strap for
broadband board designs because they do not specify ecc setting in dts
but rather using the strap setting.

Remove the requirement of interrupts property to reflect the driver
code. Also add myself to the list of maintainers.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
---
Changes in v2:
- Revert the new compatible string nand-bcmbca
- Drop the BCM63168 compatible fix to avoid any potential ABI
incompatibility issue
- Simplify the explanation for brcm,nand-use-wp
- Keep the interrupt name requirement when interrupt number is specified
---
 .../bindings/mtd/brcm,brcmnand.yaml           | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index f57e96374e67..56176ec1a992 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
 maintainers:
   - Brian Norris <computersforpeace@gmail.com>
   - Kamal Dasu <kdasu.kdev@gmail.com>
+  - William Zhang <william.zhang@broadcom.com>
 
 description: |
   The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
@@ -18,9 +19,10 @@ description: |
   supports basic PROGRAM and READ functions, among other features.
 
   This controller was originally designed for STB SoCs (BCM7xxx) but is now
-  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
-  iProc/Cygnus. Its history includes several similar (but not fully register
-  compatible) versions.
+  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
+  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
+  Its history includes several similar (but not fully register compatible)
+  versions.
 
   -- Additional SoC-specific NAND controller properties --
 
@@ -53,7 +55,7 @@ properties:
               - brcm,brcmnand-v7.2
               - brcm,brcmnand-v7.3
           - const: brcm,brcmnand
-      - description: BCM63138 SoC-specific NAND controller
+      - description: BCMBCA SoC-specific NAND controller
         items:
           - const: brcm,nand-bcm63138
           - enum:
@@ -65,7 +67,7 @@ properties:
           - const: brcm,nand-iproc
           - const: brcm,brcmnand-v6.1
           - const: brcm,brcmnand
-      - description: BCM63168 SoC-specific NAND controller
+      - description: BCM63xx SoC-specific NAND controller
         items:
           - const: brcm,nand-bcm63168
           - const: brcm,nand-bcm6368
@@ -111,6 +113,17 @@ properties:
       earlier versions of this core that include WP
     type: boolean
 
+  brcm,nand-use-wp:
+    description:
+      Use this property to indicate if board design uses
+      controller's write protection feature and connects its
+      NAND_WPb pin to nand chip's WP_L pin. Driver defaults to
+      use this feature when this property does not exist.
+      Set to 0 if WP pins are not connected and feature is not
+      used. Set to 1 if WP pins are connected and feature is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
 patternProperties:
   "^nand@[a-f0-9]$":
     type: object
@@ -137,6 +150,16 @@ patternProperties:
           layout.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      brcm,nand-ecc-use-strap:
+        description:
+          This flag is used by the driver to get the ecc strength and
+          spare area size from the SoC NAND boot strap setting. This
+          is commonly used by the BCMBCA SoC board design. If ecc
+          strength and spare area size are set by nand-ecc-strength
+          and brcm,nand-oob-sector-size in the dts, these settings
+          have precedence and override this flag.
+        $ref: /schemas/types.yaml#/definitions/flag
+
     unevaluatedProperties: false
 
 allOf:
@@ -177,6 +200,8 @@ allOf:
             - const: iproc-idm
             - const: iproc-ext
   - if:
+      required:
+        - interrupts
       properties:
         interrupts:
           minItems: 2
@@ -189,7 +214,6 @@ unevaluatedProperties: false
 required:
   - reg
   - reg-names
-  - interrupts
 
 examples:
   - |
-- 
2.37.3


