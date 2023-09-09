Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA7C799AF6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbjIIUUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343656AbjIIUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:20:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E88B19F;
        Sat,  9 Sep 2023 13:19:24 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389KHej3008460;
        Sat, 9 Sep 2023 20:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=WuCSDHYrZ1YseK7ZDDbbfHj7W3GG/Tc24tr4X4La/eg=;
 b=XYEfAASOcCr1kWydjI90V/+9fwZD77Rw++2SXDJ7nOJJ6PcAxpYoiMgMN8ZFlKM/FQZD
 BTYkWixC2t8eXOU+1EtjGTLuXPqOY2dkYSDwcbzlg9S9yKcUFVfw5Q/Zl8kPtTi2jb60
 H2lkNfIux7p8faUyq8qKfch/sPHHZi9FsmRWnIbxCqwXUv7dQXuRa9a1pkJtQ3a0QEXt
 0HNvnUSUMUaLFRMrUKTJ0OtFeYE/xidCiTCQMwzKI6GSVcpPyDF9G9qH9HHIlIveBwX8
 m07GPzFskn0z5wrVthOs2t/8K2F3vhylYpgIMRujoAuLrndEGKzpah0qOYkrgOePWXhd iQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0gt18xck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Sep 2023 20:17:40 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 389KHcDB014900
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Sep 2023 20:17:38 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 9 Sep 2023 13:17:28 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v5 06/17] soc: qcom: Add Qualcomm APSS minidump kernel driver
Date:   Sun, 10 Sep 2023 01:46:07 +0530
Message-ID: <1694290578-17733-7-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P2i_KqOYbsMchaxoqkrJe1B2o2ONrIa6
X-Proofpoint-GUID: P2i_KqOYbsMchaxoqkrJe1B2o2ONrIa6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309090187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minidump is a best effort mechanism to collect useful and predefined
data for first level of debugging on end user devices running on
Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
or subsystem part of SoC crashes, due to a range of hardware and
software bugs. Hence, the ability to collect accurate data is only
a best-effort. The data collected could be invalid or corrupted,
data collection itself could fail, and so on.

Qualcomm devices in engineering mode provides a mechanism for
generating full system ramdumps for post mortem debugging. But in some
cases it's however not feasible to capture the entire content of RAM.
The minidump mechanism provides the means for selecting region should
be included in the ramdump. The solution supports extracting the
ramdump/minidump produced either over USB or stored to an attached
storage device.

The core of minidump feature is part of Qualcomm's boot firmware code.
It initializes shared memory (SMEM), which is a part of DDR and
allocates a small section of it to minidump table i.e also called
global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
their own table of segments to be included in the minidump, all
references from a descriptor in SMEM (G-ToC). Each segment/region has
some details like name, physical address and it's size etc. and it
could be anywhere scattered in the DDR.

qcom_minidump(core or frontend) driver adds the capability to add inux
region to be dumped as part of ram dump collection. It provides
appropriate symbol to register/unregister client regions.

To simplify post mortem debugging, it creates and maintain an ELF
header as first region that gets updated upon registration
of a new region.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/Kconfig                  |  13 +
 drivers/soc/qcom/Makefile                 |   1 +
 drivers/soc/qcom/qcom_minidump.c          | 603 ++++++++++++++++++++++++++++++
 drivers/soc/qcom/qcom_minidump_internal.h |  10 +
 drivers/soc/qcom/smem.c                   |  18 +
 include/linux/soc/qcom/smem.h             |   2 +
 include/soc/qcom/qcom_minidump.h          |  33 ++
 7 files changed, 680 insertions(+)
 create mode 100644 drivers/soc/qcom/qcom_minidump.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index ff38deac6a7d..4b36d46807bc 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -300,4 +300,17 @@ config QCOM_RPROC_MINIDUMP
 	  query predefined minidump segments associated with the remote processor
 	  and check its validity and end up collecting the dump on remote processor
 	  crash during its recovery.
+
+config QCOM_MINIDUMP
+	tristate "QCOM APSS Minidump driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_SMEM
+	help
+	  This config enables linux core infrastructure for Application
+	  processor subsystem (APSS) minidump collection i.e, it enables
+	  Linux clients drivers to register their internal data structures
+	  and debug messages as part of the apss minidump table and when
+	  the SoC is crashed, these selective regions will be dumped
+	  instead of the entire DDR dump. This saves significant amount
+	  of time and/or storage space.
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index a5fd2fed0923..9c1a409679ec 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
 obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
 obj-$(CONFIG_QCOM_RPROC_MINIDUMP)	+= qcom_rproc_minidump.o
+obj-$(CONFIG_QCOM_MINIDUMP)		+= qcom_minidump.o
diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
new file mode 100644
index 000000000000..86f4d09a7b4e
--- /dev/null
+++ b/drivers/soc/qcom/qcom_minidump.c
@@ -0,0 +1,603 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/elf.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/string.h>
+#include <soc/qcom/qcom_minidump.h>
+
+#include "qcom_minidump_internal.h"
+
+/**
+ * struct minidump_ss_data - Minidump subsystem private data
+ * @md_ss_toc	: Application Subsystem TOC pointer
+ * @md_regions	: Application Subsystem region base pointer
+ */
+struct minidump_ss_data {
+	struct minidump_subsystem	*md_ss_toc;
+	struct minidump_region		*md_regions;
+};
+
+/**
+ * struct minidump_elfhdr - Minidump table elf header
+ * @ehdr: elf main header
+ * @shdr: Section header
+ * @phdr: Program header
+ * @elf_offset: Section offset in elf
+ * @strtable_idx: String table current index position
+ */
+struct minidump_elfhdr {
+	struct elfhdr		*ehdr;
+	struct elf_shdr		*shdr;
+	struct elf_phdr		*phdr;
+	size_t			elf_offset;
+	size_t			strtable_idx;
+};
+
+/**
+ * struct minidump - Minidump driver data information
+ * @elf		  : Minidump elf header
+ * @dev		  : Minidump backend device
+ * @max_num_limit : Maximum number of region limit
+ * @apss_data	  : Backend driver's private data pointer
+ */
+struct minidump {
+	struct minidump_elfhdr		elf;
+	struct device			*dev;
+	struct minidump_ss_data		*apss_data;
+	struct mutex			md_lock;
+};
+
+/*
+ * In some of the Old Qualcomm devices, boot firmware statically allocates 300
+ * as total number of supported region (including all co-processors) in
+ * minidump table out of which linux was using 201. In future, this limitation
+ * from boot firmware might get removed by allocating the region dynamically.
+ * So, keep it compatible with older devices, we can keep the current limit for
+ * Linux to 201.
+ */
+#define MAX_NUM_ENTRIES	  201
+#define MAX_STRTBL_SIZE	  (MAX_NUM_ENTRIES * MAX_REGION_NAME_LENGTH)
+
+static struct elf_shdr *elf_shdr_entry_addr(struct elfhdr *ehdr, int idx)
+{
+	struct elf_shdr *eshdr = (struct elf_shdr *)((size_t)ehdr + ehdr->e_shoff);
+
+	return &eshdr[idx];
+}
+
+static struct elf_phdr *elf_phdr_entry_addr(struct elfhdr *ehdr, int idx)
+{
+	struct elf_phdr *ephdr = (struct elf_phdr *)((size_t)ehdr + ehdr->e_phoff);
+
+	return &ephdr[idx];
+}
+
+static char *elf_str_table_start(struct elfhdr *ehdr)
+{
+	struct elf_shdr *eshdr;
+
+	if (ehdr->e_shstrndx == SHN_UNDEF)
+		return NULL;
+
+	eshdr = elf_shdr_entry_addr(ehdr, ehdr->e_shstrndx);
+
+	return (char *)ehdr + eshdr->sh_offset;
+}
+
+static char *elf_lookup_string(struct minidump *md, struct elfhdr *ehdr, int offset)
+{
+	char *strtab = elf_str_table_start(ehdr);
+
+	if (!strtab || (md->elf.strtable_idx < offset))
+		return NULL;
+
+	return strtab + offset;
+}
+
+static unsigned int append_str_to_strtable(struct minidump *md, const char *name)
+{
+	char *strtab = elf_str_table_start(md->elf.ehdr);
+	unsigned int old_idx = md->elf.strtable_idx;
+	unsigned int ret;
+
+	if (!strtab || !name)
+		return 0;
+
+	ret = old_idx;
+	old_idx += strscpy((strtab + old_idx), name, MAX_REGION_NAME_LENGTH);
+	md->elf.strtable_idx = old_idx + 1;
+
+	return ret;
+}
+
+static int qcom_md_clear_elfheader(struct minidump *md,
+				   const struct qcom_minidump_region *region)
+{
+	struct elfhdr *ehdr = md->elf.ehdr;
+	struct elf_shdr *shdr;
+	struct elf_shdr *tmp_shdr;
+	struct elf_phdr *phdr;
+	struct elf_phdr *tmp_phdr;
+	unsigned int phidx;
+	unsigned int shidx;
+	unsigned int len;
+	unsigned int i;
+	char *shname;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		if (phdr->p_paddr == region->phys_addr &&
+		    phdr->p_memsz == region->size)
+			break;
+	}
+
+	if (i == ehdr->e_phnum) {
+		dev_err(md->dev, "Cannot find program header entry in elf\n");
+		return -EINVAL;
+	}
+
+	phidx = i;
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		shdr = elf_shdr_entry_addr(ehdr, i);
+		shname = elf_lookup_string(md, ehdr, shdr->sh_name);
+		if (shname && !strcmp(shname, region->name) &&
+		    shdr->sh_addr == (elf_addr_t)region->virt_addr &&
+		    shdr->sh_size == region->size)
+			break;
+	}
+
+	if (i == ehdr->e_shnum) {
+		dev_err(md->dev, "Cannot find section header entry in elf\n");
+		return -EINVAL;
+	}
+
+	shidx = i;
+	if (shdr->sh_offset != phdr->p_offset) {
+		dev_err(md->dev, "Invalid entry details for region: %s\n", region->name);
+		return -EINVAL;
+	}
+
+	/* Clear name in string table */
+	len = strlen(shname) + 1;
+	memmove(shname, shname + len, md->elf.strtable_idx - shdr->sh_name - len);
+	md->elf.strtable_idx -= len;
+
+	/* Clear program header */
+	tmp_phdr = elf_phdr_entry_addr(ehdr, phidx);
+	for (i = phidx; i < ehdr->e_phnum - 1; i++) {
+		tmp_phdr = elf_phdr_entry_addr(ehdr, i + 1);
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		memcpy(phdr, tmp_phdr, sizeof(struct elf_phdr));
+		phdr->p_offset = phdr->p_offset - region->size;
+	}
+	memset(tmp_phdr, 0, sizeof(struct elf_phdr));
+	ehdr->e_phnum--;
+
+	/* Clear section header */
+	tmp_shdr = elf_shdr_entry_addr(ehdr, shidx);
+	for (i = shidx; i < ehdr->e_shnum - 1; i++) {
+		tmp_shdr = elf_shdr_entry_addr(ehdr, i + 1);
+		shdr = elf_shdr_entry_addr(ehdr, i);
+		memcpy(shdr, tmp_shdr, sizeof(struct elf_shdr));
+		shdr->sh_offset -= region->size;
+		shdr->sh_name -= len;
+	}
+
+	memset(tmp_shdr, 0, sizeof(struct elf_shdr));
+	ehdr->e_shnum--;
+	md->elf.elf_offset -= region->size;
+
+	return 0;
+}
+
+static void qcom_md_update_elfheader(struct minidump *md,
+				     const struct qcom_minidump_region *region)
+{
+	struct elfhdr *ehdr = md->elf.ehdr;
+	struct elf_shdr *shdr;
+	struct elf_phdr *phdr;
+
+	shdr = elf_shdr_entry_addr(ehdr, ehdr->e_shnum++);
+	phdr = elf_phdr_entry_addr(ehdr, ehdr->e_phnum++);
+
+	shdr->sh_type = SHT_PROGBITS;
+	shdr->sh_name = append_str_to_strtable(md, region->name);
+	shdr->sh_addr = (elf_addr_t)region->virt_addr;
+	shdr->sh_size = region->size;
+	shdr->sh_flags = SHF_WRITE;
+	shdr->sh_offset = md->elf.elf_offset;
+	shdr->sh_entsize = 0;
+
+	phdr->p_type = PT_LOAD;
+	phdr->p_offset = md->elf.elf_offset;
+	phdr->p_vaddr = (elf_addr_t)region->virt_addr;
+	phdr->p_paddr = region->phys_addr;
+	phdr->p_filesz = phdr->p_memsz = region->size;
+	phdr->p_flags = PF_R | PF_W;
+	md->elf.elf_offset += shdr->sh_size;
+}
+
+static void qcom_md_add_region(struct minidump_ss_data *mdss_data,
+			       const struct qcom_minidump_region *region)
+{
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	struct minidump_region *mdr;
+	unsigned int region_cnt;
+
+	region_cnt = le32_to_cpu(mdss_toc->region_count);
+	mdr = &mdss_data->md_regions[region_cnt];
+	strscpy(mdr->name, region->name, sizeof(mdr->name));
+	mdr->address = cpu_to_le64(region->phys_addr);
+	mdr->size = cpu_to_le64(region->size);
+	mdr->valid = cpu_to_le32(MINIDUMP_REGION_VALID);
+	region_cnt++;
+	mdss_toc->region_count = cpu_to_le32(region_cnt);
+}
+
+static int qcom_md_get_region_index(struct minidump_ss_data *mdss_data,
+				    const struct qcom_minidump_region *region)
+{
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	struct minidump_region *mdr;
+	unsigned int i;
+	unsigned int count;
+
+	count = le32_to_cpu(mdss_toc->region_count);
+	for (i = 0; i < count; i++) {
+		mdr = &mdss_data->md_regions[i];
+		if (!strcmp(mdr->name, region->name))
+			return i;
+	}
+
+	return -ENOENT;
+}
+
+static int qcom_md_region_unregister(struct minidump *md,
+				     const struct qcom_minidump_region *region)
+{
+	struct minidump_ss_data *mdss_data = md->apss_data;
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	struct minidump_region *mdr;
+	unsigned int region_cnt;
+	unsigned int idx;
+	int ret;
+
+	ret = qcom_md_get_region_index(mdss_data, region);
+	if (ret < 0) {
+		dev_err(md->dev, "%s region is not present\n", region->name);
+		return ret;
+	}
+
+	idx = ret;
+	mdr = &mdss_data->md_regions[0];
+	region_cnt = le32_to_cpu(mdss_toc->region_count);
+	/*
+	 * Left shift all the regions exist after this removed region
+	 * index by 1 to fill the gap and zero out the last region
+	 * present at the end.
+	 */
+	memmove(&mdr[idx], &mdr[idx + 1],
+		(region_cnt - idx - 1) * sizeof(struct minidump_region));
+	memset(&mdr[region_cnt - 1], 0, sizeof(struct minidump_region));
+	region_cnt--;
+	mdss_toc->region_count = cpu_to_le32(region_cnt);
+
+	return 0;
+}
+
+static int qcom_md_region_register(struct minidump *md,
+				   const struct qcom_minidump_region *region)
+{
+	struct minidump_ss_data *mdss_data = md->apss_data;
+	struct minidump_subsystem *mdss_toc = mdss_data->md_ss_toc;
+	unsigned int num_region;
+	int ret;
+
+	ret = qcom_md_get_region_index(mdss_data, region);
+	if (ret >= 0) {
+		dev_info(md->dev, "%s region is already registered\n", region->name);
+		return -EEXIST;
+	}
+
+	/* Check if there is a room for a new entry */
+	num_region = le32_to_cpu(mdss_toc->region_count);
+	if (num_region >= MAX_NUM_ENTRIES) {
+		dev_err(md->dev, "maximum region limit %u reached\n", num_region);
+		return -ENOSPC;
+	}
+
+	qcom_md_add_region(mdss_data, region);
+
+	return 0;
+}
+
+static bool qcom_minidump_valid_region(const struct qcom_minidump_region *region)
+{
+	return region &&
+		strnlen(region->name, MAX_NAME_LENGTH) < MAX_NAME_LENGTH &&
+		region->virt_addr &&
+		region->size &&
+		IS_ALIGNED(region->size, 4);
+}
+
+/**
+ * qcom_minidump_region_register() - Register region in APSS Minidump table.
+ * @region: minidump region.
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+int qcom_minidump_region_register(const struct qcom_minidump_region *region)
+{
+	struct minidump *md;
+	int ret;
+
+	md = qcom_smem_minidump_ready();
+	if (!md)
+		return -EPROBE_DEFER;
+
+	if (!qcom_minidump_valid_region(region))
+		return -EINVAL;
+
+	mutex_lock(&md->md_lock);
+	ret = qcom_md_region_register(md, region);
+	if (ret)
+		goto unlock;
+
+	qcom_md_update_elfheader(md, region);
+unlock:
+	mutex_unlock(&md->md_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_region_register);
+
+/**
+ * qcom_minidump_region_unregister() - Unregister region from APSS Minidump table.
+ * @region: minidump region.
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+int qcom_minidump_region_unregister(const struct qcom_minidump_region *region)
+{
+	struct minidump *md;
+	int ret;
+
+	md = qcom_smem_minidump_ready();
+	if (!md)
+		return -EPROBE_DEFER;
+
+	if (!qcom_minidump_valid_region(region))
+		return -EINVAL;
+
+	mutex_lock(&md->md_lock);
+	ret = qcom_md_region_unregister(md, region);
+	if (ret)
+		goto unlock;
+
+	ret = qcom_md_clear_elfheader(md, region);
+unlock:
+	mutex_unlock(&md->md_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_region_unregister);
+
+static int qcom_md_add_elfheader(struct minidump *md)
+{
+	struct qcom_minidump_region elfregion;
+	struct elfhdr *ehdr;
+	struct elf_shdr *shdr;
+	struct elf_phdr *phdr;
+	unsigned int  elfh_size;
+	unsigned int strtbl_off;
+	unsigned int phdr_off;
+	unsigned int banner_len;
+	char *banner;
+
+	banner_len = strlen(linux_banner);
+	/*
+	 * Header buffer contains:
+	 * ELF header, (MAX_NUM_ENTRIES + 4) of Section and Program ELF headers,
+	 * where, 4 additional entries, one for empty header, one for string table
+	 * one for minidump table and one for linux banner.
+	 *
+	 * Linux banner is stored in minidump to aid post mortem tools to determine
+	 * the kernel version.
+	 */
+	elfh_size = sizeof(*ehdr);
+	elfh_size += MAX_STRTBL_SIZE;
+	elfh_size += banner_len + 1;
+	elfh_size += ((sizeof(*shdr) + sizeof(*phdr)) * (MAX_NUM_ENTRIES + 4));
+	elfh_size = ALIGN(elfh_size, 4);
+
+	md->elf.ehdr = devm_kzalloc(md->dev, elfh_size, GFP_KERNEL);
+	if (!md->elf.ehdr)
+		return -ENOMEM;
+
+	ehdr = md->elf.ehdr;
+	/* Assign Section/Program headers offset */
+	md->elf.shdr = shdr = (struct elf_shdr *)(ehdr + 1);
+	md->elf.phdr = phdr = (struct elf_phdr *)(shdr + MAX_NUM_ENTRIES);
+	phdr_off = sizeof(*ehdr) + (sizeof(*shdr) * MAX_NUM_ENTRIES);
+
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELF_CLASS;
+	ehdr->e_ident[EI_DATA] = ELF_DATA;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine  = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_ehsize = sizeof(*ehdr);
+	ehdr->e_phoff = phdr_off;
+	ehdr->e_phentsize = sizeof(*phdr);
+	ehdr->e_shoff = sizeof(*ehdr);
+	ehdr->e_shentsize = sizeof(*shdr);
+	ehdr->e_shstrndx = 1;
+
+	md->elf.elf_offset = elfh_size;
+	/*
+	 * The zeroth index of the section header is reserved and is rarely used.
+	 * Set the section header as null (SHN_UNDEF) and move to the next one.
+	 * 2nd Section is String table.
+	 */
+	md->elf.strtable_idx = 1;
+	strtbl_off = sizeof(*ehdr) + ((sizeof(*phdr) + sizeof(*shdr)) * MAX_NUM_ENTRIES);
+	shdr++;
+	shdr->sh_type = SHT_STRTAB;
+	shdr->sh_offset = (elf_addr_t)strtbl_off;
+	shdr->sh_size = MAX_STRTBL_SIZE;
+	shdr->sh_entsize = 0;
+	shdr->sh_flags = 0;
+	shdr->sh_name = append_str_to_strtable(md, "STR_TBL");
+	shdr++;
+
+	/* 3rd Section is Linux banner */
+	banner = (char *)ehdr + strtbl_off + MAX_STRTBL_SIZE;
+	memcpy(banner, linux_banner, banner_len);
+
+	shdr->sh_type = SHT_PROGBITS;
+	shdr->sh_offset = (elf_addr_t)(strtbl_off + MAX_STRTBL_SIZE);
+	shdr->sh_size = banner_len + 1;
+	shdr->sh_addr = (elf_addr_t)linux_banner;
+	shdr->sh_entsize = 0;
+	shdr->sh_flags = SHF_WRITE;
+	shdr->sh_name = append_str_to_strtable(md, "linux_banner");
+
+	phdr->p_type = PT_LOAD;
+	phdr->p_offset = (elf_addr_t)(strtbl_off + MAX_STRTBL_SIZE);
+	phdr->p_vaddr = (elf_addr_t)linux_banner;
+	phdr->p_paddr = virt_to_phys(linux_banner);
+	phdr->p_filesz = phdr->p_memsz = banner_len + 1;
+	phdr->p_flags = PF_R | PF_W;
+
+	/*
+	 * Above are some prdefined sections/program header used
+	 * for debug, update their count here.
+	 */
+	ehdr->e_phnum = 1;
+	ehdr->e_shnum = 3;
+
+	/* Register ELF header as first region */
+	strscpy(elfregion.name, "KELF_HEADER", sizeof(elfregion.name));
+	elfregion.virt_addr = md->elf.ehdr;
+	elfregion.phys_addr = virt_to_phys(md->elf.ehdr);
+	elfregion.size = elfh_size;
+
+	return qcom_md_region_register(md, &elfregion);
+}
+
+static int qcom_apss_md_table_init(struct minidump *md,
+				   struct minidump_subsystem *mdss_toc)
+{
+	struct minidump_ss_data *mdss_data;
+
+	mdss_data = devm_kzalloc(md->dev, sizeof(*mdss_data), GFP_KERNEL);
+	if (!mdss_data)
+		return -ENOMEM;
+
+	mdss_data->md_ss_toc = mdss_toc;
+	mdss_data->md_regions = devm_kcalloc(md->dev, MAX_NUM_ENTRIES,
+					     sizeof(struct minidump_region),
+					     GFP_KERNEL);
+	if (!mdss_data->md_regions)
+		return -ENOMEM;
+
+	mdss_toc = mdss_data->md_ss_toc;
+	mdss_toc->regions_baseptr = cpu_to_le64(virt_to_phys(mdss_data->md_regions));
+	mdss_toc->enabled = cpu_to_le32(MINIDUMP_SS_ENABLED);
+	mdss_toc->status = cpu_to_le32(1);
+	mdss_toc->region_count = cpu_to_le32(0);
+
+	/* Tell bootloader not to encrypt the regions of this subsystem */
+	mdss_toc->encryption_status = cpu_to_le32(MINIDUMP_SS_ENCR_DONE);
+	mdss_toc->encryption_required = cpu_to_le32(MINIDUMP_SS_ENCR_NOTREQ);
+
+	md->apss_data = mdss_data;
+
+	return 0;
+}
+
+static int qcom_apss_minidump_probe(struct platform_device *pdev)
+{
+	struct minidump_global_toc *mdgtoc;
+	struct minidump *md;
+	size_t size;
+	int ret;
+
+	md = devm_kzalloc(&pdev->dev, sizeof(struct minidump), GFP_KERNEL);
+	if (!md)
+		return -ENOMEM;
+
+	md->dev = &pdev->dev;
+	mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, &size);
+	if (IS_ERR(mdgtoc)) {
+		ret = PTR_ERR(mdgtoc);
+		dev_err(md->dev, "Couldn't find minidump smem item: %d\n", ret);
+		return ret;
+	}
+
+	if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
+		dev_err(md->dev, "minidump table is not initialized: %d\n", ret);
+		return -EINVAL;
+	}
+
+	mutex_init(&md->md_lock);
+	ret = qcom_apss_md_table_init(md, &mdgtoc->subsystems[MINIDUMP_APSS_DESC]);
+	if (ret) {
+		dev_err(md->dev, "apss minidump initialization failed: %d\n", ret);
+		return ret;
+	}
+
+	/* First entry would be ELF header */
+	ret = qcom_md_add_elfheader(md);
+	if (ret) {
+		dev_err(md->dev, "Failed to add elf header: %d\n", ret);
+		memset(md->apss_data->md_ss_toc, 0, sizeof(struct minidump_subsystem));
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, md);
+
+	return ret;
+}
+
+static int qcom_apss_minidump_remove(struct platform_device *pdev)
+{
+	struct minidump *md = platform_get_drvdata(pdev);
+	struct minidump_ss_data *mdss_data;
+
+	mdss_data = md->apss_data;
+	memset(mdss_data->md_ss_toc, cpu_to_le32(0), sizeof(struct minidump_subsystem));
+	md = NULL;
+
+	return 0;
+}
+
+static struct platform_driver qcom_minidump_driver = {
+	.probe = qcom_apss_minidump_probe,
+	.remove = qcom_apss_minidump_remove,
+	.driver  = {
+		.name = "qcom-minidump-smem",
+	},
+};
+
+module_platform_driver(qcom_minidump_driver);
+
+MODULE_DESCRIPTION("Qualcomm APSS minidump driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:qcom-minidump-smem");
diff --git a/drivers/soc/qcom/qcom_minidump_internal.h b/drivers/soc/qcom/qcom_minidump_internal.h
index 71709235b196..a2aebe5b690a 100644
--- a/drivers/soc/qcom/qcom_minidump_internal.h
+++ b/drivers/soc/qcom/qcom_minidump_internal.h
@@ -9,10 +9,20 @@
 #define MAX_NUM_OF_SS           10
 #define MAX_REGION_NAME_LENGTH  16
 #define SBL_MINIDUMP_SMEM_ID	602
+
 #define MINIDUMP_REGION_VALID	   ('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_REGION_INVALID	   ('I' << 24 | 'N' << 16 | 'V' << 8 | 'A' << 0)
+#define MINIDUMP_REGION_INIT	   ('I' << 24 | 'N' << 16 | 'I' << 8 | 'T' << 0)
+#define MINIDUMP_REGION_NOINIT	   0
+
+#define MINIDUMP_SS_ENCR_REQ	   (0 << 24 | 'Y' << 16 | 'E' << 8 | 'S' << 0)
+#define MINIDUMP_SS_ENCR_NOTREQ	   (0 << 24 | 0 << 16 | 'N' << 8 | 'R' << 0)
+#define MINIDUMP_SS_ENCR_START	   ('S' << 24 | 'T' << 16 | 'R' << 8 | 'T' << 0)
 #define MINIDUMP_SS_ENCR_DONE	   ('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
 #define MINIDUMP_SS_ENABLED	   ('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
 
+#define MINIDUMP_APSS_DESC	   0
+
 /**
  * struct minidump_region - Minidump region
  * @name		: Name of the region to be dumped
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index b0d59e815c3b..a9c8d1c85ad0 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -270,6 +270,7 @@ struct smem_region {
  * @partitions: list of partitions of current processor/host
  * @item_count: max accepted item number
  * @socinfo:	platform device pointer
+ * @minidump:	minidump platform device pointer
  * @num_regions: number of @regions
  * @regions:	list of the memory regions defining the shared memory
  */
@@ -280,6 +281,7 @@ struct qcom_smem {
 
 	u32 item_count;
 	struct platform_device *socinfo;
+	struct platform_device *minidump;
 	struct smem_ptable *ptable;
 	struct smem_partition global_partition;
 	struct smem_partition partitions[SMEM_HOST_COUNT];
@@ -795,6 +797,13 @@ int qcom_smem_get_soc_id(u32 *id)
 }
 EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
 
+void *qcom_smem_minidump_ready(void)
+{
+	return (__smem && __smem->minidump) ? platform_get_drvdata(__smem->minidump) :
+		NULL;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_minidump_ready);
+
 static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
 	struct smem_header *header;
@@ -1174,11 +1183,20 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
+	smem->minidump = platform_device_register_data(&pdev->dev, "qcom-minidump-smem",
+						      PLATFORM_DEVID_NONE, NULL,
+						      0);
+	if (IS_ERR(smem->minidump)) {
+		dev_dbg(&pdev->dev, "failed to register minidump device\n");
+		smem->minidump = NULL;
+	}
+
 	return 0;
 }
 
 static int qcom_smem_remove(struct platform_device *pdev)
 {
+	platform_device_unregister(__smem->minidump);
 	platform_device_unregister(__smem->socinfo);
 
 	hwspin_lock_free(__smem->hwlock);
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index 223db6a9c733..efcd15b8112b 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -13,4 +13,6 @@ phys_addr_t qcom_smem_virt_to_phys(void *p);
 
 int qcom_smem_get_soc_id(u32 *id);
 
+void *qcom_smem_minidump_ready(void);
+
 #endif
diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
index cd87caef919d..d993604ed2bf 100644
--- a/include/soc/qcom/qcom_minidump.h
+++ b/include/soc/qcom/qcom_minidump.h
@@ -6,6 +6,39 @@
 #ifndef _QCOM_MINIDUMP_H_
 #define _QCOM_MINIDUMP_H_
 
+#define MAX_NAME_LENGTH		12
+
+/**
+ * struct qcom_minidump_region - APSS Minidump region information
+ *
+ * @name:	Entry name, Minidump will dump binary with this name.
+ * @virt_addr:  Virtual address of the entry.
+ * @phys_addr:	Physical address of the entry to dump.
+ * @size:	Number of byte to dump from @address location,
+ *		and it should be 4 byte aligned.
+ */
+struct qcom_minidump_region {
+	char		name[MAX_NAME_LENGTH];
+	void		*virt_addr;
+	phys_addr_t	phys_addr;
+	size_t		size;
+};
+
+#if IS_ENABLED(CONFIG_QCOM_MINIDUMP)
+int qcom_minidump_region_register(const struct qcom_minidump_region *region);
+int qcom_minidump_region_unregister(const struct qcom_minidump_region *region);
+#else
+static inline int qcom_minidump_region_register(const struct qcom_minidump_region *region)
+{
+	/* Return quietly, if minidump config is not enabled */
+	return 0;
+}
+static inline int qcom_minidump_region_unregister(const struct qcom_minidump_region *region)
+{
+	return 0;
+}
+#endif /* CONFIG_QCOM_MINIDUMP */
+
 struct rproc;
 struct rproc_dump_segment;
 
-- 
2.7.4

