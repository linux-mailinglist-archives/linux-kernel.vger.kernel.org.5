Return-Path: <linux-kernel+bounces-66766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2598B856149
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CE81C219D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5312C12F5B9;
	Thu, 15 Feb 2024 11:15:23 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5F12EBE9;
	Thu, 15 Feb 2024 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995721; cv=none; b=TiDxYqg8uY9RJtUgzg84NNYrhngalolGgJD+724GIG9szBXRhEyCu4smvCCqDfouKWOIH4SMcKlw/flFyBXF6CCn4mNSKWoU+cruESKOlVORIFc0s4/mt9KKNEQPeXMnU/yV5S947uJh0MBNFS3eByZG1P7j23227eeh8u4BgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995721; c=relaxed/simple;
	bh=UButGjxJwhYtiOQIFVRUYY73VvluAiDWbFyYZpSpE3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmUnxK6MBJQI+VxO+WbHMhWT1mWXgwjp10xhLx3HKRlU09DN+RSLb6nAC+fxqQGhMifOLqtFdWwsdDL6uAPAi4WfYZiX+ATAPyupyf/5vew0nQ9A5bJ8uX5zFWjXTiXQDQyQFW2PsWGcjZ/GqfIxaF35Zja7Ee14Rd3/btJnurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbC784fS3z67mcQ;
	Thu, 15 Feb 2024 19:11:32 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 90E45140B55;
	Thu, 15 Feb 2024 19:15:16 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:15:15 +0000
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
Subject: [RFC PATCH v6 12/12] memory: RAS2: Add memory RAS2 driver
Date: Thu, 15 Feb 2024 19:14:54 +0800
Message-ID: <20240215111455.1462-13-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240215111455.1462-1-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Memory RAS2 driver binds to the platform device add by the ACPI RAS2
driver.
Driver registers the PCC channel for communicating with the ACPI compliant
platform that contains RAS2 command support in the hardware.

Add interface functions to support configuring the parameters of HW patrol
scrubs in the system, which exposed to the kernel via the RAS2 and PCC,
using the RAS2 commands.

Add support for RAS2 platform devices to register with scrub subsystem
driver. This enables user to configure the parameters of HW patrol scrubs,
which exposed to the kernel via the RAS2 table, through the scrub sysfs
attributes.

Open Question:
Sysfs scrub control attribute "enable_background_scrub" is added for RAS2,
based on the feedback from Bill Schwartz <wschwartz@amperecomputing.com
on v4 to enable/disable the background_scrubbing in the platform as defined in the
“Configure Scrub Parameters [INPUT]“ field  in RAS2 Table 5.87: Parameter Block
Structure for PATROL_SCRUB.
Is it a right approach to support "enable_background_scrub" in the sysfs
scrub control?

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/memory/Kconfig       |  14 ++
 drivers/memory/Makefile      |   2 +
 drivers/memory/ras2.c        | 354 +++++++++++++++++++++++++++++++++++
 drivers/memory/rasf_common.c | 269 ++++++++++++++++++++++++++
 include/memory/rasf.h        |  88 +++++++++
 5 files changed, 727 insertions(+)
 create mode 100644 drivers/memory/ras2.c
 create mode 100644 drivers/memory/rasf_common.c
 create mode 100755 include/memory/rasf.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index d2e015c09d83..5fff18fcd3e2 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -225,6 +225,20 @@ config STM32_FMC2_EBI
 	  devices (like SRAM, ethernet adapters, FPGAs, LCD displays, ...) on
 	  SOCs containing the FMC2 External Bus Interface.
 
+config MEM_RASF
+	bool "Memory RASF driver"
+	depends on ACPI_RASF
+	depends on SCRUB
+	help
+	  The driver bound to the platform device added by the ACPI RAS2
+	  driver. Driver registers the PCC channel for communicating with
+	  the ACPI compliant platform that contains RAS2 command support
+	  in the hardware.
+	  Registers with the scrub configure driver to provide sysfs interfaces
+	  for configuring the hw patrol scrubber in the system, which exposed
+	  via the ACPI RAS2 table and PCC. Provides the interface functions
+	  support configuring the HW patrol scrubbers in the system.
+
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
 source "drivers/memory/scrub/Kconfig"
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 4b37312cb342..4bd7653e1dce 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_DDR)		+= jedec_ddr_data.o
 ifeq ($(CONFIG_DDR),y)
 obj-$(CONFIG_OF)		+= of_memory.o
 endif
+obj-$(CONFIG_MEM_RASF)		+= rasf_common.o ras2.o
+
 obj-$(CONFIG_ARM_PL172_MPMC)	+= pl172.o
 obj-$(CONFIG_ATMEL_EBI)		+= atmel-ebi.o
 obj-$(CONFIG_BRCMSTB_DPFE)	+= brcmstb_dpfe.o
diff --git a/drivers/memory/ras2.c b/drivers/memory/ras2.c
new file mode 100644
index 000000000000..046e4ae7eaf0
--- /dev/null
+++ b/drivers/memory/ras2.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ras2.c - ACPI RAS2 memory driver
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ *
+ *  - Registers the PCC channel for communicating with the
+ *    ACPI compliant platform that contains RAS2 command
+ *    support in the hardware.
+ *  - Provides functions to configure HW patrol scrubs
+ *    in the system.
+ *  - Registers with the scrub configure driver for the
+ *    hw patrol scrub in the system, which exposed via
+ *    the ACPI RAS2 table and PCC.
+ */
+
+#define pr_fmt(fmt)	"MEMORY RAS2: " fmt
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/cleanup.h>
+
+#include <acpi/rasf_acpi.h>
+#include <memory/rasf.h>
+
+/* RAS2 specific definitions. */
+#define RAS2_SCRUB	"ras2_scrub"
+#define RAS2_ID_FORMAT RAS2_SCRUB "%d"
+#define RAS2_SUPPORT_HW_PARTOL_SCRUB	BIT(0)
+#define RAS2_TYPE_PATROL_SCRUB	0x0000
+
+#define RAS2_GET_PATROL_PARAMETERS	0x01
+#define	RAS2_START_PATROL_SCRUBBER	0x02
+#define	RAS2_STOP_PATROL_SCRUBBER	0x03
+
+#define RAS2_PATROL_SCRUB_RATE_VALID	BIT(0)
+#define RAS2_PATROL_SCRUB_RATE_IN_MASK	GENMASK(15, 8)
+#define RAS2_PATROL_SCRUB_EN_BACKGROUND	BIT(0)
+#define RAS2_PATROL_SCRUB_RATE_OUT_MASK	GENMASK(7, 0)
+#define RAS2_PATROL_SCRUB_MIN_RATE_OUT_MASK	GENMASK(15, 8)
+#define RAS2_PATROL_SCRUB_MAX_RATE_OUT_MASK	GENMASK(23, 16)
+
+static void ras2_tx_done(struct mbox_client *cl, void *msg, int ret)
+{
+	if (ret) {
+		dev_dbg(cl->dev, "TX did not complete: CMD sent:%x, ret:%d\n",
+			*(u16 *)msg, ret);
+	} else {
+		dev_dbg(cl->dev, "TX completed. CMD sent:%x, ret:%d\n",
+			*(u16 *)msg, ret);
+	}
+}
+
+/*
+ * The below functions are exposed to OSPM, to query, configure and
+ * initiate memory patrol scrub.
+ */
+static int ras2_is_patrol_scrub_support(struct rasf_context *ras2_ctx)
+{
+	int ret;
+	struct acpi_ras2_shared_memory  __iomem *generic_comm_base;
+
+	if (!ras2_ctx || !ras2_ctx->pcc_comm_addr)
+		return -EFAULT;
+
+	generic_comm_base = ras2_ctx->pcc_comm_addr;
+	guard(spinlock_irqsave)(&ras2_ctx->spinlock);
+	generic_comm_base->set_capabilities[0] = 0;
+
+	/* send command for reading RAS2 capabilities */
+	ret = rasf_send_pcc_cmd(ras2_ctx, RASF_PCC_CMD_EXEC);
+	if (ret) {
+		pr_err("%s: rasf_send_pcc_cmd failed\n", __func__);
+		return ret;
+	}
+
+	return generic_comm_base->features[0] & RAS2_SUPPORT_HW_PARTOL_SCRUB;
+}
+
+static int ras2_get_patrol_scrub_params(struct rasf_context *ras2_ctx,
+					struct rasf_scrub_params *params)
+{
+	int ret = 0;
+	u8  min_supp_scrub_rate, max_supp_scrub_rate;
+	struct acpi_ras2_shared_memory  __iomem *generic_comm_base;
+	struct acpi_ras2_patrol_scrub_parameter __iomem *patrol_scrub_params;
+
+	if (!ras2_ctx || !ras2_ctx->pcc_comm_addr)
+		return -EFAULT;
+
+	generic_comm_base = ras2_ctx->pcc_comm_addr;
+	patrol_scrub_params = ras2_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
+
+	guard(spinlock_irqsave)(&ras2_ctx->spinlock);
+	generic_comm_base->set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	/* send command for reading RASF capabilities */
+	ret = rasf_send_pcc_cmd(ras2_ctx, RASF_PCC_CMD_EXEC);
+	if (ret) {
+		pr_err("%s: rasf_send_pcc_cmd failed\n", __func__);
+		return ret;
+	}
+
+	if (!(generic_comm_base->features[0] & RAS2_SUPPORT_HW_PARTOL_SCRUB) ||
+	    !(generic_comm_base->num_parameter_blocks)) {
+		pr_err("%s: Platform does not support HW Patrol Scrubber\n", __func__);
+		return -ENOTSUPP;
+	}
+
+	if (!patrol_scrub_params->requested_address_range[1]) {
+		pr_err("%s: Invalid requested address range, \
+			requested_address_range[0]=0x%llx \
+			requested_address_range[1]=0x%llx\n",
+			__func__,
+			patrol_scrub_params->requested_address_range[0],
+			patrol_scrub_params->requested_address_range[1]);
+		return -ENOTSUPP;
+	}
+
+	generic_comm_base->set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	patrol_scrub_params->header.type = RAS2_TYPE_PATROL_SCRUB;
+	patrol_scrub_params->patrol_scrub_command = RAS2_GET_PATROL_PARAMETERS;
+
+	/* send command for reading the HW patrol scrub parameters */
+	ret = rasf_send_pcc_cmd(ras2_ctx, RASF_PCC_CMD_EXEC);
+	if (ret) {
+		pr_err("%s: failed to read HW patrol scrub parameters\n", __func__);
+		return ret;
+	}
+
+	/* copy output scrub parameters */
+	params->addr_base = patrol_scrub_params->actual_address_range[0];
+	params->addr_size = patrol_scrub_params->actual_address_range[1];
+	params->flags = patrol_scrub_params->flags;
+	params->rate = FIELD_GET(RAS2_PATROL_SCRUB_RATE_OUT_MASK,
+				 patrol_scrub_params->scrub_params_out);
+	min_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MIN_RATE_OUT_MASK,
+					patrol_scrub_params->scrub_params_out);
+	max_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MAX_RATE_OUT_MASK,
+					patrol_scrub_params->scrub_params_out);
+	snprintf(params->rate_avail, RASF_MAX_RATE_RANGE_LENGTH,
+		 "%d-%d", min_supp_scrub_rate, max_supp_scrub_rate);
+
+	return 0;
+}
+
+static int ras2_enable_patrol_scrub(struct rasf_context *ras2_ctx, bool enable)
+{
+	int ret = 0;
+	struct rasf_scrub_params params;
+	struct acpi_ras2_shared_memory  __iomem *generic_comm_base;
+	u8 scrub_rate_to_set, min_supp_scrub_rate, max_supp_scrub_rate;
+	struct acpi_ras2_patrol_scrub_parameter __iomem *patrol_scrub_params;
+
+	if (!ras2_ctx || !ras2_ctx->pcc_comm_addr)
+		return -EFAULT;
+
+	generic_comm_base = ras2_ctx->pcc_comm_addr;
+	patrol_scrub_params = ras2_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
+
+	if (enable) {
+		ret = ras2_get_patrol_scrub_params(ras2_ctx, &params);
+		if (ret)
+			return ret;
+	}
+
+	guard(spinlock_irqsave)(&ras2_ctx->spinlock);
+	generic_comm_base->set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	patrol_scrub_params->header.type = RAS2_TYPE_PATROL_SCRUB;
+
+	if (enable) {
+		patrol_scrub_params->patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
+		patrol_scrub_params->requested_address_range[0] = params.addr_base;
+		patrol_scrub_params->requested_address_range[1] = params.addr_size;
+
+		scrub_rate_to_set = FIELD_GET(RAS2_PATROL_SCRUB_RATE_IN_MASK,
+					      patrol_scrub_params->scrub_params_in);
+		min_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MIN_RATE_OUT_MASK,
+						patrol_scrub_params->scrub_params_out);
+		max_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MAX_RATE_OUT_MASK,
+						patrol_scrub_params->scrub_params_out);
+		if (scrub_rate_to_set < min_supp_scrub_rate ||
+		    scrub_rate_to_set > max_supp_scrub_rate) {
+			pr_warn("patrol scrub rate to set is out of the supported range\n");
+			pr_warn("min_supp_scrub_rate=%d max_supp_scrub_rate=%d\n",
+				 min_supp_scrub_rate, max_supp_scrub_rate);
+			return -EINVAL;
+		}
+	} else {
+		patrol_scrub_params->patrol_scrub_command = RAS2_STOP_PATROL_SCRUBBER;
+	}
+
+	/* send command for enable/disable HW patrol scrub */
+	ret = rasf_send_pcc_cmd(ras2_ctx, RASF_PCC_CMD_EXEC);
+	if (ret) {
+		pr_err("%s: failed to enable/disable the HW patrol scrub\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ras2_enable_background_scrub(struct rasf_context *ras2_ctx, bool enable)
+{
+	int ret;
+	struct acpi_ras2_shared_memory  __iomem *generic_comm_base;
+	struct acpi_ras2_patrol_scrub_parameter __iomem *patrol_scrub_params;
+
+	if (!ras2_ctx || !ras2_ctx->pcc_comm_addr)
+		return -EFAULT;
+
+	generic_comm_base = ras2_ctx->pcc_comm_addr;
+	patrol_scrub_params = ras2_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
+
+	guard(spinlock_irqsave)(&ras2_ctx->spinlock);
+	generic_comm_base->set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
+	patrol_scrub_params->header.type = RAS2_TYPE_PATROL_SCRUB;
+	patrol_scrub_params->patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
+
+	patrol_scrub_params->scrub_params_in &= ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
+	patrol_scrub_params->scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_EN_BACKGROUND,
+							   enable);
+
+	/* send command for enable/disable HW patrol scrub */
+	ret = rasf_send_pcc_cmd(ras2_ctx, RASF_PCC_CMD_EXEC);
+	if (ret) {
+		pr_err("%s: failed to enable/disable background patrol scrubbing\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+static int ras2_set_patrol_scrub_params(struct rasf_context *ras2_ctx,
+					struct rasf_scrub_params *params, u8 param_type)
+{
+	struct acpi_ras2_shared_memory  __iomem *generic_comm_base;
+	struct acpi_ras2_patrol_scrub_parameter __iomem *patrol_scrub_params;
+
+	if (!ras2_ctx || !ras2_ctx->pcc_comm_addr)
+		return -EFAULT;
+
+	generic_comm_base = ras2_ctx->pcc_comm_addr;
+	patrol_scrub_params = ras2_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
+
+	guard(spinlock_irqsave)(&ras2_ctx->spinlock);
+	patrol_scrub_params->header.type = RAS2_TYPE_PATROL_SCRUB;
+	if (param_type == RASF_MEM_SCRUB_PARAM_ADDR_BASE && params->addr_base) {
+		patrol_scrub_params->requested_address_range[0] = params->addr_base;
+	} else if (param_type == RASF_MEM_SCRUB_PARAM_ADDR_SIZE && params->addr_size) {
+		patrol_scrub_params->requested_address_range[1] = params->addr_size;
+	} else if (param_type == RASF_MEM_SCRUB_PARAM_RATE) {
+		patrol_scrub_params->scrub_params_in &= ~RAS2_PATROL_SCRUB_RATE_IN_MASK;
+		patrol_scrub_params->scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_RATE_IN_MASK,
+								   params->rate);
+	} else {
+		pr_err("Invalid patrol scrub parameter to set\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct rasf_hw_scrub_ops ras2_hw_ops = {
+	.enable_scrub = ras2_enable_patrol_scrub,
+	.enable_background_scrub = ras2_enable_background_scrub,
+	.get_scrub_params = ras2_get_patrol_scrub_params,
+	.set_scrub_params = ras2_set_patrol_scrub_params,
+};
+
+static const struct scrub_ops ras2_scrub_ops = {
+	.is_visible = rasf_hw_scrub_is_visible,
+	.read = rasf_hw_scrub_read,
+	.write = rasf_hw_scrub_write,
+	.read_string = rasf_hw_scrub_read_strings,
+};
+
+static DEFINE_IDA(ras2_ida);
+
+static void devm_ras2_release(void *ctx)
+{
+	struct rasf_context *ras2_ctx = ctx;
+
+	ida_free(&ras2_ida, ras2_ctx->id);
+	rasf_unregister_pcc_channel(ras2_ctx);
+}
+
+static int ras2_probe(struct platform_device *pdev)
+{
+	int ret, id;
+	struct mbox_client *cl;
+	struct device *hw_scrub_dev;
+	struct rasf_context *ras2_ctx;
+	char scrub_name[RASF_MAX_NAME_LENGTH];
+
+	ras2_ctx = devm_kzalloc(&pdev->dev, sizeof(*ras2_ctx), GFP_KERNEL);
+	if (!ras2_ctx)
+		return -ENOMEM;
+
+	ras2_ctx->dev = &pdev->dev;
+	ras2_ctx->ops = &ras2_hw_ops;
+	spin_lock_init(&ras2_ctx->spinlock);
+	platform_set_drvdata(pdev, ras2_ctx);
+
+	cl = &ras2_ctx->mbox_client;
+	/* Request mailbox channel */
+	cl->dev = &pdev->dev;
+	cl->tx_done = ras2_tx_done;
+	cl->knows_txdone = true;
+	ras2_ctx->pcc_subspace_idx = *((int *)pdev->dev.platform_data);
+	dev_dbg(&pdev->dev, "pcc-subspace-id=%d\n", ras2_ctx->pcc_subspace_idx);
+	ret = rasf_register_pcc_channel(ras2_ctx);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, devm_ras2_release, ras2_ctx);
+	if (ret < 0)
+		return ret;
+
+	if (ras2_is_patrol_scrub_support(ras2_ctx)) {
+		id = ida_alloc(&ras2_ida, GFP_KERNEL);
+		if (id < 0)
+			return id;
+		ras2_ctx->id = id;
+		snprintf(scrub_name, sizeof(scrub_name), "%s%d", RAS2_SCRUB, id);
+		dev_set_name(&pdev->dev, RAS2_ID_FORMAT, id);
+		hw_scrub_dev = devm_scrub_device_register(&pdev->dev, scrub_name,
+							  ras2_ctx, &ras2_scrub_ops,
+							  0, NULL);
+		if (PTR_ERR_OR_ZERO(hw_scrub_dev))
+			return PTR_ERR_OR_ZERO(hw_scrub_dev);
+	}
+	ras2_ctx->scrub_dev = hw_scrub_dev;
+
+	return 0;
+}
+
+static const struct platform_device_id ras2_id_table[] = {
+	{ .name = "ras2", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ras2_id_table);
+
+static struct platform_driver ras2_driver = {
+	.probe = ras2_probe,
+	.driver = {
+		.name = "ras2",
+		.suppress_bind_attrs = true,
+	},
+	.id_table = ras2_id_table,
+};
+module_driver(ras2_driver, platform_driver_register, platform_driver_unregister);
+
+MODULE_DESCRIPTION("ras2 memory driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/memory/rasf_common.c b/drivers/memory/rasf_common.c
new file mode 100644
index 000000000000..85f67308698d
--- /dev/null
+++ b/drivers/memory/rasf_common.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * rasf_common.c - Common functions for memory RASF driver
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ *
+ * This driver implements call back functions for the scrub
+ * configure driver to configure the parameters of the hw patrol
+ * scrubbers in the system, which exposed via the ACPI RASF/RAS2
+ * table and PCC.
+ */
+
+#define pr_fmt(fmt)     "MEMORY RASF COMMON: " fmt
+
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <acpi/rasf_acpi.h>
+#include <memory/rasf.h>
+
+static int enable_write(struct rasf_context *rasf_ctx, long val)
+{
+	int ret;
+	bool enable = val;
+
+	ret = rasf_ctx->ops->enable_scrub(rasf_ctx, enable);
+	if (ret) {
+		pr_err("enable patrol scrub fail, enable=%d ret=%d\n",
+		       enable, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int enable_background_scrub_write(struct rasf_context *rasf_ctx, long val)
+{
+	int ret;
+	bool enable = val;
+
+	ret = rasf_ctx->ops->enable_background_scrub(rasf_ctx, enable);
+	if (ret) {
+		pr_err("enable background patrol scrub fail, enable=%d ret=%d\n",
+		       enable, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int addr_base_read(struct rasf_context *rasf_ctx, u64 *val)
+{
+	int ret;
+	struct rasf_scrub_params params;
+
+	ret = rasf_ctx->ops->get_scrub_params(rasf_ctx, &params);
+	if (ret) {
+		pr_err("get patrol scrub params fail ret=%d\n", ret);
+		return ret;
+	}
+	*val = params.addr_base;
+
+	return 0;
+}
+
+static int addr_base_write(struct rasf_context *rasf_ctx, u64 val)
+{
+	int ret;
+	struct rasf_scrub_params params;
+
+	params.addr_base = val;
+	ret = rasf_ctx->ops->set_scrub_params(rasf_ctx, &params, RASF_MEM_SCRUB_PARAM_ADDR_BASE);
+	if (ret) {
+		pr_err("set patrol scrub params for addr_base fail ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int addr_size_read(struct rasf_context *rasf_ctx, u64 *val)
+{
+	int ret;
+	struct rasf_scrub_params params;
+
+	ret = rasf_ctx->ops->get_scrub_params(rasf_ctx, &params);
+	if (ret) {
+		pr_err("get patrol scrub params fail ret=%d\n", ret);
+		return ret;
+	}
+	*val = params.addr_size;
+
+	return 0;
+}
+
+static int addr_size_write(struct rasf_context *rasf_ctx, u64 val)
+{
+	int ret;
+	struct rasf_scrub_params params;
+
+	params.addr_size = val;
+	ret = rasf_ctx->ops->set_scrub_params(rasf_ctx, &params, RASF_MEM_SCRUB_PARAM_ADDR_SIZE);
+	if (ret) {
+		pr_err("set patrol scrub params for addr_size fail ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rate_read(struct  rasf_context *rasf_ctx, u64 *val)
+{
+	int ret;
+	struct rasf_scrub_params params;
+
+	ret = rasf_ctx->ops->get_scrub_params(rasf_ctx, &params);
+	if (ret) {
+		pr_err("get patrol scrub params fail ret=%d\n", ret);
+		return ret;
+	}
+	*val = params.rate;
+
+	return 0;
+}
+
+static int rate_write(struct rasf_context *rasf_ctx, long val)
+{
+	int ret;
+	struct rasf_scrub_params params;
+
+	params.rate = val;
+	ret = rasf_ctx->ops->set_scrub_params(rasf_ctx, &params, RASF_MEM_SCRUB_PARAM_RATE);
+	if (ret) {
+		pr_err("set patrol scrub params for rate fail ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rate_available_read(struct rasf_context *rasf_ctx, char *buf)
+{
+	int ret;
+	struct rasf_scrub_params params;
+
+	ret = rasf_ctx->ops->get_scrub_params(rasf_ctx, &params);
+	if (ret) {
+		pr_err("get patrol scrub params fail ret=%d\n", ret);
+		return ret;
+	}
+
+	sprintf(buf, "%s\n", params.rate_avail);
+
+	return 0;
+}
+
+/**
+ * rasf_hw_scrub_is_visible() - Callback to return attribute visibility
+ * @drv_data: Pointer to driver-private data structure passed
+ *	      as argument to devm_scrub_device_register().
+ * @attr_id: Scrub attribute
+ * @region_id: ID of the memory region
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+umode_t rasf_hw_scrub_is_visible(struct device *dev, u32 attr_id, int region_id)
+{
+	switch (attr_id) {
+	case scrub_rate_available:
+		return 0444;
+	case scrub_enable:
+	case scrub_enable_background_scrub:
+		return 0200;
+	case scrub_addr_base:
+	case scrub_addr_size:
+	case scrub_rate:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * rasf_hw_scrub_read() - Read callback for data attributes
+ * @device: Pointer to scrub device
+ * @attr_id: Scrub attribute
+ * @region_id: ID of the memory region
+ * @val: Pointer to the returned data
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int rasf_hw_scrub_read(struct device *device, u32 attr_id, int region_id, u64 *val)
+{
+	struct rasf_context *rasf_ctx;
+
+	rasf_ctx = dev_get_drvdata(device);
+
+	switch (attr_id) {
+	case scrub_addr_base:
+		return addr_base_read(rasf_ctx, val);
+	case scrub_addr_size:
+		return addr_size_read(rasf_ctx, val);
+	case scrub_rate:
+		return rate_read(rasf_ctx, val);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+/**
+ * rasf_hw_scrub_write() - Write callback for data attributes
+ * @device: Pointer to scrub device
+ * @attr_id: Scrub attribute
+ * @region_id: ID of the memory region
+ * @val: Value to write
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int rasf_hw_scrub_write(struct device *device, u32 attr_id, int region_id, u64 val)
+{
+	struct rasf_context *rasf_ctx;
+
+	rasf_ctx = dev_get_drvdata(device);
+
+	switch (attr_id) {
+	case scrub_addr_base:
+		return addr_base_write(rasf_ctx, val);
+	case scrub_addr_size:
+		return addr_size_write(rasf_ctx, val);
+	case scrub_enable:
+		return enable_write(rasf_ctx, val);
+	case scrub_enable_background_scrub:
+		return enable_background_scrub_write(rasf_ctx, val);
+	case scrub_rate:
+		return rate_write(rasf_ctx, val);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+/**
+ * rasf_hw_scrub_read_strings() - Read callback for string attributes
+ * @device: Pointer to scrub device
+ * @attr_id: Scrub attribute
+ * @region_id: ID of the memory region
+ * @buf: Pointer to the buffer for copying returned string
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int rasf_hw_scrub_read_strings(struct device *device, u32 attr_id, int region_id,
+			       char *buf)
+{
+	struct rasf_context *rasf_ctx;
+
+	rasf_ctx = dev_get_drvdata(device);
+
+	switch (attr_id) {
+	case scrub_rate_available:
+		return rate_available_read(rasf_ctx, buf);
+	default:
+		return -ENOTSUPP;
+	}
+}
diff --git a/include/memory/rasf.h b/include/memory/rasf.h
new file mode 100755
index 000000000000..aacfa84dcc6f
--- /dev/null
+++ b/include/memory/rasf.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Memory RASF driver header file
+ *
+ * Copyright (c) 2023 HiSilicon Limited
+ */
+
+#ifndef _RASF_H
+#define _RASF_H
+
+#include <memory/memory-scrub.h>
+
+#define RASF_MAX_NAME_LENGTH      64
+#define RASF_MAX_RATE_RANGE_LENGTH      64
+
+/*
+ * Data structures RASF
+ */
+
+/**
+ * struct rasf_scrub_params- RASF scrub parameter data structure.
+ * @addr_base:	[IN] Base address of the address range to be patrol scrubbed.
+ *		[OUT] Base address of the actual address range.
+ * @addr_size:	[IN] Size of the address range to be patrol scrubbed.
+ *		[OUT] Size of the actual address range.
+ * @flags:	[OUT] The platform returns this value in response to
+ *		GET_PATROL_PARAMETERS.
+ *		For RASF and RAS2:
+ *		Bit [0]: Will be set if memory scrubber is already
+ *		running for address range specified in “Actual Address Range”.
+ *		For RASF:
+ *		Bits [3:1]: Current Patrol rate, if Bit [0] is set.
+ * @rate:	[IN] Requested patrol scrub rate.
+ *		[OUT] Current patrol scrub rate.
+ * @rate_avail:[OUT] Supported patrol rates.
+ */
+struct rasf_scrub_params {
+	u64 addr_base;
+	u64 addr_size;
+	u16 flags;
+	u32 rate;
+	char rate_avail[RASF_MAX_RATE_RANGE_LENGTH];
+};
+
+enum {
+	RASF_MEM_SCRUB_PARAM_ADDR_BASE = 0,
+	RASF_MEM_SCRUB_PARAM_ADDR_SIZE,
+	RASF_MEM_SCRUB_PARAM_RATE,
+};
+
+/**
+ * struct rasf_hw_scrub_ops - rasf hw scrub device operations
+ * @enable_scrub: Function to enable/disable RASF/RAS2 scrubber.
+ *		Parameters are:
+ *		@rasf_ctx: Pointer to RASF/RAS2 context structure.
+ *		@enable: enable/disable RASF/RAS2 patrol scrubber.
+ *		The function returns 0 on success or a negative error number.
+ * @enable_background_scrub: Function to enable/disable background scrubbing.
+ *		Parameters are:
+ *		@rasf_ctx: Pointer to RASF/RAS2 context structure.
+ *		@enable: enable/disable background patrol scrubbing.
+ *		The function returns 0 on success or a negative error number.
+ * @get_scrub_params:	Read scrubber parameters. Mandatory
+ *		Parameters are:
+ *		@rasf_ctx: Pointer to RASF/RAS2 context structure.
+ *		@params: Pointer to scrub params data structure.
+ *		The function returns 0 on success or a negative error number.
+ * @set_scrub_params: Set scrubber parameters. Mandatory.
+ *		Parameters are:
+ *		@rasf_ctx: Pointer to RASF/RAS2 context structure.
+ *		@params: Pointer to scrub params data structure.
+ *		@param_type: Scrub parameter type to set.
+ *		The function returns 0 on success or a negative error number.
+ */
+struct rasf_hw_scrub_ops {
+	int (*enable_scrub)(struct rasf_context *rasf_ctx, bool enable);
+	int (*enable_background_scrub)(struct rasf_context *rasf_ctx, bool enable);
+	int (*get_scrub_params)(struct rasf_context *rasf_ctx,
+				struct rasf_scrub_params *params);
+	int (*set_scrub_params)(struct rasf_context *rasf_ctx,
+				struct rasf_scrub_params *params, u8 param_type);
+};
+
+umode_t rasf_hw_scrub_is_visible(struct device *dev, u32 attr_id, int region_id);
+int rasf_hw_scrub_read(struct device *dev, u32 attr_id, int region_id, u64 *val);
+int rasf_hw_scrub_write(struct device *dev, u32 attr_id, int region_id, u64 val);
+int rasf_hw_scrub_read_strings(struct device *dev, u32 attr_id, int region_id, char *buf);
+#endif /* _RASF_H */
-- 
2.34.1


