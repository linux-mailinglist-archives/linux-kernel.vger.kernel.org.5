Return-Path: <linux-kernel+bounces-110425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF45E885EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64372820CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2588113A275;
	Thu, 21 Mar 2024 16:51:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CB113A260
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039917; cv=none; b=OerbXHlgPix8F8HGjM/R52aL7B+fqJ1L2IudYgYrrYK+0R6HeOCyncH2kxTr4JFVHE6o/OlttR4rVgn2ZbaZHDgxBe/JdMIAmbbccdQ+Ett1xrXgZYSjlp3JFl4v2/QMh50kHpXpZMSV4sADOa4NRVhlmZpTnwV1Al2AkZVPlD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039917; c=relaxed/simple;
	bh=D6im2uatVAY3d2qHjwDBA6MtX1kiHCDULXvX4tpVQwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqmloK30t4oUYCbT0pQYGAMF6ODIyytRdpMN9mhbjfC3MXQ/inNwPeiaruuV1z8b+21e+wWRTg1tHrYqY6SdNqOWfRYx/hxrt8hcCxl+8QImh0nLwacHfdSGPZ7JtDroyoyRp2Ey+VqWezznhM8IsPRgKTYdTBayNM4XtHMMGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A40801688;
	Thu, 21 Mar 2024 09:52:29 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 667313F67D;
	Thu, 21 Mar 2024 09:51:52 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v1 08/31] x86/resctrl: Move resctrl types to a separate header
Date: Thu, 21 Mar 2024 16:50:43 +0000
Message-Id: <20240321165106.31602-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240321165106.31602-1-james.morse@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid sticky problems in the mpam glue code, move the resctrl
enums into a separate header.

This lets the arch code declare prototypes that use these enums without
creating a loop via asm<->linux resctrl.h The same logic applies to the
monitor-configuration defines, move these too.

The maintainers entry for these headers was missed when resctrl.h
was created. Add a wildcard entry to match both resctrl.h and
resctrl_types.h.

Signed-off-by: James Morse <james.morse@arm.com>
---
internal.h lacks a copyright notice so there is nothing to preserve
when creating a new file...
---
 MAINTAINERS                            |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 24 ---------
 include/linux/resctrl.h                | 35 +------------
 include/linux/resctrl_types.h          | 68 ++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 58 deletions(-)
 create mode 100644 include/linux/resctrl_types.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 43b39956694a..5621dd823e79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18543,6 +18543,7 @@ S:	Supported
 F:	Documentation/arch/x86/resctrl*
 F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
+F:	include/linux/resctrl*.h
 F:	tools/testing/selftests/resctrl/
 
 READ-COPY UPDATE (RCU)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 32ade929ea1b..031948322eab 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -32,30 +32,6 @@
  */
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
 
-/* Reads to Local DRAM Memory */
-#define READS_TO_LOCAL_MEM		BIT(0)
-
-/* Reads to Remote DRAM Memory */
-#define READS_TO_REMOTE_MEM		BIT(1)
-
-/* Non-Temporal Writes to Local Memory */
-#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
-
-/* Non-Temporal Writes to Remote Memory */
-#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
-
-/* Reads to Local Memory the system identifies as "Slow Memory" */
-#define READS_TO_LOCAL_S_MEM		BIT(4)
-
-/* Reads to Remote Memory the system identifies as "Slow Memory" */
-#define READS_TO_REMOTE_S_MEM		BIT(5)
-
-/* Dirty Victims to All Types of Memory */
-#define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
-
-/* Max event bits supported */
-#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
-
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index c5fcbb524136..b0ee7256e095 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pid.h>
+#include <linux/resctrl_types.h>
 
 /* CLOSID, RMID value used by the default control group */
 #define RESCTRL_RESERVED_CLOSID		0
@@ -24,40 +25,6 @@ int proc_resctrl_show(struct seq_file *m,
 /* max value for struct rdt_domain's mbps_val */
 #define MBA_MAX_MBPS   U32_MAX
 
-/**
- * enum resctrl_conf_type - The type of configuration.
- * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
- * @CDP_CODE:	Configuration applies to instruction fetches.
- * @CDP_DATA:	Configuration applies to reads and writes.
- */
-enum resctrl_conf_type {
-	CDP_NONE,
-	CDP_CODE,
-	CDP_DATA,
-};
-
-enum resctrl_res_level {
-	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L2,
-	RDT_RESOURCE_MBA,
-	RDT_RESOURCE_SMBA,
-
-	/* Must be the last */
-	RDT_NUM_RESOURCES,
-};
-
-#define CDP_NUM_TYPES	(CDP_DATA + 1)
-
-/*
- * Event IDs, the values match those used to program IA32_QM_EVTSEL before
- * reading IA32_QM_CTR on RDT systems.
- */
-enum resctrl_event_id {
-	QOS_L3_OCCUP_EVENT_ID		= 0x01,
-	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
-	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
-};
-
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @new_ctrl:		new ctrl value to be loaded
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
new file mode 100644
index 000000000000..4788bd95dac6
--- /dev/null
+++ b/include/linux/resctrl_types.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ * Based on arch/x86/kernel/cpu/resctrl/internal.h
+ */
+
+#ifndef __LINUX_RESCTRL_TYPES_H
+#define __LINUX_RESCTRL_TYPES_H
+
+/* Reads to Local DRAM Memory */
+#define READS_TO_LOCAL_MEM		BIT(0)
+
+/* Reads to Remote DRAM Memory */
+#define READS_TO_REMOTE_MEM		BIT(1)
+
+/* Non-Temporal Writes to Local Memory */
+#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
+
+/* Non-Temporal Writes to Remote Memory */
+#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
+
+/* Reads to Local Memory the system identifies as "Slow Memory" */
+#define READS_TO_LOCAL_S_MEM		BIT(4)
+
+/* Reads to Remote Memory the system identifies as "Slow Memory" */
+#define READS_TO_REMOTE_S_MEM		BIT(5)
+
+/* Dirty Victims to All Types of Memory */
+#define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
+
+/* Max event bits supported */
+#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
+
+/**
+ * enum resctrl_conf_type - The type of configuration.
+ * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
+ * @CDP_CODE:	Configuration applies to instruction fetches.
+ * @CDP_DATA:	Configuration applies to reads and writes.
+ */
+enum resctrl_conf_type {
+	CDP_NONE,
+	CDP_CODE,
+	CDP_DATA,
+};
+
+enum resctrl_res_level {
+	RDT_RESOURCE_L3,
+	RDT_RESOURCE_L2,
+	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_SMBA,
+
+	/* Must be the last */
+	RDT_NUM_RESOURCES,
+};
+
+#define CDP_NUM_TYPES	(CDP_DATA + 1)
+
+/*
+ * Event IDs, the values match those used to program IA32_QM_EVTSEL before
+ * reading IA32_QM_CTR on RDT systems.
+ */
+enum resctrl_event_id {
+	QOS_L3_OCCUP_EVENT_ID		= 0x01,
+	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
+	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
+};
+
+#endif /* __LINUX_RESCTRL_TYPES_H */
-- 
2.39.2


