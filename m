Return-Path: <linux-kernel+bounces-115664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EACB889D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE012C2EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2373354662;
	Mon, 25 Mar 2024 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaiHNNtc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42B4DA19;
	Sun, 24 Mar 2024 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321565; cv=none; b=GhySO8cz7CAturGreWQ7K8A9liqnkp/4bbXmQN43goUAxyDzMszfEKjAEtQIFskhtIZtvvNLx35XmdT5l0G7f6aAscibydsCzpuGFOXWxUOZWPoeHhz3q/GqMuVcswlo6eoPBP88hVEOML3TWAQD1rrDzYJ7XYbNPo9jt5NJxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321565; c=relaxed/simple;
	bh=0h+dVccax6ro0iS08S+b3SQ+pRrc0gTGC3ATwkrtnoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRuPsfbKws2tOfSOzTGEEiJBd7zibcBhgPie0FQX1LVe1AxPCPjZTFJhod6Kma56//UCUzdfsKMh4gTu0cYEeno9NhjR7Pr1sc6GIENfcS2ppHLskwA039haHiddNdot92eQMnlnIcTbKKr32tMtDtt5mWelumzIbbApJl9tNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaiHNNtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDCBC43390;
	Sun, 24 Mar 2024 23:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321565;
	bh=0h+dVccax6ro0iS08S+b3SQ+pRrc0gTGC3ATwkrtnoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SaiHNNtcn8XYMnqmPV/sQEs4xbUXv/AbpTTGW02QXYvcSM8+DI9Ui3dpFKoODlLlo
	 z7u/y2oDz87nytQt6SzzS/HwsAL9LZl37XudVozNUhX1ZbGxVwIbmSUm5RvuIVQwZ/
	 NGxInmXcwibnhidXJuJqbFz/1yrTXLriyRfRZRl/2IfZbk840buErbItmA10/V4EQn
	 JU/kctReqrb4pF871TJ/Bv+PTzHkicWIVolgU2w7YZIAuxgd8LvnWlqSDnjYR1PpV2
	 /lxP/DORxghVNhaPDmdM6eFgrCcXwUc6M+24UZXu/egwc941EIkK1mi3Fpf8aqzzcC
	 WUG4kKpyRiGkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Haorong Ye <yehaorong@bytedance.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 293/638] PCI: Make pci_dev_is_disconnected() helper public for other drivers
Date: Sun, 24 Mar 2024 18:55:30 -0400
Message-ID: <20240324230116.1348576-294-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ethan Zhao <haifeng.zhao@linux.intel.com>

[ Upstream commit 39714fd73c6b60a8d27bcc5b431afb0828bf4434 ]

Make pci_dev_is_disconnected() public so that it can be called from
Intel VT-d driver to quickly fix/workaround the surprise removal
unplug hang issue for those ATS capable devices on PCIe switch downstream
hotplug capable ports.

Beside pci_device_is_present() function, this one has no config space
space access, so is light enough to optimize the normal pure surprise
removal and safe removal flow.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Tested-by: Haorong Ye <yehaorong@bytedance.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Link: https://lore.kernel.org/r/20240301080727.3529832-2-haifeng.zhao@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation request when device is disconnected")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.h   | 5 -----
 include/linux/pci.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 99abc4cec0df1..1b4f941829724 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -363,11 +363,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	return 0;
 }
 
-static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
-{
-	return dev->error_state == pci_channel_io_perm_failure;
-}
-
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
 #define PCI_DPC_RECOVERED 1
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3af5f29985511..b548d5646a86d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2477,6 +2477,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 	return NULL;
 }
 
+static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
+{
+	return dev->error_state == pci_channel_io_perm_failure;
+}
+
 void pci_request_acs(void);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
-- 
2.43.0


