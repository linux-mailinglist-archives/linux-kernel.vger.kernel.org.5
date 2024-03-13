Return-Path: <linux-kernel+bounces-101251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4364787A499
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8AAB21D08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F07B38380;
	Wed, 13 Mar 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLLR62tp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0E1B7F1;
	Wed, 13 Mar 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320689; cv=none; b=hsgtN6R3QQOvd1hz+CBbVorjfzxwDkxYndfjaWHLVsWeV9qQWvQgKEb2wSLPr83a0OvWRBDsNlq4P4m3p4GY/GbXv8U5j5GmmgrZWiwn+yfCXCpsbqFqPxw58SzojJDVoi/qNljOtmUPf8gXIbX6P5c2XjYk6yLrGrIZ5wbMsdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320689; c=relaxed/simple;
	bh=VV5p98jOb39/jQo9ir6M+cQENBSVyltBiiHZq5lYrcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQ7Ww+en0k2RVQQHN6BKKnLtGX+/G35nTpb+u8UWU89tUOHSTonx1ap5LMZUfV0cxNqg+Tin3xvN9N8hAD/XOBmnJEgJjm49E+4Qzh/Wspat+7ePwLr1BZinWevNagBln8P4fPciAelL4FnOQEAoqB29uVHrW5qW+x1OSyYrhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLLR62tp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710320688; x=1741856688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VV5p98jOb39/jQo9ir6M+cQENBSVyltBiiHZq5lYrcg=;
  b=hLLR62tp03sMiubOxlX/cfJ23sD6gGZkDeBslTtAeglvmngFuKR1OvJi
   p9cjWCuNUbuEr4vjq+R5XDGNNFUXqLBjjdBp6wVTgwM5xxk+RrFL9/hYY
   SO8wuzu/mM/kbrJIWGZ/bOmhhAw1LOCv0IctgWmVK2qimcBEWHiAChxcf
   bP9vFlNDASJy3z0MDAqtRvLYA5u16UlRVPcwgqMuQeBh/1ce9BEJ5A4YF
   Jpr5SiTZgSOmdIjuK2mAAmMPvsZ3A1uLW5gCMLgTMQ5DVdbLUVobX1VE6
   z2G4yyXfMh9NKFMQK2A+U2hH1fIfxxfgdZ9DpcFHo7T73Jw24CiuihpIp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22586904"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22586904"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12265660"
Received: from s2600wttr.bj.intel.com ([10.240.192.113])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:45 -0700
From: Li Ming <ming4.li@intel.com>
To: dan.j.williams@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming4.li@intel.com>
Subject: [RFC PATCH 6/6] cxl/pci: Support to handle root port RAS errors captured by RCEC
Date: Wed, 13 Mar 2024 08:36:02 +0000
Message-Id: <20240313083602.239201-7-ming4.li@intel.com>
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

The CXL subsystem already supports RCH RAS Error handling that has a
dependency on the RCEC. Reuse and extend that RCH topology support to
handle the errors detected by root port and logged in RCEC.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/pci.c | 83 ++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7254484330d2..154812f1f450 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -837,18 +837,6 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
 
-static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
-					  struct cxl_dport *dport)
-{
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
-}
-
-static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
-				       struct cxl_dport *dport)
-{
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
 /*
  * Copy the AER capability registers using 32 bit read accesses.
  * This is necessary because RCRB AER capability is MMIO mapped. Clear the
@@ -897,10 +885,45 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 	return false;
 }
 
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+/* Get AER severity from CXL RAS Capability */
+static bool cxl_ras_get_aer_severity(void __iomem *ras_base, int *severity)
+{
+	void __iomem *addr;
+	u32 ue_severity;
+	u32 status;
+
+	if (!ras_base)
+		return false;
+
+	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
+	status = readl(addr);
+	addr = ras_base + CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET;
+	ue_severity = readl(addr);
+	status &= CXL_RAS_UNCORRECTABLE_STATUS_MASK;
+	if (status) {
+		if (status & ue_severity)
+			*severity = AER_FATAL;
+		else
+			*severity = AER_NONFATAL;
+
+		return true;
+	}
+
+	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
+	status = readl(addr);
+	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
+		*severity = AER_CORRECTABLE;
+		return true;
+	}
+
+	return false;
+}
+
+static void cxl_handle_dport_errors(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
+	struct pci_dev *dport_pdev;
 	struct cxl_dport *dport;
 	int severity;
 	struct cxl_port *port __free(put_cxl_port) =
@@ -909,31 +932,38 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	if (!port)
 		return;
 
-	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
-		return;
-
-	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
-		return;
+	if (cxlds->rcd) {
+		if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
+			return;
 
-	pci_print_aer(pdev, severity, &aer_regs);
+		if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+			return;
+		pci_print_aer(pdev, severity, &aer_regs);
+	} else {
+		dport_pdev = to_pci_dev(dport->dport_dev);
+		/* TODO: add support for switch downstream port error handling */
+		if (pci_pcie_type(dport_pdev) != PCI_EXP_TYPE_ROOT_PORT)
+			return;
+		if (!cxl_ras_get_aer_severity(dport->regs.ras, &severity))
+			return;
+	}
 
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_rdport_cor_ras(cxlds, dport);
+		__cxl_handle_cor_ras(cxlds, dport->regs.ras);
 	else
-		cxl_handle_rdport_ras(cxlds, dport);
+		__cxl_handle_ras(cxlds, dport->regs.ras);
+
 }
 
 #else
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+static void cxl_handle_dport_errors(struct cxl_dev_state *cxlds) { }
 #endif
 
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 
-	if (cxlds->rcd)
-		cxl_handle_rdport_errors(cxlds);
-
+	cxl_handle_dport_errors(cxlds);
 	cxl_handle_endpoint_cor_ras(cxlds);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
@@ -946,8 +976,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
-	if (cxlds->rcd)
-		cxl_handle_rdport_errors(cxlds);
+	cxl_handle_dport_errors(cxlds);
 
 	/*
 	 * A frozen channel indicates an impending reset which is fatal to
-- 
2.40.1


