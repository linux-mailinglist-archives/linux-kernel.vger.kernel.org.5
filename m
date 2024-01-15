Return-Path: <linux-kernel+bounces-26058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A5A82DAA6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB202820C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CFD17744;
	Mon, 15 Jan 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ySLLIzKs"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524D17550;
	Mon, 15 Jan 2024 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40FDNWdj001257;
	Mon, 15 Jan 2024 14:53:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=OgCELuVFO6l7+GmqvmsGfv3d0brsEPOycdRNQDOksnU=; b=yS
	LLIzKsqc7ldBxPvk2cCYhfsWNbMRxioygB3e/Mb2g6h/Qm3GwHP+2OErY62XmHYK
	a8iWb+gpwK1X+3zO5nBU1zjEzYfzD0Zf41kWjJS58g7HZupO9RCSbBaf+HyWMaid
	zmF5lPQSffOpJqATdPcXEqgLnwLhgCPqFETj7kT2dOCqZAFfk/PLQ99GCmRTdnKP
	y2tuCyCBFR2fq8AE9+kKUhI8++ijR3iLBZB0xCzRVoB9V8dOMTFFakFu0/ozTbNO
	0sg4Tc7XSKOj9N47JBN3ZNQwbyXGfn6yFMZ6HjAdQ2mi7IcEtifwoDauQRjnOGY/
	DJw44jzZxfCIuOtMramw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkma5rwhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 14:53:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49AD5100057;
	Mon, 15 Jan 2024 14:53:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3C8E228EF7F;
	Mon, 15 Jan 2024 14:53:58 +0100 (CET)
Received: from localhost (10.201.20.75) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 14:53:57 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH 1/4] remoteproc: Add TEE support
Date: Mon, 15 Jan 2024 14:52:46 +0100
Message-ID: <20240115135249.296822-2-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115135249.296822-1-arnaud.pouliquen@foss.st.com>
References: <20240115135249.296822-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Add a remoteproc TEE (Trusted Execution Environment) device
that will be probed by the TEE bus. If the associated Trusted
application is supported on secure part this device offers a client
interface to load a firmware in the secure part.
This firmware could be authenticated and decrypted by the secure
trusted application.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/Kconfig          |   9 +
 drivers/remoteproc/Makefile         |   1 +
 drivers/remoteproc/tee_remoteproc.c | 393 ++++++++++++++++++++++++++++
 include/linux/tee_remoteproc.h      |  99 +++++++
 4 files changed, 502 insertions(+)
 create mode 100644 drivers/remoteproc/tee_remoteproc.c
 create mode 100644 include/linux/tee_remoteproc.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 48845dc8fa85..85299606806c 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -365,6 +365,15 @@ config XLNX_R5_REMOTEPROC
 
 	  It's safe to say N if not interested in using RPU r5f cores.
 
+
+config TEE_REMOTEPROC
+	tristate "trusted firmware support by a TEE application"
+	depends on OPTEE
+	help
+	  Support for trusted remote processors firmware. The firmware
+	  authentication and/or decryption are managed by a trusted application.
+	  This can be either built-in or a loadable module.
+
 endif # REMOTEPROC
 
 endmenu
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 91314a9b43ce..fa8daebce277 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_RCAR_REMOTEPROC)		+= rcar_rproc.o
 obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
 obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
 obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
+obj-$(CONFIG_TEE_REMOTEPROC)		+= tee_remoteproc.o
 obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
 obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
 obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
diff --git a/drivers/remoteproc/tee_remoteproc.c b/drivers/remoteproc/tee_remoteproc.c
new file mode 100644
index 000000000000..d089087eb1f6
--- /dev/null
+++ b/drivers/remoteproc/tee_remoteproc.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
+ * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>
+ */
+
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/remoteproc.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+#include <linux/tee_remoteproc.h>
+
+#include "remoteproc_internal.h"
+
+#define MAX_TEE_PARAM_ARRY_MEMBER	4
+
+/*
+ * Authentication of the firmware and load in the remote processor memory
+ *
+ * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
+ * [in]	 params[1].memref:	buffer containing the image of the buffer
+ */
+#define TA_RPROC_FW_CMD_LOAD_FW		1
+
+/*
+ * Start the remote processor
+ *
+ * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
+ */
+#define TA_RPROC_FW_CMD_START_FW	2
+
+/*
+ * Stop the remote processor
+ *
+ * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
+ */
+#define TA_RPROC_FW_CMD_STOP_FW		3
+
+/*
+ * Return the address of the resource table, or 0 if not found
+ * No check is done to verify that the address returned is accessible by
+ * the non secure context. If the resource table is loaded in a protected
+ * memory the access by the non secure context will lead to a data abort.
+ *
+ * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
+ * [out]  params[1].value.a:	32bit LSB resource table memory address
+ * [out]  params[1].value.b:	32bit MSB resource table memory address
+ * [out]  params[2].value.a:	32bit LSB resource table memory size
+ * [out]  params[2].value.b:	32bit MSB resource table memory size
+ */
+#define TA_RPROC_FW_CMD_GET_RSC_TABLE	4
+
+/*
+ * Return the address of the core dump
+ *
+ * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
+ * [out] params[1].memref:	address of the core dump image if exist,
+ *				else return Null
+ */
+#define TA_RPROC_FW_CMD_GET_COREDUMP	5
+
+struct tee_rproc_mem {
+	char name[20];
+	void __iomem *cpu_addr;
+	phys_addr_t bus_addr;
+	u32 dev_addr;
+	size_t size;
+};
+
+struct tee_rproc_context {
+	struct list_head sessions;
+	struct tee_context *tee_ctx;
+	struct device *dev;
+};
+
+struct tee_rproc_context *tee_rproc_ctx;
+
+static void prepare_args(struct tee_rproc *trproc, int cmd, struct tee_ioctl_invoke_arg *arg,
+			 struct tee_param *param, unsigned int num_params)
+{
+	memset(arg, 0, sizeof(*arg));
+	memset(param, 0, MAX_TEE_PARAM_ARRY_MEMBER * sizeof(*param));
+
+	arg->func = cmd;
+	arg->session = trproc->session_id;
+	arg->num_params = num_params + 1;
+
+	param[0] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+		.u.value.a = trproc->rproc_id,
+	};
+}
+
+int tee_rproc_load_fw(struct tee_rproc *trproc, const struct firmware *fw)
+{
+	struct tee_ioctl_invoke_arg arg;
+	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
+	struct tee_shm *fw_shm;
+	int ret;
+
+	fw_shm = tee_shm_register_kernel_buf(tee_rproc_ctx->tee_ctx, (void *)fw->data, fw->size);
+	if (IS_ERR(fw_shm))
+		return PTR_ERR(fw_shm);
+
+	prepare_args(trproc, TA_RPROC_FW_CMD_LOAD_FW, &arg, param, 1);
+
+	/* Provide the address of the firmware image */
+	param[1] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
+		.u.memref = {
+			.shm = fw_shm,
+			.size = fw->size,
+			.shm_offs = 0,
+		},
+	};
+
+	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(tee_rproc_ctx->dev,
+			"TA_RPROC_FW_CMD_LOAD_FW invoke failed TEE err: %x, ret:%x\n",
+			arg.ret, ret);
+		if (!ret)
+			ret = -EIO;
+	}
+
+	tee_shm_free(fw_shm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tee_rproc_load_fw);
+
+int rproc_tee_get_rsc_table(struct tee_rproc *trproc)
+{
+	struct tee_ioctl_invoke_arg arg;
+	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
+	struct rproc *rproc = trproc->rproc;
+	size_t rsc_size;
+	int ret;
+
+	prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, param, 2);
+
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+
+	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(tee_rproc_ctx->dev,
+			"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %x, ret:%x\n",
+			arg.ret, ret);
+		return -EIO;
+	}
+
+	rsc_size = param[2].u.value.a;
+
+	/* If the size is null no resource table defined in the image */
+	if (!rsc_size)
+		return 0;
+
+	/* Store the resource table address that would be updated by the remote core . */
+	trproc->rsc_va = ioremap_wc(param[1].u.value.a, rsc_size);
+	if (IS_ERR_OR_NULL(trproc->rsc_va)) {
+		dev_err(tee_rproc_ctx->dev, "Unable to map memory region: %lld+%zx\n",
+			param[1].u.value.a, rsc_size);
+		trproc->rsc_va = NULL;
+		return -ENOMEM;
+	}
+
+	/*
+	 * A cached table is requested as the physical address is not mapped yet
+	 * but remoteproc needs to parse the table for resources.
+	 */
+	rproc->cached_table = kmemdup(trproc->rsc_va, rsc_size, GFP_KERNEL);
+	if (!rproc->cached_table)
+		return -ENOMEM;
+
+	rproc->table_ptr = rproc->cached_table;
+	rproc->table_sz = rsc_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_get_rsc_table);
+
+struct resource_table *tee_rproc_get_loaded_rsc_table(struct tee_rproc *trproc)
+{
+	return (struct resource_table *)trproc->rsc_va;
+}
+EXPORT_SYMBOL_GPL(tee_rproc_get_loaded_rsc_table);
+
+int tee_rproc_start(struct tee_rproc *trproc)
+{
+	struct tee_ioctl_invoke_arg arg;
+	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
+	int ret;
+
+	prepare_args(trproc, TA_RPROC_FW_CMD_START_FW, &arg, param, 0);
+
+	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(tee_rproc_ctx->dev,
+			"TA_RPROC_FW_CMD_START_FW invoke failed TEE err: %x, ret:%x\n",
+			arg.ret, ret);
+		if (!ret)
+			ret = -EIO;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tee_rproc_start);
+
+int tee_rproc_stop(struct tee_rproc *trproc)
+{
+	struct tee_ioctl_invoke_arg arg;
+	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
+	int ret;
+
+	prepare_args(trproc, TA_RPROC_FW_CMD_STOP_FW, &arg, param, 0);
+
+	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(tee_rproc_ctx->dev,
+			"TA_RPROC_FW_CMD_STOP_FW invoke failed TEE err: %x, ret:%x\n",
+			arg.ret, ret);
+		if (!ret)
+			ret = -EIO;
+	}
+	if (trproc->rsc_va)
+		iounmap(trproc->rsc_va);
+	trproc->rsc_va = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tee_rproc_stop);
+
+static const struct tee_client_device_id stm32_tee_rproc_id_table[] = {
+	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905,
+		   0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, 0x1a, 0x08)},
+	{}
+};
+
+struct tee_rproc *tee_rproc_register(struct device *dev, unsigned int rproc_id)
+{
+	struct tee_client_device *rproc_tee_device;
+	struct tee_ioctl_open_session_arg sess_arg;
+	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
+	struct tee_rproc *trproc;
+	int ret;
+
+	/*
+	 * The device is not probed by the TEE bus. We ignore the reason (bus could be not yet
+	 * probed or service not available in the secure firmware)
+	 * Assumption here is that the TEE bus is not probed.
+	 */
+	if (!tee_rproc_ctx)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	trproc =  devm_kzalloc(dev, sizeof(*trproc), GFP_KERNEL);
+	if (!trproc)
+		return ERR_PTR(-ENOMEM);
+
+	rproc_tee_device = to_tee_client_device(tee_rproc_ctx->dev);
+	memset(&sess_arg, 0, sizeof(sess_arg));
+
+	/* Open session with rproc_tee load the OP-TEE Trusted Application */
+	memcpy(sess_arg.uuid, rproc_tee_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
+
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+	sess_arg.num_params = 1;
+
+	param[0] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+		.u.value.a = rproc_id,
+	};
+
+	ret = tee_client_open_session(tee_rproc_ctx->tee_ctx, &sess_arg, param);
+	if (ret < 0 || sess_arg.ret != 0) {
+		dev_err(dev, "tee_client_open_session failed, err: %x\n", sess_arg.ret);
+		return ERR_PTR(-EINVAL);
+	}
+
+	trproc->parent =  dev;
+	trproc->rproc_id = rproc_id;
+	trproc->session_id = sess_arg.session;
+
+	list_add_tail(&trproc->node, &tee_rproc_ctx->sessions);
+
+	return trproc;
+}
+EXPORT_SYMBOL_GPL(tee_rproc_register);
+
+int tee_rproc_unregister(struct tee_rproc *trproc)
+{
+	int ret;
+
+	if (!tee_rproc_ctx)
+		return -ENODEV;
+
+	ret = tee_client_close_session(tee_rproc_ctx->tee_ctx, trproc->session_id);
+	if (ret < 0)
+		dev_err(trproc->parent,	"tee_client_close_session failed, err: %x\n", ret);
+
+	list_del(&trproc->node);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tee_rproc_unregister);
+
+static int tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	/* Today we support only the OP-TEE, could be extend to other tees */
+	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
+}
+
+static int tee_rproc_probe(struct device *dev)
+{
+	struct tee_context *tee_ctx;
+	int ret;
+
+	/* Only one RPROC OP-TEE device allowed */
+	if (tee_rproc_ctx) {
+		dev_err(dev, "An RPROC OP-TEE device was already initialized: only one allowed\n");
+		return -EBUSY;
+	}
+
+	/* Open context with TEE driver */
+	tee_ctx = tee_client_open_context(NULL, tee_ctx_match, NULL, NULL);
+	if (IS_ERR(tee_ctx))
+		return PTR_ERR(tee_ctx);
+
+	tee_rproc_ctx = devm_kzalloc(dev, sizeof(*tee_ctx), GFP_KERNEL);
+	if (!tee_ctx) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	tee_rproc_ctx->dev = dev;
+	tee_rproc_ctx->tee_ctx = tee_ctx;
+	INIT_LIST_HEAD(&tee_rproc_ctx->sessions);
+
+	return 0;
+err:
+	tee_client_close_context(tee_ctx);
+
+	return ret;
+}
+
+static int tee_rproc_remove(struct device *dev)
+{
+	struct tee_rproc *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &tee_rproc_ctx->sessions, node) {
+		tee_client_close_session(tee_rproc_ctx->tee_ctx, entry->session_id);
+		list_del(&entry->node);
+		kfree(entry);
+	}
+
+	tee_client_close_context(tee_rproc_ctx->tee_ctx);
+
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(tee, stm32_tee_rproc_id_table);
+
+static struct tee_client_driver tee_rproc_fw_driver = {
+	.id_table	= stm32_tee_rproc_id_table,
+	.driver		= {
+		.name		= KBUILD_MODNAME,
+		.bus		= &tee_bus_type,
+		.probe		= tee_rproc_probe,
+		.remove		= tee_rproc_remove,
+	},
+};
+
+static int __init tee_rproc_fw_mod_init(void)
+{
+	return driver_register(&tee_rproc_fw_driver.driver);
+}
+
+static void __exit tee_rproc_fw_mod_exit(void)
+{
+	driver_unregister(&tee_rproc_fw_driver.driver);
+}
+
+module_init(tee_rproc_fw_mod_init);
+module_exit(tee_rproc_fw_mod_exit);
+
+MODULE_DESCRIPTION(" TEE remote processor control driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/tee_remoteproc.h b/include/linux/tee_remoteproc.h
new file mode 100644
index 000000000000..0e11e5b8b524
--- /dev/null
+++ b/include/linux/tee_remoteproc.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright(c) 2023 STMicroelectronics - All Rights Reserved
+ */
+
+#ifndef TEE_REMOTEPROC_H
+#define TEE_REMOTEPROC_H
+
+#include <linux/remoteproc.h>
+#include <linux/tee_drv.h>
+
+/**
+ * struct tee_rproc - TEE remoteproc structure
+ * @node:		Reference in list
+ * @rproc:		Remoteproc reference
+ * @parent:		Parent device
+ * @rproc_id:		Identifier of the target firmware
+ * @session_id:		TEE session identifier
+ * @rsc_va:		Resource table virtual address.
+ */
+struct tee_rproc {
+	struct list_head node;
+	struct rproc *rproc;
+	struct device *parent;
+	u32 rproc_id;
+	u32 session_id;
+	void *rsc_va;
+};
+
+#if IS_ENABLED(CONFIG_TEE_REMOTEPROC)
+
+struct tee_rproc *tee_rproc_register(struct device *dev, unsigned int rproc_id);
+int tee_rproc_unregister(struct tee_rproc *trproc);
+
+int tee_rproc_load_fw(struct tee_rproc *trproc, const struct firmware *fw);
+int rproc_tee_get_rsc_table(struct tee_rproc *trproc);
+struct resource_table *tee_rproc_get_loaded_rsc_table(struct tee_rproc *trproc);
+int tee_rproc_start(struct tee_rproc *trproc);
+int tee_rproc_stop(struct tee_rproc *trproc);
+
+#else
+
+static inline struct tee_rproc *tee_rproc_register(struct device *dev, unsigned int rproc_id)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline int tee_rproc_unregister(struct tee_rproc *trproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int tee_rproc_load_fw(struct tee_rproc *trproc,
+				    const struct firmware *fw)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int tee_rproc_start(struct tee_rproc *trproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int tee_rproc_stop(struct tee_rproc *trproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int rproc_tee_get_rsc_table(struct tee_rproc *trproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline struct resource_table *
+	tee_rproc_get_loaded_rsc_table(struct tee_rproc *trproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return NULL;
+}
+
+#endif /* CONFIG_TEE_REMOTEPROC */
+#endif /* TEE_REMOTEPROC_H */
-- 
2.25.1


