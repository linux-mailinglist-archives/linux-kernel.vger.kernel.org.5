Return-Path: <linux-kernel+bounces-114976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0240B888C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2FCB29837
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8472E081C;
	Mon, 25 Mar 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLmyZBLP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C617AF82;
	Sun, 24 Mar 2024 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323710; cv=none; b=g5hTGG3XC4zX5TbhMxsssqICQIDKt8L74Nrj8UBXGF8c/EkLMbRmSVkDlib/VK4aDJ/2WstaflQmK8FCc7zNn3n/61GfBQW56LqaC9ALPlAV4cMaZuiTMZ4Vjvh4wcyykiGY1Zp+MvYrx3RGmchRV5urlw0pNzLfl1N8GodVdd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323710; c=relaxed/simple;
	bh=T+nOVCSzRnGTdI5P8M9Z7cq6C1PiVUrKiwdyHWmFwZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q68vbM8MQbObw3VsdgdVUh1oOJIu7Fg/cDVKWEZGkwUcqakx+TUHaBJ3rP5YWcGPNDU0RXDEdq/pgZQD2/um9j+gtE8541yyfaK8Q8R/jEdGlyFLnAeNzJcq6rgbzasmByLHzTt1FblbEeWNvtPuCVmlOH+BHpSlSfdR+yEYX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLmyZBLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DD2C43390;
	Sun, 24 Mar 2024 23:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323709;
	bh=T+nOVCSzRnGTdI5P8M9Z7cq6C1PiVUrKiwdyHWmFwZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLmyZBLPc/wikNz+h7Vic52CcsI2I/WNTGqOJjEMOlfxjIkucdCdJGu01hYiTbLRI
	 c8qOyFxewo0LGfnj7o5r1wAVDENCc7cFCEf5rKBe5lX6DH0Jl5mBdsHjTofaF1tNNm
	 mDO+ljTGMNA4u7pZg8irSD9J1Ifzf0KrQpxFkrE65/xB1rQrXcN77Q9l5CQKqFwWTI
	 +wAzv4LXPoB6EZRs5fHOHqzlGsC803/zqZzvMZuzfq3wfGLsviyt6Eb+w5qckYnznj
	 L8GEJa24qwnTBkR/h7y3p8x3Z/79DRxoE1H2v/Xb/bPNektJ57C0bqywbhZHsxn+Qx
	 aRX8wSFYItCdQ==
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
Subject: [PATCH 5.10 082/238] PCI: Make pci_dev_is_disconnected() helper public for other drivers
Date: Sun, 24 Mar 2024 19:37:50 -0400
Message-ID: <20240324234027.1354210-83-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 72436000ff252..32fa07bfc448e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -399,11 +399,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
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
index 550e1cdb473fa..bf46453475e31 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2191,6 +2191,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
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


