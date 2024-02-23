Return-Path: <linux-kernel+bounces-77732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9C86098C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F1A1C24062
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E3125A2;
	Fri, 23 Feb 2024 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gRg1zp2L"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93876DDB1;
	Fri, 23 Feb 2024 03:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660112; cv=none; b=GoYGqYSJE9qzjVBd4xOWj+5yhCRXIuUzRIOi36v1cHUH/FfbxW5cI0nM98LGaL9uAcUUIGbeJYAw4LmZywLLPahmBM3rZAZHatqDuVVhX8xlAU46GdgwfrcXjvvpCdpD+Y5Lfq8IOzU9XulAWG8FOZaCa8BJjVKKDeZpRbgI/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660112; c=relaxed/simple;
	bh=VL3W4Hrd8AMxNoY1VfirYQHtQnsee+7UFtazgfSJcYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1tt0rDSrzhPM5woWgCFB/AiqUgZsenYo8F/UVvG8NQs1tIcNxN5Y4XZNTHgDq/pBF0N0KgqpaC0cImBf4idRhcx/7LD20Rx1CGExLPCrzGYpRKdPS7e+BYYVIK//+E/1vr6nxNmZ5+6I0zbnmwjkJiKOIQiAdTFVUe6v7vpDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gRg1zp2L; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A4D28C0047FE;
	Thu, 22 Feb 2024 19:48:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A4D28C0047FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708660108;
	bh=VL3W4Hrd8AMxNoY1VfirYQHtQnsee+7UFtazgfSJcYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRg1zp2LO7EHCQAQD6CuliV5gJm6QoHnJMZdC+vvfiWtGdDkRK7ezoZGnv+rjzquX
	 AT5omQCtRdR8imYenbIrwU4D7vnIE74sooNYAQo/floXoWrDs9NHPh+pFWiFN3FiG7
	 RYECOPUu6/8J13dsvMGO06RVgD1BHpZCzl0Sddqw=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 390B718041CAC4;
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
	Conor Dooley <conor.dooley@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH v6 05/13] dt-bindings: mtd: brcmnand: Add WP pin connection property
Date: Thu, 22 Feb 2024 19:47:50 -0800
Message-Id: <20240223034758.13753-6-william.zhang@broadcom.com>
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

Add brcm,wp-not-connected property to have an option for disabling this
feature on broadband board design that does not connect WP pin.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

---

Changes in v6:
- Add reviewed-by tags

Changes in v5:
- Update the description of this new property

Changes in v4:
- Move the WP pin property to this separate patch and change it to
boolean type.

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index e54ca08a798a..6a717bcedfd3 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@ -113,6 +113,13 @@ properties:
       earlier versions of this core that include WP
     type: boolean
 
+  brcm,wp-not-connected:
+    description:
+      Use this property when WP pin is not physically wired to the NAND chip.
+      Write protection feature cannot be used. By default, controller assumes
+      the pin is connected and feature is used.
+    $ref: /schemas/types.yaml#/definitions/flag
+
 patternProperties:
   "^nand@[a-f0-9]$":
     type: object
-- 
2.37.3


