Return-Path: <linux-kernel+bounces-115921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CB38898AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A268F2A49C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7D32666B4;
	Mon, 25 Mar 2024 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot5afAK3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBB148FE7;
	Sun, 24 Mar 2024 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322116; cv=none; b=t7+fGtfhwY0iyuDCtpJ6VMCTYFZm8nnRS0HphMIFyNcP9zOwGNxCi+nnIcB34JVIy/tUPjMfiGboLaMZPSY/0CRm4DfZ/k7i2hKwhPYbecFXaybXYspiopf1sWaqqkea9EFMI24Bem+gdb8hZf4dPRlmnawpkPX7gsKrF9P3YIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322116; c=relaxed/simple;
	bh=fX6AZ+UGxnxJZMDeWsDLp4MrCDnpwCiiPlfQdIChI+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3/cj0zxeObYLZZA3tWOWHEphz2gneTWz9mErUDoyKrfu8b319AxGdVyBZR8QmK2kXZiHo1PvCmQkYtHCGmQs6hYdrh4vUVxyp2rRQioeeeHNxmWd4CMaecbhBhfiTSJCVYi27BzHEBvJ9BdkCxvG8KixVW4+3YYOsZQGPQXwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot5afAK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC06C433F1;
	Sun, 24 Mar 2024 23:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322116;
	bh=fX6AZ+UGxnxJZMDeWsDLp4MrCDnpwCiiPlfQdIChI+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ot5afAK3BvbRPMuPd2JwU9n0WQr/I3R1DpQgghZP+OmoGZHaoRYpOyuM3Q+MOeiIi
	 H/1ZulEvXKDGB9CfqMOqDg++gTTWWBYymLGLhGL7UnECvysj1KotTldRcG1fYrwvP5
	 JKrvHWNMO8e6blzTTvJ7WxUmqjKSmU8c2kJ5cTawo0aYbiMBuVK764m6ExiInyG3T1
	 72QPJkAaTAFVPqZTIcszZJjgVxa3pcN0RUWlC1XO0VGin+qhLyuwiUJptncUtDRT1H
	 Jj20yTHYoF0GJCMlQ+wqc6j43n28tYRFdKt8jfRjZvnlv/pkuLtjahNrRK+WDOkz/x
	 1d6GnWCkQw2aA==
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
Subject: [PATCH 6.1 191/451] PCI: Make pci_dev_is_disconnected() helper public for other drivers
Date: Sun, 24 Mar 2024 19:07:47 -0400
Message-ID: <20240324231207.1351418-192-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index e1d02b7c60294..9950deeb047a7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -357,11 +357,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
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
index eccaf1abea79d..f5d89a4b811f1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2355,6 +2355,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
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


