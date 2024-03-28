Return-Path: <linux-kernel+bounces-122941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF80C88FFDD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE191C27998
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812217E58D;
	Thu, 28 Mar 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="NCeGZUnO"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE93032A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631376; cv=none; b=JyPBzLkc0IJBdPfRnYccyzXhcjfDpn2NGcaSW+Uo7W6JwghbPOJ7Pp5nubhLdctXj64+vh5Tck7d+FkMPOJMaHC/3z64BiRuO5vRFMjU/Dpp13+6B309Cc3OtdsUjZa0FL34wdivG4M4ukVidFvpb2wlJZrM5MNQYq9HakOdUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631376; c=relaxed/simple;
	bh=w7lYAZ5uk7kchtoYBrDdTDqy2vNU3oFxqkAuhLzk0mk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DRD9sKixbfJ0kMPbrriCihVtOUrFPnv5xNUjj0UrYZPHsXEWQX401tmaE2Ba/W0+UtbV2LJx3bQ+X6QtF5cRMGN9D7h7DcTa2TEp+KoPXeMfG6gEWi/r0jHEatoxRPT7KlL09kPrjfYbqMD9ZGv24Qdz2iTnTV7BbN2Vm2IA0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=NCeGZUnO; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse.fritz.box (pd9e59192.dip0.t-ipconnect.de [217.229.145.146])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 1F10F2FC0063;
	Thu, 28 Mar 2024 14:09:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1711631369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ojbSBuW9t8NkBbxB8HzsJZUa41zS6xae7K3rNwVDPtU=;
	b=NCeGZUnOUJFjf1bi7Pk2p2TSLikWJsotk0+c/Evf0+v5kTl2j/2h4zg80WC88XBDWtC3Nl
	p2p+RB0olc/EM5KzyOxSxsdY4LqRcUgoxYgFIWf9iN91Js9E/DEV/he0+HUuYDyzDmEf7n
	KwDI9URxv5om54idg6aMh8/orQIRDrU=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
Date: Thu, 28 Mar 2024 14:09:22 +0100
Message-Id: <20240328130923.61752-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Georg Gottleuber <ggo@tuxedocomputers.com>

On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
power consumption in s2idle sleep (2-3 watts).

This patch applies 'Force No Simple Suspend' quirk to achieve a
sleep with a lower power consumption, typically around 0.5 watts.

Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 drivers/nvme/host/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa3801..63f4947c960f9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2917,6 +2917,17 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		    dmi_match(DMI_BOARD_NAME, "NS5x_7xPU") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1"))
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
+	} else if (pdev->vendor == 0x144d && pdev->device == 0xa80d) {
+		/*
+		 * Exclude Samsung 990 Evo from NVME_QUIRK_SIMPLE_SUSPEND
+		 * because of high power consumption (> 2 Watt) in s2idle
+		 * sleep. Only some boards with Intel CPU are affected.
+		 */
+		if (dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
+		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
+			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
 	return 0;
-- 
2.34.1


