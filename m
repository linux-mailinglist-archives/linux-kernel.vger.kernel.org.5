Return-Path: <linux-kernel+bounces-50901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1429848013
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E98B27B74
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E5A111A4;
	Sat,  3 Feb 2024 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kX/rc4Fk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCECDF9FD;
	Sat,  3 Feb 2024 04:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933047; cv=none; b=rAoPNJKfdblkP07BDaA97EBWiTsL0XuetURcYkUWLiIKVp18vgvjWucZOWa96wWXNM5920C/oboFxDh9kxn/mRHbtdOXb/rgBQAK5PojpV7m7LfPTiBVzzF++zW92c+UBTXjAAYZN2pBGCTM/AJ1v4uBND4C/6Yga+uWMyE56rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933047; c=relaxed/simple;
	bh=Pcpg+RONIxK6V+cB6JOTzMh7v9Tu8BTb7TgeuU7pUV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UoOcj6OSj8ar1gji3u3ak/0u/5rC1GFQtqN8Wc1SChEJW2HbOnbhijcSb5NTXXaVO0Gb7pusjvFN+3clH8NIlq7fpP93kImBo9OGCBdPMZlaD4+vv5mG8QWVMMFnGqyPBHIQQem3EuvOSUMNwCwnEofo98ES8vB3helgCvTZpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kX/rc4Fk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706933046; x=1738469046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Pcpg+RONIxK6V+cB6JOTzMh7v9Tu8BTb7TgeuU7pUV4=;
  b=kX/rc4Fkf/tBAyaX0uyKsX0onz6aoBcXH0IYYm0cuGgpIbJn78sGb5VT
   68fYXO/MCUyiCz+JAAapKaRFCyUWVTaaUueX6ahjY271jNVPf2+cX1Omz
   XFiNlNMn9I+2WMwlNK1ghcN/ZWQg8+P5rbn3SgDVIjZqh5h1SQb30y3VB
   JBwaubJTYPwMb7ghGwFBvzSwmzgZB/bNa4FoKR5g1Xq2i2aMIUBh4zYgU
   hnzyFO6NHPvQEGrUo2i/cmN4oJITmWWZAH+ujQOLn65aIUEH2pvkvuld6
   9koOEgsqY4GVgaZ2NwLlCaFjd4+KNbrDOkO5VDKrr7APGGXn+uxfszbgT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4181417"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4181417"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823382511"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823382511"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 20:04:03 -0800
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
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 3/9] thermal: intel: hfi: Move selected data structures to a header file
Date: Fri,  2 Feb 2024 20:05:09 -0800
Message-Id: <20240203040515.23947-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Zhuocheng Ding <zhuocheng.ding@intel.com>

The virtualization of HFI needs the definitions of HFI capabilities and
the HFI table. Move these definitions into a header file under arch/x86.
No changes in the relocated structures.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 MAINTAINERS                       |  1 +
 arch/x86/include/asm/hfi.h        | 70 +++++++++++++++++++++++++++++++
 drivers/thermal/intel/intel_hfi.c | 66 +----------------------------
 3 files changed, 72 insertions(+), 65 deletions(-)
 create mode 100644 arch/x86/include/asm/hfi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8999497011a2..8bc873ba82fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21788,6 +21788,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pm/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
+F:	arch/x86/include/asm/hfi.h
 F:	Documentation/ABI/testing/sysfs-class-thermal
 F:	Documentation/admin-guide/thermal/
 F:	Documentation/devicetree/bindings/thermal/
diff --git a/arch/x86/include/asm/hfi.h b/arch/x86/include/asm/hfi.h
new file mode 100644
index 000000000000..ed8a548a376e
--- /dev/null
+++ b/arch/x86/include/asm/hfi.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_HFI_H
+#define _ASM_X86_HFI_H
+
+/* CPUID detection and enumeration definitions for HFI */
+
+union hfi_capabilities {
+	struct {
+		u8	performance:1;
+		u8	energy_efficiency:1;
+		u8	__reserved:6;
+	} split;
+	u8 bits;
+};
+
+union cpuid6_edx {
+	struct {
+		union hfi_capabilities	capabilities;
+		u32			table_pages:4;
+		u32			__reserved:4;
+		s32			index:16;
+	} split;
+	u32 full;
+};
+
+/**
+ * struct hfi_hdr - Header of the HFI table
+ * @perf_updated:	Hardware updated performance capabilities
+ * @ee_updated:		Hardware updated energy efficiency capabilities
+ *
+ * Properties of the data in an HFI table.
+ */
+struct hfi_hdr {
+	u8	perf_updated;
+	u8	ee_updated;
+} __packed;
+
+/**
+ * struct hfi_table - Representation of an HFI table
+ * @base_addr:		Base address of the local copy of the HFI table
+ * @timestamp:		Timestamp of the last update of the local table.
+ *			Located at the base of the local table.
+ * @hdr:		Base address of the header of the local table
+ * @data:		Base address of the data of the local table
+ */
+struct hfi_table {
+	union {
+		void			*base_addr;
+		u64			*timestamp;
+	};
+	void			*hdr;
+	void			*data;
+};
+
+/**
+ * struct hfi_features - Supported HFI features
+ * @nr_table_pages:	Size of the HFI table in 4KB pages
+ * @cpu_stride:		Stride size to locate the capability data of a logical
+ *			processor within the table (i.e., row stride)
+ * @hdr_size:		Size of the table header
+ *
+ * Parameters and supported features that are common to all HFI instances
+ */
+struct hfi_features {
+	size_t		nr_table_pages;
+	unsigned int	cpu_stride;
+	unsigned int	hdr_size;
+};
+
+#endif /* _ASM_X86_HFI_H */
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index eeabdf072efd..ee8950a60f72 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -41,6 +41,7 @@
 #include <linux/topology.h>
 #include <linux/workqueue.h>
 
+#include <asm/hfi.h>
 #include <asm/msr.h>
 
 #include "intel_hfi.h"
@@ -48,29 +49,8 @@
 
 #include "../thermal_netlink.h"
 
-/* CPUID detection and enumeration definitions for HFI */
-
 #define CPUID_HFI_LEAF 6
 
-union hfi_capabilities {
-	struct {
-		u8	performance:1;
-		u8	energy_efficiency:1;
-		u8	__reserved:6;
-	} split;
-	u8 bits;
-};
-
-union cpuid6_edx {
-	struct {
-		union hfi_capabilities	capabilities;
-		u32			table_pages:4;
-		u32			__reserved:4;
-		s32			index:16;
-	} split;
-	u32 full;
-};
-
 /**
  * struct hfi_cpu_data - HFI capabilities per CPU
  * @perf_cap:		Performance capability
@@ -84,35 +64,6 @@ struct hfi_cpu_data {
 	u8	ee_cap;
 } __packed;
 
-/**
- * struct hfi_hdr - Header of the HFI table
- * @perf_updated:	Hardware updated performance capabilities
- * @ee_updated:		Hardware updated energy efficiency capabilities
- *
- * Properties of the data in an HFI table.
- */
-struct hfi_hdr {
-	u8	perf_updated;
-	u8	ee_updated;
-} __packed;
-
-/**
- * struct hfi_table - Representation of an HFI table
- * @base_addr:		Base address of the local copy of the HFI table
- * @timestamp:		Timestamp of the last update of the local table.
- *			Located at the base of the local table.
- * @hdr:		Base address of the header of the local table
- * @data:		Base address of the data of the local table
- */
-struct hfi_table {
-	union {
-		void			*base_addr;
-		u64			*timestamp;
-	};
-	void			*hdr;
-	void			*data;
-};
-
 /**
  * struct hfi_instance - Representation of an HFI instance (i.e., a table)
  * @local_table:	Local copy of HFI table for this instance
@@ -133,21 +84,6 @@ struct hfi_instance {
 	raw_spinlock_t		event_lock;
 };
 
-/**
- * struct hfi_features - Supported HFI features
- * @nr_table_pages:	Size of the HFI table in 4KB pages
- * @cpu_stride:		Stride size to locate the capability data of a logical
- *			processor within the table (i.e., row stride)
- * @hdr_size:		Size of the table header
- *
- * Parameters and supported features that are common to all HFI instances
- */
-struct hfi_features {
-	size_t		nr_table_pages;
-	unsigned int	cpu_stride;
-	unsigned int	hdr_size;
-};
-
 /**
  * struct hfi_cpu_info - Per-CPU attributes to consume HFI data
  * @index:		Row of this CPU in its HFI table
-- 
2.25.1


