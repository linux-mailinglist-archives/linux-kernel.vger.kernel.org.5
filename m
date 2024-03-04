Return-Path: <linux-kernel+bounces-90495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC7870016
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223DA1F2432E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69E38DDC;
	Mon,  4 Mar 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IhoLhdF0"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F339FC7;
	Mon,  4 Mar 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550937; cv=none; b=lnYSufH3o7FwWrbiDRnkUXPBAE55k8AxGKj1DOkJ6Dl8mywwe+ufWMKXIXsy36kYTBV9Lma27avMPzk9GqS3SgDpS/xk2U5n/LzG1o8inG4CYwOJayl+5Rv3YnCDIlceRAWR0XOFoiVGuA3QwYItnYqeX8PIF6MfiMYEiRtYHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550937; c=relaxed/simple;
	bh=eEb3HhdE3LbmaO448d+jZIgF9jT9Xj+r6l8T4K07FZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJdrzmaEDKXDAf+A3ArnHHLLC9fZ2hSIiXR1D8s9V9NTQjXJQJUGMpFxRG0hXAMBXOD1ad/BBzAWg8VXLl3tT2YNhCxKqWUxGDS220M776gO3GkuCQjMrXHg5uzFs2SADna6B4W5Y1LF42aZVtVUbVo9hj9mRTllMRrSDQvZwyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IhoLhdF0; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709550926; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wEiSSByp1+Om+Lko8VSu8bqHCkg0fMtXM7dtUrDbVns=;
	b=IhoLhdF0WPD0NK1xs0sF7ZO1wnAsnaIVPBWTRgS0FThRSotzqtf0ppd/YAOTdg7YJb8+UPO2idXLlxEMgjvNtOMS3QGIuhMQWyVzD7Zoa4Hl8I7nAenFr+PyK4bWmJjmNLV863JT+TQ1djk3tCaPlY1O+Y1D5iEqMPcXcTqZRrE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W1pO4Ip_1709550923;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W1pO4Ip_1709550923)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 19:15:25 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Tyler Baicar <baicar@os.amperecomputing.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Date: Mon,  4 Mar 2024 19:15:16 +0800
Message-Id: <20240304111517.33001-2-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240304111517.33001-1-tianruidong@linux.alibaba.com>
References: <20240304111517.33001-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tyler Baicar <baicar@os.amperecomputing.com>

Add support for parsing the ARM Error Source Table and basic handling of
errors reported through both memory mapped and system register interfaces.

Assume system register interfaces are only registered with private
peripheral interrupts (PPIs); otherwise there is no guarantee the
core handling the error is the core which took the error and has the
syndrome info in its system registers.

All detected errors will be collected to a workqueue in irq context and
print error information later.

Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 MAINTAINERS                  |  11 +
 arch/arm64/include/asm/ras.h |  38 ++
 drivers/acpi/arm64/Kconfig   |  10 +
 drivers/acpi/arm64/Makefile  |   1 +
 drivers/acpi/arm64/aest.c    | 723 +++++++++++++++++++++++++++++++++++
 include/linux/acpi_aest.h    |  91 +++++
 include/linux/cpuhotplug.h   |   1 +
 7 files changed, 875 insertions(+)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a7a90eeec49..5df845763a9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -329,6 +329,17 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
 
+ACPI AEST
+M:	Tyler Baicar <baicar@os.amperecomputing.com>
+M:	Ruidong Tian <tianruidond@linux.alibaba.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Supported
+F:	arch/arm64/include/asm/ras.h
+F:	drivers/acpi/arm64/aest.c
+F:	include/linux/acpi_aest.h
+
+
 ACPI FOR RISC-V (ACPI/riscv)
 M:	Sunil V L <sunilvl@ventanamicro.com>
 L:	linux-acpi@vger.kernel.org
diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
new file mode 100644
index 000000000000..2fb0d9741567
--- /dev/null
+++ b/arch/arm64/include/asm/ras.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RAS_H
+#define __ASM_RAS_H
+
+#include <linux/types.h>
+#include <linux/bits.h>
+
+#define ERR_STATUS_AV		BIT(31)
+#define ERR_STATUS_V		BIT(30)
+#define ERR_STATUS_UE		BIT(29)
+#define ERR_STATUS_ER		BIT(28)
+#define ERR_STATUS_OF		BIT(27)
+#define ERR_STATUS_MV		BIT(26)
+#define ERR_STATUS_CE		(BIT(25) | BIT(24))
+#define ERR_STATUS_DE		BIT(23)
+#define ERR_STATUS_PN		BIT(22)
+#define ERR_STATUS_UET		(BIT(21) | BIT(20))
+#define ERR_STATUS_CI		BIT(19)
+#define ERR_STATUS_IERR 	GENMASK_ULL(15, 8)
+#define ERR_STATUS_SERR 	GENMASK_ULL(7, 0)
+
+/* These bit is write-one-to-clear */
+#define ERR_STATUS_W1TC 	(ERR_STATUS_AV | ERR_STATUS_V | ERR_STATUS_UE | \
+				ERR_STATUS_ER | ERR_STATUS_OF | ERR_STATUS_MV | \
+				ERR_STATUS_CE | ERR_STATUS_DE | ERR_STATUS_PN | \
+				ERR_STATUS_UET | ERR_STATUS_CI)
+
+#define RAS_REV_v1_1		0x1
+
+struct ras_ext_regs {
+	u64 err_fr;
+	u64 err_ctlr;
+	u64 err_status;
+	u64 err_addr;
+	u64 err_misc[4];
+};
+
+#endif	/* __ASM_RAS_H */
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index b3ed6212244c..639db671c5cf 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -21,3 +21,13 @@ config ACPI_AGDI
 
 config ACPI_APMT
 	bool
+
+config ACPI_AEST
+	bool "ARM Error Source Table Support"
+
+	help
+	  The Arm Error Source Table (AEST) provides details on ACPI
+	  extensions that enable kernel-first handling of errors in a
+	  system that supports the Armv8 RAS extensions.
+
+	  If set, the kernel will report and log hardware errors.
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 726944648c9b..5ea82b196b90 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
 obj-y				+= dma.o init.o
 obj-y				+= thermal_cpufreq.o
+obj-$(CONFIG_ACPI_AEST) 	+= aest.o
diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
new file mode 100644
index 000000000000..be0883316449
--- /dev/null
+++ b/drivers/acpi/arm64/aest.c
@@ -0,0 +1,723 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2021, Ampere Computing LLC
+ * Copyright (c) 2021-2024, Alibaba Group.
+ */
+
+#include <linux/acpi.h>
+#include <linux/acpi_aest.h>
+#include <linux/cpuhotplug.h>
+#include <linux/kernel.h>
+#include <linux/genalloc.h>
+#include <linux/llist.h>
+#include <acpi/actbl.h>
+#include <asm/ras.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "ACPI AEST: " fmt
+
+#define CASE_READ_CLEAR(x, clear)					\
+	case (x): {							\
+		res = read_sysreg_s(SYS_##x##_EL1);			\
+		if (clear)						\
+			write_sysreg_s(0, SYS_##x##_EL1);		\
+		break;							\
+	}
+
+#define CASE_WRITE(val, x)						\
+	case (x): {							\
+		write_sysreg_s((val), SYS_##x##_EL1);			\
+		break;							\
+	}
+
+static struct acpi_table_header *aest_table;
+
+static struct aest_node __percpu **ppi_data;
+
+static int *ppi_irqs;
+static u8 num_ppi;
+static u8 ppi_idx;
+
+static struct work_struct aest_work;
+
+static struct gen_pool *aest_node_pool;
+static struct llist_head aest_node_llist;
+
+/*
+ * This memory pool is only to be used to save AEST node in AEST irq context.
+ * Use 8 pages to save AEST node for now (~500 AEST node at most).
+ */
+#define AEST_NODE_POOLSZ	(8 * PAGE_SIZE)
+
+static u64 aest_sysreg_read_clear(u64 base, u32 offset, bool clear)
+{
+	u64 res;
+
+	switch (offset) {
+	CASE_READ_CLEAR(ERXFR, clear)
+	CASE_READ_CLEAR(ERXCTLR, clear)
+	CASE_READ_CLEAR(ERXSTATUS, clear)
+	CASE_READ_CLEAR(ERXADDR, clear)
+	CASE_READ_CLEAR(ERXMISC0, clear)
+	CASE_READ_CLEAR(ERXMISC1, clear)
+	CASE_READ_CLEAR(ERXMISC2, clear)
+	CASE_READ_CLEAR(ERXMISC3, clear)
+	default :
+		res = 0;
+	}
+	return res;
+}
+
+static void aest_sysreg_write(u64 base, u32 offset, u64 val)
+{
+	switch (offset) {
+	CASE_WRITE(val, ERXFR)
+	CASE_WRITE(val, ERXCTLR)
+	CASE_WRITE(val, ERXSTATUS)
+	CASE_WRITE(val, ERXADDR)
+	CASE_WRITE(val, ERXMISC0)
+	CASE_WRITE(val, ERXMISC1)
+	CASE_WRITE(val, ERXMISC2)
+	CASE_WRITE(val, ERXMISC3)
+	default :
+		return;
+	}
+}
+
+static u64 aest_iomem_read_clear(u64 base, u32 offset, bool clear)
+{
+	u64 res;
+
+	res = readq((void *)(base + offset));
+	if (clear)
+		writeq(0, (void *)(base + offset));
+	return res;
+}
+
+static void aest_iomem_write(u64 base, u32 offset, u64 val)
+{
+	writeq(val, (void *)(base + offset));
+}
+
+static void aest_print(struct aest_node_llist *lnode)
+{
+	static atomic_t seqno;
+	unsigned int curr_seqno;
+	char pfx_seq[64];
+	int index;
+	struct ras_ext_regs *regs;
+
+	curr_seqno = atomic_inc_return(&seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), "{%u}" HW_ERR, curr_seqno);
+	pr_info("%sHardware error from %s\n", pfx_seq, lnode->node_name);
+
+	switch (lnode->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		pr_err("%s Error from CPU%d\n", pfx_seq, lnode->id0);
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+		pr_err("%s Error from memory at SRAT proximity domain 0x%x\n",
+			pfx_seq, lnode->id0);
+		break;
+	case ACPI_AEST_SMMU_ERROR_NODE:
+		pr_err("%s Error from SMMU IORT node 0x%x subcomponent 0x%x\n",
+			pfx_seq, lnode->id0, lnode->id1);
+		break;
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+		pr_err("%s Error from vendor hid 0x%x uid 0x%x\n",
+			pfx_seq, lnode->id0, lnode->id1);
+		break;
+	case ACPI_AEST_GIC_ERROR_NODE:
+		pr_err("%s Error from GIC type 0x%x instance 0x%x\n",
+			pfx_seq, lnode->id0, lnode->id1);
+		break;
+	default:
+		pr_err("%s Unknown AEST node type\n", pfx_seq);
+		return;
+	}
+
+	index = lnode->index;
+	regs = &lnode->regs;
+
+	pr_err("%s  ERR%uFR: 0x%llx\n", pfx_seq, index, regs->err_fr);
+	pr_err("%s  ERR%uCTRL: 0x%llx\n", pfx_seq, index, regs->err_ctlr);
+	pr_err("%s  ERR%uSTATUS: 0x%llx\n", pfx_seq, index, regs->err_status);
+	if (regs->err_status & ERR_STATUS_AV)
+		pr_err("%s  ERR%uADDR: 0x%llx\n", pfx_seq, index, regs->err_addr);
+
+	if (regs->err_status & ERR_STATUS_MV) {
+		pr_err("%s  ERR%uMISC0: 0x%llx\n", pfx_seq, index, regs->err_misc[0]);
+		pr_err("%s  ERR%uMISC1: 0x%llx\n", pfx_seq, index, regs->err_misc[1]);
+		pr_err("%s  ERR%uMISC2: 0x%llx\n", pfx_seq, index, regs->err_misc[2]);
+		pr_err("%s  ERR%uMISC3: 0x%llx\n", pfx_seq, index, regs->err_misc[3]);
+	}
+}
+
+
+static void aest_node_pool_process(struct work_struct *__unused)
+{
+	struct llist_node *head;
+	struct aest_node_llist *lnode, *tmp;
+
+	head = llist_del_all(&aest_node_llist);
+	if (!head)
+		return;
+
+	head = llist_reverse_order(head);
+	llist_for_each_entry_safe(lnode, tmp, head, llnode) {
+		aest_print(lnode);
+		gen_pool_free(aest_node_pool, (unsigned long)lnode,
+				sizeof(*lnode));
+	}
+}
+
+static int aest_node_gen_pool_add(struct aest_node *node, int index,
+				struct ras_ext_regs *regs)
+{
+	struct aest_node_llist *list;
+
+	if (!aest_node_pool)
+		return -EINVAL;
+
+	list = (void *)gen_pool_alloc(aest_node_pool, sizeof(*list));
+	if (!list)
+		return -ENOMEM;
+
+	list->type = node->type;
+	list->node_name = node->name;
+	switch (node->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		list->id0 = node->spec.processor.processor_id;
+		if (node->spec.processor.flags & (ACPI_AEST_PROC_FLAG_SHARED |
+						ACPI_AEST_PROC_FLAG_GLOBAL))
+			list->id0 = smp_processor_id();
+
+		list->id1 = node->spec.processor.resource_type;
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+		list->id0 = node->spec.memory.srat_proximity_domain;
+		break;
+	case ACPI_AEST_SMMU_ERROR_NODE:
+		list->id0 = node->spec.smmu.iort_node_reference;
+		list->id1 = node->spec.smmu.subcomponent_reference;
+		break;
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+		list->id0 = node->spec.vendor.acpi_hid;
+		list->id1 = node->spec.vendor.acpi_uid;
+		break;
+	case ACPI_AEST_GIC_ERROR_NODE:
+		list->id0 = node->spec.gic.interface_type;
+		list->id1 = node->spec.gic.instance_id;
+		break;
+	default:
+		list->id0 = 0;
+		list->id1 = 0;
+	}
+
+	memcpy(&list->regs, regs, sizeof(*regs));
+	list->index = index;
+	llist_add(&list->llnode, &aest_node_llist);
+
+	return 0;
+}
+
+static int aest_node_pool_init(void)
+{
+	unsigned long addr, size;
+	int rc;
+
+	if (aest_node_pool)
+		return 0;
+
+	aest_node_pool = gen_pool_create(ilog2(sizeof(struct aest_node_llist)), -1);
+	if (!aest_node_pool)
+		return -ENOMEM;
+
+	size = PAGE_ALIGN(AEST_NODE_POOLSZ);
+	addr = (unsigned long)vmalloc(size);
+	if (!addr)
+		goto err_pool_alloc;
+
+	rc = gen_pool_add(aest_node_pool, addr, size, -1);
+	if (rc)
+		goto err_pool_add;
+
+	return 0;
+
+err_pool_add:
+	vfree((void *)addr);
+
+err_pool_alloc:
+	gen_pool_destroy(aest_node_pool);
+
+	return -ENOMEM;
+}
+
+static void aest_log(struct aest_node *node, int index, struct ras_ext_regs *regs)
+{
+	if (!aest_node_gen_pool_add(node, index, regs))
+		schedule_work(&aest_work);
+}
+
+/*
+ * you must select cpu number first in order to operate RAS register belonged
+ * that cpu.
+ */
+static void aest_select_cpu(struct aest_node *node, int i)
+{
+	if (node->interface.type == ACPI_AEST_NODE_SYSTEM_REGISTER) {
+		write_sysreg_s(i, SYS_ERRSELR_EL1);
+		isb();
+	}
+}
+
+static void aest_proc(struct aest_node *node)
+{
+	struct ras_ext_regs regs = {0};
+	struct aest_access *access;
+	int i;
+	u64 regs_p;
+
+
+	for (i = node->interface.record_start; i < node->interface.record_end; i++) {
+		/* 1b: Error record at i index is not implemented */
+		if (test_bit(i, &node->interface.record_implemented))
+			continue;
+
+		aest_select_cpu(node, i);
+
+		access = node->access;
+		regs_p = (u64)&node->interface.regs[i];
+
+		regs.err_status = access->read_clear(regs_p, ERXSTATUS, false);
+		if (!(regs.err_status & ERR_STATUS_V))
+			continue;
+
+		if (regs.err_status & ERR_STATUS_AV)
+			regs.err_addr = access->read_clear(regs_p, ERXADDR, false);
+
+		regs.err_fr = access->read_clear(regs_p, ERXFR, false);
+		regs.err_ctlr = access->read_clear(regs_p, ERXCTLR, false);
+
+		if (regs.err_status & ERR_STATUS_MV) {
+			bool clear = node->interface.flags & ACPI_AEST_INTERFACE_CLEAR_MISC;
+
+			regs.err_misc[0] = access->read_clear(regs_p, ERXMISC0, clear);
+			regs.err_misc[1] = access->read_clear(regs_p, ERXMISC1, clear);
+			regs.err_misc[2] = access->read_clear(regs_p, ERXMISC2, clear);
+			regs.err_misc[3] = access->read_clear(regs_p, ERXMISC3, clear);
+		}
+
+		aest_log(node, i, &regs);
+
+		if (regs.err_status & ERR_STATUS_UE)
+			panic("AEST: uncorrectable error encountered");
+
+		/* Write-one-to-clear the bits we've seen */
+		regs.err_status &= ERR_STATUS_W1TC;
+
+		/* Multi bit filed need to write all-ones to clear. */
+		if (regs.err_status & ERR_STATUS_CE)
+			regs.err_status |= ERR_STATUS_CE;
+
+		/* Multi bit filed need to write all-ones to clear. */
+		if (regs.err_status & ERR_STATUS_UET)
+			regs.err_status |= ERR_STATUS_UET;
+
+		access->write(regs_p, ERXSTATUS, regs.err_status);
+	}
+}
+
+static irqreturn_t aest_irq_func(int irq, void *input)
+{
+	struct aest_node *node = input;
+
+	aest_proc(node);
+
+	return IRQ_HANDLED;
+}
+
+static int __init aest_register_gsi(u32 gsi, int trigger, void *data,
+					irq_handler_t aest_irq_func)
+{
+	int cpu, irq;
+
+	irq = acpi_register_gsi(NULL, gsi, trigger, ACPI_ACTIVE_HIGH);
+
+	if (irq == -EINVAL) {
+		pr_err("failed to map AEST GSI %d\n", gsi);
+		return -EINVAL;
+	}
+
+	if (gsi < 16) {
+		pr_err("invalid GSI %d\n", gsi);
+		return -EINVAL;
+	} else if (gsi < 32) {
+		if (ppi_idx >= AEST_MAX_PPI) {
+			pr_err("Unable to register PPI %d\n", gsi);
+			return -EINVAL;
+		}
+		ppi_irqs[ppi_idx] = irq;
+		enable_percpu_irq(irq, IRQ_TYPE_NONE);
+		for_each_possible_cpu(cpu) {
+			memcpy(per_cpu_ptr(ppi_data[ppi_idx], cpu), data,
+			       sizeof(struct aest_node));
+		}
+		if (request_percpu_irq(irq, aest_irq_func, "AEST",
+				       ppi_data[ppi_idx++])) {
+			pr_err("failed to register AEST IRQ %d\n", irq);
+			return -EINVAL;
+		}
+	} else if (gsi < 1020) {
+		if (request_irq(irq, aest_irq_func, IRQF_SHARED, "AEST",
+				data)) {
+			pr_err("failed to register AEST IRQ %d\n", irq);
+			return -EINVAL;
+		}
+	} else {
+		pr_err("invalid GSI %d\n", gsi);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init aest_init_interrupts(struct acpi_aest_hdr *hdr,
+				       struct aest_node *node)
+{
+	struct acpi_aest_node_interrupt *interrupt;
+	int i, trigger, ret = 0;
+
+	interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt, hdr,
+				 hdr->node_interrupt_offset);
+
+	for (i = 0; i < hdr->node_interrupt_count; i++, interrupt++) {
+		trigger = (interrupt->flags & AEST_INTERRUPT_MODE) ?
+			  ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		if (aest_register_gsi(interrupt->gsiv, trigger, node,
+					aest_irq_func))
+			ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void __init set_aest_node_name(struct aest_node *node)
+{
+	switch (node->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		node->name = kasprintf(GFP_KERNEL, "AEST-CPU%d",
+			node->spec.processor.processor_id);
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+	case ACPI_AEST_SMMU_ERROR_NODE:
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+	case ACPI_AEST_GIC_ERROR_NODE:
+		node->name = kasprintf(GFP_KERNEL, "AEST-%llx",
+			node->interface.phy_addr);
+		break;
+	default:
+		node->name = kasprintf(GFP_KERNEL, "AEST-Unkown-Node");
+	}
+}
+
+/* access type is decided by AEST interface type. */
+static struct aest_access aest_access[] = {
+	[ACPI_AEST_NODE_SYSTEM_REGISTER] = {
+		.read_clear = aest_sysreg_read_clear,
+		.write = aest_sysreg_write,
+	},
+
+	[ACPI_AEST_NODE_MEMORY_MAPPED] = {
+		.read_clear = aest_iomem_read_clear,
+		.write = aest_iomem_write,
+	},
+	{ }
+};
+
+static int __init aest_init_interface(struct acpi_aest_hdr *hdr,
+				       struct aest_node *node)
+{
+	struct acpi_aest_node_interface *interface;
+	struct resource *res;
+	int size;
+
+	interface = ACPI_ADD_PTR(struct acpi_aest_node_interface, hdr,
+				 hdr->node_interface_offset);
+
+	if (interface->type >= ACPI_AEST_XFACE_RESERVED) {
+		pr_err("invalid interface type: %d\n", interface->type);
+		return -EINVAL;
+	}
+
+	node->interface.type = interface->type;
+	node->interface.phy_addr = interface->address;
+	node->interface.record_start = interface->error_record_index;
+	node->interface.record_end = interface->error_record_index +
+					interface->error_record_count;
+	node->interface.flags = interface->flags;
+	node->interface.record_implemented = interface->error_record_implemented;
+	node->interface.status_reporting = interface->error_status_reporting;
+	node->access = &aest_access[interface->type];
+
+	/*
+	 * Currently SR based handling is done through the architected
+	 * discovery exposed through SRs. That may change in the future
+	 * if there is supplemental information in the AEST that is
+	 * needed.
+	 */
+	if (interface->type == ACPI_AEST_NODE_SYSTEM_REGISTER)
+		return 0;
+
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	size = interface->error_record_count * sizeof(struct ras_ext_regs);
+	res->name = "AEST";
+	res->start = interface->address;
+	res->end = res->start + size;
+	res->flags = IORESOURCE_MEM;
+
+	if (insert_resource(&iomem_resource, res)) {
+		pr_notice("request region conflict with %s\n",
+			res->name);
+	}
+
+	node->interface.regs = ioremap(res->start, size);
+	if (!node->interface.regs) {
+		pr_err("Ioremap for %s failed!\n", node->name);
+		kfree(res);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init aest_init_common(struct acpi_aest_hdr *hdr,
+						struct aest_node *node)
+{
+	int ret;
+
+	set_aest_node_name(node);
+
+	ret = aest_init_interface(hdr, node);
+	if (ret) {
+		pr_err("failed to init interface\n");
+		return ret;
+	}
+
+	return aest_init_interrupts(hdr, node);
+}
+
+static int __init aest_init_node_default(struct acpi_aest_hdr *hdr)
+{
+	struct aest_node *node;
+	union aest_node_spec *node_spec;
+	int ret;
+
+	node = kzalloc(sizeof(struct aest_node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->type = hdr->type;
+	node_spec = ACPI_ADD_PTR(union aest_node_spec, hdr,
+					hdr->node_specific_offset);
+
+	memcpy(&node->spec, node_spec,
+			hdr->node_interface_offset - hdr->node_specific_offset);
+
+	ret = aest_init_common(hdr, node);
+	if (ret)
+		kfree(node);
+
+	return ret;
+}
+
+static int __init aest_init_processor_node(struct acpi_aest_hdr *hdr)
+{
+	struct aest_node *node;
+	union aest_node_spec *node_spec;
+	union aest_node_processor *proc;
+	int ret;
+
+	node = kzalloc(sizeof(struct aest_node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->type = hdr->type;
+	node_spec = ACPI_ADD_PTR(union aest_node_spec, hdr,
+					hdr->node_specific_offset);
+
+	memcpy(&node->spec, node_spec,
+			hdr->node_interface_offset - hdr->node_specific_offset);
+
+	proc = ACPI_ADD_PTR(union aest_node_processor, node_spec,
+					sizeof(acpi_aest_processor));
+
+	switch (node->spec.processor.resource_type) {
+	case ACPI_AEST_CACHE_RESOURCE:
+		memcpy(&node->proc, proc,
+				sizeof(struct acpi_aest_processor_cache));
+		break;
+	case ACPI_AEST_TLB_RESOURCE:
+		memcpy(&node->proc, proc,
+				sizeof(struct acpi_aest_processor_tlb));
+		break;
+	case ACPI_AEST_GENERIC_RESOURCE:
+		memcpy(&node->proc, proc,
+				sizeof(struct acpi_aest_processor_generic));
+		break;
+	}
+
+	ret = aest_init_common(hdr, node);
+	if (ret)
+		kfree(node);
+
+	return ret;
+}
+
+static int __init aest_init_node(struct acpi_aest_hdr *node)
+{
+	switch (node->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		return aest_init_processor_node(node);
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+	case ACPI_AEST_SMMU_ERROR_NODE:
+	case ACPI_AEST_GIC_ERROR_NODE:
+		return aest_init_node_default(node);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void __init aest_count_ppi(struct acpi_aest_hdr *header)
+{
+	struct acpi_aest_node_interrupt *interrupt;
+	int i;
+
+	interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt, header,
+				 header->node_interrupt_offset);
+
+	for (i = 0; i < header->node_interrupt_count; i++, interrupt++) {
+		if (interrupt->gsiv >= 16 && interrupt->gsiv < 32)
+			num_ppi++;
+	}
+}
+
+static int aest_starting_cpu(unsigned int cpu)
+{
+	int i;
+
+	for (i = 0; i < num_ppi; i++)
+		enable_percpu_irq(ppi_irqs[i], IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int aest_dying_cpu(unsigned int cpu)
+{
+	int i;
+
+	for (i = 0; i < num_ppi; i++)
+		disable_percpu_irq(ppi_irqs[i]);
+
+	return 0;
+}
+
+int __init acpi_aest_init(void)
+{
+	struct acpi_aest_hdr *aest_node, *aest_end;
+	struct acpi_table_aest *aest;
+	int i, ret = 0;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (!IS_ENABLED(CONFIG_ARM64_RAS_EXTN))
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_AEST, 0, &aest_table)))
+		return -EINVAL;
+
+	ret = aest_node_pool_init();
+	if (ret) {
+		pr_err("Failed init aest node pool.\n");
+		goto fail;
+	}
+
+	INIT_WORK(&aest_work, aest_node_pool_process);
+
+	aest = (struct acpi_table_aest *)aest_table;
+
+	/* Get the first AEST node */
+	aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				 sizeof(struct acpi_table_header));
+	/* Pointer to the end of the AEST table */
+	aest_end = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				aest_table->length);
+
+	while (aest_node < aest_end) {
+		if (((u64)aest_node + aest_node->length) > (u64)aest_end) {
+			pr_err("AEST node pointer overflow, bad table.\n");
+			return -EINVAL;
+		}
+
+		aest_count_ppi(aest_node);
+
+		aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
+					 aest_node->length);
+	}
+
+	ppi_data = kcalloc(num_ppi, sizeof(struct aest_node_data *),
+				GFP_KERNEL);
+	if (!ppi_data) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	ppi_irqs = kcalloc(num_ppi, sizeof(int), GFP_KERNEL);
+	if (!ppi_irqs) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	for (i = 0; i < num_ppi; i++) {
+		ppi_data[i] = alloc_percpu(struct aest_node);
+		if (!ppi_data[i]) {
+			pr_err("Failed percpu allocation.\n");
+			ret = -ENOMEM;
+			goto fail;
+		}
+	}
+
+	aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				 sizeof(struct acpi_table_header));
+
+	while (aest_node < aest_end) {
+		ret = aest_init_node(aest_node);
+		if (ret) {
+			pr_err("failed to init node: %d", ret);
+			goto fail;
+		}
+
+		aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
+					 aest_node->length);
+	}
+
+
+
+	return cpuhp_setup_state(CPUHP_AP_ARM_AEST_STARTING,
+			  "drivers/acpi/arm64/aest:starting",
+			  aest_starting_cpu, aest_dying_cpu);
+
+fail:
+	for (i = 0; i < num_ppi; i++)
+		free_percpu(ppi_data[i]);
+	kfree(ppi_data);
+	return ret;
+}
+subsys_initcall(acpi_aest_init);
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
new file mode 100644
index 000000000000..10c2564c32f9
--- /dev/null
+++ b/include/linux/acpi_aest.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef AEST_H
+#define AEST_H
+
+#include <acpi/actbl.h>
+#include <asm/ras.h>
+
+#define AEST_INTERRUPT_MODE		BIT(0)
+
+#define ACPI_AEST_PROC_FLAG_GLOBAL	(1<<0)
+#define ACPI_AEST_PROC_FLAG_SHARED	(1<<1)
+
+#define ACPI_AEST_INTERFACE_CLEAR_MISC	(1<<0)
+
+#define AEST_MAX_PPI			4
+
+#define ERXFR			0x0
+#define ERXCTLR			0x8
+#define ERXSTATUS		0x10
+#define ERXADDR			0x18
+#define ERXMISC0		0x20
+#define ERXMISC1		0x28
+#define ERXMISC2		0x30
+#define ERXMISC3		0x38
+
+struct aest_node_interface {
+	u8 type;
+	u64 phy_addr;
+	u16 record_start;
+	u16 record_end;
+	u32 flags;
+	unsigned long record_implemented;
+	unsigned long status_reporting;
+	struct ras_ext_regs *regs;
+};
+
+union aest_node_processor {
+	struct acpi_aest_processor_cache cache_data;
+	struct acpi_aest_processor_tlb tlb_data;
+	struct acpi_aest_processor_generic generic_data;
+};
+
+union aest_node_spec {
+	struct acpi_aest_processor processor;
+	struct acpi_aest_memory memory;
+	struct acpi_aest_smmu smmu;
+	struct acpi_aest_vendor vendor;
+	struct acpi_aest_gic gic;
+};
+
+struct aest_access {
+	u64 (*read_clear)(u64 base, u32 offset, bool clear);
+	void (*write)(u64 base, u32 offset, u64 val);
+};
+
+struct aest_node {
+	char *name;
+	u8 type;
+	struct aest_node_interface interface;
+	union aest_node_spec spec;
+	union aest_node_processor proc;
+	struct aest_access *access;
+};
+
+struct aest_node_llist {
+	struct llist_node llnode;
+	char *node_name;
+	int type;
+	/*
+	 * Different nodes have different meanings:
+	 *   - Processor node	: processor number.
+	 *   - Memory node	: SRAT proximity domain.
+	 *   - SMMU node	: IORT proximity domain.
+	 *   - Vendor node	: hardware ID.
+	 *   - GIC node		: interface type.
+	 */
+	u32 id0;
+	/*
+	 * Different nodes have different meanings:
+	 *   - Processor node	: processor resource type.
+	 *   - Memory node	: Non.
+	 *   - SMMU node	: subcomponent reference.
+	 *   - Vendor node	: Unique ID.
+	 *   - GIC node		: instance identifier.
+	 */
+	u32 id1;
+	int index;
+	struct ras_ext_regs regs;
+};
+
+#endif /* AEST_H */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 35e78ddb2b37..c2784706ffe2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -175,6 +175,7 @@ enum cpuhp_state {
 	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_TI_GP_TIMER_STARTING,
 	CPUHP_AP_HYPERV_TIMER_STARTING,
+	CPUHP_AP_ARM_AEST_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
-- 
2.33.1


