Return-Path: <linux-kernel+bounces-50777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B6847DCD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612FC1C231F6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A910F9;
	Sat,  3 Feb 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ty2gDHgv"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA487468;
	Sat,  3 Feb 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920160; cv=none; b=CW+hIZjerGaX2iLSWq7Z0AnlKtSSLWwwjRrPPl9/uxvDwYnWb8FR5mjnM/gim79YlL3tCd9w8RntdAJeOQRgF9CHWfXRzavHiayS6ZXHudhMd+k5tYKq0s0eXPGxOTzuXVh2RmrNuQ7f0HiNv2o4w4Icgg0FCFFvGR/d86BYXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920160; c=relaxed/simple;
	bh=te5+l18ZZxWvnmfq+UvIJN6+FYEaQdsKeXHBLOKms1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFvuHACZWZqxNi81kOg34+CMH5iK10HJsrcN78OTvoH1wwKVqET6NBcv/d30Hlu7FnBxDLnSC5eGZotmK23uj8mUbmb36Cmqpn1BmifK11tNgG0TFo3zA3uKMkacHd/vGznxGYyqd1IZcneQoeg9YH2mTpKSq8/4vLV8+dyAN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ty2gDHgv; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0AC1AC001668;
	Fri,  2 Feb 2024 16:29:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0AC1AC001668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1706920158;
	bh=te5+l18ZZxWvnmfq+UvIJN6+FYEaQdsKeXHBLOKms1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ty2gDHgv+jc6uy7673PtqGYXFmrpGpr/XOfWkQZt2NVMDG34t3iGTNr/MwC4zIL/H
	 cMNoD2hcIjF62NLa9sUCpg5cgECxGbB9GP2s0EK60Mn1UsGiunyIEk9+/OBg2UggyY
	 op+TypxFuMBBfe7j3uvH5VR6ku6uctfclC31MeCE=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 98EA018041CAC4;
	Fri,  2 Feb 2024 16:29:16 -0800 (PST)
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
Subject: [PATCH v4 03/12] dt-bindings: mtd: brcmnand: Add ecc strap property
Date: Fri,  2 Feb 2024 16:28:24 -0800
Message-Id: <20240203002834.171462-4-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240203002834.171462-1-william.zhang@broadcom.com>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
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

Changes in v4:
- Move ecc strap property to this separate patch and remove some
non-binding related text from the description

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index d0168d55c73e..2599d902ec3a 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@ -147,6 +147,14 @@ patternProperties:
           layout.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      brcm,nand-ecc-use-strap:
+        description:
+          This flag indicates the ecc strength and spare area size should
+          be retrieved from the SoC NAND boot strap setting instead of
+          nand-ecc-strength and brcm,nand-oob-sector-size or auto detection.
+          This is commonly used by the BCMBCA SoC board design.
+        $ref: /schemas/types.yaml#/definitions/flag
+
     unevaluatedProperties: false
 
 allOf:
-- 
2.37.3


