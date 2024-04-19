Return-Path: <linux-kernel+bounces-151772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55148AB3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80681C21221
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673513D282;
	Fri, 19 Apr 2024 16:47:55 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56813BC07;
	Fri, 19 Apr 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545274; cv=none; b=oOlgfq4/Ofrov/rOU7i0BI5KsMQhKAUEnflyX2N1FCBOSUz2243qfYqqzofNtNAYVIm4ZeLZfKISDrJ3KrAVl6dY12RA1zFli30t3nKs8Z7NqTcToKBKIUEYMYgXHbC0pglS5lci8SQQe+koVBGF+kA+eCWTGug0N2R4CpW9syw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545274; c=relaxed/simple;
	bh=NcR+bYaf8Mx3cz6CkDdlXpQDZaAt7PQmrLfmx7E3u+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHz6a7+cq+KQpiL7Ok90Bv0hjgX4dn/9SCB6VSnuekdKXvpMt7r8la2TyX09NnQMZbZAwXeGuHq8QusXN/Xn/N1FbNznPAoMluC3U6moK6Lsup9hjqr9uECYi6q9FO6OnngXWFyrxAjQUN4b60nQb/p+DjKj/vF5PpPTcU0u2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLgYc1bsvz6K8xt;
	Sat, 20 Apr 2024 00:47:48 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 913BD140A35;
	Sat, 20 Apr 2024 00:47:49 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 17:47:48 +0100
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v8 08/10] ACPI:RAS2: Add ACPI RAS2 driver
Date: Sat, 20 Apr 2024 00:47:17 +0800
Message-ID: <20240419164720.1765-9-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240419164720.1765-1-shiju.jose@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for ACPI RAS2 feature table (RAS2) defined in the
ACPI 6.5 Specification, section 5.2.21.
Driver contains RAS2 Init, which extracts the RAS2 table and driver
adds platform device for each memory features which binds to the
RAS2 memory driver.

Driver uses PCC mailbox to communicate with the ACPI HW and the
driver adds OSPM interfaces to send RAS2 commands.

Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/Kconfig     |  10 ++
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/ras2.c      | 366 +++++++++++++++++++++++++++++++++++++++
 include/acpi/ras2_acpi.h |  59 +++++++
 4 files changed, 436 insertions(+)
 create mode 100755 drivers/acpi/ras2.c
 create mode 100644 include/acpi/ras2_acpi.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ff1689bb3124..638f1e38f961 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -284,6 +284,16 @@ config ACPI_CPPC_LIB
 	  If your platform does not support CPPC in firmware,
 	  leave this option disabled.
 
+config ACPI_RAS2
+	bool "ACPI RAS2 driver"
+	select MAILBOX
+	select PCC
+	help
+	  The driver adds support for ACPI RAS2 feature table(extracts RAS2
+	  table from OS system table) and OSPM interfaces to send RAS2
+	  commands via PCC mailbox subspace. Driver adds platform device for
+	  the RAS2 memory features which binds to the RAS2 memory driver.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || ARM64 || LOONGARCH || RISCV
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8cc8c0d9c873..1df9de524c62 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
+obj-$(CONFIG_ACPI_RAS2)		+= ras2.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
new file mode 100755
index 000000000000..f4282aad5174
--- /dev/null
+++ b/drivers/acpi/ras2.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Implementation of ACPI RAS2 driver.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ *
+ * Support for RAS2 - ACPI 6.5 Specification, section 5.2.21
+ *
+ * Driver contains ACPI RAS2 init, which extracts the ACPI RAS2 table and
+ * get the PCC channel subspace for communicating with the ACPI compliant
+ * HW platform which supports ACPI RAS2. Driver adds platform devices
+ * for each RAS2 memory feature which binds to the memory ACPI RAS2 driver.
+ */
+
+#define pr_fmt(fmt)    "ACPI RAS2: " fmt
+
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/ktime.h>
+#include <linux/platform_device.h>
+#include <acpi/pcc.h>
+#include <acpi/ras2_acpi.h>
+
+/*
+ * Arbitrary Retries for PCC commands because the
+ * remote processor could be much slower to reply.
+ */
+#define RAS2_NUM_RETRIES 600
+
+#define RAS2_FEATURE_TYPE_MEMORY        0x00
+
+/* global variables for the RAS2 PCC subspaces */
+static DEFINE_MUTEX(ras2_pcc_subspace_lock);
+static LIST_HEAD(ras2_pcc_subspaces);
+
+static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)
+{
+	struct acpi_ras2_shared_memory __iomem *generic_comm_base = pcc_subspace->pcc_comm_addr;
+	ktime_t next_deadline = ktime_add(ktime_get(), pcc_subspace->deadline);
+	u16 status;
+
+	while (!ktime_after(ktime_get(), next_deadline)) {
+		/*
+		 * As per ACPI spec, the PCC space will be initialized by
+		 * platform and should have set the command completion bit when
+		 * PCC can be used by OSPM
+		 */
+		status = readw_relaxed(&generic_comm_base->status);
+		if (status & RAS2_PCC_CMD_ERROR)
+			return -EIO;
+		if (status & RAS2_PCC_CMD_COMPLETE)
+			return 0;
+		/*
+		 * Reducing the bus traffic in case this loop takes longer than
+		 * a few retries.
+		 */
+		msleep(10);
+	}
+
+	return -EIO;
+}
+
+/**
+ * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
+ * @ras2_ctx:	pointer to the ras2 context structure
+ * @cmd:	command to send
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int ras2_send_pcc_cmd(struct ras2_scrub_ctx *ras2_ctx, u16 cmd)
+{
+	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
+	struct acpi_ras2_shared_memory *generic_comm_base = pcc_subspace->pcc_comm_addr;
+	static ktime_t last_cmd_cmpl_time, last_mpar_reset;
+	struct mbox_chan *pcc_channel;
+	unsigned int time_delta;
+	static int mpar_count;
+	int ret;
+
+	guard(mutex)(&ras2_pcc_subspace_lock);
+	ret = ras2_check_pcc_chan(pcc_subspace);
+	if (ret)
+		return ret;
+	pcc_channel = pcc_subspace->pcc_chan->mchan;
+
+	/*
+	 * Handle the Minimum Request Turnaround Time(MRTT)
+	 * "The minimum amount of time that OSPM must wait after the completion
+	 * of a command before issuing the next command, in microseconds"
+	 */
+	if (pcc_subspace->pcc_mrtt) {
+		time_delta = ktime_us_delta(ktime_get(), last_cmd_cmpl_time);
+		if (pcc_subspace->pcc_mrtt > time_delta)
+			udelay(pcc_subspace->pcc_mrtt - time_delta);
+	}
+
+	/*
+	 * Handle the non-zero Maximum Periodic Access Rate(MPAR)
+	 * "The maximum number of periodic requests that the subspace channel can
+	 * support, reported in commands per minute. 0 indicates no limitation."
+	 *
+	 * This parameter should be ideally zero or large enough so that it can
+	 * handle maximum number of requests that all the cores in the system can
+	 * collectively generate. If it is not, we will follow the spec and just
+	 * not send the request to the platform after hitting the MPAR limit in
+	 * any 60s window
+	 */
+	if (pcc_subspace->pcc_mpar) {
+		if (mpar_count == 0) {
+			time_delta = ktime_ms_delta(ktime_get(), last_mpar_reset);
+			if (time_delta < 60 * MSEC_PER_SEC) {
+				dev_dbg(ras2_ctx->dev,
+					"PCC cmd not sent due to MPAR limit");
+				return -EIO;
+			}
+			last_mpar_reset = ktime_get();
+			mpar_count = pcc_subspace->pcc_mpar;
+		}
+		mpar_count--;
+	}
+
+	/* Write to the shared comm region. */
+	writew_relaxed(cmd, &generic_comm_base->command);
+
+	/* Flip CMD COMPLETE bit */
+	writew_relaxed(0, &generic_comm_base->status);
+
+	/* Ring doorbell */
+	ret = mbox_send_message(pcc_channel, &cmd);
+	if (ret < 0) {
+		dev_err(ras2_ctx->dev,
+			"Err sending PCC mbox message. cmd:%d, ret:%d\n",
+			cmd, ret);
+		return ret;
+	}
+
+	/*
+	 * If Minimum Request Turnaround Time is non-zero, we need
+	 * to record the completion time of both READ and WRITE
+	 * command for proper handling of MRTT, so we need to check
+	 * for pcc_mrtt in addition to CMD_READ
+	 */
+	if (cmd == RAS2_PCC_CMD_EXEC || pcc_subspace->pcc_mrtt) {
+		ret = ras2_check_pcc_chan(pcc_subspace);
+		if (pcc_subspace->pcc_mrtt)
+			last_cmd_cmpl_time = ktime_get();
+	}
+
+	if (pcc_channel->mbox->txdone_irq)
+		mbox_chan_txdone(pcc_channel, ret);
+	else
+		mbox_client_txdone(pcc_channel, ret);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
+
+static int ras2_register_pcc_channel(struct device *dev, struct ras2_scrub_ctx *ras2_ctx,
+				     int pcc_subspace_id)
+{
+	struct acpi_pcct_hw_reduced *ras2_ss;
+	struct mbox_client *ras2_mbox_cl;
+	struct pcc_mbox_chan *pcc_chan;
+	struct ras2_pcc_subspace *pcc_subspace;
+
+	if (pcc_subspace_id < 0)
+		return -EINVAL;
+
+	mutex_lock(&ras2_pcc_subspace_lock);
+	list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
+		if (pcc_subspace->pcc_subspace_id == pcc_subspace_id) {
+			ras2_ctx->pcc_subspace = pcc_subspace;
+			pcc_subspace->ref_count++;
+			mutex_unlock(&ras2_pcc_subspace_lock);
+			return 0;
+		}
+	}
+	mutex_unlock(&ras2_pcc_subspace_lock);
+
+	pcc_subspace = kcalloc(1, sizeof(*pcc_subspace), GFP_KERNEL);
+	if (!pcc_subspace)
+		return -ENOMEM;
+	pcc_subspace->pcc_subspace_id = pcc_subspace_id;
+	ras2_mbox_cl = &pcc_subspace->mbox_client;
+	ras2_mbox_cl->dev = dev;
+	ras2_mbox_cl->knows_txdone = true;
+
+	pcc_chan = pcc_mbox_request_channel(ras2_mbox_cl, pcc_subspace_id);
+	if (IS_ERR(pcc_chan)) {
+		kfree(pcc_subspace);
+		return PTR_ERR(pcc_chan);
+	}
+	pcc_subspace->pcc_chan = pcc_chan;
+	ras2_ss = pcc_chan->mchan->con_priv;
+	pcc_subspace->comm_base_addr = ras2_ss->base_address;
+
+	/*
+	 * ras2_ss->latency is just a Nominal value. In reality
+	 * the remote processor could be much slower to reply.
+	 * So add an arbitrary amount of wait on top of Nominal.
+	 */
+	pcc_subspace->deadline = ns_to_ktime(RAS2_NUM_RETRIES * ras2_ss->latency *
+					     NSEC_PER_USEC);
+	pcc_subspace->pcc_mrtt = ras2_ss->min_turnaround_time;
+	pcc_subspace->pcc_mpar = ras2_ss->max_access_rate;
+	pcc_subspace->pcc_comm_addr = acpi_os_ioremap(pcc_subspace->comm_base_addr,
+						      ras2_ss->length);
+	/* Set flag so that we dont come here for each CPU. */
+	pcc_subspace->pcc_channel_acquired = true;
+
+	mutex_lock(&ras2_pcc_subspace_lock);
+	list_add(&pcc_subspace->elem, &ras2_pcc_subspaces);
+	pcc_subspace->ref_count++;
+	mutex_unlock(&ras2_pcc_subspace_lock);
+	ras2_ctx->pcc_subspace = pcc_subspace;
+
+	return 0;
+}
+
+static void ras2_unregister_pcc_channel(void *ctx)
+{
+	struct ras2_scrub_ctx *ras2_ctx = ctx;
+	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
+
+	if (!pcc_subspace  || !pcc_subspace->pcc_chan)
+		return;
+
+	guard(mutex)(&ras2_pcc_subspace_lock);
+	if (pcc_subspace->ref_count > 0)
+		pcc_subspace->ref_count--;
+	if (!pcc_subspace->ref_count) {
+		list_del(&pcc_subspace->elem);
+		pcc_mbox_free_channel(pcc_subspace->pcc_chan);
+		kfree(pcc_subspace);
+	}
+}
+
+/**
+ * devm_ras2_register_pcc_channel() - Register RAS2 PCC channel
+ * @dev:		pointer to the ras2 device
+ * @ras2_ctx:		pointer to the ras2 context structure
+ * @pcc_subspace_id:	identifier of the RAS2 PCC channel.
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int devm_ras2_register_pcc_channel(struct device *dev, struct ras2_scrub_ctx *ras2_ctx,
+				   int pcc_subspace_id)
+{
+	int ret;
+
+	ret = ras2_register_pcc_channel(dev, ras2_ctx, pcc_subspace_id);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ras2_unregister_pcc_channel, ras2_ctx);
+}
+EXPORT_SYMBOL_NS_GPL(devm_ras2_register_pcc_channel, ACPI_RAS2);
+
+static struct platform_device *ras2_add_platform_device(char *name, int channel)
+{
+	int ret;
+	struct platform_device *pdev __free(platform_device_put) =
+		platform_device_alloc(name, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return ERR_PTR(-ENOMEM);
+
+	ret = platform_device_add_data(pdev, &channel, sizeof(channel));
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return_ptr(pdev);
+}
+
+static struct acpi_table_header *acpi_get_table2(acpi_string signature,
+						 u32 instance)
+{
+	struct acpi_table_header *header = NULL;
+	acpi_status status = acpi_get_table(signature, instance, &header);
+
+	if (ACPI_FAILURE(status))
+		return ERR_PTR(-EINVAL);
+
+	return header;
+}
+
+static int __init ras2_acpi_init(void)
+{
+	struct acpi_ras2_pcc_desc *pcc_desc_list;
+	struct acpi_table_ras2 *pRas2Table;
+	struct platform_device *pdev;
+	int pcc_subspace_id;
+	acpi_size ras2_size;
+	u8 count = 0, i;
+
+	struct acpi_table_header *pAcpiTable __free(acpi_put_table) =
+						acpi_get_table2("RAS2", 0);
+	if (IS_ERR_OR_NULL(pAcpiTable)) {
+		pr_err("ACPI RAS2 driver failed to initialize, get table failed\n");
+		return -ENODEV;
+	}
+
+	ras2_size = pAcpiTable->length;
+	if (ras2_size < sizeof(struct acpi_table_ras2)) {
+		pr_err("ACPI RAS2 table present but broken (too short #1)\n");
+		return -EINVAL;
+	}
+
+	pRas2Table = (struct acpi_table_ras2 *)pAcpiTable;
+	if (pRas2Table->num_pcc_descs <= 0) {
+		pr_err("ACPI RAS2 table does not contain PCC descriptors\n");
+		return -EINVAL;
+	}
+
+	struct platform_device **pdev_list __free(kfree) =
+			kcalloc(pRas2Table->num_pcc_descs, sizeof(*pdev_list),
+				GFP_KERNEL);
+	if (!pdev_list)
+		return -ENOMEM;
+
+	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(pRas2Table + 1);
+	/* Double scan for the case of only one actual controller */
+	pcc_subspace_id = -1;
+	count = 0;
+	for (i = 0; i < pRas2Table->num_pcc_descs; i++, pcc_desc_list++) {
+		if (pcc_desc_list->feature_type != RAS2_FEATURE_TYPE_MEMORY)
+			continue;
+		if (pcc_subspace_id == -1) {
+			pcc_subspace_id = pcc_desc_list->channel_id;
+			count++;
+		}
+		if (pcc_desc_list->channel_id != pcc_subspace_id)
+			count++;
+	}
+	if (count == 1) {
+		pdev = ras2_add_platform_device("acpi_ras2", pcc_subspace_id);
+		if (!pdev)
+			goto free_ras2_pdev;
+		pdev_list[0] = pdev;
+		return 0;
+	}
+
+	count = 0;
+	for (i = 0; i < pRas2Table->num_pcc_descs; i++, pcc_desc_list++) {
+		if (pcc_desc_list->feature_type != RAS2_FEATURE_TYPE_MEMORY)
+			continue;
+		pcc_subspace_id = pcc_desc_list->channel_id;
+		/* Add the platform device and bind ACPI RAS2 memory driver */
+		pdev = ras2_add_platform_device("acpi_ras2", pcc_subspace_id);
+		if (!pdev)
+			goto free_ras2_pdev;
+		pdev_list[count++] = pdev;
+	}
+
+	return 0;
+
+free_ras2_pdev:
+	for (i = count; i >= 0; i++)
+		platform_device_put(pdev_list[i]);
+
+	return -ENODEV;
+}
+late_initcall(ras2_acpi_init)
diff --git a/include/acpi/ras2_acpi.h b/include/acpi/ras2_acpi.h
new file mode 100644
index 000000000000..8c9430e6383e
--- /dev/null
+++ b/include/acpi/ras2_acpi.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * RAS2 ACPI driver header file
+ *
+ * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises
+ *
+ * Copyright (c) 2024 HiSilicon Limited
+ */
+
+#ifndef _RAS2_ACPI_H
+#define _RAS2_ACPI_H
+
+#include <linux/acpi.h>
+#include <linux/mailbox_client.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#define RAS2_PCC_CMD_COMPLETE	BIT(0)
+#define RAS2_PCC_CMD_ERROR	BIT(2)
+
+/* RAS2 specific PCC commands */
+#define RAS2_PCC_CMD_EXEC 0x01
+
+struct device;
+
+/* Data structures for PCC communication and RAS2 table */
+struct pcc_mbox_chan;
+
+struct ras2_pcc_subspace {
+	int pcc_subspace_id;
+	struct mbox_client mbox_client;
+	struct pcc_mbox_chan *pcc_chan;
+	struct acpi_ras2_shared_memory __iomem *pcc_comm_addr;
+	u64 comm_base_addr;
+	bool pcc_channel_acquired;
+	ktime_t deadline;
+	unsigned int pcc_mpar;
+	unsigned int pcc_mrtt;
+	struct list_head elem;
+	u16 ref_count;
+};
+
+struct ras2_scrub_ctx {
+	struct device *dev;
+	struct ras2_pcc_subspace *pcc_subspace;
+	int id;
+	struct device *scrub_dev;
+	bool bg;
+	u64 base, size;
+	u8 rate, rate_min, rate_max;
+	/* Lock to provide mutually exclusive access to PCC channel */
+	struct mutex lock;
+};
+
+int ras2_send_pcc_cmd(struct ras2_scrub_ctx *ras2_ctx, u16 cmd);
+int devm_ras2_register_pcc_channel(struct device *dev, struct ras2_scrub_ctx *ras2_ctx,
+				   int pcc_subspace_id);
+
+#endif /* _RAS2_ACPI_H */
-- 
2.34.1


