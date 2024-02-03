Return-Path: <linux-kernel+bounces-50778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9266847DCF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C658B24EE9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7BC7464;
	Sat,  3 Feb 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="vxD3GewR"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3EEA9;
	Sat,  3 Feb 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920162; cv=none; b=Q2HkqQUGzSIeJH4r/W5aHObVvzFQarlp+1cxCN9xA3N6p6ix/LcU+Bw56WG4IJ4zMKRdIPmW7i9tsRGE5QDILY1/RqVW2z895F09KYKXP/zciwZZUthHsSa0iQQf5Xmid7i078yKfeorpKSkC7urolLdTm1hsY90B8boEmwe+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920162; c=relaxed/simple;
	bh=VYh+6T868Hjd9BlZA701iKMQ4aVmP1U0C12y+IHan7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1GH0rM1gndrwHmPjjpeE3Vb1KrA7t87lCKhTAM5tMClEVBKnlv97uKZ0jl/ngSxxfZYZrAiZ077JhQ3fvzYzpTtZALWD+dL/snw1SAp7+dKhQi7Gwsyp7d64nh+/xTOTH4KHiegVimAKrTHVPO6RH9G1QefQKKeZuGrnYamJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=vxD3GewR; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 71E9CC0029C3;
	Fri,  2 Feb 2024 16:29:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 71E9CC0029C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1706920154;
	bh=VYh+6T868Hjd9BlZA701iKMQ4aVmP1U0C12y+IHan7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vxD3GewRgxTIuh2y78J8VlNUvDDF1RMhBY6AcWPOG5UDt5DotblfCfD3IW82sQ9Zp
	 4OqK+KL6XYakLPsCNd5ka02MxYEHE7zt0rKpdja/fSCnDoBKvFzfCadxIKEG80A5rZ
	 8hbkxWPeJ6gzROp528jZavr/BOBJMxOtRsGpy5Gc=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id EAF4718041CAC4;
	Fri,  2 Feb 2024 16:29:12 -0800 (PST)
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
Subject: [PATCH v4 02/12] dt-bindings: mtd: brcmnand: Add WP pin connection property
Date: Fri,  2 Feb 2024 16:28:23 -0800
Message-Id: <20240203002834.171462-3-william.zhang@broadcom.com>
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

Add brcm,wp-not-connected property to have an option for disabling this
feature on broadband board design that does not connect WP pin.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v4:
- Move the WP pin property to this separate patch and change it to
boolean type.

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index e54ca08a798a..d0168d55c73e 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@ -113,6 +113,14 @@ properties:
       earlier versions of this core that include WP
     type: boolean
 
+  brcm,wp-not-connected:
+    description:
+      Use this property when board design does not connect controller's
+      NAND_WPb pin to NAND chip's WP_L pin and disable the write
+      protection feature. By default, controller assumes the pin is
+      connected and feature is used.
+    $ref: /schemas/types.yaml#/definitions/flag
+
 patternProperties:
   "^nand@[a-f0-9]$":
     type: object
-- 
2.37.3


