Return-Path: <linux-kernel+bounces-118140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8088B5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27027B273A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D880610;
	Mon, 25 Mar 2024 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9gatwuB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16987F7C0;
	Mon, 25 Mar 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406978; cv=none; b=P0LERfy2vSJsmRgmr6LdystUlBeoXXF1Zo9GZk0Cq2sHz68dMUxXnFXpGmxDbuwNQY8+CHbGAl6rNfsbAwsI+e6u1Kg/WBDX9p01bo9d+KUFXzVHCPN6BwN4V2qJWXUX4DaKsjY49eNKo34IEhTjnIEcqKkQHD0eDVbKrRt7Uls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406978; c=relaxed/simple;
	bh=mpENNzXqB34PkfN3qWk4baDeHWXS11DwgtTCQWCof7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WehbatLSysQRut8KplU2oxzR4cE86wvqU0sP+qXKeQLIdNBzkVsMy78Jeb3dqoPEZGlrI95weGKUUg6J2xQ9QbtGcLyVhfYn6lD/dS+gQBucnGRsLbyMlkxzUvRMimr8LEcSun09Fa4VU+QFzF6frQKK7cAJguzvhtI/Dcyc4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9gatwuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D68EC433F1;
	Mon, 25 Mar 2024 22:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711406978;
	bh=mpENNzXqB34PkfN3qWk4baDeHWXS11DwgtTCQWCof7E=;
	h=From:To:Cc:Subject:Date:From;
	b=d9gatwuBzcGbQxPOdikSyNqT+DW3r6dusOgETC2TS+5LpMd5fcEGm9X70IvtcRpAs
	 xE1BTe7Zbmq5vUIcgrD/nRL1WSk7s/3Onu83T0XIFAdkvv+P8AocDmxfmbgh4dwtPU
	 z2ykTBqjq1gfNPca/TDnwoE5d3gAdUQLlSPaYCaJzZSQz+xi0fDSBr9UcrNFSMD5bN
	 4hiMGKnFfYiG1fA6CSzmXOCCkurpdlXr6dQDuVV3GymwAu3vt4QWnQIhp8b89h4lZi
	 WtITY6fXEFgLowSagOKMneoO6cjSGlg58GKUi3w6zR2gYqNUNXIRdemVdUO3PDl7s+
	 mDW9fgjoKUG4w==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] qed: Drop useless pci_params.pm_cap
Date: Mon, 25 Mar 2024 17:49:31 -0500
Message-Id: <20240325224931.1462051-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

qed_init_pci() used pci_params.pm_cap only to cache the pci_dev.pm_cap.
Drop the cache and use pci_dev.pm_cap directly.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/qlogic/qed/qed.h      | 2 --
 drivers/net/ethernet/qlogic/qed/qed_main.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed.h b/drivers/net/ethernet/qlogic/qed/qed.h
index 1d719726f72b..b7def3b54937 100644
--- a/drivers/net/ethernet/qlogic/qed/qed.h
+++ b/drivers/net/ethernet/qlogic/qed/qed.h
@@ -662,8 +662,6 @@ struct qed_hwfn {
 };
 
 struct pci_params {
-	int		pm_cap;
-
 	unsigned long	mem_start;
 	unsigned long	mem_end;
 	unsigned int	irq;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index c278f8893042..408da4312e01 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -323,8 +323,7 @@ static int qed_init_pci(struct qed_dev *cdev, struct pci_dev *pdev)
 		goto err2;
 	}
 
-	cdev->pci_params.pm_cap = pci_find_capability(pdev, PCI_CAP_ID_PM);
-	if (IS_PF(cdev) && !cdev->pci_params.pm_cap)
+	if (IS_PF(cdev) && !pdev->pm_cap)
 		DP_NOTICE(cdev, "Cannot find power management capability\n");
 
 	rc = dma_set_mask_and_coherent(&cdev->pdev->dev, DMA_BIT_MASK(64));
-- 
2.34.1


