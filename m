Return-Path: <linux-kernel+bounces-104867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B00887D4C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A2C1F23723
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5507535B6;
	Fri, 15 Mar 2024 20:00:58 +0000 (UTC)
Received: from rosemary.ibugone.net (unknown [202.38.75.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906750A75
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.75.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532858; cv=none; b=McBB/HZGOBIzmcJY2QZiimuj9QF9RW24egKjr7FBp43zyfhQes2GW3dOZst3985CYyvyi0KJtgPZAE+iRpiLtvOFwRhdvEIlGTaSwNWZLuAITeHDq72do5cNjI3+Y5c3Y4Yty1eoWE2OTuNPjWNNnld9dJ59Ru97fvpo9cfPmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532858; c=relaxed/simple;
	bh=DWuHyDQ7KaouzyzHkM8sjp+zITuNkADl5Pm6V4ABgBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKgiSDSBYqX+N2tqcnidLjkSwjOUvqHWRNtXVcj/09gdLxWfLyLZqR+9NkoxpqOzNO+lkRd/i0Q4TVVtOE6awqGWFVKMAuWjVTMiTyC7dYK8YBE1wxxk6Wq5PoPaJaPuInRZZYt4jFxJB+F+wIbMIbbRC+a2Jwwxte2d7c57bAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ibugone.com; spf=pass smtp.mailfrom=ibugone.com; arc=none smtp.client-ip=202.38.75.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ibugone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibugone.com
Received: by rosemary.ibugone.net (Postfix, from userid 1000)
	id 4D2CE7A56F4; Sat, 16 Mar 2024 03:32:09 +0800 (CST)
From: iBug <i@ibugone.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	"Jiawei Fu (iBug)" <i@ibugone.com>
Subject: [PATCH] drivers/nvme: Add quirks for device 126f:2262
Date: Sat, 16 Mar 2024 03:27:49 +0800
Message-ID: <20240315192747.1749119-3-i@ibugone.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiawei Fu (iBug)" <i@ibugone.com>

This commit adds NVME_QUIRK_NO_DEEPEST_PS and NVME_QUIRK_BOGUS_NID for
device [126f:2262], which appears to be a generic VID:PID pair used for
many SSDs based on the Silicon Motion SM2262/SM2262EN controller.

Two of my SSDs with this VID:PID pair exhibit the same behavior:

  * They frequently have trouble exiting the deepest power state (5),
    resulting in the entire disk unresponsive.
    Verified by setting nvme_core.default_ps_max_latency_us=10000 and
    observing them behaving normally.
  * They produce all-zero nguid and eui64 with `nvme id-ns` command.

The offending products are:

  * HP SSD EX950 1TB
  * HIKVISION C2000Pro 2TB

Signed-off-by: Jiawei Fu <i@ibugone.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa380..8e0bb9692685 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3363,6 +3363,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.43.2


