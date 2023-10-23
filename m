Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155807D2E10
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjJWJVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjJWJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:21:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B005710CB;
        Mon, 23 Oct 2023 02:21:33 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N8o5x7017071;
        Mon, 23 Oct 2023 09:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0gLwEl23HvZfBvx7S37MAPxh7yz477e3uwcHY/paGyQ=;
 b=CvbIJK4EPKyaA/c/aCt8p8Do+fmkrYYV1Hhm7yE6KxNHKaBGWrb6Ci6WztNRw+sEanSf
 j0Wj9GveMFrNEWzpuD4VuvnWm3W0de2PtcaJ7wF89Rt/XPVFSBau0ghElGLW1U4L48Et
 nujxOLAhwC+W5Ckw8FGkoD3JeXB0EZQPRN8Hqj0r7lffgLPN5fr8IN9Mmb9LmDKjpYE6
 xJVNYOfpttI17lRb9xbfX0o2PrQwbbr8HIznpMM/uSOLJKIBfmJFA856BrQgMyk2hHj5
 KKqAaU1+F0iuRXzDB4iIA1Xw7WP0BHBdbGRvgNe+4HKLiFjBFu+9gOD8K/O67M5CIAZ/ FQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv5ky46nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:21:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N9LTlG002289
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:21:29 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 02:21:23 -0700
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH v1 3/5] soc: qcom: memory_dump: Add memory dump driver
Date:   Mon, 23 Oct 2023 17:20:55 +0800
Message-ID: <1698052857-6918-4-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: At3ZkJLxqJlQI09YD70zdKAFGlhQmMSi
X-Proofpoint-GUID: At3ZkJLxqJlQI09YD70zdKAFGlhQmMSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm memory dump driver initializes system memory dump table.
Firmware dumps system cache, internal memory, peripheral registers
to DDR as per this table after system crashes and warm resets. The
driver reserves memory, populates ids and sizes for firmware dumping
according to the configuration.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 MAINTAINERS                    |   7 +
 drivers/soc/qcom/Kconfig       |  11 +
 drivers/soc/qcom/Makefile      |   1 +
 drivers/soc/qcom/memory_dump.c | 540 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 559 insertions(+)
 create mode 100644 drivers/soc/qcom/memory_dump.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f1328..096e0f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17792,6 +17792,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
 F:	drivers/regulator/vqmmc-ipq4019-regulator.c
 
+QUALCOMM MEMORY DUMP DRIVER
+M:	Zhenhua Huang <quic_zhenhuah@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,memory_dump.yaml
+F:	drivers/soc/qcom/memory_dump.c
+
 QUALCOMM NAND CONTROLLER DRIVER
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-mtd@lists.infradead.org
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 7153488..1842f4e 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -74,6 +74,17 @@ config QCOM_KRYO_L2_ACCESSORS
 	bool
 	depends on (ARCH_QCOM || COMPILE_TEST) && ARM64
 
+config QCOM_MEMORY_DUMP
+       bool "QCOM Memory Dump Support"
+       depends on ARCH_QCOM || COMPILE_TEST
+       select BOOT_CONFIG
+       help
+         Qualcomm memory dump driver initializes system memory dump table.
+         Firmware dumps system cache, internal memory, peripheral registers to
+         DDR as per this table after system crash and warm reset.
+         The driver allocates reserved memory and populates ids, sizes for
+         firmware to dump according to configuration.
+
 config QCOM_MDT_LOADER
 	tristate
 	select QCOM_SCM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index bbca2e1..988880c 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_QCOM_STATS)	+= qcom_stats.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
 obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
+obj-$(CONFIG_QCOM_MEMORY_DUMP) += memory_dump.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
diff --git a/drivers/soc/qcom/memory_dump.c b/drivers/soc/qcom/memory_dump.c
new file mode 100644
index 0000000..57cd897
--- /dev/null
+++ b/drivers/soc/qcom/memory_dump.c
@@ -0,0 +1,540 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * Qualcomm memory dump driver dynamically reserves memory and provides
+ * hints(id and size) of debugging information based on specified
+ * protocols with firmware into pre-allocated memory. Firmware then does the
+ * real data capture. The debugging information includes cache contents,
+ * internal memory, registers.
+ * After crash and warm reboot, firmware scans ids, sizes and stores contents
+ * into reserved memory accordingly. Firmware then enters into full dump mode
+ * which dumps whole DDR to host through USB.
+ *
+ */
+#include <asm/barrier.h>
+#include <linux/bootconfig.h>
+#include <linux/cma.h>
+#include <linux/device.h>
+#include <linux/dma-map-ops.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#define MAX_NUM_ENTRIES		0x150
+#define QCOM_DUMP_MAKE_VERSION(major, minor)	(((major) << 20) | (minor))
+#define QCOM_DUMP_TABLE_VERSION		QCOM_DUMP_MAKE_VERSION(2, 0)
+#define QCOM_DUMP_DATA_SIZE sizeof(struct qcom_dump_data)
+
+enum qcom_dump_table_ids {
+	QCOM_DUMP_TABLE_LINUX,
+	QCOM_DUMP_TABLE_MAX = MAX_NUM_ENTRIES,
+};
+
+enum qcom_dump_type {
+	QCOM_DUMP_TYPE_DATA,
+	QCOM_DUMP_TYPE_TABLE,
+};
+
+/*
+ * +----------+         1st level
+ * |IMEM      |------+-----------------+
+ * +----------+      | qcom_dump_table |
+ *                   |---------------- |
+ *                   | version         |
+ *                   | num_entryies    |
+ *                   | ..              |
+ *                   |---------------- |
+ *             +-----|qcom_dump_entry  |
+ *             |     |qcom_dump_entry  |
+ *             |     |  ...            |
+ *             |     +-----------------+
+ *             |
+ *             |
+ *             |        2nd level
+ *             |     +-----------------+
+ *             ------| qcom_dump_table |
+ *                   |---------------- |
+ *                   | version         |
+ *                   | num_entryies    |
+ *                   | ..              |
+ *                   |---------------- |     +-------------+     +----------+
+ *                   |qcom_dump_entry  |-----|qcom_dump_data|----| data     |
+ *                   |qcom_dump_entry  |     +-------------+     +----------+
+ *                   |  ...            |---- +-------------+     +----------+
+ *                   +-----------------+     |qcom_dump_data|----| data     |
+ *                                           +-------------+     +----------+
+ *
+ * Structures can not be packed due to protocols with firmware.
+ */
+struct qcom_dump_data {
+	__le32 version;
+	__le32 magic;
+	char name[32];
+	__le64 addr;
+	__le64 len;
+	__le32 reserved;
+};
+
+struct qcom_dump_entry {
+	__le32 id;
+	char name[32];
+	__le32 type;
+	__le64 addr;
+};
+
+struct qcom_dump_table {
+	__le32 version;
+	__le32 num_entries;
+	struct qcom_dump_entry entries[MAX_NUM_ENTRIES];
+};
+
+struct qcom_memory_dump {
+	u64 table_phys;
+	struct qcom_dump_table *table;
+	struct xbc_node *mem_dump_node;
+	/* Cached 2nd level table */
+	struct qcom_dump_table *cached_2nd_table;
+};
+
+static void __init mem_dump_entry_set(struct device *dev,
+				      struct qcom_dump_entry *entry,
+				      u32 id,
+				      u32 type, uint64_t addr)
+{
+	entry->id = id;
+	entry->type = type;
+	entry->addr = addr;
+}
+
+/* 1st level table register */
+static int __init mem_dump_table_register(struct device *dev,
+					  struct qcom_dump_entry *entry)
+{
+	struct qcom_memory_dump *memdump = dev_get_drvdata(dev);
+	struct qcom_dump_entry *last_entry;
+	struct qcom_dump_table *table = memdump->table;
+
+	if (!table || table->num_entries >= MAX_NUM_ENTRIES)
+		return -EINVAL;
+
+	last_entry = &table->entries[table->num_entries];
+	mem_dump_entry_set(dev, last_entry, entry->id,
+			   QCOM_DUMP_TYPE_TABLE, entry->addr);
+	table->num_entries++;
+
+	return 0;
+}
+
+/* Get 2nd level table */
+static struct qcom_dump_table * __init
+mem_dump_get_table(struct device *dev,
+		   enum qcom_dump_table_ids id)
+{
+	struct qcom_memory_dump *memdump = dev_get_drvdata(dev);
+	struct qcom_dump_table *table = memdump->table;
+	unsigned long offset;
+	int i;
+
+	if (memdump->cached_2nd_table)
+		return memdump->cached_2nd_table;
+
+	if (!table) {
+		dev_err(dev, "Mem dump base table does not exist\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	for (i = 0; i < MAX_NUM_ENTRIES; i++) {
+		if (table->entries[i].id == id)
+			break;
+	}
+
+	if (i == MAX_NUM_ENTRIES || !table->entries[i].addr) {
+		dev_err(dev, "Mem dump base table entry %d invalid\n", id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	offset = table->entries[i].addr - memdump->table_phys;
+
+	/* Get the table pointer. Phy and virt addr has same offset */
+	table = (void *)memdump->table + offset;
+	/* Cache it for next time visit */
+	memdump->cached_2nd_table = table;
+
+	return table;
+}
+
+/* register in 2nd level table */
+static int __init mem_dump_data_register(struct device *dev,
+					 enum qcom_dump_table_ids id,
+					 struct qcom_dump_entry *entry)
+{
+	struct qcom_dump_entry *last_entry;
+	struct qcom_dump_table *table;
+
+	/* Get 2nd level table */
+	table = mem_dump_get_table(dev, id);
+	if (IS_ERR(table))
+		return PTR_ERR(table);
+
+	if (!table || table->num_entries >= MAX_NUM_ENTRIES)
+		return -EINVAL;
+
+	last_entry = &table->entries[table->num_entries];
+	mem_dump_entry_set(dev, last_entry, entry->id, QCOM_DUMP_TYPE_DATA,
+			   entry->addr);
+	table->num_entries++;
+
+	return 0;
+}
+
+static int __init qcom_init_memdump_imem_area(struct device *dev, size_t size)
+{
+	struct qcom_memory_dump *memdump = dev_get_drvdata(dev);
+	void __iomem *table_offset;
+	void __iomem *table_base;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL,
+				     "qcom,qcom-imem-mem-dump-table");
+	if (!np) {
+		dev_err_probe(dev, -ENODEV,
+			      "Mem dump base table DT node does not exist\n");
+		return -ENODEV;
+	}
+
+	table_base = devm_of_iomap(dev, np, 0, NULL);
+	if (!table_base) {
+		dev_err_probe(dev, -ENOMEM,
+			      "Mem dump base table imem offset mapping failed\n");
+		return -ENOMEM;
+	}
+
+	np = of_find_compatible_node(NULL, NULL,
+				     "qcom,qcom-imem-mem-dump-table-size");
+	if (!np) {
+		dev_err_probe(dev, -ENODEV,
+			      "Mem dump base table size DT node does not exist\n");
+		devm_iounmap(dev, table_base);
+		return -ENODEV;
+	}
+
+	table_offset = devm_of_iomap(dev, np, 0, NULL);
+	if (!table_offset) {
+		dev_err_probe(dev, -ENOMEM,
+			      "Mem dump base table size imem offset mapping failed\n");
+		devm_iounmap(dev, table_base);
+		return -ENOMEM;
+	}
+
+	memcpy_toio(table_base, &memdump->table_phys,
+		    sizeof(memdump->table_phys));
+	memcpy_toio(table_offset,
+		    &size, sizeof(size_t));
+
+	/* Ensure write to table_base is complete before unmapping */
+	mb();
+	dev_dbg(dev, "QCOM Memory Dump base table set up in IMEM\n");
+
+	devm_iounmap(dev, table_base);
+	devm_iounmap(dev, table_offset);
+	return 0;
+}
+
+/* Helper function for applying both vaddr and phys addr */
+static void __init mem_dump_apply_offset(void **dump_vaddr,
+					 phys_addr_t *phys_addr, size_t offset)
+{
+	*dump_vaddr += offset;
+	*phys_addr += offset;
+}
+
+/* Populate 1st level: QCOM_DUMP_TABLE_LINUX */
+static int __init mem_dump_register_data_table(struct device *dev,
+					       void *dump_vaddr,
+					       phys_addr_t phys_addr)
+{
+	struct qcom_memory_dump *memdump = dev_get_drvdata(dev);
+	struct qcom_dump_table *table;
+	struct qcom_dump_entry entry;
+	int ret;
+
+	memdump->table = dump_vaddr;
+	memdump->table->version = QCOM_DUMP_TABLE_VERSION;
+	memdump->table_phys = phys_addr;
+	mem_dump_apply_offset(&dump_vaddr, &phys_addr, sizeof(*table));
+
+	table = dump_vaddr;
+	table->version = QCOM_DUMP_TABLE_VERSION;
+	entry.id = QCOM_DUMP_TABLE_LINUX;
+	entry.addr = phys_addr;
+	ret = mem_dump_table_register(dev, &entry);
+	if (ret) {
+		dev_err(dev, "Mem dump apps data table register failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init mem_dump_reserve_mem(struct device *dev)
+{
+	int ret;
+
+	if (of_property_present(dev->of_node, "memory-region")) {
+		ret = of_reserved_mem_device_init_by_idx(dev,
+							 dev->of_node, 0);
+		if (ret)
+			dev_err_probe(dev, ret,
+				      "Failed to initialize reserved mem\n");
+		return ret;
+	}
+
+	/* Using default CMA region is fallback choice */
+	dev_dbg(dev, "Using default CMA region\n");
+	return 0;
+}
+
+static struct page * __init
+mem_dump_alloc_mem(struct device *dev, size_t *total_size)
+{
+	struct qcom_memory_dump *memdump = dev_get_drvdata(dev);
+	struct xbc_node *linked_list;
+	int num_of_nodes = 0;
+	struct page *page;
+	const char *size_p;
+	const char *id_p;
+	int ret = 0;
+	int size;
+	int id;
+
+	memdump->mem_dump_node = xbc_find_node("memory_dump_config");
+	if (!memdump->mem_dump_node) {
+		dev_err(dev, "xbc config not found\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	*total_size = sizeof(struct qcom_dump_table) * 2;
+
+	xbc_node_for_each_subkey(memdump->mem_dump_node, linked_list) {
+		const char *name = xbc_node_get_data(linked_list);
+
+		if (!name)
+			continue;
+
+		id_p = xbc_node_find_value(linked_list, "id", NULL);
+		size_p = xbc_node_find_value(linked_list, "size", NULL);
+
+		if (id_p && size_p) {
+			ret = kstrtoint(id_p, 0, &id);
+			if (ret)
+				continue;
+
+			ret = kstrtoint(size_p, 0, &size);
+			if (ret)
+				continue;
+
+			if (check_add_overflow(*total_size, size, total_size))
+				return ERR_PTR(-EOVERFLOW);
+
+			num_of_nodes++;
+		} else {
+			continue;
+		}
+	}
+
+	if (!num_of_nodes)
+		return ERR_PTR(-EINVAL);
+
+	if (check_add_overflow(*total_size,
+			       (QCOM_DUMP_DATA_SIZE * num_of_nodes),
+			       total_size))
+		return ERR_PTR(-EOVERFLOW);
+
+	/* Align total_size */
+	if (*total_size > ALIGN(*total_size, PAGE_SIZE))
+		return ERR_PTR(-EOVERFLOW);
+	*total_size = ALIGN(*total_size, PAGE_SIZE);
+
+	/*
+	 * Physical continuous buffer.
+	 */
+	page = cma_alloc(dev_get_cma_area(dev), (*total_size / PAGE_SIZE),
+			 0, false);
+	if (page)
+		memset(page_address(page), 0, *total_size);
+	else
+		return ERR_PTR(-ENOMEM);
+
+	return page;
+}
+
+/* populate allocated region */
+static int __init mem_dump_populate_mem(struct device *dev,
+					struct page *start_page,
+					size_t total_size)
+{
+	struct qcom_memory_dump *memdump = dev_get_drvdata(dev);
+	struct qcom_dump_entry dump_entry;
+	struct qcom_dump_data *dump_data;
+	struct xbc_node *linked_list;
+	phys_addr_t phys_end_addr;
+	phys_addr_t phys_addr;
+	const char *size_p;
+	void *dump_vaddr;
+	const char *id_p;
+	int ret = 0;
+	int size;
+	int id;
+
+	phys_addr = page_to_phys(start_page);
+	phys_end_addr = phys_addr + total_size;
+	dump_vaddr = page_to_virt(start_page);
+
+	ret = mem_dump_register_data_table(dev, dump_vaddr, phys_addr);
+	if (ret) {
+		dev_err_probe(dev, ret, "Mem Dump table set up is failed\n");
+		return ret;
+	}
+
+	ret = qcom_init_memdump_imem_area(dev, total_size);
+	if (ret)
+		return ret;
+
+	/* Apply two tables: QCOM_DUMP_TYPE_TABLE and QCOM_DUMP_TYPE_DATA */
+	mem_dump_apply_offset(&dump_vaddr, &phys_addr,
+			      sizeof(struct qcom_dump_table) * 2);
+
+	/* Both "id" and "size" must be present */
+	xbc_node_for_each_subkey(memdump->mem_dump_node, linked_list) {
+		const char *name = xbc_node_get_data(linked_list);
+
+		if (!name)
+			continue;
+
+		id_p = xbc_node_find_value(linked_list, "id", NULL);
+		size_p = xbc_node_find_value(linked_list, "size", NULL);
+
+		if (id_p && size_p) {
+			ret = kstrtoint(id_p, 0, &id);
+			if (ret)
+				continue;
+
+			ret = kstrtoint(size_p, 0, &size);
+
+			if (ret)
+				continue;
+
+		/*
+		 * Physical layout: starting from two qcom_dump_data.
+		 * Following are respective dump meta data and reserved regions.
+		 * Qcom_dump_data is populated by the driver, fw parse it
+		 * and dump respective info into dump mem.
+		 * Illustrate the layout:
+		 *
+		 *   +------------------------+------------------------+
+		 *   | qcom_dump_table(TABLE) | qcom_dump_table(DATA)  |
+		 *   +------------------------+------------------------+
+		 *   +-------------+----------+-------------+----------+
+		 *   |qcom_dump_data| dump mem|qcom_dump_data| dump mem |
+		 *   +-------------+----------+-------------+----------+
+		 *   +-------------+----------+-------------+----------+
+		 *   |qcom_dump_data| dump mem|qcom_dump_data| dump mem |
+		 *   +-------------+----------+-------------+----------+
+		 *   ...
+		 */
+			dump_data = dump_vaddr;
+			dump_data->addr = phys_addr + QCOM_DUMP_DATA_SIZE;
+			dump_data->len = size;
+			dump_entry.id = id;
+			strscpy(dump_data->name, name,
+				sizeof(dump_data->name));
+			dump_entry.addr = phys_addr;
+			ret = mem_dump_data_register(dev, QCOM_DUMP_TABLE_LINUX,
+						     &dump_entry);
+			if (ret) {
+				dev_err_probe(dev, ret, "Dump data setup failed, id = %d\n",
+					      id);
+				return ret;
+			}
+
+			mem_dump_apply_offset(&dump_vaddr, &phys_addr,
+					      size + QCOM_DUMP_DATA_SIZE);
+			if (phys_addr > phys_end_addr) {
+				dev_err_probe(dev, -ENOMEM, "Exceeding allocated region\n");
+				return -ENOMEM;
+			}
+		} else {
+			continue;
+		}
+	}
+
+	return ret;
+}
+
+static int __init mem_dump_probe(struct platform_device *pdev)
+{
+	struct qcom_memory_dump *memdump;
+	struct device *dev = &pdev->dev;
+	struct page *page;
+	size_t total_size;
+	int ret = 0;
+
+	memdump = devm_kzalloc(dev, sizeof(struct qcom_memory_dump),
+			       GFP_KERNEL);
+	if (!memdump)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, memdump);
+
+	/* check and initiate CMA region */
+	ret = mem_dump_reserve_mem(dev);
+	if (ret)
+		return ret;
+
+	/* allocate and populate */
+	page = mem_dump_alloc_mem(dev, &total_size);
+	if (IS_ERR(page)) {
+		ret = PTR_ERR(page);
+		dev_err_probe(dev, ret, "mem dump alloc failed\n");
+		goto release;
+	}
+
+	ret = mem_dump_populate_mem(dev, page, total_size);
+	if (!ret)
+		dev_info(dev, "Mem dump region populated successfully\n");
+	else
+		goto free;
+
+	return 0;
+
+free:
+	cma_release(dev_get_cma_area(dev), page, (total_size / PAGE_SIZE));
+
+release:
+	of_reserved_mem_device_release(dev);
+	return ret;
+}
+
+static const struct of_device_id mem_dump_match_table[] = {
+	{.compatible = "qcom,mem-dump",},
+	{}
+};
+
+static struct platform_driver mem_dump_driver = {
+	.driver = {
+		.name = "qcom_mem_dump",
+		.of_match_table = mem_dump_match_table,
+	},
+};
+module_platform_driver_probe(mem_dump_driver, mem_dump_probe);
+
+MODULE_DESCRIPTION("Memory Dump Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

