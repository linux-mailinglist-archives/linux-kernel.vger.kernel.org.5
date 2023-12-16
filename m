Return-Path: <linux-kernel+bounces-1881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E56815534
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AACB23737
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC618C05;
	Sat, 16 Dec 2023 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B5TWgck2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5383D286;
	Sat, 16 Dec 2023 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFNVtTc032147;
	Sat, 16 Dec 2023 00:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=iTaqAUcOpRnCyYGJ0l3m5/vSDTCcvFGH9tqjh544eL4
	=; b=B5TWgck2K4jQCXDXIXtpg0n/j8Lmn6aBx9i6XSvu/Ndrr8htpVOatDgU36c
	SzO86s0LDTgX0Oknj9ZfrfkxDYjFmSMKCAVau4q1WE8xly/pVsb69pWgqSrex48E
	YMLrG37sHq1Pj+kYbBJeM3MjAqgdv2CTf+00xl9MT/jhHVW9fF3IWh72kEeKt7Ne
	JxdhvC5hdNj0bExWUQEAfXmH4vsRwoBqjo+iy1a19l/KamOCJtx6oXOUVgdgrkpW
	04mgx1xFFj8UDHogTprUJOfyGme+1xoFKHe7/2qJVjVLNnNEOfj9GpYMAjCuFg9e
	vUW4PN6bolhIhCM72I73g15onEA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0vv9ghj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0L7SM015556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:07 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:06 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:20:52 -0800
Subject: [PATCH RFC v15 11/30] gunyah: vm_mgr: Add framework for VM
 Functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-11-192a5d872a30@quicinc.com>
References: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
In-Reply-To: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
To: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1nT_mBGLws1M_dRKl_RKL4-iwDUKhNXs
X-Proofpoint-ORIG-GUID: 1nT_mBGLws1M_dRKl_RKL4-iwDUKhNXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312160001

Introduce a framework for Gunyah userspace to install VM functions. VM
functions are optional interfaces to the virtual machine. vCPUs,
ioeventfs, and irqfds are examples of such VM functions and are
implemented in subsequent patches.

A generic framework is implemented instead of individual ioctls to
create vCPUs, irqfds, etc., in order to simplify the VM manager core
implementation and allow dynamic loading of VM function modules.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c  | 217 +++++++++++++++++++++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h  |   6 ++
 include/linux/gunyah_vm_mgr.h | 100 +++++++++++++++++++
 include/uapi/linux/gunyah.h   |  18 ++++
 4 files changed, 339 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 1b1b26f568af..81bc73047e1e 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -6,15 +6,185 @@
 #define pr_fmt(fmt) "gunyah_vm_mgr: " fmt
 
 #include <linux/anon_inodes.h>
+#include <linux/compat.h>
 #include <linux/file.h>
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/gunyah_vm_mgr.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/xarray.h>
 
 #include <uapi/linux/gunyah.h>
 
 #include "vm_mgr.h"
 
+static DEFINE_XARRAY(gunyah_vm_functions);
+
+static void gunyah_vm_put_function(struct gunyah_vm_function *fn)
+{
+	module_put(fn->mod);
+}
+
+static struct gunyah_vm_function *gunyah_vm_get_function(u32 type)
+{
+	struct gunyah_vm_function *fn;
+
+	fn = xa_load(&gunyah_vm_functions, type);
+	if (!fn) {
+		request_module("ghfunc:%d", type);
+
+		fn = xa_load(&gunyah_vm_functions, type);
+	}
+
+	if (!fn || !try_module_get(fn->mod))
+		fn = ERR_PTR(-ENOENT);
+
+	return fn;
+}
+
+static void
+gunyah_vm_remove_function_instance(struct gunyah_vm_function_instance *inst)
+	__must_hold(&inst->ghvm->fn_lock)
+{
+	inst->fn->unbind(inst);
+	list_del(&inst->vm_list);
+	gunyah_vm_put_function(inst->fn);
+	kfree(inst->argp);
+	kfree(inst);
+}
+
+static void gunyah_vm_remove_functions(struct gunyah_vm *ghvm)
+{
+	struct gunyah_vm_function_instance *inst, *iiter;
+
+	mutex_lock(&ghvm->fn_lock);
+	list_for_each_entry_safe(inst, iiter, &ghvm->functions, vm_list) {
+		gunyah_vm_remove_function_instance(inst);
+	}
+	mutex_unlock(&ghvm->fn_lock);
+}
+
+static long gunyah_vm_add_function_instance(struct gunyah_vm *ghvm,
+					    struct gunyah_fn_desc *f)
+{
+	struct gunyah_vm_function_instance *inst;
+	void __user *argp;
+	long r = 0;
+
+	if (f->arg_size > GUNYAH_FN_MAX_ARG_SIZE) {
+		dev_err_ratelimited(ghvm->parent, "%s: arg_size > %d\n",
+				    __func__, GUNYAH_FN_MAX_ARG_SIZE);
+		return -EINVAL;
+	}
+
+	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+
+	inst->arg_size = f->arg_size;
+	if (inst->arg_size) {
+		inst->argp = kzalloc(inst->arg_size, GFP_KERNEL);
+		if (!inst->argp) {
+			r = -ENOMEM;
+			goto free;
+		}
+
+		argp = u64_to_user_ptr(f->arg);
+		if (copy_from_user(inst->argp, argp, f->arg_size)) {
+			r = -EFAULT;
+			goto free_arg;
+		}
+	}
+
+	inst->fn = gunyah_vm_get_function(f->type);
+	if (IS_ERR(inst->fn)) {
+		r = PTR_ERR(inst->fn);
+		goto free_arg;
+	}
+
+	inst->ghvm = ghvm;
+	inst->rm = ghvm->rm;
+
+	mutex_lock(&ghvm->fn_lock);
+	r = inst->fn->bind(inst);
+	if (r < 0) {
+		mutex_unlock(&ghvm->fn_lock);
+		gunyah_vm_put_function(inst->fn);
+		goto free_arg;
+	}
+
+	list_add(&inst->vm_list, &ghvm->functions);
+	mutex_unlock(&ghvm->fn_lock);
+
+	return r;
+free_arg:
+	kfree(inst->argp);
+free:
+	kfree(inst);
+	return r;
+}
+
+static long gunyah_vm_rm_function_instance(struct gunyah_vm *ghvm,
+					   struct gunyah_fn_desc *f)
+{
+	struct gunyah_vm_function_instance *inst, *iter;
+	void __user *user_argp;
+	void *argp;
+	long r = 0;
+
+	r = mutex_lock_interruptible(&ghvm->fn_lock);
+	if (r)
+		return r;
+
+	if (f->arg_size) {
+		argp = kzalloc(f->arg_size, GFP_KERNEL);
+		if (!argp) {
+			r = -ENOMEM;
+			goto out;
+		}
+
+		user_argp = u64_to_user_ptr(f->arg);
+		if (copy_from_user(argp, user_argp, f->arg_size)) {
+			r = -EFAULT;
+			kfree(argp);
+			goto out;
+		}
+
+		r = -ENOENT;
+		list_for_each_entry_safe(inst, iter, &ghvm->functions,
+					 vm_list) {
+			if (inst->fn->type == f->type &&
+			    inst->fn->compare(inst, argp, f->arg_size)) {
+				gunyah_vm_remove_function_instance(inst);
+				r = 0;
+			}
+		}
+
+		kfree(argp);
+	}
+
+out:
+	mutex_unlock(&ghvm->fn_lock);
+	return r;
+}
+
+int gunyah_vm_function_register(struct gunyah_vm_function *fn)
+{
+	if (!fn->bind || !fn->unbind)
+		return -EINVAL;
+
+	return xa_err(xa_store(&gunyah_vm_functions, fn->type, fn, GFP_KERNEL));
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_function_register);
+
+void gunyah_vm_function_unregister(struct gunyah_vm_function *fn)
+{
+	/* Expecting unregister to only come when unloading a module */
+	WARN_ON(fn->mod && module_refcount(fn->mod));
+	xa_erase(&gunyah_vm_functions, fn->type);
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_function_unregister);
+
 static int gunyah_vm_rm_notification_status(struct gunyah_vm *ghvm, void *data)
 {
 	struct gunyah_rm_vm_status_payload *payload = data;
@@ -91,7 +261,10 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 
 	init_rwsem(&ghvm->status_lock);
 	init_waitqueue_head(&ghvm->vm_status_wait);
+	kref_init(&ghvm->kref);
 	ghvm->vm_status = GUNYAH_RM_VM_STATUS_NO_STATE;
+	INIT_LIST_HEAD(&ghvm->functions);
+	mutex_init(&ghvm->fn_lock);
 
 	return ghvm;
 }
@@ -182,6 +355,7 @@ static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
 			    unsigned long arg)
 {
 	struct gunyah_vm *ghvm = filp->private_data;
+	void __user *argp = (void __user *)arg;
 	long r;
 
 	switch (cmd) {
@@ -189,6 +363,24 @@ static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
 		r = gunyah_vm_ensure_started(ghvm);
 		break;
 	}
+	case GUNYAH_VM_ADD_FUNCTION: {
+		struct gunyah_fn_desc f;
+
+		if (copy_from_user(&f, argp, sizeof(f)))
+			return -EFAULT;
+
+		r = gunyah_vm_add_function_instance(ghvm, &f);
+		break;
+	}
+	case GUNYAH_VM_REMOVE_FUNCTION: {
+		struct gunyah_fn_desc f;
+
+		if (copy_from_user(&f, argp, sizeof(f)))
+			return -EFAULT;
+
+		r = gunyah_vm_rm_function_instance(ghvm, &f);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 		break;
@@ -197,14 +389,22 @@ static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
 	return r;
 }
 
-static int gunyah_vm_release(struct inode *inode, struct file *filp)
+int __must_check gunyah_vm_get(struct gunyah_vm *ghvm)
 {
-	struct gunyah_vm *ghvm = filp->private_data;
+	return kref_get_unless_zero(&ghvm->kref);
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_get);
+
+static void _gunyah_vm_put(struct kref *kref)
+{
+	struct gunyah_vm *ghvm = container_of(kref, struct gunyah_vm, kref);
 	int ret;
 
 	if (ghvm->vm_status == GUNYAH_RM_VM_STATUS_RUNNING)
 		gunyah_vm_stop(ghvm);
 
+	gunyah_vm_remove_functions(ghvm);
+
 	if (ghvm->vm_status != GUNYAH_RM_VM_STATUS_NO_STATE &&
 	    ghvm->vm_status != GUNYAH_RM_VM_STATUS_LOAD &&
 	    ghvm->vm_status != GUNYAH_RM_VM_STATUS_RESET) {
@@ -227,6 +427,19 @@ static int gunyah_vm_release(struct inode *inode, struct file *filp)
 
 	gunyah_rm_put(ghvm->rm);
 	kfree(ghvm);
+}
+
+void gunyah_vm_put(struct gunyah_vm *ghvm)
+{
+	kref_put(&ghvm->kref, _gunyah_vm_put);
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_put);
+
+static int gunyah_vm_release(struct inode *inode, struct file *filp)
+{
+	struct gunyah_vm *ghvm = filp->private_data;
+
+	gunyah_vm_put(ghvm);
 	return 0;
 }
 
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index aa058722c5fe..a9e0eaf212fd 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -9,6 +9,8 @@
 #include <linux/device.h>
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
@@ -28,6 +30,10 @@ struct gunyah_vm {
 	enum gunyah_rm_vm_status vm_status;
 	wait_queue_head_t vm_status_wait;
 	struct rw_semaphore status_lock;
+
+	struct kref kref;
+	struct mutex fn_lock;
+	struct list_head functions;
 };
 
 #endif
diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
new file mode 100644
index 000000000000..f40e57f32fd8
--- /dev/null
+++ b/include/linux/gunyah_vm_mgr.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _GUNYAH_VM_MGR_H
+#define _GUNYAH_VM_MGR_H
+
+#include <linux/compiler_types.h>
+#include <linux/gunyah.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+#include <linux/notifier.h>
+
+#include <uapi/linux/gunyah.h>
+
+struct gunyah_vm;
+
+int __must_check gunyah_vm_get(struct gunyah_vm *ghvm);
+void gunyah_vm_put(struct gunyah_vm *ghvm);
+
+struct gunyah_vm_function_instance;
+/**
+ * struct gunyah_vm_function - Represents a function type
+ * @type: value from &enum gunyah_fn_type
+ * @name: friendly name for debug purposes
+ * @mod: owner of the function type
+ * @bind: Called when a new function of this type has been allocated.
+ * @unbind: Called when the function instance is being destroyed.
+ * @compare: Compare function instance @f's argument to the provided arg.
+ *           Return true if they are equivalent. Used on GUNYAH_VM_REMOVE_FUNCTION.
+ */
+struct gunyah_vm_function {
+	u32 type;
+	const char *name;
+	struct module *mod;
+	long (*bind)(struct gunyah_vm_function_instance *f);
+	void (*unbind)(struct gunyah_vm_function_instance *f);
+	bool (*compare)(const struct gunyah_vm_function_instance *f,
+			const void *arg, size_t size);
+};
+
+/**
+ * struct gunyah_vm_function_instance - Represents one function instance
+ * @arg_size: size of user argument
+ * @argp: pointer to user argument
+ * @ghvm: Pointer to VM instance
+ * @rm: Pointer to resource manager for the VM instance
+ * @fn: The ops for the function
+ * @data: Private data for function
+ * @vm_list: for gunyah_vm's functions list
+ * @fn_list: for gunyah_vm_function's instances list
+ */
+struct gunyah_vm_function_instance {
+	size_t arg_size;
+	void *argp;
+	struct gunyah_vm *ghvm;
+	struct gunyah_rm *rm;
+	struct gunyah_vm_function *fn;
+	void *data;
+	struct list_head vm_list;
+};
+
+int gunyah_vm_function_register(struct gunyah_vm_function *f);
+void gunyah_vm_function_unregister(struct gunyah_vm_function *f);
+
+/* Since the function identifiers were setup in a uapi header as an
+ * enum and we do no want to change that, the user must supply the expanded
+ * constant as well and the compiler checks they are the same.
+ * See also MODULE_ALIAS_RDMA_NETLINK.
+ */
+#define MODULE_ALIAS_GUNYAH_VM_FUNCTION(_type, _idx)        \
+	static inline void __maybe_unused __chk##_idx(void) \
+	{                                                   \
+		BUILD_BUG_ON(_type != _idx);                \
+	}                                                   \
+	MODULE_ALIAS("ghfunc:" __stringify(_idx))
+
+#define DECLARE_GUNYAH_VM_FUNCTION(_name, _type, _bind, _unbind, _compare) \
+	static struct gunyah_vm_function _name = {                         \
+		.type = _type,                                             \
+		.name = __stringify(_name),                                \
+		.mod = THIS_MODULE,                                        \
+		.bind = _bind,                                             \
+		.unbind = _unbind,                                         \
+		.compare = _compare,                                       \
+	}
+
+#define module_gunyah_vm_function(__gf)                  \
+	module_driver(__gf, gunyah_vm_function_register, \
+		      gunyah_vm_function_unregister)
+
+#define DECLARE_GUNYAH_VM_FUNCTION_INIT(_name, _type, _idx, _bind, _unbind, \
+					_compare)                           \
+	DECLARE_GUNYAH_VM_FUNCTION(_name, _type, _bind, _unbind, _compare); \
+	module_gunyah_vm_function(_name);                                   \
+	MODULE_ALIAS_GUNYAH_VM_FUNCTION(_type, _idx)
+
+#endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 31e7f79a6c39..1b7cb5fde70a 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -25,4 +25,22 @@
  */
 #define GUNYAH_VM_START		_IO(GUNYAH_IOCTL_TYPE, 0x3)
 
+#define GUNYAH_FN_MAX_ARG_SIZE		256
+
+/**
+ * struct gunyah_fn_desc - Arguments to create a VM function
+ * @type: Type of the function. See &enum gunyah_fn_type.
+ * @arg_size: Size of argument to pass to the function. arg_size <= GUNYAH_FN_MAX_ARG_SIZE
+ * @arg: Pointer to argument given to the function. See &enum gunyah_fn_type for expected
+ *       arguments for a function type.
+ */
+struct gunyah_fn_desc {
+	__u32 type;
+	__u32 arg_size;
+	__u64 arg;
+};
+
+#define GUNYAH_VM_ADD_FUNCTION	_IOW(GUNYAH_IOCTL_TYPE, 0x4, struct gunyah_fn_desc)
+#define GUNYAH_VM_REMOVE_FUNCTION	_IOW(GUNYAH_IOCTL_TYPE, 0x7, struct gunyah_fn_desc)
+
 #endif

-- 
2.43.0


