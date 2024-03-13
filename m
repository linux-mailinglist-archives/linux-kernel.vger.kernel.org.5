Return-Path: <linux-kernel+bounces-101249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60B187A494
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A182834B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42692E62D;
	Wed, 13 Mar 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAO41EBo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810FA1CF9C;
	Wed, 13 Mar 2024 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320685; cv=none; b=GZ4D0pfruFAykqtGAEvympfQWhgYIo9JjEU1VTCmB54Rfy8/bfIHk7EGq1Bie7VlKRJZ4SWe7WbXCn1fUFo5PlCYTGHl8+dMZD05NbLCNIduz5gqe58seO2zNEdiQbR3DDk/wFbYtE76coqE0Bq5iqM7oPEdQGtSNB9UtLKOP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320685; c=relaxed/simple;
	bh=cCcAZorzRLb7lbgjB3+q7cWyi/RgdyXLKB8wuGXjVn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgnjZSKK3DqGAHDhqO9Nty3o6W5h2dS8Qo4zeUYTftCEZ1MH3pHAya1fmWYAcQuPvrPUmXvm7TjviGDA8LhC4jSfG5eatVNHjZS6vsclwhZyWtKcUqYI8uf1P71i5YSY6CCjPDhk/d+tP7CaRfSd0GUVZnE6XZ8aGMQfPNH2waQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAO41EBo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710320684; x=1741856684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cCcAZorzRLb7lbgjB3+q7cWyi/RgdyXLKB8wuGXjVn4=;
  b=FAO41EBotxMxJc6ql89JS4cp+B0heIX+SZ8mbzu5bz/szl8cxFBdumzo
   OViWPfkcBnFboLDkAfM52H/IBoUKqsFH7M00Qc4QoFFYnLwK5AitPEiAT
   QYIZoEJd4QKOYL3hNmERC7DqhbVDAVfFQxIcJYVQuL/JNxOJC8MqiLhEc
   ufYeJc8LNr/hiq51qTE4+hzb50V4jcModMyNJRNPG4Q4hNgtoKMfnLxR7
   QO28SUxVQ/AdFLuRVt0w47R+pnHwBUyOwuw4YGrqPZpoVNZnUSa0+cJ2d
   LMbN45ymJ1B8dOC2+8hCkoni2h1+e2mqXQTC9jVGihkn4hqnayDycgwEW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22586893"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22586893"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12265634"
Received: from s2600wttr.bj.intel.com ([10.240.192.113])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:41 -0700
From: Li Ming <ming4.li@intel.com>
To: dan.j.williams@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming4.li@intel.com>
Subject: [RFC PATCH 4/6] PCI/AER: Extend RCH RAS error handling to support VH topology case
Date: Wed, 13 Mar 2024 08:36:00 +0000
Message-Id: <20240313083602.239201-5-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240313083602.239201-1-ming4.li@intel.com>
References: <20240313083602.239201-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When RCEC captures CXL.cachemem protocol errors detected by CXL root
port, the recommendation from CXL r3.1 9.18.1.5 is :

	"Probe all CXL Downstream Ports and determine whether they have logged an
	error in the CXL.io or CXL.cachemem status registers."

The flow is similar with RCH RAS error handling, so reuse it to support
above case.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/pci/pcie/aer.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 364c74e47273..79bfa5fb78f4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -996,11 +996,15 @@ static bool is_internal_error(struct aer_err_info *info)
 	return info->status & PCI_ERR_UNC_INTN;
 }
 
-static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
+static int cxl_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
 	const struct pci_error_handlers *err_handler;
 
+	/* Skip the RCiEP devices not associating with RCEC */
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) &&
+	    !dev->rcec)
+		return 0;
 	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
 		return 0;
 
@@ -1025,16 +1029,16 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	/*
 	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
+	 * RCH's downstream port or a CXL root port. Check and handle
+	 * them in the CXL.mem device driver.
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
 	    is_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+		pcie_walk_rcec_all(dev, cxl_handle_error_iter, info);
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
@@ -1080,8 +1084,8 @@ static void cxl_enable_rcec(struct pci_dev *rcec)
 
 #else
 static inline void cxl_enable_rcec(struct pci_dev *dev) { }
-static inline void cxl_rch_handle_error(struct pci_dev *dev,
-					struct aer_err_info *info) { }
+static inline void cxl_handle_error(struct pci_dev *dev,
+				    struct aer_err_info *info) { }
 #endif
 
 /**
@@ -1119,7 +1123,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_rch_handle_error(dev, info);
+	cxl_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
-- 
2.40.1


