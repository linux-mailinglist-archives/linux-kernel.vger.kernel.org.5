Return-Path: <linux-kernel+bounces-160224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE58B3AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BD9287C43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F8155A56;
	Fri, 26 Apr 2024 15:09:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CDC155723
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144178; cv=none; b=p7ZS92BTljVLJxYUdS0Kff1c09kuLHt23HqHCO7Zm3GMq/00PPffqtDjc1Mj0PaQ+BOpb3LB3r+ImVTKQqZ+hlzj4P0MoOTayfaGLwfUunb10Ik/QQ4zpGcNgxnP4eK1UjDVEsJ62umwgxqavetOJu+04hDyBkO7lFG/tvHUeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144178; c=relaxed/simple;
	bh=FpxkIPP9DuGI2+rCk9WCX7J/wgWIVZBykrAyft6wNlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEUzEX+pMG4cNeqj8gbISGUqEa+95MqGnWVqTxUC67RbwP5QHZ/F/YMqzAM3OPVZNsrAwvWrAXX2rym/JLwfhmUr8281+61EbxY9gnSbkt+Sz0DLfImMrLjG/mCDGA52Ka3C/6O0pOkYUoyqY62W8QFiHEKLmr7jcI3dysIcO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1B181691;
	Fri, 26 Apr 2024 08:10:04 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE2553F73F;
	Fri, 26 Apr 2024 08:09:33 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2 08/35] x86/resctrl: Move resctrl types to a separate header
Date: Fri, 26 Apr 2024 16:08:37 +0100
Message-Id: <20240426150904.8854-8-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426150904.8854-1-Dave.Martin@arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

When resctrl is fully factored into core and per-arch code, each arch
will need to use some resctrl common definitions in order to define its
own specializations and helpers.  Following conventional practice, it
would be desirable to put the dependent arch definitions in an
<asm/resctrl.h> header that is included by the common <linux/resctrl.h>
header.  However, this can make it awkward to avoid a circular
dependency between <linux/resctrl.h> and the arch header.

To avoid such dependencies, move the affected common types and
constants into a new header that does not need to depend on
<linux/resctrl.h> or on the arch headers.

The same logic applies to the monitor-configuration defines, move these
too.

The maintainers entry for these headers was missed when resctrl.h was
created. Add a wildcard entry to match both resctrl.h and
resctrl_types.h.

Signed-off-by: James Morse <james.morse@arm.com>

---

FYI: James Morse (et al.)

 * This patch needs review to see how many of the x86-specific
   definitions really ought to be exported...

 * The header should have a comment explaining its content and purpose
   (once we have that nailed down).

Changes in v2:

 * [Commit message only] Rewrite commit message to clarify the the
   rationale for refactoring the headers in this way.
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
index 1495e03d1f1b..78eea7caf839 100644
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
2.34.1


