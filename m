Return-Path: <linux-kernel+bounces-88049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D93F86DCB2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E51C22FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD07F69970;
	Fri,  1 Mar 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Isp2xshy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0B69D1B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280470; cv=none; b=QySljJIhTuOpEYqjPctx+caNSjlNOokD+xtlpqEstY3QeGW0oEl/6cYSBSbde/i9OQ/ge/+GqSQT6IsUghjb8OKu2NRLodn3G2VPR7ffDEevF0mvEhQDkkiBX40WPDrNQf9qjFB+Wx8a7FHmMnjvLjACW0SgtnPHwH0ckvnz+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280470; c=relaxed/simple;
	bh=2TzLf4OIt1MGytd6q5pU6ETsxdGfZl7KkNocynO4NGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p8+JD4MUCM91nkxc+j3/S/jz8bRNFHRJ4OP3hu9vschOB40sY08yeXgw7TpbU9PJVfr32RyD4ep2/eCbeu62bCKDXJXfxKEsXqfQqyxnZ4At//XAr4/OKDu8io/PltEjLwWd7llajbgZxeUtJ5ul/+IlBV+GuIWf+j8vO3QzsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Isp2xshy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709280469; x=1740816469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2TzLf4OIt1MGytd6q5pU6ETsxdGfZl7KkNocynO4NGg=;
  b=Isp2xshyrWtXRPmRQEPgijPgoxA3ViiExPQCAUruZod3jKsHNPHnmVOb
   hNj+yXeoUk8QV8CnE2cxOFeFufQ+XDfkvfg5HMcW+CnULHAv+RtjnXjWj
   bDeRHG6Tkv+nsbgdS54N+hXPKeRS6yyn0KePK2819UdQDjZ+IIe8Qc12o
   5ijY7c1rWuAziDwBshANP7WwXTYYqfiBWt9vsZ46eNY/+hzifK2aEGo1A
   LpwoLEdcKdB+ycIZui314Qllppmx7Y7svic4/K8grKCnMkXTPW1SuCGEh
   mesveGGE27VN1tpXD7DeLzBwA0RpCv2HunzQDYxpih/xKdFjsAYwQn1Rh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15240404"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="15240404"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8187467"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa009.jf.intel.com with ESMTP; 01 Mar 2024 00:07:44 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Haorong Ye <yehaorong@bytedance.com>
Subject: [PATCH v14 1/3] PCI: make pci_dev_is_disconnected() helper public for other drivers
Date: Fri,  1 Mar 2024 03:07:25 -0500
Message-Id: <20240301080727.3529832-2-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240301080727.3529832-1-haifeng.zhao@linux.intel.com>
References: <20240301080727.3529832-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/pci/pci.h   | 5 -----
 include/linux/pci.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

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
-- 
2.31.1


