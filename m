Return-Path: <linux-kernel+bounces-101248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96B887A493
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCCF2834A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCD225568;
	Wed, 13 Mar 2024 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTFdb27c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E04225AC;
	Wed, 13 Mar 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320683; cv=none; b=XcabbzNhmiGXgXezxoNHN0PaHvIzmXtUpOcvsk9Yo1PaEfTmvSI6lO/F+xzb3+bJ+qJ0am2edOpUBpI+wIjGyIvryDKDLZAurgAqLDxpA6oZqJYt7/PXBxerfALMntr9yoRfaIDoynO3FuL7NzmPZzpAdp5hD02DyVXRKKPGHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320683; c=relaxed/simple;
	bh=njHq/wxfjkmMzk/ugY+47vwXpLQCoq4Ln7TqkR1qc4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSiztW0M6ebBbQaNytbdMZBx/jmBUftt7FPWd528okx0njPBMYKM/LaQrn/0sKHuj/Uc6O9La/n9oNrvh9a2arCXhY8C385uMqlpx86qH/WV30toiAjiG23Qr7mFi76EHcow4GM+0wKTfZ03PfUeAC3wzZBEK4akvpYcza4A+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTFdb27c; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710320682; x=1741856682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=njHq/wxfjkmMzk/ugY+47vwXpLQCoq4Ln7TqkR1qc4A=;
  b=nTFdb27cbbzJl6RzhS06o7A2Pw08RDJdFA+jxbT2HD+qCZYKU18jioUe
   9X74UKSq8//wUl7IsJK1Ju1xOJhEG6h6WmKePkfc6Z83IlPHrc4GQO2EP
   NomjNSk2eEt+vwxtbvP7JF0WNeSPGIy8OS+WGtbfpnj0ELVTWHTQfRLsN
   VHLQJqMrvJGDjNe/uOHqwRATixXt1jfm/HRSqAGa/xmxmFYfb39h89tNw
   ZCV7k4YHJvOpBrBo/8fWoSM6bq5mjEzF8C/NFRSZLx2wQCmsUUJwY1n5Q
   y8MKnBGDnmupTMbpOcnWJZHi8kNkk1AQ2Q1y061ygle8B3aRXZTJbCRku
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22586888"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22586888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12265626"
Received: from s2600wttr.bj.intel.com ([10.240.192.113])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:39 -0700
From: Li Ming <ming4.li@intel.com>
To: dan.j.williams@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming4.li@intel.com>
Subject: [RFC PATCH 3/6] PCI/AER: Enable RCEC to report internal error for CXL root port
Date: Wed, 13 Mar 2024 08:35:59 +0000
Message-Id: <20240313083602.239201-4-ming4.li@intel.com>
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

Per CXl r3.1 section 12.2.2, CXL.cachemem protocol erros detected by CXL
root port could be logged in RCEC AER Extended Capability as
PCI_ERR_UNC_INTN or PCI_ERR_COR_INTERNAL. Unmask these errors for that
case.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/pci/pcie/aer.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 42a3bd35a3e1..364c74e47273 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -985,7 +985,7 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
-	return (pcie_ports_native || host->native_aer);
+	return (pcie_ports_native || host->native_aer) && host->is_cxl;
 }
 
 static bool is_internal_error(struct aer_err_info *info)
@@ -1041,8 +1041,13 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 {
 	bool *handles_cxl = data;
 
-	if (!*handles_cxl)
-		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
+	if (!*handles_cxl && cxl_error_is_native(dev)) {
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END &&
+		    dev->rcec && is_cxl_mem_dev(dev))
+			*handles_cxl = true;
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+			*handles_cxl = true;
+	}
 
 	/* Non-zero terminates iteration */
 	return *handles_cxl;
@@ -1054,13 +1059,18 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
 
 	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
 	    pcie_aer_is_native(rcec))
-		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+		pcie_walk_rcec_all(rcec, handles_cxl_error_iter, &handles_cxl);
 
 	return handles_cxl;
 }
 
-static void cxl_rch_enable_rcec(struct pci_dev *rcec)
+static void cxl_enable_rcec(struct pci_dev *rcec)
 {
+	/*
+	 * Enable RCEC's internal error report for two cases:
+	 * 1. RCiEP detected CXL.cachemem protocol errors
+	 * 2. CXL root port detected CXL.cachemem protocol errors.
+	 */
 	if (!handles_cxl_errors(rcec))
 		return;
 
@@ -1069,7 +1079,7 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
 }
 
 #else
-static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
+static inline void cxl_enable_rcec(struct pci_dev *dev) { }
 static inline void cxl_rch_handle_error(struct pci_dev *dev,
 					struct aer_err_info *info) { }
 #endif
@@ -1494,7 +1504,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
-	cxl_rch_enable_rcec(port);
+	cxl_enable_rcec(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.40.1


