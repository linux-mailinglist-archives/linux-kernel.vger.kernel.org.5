Return-Path: <linux-kernel+bounces-116037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD388957B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252EA1F30B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3CF270C8C;
	Mon, 25 Mar 2024 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl5rLwSm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB7130A43;
	Sun, 24 Mar 2024 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323422; cv=none; b=KsuvMR1dC3Rz+d+ayFH8tdizjzF/SP/5JjH4cM25m5G8a6vfw6+x50i+sX8tdBErbERNuoTgTUWBZ7t0xsS02As/+Oavz/eDOzuc32WuJ2O+c6OBdXuBOY6y9fpYcFd1yDI34DB/B10FhTn7F6R6kgIRcj6XvQUVLo9XCx7Baoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323422; c=relaxed/simple;
	bh=1LpbIxGXcYAfUP3h7w20zYf1iL7CarMN8BxniycF2YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vD6aPZE7zL+4AhhtrVuK2dYOzZLkf1UqZ4HgJ2lM9jwwg3ywgSMgl7Jt6J+KOtbjGaDYxGshWMdf3bWUetYWnzTimN8TEvp+p31AjvKqgwJicG20PJwdFWWcdoI6jLNZsTKmOe5vUenLE1kuNSrDIlIg66skpW0Gig/wtjrtEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl5rLwSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECC6C433F1;
	Sun, 24 Mar 2024 23:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323422;
	bh=1LpbIxGXcYAfUP3h7w20zYf1iL7CarMN8BxniycF2YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bl5rLwSm6xEj4zStuWwi6kpQ2S8L1P1bNJH+8mtY2eOd3vRGbKm+8ZsI6LumN85xv
	 dKpEqrwPtA+8EH+JRtnl17/6FgztT2pLj+uxrdJmAHg/qpUt+osOKLzvEVjkOM8Qae
	 H5Tb7copU8qjcpCE9maN65g42jsZu0Xg5bVvxXu+mY01n9pCzG77/8q9zvIqeDdgQd
	 wRkb5JNeumMnh/RQIqDtfH3gIKaavFiDCpkhFEo9SUuvkEzrSPfaU30VnVnv+Fhd2N
	 CJvjs/3PuGEV6Z2cNA64NvvCwvJjwKF5CywFQ9NNQHhVnM3zWnQZ9Bvv8Dc+QDKhMJ
	 WZHSvDMEMV6/w==
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
Subject: [PATCH 5.15 124/317] PCI: Make pci_dev_is_disconnected() helper public for other drivers
Date: Sun, 24 Mar 2024 19:31:44 -0400
Message-ID: <20240324233458.1352854-125-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 2b5337980da7d..ec968b14aa2a2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -395,11 +395,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
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
index 99dfb8c1993a6..08d26b58f95ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2284,6 +2284,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
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


