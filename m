Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957FC8108CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378458AbjLMDrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378428AbjLMDr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:47:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B69C;
        Tue, 12 Dec 2023 19:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702439256; x=1733975256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TljuoHGjQTdNL/8N4wKTVKbm0YrUiASyUSEokPW3tOo=;
  b=clL4F5q2Ncf53dBZ+la6Gr/JknOVcE6qSif2EdYK2I/9MIB2yFcSKDfl
   hA+30f15HMPKqgfv4XpgGUWWuSLVd+aqJOcvX/FRU6V64xOBPGkaviMeM
   FyGNwr5wiAwO4JKepllKWqEza1lag8vVj04eCWUgOljniDW2j2G9oayOG
   avKEkA6iEPJuBFPDvafESm+RT6No/Pu8chWKhc17ARWlWW7O6QMR34kiO
   iodbzT91rpEuXYajxdtyzQ/m+eOnLDDspu4H9lhh7moDK2ChYGwKJFR/r
   7jjgP79u3ANCMlJ7bD6M7r3iOIIgfmHlEgzmFvuliZYVseY/YwD9ceFm1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="459227277"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="459227277"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 19:47:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897175460"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="897175460"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by orsmga004.jf.intel.com with ESMTP; 12 Dec 2023 19:47:33 -0800
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
To:     bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, haifeng.zhao@linux.intel.com,
        Haorong Ye <yehaorong@bytedance.com>
Subject: [PATCH 1/2] PCI: make pci_dev_is_disconnected() helper public for other drivers
Date:   Tue, 12 Dec 2023 22:46:36 -0500
Message-Id: <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move pci_dev_is_disconnected() from driver/pci/pci.h to public
include/linux/pci.h for other driver's reference.
no function change.

Tested-by: Haorong Ye <yehaorong@bytedance.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/pci/pci.h   | 5 -----
 include/linux/pci.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..75fa2084492f 100644
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
index 60ca768bc867..869f2ec97a84 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2503,6 +2503,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
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

