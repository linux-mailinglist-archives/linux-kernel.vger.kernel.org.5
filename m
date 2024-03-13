Return-Path: <linux-kernel+bounces-101250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A24B87A497
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA491F2299B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA01CF9C;
	Wed, 13 Mar 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHqpBe+s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE22E64E;
	Wed, 13 Mar 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320687; cv=none; b=A5kllIJeOhFaO+nKhTqNz/jn7uIqKBTZtdMPW40lT3s/+gS2YlzKg2VbQiSsZARsbare64VtLFiImCIirNG1uxfHS+CqkjtYbWyQZBT2Q48sC27wWJT3sSKpJbjF2RZORbqfv9/yZUhowC0Mz4uz2IkcPJCkppVnTqsXg1fxD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320687; c=relaxed/simple;
	bh=bdjRVrFiBAZVBjFLvU3URBuucAkGET+Mkv7SXM2nCHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rfNVyr7Myf79MwWb7T6/t8qAOKtIz5DyUvdLkcWBm828Um1RWRmzapics3rObd6aCcqr5XyHe79628+AIaW+NswJgbq8Lzws6Chw+LqTFmNnoPYinLcIkf6utNzYbPZ/e6kmGGT2q9xZFmUjilltWnYsst3yppAz/E7gh51FbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHqpBe+s; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710320686; x=1741856686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bdjRVrFiBAZVBjFLvU3URBuucAkGET+Mkv7SXM2nCHo=;
  b=nHqpBe+sHBpfrEdmb/+KnnFw6U64YWVPntohXd2f+65pbwNIbQUcZjp+
   RTJgCY8P6QNQ8NqBLsATJoU8qssWU+VQ+t5zPAtvh47fMF+Fh6RDppJ4+
   Ki0glwuMl+tAgfMhISmIfKdjmh4Y4uc60xtLromv1aLd6u/+rrkJTM9Vo
   GAPO+1FNF77ebVrAVQys9x+k6nlnjEaeoWcIltj8m+nMovrWVd8Mgi3gZ
   yyWvzA4bbDI1uNwt8xVLhQs1Jg7IPhVAfk2C+GOfUa3MFBc4iLz8/6n9g
   c5/aVeXvwLzdKCI7lraAbxgNwt5JblYxTBDXDt9c+V2CcLb1Yf10V3fBh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22586900"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22586900"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12265646"
Received: from s2600wttr.bj.intel.com ([10.240.192.113])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:43 -0700
From: Li Ming <ming4.li@intel.com>
To: dan.j.williams@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming4.li@intel.com>
Subject: [RFC PATCH 5/6] cxl: Use __free() for cxl_pci/mem_find_port() to drop put_device()
Date: Wed, 13 Mar 2024 08:36:01 +0000
Message-Id: <20240313083602.239201-6-ming4.li@intel.com>
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

Introduce a new helper function called put_cxl_port() to instead of the
put_device() in order to release the device reference of struct cxl_port
got via get_device() in cxl_pci/mem_find_port().

Besides, use scope-based resource management __free() to drop the open
coded put_device() for each cxl_pci/mem_find_port().

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/pci.c  |  6 ++----
 drivers/cxl/core/port.c |  9 +++++++++
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/mem.c       |  5 ++---
 drivers/cxl/pci.c       | 12 +++++-------
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6c9c8d92f8f7..7254484330d2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -902,15 +902,13 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
 	struct cxl_dport *dport;
-	struct cxl_port *port;
 	int severity;
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
 
-	port = cxl_pci_find_port(pdev, &dport);
 	if (!port)
 		return;
 
-	put_device(&port->dev);
-
 	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
 		return;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..6e2fc2fce7c9 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1671,6 +1671,15 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
 
+void put_cxl_port(struct cxl_port *port)
+{
+	if (!port)
+		return;
+
+	put_device(&port->dev);
+}
+EXPORT_SYMBOL_NS_GPL(put_cxl_port, CXL);
+
 static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 				    struct cxl_port *port, int *target_map)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6017c0c57b4..476158782e3e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -743,6 +743,8 @@ struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 				   struct cxl_dport **dport);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport);
+void put_cxl_port(struct cxl_port *port);
+DEFINE_FREE(put_cxl_port, struct cxl_port *, if (_T) put_cxl_port(_T))
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c5c9d8e0d88d..5aaa8ee2a46d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -109,7 +109,6 @@ static int cxl_mem_probe(struct device *dev)
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *endpoint_parent;
-	struct cxl_port *parent_port;
 	struct cxl_dport *dport;
 	struct dentry *dentry;
 	int rc;
@@ -146,7 +145,8 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	parent_port = cxl_mem_find_port(cxlmd, &dport);
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		cxl_mem_find_port(cxlmd, &dport);
 	if (!parent_port) {
 		dev_err(dev, "CXL port topology not found\n");
 		return -ENXIO;
@@ -170,7 +170,6 @@ static int cxl_mem_probe(struct device *dev)
 	rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
 unlock:
 	device_unlock(endpoint_parent);
-	put_device(&parent_port->dev);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4fd1f207c84e..d0ec8c5b1e99 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -473,23 +473,21 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
 static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 				  struct cxl_register_map *map)
 {
-	struct cxl_port *port;
 	struct cxl_dport *dport;
 	resource_size_t component_reg_phys;
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+
+	if (!port)
+		return -EPROBE_DEFER;
 
 	*map = (struct cxl_register_map) {
 		.host = &pdev->dev,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
-	port = cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
 	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
 
-	put_device(&port->dev);
-
 	if (component_reg_phys == CXL_RESOURCE_NONE)
 		return -ENXIO;
 
-- 
2.40.1


