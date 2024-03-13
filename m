Return-Path: <linux-kernel+bounces-101246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F387A490
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E1CB21E77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A926D225A6;
	Wed, 13 Mar 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLtv1WXf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB71B7FE;
	Wed, 13 Mar 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320680; cv=none; b=gtjKT/Y6x+rtJFrar5+EJuOQLGVteMo9v57ofTe64Vjokoyrf24wlB3Yb0tmya+s7SBLktqBl9ewaSdT2550yl5bjtII7DnYtiRsgYOYkrM/wCrnWf0HGJ7AcK0lQfJ6HjuWiTj+/gF51kfBinsdK0EciR44bb3zUxUZWUb9aqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320680; c=relaxed/simple;
	bh=/POb0gRCrTWVO7oygRZEsKACcsqc9KTtU1WqkcFMu/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0wKC4PYowqD+IuDz63iGDR8LOe7gW5ypT92IvzMcA/D3ty6HMNQTcvPhM0HWOaZ1B5A334bH2gkBlp6plIP28YupYvkSf2O6KX+SqzNQCnis/ykicN+7dv6oyZMNv8KIVHK1vDa4m+PP4BgwdMriq/O3Enwx8tkaqz6bW8i/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLtv1WXf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710320679; x=1741856679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/POb0gRCrTWVO7oygRZEsKACcsqc9KTtU1WqkcFMu/I=;
  b=KLtv1WXfsOCHPb2lSLAXxNYZzeINM2EMfmsUZ0TRDIii/qFSRBOnGpc2
   24QHlm8ekcijwYfvhjjZS7N/hJ35MreboJrVqBB5N5uJ3cto38unqyMho
   OV/COMNmQzWr8RJE+EA291hAPa0btXzu2wwsxFPSqOI+qFBBsWE2h7VvK
   KUSrjqAYwK/Xny5aYLnZC5jdNoEj0ejPts1IUuHBDcS1LZx/HdoZDVHPj
   eQI3yf/dsnbJHsvFroZgiiLqXzUQEx5ttfqG0RWUNkuLFnosdvnIPlve8
   eQfrKBlpAdvdTqXfqZcbto3aR3AeseNeLP5ByazYGv1fJBElDcSy+nBoD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22586883"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22586883"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12265612"
Received: from s2600wttr.bj.intel.com ([10.240.192.113])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:37 -0700
From: Li Ming <ming4.li@intel.com>
To: dan.j.williams@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming4.li@intel.com>
Subject: [RFC PATCH 2/6] PCI/CXL: A new attribute to indicate CXL-capable host bridge
Date: Wed, 13 Mar 2024 08:35:58 +0000
Message-Id: <20240313083602.239201-3-ming4.li@intel.com>
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

Introduce a new attribute called 'is_cxl' in struct pci_host_bridge to
indicate if the PCI host bridge is CXl capable.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/acpi/pci_root.c | 1 +
 include/linux/pci.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 58b89b8d950e..4ab0dc8450ce 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1034,6 +1034,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		goto out_release_info;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
+	host_bridge->is_cxl = is_cxl(root);
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
 		host_bridge->native_pcie_hotplug = 0;
 	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bf6c02bee49f..bbe90e730285 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -587,6 +587,7 @@ struct pci_host_bridge {
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
 	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
+	unsigned int	is_cxl:1;		/* CXL capable Host Bridge */
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
-- 
2.40.1


