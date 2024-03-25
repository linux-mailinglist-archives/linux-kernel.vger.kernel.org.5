Return-Path: <linux-kernel+bounces-117339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C188AA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530A81C33F22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4FC131BAC;
	Mon, 25 Mar 2024 15:12:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C8946450;
	Mon, 25 Mar 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379522; cv=none; b=FTET7YJ/JXMM8+cCHqqAcM7HG4QTV+wD3w82EhC1g9VQdah2E2P/CLoIvZvQuaXIvOCD4A7HQyKxE8WsmTsUqFipdN8LVXCQJXVe4TMg2eu7zpBD9GUWb/gnhKLTzkG0aEczjQJi4kFwxG6CQ3z6CMjH4tWJKPccDbI/Wma9DBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379522; c=relaxed/simple;
	bh=ySu7C0VToW0EwUXvOxZZCVKkL36LW1Nri3v06wH4L5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TEpnMHBVAgXKYZjPTSmxGevFTzwPCniPQACtfvL3Jko+Gj77rPB12LCLVfkQvtkYFmbVt6P+lfBEITlClF9sWTQ5lIjy6EP+yOVBP4CUTr1tlKuwBRrDWRiwMQSla8e8iUdxEo3ZjYuBppx9f/WXTW391seSD+7QmR0hFFRVq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 329B8106F;
	Mon, 25 Mar 2024 08:12:33 -0700 (PDT)
Received: from mango.localdomain (unknown [10.57.15.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 651233F64C;
	Mon, 25 Mar 2024 08:11:57 -0700 (PDT)
From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: jens.wiklander@linaro.org,
	sumit.garg@linaro.org,
	corbet@lwn.net,
	balint.dobszay@arm.com,
	sudeep.holla@arm.com,
	rdunlap@infradead.org,
	krzk@kernel.org,
	gyorgy.szing@arm.com
Subject: [PATCH v4 3/5] tee: tstee: Add Trusted Services TEE driver
Date: Mon, 25 Mar 2024 16:11:03 +0100
Message-Id: <20240325151105.135667-4-balint.dobszay@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325151105.135667-1-balint.dobszay@arm.com>
References: <20240325151105.135667-1-balint.dobszay@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Trusted Services project provides a framework for developing and
deploying device Root of Trust services in FF-A Secure Partitions. The
FF-A SPs are accessible through the FF-A driver, but this doesn't
provide a user space interface. The goal of this TEE driver is to make
Trusted Services SPs accessible for user space clients.

All TS SPs have the same FF-A UUID, it identifies the RPC protocol used
by TS. A TS SP can host one or more services, a service is identified by
its service UUID. The same type of service cannot be present twice in
the same SP. During SP boot each service in an SP is assigned an
interface ID, this is just a short ID to simplify message addressing.
There is 1:1 mapping between TS SPs and TEE devices, i.e. a separate TEE
device is registered for each TS SP. This is required since contrary to
the generic TEE design where memory is shared with the whole TEE
implementation, in case of FF-A, memory is shared with a specific SP. A
user space client has to be able to separately share memory with each SP
based on its endpoint ID.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
---
 drivers/tee/Kconfig               |   1 +
 drivers/tee/Makefile              |   1 +
 drivers/tee/tstee/Kconfig         |  11 +
 drivers/tee/tstee/Makefile        |   3 +
 drivers/tee/tstee/core.c          | 480 ++++++++++++++++++++++++++++++
 drivers/tee/tstee/tstee_private.h |  92 ++++++
 include/uapi/linux/tee.h          |   1 +
 7 files changed, 589 insertions(+)
 create mode 100644 drivers/tee/tstee/Kconfig
 create mode 100644 drivers/tee/tstee/Makefile
 create mode 100644 drivers/tee/tstee/core.c
 create mode 100644 drivers/tee/tstee/tstee_private.h

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 73a147202e88..61b507c18780 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -15,5 +15,6 @@ if TEE
 
 source "drivers/tee/optee/Kconfig"
 source "drivers/tee/amdtee/Kconfig"
+source "drivers/tee/tstee/Kconfig"
 
 endif
diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
index 68da044afbfa..5488cba30bd2 100644
--- a/drivers/tee/Makefile
+++ b/drivers/tee/Makefile
@@ -5,3 +5,4 @@ tee-objs += tee_shm.o
 tee-objs += tee_shm_pool.o
 obj-$(CONFIG_OPTEE) += optee/
 obj-$(CONFIG_AMDTEE) += amdtee/
+obj-$(CONFIG_ARM_TSTEE) += tstee/
diff --git a/drivers/tee/tstee/Kconfig b/drivers/tee/tstee/Kconfig
new file mode 100644
index 000000000000..d32f91d47398
--- /dev/null
+++ b/drivers/tee/tstee/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config ARM_TSTEE
+	tristate "Arm Trusted Services TEE driver"
+	depends on ARM_FFA_TRANSPORT
+	default n
+	help
+	  The Trusted Services project provides a framework for developing and
+	  deploying device Root of Trust services in FF-A Secure Partitions.
+	  This driver provides an interface to make Trusted Services Secure
+	  Partitions accessible for user space clients, since the FF-A driver
+	  doesn't implement a user space interface directly.
diff --git a/drivers/tee/tstee/Makefile b/drivers/tee/tstee/Makefile
new file mode 100644
index 000000000000..5227020ebd30
--- /dev/null
+++ b/drivers/tee/tstee/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+arm-tstee-objs := core.o
+obj-$(CONFIG_ARM_TSTEE) = arm-tstee.o
diff --git a/drivers/tee/tstee/core.c b/drivers/tee/tstee/core.c
new file mode 100644
index 000000000000..533425e9e9e7
--- /dev/null
+++ b/drivers/tee/tstee/core.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Arm Limited
+ */
+
+#include <linux/arm_ffa.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/tee_core.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include <linux/xarray.h>
+#include "tstee_private.h"
+
+#define FFA_DIRECT_REQ_ARG_NUM 5
+#define FFA_INVALID_MEM_HANDLE U64_MAX
+
+static void arg_list_to_ffa_data(const u32 *args,
+				 struct ffa_send_direct_data *data)
+{
+	data->data0 = args[0];
+	data->data1 = args[1];
+	data->data2 = args[2];
+	data->data3 = args[3];
+	data->data4 = args[4];
+}
+
+static void arg_list_from_ffa_data(const struct ffa_send_direct_data *data,
+				   u32 *args)
+{
+	args[0] = lower_32_bits(data->data0);
+	args[1] = lower_32_bits(data->data1);
+	args[2] = lower_32_bits(data->data2);
+	args[3] = lower_32_bits(data->data3);
+	args[4] = lower_32_bits(data->data4);
+}
+
+static void tstee_get_version(struct tee_device *teedev,
+			      struct tee_ioctl_version_data *vers)
+{
+	struct tstee *tstee = tee_get_drvdata(teedev);
+	struct tee_ioctl_version_data v = {
+		.impl_id = TEE_IMPL_ID_TSTEE,
+		/* FF-A endpoint ID only uses the lower 16 bits */
+		.impl_caps = lower_16_bits(tstee->ffa_dev->vm_id),
+		.gen_caps = 0,
+	};
+
+	*vers = v;
+}
+
+static int tstee_open(struct tee_context *ctx)
+{
+	struct ts_context_data *ctxdata;
+
+	ctxdata = kzalloc(sizeof(*ctxdata), GFP_KERNEL);
+	if (!ctxdata)
+		return -ENOMEM;
+
+	xa_init_flags(&ctxdata->sess_list, XA_FLAGS_ALLOC);
+
+	ctx->data = ctxdata;
+
+	return 0;
+}
+
+static void tstee_release(struct tee_context *ctx)
+{
+	struct ts_context_data *ctxdata = ctx->data;
+	struct ts_session *sess;
+	unsigned long idx;
+
+	if (!ctxdata)
+		return;
+
+	xa_for_each(&ctxdata->sess_list, idx, sess) {
+		xa_erase(&ctxdata->sess_list, idx);
+		kfree(sess);
+	}
+
+	xa_destroy(&ctxdata->sess_list);
+
+	kfree(ctxdata);
+	ctx->data = NULL;
+}
+
+static int tstee_open_session(struct tee_context *ctx,
+			      struct tee_ioctl_open_session_arg *arg,
+			      struct tee_param *param __always_unused)
+{
+	struct tstee *tstee = tee_get_drvdata(ctx->teedev);
+	struct ffa_device *ffa_dev = tstee->ffa_dev;
+	struct ts_context_data *ctxdata = ctx->data;
+	struct ffa_send_direct_data ffa_data;
+	struct ts_session *sess = NULL;
+	u32 ffa_args[FFA_DIRECT_REQ_ARG_NUM] = {};
+	u32 sess_id;
+	int rc;
+
+	ffa_args[TS_RPC_CTRL_REG] =
+		TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFACE_ID,
+					      TS_RPC_OP_SERVICE_INFO);
+
+	memcpy(ffa_args + TS_RPC_SERVICE_INFO_UUID0, arg->uuid, UUID_SIZE);
+
+	arg_list_to_ffa_data(ffa_args, &ffa_data);
+	rc = ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
+	if (rc)
+		return rc;
+
+	arg_list_from_ffa_data(&ffa_data, ffa_args);
+
+	if (ffa_args[TS_RPC_SERVICE_INFO_RPC_STATUS] != TS_RPC_OK)
+		return -ENODEV;
+
+	if (ffa_args[TS_RPC_SERVICE_INFO_IFACE] > U8_MAX)
+		return -EINVAL;
+
+	sess = kzalloc(sizeof(*sess), GFP_KERNEL);
+	if (!sess)
+		return -ENOMEM;
+
+	sess->iface_id = ffa_args[TS_RPC_SERVICE_INFO_IFACE];
+
+	rc = xa_alloc(&ctxdata->sess_list, &sess_id, sess, xa_limit_32b,
+		      GFP_KERNEL);
+	if (rc) {
+		kfree(sess);
+		return rc;
+	}
+
+	arg->session = sess_id;
+	arg->ret = 0;
+
+	return 0;
+}
+
+static int tstee_close_session(struct tee_context *ctx, u32 session)
+{
+	struct ts_context_data *ctxdata = ctx->data;
+	struct ts_session *sess;
+
+	/* Calls xa_lock() internally */
+	sess = xa_erase(&ctxdata->sess_list, session);
+	if (!sess)
+		return -EINVAL;
+
+	kfree(sess);
+
+	return 0;
+}
+
+static int tstee_invoke_func(struct tee_context *ctx,
+			     struct tee_ioctl_invoke_arg *arg,
+			     struct tee_param *param)
+{
+	struct tstee *tstee = tee_get_drvdata(ctx->teedev);
+	struct ffa_device *ffa_dev = tstee->ffa_dev;
+	struct ts_context_data *ctxdata = ctx->data;
+	struct ffa_send_direct_data ffa_data;
+	struct tee_shm *shm = NULL;
+	struct ts_session *sess;
+	u32 req_len, ffa_args[FFA_DIRECT_REQ_ARG_NUM] = {};
+	int shm_id, rc;
+	u8 iface_id;
+	u64 handle;
+	u16 opcode;
+
+	xa_lock(&ctxdata->sess_list);
+	sess = xa_load(&ctxdata->sess_list, arg->session);
+
+	/*
+	 * Do this while holding the lock to make sure that the session wasn't
+	 * closed meanwhile
+	 */
+	if (sess)
+		iface_id = sess->iface_id;
+
+	xa_unlock(&ctxdata->sess_list);
+	if (!sess)
+		return -EINVAL;
+
+	opcode = lower_16_bits(arg->func);
+	shm_id = lower_32_bits(param[0].u.value.a);
+	req_len = lower_32_bits(param[0].u.value.b);
+
+	if (shm_id != 0) {
+		shm = tee_shm_get_from_id(ctx, shm_id);
+		if (IS_ERR(shm))
+			return PTR_ERR(shm);
+
+		if (shm->size < req_len) {
+			dev_err(&ffa_dev->dev,
+				"request doesn't fit into shared memory buffer\n");
+			rc = -EINVAL;
+			goto out;
+		}
+
+		handle = shm->sec_world_id;
+	} else {
+		handle = FFA_INVALID_MEM_HANDLE;
+	}
+
+	ffa_args[TS_RPC_CTRL_REG] = TS_RPC_CTRL_PACK_IFACE_OPCODE(iface_id,
+								  opcode);
+	ffa_args[TS_RPC_SERVICE_MEM_HANDLE_LSW] = lower_32_bits(handle);
+	ffa_args[TS_RPC_SERVICE_MEM_HANDLE_MSW] = upper_32_bits(handle);
+	ffa_args[TS_RPC_SERVICE_REQ_LEN] = req_len;
+	ffa_args[TS_RPC_SERVICE_CLIENT_ID] = 0;
+
+	arg_list_to_ffa_data(ffa_args, &ffa_data);
+	rc = ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
+	if (rc)
+		goto out;
+
+	arg_list_from_ffa_data(&ffa_data, ffa_args);
+
+	if (ffa_args[TS_RPC_SERVICE_RPC_STATUS] != TS_RPC_OK) {
+		dev_err(&ffa_dev->dev, "invoke_func rpc status: %d\n",
+			ffa_args[TS_RPC_SERVICE_RPC_STATUS]);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	arg->ret = ffa_args[TS_RPC_SERVICE_STATUS];
+	if (shm && shm->size >= ffa_args[TS_RPC_SERVICE_RESP_LEN])
+		param[0].u.value.a = ffa_args[TS_RPC_SERVICE_RESP_LEN];
+
+out:
+	if (shm)
+		tee_shm_put(shm);
+
+	return rc;
+}
+
+static int tstee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
+			      struct page **pages, size_t num_pages,
+			      unsigned long start __always_unused)
+{
+	struct tstee *tstee = tee_get_drvdata(ctx->teedev);
+	struct ffa_device *ffa_dev = tstee->ffa_dev;
+	struct ffa_mem_region_attributes mem_attr = {
+		.receiver = tstee->ffa_dev->vm_id,
+		.attrs = FFA_MEM_RW,
+		.flag = 0,
+	};
+	struct ffa_mem_ops_args mem_args = {
+		.attrs = &mem_attr,
+		.use_txbuf = true,
+		.nattrs = 1,
+		.flags = 0,
+	};
+	struct ffa_send_direct_data ffa_data;
+	struct sg_table sgt;
+	u32 ffa_args[FFA_DIRECT_REQ_ARG_NUM] = {};
+	int rc;
+
+	rc = sg_alloc_table_from_pages(&sgt, pages, num_pages, 0,
+				       num_pages * PAGE_SIZE, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	mem_args.sg = sgt.sgl;
+	rc = ffa_dev->ops->mem_ops->memory_share(&mem_args);
+	sg_free_table(&sgt);
+	if (rc)
+		return rc;
+
+	shm->sec_world_id = mem_args.g_handle;
+
+	ffa_args[TS_RPC_CTRL_REG] =
+			TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFACE_ID,
+						      TS_RPC_OP_RETRIEVE_MEM);
+	ffa_args[TS_RPC_RETRIEVE_MEM_HANDLE_LSW] =
+			lower_32_bits(shm->sec_world_id);
+	ffa_args[TS_RPC_RETRIEVE_MEM_HANDLE_MSW] =
+			upper_32_bits(shm->sec_world_id);
+	ffa_args[TS_RPC_RETRIEVE_MEM_TAG_LSW] = 0;
+	ffa_args[TS_RPC_RETRIEVE_MEM_TAG_MSW] = 0;
+
+	arg_list_to_ffa_data(ffa_args, &ffa_data);
+	rc = ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
+	if (rc) {
+		(void)ffa_dev->ops->mem_ops->memory_reclaim(shm->sec_world_id,
+							    0);
+		return rc;
+	}
+
+	arg_list_from_ffa_data(&ffa_data, ffa_args);
+
+	if (ffa_args[TS_RPC_RETRIEVE_MEM_RPC_STATUS] != TS_RPC_OK) {
+		dev_err(&ffa_dev->dev, "shm_register rpc status: %d\n",
+			ffa_args[TS_RPC_RETRIEVE_MEM_RPC_STATUS]);
+		ffa_dev->ops->mem_ops->memory_reclaim(shm->sec_world_id, 0);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tstee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
+{
+	struct tstee *tstee = tee_get_drvdata(ctx->teedev);
+	struct ffa_device *ffa_dev = tstee->ffa_dev;
+	struct ffa_send_direct_data ffa_data;
+	u32 ffa_args[FFA_DIRECT_REQ_ARG_NUM] = {};
+	int rc;
+
+	ffa_args[TS_RPC_CTRL_REG] =
+			TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFACE_ID,
+						      TS_RPC_OP_RELINQ_MEM);
+	ffa_args[TS_RPC_RELINQ_MEM_HANDLE_LSW] =
+			lower_32_bits(shm->sec_world_id);
+	ffa_args[TS_RPC_RELINQ_MEM_HANDLE_MSW] =
+			upper_32_bits(shm->sec_world_id);
+
+	arg_list_to_ffa_data(ffa_args, &ffa_data);
+	rc = ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data);
+	if (rc)
+		return rc;
+	arg_list_from_ffa_data(&ffa_data, ffa_args);
+
+	if (ffa_args[TS_RPC_RELINQ_MEM_RPC_STATUS] != TS_RPC_OK) {
+		dev_err(&ffa_dev->dev, "shm_unregister rpc status: %d\n",
+			ffa_args[TS_RPC_RELINQ_MEM_RPC_STATUS]);
+		return -EINVAL;
+	}
+
+	rc = ffa_dev->ops->mem_ops->memory_reclaim(shm->sec_world_id, 0);
+
+	return rc;
+}
+
+static const struct tee_driver_ops tstee_ops = {
+	.get_version = tstee_get_version,
+	.open = tstee_open,
+	.release = tstee_release,
+	.open_session = tstee_open_session,
+	.close_session = tstee_close_session,
+	.invoke_func = tstee_invoke_func,
+};
+
+static const struct tee_desc tstee_desc = {
+	.name = "tstee-clnt",
+	.ops = &tstee_ops,
+	.owner = THIS_MODULE,
+};
+
+static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
+			 size_t size, size_t align)
+{
+	return tee_dyn_shm_alloc_helper(shm, size, align, tstee_shm_register);
+}
+
+static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
+{
+	tee_dyn_shm_free_helper(shm, tstee_shm_unregister);
+}
+
+static void pool_op_destroy_pool(struct tee_shm_pool *pool)
+{
+	kfree(pool);
+}
+
+static const struct tee_shm_pool_ops pool_ops = {
+	.alloc = pool_op_alloc,
+	.free = pool_op_free,
+	.destroy_pool = pool_op_destroy_pool,
+};
+
+static struct tee_shm_pool *tstee_create_shm_pool(void)
+{
+	struct tee_shm_pool *pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	pool->ops = &pool_ops;
+
+	return pool;
+}
+
+static bool tstee_check_rpc_compatible(struct ffa_device *ffa_dev)
+{
+	struct ffa_send_direct_data ffa_data;
+	u32 ffa_args[FFA_DIRECT_REQ_ARG_NUM] = {};
+
+	ffa_args[TS_RPC_CTRL_REG] =
+			TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC_MGMT_IFACE_ID,
+						      TS_RPC_OP_GET_VERSION);
+
+	arg_list_to_ffa_data(ffa_args, &ffa_data);
+	if (ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data))
+		return false;
+
+	arg_list_from_ffa_data(&ffa_data, ffa_args);
+
+	return ffa_args[TS_RPC_GET_VERSION_RESP] == TS_RPC_PROTOCOL_VERSION;
+}
+
+static int tstee_probe(struct ffa_device *ffa_dev)
+{
+	struct tstee *tstee;
+	int rc;
+
+	ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
+
+	if (!tstee_check_rpc_compatible(ffa_dev))
+		return -EINVAL;
+
+	tstee = kzalloc(sizeof(*tstee), GFP_KERNEL);
+	if (!tstee)
+		return -ENOMEM;
+
+	tstee->ffa_dev = ffa_dev;
+
+	tstee->pool = tstee_create_shm_pool();
+	if (IS_ERR(tstee->pool)) {
+		rc = PTR_ERR(tstee->pool);
+		tstee->pool = NULL;
+		goto err_free_tstee;
+	}
+
+	tstee->teedev = tee_device_alloc(&tstee_desc, NULL, tstee->pool, tstee);
+	if (IS_ERR(tstee->teedev)) {
+		rc = PTR_ERR(tstee->teedev);
+		tstee->teedev = NULL;
+		goto err_free_pool;
+	}
+
+	rc = tee_device_register(tstee->teedev);
+	if (rc)
+		goto err_unreg_teedev;
+
+	ffa_dev_set_drvdata(ffa_dev, tstee);
+
+	return 0;
+
+err_unreg_teedev:
+	tee_device_unregister(tstee->teedev);
+err_free_pool:
+	tee_shm_pool_free(tstee->pool);
+err_free_tstee:
+	kfree(tstee);
+	return rc;
+}
+
+static void tstee_remove(struct ffa_device *ffa_dev)
+{
+	struct tstee *tstee = ffa_dev->dev.driver_data;
+
+	tee_device_unregister(tstee->teedev);
+	tee_shm_pool_free(tstee->pool);
+	kfree(tstee);
+}
+
+static const struct ffa_device_id tstee_device_ids[] = {
+	/* TS RPC protocol UUID: bdcd76d7-825e-4751-963b-86d4f84943ac */
+	{ TS_RPC_UUID },
+	{}
+};
+
+static struct ffa_driver tstee_driver = {
+	.name = "arm_tstee",
+	.probe = tstee_probe,
+	.remove = tstee_remove,
+	.id_table = tstee_device_ids,
+};
+
+module_ffa_driver(tstee_driver);
+
+MODULE_AUTHOR("Balint Dobszay <balint.dobszay@arm.com>");
+MODULE_DESCRIPTION("Arm Trusted Services TEE driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tee/tstee/tstee_private.h b/drivers/tee/tstee/tstee_private.h
new file mode 100644
index 000000000000..8e58725b57eb
--- /dev/null
+++ b/drivers/tee/tstee/tstee_private.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Arm Limited
+ */
+
+#ifndef TSTEE_PRIVATE_H
+#define TSTEE_PRIVATE_H
+
+#include <linux/arm_ffa.h>
+#include <linux/bitops.h>
+#include <linux/tee_core.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include <linux/xarray.h>
+
+/*
+ * The description of the ABI implemented in this file is available at
+ * https://trusted-services.readthedocs.io/en/v1.0.0/developer/service-access-protocols.html#abi
+ */
+
+/* UUID of this protocol */
+#define TS_RPC_UUID UUID_INIT(0xbdcd76d7, 0x825e, 0x4751, \
+			      0x96, 0x3b, 0x86, 0xd4, 0xf8, 0x49, 0x43, 0xac)
+
+/* Protocol version*/
+#define TS_RPC_PROTOCOL_VERSION		(1)
+
+/* Status codes */
+#define TS_RPC_OK			(0)
+
+/* RPC control register */
+#define TS_RPC_CTRL_REG			(0)
+#define OPCODE_MASK			GENMASK(15, 0)
+#define IFACE_ID_MASK			GENMASK(23, 16)
+#define TS_RPC_CTRL_OPCODE(x)		((u16)(FIELD_GET(OPCODE_MASK, (x))))
+#define TS_RPC_CTRL_IFACE_ID(x)		((u8)(FIELD_GET(IFACE_ID_MASK, (x))))
+#define TS_RPC_CTRL_PACK_IFACE_OPCODE(i, o)	\
+	(FIELD_PREP(IFACE_ID_MASK, (i)) | FIELD_PREP(OPCODE_MASK, (o)))
+#define TS_RPC_CTRL_SAP_RC		BIT(30)
+#define TS_RPC_CTRL_SAP_ERR		BIT(31)
+
+/* Interface ID for RPC management operations */
+#define TS_RPC_MGMT_IFACE_ID		(0xff)
+
+/* Management calls */
+#define TS_RPC_OP_GET_VERSION		(0x0000)
+#define TS_RPC_GET_VERSION_RESP		(1)
+
+#define TS_RPC_OP_RETRIEVE_MEM		(0x0001)
+#define TS_RPC_RETRIEVE_MEM_HANDLE_LSW	(1)
+#define TS_RPC_RETRIEVE_MEM_HANDLE_MSW	(2)
+#define TS_RPC_RETRIEVE_MEM_TAG_LSW	(3)
+#define TS_RPC_RETRIEVE_MEM_TAG_MSW	(4)
+#define TS_RPC_RETRIEVE_MEM_RPC_STATUS	(1)
+
+#define TS_RPC_OP_RELINQ_MEM		(0x0002)
+#define TS_RPC_RELINQ_MEM_HANDLE_LSW	(1)
+#define TS_RPC_RELINQ_MEM_HANDLE_MSW	(2)
+#define TS_RPC_RELINQ_MEM_RPC_STATUS	(1)
+
+#define TS_RPC_OP_SERVICE_INFO		(0x0003)
+#define TS_RPC_SERVICE_INFO_UUID0	(1)
+#define TS_RPC_SERVICE_INFO_UUID1	(2)
+#define TS_RPC_SERVICE_INFO_UUID2	(3)
+#define TS_RPC_SERVICE_INFO_UUID3	(4)
+#define TS_RPC_SERVICE_INFO_RPC_STATUS	(1)
+#define TS_RPC_SERVICE_INFO_IFACE	(2)
+
+/* Service call */
+#define TS_RPC_SERVICE_MEM_HANDLE_LSW	(1)
+#define TS_RPC_SERVICE_MEM_HANDLE_MSW	(2)
+#define TS_RPC_SERVICE_REQ_LEN		(3)
+#define TS_RPC_SERVICE_CLIENT_ID	(4)
+#define TS_RPC_SERVICE_RPC_STATUS	(1)
+#define TS_RPC_SERVICE_STATUS		(2)
+#define TS_RPC_SERVICE_RESP_LEN		(3)
+
+struct tstee {
+	struct ffa_device *ffa_dev;
+	struct tee_device *teedev;
+	struct tee_shm_pool *pool;
+};
+
+struct ts_session {
+	u8 iface_id;
+};
+
+struct ts_context_data {
+	struct xarray sess_list;
+};
+
+#endif /* TSTEE_PRIVATE_H */
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 23e57164693c..d0430bee8292 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -56,6 +56,7 @@
  */
 #define TEE_IMPL_ID_OPTEE	1
 #define TEE_IMPL_ID_AMDTEE	2
+#define TEE_IMPL_ID_TSTEE	3
 
 /*
  * OP-TEE specific capabilities
-- 
2.34.1


