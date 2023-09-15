Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774187A24CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjIOR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbjIOR3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:29:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47122105;
        Fri, 15 Sep 2023 10:29:10 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLjN0QpMz6HJfL;
        Sat, 16 Sep 2023 01:27:20 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:29:08 +0100
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
Subject: [RFC PATCH 9/9] memory: RAS2: Add memory RAS2 driver
Date:   Sat, 16 Sep 2023 01:28:18 +0800
Message-ID: <20230915172818.761-10-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230915172818.761-1-shiju.jose@huawei.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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

Memory RAS2 driver binds to the platform device add by the ACPI RAS2
driver.
Driver registers the PCC channel for communicating with the ACPI compliant
platform that contains RAS2 command support in the hardware.

Add interface functions to support configuring the parameters of HW patrol
scrubber in the system, which exposed to the kernel via the RAS2 and PCC,
using the RAS2 commands.

Add support for RAS2 platform devices to register with scrub config driver.
This enables user to configure the parameters of HW patrol scrubbers,
which exposed to the kernel via the RAS2 table, through the scrub sysfs
attributes.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/memory/Makefile |   2 +-
 drivers/memory/ras2.c   | 334 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 335 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/ras2.c

diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 49340cd100fc..b4b8ff7c6926 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_DDR)		+= jedec_ddr_data.o
 ifeq ($(CONFIG_DDR),y)
 obj-$(CONFIG_OF)		+= of_memory.o
 endif
-obj-$(CONFIG_MEM_RASF)		+= rasf_common.o rasf.o
+obj-$(CONFIG_MEM_RASF)		+= rasf_common.o rasf.o ras2.o
 
 obj-$(CONFIG_ARM_PL172_MPMC)	+= pl172.o
 obj-$(CONFIG_ATMEL_EBI)		+= atmel-ebi.o
diff --git a/drivers/memory/ras2.c b/drivers/memory/ras2.c
new file mode 100644
index 000000000000..80da996bf12e
--- /dev/null
+++ b/drivers/memory/ras2.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ras2.c - ACPI RAS2 memory driver
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ *
+ *  - Registers the PCC channel for communicating with the
+ *    ACPI compliant platform that contains RAS2 command
+ *    support in the hardware.
+ *  - Provides functions to configure HW patrol scrubber
+ *    in the system.
+ *  - Registers with the scrub configure driver for the
+ *    hw patrol scrubber in the system, which exposed via
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
+/* The default number of regions for RAS2 */
+#define RAS2_NUM_REGIONS	1
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
+ * initiate memory patrol scrubber.
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
+	if (patrol_scrub_params->flags & RAS2_PATROL_SCRUB_RATE_VALID) {
+		params->speed = FIELD_GET(RAS2_PATROL_SCRUB_RATE_OUT_MASK,
+					  patrol_scrub_params->scrub_params_out);
+		min_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MIN_RATE_OUT_MASK,
+						patrol_scrub_params->scrub_params_out);
+		max_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MAX_RATE_OUT_MASK,
+						patrol_scrub_params->scrub_params_out);
+		snprintf(params->speed_avail, RASF_MAX_SPEED_RANGE_LENGTH,
+			"%d-%d", min_supp_scrub_rate, max_supp_scrub_rate);
+	} else {
+		params->speed = 0;
+		snprintf(params->speed_avail, RASF_MAX_SPEED_RANGE_LENGTH,
+			"%s", "Unavailable");
+	}
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
+		if (patrol_scrub_params->flags & RAS2_PATROL_SCRUB_RATE_VALID) {
+			scrub_rate_to_set = FIELD_GET(RAS2_PATROL_SCRUB_RATE_IN_MASK,
+						      patrol_scrub_params->scrub_params_in);
+			min_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MIN_RATE_OUT_MASK,
+							patrol_scrub_params->scrub_params_out);
+			max_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MAX_RATE_OUT_MASK,
+							patrol_scrub_params->scrub_params_out);
+			if (scrub_rate_to_set < min_supp_scrub_rate ||
+			    scrub_rate_to_set > max_supp_scrub_rate) {
+				pr_warn("patrol scrub rate to set is out of the supported range\n");
+				pr_warn("min_supp_scrub_rate=%d max_supp_scrub_rate=%d\n",
+					min_supp_scrub_rate, max_supp_scrub_rate);
+				return -EINVAL;
+			}
+		}
+	} else
+		patrol_scrub_params->patrol_scrub_command = RAS2_STOP_PATROL_SCRUBBER;
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
+	} else if (param_type == RASF_MEM_SCRUB_PARAM_SPEED) {
+		patrol_scrub_params->scrub_params_in &= ~RAS2_PATROL_SCRUB_RATE_IN_MASK;
+		patrol_scrub_params->scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_RATE_IN_MASK,
+								   params->speed);
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
+		ras2_ctx->n_regions = RAS2_NUM_REGIONS;
+		snprintf(scrub_name, sizeof(scrub_name), "%s%d", RAS2_SCRUB, id);
+		dev_set_name(&pdev->dev, RAS2_ID_FORMAT, id);
+		hw_scrub_dev = devm_scrub_device_register(&pdev->dev, scrub_name,
+							  ras2_ctx, &ras2_scrub_ops,
+							  ras2_ctx->n_regions);
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
-- 
2.34.1

