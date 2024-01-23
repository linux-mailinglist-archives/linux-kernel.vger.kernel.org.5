Return-Path: <linux-kernel+bounces-35868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0585B8397B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A69F1F2227C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582E482D67;
	Tue, 23 Jan 2024 18:30:11 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3634823D5;
	Tue, 23 Jan 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034610; cv=none; b=FjiIDX+SYnoGDZ7I1kAmKDFSbSpwEByndTi3VIZ3cQCqf1YNOSGvCo6l6cOU9qkBxn11EjsmNRUc29e9iWqW+vsskGmUK5qH4EdAkRRoM4KzIRUuv6WSQqRwgGdDrN73LbMwp5OSHjA0eype/NHr5pYr9rqi6Lmk3k+rEXniSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034610; c=relaxed/simple;
	bh=8i78LrYAny+ucwGZHvYyL/nhtG4lVxGC0FsadYuuP2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYhdsD3WX95lxpdDUyDtm2A2VOLEPM3AJEHRpdHJOZ/wmx9Yz+mAo06vCPsJoOhS5AO6p1PrtkTywmptw8s71esQDqlHJ4b5n6Bo8Qd542H5iyUKBbNQmnNdpfg4ZCxf38ISypZFlJj7iLTe1TBXE169/F5Pdi4a6Ia26M5E/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Conrad Kostecki <conikost@gentoo.org>
To: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dlemoal@kernel.org,
	hdegoede@redhat.com
Subject: [PATCH] ahci: asm1166: correct count of reported ports
Date: Tue, 23 Jan 2024 19:30:02 +0100
Message-ID: <20240123183002.15499-1-conikost@gentoo.org>
X-Mailer: git-send-email 2.43.0
Reply-To: linux-ide@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASM1166 SATA host controller always reports wrongly,
that it has 32 ports. But in reality, it only has six ports.

This seems to be a hardware issue, as all tested ASM1166
SATA host controllers reports such high count of ports.

Example output: ahci 0000:09:00.0: AHCI 0001.0301
32 slots 32 ports 6 Gbps 0xffffff3f impl SATA mode.

By adjusting the port_map, the count is limited to six ports.

New output: ahci 0000:09:00.0: AHCI 0001.0301
32 slots 32 ports 6 Gbps 0x3f impl SATA mode.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=211873
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218346
Signed-off-by: Conrad Kostecki <conikost@gentoo.org>
---
 drivers/ata/ahci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3a5f3255f51b..762c5d8b7c1a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -663,6 +663,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
+		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
+		hpriv->saved_port_map = 0x3f;
+	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
 		hpriv->saved_port_map = 1;
-- 
2.43.0


