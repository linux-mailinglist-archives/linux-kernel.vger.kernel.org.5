Return-Path: <linux-kernel+bounces-77731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 050DD86098B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52E1B24BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910981173D;
	Fri, 23 Feb 2024 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MevVbaeQ"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DAFDDBB;
	Fri, 23 Feb 2024 03:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660111; cv=none; b=EFGMqPJ8Gw3qUinFt2BDoyRPQ9JZV9tl4gB8SC1YDns/O7FzPIx+9dtlqUIJePG0duBSpLWFBP2Y3nrM57j6d1TEZc7tHwbSJTvbmHFeYaxhkXT51PoPpqwQtaF8CspUIvZzeZt0X2njJauZVefjpaizK9rE8vAB8JjVaVq0u3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660111; c=relaxed/simple;
	bh=jLwEb4I1DX2qFCUdUG5NZdbf5UdXONu/inu49U3VjgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwIOToFDJf82+FvujFvxg0mtNkK4c7h8SbGyHUmj2mDaD3ACQLuBlmbwegsJ2Asu+yGvSeDrBfevmRou217NRJYVZbtINxiVmAfgLv7WFxJ2xuXq199KsH/L0o5IN8I9BietbTBD0FZpxnnfaZmTyFY9mBCLP4EWeZczZDJ8jQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MevVbaeQ; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 65382C001BF5;
	Thu, 22 Feb 2024 19:48:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 65382C001BF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708660109;
	bh=jLwEb4I1DX2qFCUdUG5NZdbf5UdXONu/inu49U3VjgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MevVbaeQgn8ezCqYhd8D4Yq2/ooO1PpfIkwMUi4lsOjKaUSW95jLsWZOzfV1mJYBr
	 pXOC1VTHS+HPUwHSRkUAyZIOOsLHE4okImWIqQCV7GmrfhoTvrQeqcHUj804jzb27X
	 U7HpLoOl8SHgpkHDtST3gYpfzuG8oHB7qtIRx3Oc=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id ED05418041CAC4;
	Thu, 22 Feb 2024 19:48:27 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	devicetree@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 06/13] dt-bindings: mtd: brcmnand: Add ecc strap property
Date: Thu, 22 Feb 2024 19:47:51 -0800
Message-Id: <20240223034758.13753-7-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240223034758.13753-1-william.zhang@broadcom.com>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
board boot strap for broadband board designs because they do not specify
ecc setting in dts but rather using the strap setting.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v6:
- Add other nand ecc properties to the exclude check list
- Update the brcm,nand-ecc-use-strap property description

Changes in v5:
- Update the description for this ecc strap property
- Add check to make sure brcm,nand-ecc-use-strap and
  nand-ecc-strength/brcm,nand-oob-sector-size can not be used at the
  same time

Changes in v4:
- Move ecc strap property to this separate patch and remove some
non-binding related text from the description

Changes in v3: None
Changes in v2: None

 .../bindings/mtd/brcm,brcmnand.yaml           | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index 6a717bcedfd3..064e840aeaa1 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@ -146,6 +146,15 @@ patternProperties:
           layout.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      brcm,nand-ecc-use-strap:
+        description:
+          This property requires the host system to get the ECC related
+          settings from the SoC NAND boot strap configuration instead of
+          the generic NAND ECC settings. This is a common hardware design
+          on BCMBCA based boards. This strap ECC option and generic NAND
+          ECC option can not be specified at the same time.
+        $ref: /schemas/types.yaml#/definitions/flag
+
     unevaluatedProperties: false
 
 allOf:
@@ -195,6 +204,21 @@ allOf:
       required:
         - interrupt-names
 
+  - if:
+      patternProperties:
+        "^nand@[a-f0-9]$":
+          required:
+            - brcm,nand-ecc-use-strap
+    then:
+      patternProperties:
+        "^nand@[a-f0-9]$":
+          properties:
+            nand-ecc-strength: false
+            nand-ecc-step-size: false
+            nand-ecc-maximize: false
+            nand-ecc-algo: false
+            brcm,nand-oob-sector-size: false
+
 unevaluatedProperties: false
 
 required:
-- 
2.37.3


