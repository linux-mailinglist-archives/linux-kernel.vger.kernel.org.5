Return-Path: <linux-kernel+bounces-92368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A6871F25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8CE1C24A31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3BF5B5AF;
	Tue,  5 Mar 2024 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kq0TTBF3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED55A4E2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641649; cv=none; b=IdQ8ecn68W7YiqxqtR7w7POQwXR5pLXTAloI3RSByzHgiKeE858BkrpJ/XGkfqOSPUZPY3JyZsXsA1ZclF3BGtA5G3xzylthw/zWV2hmzoPY937V60bn8nOYC6Mv3XJ3Hp5TGfiD9R18DkoHnmGfltfSHnBR8vaR2AzpWg0lmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641649; c=relaxed/simple;
	bh=TKDPxYW/tLR6+pdSadQd+rmH+EeLgf0eVqOWRG19CiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ra/SZlzgUZblC+H3MKx45MTu9YR9xNJwk65xgqv9lFtyagg8E0+cL3IFUoDj2ezo6gMLHX3U3J+ukQlo/yeYByrZuYcRCnLXjThZNJBir9KIiGzmyiqKq+E0jOePLKFczxMb3bXYz6sqAHWnhcK2xL0L1nDAl/yx3zCUY492sDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kq0TTBF3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709641648; x=1741177648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKDPxYW/tLR6+pdSadQd+rmH+EeLgf0eVqOWRG19CiM=;
  b=kq0TTBF3iC1XkcQQIw5LonZg2Tt5A91x018nZXhbAeRzOST/WcE+OsyB
   WQqog/CZbHHiQ3P6T8jQWZl3lOukO8uwBLgAtn6nx+09GTWF0T85yTXOY
   ZJXXEX2RiUIP1vuNBR2DseX2liTZsCfFdtC5DM/wiHBiRxkiFlMmRv9NL
   Y3nkC8mckT4CcVSmlwpfjo6a8sLGpl3JzOLYkzpS/hvunYzHJJGaUT1Fg
   D8fiwloms/uLhCYGDj9KAViwvAJeiFUdBCcf3oaYHDfaOsnOrQt6L5pfm
   Qi9gitv/gQsglGnGgqJokvmEgUTquF6TdLcwnf3h9WU2TTkaX4Idk2OZr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21648435"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21648435"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:27:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9330074"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2024 04:27:26 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Eric Badger <ebadger@purestorage.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] PCI: Make pci_dev_is_disconnected() helper public for other drivers
Date: Tue,  5 Mar 2024 20:21:14 +0800
Message-Id: <20240305122121.211482-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305122121.211482-1-baolu.lu@linux.intel.com>
References: <20240305122121.211482-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Zhao <haifeng.zhao@linux.intel.com>

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
---
 include/linux/pci.h | 5 +++++
 drivers/pci/pci.h   | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7ab0d13672da..213109d3c601 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2517,6 +2517,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
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
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e9750b1b19ba..bfc56f7bee1c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -368,11 +368,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
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
-- 
2.34.1


