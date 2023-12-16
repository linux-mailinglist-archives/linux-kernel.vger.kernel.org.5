Return-Path: <linux-kernel+bounces-1913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE8E8155B8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710CBB23AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F75E1100;
	Sat, 16 Dec 2023 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGOwgGT4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69A517E8;
	Sat, 16 Dec 2023 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702687912; x=1734223912;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FrdnvABXLWZBgVFBeb7jdyh66RlSMWph5cvL0Ajf7EI=;
  b=kGOwgGT4NVyfxj0Dy/K1VxzSUyB2vGWurvA3jPOAHP687v3iJ392Wozm
   QtWfAPgzqNqXT3l04kCn5XWvTIJXMWRKqhpWZ7IHRlUnipbE4H9r6B70n
   wAsujWscNy/uueYzVLtqBoh9P+1Tsmp3Z6ibH4G2cFljKtfmlQc9fxLqR
   8eQ1NXczlZJ92EWuGlHIWcBjNeao8oY5HtISsMXL/hph5GVpihC80HEBE
   8w+F7SdE6nwuCKtcrdz2CEapJXlkprdlbc5R55igtwYWF8rDPKQh1pxvl
   hU25nLOaorNGfsQZ5A268d0uGA8RBFO7ISKeCkjet2bUiXV7lpE/Y8txE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2171699"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2171699"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 16:51:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="898310133"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="898310133"
Received: from simmons1-mobl5.amr.corp.intel.com (HELO rjingar-desk5.intel.com) ([10.213.162.133])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 16:51:50 -0800
From: rjingar <rajvi.jingar@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Cc: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Subject: [PATCH] platform/x86/intel/vsec: Add support for Lunar Lake M
Date: Fri, 15 Dec 2023 16:51:46 -0800
Message-Id: <20231216005146.1735455-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajvi Jingar <rajvi.jingar@linux.intel.com>

Add Lunar Lake M PMT telemetry support.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index c1f9e4471b28..3567dba57781 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -421,6 +421,11 @@ static const struct intel_vsec_platform_info tgl_info = {
 	.quirks = VSEC_QUIRK_TABLE_SHIFT | VSEC_QUIRK_EARLY_HW,
 };
 
+/* LNL info */
+static const struct intel_vsec_platform_info lnl_info = {
+	.caps = VSEC_CAP_TELEMETRY | VSEC_CAP_WATCHER,
+};
+
 #define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
 #define PCI_DEVICE_ID_INTEL_VSEC_DG1		0x490e
 #define PCI_DEVICE_ID_INTEL_VSEC_MTL_M		0x7d0d
@@ -428,6 +433,7 @@ static const struct intel_vsec_platform_info tgl_info = {
 #define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
 #define PCI_DEVICE_ID_INTEL_VSEC_RPL		0xa77d
 #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
+#define PCI_DEVICE_ID_INTEL_VSEC_LNL_M		0x647d
 static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
@@ -436,6 +442,7 @@ static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &oobmsm_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_LNL_M, &lnl_info) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_vsec_pci_ids);
-- 
2.34.1


