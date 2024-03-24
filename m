Return-Path: <linux-kernel+bounces-113755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44857888E75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F367C28F606
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F3D12C80A;
	Sun, 24 Mar 2024 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ59bnhP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5EE1E16AE;
	Sun, 24 Mar 2024 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320775; cv=none; b=XkaVhs/+9hH5VRig8MBF5PlXJTJMx42y83LQ4yj43w8+ITYtAPzwDx2f3X3CwtMQNILDKLROstO7EKborCBf/axACDONYiIUMDB84RfcJ8bd5r2Ii+UttrJ2HdElzPAVPFBfg7Ri/4LpUlRlVXVVAcA0XKO/O3f84k1EtqUPW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320775; c=relaxed/simple;
	bh=7z9VKnEcVKttCYMNNEZ3RltWsrm5wlUFur33f2x7As0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tos6bC4GRbyLc4WoKgfJjxPNk6KUw/AYtLxlVYh4QMBQyVJQbqzJqiJkXrtFCWWLWLPXKSO9ZSga8/l3B6IkXNHri8AEQ3ElP44cz4oDN/e91+x/7nCl6TAjS6Hxoy/KpDDYkhy7gUNqORM064yDza13MmnhDdE77TAt3xNwfAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ59bnhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4C7C433F1;
	Sun, 24 Mar 2024 22:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320774;
	bh=7z9VKnEcVKttCYMNNEZ3RltWsrm5wlUFur33f2x7As0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQ59bnhP6kTC+L6442cpzj9iCPzFPEBoL07n5ptFo7EsPZKbzUdwboJggyE3xSCvF
	 8TGC236b+edv1ILwwwrqCWNcucj36t5j7NZ+J28k7OB6YthoPamnL5kgQ51wyGt3gr
	 1E18uVVbPmS7ADVMlaGnnLt1m3K5ZBaDRTasExIkeCAyDkO5LVOquxarOB6gr+KCwl
	 hAfptTBkYHPtJZykLNkfGWdEmwWw3/fDjkbbMdt/orBwVWpa9LRLoPNsVcBJhB18Gv
	 5O6b/4p/vmlXDQn0u4mSGMCczgW38aIz+6I2Anthawjf9VycdlNVDJzkv/U1FhV3ss
	 dLCA2HE+gA+Xg==
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
Subject: [PATCH 6.7 338/713] PCI: Make pci_dev_is_disconnected() helper public for other drivers
Date: Sun, 24 Mar 2024 18:41:04 -0400
Message-ID: <20240324224720.1345309-339-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 24ae29f0d36d7..1697cb8289d49 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -366,11 +366,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
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
index 675937a5bd7ce..ca0e61c838e83 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2511,6 +2511,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
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


