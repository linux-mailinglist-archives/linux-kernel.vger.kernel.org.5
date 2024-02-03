Return-Path: <linux-kernel+bounces-50902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5211848014
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064F21C223CB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910611723;
	Sat,  3 Feb 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zxvj/Vqf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E21101C2;
	Sat,  3 Feb 2024 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933048; cv=none; b=ir/oDAjRXSF/ITrHBM20FfROQ7a0y70lwpecKGGrhzQVDVYH1QStqrAP/jIf5eoOxO65UiEsU1APaAf/8cg+MPVYP4nltBCj/kBk6iQA+zyiCLwLa3g8WyAdL+UQo4YY+3rwBcbglkC8QUmdgOctSxcnjzVF6s+36CULpJuMrtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933048; c=relaxed/simple;
	bh=9cnaRm9LjI9lLTU3jJB4JtwuQf6hd8BghI7MVlZAsVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VoeP8AL+f5n08sT7Mg9mnVnFt2K1sH20aQdM9pY8zYnSPIKkvtFjt3Ma4apFNoumwXsfx4QarpXUkCO5GI/WZjPKA4YBcPStYNLaufnkaVgV7gtU8G/Fn0o3h89oGKdoUwwyZWHmgd8C4Z7/GIL8aBqa0oNLpnPsLA65RvyJ/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zxvj/Vqf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706933047; x=1738469047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9cnaRm9LjI9lLTU3jJB4JtwuQf6hd8BghI7MVlZAsVg=;
  b=Zxvj/Vqf4mQN3EX2vDoy4Z5j8adWABlH8wLILj80UtAnyEB2cKXIukiO
   s1GMR2DIg2zNncbUIaS7OPWJ122arUC/rSlbvk4+MPUWwengkdK/O2Wyy
   b79hhpqq5OEc/sKTiarIRMIYT7ZRG3+hFUT1hdE/++sHX5RWQMmE/Qmpk
   itaIK5pJZeYTt3K4f+L4fVv5hCmuBJ2oN45ljdkcBfU2YReqqov5TDgxV
   YlIzvKwWnG23qPwevEPLFBwbQNsWXVRJtGJ/U/bMuv8Tu7hfpnhd693Fm
   LV5DFA7KisJaXpkxN3jVKwocy+70CduaIp9mrShC/oc+L1XtQQrNaWMlp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4181419"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4181419"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823382515"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823382515"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 20:04:04 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>,
	x86@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH 4/9] thermal: intel: hfi: Introduce Intel Thread Director classes
Date: Fri,  2 Feb 2024 20:05:10 -0800
Message-Id: <20240203040515.23947-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Intel hybrid parts, each type of CPU has specific performance and
energy efficiency capabilities. The Intel Thread Director technology
extends the Hardware Feedback Interface (HFI) to provide performance and
energy efficiency data for advanced classes of instructions.

Add support to parse per-class capabilities.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Zhuocheng Ding <zhuocheng.ding@intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Patch cherry-picked from the IPC classes patchset.
---
---
 arch/x86/include/asm/hfi.h        |  8 +++++++-
 drivers/thermal/intel/intel_hfi.c | 22 +++++++++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hfi.h b/arch/x86/include/asm/hfi.h
index ed8a548a376e..02ee56dbaeb6 100644
--- a/arch/x86/include/asm/hfi.h
+++ b/arch/x86/include/asm/hfi.h
@@ -28,7 +28,8 @@ union cpuid6_edx {
  * @perf_updated:	Hardware updated performance capabilities
  * @ee_updated:		Hardware updated energy efficiency capabilities
  *
- * Properties of the data in an HFI table.
+ * Properties of the data in an HFI table. There exists one header per each
+ * HFI class.
  */
 struct hfi_hdr {
 	u8	perf_updated;
@@ -54,16 +55,21 @@ struct hfi_table {
 
 /**
  * struct hfi_features - Supported HFI features
+ * @nr_classes:		Number of classes supported
  * @nr_table_pages:	Size of the HFI table in 4KB pages
  * @cpu_stride:		Stride size to locate the capability data of a logical
  *			processor within the table (i.e., row stride)
+ * @class_stride:	Stride size to locate a class within the capability
+ *			data of a logical processor or the HFI table header
  * @hdr_size:		Size of the table header
  *
  * Parameters and supported features that are common to all HFI instances
  */
 struct hfi_features {
+	unsigned int	nr_classes;
 	size_t		nr_table_pages;
 	unsigned int	cpu_stride;
+	unsigned int	class_stride;
 	unsigned int	hdr_size;
 };
 
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index ee8950a60f72..3c399f3d059f 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -57,7 +57,7 @@
  * @ee_cap:		Energy efficiency capability
  *
  * Capabilities of a logical processor in the HFI table. These capabilities are
- * unitless.
+ * unitless and specific to each HFI class.
  */
 struct hfi_cpu_data {
 	u8	perf_cap;
@@ -277,8 +277,8 @@ static void init_hfi_cpu_index(struct hfi_cpu_info *info)
 }
 
 /*
- * The format of the HFI table depends on the number of capabilities that the
- * hardware supports. Keep a data structure to navigate the table.
+ * The format of the HFI table depends on the number of capabilities and classes
+ * that the hardware supports. Keep a data structure to navigate the table.
  */
 static void init_hfi_instance(struct hfi_instance *hfi_instance)
 {
@@ -498,18 +498,30 @@ static __init int hfi_parse_features(void)
 	/* The number of 4KB pages required by the table */
 	hfi_features.nr_table_pages = edx.split.table_pages + 1;
 
+	/*
+	 * Capability fields of an HFI class are grouped together. Classes are
+	 * contiguous in memory.  Hence, use the number of supported features to
+	 * locate a specific class.
+	 */
+	hfi_features.class_stride = nr_capabilities;
+
+	/* For now, use only one class of the HFI table */
+	hfi_features.nr_classes = 1;
+
 	/*
 	 * The header contains change indications for each supported feature.
 	 * The size of the table header is rounded up to be a multiple of 8
 	 * bytes.
 	 */
-	hfi_features.hdr_size = DIV_ROUND_UP(nr_capabilities, 8) * 8;
+	hfi_features.hdr_size = DIV_ROUND_UP(nr_capabilities *
+					     hfi_features.nr_classes, 8) * 8;
 
 	/*
 	 * Data of each logical processor is also rounded up to be a multiple
 	 * of 8 bytes.
 	 */
-	hfi_features.cpu_stride = DIV_ROUND_UP(nr_capabilities, 8) * 8;
+	hfi_features.cpu_stride = DIV_ROUND_UP(nr_capabilities *
+					       hfi_features.nr_classes, 8) * 8;
 
 	return 0;
 }
-- 
2.25.1


