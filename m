Return-Path: <linux-kernel+bounces-36381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1FF839FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8573B24236
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1186ABB;
	Wed, 24 Jan 2024 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ka0pFV66"
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89223C3B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065535; cv=none; b=pT26urMUq0mqqjOxQbffz1UClsUJzrlVZn1A2cSsFWagpJb6eTDRQcmrw/lLyfeQOJW+2XB+QKq54b2J2ZgL33QV2o0sgNZ54PpelSToS8/fuauuuaJ9xTGCYj7fIXrJn9V8l/JDBPIZBJ50o9M2neDFa+GMAxZENxFvhf7tJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065535; c=relaxed/simple;
	bh=nvrEOWH9z/+z7lJvtyev/8yIQOX98EvFRNg3Zd+SrHQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SmHVNdz0FLW0YuinuCW1EticQR9MBthvPrH/WGj7Ak4UJVbd1VTcNNgS/UAFquwNwoV+Pyrr+/LHC+CLBEY2e5v+JfOO+3GaucWTQGfGkiwazfqgARHjAffxMxwzGLfNgYQlf0KvabJY/1ZSTmIvWTfkBdPI9soiy7OKvqiXozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ka0pFV66; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-6ddf1e88e51so3787728a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706065532; x=1706670332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfC42mFMxWbt42N2Y8Snh0FkDOtoFt5c5JS3NwC/Elo=;
        b=Ka0pFV6679h2oN4khzX+fzYkR0AKjyg1Pl9I219cyRhQqnMt3SLw1GKY3WFlbov3MK
         rfD2qVjNb5Aa56dBNw7/23m2DkbOa/8WTfYEBQx8cdiJbjUFurBQ8oZ9gmVa0URz4mA1
         yYTvNEsXA9MUbN+RhqjNGmiNk4J6M81GmXX1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065532; x=1706670332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfC42mFMxWbt42N2Y8Snh0FkDOtoFt5c5JS3NwC/Elo=;
        b=v0tIZ+PKmBvMXAQvRWvcISsZEWtq9fe+vfXnuVWGCmuoJ0gmxCE3PCCbFwTfbwScLr
         FgyO3YScOdDzOVrMv0DZkdEtPGuE6FkjkXBcXgOVLQIHBkyzpnxkDjl9Nvc55S4jCwvM
         8VRtG/6YLTawXdRrv4VavXwdXPQVm21fpAQNOL6xEPE9xeUbDI3J7CG6+7wo2F+PXky9
         07JiJh73DbHgFVfmrDP9IbR8rMb5fdCPwJJ7BBM09THl1h9A4vIN1/vN0P59pfBvX/ZG
         1bSouoTvwRNLMXZwl517kTwnxZpRxCrdANnXumDz1e35RV3qrkDkuUse1LMQmveuT0sF
         CG+A==
X-Gm-Message-State: AOJu0YyYvg5/Byg4kXQMe6j2Ll2UGS84pgk3YTIDioSBdECzWw9Df4xF
	rGtue4LdCl9u9a/slnKUUKyMMWF8c5mqO0Rb7rrj/UJmSDJ43F7Hx6NVRGRQ9Hew2S0M3yKYEf0
	woZJlPc1tSSQeHwsCFs47LEMnishHGQ==
X-Google-Smtp-Source: AGHT+IGkswDyG3Gtz3GqJE+TRieLfMO18ZMJzmD7ROmdRdjJ3ufDF3WoK1jWXcVp3qq/MXq4+F0KEGsc3xvR
X-Received: by 2002:a9d:5e09:0:b0:6e0:f7bc:24f8 with SMTP id d9-20020a9d5e09000000b006e0f7bc24f8mr847296oti.60.1706065532044;
        Tue, 23 Jan 2024 19:05:32 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp-relay.gmail.com with ESMTPS id c22-20020a056830349600b006dc7502beabsm455320otu.3.2024.01.23.19.05.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 19:05:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: David Regan <dregan@broadcom.com>
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
Subject: [PATCH v3 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
Date: Tue, 23 Jan 2024 19:04:49 -0800
Message-Id: <20240124030458.98408-2-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240124030458.98408-1-dregan@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
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
Changes in v3:
- Update brcm,nand-use-wp description
- Revert the description change to BCM63168 SoC-specific NAND controller
---
Changes in v2:
- Revert the new compatible string nand-bcmbca
- Drop the BCM63168 compatible fix to avoid any potential ABI
incompatibility issue
- Simplify the explanation for brcm,nand-use-wp
- Keep the interrupt name requirement when interrupt number is specified
---
 .../bindings/mtd/brcm,brcmnand.yaml           | 37 ++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index f57e96374e67..752c6ee98a7d 100644
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
@@ -111,6 +113,20 @@ properties:
       earlier versions of this core that include WP
     type: boolean
 
+  brcm,nand-use-wp:
+    description:
+      Use this property to indicate if board design uses
+      controller's write protection feature and connects its
+      NAND_WPb pin to nand chip's WP_L pin. By default the driver
+      uses a module parameter with default value set to enable to
+      control this feature for all boards. Use this dts property to
+      override the default behavior and enable/disable this feature
+      through board dts on a per board basis.
+      Set to 0 if WP pins are not connected and feature is not
+      used. Set to 1 if WP pins are connected and feature is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
 patternProperties:
   "^nand@[a-f0-9]$":
     type: object
@@ -137,6 +153,16 @@ patternProperties:
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
@@ -177,6 +203,8 @@ allOf:
             - const: iproc-idm
             - const: iproc-ext
   - if:
+      required:
+        - interrupts
       properties:
         interrupts:
           minItems: 2
@@ -189,7 +217,6 @@ unevaluatedProperties: false
 required:
   - reg
   - reg-names
-  - interrupts
 
 examples:
   - |
-- 
2.37.3


