Return-Path: <linux-kernel+bounces-155864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3C8AF82E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C379B25DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3596E14388A;
	Tue, 23 Apr 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLzUSBmr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC18142E7C;
	Tue, 23 Apr 2024 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905186; cv=none; b=EFBIHPDV38b7gR5htaICc6y5bAAcSroDLW51UlrCPSkdimxrrmfk+uklmSp1vxtEi6AQaRMzAx7JORyxBkojX+VXQ8edPKiN5TgZth6Q/48Uj2wGm8WLlqPZgyMxoyP4SL2tRlf/9OGonnez+Y7VpuVbZVB2pbJilGsG05Juuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905186; c=relaxed/simple;
	bh=75pbXDBuz3te5n9FvztG+mhIMF2b3+e80CL0R9tbGA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdygYQZg5kVyZvv1eStCKN9YJ1yZ4JosqtRF+xfl/Tu5/X2oEXlLwka12lbOSnIaKw3Iqfb5dt0GDmEVr5wi0kr7Qrz5+3sg7+EipLq5uywfH2cIQps72NVqIJyJHcaIYPrXFVZ+yjwcJWVkcu+pt+7fNfmlgdI/trT8wgmJi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLzUSBmr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905185; x=1745441185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75pbXDBuz3te5n9FvztG+mhIMF2b3+e80CL0R9tbGA0=;
  b=TLzUSBmrYhYRyI41/bBsa55Ltk9oqqtlOs/G5DaZn/b7DoGflVlBsJKo
   T+kbpQKAfHEu4ZDH6y9XAQ/tFV81q4Nb4zW2sRSFKZ9qt6K3BaI4opOg0
   YOV6tai9/fIBvKy4gZIgNrtIaJZuRfMA1bF5x9o4q60qjD/sld0tLLjUe
   76ipWMtz6xGDORE22JbigpusEC+l7+kC4T/QP0oolUeqHXxEBjFARqfL/
   d2IUzEKihATwiHnZCP1JHZtPrx/loBdUAzDk2PUhArNCNDTURRdYMYTft
   N2ydwneRCyAsvNxYSy8saVGnmN39baApgcyyMKnAuvT2jwsp/WdmS9s77
   w==;
X-CSE-ConnectionGUID: KbUWeCneSVSOngvHJhFSng==
X-CSE-MsgGUID: l3AJGxamS4aoUlYAnw05jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912318"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912318"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:23 -0700
X-CSE-ConnectionGUID: R5NW+pS7RzWJZ5rm3K4sMw==
X-CSE-MsgGUID: dSXyhod7RWqNq7Vevoz9VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533080"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:23 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 02/10] platform/x86/intel/tpmi: Check major version change for TPMI Information
Date: Tue, 23 Apr 2024 13:46:11 -0700
Message-Id: <20240423204619.3946901-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
References: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Check the major version from TPMI information header and fail to load
driver if the version is not supported.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 003e765dedea..a5bcb77bcb35 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -666,28 +666,37 @@ static int tpmi_create_devices(struct intel_tpmi_info *tpmi_info)
 }
 
 #define TPMI_INFO_BUS_INFO_OFFSET	0x08
+#define TPMI_INFO_MAJOR_VERSION		0x00
 
 static int tpmi_process_info(struct intel_tpmi_info *tpmi_info,
 			     struct intel_tpmi_pm_feature *pfs)
 {
 	struct tpmi_info_header header;
 	void __iomem *info_mem;
+	u64 feature_header;
+	int ret = 0;
 
-	info_mem = ioremap(pfs->vsec_offset + TPMI_INFO_BUS_INFO_OFFSET,
-			   pfs->pfs_header.entry_size * sizeof(u32) - TPMI_INFO_BUS_INFO_OFFSET);
+	info_mem = ioremap(pfs->vsec_offset, pfs->pfs_header.entry_size * sizeof(u32));
 	if (!info_mem)
 		return -ENOMEM;
 
-	memcpy_fromio(&header, info_mem, sizeof(header));
+	feature_header = readq(info_mem);
+	if (TPMI_MAJOR_VERSION(feature_header) != TPMI_INFO_MAJOR_VERSION) {
+		ret = -ENODEV;
+		goto error_info_header;
+	}
+
+	memcpy_fromio(&header, info_mem + TPMI_INFO_BUS_INFO_OFFSET, sizeof(header));
 
 	tpmi_info->plat_info.package_id = header.pkg;
 	tpmi_info->plat_info.bus_number = header.bus;
 	tpmi_info->plat_info.device_number = header.dev;
 	tpmi_info->plat_info.function_number = header.fn;
 
+error_info_header:
 	iounmap(info_mem);
 
-	return 0;
+	return ret;
 }
 
 static int tpmi_fetch_pfs_header(struct intel_tpmi_pm_feature *pfs, u64 start, int size)
-- 
2.40.1


