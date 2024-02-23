Return-Path: <linux-kernel+bounces-78499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7510861433
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160EB1C20ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3183CAD;
	Fri, 23 Feb 2024 14:37:53 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B432E412;
	Fri, 23 Feb 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699072; cv=none; b=SQWuZpBSHNOGMIiYqYM4ChO0yoBuXRF7ma3H9PKa43wBs+eLDVUIoyHKcz8KcMU44vzrxjgEw2U74m1KsRcUwhIk4htIJzuJfR6cxJNqQFGBjbDYBqeXZ7fbb96q30vFIQ3Pm/KLZeu5yeKKo91mU8SKlKK4dlm5oxyB//i5piQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699072; c=relaxed/simple;
	bh=T0q+t3x/VkaVnw8IvMEZVDZKcyC74OoGTeGcfhG78jw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xhtj0zU3ZqpFz1hk8tmmwDb0HP2HiHugi0J0inbtCL/V8c6QZMbOEBGY1RBUZGKRZSEJqGNnjwATXaKEyat5yY4qYkTG3ywiogxpBUUfMQpNZqpjKX1qg+lCUbR5HCfxEH57CmwX3ygLpa29PXj8QdwZ3y9f6mfwd3VRfsNT0D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThCDf2QDJz6K611;
	Fri, 23 Feb 2024 22:33:38 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id A378F14149E;
	Fri, 23 Feb 2024 22:37:47 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:37:46 +0000
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
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v7 10/12] ACPI:RAS2: Add common library for RAS2 PCC interfaces
Date: Fri, 23 Feb 2024 22:37:21 +0800
Message-ID: <20240223143723.1574-11-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240223143723.1574-1-shiju.jose@huawei.com>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: A Somasundaram <somasundaram.a@hpe.com>

The code contains PCC interfaces for RAS2 table, functions to send
RAS2 commands as per ACPI 6.5 & upwards revision.

References for this implementation,
ACPI specification 6.5 section 5.2.21 for RAS2 table and chapter 14
for PCC (Platform Communication Channel).

Driver uses PCC interfaces to communicate to the ACPI HW. This code
implements PCC interfaces and the functions to send the RAS2 commands
to be used by OSPM.

Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/Kconfig            |  14 ++
 drivers/acpi/Makefile           |   1 +
 drivers/acpi/ras2_acpi_common.c | 272 ++++++++++++++++++++++++++++++++
 include/acpi/ras2_acpi.h        |  59 +++++++
 4 files changed, 346 insertions(+)
 create mode 100755 drivers/acpi/ras2_acpi_common.c
 create mode 100644 include/acpi/ras2_acpi.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 3c3f8037ebed..6f69c9976c4f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -284,6 +284,20 @@ config ACPI_CPPC_LIB
 	  If your platform does not support CPPC in firmware,
 	  leave this option disabled.
 
+config ACPI_RAS2
+	bool "ACPI RAS2 driver"
+	depends on ACPI_PROCESSOR
+	select MAILBOX
+	select PCC
+	help
+	  The driver adds support for PCC (platform communication
+	  channel) interfaces to communicate with the ACPI complaint
+	  hardware platform supports RAS2(RAS2 Feature table).
+	  The driver adds support for RAS2(extraction of RAS2
+	  tables from OS system table), PCC interfaces and OSPM interfaces
+	  to send RAS2 commands. Driver adds platform device which
+	  binds to the RAS2 memory driver.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || ARM64 || LOONGARCH
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 12ef8180d272..b12fba9cff06 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
+obj-$(CONFIG_ACPI_RAS2)		+= ras2_acpi_common.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
diff --git a/drivers/acpi/ras2_acpi_common.c b/drivers/acpi/ras2_acpi_common.c
new file mode 100755
index 000000000000..c6e4ed96cd81
--- /dev/null
+++ b/drivers/acpi/ras2_acpi_common.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ACPI RAS2 table processing common functions
+ *
+ * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ *
+ * Support for
+ * RAS2 - ACPI 6.5 Specification, section 5.2.21
+ * PCC(Platform Communications Channel) - ACPI 6.5 Specification,
+ * chapter 14.
+ *
+ * Code contains common functions for RAS2.
+ * PCC(Platform communication channel) interfaces for the RAS2
+ * and the functions for sending RAS2 commands to the ACPI HW.
+ */
+
+#include <linux/export.h>
+#include <linux/delay.h>
+#include <linux/ktime.h>
+#include <linux/platform_device.h>
+#include <acpi/ras2_acpi.h>
+#include <acpi/acpixf.h>
+
+static int ras2_check_pcc_chan(struct ras2_context *ras2_ctx)
+{
+	struct acpi_ras2_shared_memory  __iomem *generic_comm_base = ras2_ctx->pcc_comm_addr;
+	ktime_t next_deadline = ktime_add(ktime_get(), ras2_ctx->deadline);
+
+	while (!ktime_after(ktime_get(), next_deadline)) {
+		/*
+		 * As per ACPI spec, the PCC space wil be initialized by
+		 * platform and should have set the command completion bit when
+		 * PCC can be used by OSPM
+		 */
+		if (readw_relaxed(&generic_comm_base->status) & RAS2_PCC_CMD_COMPLETE)
+			return 0;
+		/*
+		 * Reducing the bus traffic in case this loop takes longer than
+		 * a few retries.
+		 */
+		udelay(10);
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
+int ras2_send_pcc_cmd(struct ras2_context *ras2_ctx, u16 cmd)
+{
+	int ret;
+	struct acpi_ras2_shared_memory  *generic_comm_base =
+		(struct acpi_ras2_shared_memory *)ras2_ctx->pcc_comm_addr;
+	static ktime_t last_cmd_cmpl_time, last_mpar_reset;
+	struct mbox_chan *pcc_channel;
+	static int mpar_count;
+	unsigned int time_delta;
+
+	if (cmd == RAS2_PCC_CMD_EXEC) {
+		ret = ras2_check_pcc_chan(ras2_ctx);
+		if (ret)
+			return ret;
+	}
+	pcc_channel = ras2_ctx->pcc_chan->mchan;
+
+	/*
+	 * Handle the Minimum Request Turnaround Time(MRTT)
+	 * "The minimum amount of time that OSPM must wait after the completion
+	 * of a command before issuing the next command, in microseconds"
+	 */
+	if (ras2_ctx->pcc_mrtt) {
+		time_delta = ktime_us_delta(ktime_get(), last_cmd_cmpl_time);
+		if (ras2_ctx->pcc_mrtt > time_delta)
+			udelay(ras2_ctx->pcc_mrtt - time_delta);
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
+	if (ras2_ctx->pcc_mpar) {
+		if (mpar_count == 0) {
+			time_delta = ktime_ms_delta(ktime_get(), last_mpar_reset);
+			if (time_delta < 60 * MSEC_PER_SEC) {
+				dev_dbg(ras2_ctx->dev,
+					"PCC cmd not sent due to MPAR limit");
+				return -EIO;
+			}
+			last_mpar_reset = ktime_get();
+			mpar_count = ras2_ctx->pcc_mpar;
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
+	 * For READs we need to ensure the cmd completed to ensure
+	 * the ensuing read()s can proceed. For WRITEs we dont care
+	 * because the actual write()s are done before coming here
+	 * and the next READ or WRITE will check if the channel
+	 * is busy/free at the entry of this call.
+	 *
+	 * If Minimum Request Turnaround Time is non-zero, we need
+	 * to record the completion time of both READ and WRITE
+	 * command for proper handling of MRTT, so we need to check
+	 * for pcc_mrtt in addition to CMD_READ
+	 */
+	if (cmd == RAS2_PCC_CMD_EXEC || ras2_ctx->pcc_mrtt) {
+		ret = ras2_check_pcc_chan(ras2_ctx);
+		if (ras2_ctx->pcc_mrtt)
+			last_cmd_cmpl_time = ktime_get();
+	}
+
+	if (pcc_channel->mbox->txdone_irq)
+		mbox_chan_txdone(pcc_channel, ret);
+	else
+		mbox_client_txdone(pcc_channel, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
+
+/**
+ * ras2_register_pcc_channel() - Register PCC channel
+ * @ras2_ctx:	pointer to the ras2 context structure
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int ras2_register_pcc_channel(struct ras2_context *ras2_ctx)
+{
+	u64 usecs_lat;
+	unsigned int len;
+	struct pcc_mbox_chan *pcc_chan;
+	struct mbox_client *ras2_mbox_cl;
+	struct acpi_pcct_hw_reduced *ras2_ss;
+
+	ras2_mbox_cl = &ras2_ctx->mbox_client;
+	if (!ras2_mbox_cl || ras2_ctx->pcc_subspace_idx < 0)
+		return -EINVAL;
+
+	pcc_chan = pcc_mbox_request_channel(ras2_mbox_cl,
+					    ras2_ctx->pcc_subspace_idx);
+
+	if (IS_ERR(pcc_chan)) {
+		dev_err(ras2_ctx->dev,
+			"Failed to find PCC channel for subspace %d\n",
+			ras2_ctx->pcc_subspace_idx);
+		return -ENODEV;
+	}
+	ras2_ctx->pcc_chan = pcc_chan;
+	/*
+	 * The PCC mailbox controller driver should
+	 * have parsed the PCCT (global table of all
+	 * PCC channels) and stored pointers to the
+	 * subspace communication region in con_priv.
+	 */
+	ras2_ss = pcc_chan->mchan->con_priv;
+
+	if (!ras2_ss) {
+		dev_err(ras2_ctx->dev, "No PCC subspace found for RAS2\n");
+		pcc_mbox_free_channel(ras2_ctx->pcc_chan);
+		return -ENODEV;
+	}
+
+	/*
+	 * This is the shared communication region
+	 * for the OS and Platform to communicate over.
+	 */
+	ras2_ctx->comm_base_addr = ras2_ss->base_address;
+	len = ras2_ss->length;
+	dev_dbg(ras2_ctx->dev, "PCC subspace for RAS2=0x%llx len=%d\n",
+		ras2_ctx->comm_base_addr, len);
+
+	/*
+	 * ras2_ss->latency is just a Nominal value. In reality
+	 * the remote processor could be much slower to reply.
+	 * So add an arbitrary amount of wait on top of Nominal.
+	 */
+	usecs_lat = RAS2_NUM_RETRIES * ras2_ss->latency;
+	ras2_ctx->deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
+	ras2_ctx->pcc_mrtt = ras2_ss->min_turnaround_time;
+	ras2_ctx->pcc_mpar = ras2_ss->max_access_rate;
+	ras2_ctx->pcc_comm_addr = acpi_os_ioremap(ras2_ctx->comm_base_addr,
+						  len);
+	dev_dbg(ras2_ctx->dev, "pcc_comm_addr=%p\n",
+		ras2_ctx->pcc_comm_addr);
+
+	/* Set flag so that we dont come here for each CPU. */
+	ras2_ctx->pcc_channel_acquired = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ras2_register_pcc_channel);
+
+/**
+ * ras2_unregister_pcc_channel() - Unregister PCC channel
+ * @ras2_ctx:	pointer to the ras2 context structure
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int ras2_unregister_pcc_channel(struct ras2_context *ras2_ctx)
+{
+	if (!ras2_ctx->pcc_chan)
+		return -EINVAL;
+
+	pcc_mbox_free_channel(ras2_ctx->pcc_chan);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ras2_unregister_pcc_channel);
+
+/**
+ * ras2_add_platform_device() - Add a platform device for RAS2
+ * @name:	name of the device we're adding
+ * @data:	platform specific data for this platform device
+ * @size:	size of platform specific data
+ *
+ * Returns: pointer to platform device on success, an error otherwise
+ */
+struct platform_device *ras2_add_platform_device(char *name, const void *data,
+						 size_t size)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(name, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return NULL;
+
+	ret = platform_device_add_data(pdev, data, size);
+	if (ret)
+		goto dev_put;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto dev_put;
+
+	return pdev;
+
+dev_put:
+	platform_device_put(pdev);
+
+	return ERR_PTR(ret);
+}
diff --git a/include/acpi/ras2_acpi.h b/include/acpi/ras2_acpi.h
new file mode 100644
index 000000000000..5e9ac788670a
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
+#include <linux/mailbox_controller.h>
+#include <linux/types.h>
+#include <acpi/pcc.h>
+
+#define RAS2_PCC_CMD_COMPLETE 1
+
+/* RAS2 specific PCC commands */
+#define RAS2_PCC_CMD_EXEC 0x01
+
+#define RAS2_FAILURE 0
+#define RAS2_SUCCESS 1
+
+/*
+ * Arbitrary Retries for PCC commands because the
+ * remote processor could be much slower to reply.
+ */
+#define RAS2_NUM_RETRIES 600
+
+/*
+ * Data structures for PCC communication and RAS2 table
+ */
+struct ras2_context {
+	struct device *dev;
+	int id;
+	struct mbox_client mbox_client;
+	struct pcc_mbox_chan *pcc_chan;
+	void __iomem *pcc_comm_addr;
+	u64 comm_base_addr;
+	int pcc_subspace_idx;
+	bool pcc_channel_acquired;
+	ktime_t deadline;
+	unsigned int pcc_mpar;
+	unsigned int pcc_mrtt;
+	/* Lock to provide mutually exclusive access to PCC channel */
+	spinlock_t spinlock;
+	struct device *scrub_dev;
+	const struct ras2_hw_scrub_ops *ops;
+};
+
+struct platform_device *ras2_add_platform_device(char *name, const void *data,
+						 size_t size);
+int ras2_send_pcc_cmd(struct ras2_context *ras2_ctx, u16 cmd);
+int ras2_register_pcc_channel(struct ras2_context *ras2_ctx);
+int ras2_unregister_pcc_channel(struct ras2_context *ras2_ctx);
+#endif /* _RAS2_ACPI_H */
-- 
2.34.1


