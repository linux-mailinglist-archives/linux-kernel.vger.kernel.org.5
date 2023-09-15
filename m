Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25397A24CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbjIORaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbjIOR3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:29:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1C1BF2;
        Fri, 15 Sep 2023 10:29:09 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLkg1TSqz6K6Qn;
        Sat, 16 Sep 2023 01:28:27 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:29:06 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <dave.hansen@linux.intel.com>, <david@redhat.com>,
        <jiaqiyan@google.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <rientjes@google.com>, <duenwen@google.com>,
        <Vilas.Sridharan@amd.com>, <mike.malvestuto@intel.com>,
        <gthelen@google.com>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
        <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 6/9] memory: RASF: Add memory RASF driver
Date:   Sat, 16 Sep 2023 01:28:15 +0800
Message-ID: <20230915172818.761-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230915172818.761-1-shiju.jose@huawei.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Memory RASF driver binds to the platform device add by the ACPI RASF
driver.

Driver registers the PCC channel for communicating with the ACPI compliant
platform that contains RASF command support in the hardware.

Add interface functions to support configuring the parameters of HW patrol
scrubber in the system, which exposed to the kernel via the RASF and PCC,
using the RASF commands.

Add support for RASF scrub devices to register with scrub driver.
This enables user to configure the parameters of HW patrol scrubbers,
which exposed to the kernel via the RASF table, using the scrub sysfs
attributes.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/memory/Kconfig       |  14 ++
 drivers/memory/Makefile      |   2 +
 drivers/memory/rasf.c        | 335 +++++++++++++++++++++++++++++++++++
 drivers/memory/rasf_common.c | 251 ++++++++++++++++++++++++++
 include/memory/rasf.h        |  82 +++++++++
 5 files changed, 684 insertions(+)
 create mode 100644 drivers/memory/rasf.c
 create mode 100644 drivers/memory/rasf_common.c
 create mode 100755 include/memory/rasf.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index d2e015c09d83..b831e76fcdbf 100644
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
+	  The driver bound to the platform device added by the ACPI RASF
+	  driver. Driver registers the PCC channel for communicating with
+	  the ACPI compliant platform that contains RASF/RAS2 command support
+	  in the hardware.
+	  Registers with the scrub configure driver to provide sysfs interfaces
+	  for configuring the hw patrol scrubber in the system, which exposed
+	  via the ACPI RASF/RAS2 table and PCC. Provides the interface functions
+	  support configuring the HW patrol scrubbers in the system.
+
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
 source "drivers/memory/scrub/Kconfig"
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 4b37312cb342..49340cd100fc 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_DDR)		+= jedec_ddr_data.o
 ifeq ($(CONFIG_DDR),y)
 obj-$(CONFIG_OF)		+= of_memory.o
 endif
+obj-$(CONFIG_MEM_RASF)		+= rasf_common.o rasf.o
+
 obj-$(CONFIG_ARM_PL172_MPMC)	+= pl172.o
 obj-$(CONFIG_ATMEL_EBI)		+= atmel-ebi.o
 obj-$(CONFIG_BRCMSTB_DPFE)	+= brcmstb_dpfe.o
diff --git a/drivers/memory/rasf.c b/drivers/memory/rasf.c
new file mode 100644
index 000000000000..b33024c0ed15
--- /dev/null
+++ b/drivers/memory/rasf.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * rasf.c - Memory RASF Driver
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ *
+ * This driver:
+ *  - Registers the PCC channel for communicating with the
+ *    ACPI compliant platform that contains RASF command
+ *    support in the hardware.
+ *  - Provides functions to configure HW patrol scrubber
+ *    in the system.
+ *  - Registers with the scrub configure driver for the
+ *    hw patrol scrubber in the system, which exposed via
+ *    the ACPI RASF table and PCC.
+ */
+
+#define pr_fmt(fmt)     "MEMORY RASF: " fmt
+
+#include <linux/cleanup.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <acpi/rasf_acpi.h>
+#include <memory/rasf.h>
+
+/* RASF specific definitions. */
+#define RASF_SCRUB	"rasf_scrub"
+#define RASF_SUPPORT_HW_PARTOL_SCRUB		BIT(0)
+#define RASF_EXPOSE_HW_PARTOL_SCRUB_TO_SW	BIT(1)
+
+#define RASF_TYPE_PATROL_SCRUB	0x0000
+
+#define RASF_GET_PATROL_PARAMETERS	0x01
+#define	RASF_START_PATROL_SCRUBBER	0x02
+#define	RASF_STOP_PATROL_SCRUBBER	0x03
+
+#define RASF_PATROL_SCRUB_RATE_VALID	BIT(0)
+#define RASF_PATROL_SCRUB_SPEED_MASK	GENMASK(3, 1)
+#define RASF_PATROL_SCRUB_SLOW	0x0
+#define RASF_PATROL_SCRUB_MEDIUM	0x4
+#define	RASF_PATROL_SCRUB_FAST	0x7
+
+/*
+ * The number of regions may not be relavent for RASF
+ */
+#define RASF_NUM_REGIONS        1
+
+#define to_rasf_ctx(cl)		\
+	container_of(cl, struct rasf_context, mbox_client)
+
+static void rasf_tx_done(struct mbox_client *cl, void *msg, int ret)
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
+ * initiate memory patrol scrubber.
+ */
+static int rasf_is_patrol_scrub_support(struct rasf_context *rasf_ctx)
+{
+	int ret;
+	struct acpi_rasf_shared_memory  __iomem *generic_comm_base;
+
+	if (!rasf_ctx || !rasf_ctx->pcc_comm_addr)
+		return -EFAULT;
+
+	generic_comm_base = rasf_ctx->pcc_comm_addr;
+	guard(spinlock_irqsave)(&rasf_ctx->spinlock);
+	generic_comm_base->set_capabilities[0] = 0;
+
+	/* send command for reading RASF capabilities */
+	ret = rasf_send_pcc_cmd(rasf_ctx, RASF_PCC_CMD_EXEC);
+	if (ret) {
+		pr_err("%s: rasf_send_pcc_cmd failed\n", __func__);
+		return ret;
+	}
+
+	return FIELD_GET(RASF_EXPOSE_HW_PARTOL_SCRUB_TO_SW,
+			  generic_comm_base->capabilities[0]);
+}
+
+static int rasf_get_patrol_scrub_params(struct rasf_context *rasf_ctx,
+					struct rasf_scrub_params *params)
+{
+	int ret = 0;
+	struct acpi_rasf_shared_memory  __iomem *generic_comm_base;
+	struct acpi_rasf_patrol_scrub_parameter __iomem *patrol_scrub_params;
+
+	if (!rasf_ctx || !rasf_ctx->pcc_comm_addr)
+		return -EFAULT;
+
+	generic_comm_base = rasf_ctx->pcc_comm_addr;
+	patrol_scrub_params = rasf_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
+
+	guard(spinlock_irqsave)(&rasf_ctx->spinlock);
+	generic_comm_base->set_capabilities[0] = RASF_EXPOSE_HW_PARTOL_SCRUB_TO_SW;
+
+	/* send command for reading RASF capabilities */
+	ret = rasf_send_pcc_cmd(rasf_ctx, RASF_PCC_CMD_EXEC);
+	if (ret) {
+		pr_err("%s: rasf_send_pcc_cmd failed\n", __func__);
+		return ret;
+	}
+
+	if (!(generic_comm_base->capabilities[0] & RASF_EXPOSE_HW_PARTOL_SCRUB_TO_SW) ||
+	    !(generic_comm_base->num_parameter_blocks)) {
+		pr_err("%s: Platform does not support HW Patrol Scrubber\n", __func__);
+		return -ENOTSUPP;
+	}
+
+	if (!patrol_scrub_params->requested_address_range[1]) {
+		pr_err("%s: Invalid requested address range, \
+			requested_address base=0x%llx \
+			requested_address size=0x%llx\n",
+			__func__,
+			patrol_scrub_params->requested_address_range[0],
+			patrol_scrub_params->requested_address_range[1]);
+		return -ENOTSUPP;
+	}
+
+	generic_comm_base->set_capabilities[0] = RASF_EXPOSE_HW_PARTOL_SCRUB_TO_SW;
+	patrol_scrub_params->header.type = RASF_TYPE_PATROL_SCRUB;
+	patrol_scrub_params->patrol_scrub_command = RASF_GET_PATROL_PARAMETERS;
+
+	/* send command for reading the HW patrol scrub parameters */
+	ret = rasf_send_pcc_cmd(rasf_ctx, RASF_PCC_CMD_EXEC);
+	if (ret) {
+		pr_err("%s: failed to read HW patrol scrub parameters\n", __func__);
+		return ret;
+	}
+
+	/* copy output scrubber parameters */
+	params->addr_base = patrol_scrub_params->actual_address_range[0];
+	params->addr_size = patrol_scrub_params->actual_address_range[1];
+	params->flags = patrol_scrub_params->flags;
+	if (patrol_scrub_params->flags & RASF_PATROL_SCRUB_RATE_VALID) {
+		params->speed = FIELD_GET(RASF_PATROL_SCRUB_SPEED_MASK,
+					  patrol_scrub_params->flags);
+		snprintf(params->speed_avail, RASF_MAX_SPEED_RANGE_LENGTH,
+			"%d,%d,%d", RASF_PATROL_SCRUB_SLOW,
+			RASF_PATROL_SCRUB_MEDIUM, RASF_PATROL_SCRUB_FAST);
+	} else {
+		params->speed = 0;
+		snprintf(params->speed_avail, RASF_MAX_SPEED_RANGE_LENGTH,
+			"%s", "Unavailable");
+	}
+
+	return 0;
+}
+
+static int rasf_enable_patrol_scrub(struct rasf_context *rasf_ctx, bool enable)
+{
+	int ret = 0;
+	struct rasf_scrub_params params;
+	struct acpi_rasf_shared_memory  __iomem *generic_comm_base;
+	struct acpi_rasf_patrol_scrub_parameter __iomem *patrol_scrub_params;
+
+	if (!rasf_ctx || !rasf_ctx->pcc_comm_addr)
+		return -EFAULT;
+
+	generic_comm_base = rasf_ctx->pcc_comm_addr;
+	patrol_scrub_params = rasf_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
+
+	if (enable) {
+		ret = rasf_get_patrol_scrub_params(rasf_ctx, &params);
+		if (ret)
+			return ret;
+	}
+
+	guard(spinlock_irqsave)(&rasf_ctx->spinlock);
+	generic_comm_base->set_capabilities[0] = RASF_EXPOSE_HW_PARTOL_SCRUB_TO_SW;
+	patrol_scrub_params->header.type = RASF_TYPE_PATROL_SCRUB;
+
+	if (enable) {
+		patrol_scrub_params->patrol_scrub_command = RASF_START_PATROL_SCRUBBER;
+		patrol_scrub_params->requested_address_range[0] = params.addr_base;
+		patrol_scrub_params->requested_address_range[1] = params.addr_size;
+		/* requested speed already set in the rasf_set_patrol_scrub_params */
+	} else
+		patrol_scrub_params->patrol_scrub_command = RASF_STOP_PATROL_SCRUBBER;
+
+	/* send command for enable/disable the HW patrol scrub */
+	ret = rasf_send_pcc_cmd(rasf_ctx, RASF_PCC_CMD_EXEC);
+	if (ret) {
+		pr_err("%s: failed to enable/disable the HW patrol scrub\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rasf_set_patrol_scrub_params(struct rasf_context *rasf_ctx,
+					struct rasf_scrub_params *params, u8 param_type)
+{
+	struct acpi_rasf_shared_memory  __iomem *generic_comm_base;
+	struct acpi_rasf_patrol_scrub_parameter __iomem *patrol_scrub_params;
+
+	if (!rasf_ctx || !rasf_ctx->pcc_comm_addr)
+		return -EFAULT;
+
+	generic_comm_base = rasf_ctx->pcc_comm_addr;
+	patrol_scrub_params = rasf_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
+
+	guard(spinlock_irqsave)(&rasf_ctx->spinlock);
+	patrol_scrub_params->header.type = RASF_TYPE_PATROL_SCRUB;
+	if (param_type == RASF_MEM_SCRUB_PARAM_ADDR_BASE && params->addr_base) {
+		patrol_scrub_params->requested_address_range[0] = params->addr_base;
+	} else if (param_type == RASF_MEM_SCRUB_PARAM_ADDR_SIZE && params->addr_size) {
+		patrol_scrub_params->requested_address_range[1] = params->addr_size;
+	} else if (param_type == RASF_MEM_SCRUB_PARAM_SPEED) {
+		if ((params->speed != RASF_PATROL_SCRUB_SLOW) &&
+		    (params->speed != RASF_PATROL_SCRUB_MEDIUM) &&
+		    params->speed != RASF_PATROL_SCRUB_FAST) {
+			pr_warn("rasf driver failed to set patrol scrub speed=%d\n",
+				params->speed);
+			pr_warn("Supported speeds: slow:%d medium:%d fast:%d\n",
+				RASF_PATROL_SCRUB_SLOW, RASF_PATROL_SCRUB_MEDIUM,
+				RASF_PATROL_SCRUB_FAST);
+			return -EINVAL;
+		}
+
+		/*
+		 * ACPI 6.5 Spec Table 5.78: Parameter Block Structure for PATROL_SCRUB
+		 * Requested Speed (INPUT)
+		 * Bit [0]: Will be set if patrol scrub is already running
+		 *	    for address range specified in “Actual Address Range”
+		 * Bits [2:0]: Requested Patrol Speeds
+		 */
+
+		/* Is the description about Bit[0] in the Spec an error? */
+
+		patrol_scrub_params->requested_speed &= ~RASF_PATROL_SCRUB_SPEED_MASK;
+		patrol_scrub_params->requested_speed |= FIELD_PREP(RASF_PATROL_SCRUB_SPEED_MASK, params->speed);
+	} else {
+		pr_err("Invalid patrol scrub parameter to set\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct rasf_hw_scrub_ops rasf_hw_ops = {
+	.enable_scrub = rasf_enable_patrol_scrub,
+	.get_scrub_params = rasf_get_patrol_scrub_params,
+	.set_scrub_params = rasf_set_patrol_scrub_params,
+};
+
+static const struct scrub_ops rasf_scrub_ops = {
+	.is_visible = rasf_hw_scrub_is_visible,
+	.read = rasf_hw_scrub_read,
+	.write = rasf_hw_scrub_write,
+	.read_string = rasf_hw_scrub_read_strings,
+};
+
+static void devm_rasf_release(void *rasf_ctx)
+{
+	rasf_unregister_pcc_channel(rasf_ctx);
+}
+
+static int rasf_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct mbox_client *cl;
+	struct device *hw_scrub_dev;
+	struct rasf_context *rasf_ctx;
+	char scrub_name[RASF_MAX_NAME_LENGTH];
+
+	rasf_ctx = devm_kzalloc(&pdev->dev, sizeof(*rasf_ctx), GFP_KERNEL);
+	if (!rasf_ctx)
+		return -ENOMEM;
+
+	rasf_ctx->dev = &pdev->dev;
+	rasf_ctx->ops = &rasf_hw_ops;
+	spin_lock_init(&rasf_ctx->spinlock);
+
+	platform_set_drvdata(pdev, rasf_ctx);
+	cl = &rasf_ctx->mbox_client;
+
+	/* Request mailbox channel */
+	cl->dev = &pdev->dev;
+	cl->tx_done = rasf_tx_done;
+	cl->knows_txdone = true;
+
+	rasf_ctx->pcc_subspace_idx = *((int *)pdev->dev.platform_data);
+	dev_dbg(&pdev->dev, "pcc-subspace-id=%d\n", rasf_ctx->pcc_subspace_idx);
+
+	ret = rasf_register_pcc_channel(rasf_ctx);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, devm_rasf_release, rasf_ctx);
+	if (ret < 0)
+		return ret;
+
+	if (rasf_is_patrol_scrub_support(rasf_ctx)) {
+		rasf_ctx->n_regions = RASF_NUM_REGIONS;
+		snprintf(scrub_name, sizeof(scrub_name), "%s", RASF_SCRUB);
+		hw_scrub_dev = devm_scrub_device_register(&pdev->dev, scrub_name, rasf_ctx,
+							  &rasf_scrub_ops,
+							  rasf_ctx->n_regions);
+		if (PTR_ERR_OR_ZERO(hw_scrub_dev))
+			return PTR_ERR_OR_ZERO(hw_scrub_dev);
+	}
+	rasf_ctx->scrub_dev = hw_scrub_dev;
+
+	return 0;
+}
+
+static const struct platform_device_id rasf_id_table[] = {
+	{ .name = "rasf", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, rasf_id_table);
+
+static struct platform_driver rasf_driver = {
+	.probe = rasf_probe,
+	.driver = {
+		.name = "rasf",
+		.suppress_bind_attrs = true,
+	},
+	.id_table = rasf_id_table,
+};
+module_driver(rasf_driver, platform_driver_register, platform_driver_unregister);
+
+MODULE_DESCRIPTION("rasf driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/memory/rasf_common.c b/drivers/memory/rasf_common.c
new file mode 100644
index 000000000000..aa0deb0d6d1e
--- /dev/null
+++ b/drivers/memory/rasf_common.c
@@ -0,0 +1,251 @@
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
+	bool scrub_enable = val;
+
+	ret = rasf_ctx->ops->enable_scrub(rasf_ctx, scrub_enable);
+	if (ret) {
+		pr_err("enable patrol scrub for enable fail, enable=%d ret=%d\n",
+		       scrub_enable, ret);
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
+static int speed_read(struct  rasf_context *rasf_ctx, u64 *val)
+{
+	int ret;
+	struct rasf_scrub_params params;
+
+	ret = rasf_ctx->ops->get_scrub_params(rasf_ctx, &params);
+	if (ret) {
+		pr_err("get patrol scrub params fail ret=%d\n", ret);
+		return ret;
+	}
+	*val = params.speed;
+
+	return 0;
+}
+
+static int speed_write(struct rasf_context *rasf_ctx, long val)
+{
+	int ret;
+	struct rasf_scrub_params params;
+
+	params.speed = val;
+	ret = rasf_ctx->ops->set_scrub_params(rasf_ctx, &params, RASF_MEM_SCRUB_PARAM_SPEED);
+	if (ret) {
+		pr_err("set patrol scrub params for speed fail ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int speed_available_read(struct rasf_context *rasf_ctx, char *buf)
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
+	sprintf(buf, "%s\n", params.speed_avail);
+
+	return 0;
+}
+
+/**
+ * rasf_hw_scrub_is_visible() - Callback to return attribute visibility
+ * @drv_data: Pointer to driver-private data structure passed
+ *	      as argument to devm_scrub_device_register().
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+umode_t rasf_hw_scrub_is_visible(const void *drv_data, u32 attr, int region_id)
+{
+	switch (attr) {
+	case scrub_speed_available:
+		return 0444;
+	case scrub_enable:
+		return 0200;
+	case scrub_addr_base:
+	case scrub_addr_size:
+	case scrub_speed:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * rasf_hw_scrub_read() - Read callback for data attributes
+ * @device: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ * @val: Pointer to the returned data
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int rasf_hw_scrub_read(struct device *device, u32 attr, int region_id, u64 *val)
+{
+	struct rasf_context *rasf_ctx;
+
+	rasf_ctx = dev_get_drvdata(device);
+
+	switch (attr) {
+	case scrub_addr_base:
+		return addr_base_read(rasf_ctx, val);
+	case scrub_addr_size:
+		return addr_size_read(rasf_ctx, val);
+	case scrub_speed:
+		return speed_read(rasf_ctx, val);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+/**
+ * rasf_hw_scrub_write() - Write callback for data attributes
+ * @device: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ * @val: Value to write
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int rasf_hw_scrub_write(struct device *device, u32 attr, int region_id, u64 val)
+{
+	struct rasf_context *rasf_ctx;
+
+	rasf_ctx = dev_get_drvdata(device);
+
+	switch (attr) {
+	case scrub_addr_base:
+		return addr_base_write(rasf_ctx, val);
+	case scrub_addr_size:
+		return addr_size_write(rasf_ctx, val);
+	case scrub_enable:
+		return enable_write(rasf_ctx, val);
+	case scrub_speed:
+		return speed_write(rasf_ctx, val);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+/**
+ * rasf_hw_scrub_read_strings() - Read callback for string attributes
+ * @device: Pointer to scrub device
+ * @attr: Scrub attribute
+ * @region_id: ID of the memory region
+ * @buf: Pointer to the buffer for copying returned string
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int rasf_hw_scrub_read_strings(struct device *device, u32 attr, int region_id,
+			       char *buf)
+{
+	struct rasf_context *rasf_ctx;
+
+	rasf_ctx = dev_get_drvdata(device);
+
+	switch (attr) {
+	case scrub_speed_available:
+		return speed_available_read(rasf_ctx, buf);
+	default:
+		return -ENOTSUPP;
+	}
+}
diff --git a/include/memory/rasf.h b/include/memory/rasf.h
new file mode 100755
index 000000000000..3ec291ddff97
--- /dev/null
+++ b/include/memory/rasf.h
@@ -0,0 +1,82 @@
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
+#define RASF_MAX_SPEED_RANGE_LENGTH      64
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
+ *		Bits [3:1]: Current Patrol Speeds, if Bit [0] is set.
+ * @speed:	[IN] Requested patrol Speed.
+ *		[OUT] Current patrol scrub Speed.
+ * @speed_avail:[OUT] Supported patrol speeds.
+ */
+struct rasf_scrub_params {
+	u64 addr_base;
+	u64 addr_size;
+	u16 flags;
+	u32 speed;
+	char speed_avail[RASF_MAX_SPEED_RANGE_LENGTH];
+};
+
+enum {
+	RASF_MEM_SCRUB_PARAM_ADDR_BASE = 0,
+	RASF_MEM_SCRUB_PARAM_ADDR_SIZE,
+	RASF_MEM_SCRUB_PARAM_SPEED,
+};
+
+/**
+ * struct rasf_hw_scrub_ops - rasf hw scrub device operations
+ * @enable_scrub: Function to enable/disable RASF/RAS2 scrubber. Mandatory.
+ *		Parameters are:
+ *		@rasf_ctx: Pointer to RASF/RAS2 context structure.
+ *		@enable: enable/disable RASF scrubber.
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
+	int (*get_scrub_params)(struct rasf_context *rasf_ctx,
+				struct rasf_scrub_params *params);
+	int (*set_scrub_params)(struct rasf_context *rasf_ctx,
+				struct rasf_scrub_params *params, u8 param_type);
+};
+
+umode_t rasf_hw_scrub_is_visible(const void *drv_data, u32 attr, int region_id);
+int rasf_hw_scrub_read(struct device *dev, u32 attr, int region_id, u64 *val);
+int rasf_hw_scrub_write(struct device *dev, u32 attr, int region_id, u64 val);
+int rasf_hw_scrub_read_strings(struct device *dev, u32 attr, int region_id, char *buf);
+#endif /* _RASF_H */
-- 
2.34.1

