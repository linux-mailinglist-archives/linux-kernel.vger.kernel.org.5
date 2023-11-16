Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842E07EE45E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344523AbjKPP35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKPP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:29:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDAC19D;
        Thu, 16 Nov 2023 07:29:17 -0800 (PST)
X-UUID: e412a320849411eea33bb35ae8d461a2-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=x7mgq6gYJpGX02mqGI4yPEkd9f92NtfWuRnZH7Kwg0o=;
        b=HuPhnKtYvxBO+YcBcyqEcJ91/dP4c62f5qHT0rT5pojn5BboYTwNGQm46sLnYJyIFtO0fGUqLxasO6lP8eq3Vaty2Jhrzb937SYfUicIr1+m0VRZRHDx4AvAIeSUuy8pZifUDymQr7Urf83+/lY8rxhukQYCAE565bs9OEXMxHs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c27f31e0-9a79-4513-b920-7b0138e04dd8,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:efb79cfc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e412a320849411eea33bb35ae8d461a2-20231116
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1355780317; Thu, 16 Nov 2023 23:29:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 23:29:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 16 Nov 2023 23:29:09 +0800
From:   Yi-De Wu <yi-de.wu@mediatek.com>
To:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>,
        Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v7 07/16] virt: geniezone: Add vcpu support
Date:   Thu, 16 Nov 2023 23:27:47 +0800
Message-ID: <20231116152756.4250-8-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231116152756.4250-1-yi-de.wu@mediatek.com>
References: <20231116152756.4250-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

VMM use this interface to create vcpu instance which is a fd, and this
fd will be for any vcpu operations, such as setting vcpu registers and
accepts the most important ioctl GZVM_VCPU_RUN which requests GenieZone
hypervisor to do context switch to execute VM's vcpu context.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: kevenny hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/Makefile           |   2 +-
 arch/arm64/geniezone/gzvm_arch_common.h |  30 +++
 arch/arm64/geniezone/vcpu.c             |  80 ++++++++
 arch/arm64/geniezone/vm.c               |  12 ++
 drivers/virt/geniezone/Makefile         |   3 +-
 drivers/virt/geniezone/gzvm_vcpu.c      | 251 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vm.c        |   5 +
 include/linux/gzvm_drv.h                |  24 +++
 include/uapi/linux/gzvm.h               | 164 ++++++++++++++++
 9 files changed, 568 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/geniezone/vcpu.c
 create mode 100644 drivers/virt/geniezone/gzvm_vcpu.c

diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
index 2957898cdd05..69b0a4abeab0 100644
--- a/arch/arm64/geniezone/Makefile
+++ b/arch/arm64/geniezone/Makefile
@@ -4,6 +4,6 @@
 #
 include $(srctree)/drivers/virt/geniezone/Makefile
 
-gzvm-y += vm.o
+gzvm-y += vm.o vcpu.o
 
 obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index f286ad1efdf8..276c45337344 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -11,9 +11,15 @@
 enum {
 	GZVM_FUNC_CREATE_VM = 0,
 	GZVM_FUNC_DESTROY_VM = 1,
+	GZVM_FUNC_CREATE_VCPU = 2,
+	GZVM_FUNC_DESTROY_VCPU = 3,
 	GZVM_FUNC_SET_MEMREGION = 4,
+	GZVM_FUNC_RUN = 5,
+	GZVM_FUNC_GET_ONE_REG = 8,
+	GZVM_FUNC_SET_ONE_REG = 9,
 	GZVM_FUNC_PROBE = 12,
 	GZVM_FUNC_ENABLE_CAP = 13,
+	GZVM_FUNC_INFORM_EXIT = 14,
 	NR_GZVM_FUNC,
 };
 
@@ -25,9 +31,15 @@ enum {
 
 #define MT_HVC_GZVM_CREATE_VM		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VM)
 #define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
+#define MT_HVC_GZVM_CREATE_VCPU		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VCPU)
+#define MT_HVC_GZVM_DESTROY_VCPU	GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VCPU)
 #define MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
+#define MT_HVC_GZVM_RUN			GZVM_HCALL_ID(GZVM_FUNC_RUN)
+#define MT_HVC_GZVM_GET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_GET_ONE_REG)
+#define MT_HVC_GZVM_SET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_SET_ONE_REG)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
+#define MT_HVC_GZVM_INFORM_EXIT		GZVM_HCALL_ID(GZVM_FUNC_INFORM_EXIT)
 
 /**
  * gzvm_hypcall_wrapper() - the wrapper for hvc calls
@@ -47,4 +59,22 @@ static inline u16 get_vmid_from_tuple(unsigned int tuple)
 	return (u16)(tuple >> 16);
 }
 
+static inline u16 get_vcpuid_from_tuple(unsigned int tuple)
+{
+	return (u16)(tuple & 0xffff);
+}
+
+static inline unsigned int
+assemble_vm_vcpu_tuple(u16 vmid, u16 vcpuid)
+{
+	return ((unsigned int)vmid << 16 | vcpuid);
+}
+
+static inline void
+disassemble_vm_vcpu_tuple(unsigned int tuple, u16 *vmid, u16 *vcpuid)
+{
+	*vmid = get_vmid_from_tuple(tuple);
+	*vcpuid = get_vcpuid_from_tuple(tuple);
+}
+
 #endif /* __GZVM_ARCH_COMMON_H__ */
diff --git a/arch/arm64/geniezone/vcpu.c b/arch/arm64/geniezone/vcpu.c
new file mode 100644
index 000000000000..f6670bd77ad6
--- /dev/null
+++ b/arch/arm64/geniezone/vcpu.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/err.h>
+#include <linux/uaccess.h>
+
+#include <linux/gzvm.h>
+#include <linux/gzvm_drv.h>
+#include "gzvm_arch_common.h"
+
+int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
+				  bool is_write, __u64 *data)
+{
+	struct arm_smccc_res res;
+	unsigned long a1;
+	int ret;
+
+	a1 = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	if (!is_write) {
+		ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_GET_ONE_REG,
+					   a1, reg_id, 0, 0, 0, 0, 0, &res);
+		if (ret == 0)
+			*data = res.a1;
+	} else {
+		ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_ONE_REG,
+					   a1, reg_id, *data, 0, 0, 0, 0, &res);
+	}
+
+	return ret;
+}
+
+int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason)
+{
+	struct arm_smccc_res res;
+	unsigned long a1;
+	int ret;
+
+	a1 = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_RUN, a1, 0, 0, 0, 0, 0,
+				   0, &res);
+	*exit_reason = res.a1;
+	return ret;
+}
+
+int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid)
+{
+	struct arm_smccc_res res;
+	unsigned long a1;
+
+	a1 = assemble_vm_vcpu_tuple(vm_id, vcpuid);
+	gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VCPU, a1, 0, 0, 0, 0, 0, 0,
+			     &res);
+
+	return 0;
+}
+
+/**
+ * gzvm_arch_create_vcpu() - Call smc to gz hypervisor to create vcpu
+ * @vm_id: vm id
+ * @vcpuid: vcpu id
+ * @run: Virtual address of vcpu->run
+ *
+ * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
+ */
+int gzvm_arch_create_vcpu(u16 vm_id, int vcpuid, void *run)
+{
+	struct arm_smccc_res res;
+	unsigned long a1, a2;
+	int ret;
+
+	a1 = assemble_vm_vcpu_tuple(vm_id, vcpuid);
+	a2 = (__u64)virt_to_phys(run);
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VCPU, a1, a2, 0, 0, 0, 0,
+				   0, &res);
+
+	return ret;
+}
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index d6b3f148a823..b628aa506c2f 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -30,6 +30,18 @@ int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
 	return gzvm_err_to_errno(res->a0);
 }
 
+int gzvm_arch_inform_exit(u16 vm_id)
+{
+	struct arm_smccc_res res;
+	int ret;
+
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_INFORM_EXIT, vm_id, 0, 0, 0, 0, 0, 0, &res);
+	if (ret)
+		return -ENXIO;
+
+	return 0;
+}
+
 int gzvm_arch_probe(void)
 {
 	struct arm_smccc_res res;
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 43eba5cbbf4e..ad3a7a8b2fa4 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -7,5 +7,4 @@
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_mmu.o \
-	  $(GZVM_DIR)/gzvm_vm.o
-
+	  $(GZVM_DIR)/gzvm_vm.o $(GZVM_DIR)/gzvm_vcpu.o
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
new file mode 100644
index 000000000000..39c471d0d257
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <asm/sysreg.h>
+#include <linux/anon_inodes.h>
+#include <linux/device.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gzvm_drv.h>
+
+/* maximum size needed for holding an integer */
+#define ITOA_MAX_LEN 12
+
+static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu,
+				     void __user *argp,
+				     bool is_write)
+{
+	struct gzvm_one_reg reg;
+	void __user *reg_addr;
+	u64 data = 0;
+	u64 reg_size;
+	long ret;
+
+	if (copy_from_user(&reg, argp, sizeof(reg)))
+		return -EFAULT;
+
+	reg_addr = (void __user *)reg.addr;
+	reg_size = (reg.id & GZVM_REG_SIZE_MASK) >> GZVM_REG_SIZE_SHIFT;
+	reg_size = BIT(reg_size);
+
+	if (reg_size != 1 && reg_size != 2 && reg_size != 4 && reg_size != 8)
+		return -EINVAL;
+
+	if (is_write) {
+		/* GZ hypervisor would filter out invalid vcpu register access */
+		if (copy_from_user(&data, reg_addr, reg_size))
+			return -EFAULT;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	ret = gzvm_arch_vcpu_update_one_reg(vcpu, reg.id, is_write, &data);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * gzvm_vcpu_run() - Handle vcpu run ioctl, entry point to guest and exit
+ *		     point from guest
+ * @vcpu: Pointer to struct gzvm_vcpu
+ * @argp: Pointer to struct gzvm_vcpu_run in userspace
+ *
+ * Return:
+ * * 0			- Success.
+ * * Negative		- Failure.
+ */
+static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void __user *argp)
+{
+	bool need_userspace = false;
+	u64 exit_reason = 0;
+
+	if (copy_from_user(vcpu->run, argp, sizeof(struct gzvm_vcpu_run)))
+		return -EFAULT;
+
+	for (int i = 0; i < ARRAY_SIZE(vcpu->run->padding1); i++) {
+		if (vcpu->run->padding1[i])
+			return -EINVAL;
+	}
+
+	if (vcpu->run->immediate_exit == 1)
+		return -EINTR;
+
+	while (!need_userspace && !signal_pending(current)) {
+		gzvm_arch_vcpu_run(vcpu, &exit_reason);
+
+		switch (exit_reason) {
+		case GZVM_EXIT_MMIO:
+			need_userspace = true;
+			break;
+		/**
+		 * it's geniezone's responsibility to fill corresponding data
+		 * structure
+		 */
+		case GZVM_EXIT_HYPERCALL:
+			fallthrough;
+		case GZVM_EXIT_EXCEPTION:
+			fallthrough;
+		case GZVM_EXIT_DEBUG:
+			fallthrough;
+		case GZVM_EXIT_FAIL_ENTRY:
+			fallthrough;
+		case GZVM_EXIT_INTERNAL_ERROR:
+			fallthrough;
+		case GZVM_EXIT_SYSTEM_EVENT:
+			fallthrough;
+		case GZVM_EXIT_SHUTDOWN:
+			need_userspace = true;
+			break;
+		case GZVM_EXIT_IRQ:
+			fallthrough;
+		case GZVM_EXIT_GZ:
+			break;
+		case GZVM_EXIT_UNKNOWN:
+			fallthrough;
+		default:
+			pr_err("vcpu unknown exit\n");
+			need_userspace = true;
+			goto out;
+		}
+	}
+
+out:
+	if (copy_to_user(argp, vcpu->run, sizeof(struct gzvm_vcpu_run)))
+		return -EFAULT;
+	if (signal_pending(current)) {
+		// invoke hvc to inform gz to map memory
+		gzvm_arch_inform_exit(vcpu->gzvm->vm_id);
+		return -ERESTARTSYS;
+	}
+	return 0;
+}
+
+static long gzvm_vcpu_ioctl(struct file *filp, unsigned int ioctl,
+			    unsigned long arg)
+{
+	int ret = -ENOTTY;
+	void __user *argp = (void __user *)arg;
+	struct gzvm_vcpu *vcpu = filp->private_data;
+
+	switch (ioctl) {
+	case GZVM_RUN:
+		ret = gzvm_vcpu_run(vcpu, argp);
+		break;
+	case GZVM_GET_ONE_REG:
+		/* !is_write */
+		ret = -EOPNOTSUPP;
+		break;
+	case GZVM_SET_ONE_REG:
+		/* is_write */
+		ret = gzvm_vcpu_update_one_reg(vcpu, argp, true);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations gzvm_vcpu_fops = {
+	.unlocked_ioctl = gzvm_vcpu_ioctl,
+	.llseek		= noop_llseek,
+};
+
+/* caller must hold the vm lock */
+static void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu)
+{
+	if (!vcpu)
+		return;
+
+	gzvm_arch_destroy_vcpu(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	/* clean guest's data */
+	memset(vcpu->run, 0, GZVM_VCPU_RUN_MAP_SIZE);
+	free_pages_exact(vcpu->run, GZVM_VCPU_RUN_MAP_SIZE);
+	kfree(vcpu);
+}
+
+/**
+ * gzvm_destroy_vcpus() - Destroy all vcpus, caller has to hold the vm lock
+ *
+ * @gzvm: vm struct that owns the vcpus
+ */
+void gzvm_destroy_vcpus(struct gzvm *gzvm)
+{
+	int i;
+
+	for (i = 0; i < GZVM_MAX_VCPUS; i++) {
+		gzvm_destroy_vcpu(gzvm->vcpus[i]);
+		gzvm->vcpus[i] = NULL;
+	}
+}
+
+/* create_vcpu_fd() - Allocates an inode for the vcpu. */
+static int create_vcpu_fd(struct gzvm_vcpu *vcpu)
+{
+	/* sizeof("gzvm-vcpu:") + max(strlen(itoa(vcpuid))) + null */
+	char name[10 + ITOA_MAX_LEN + 1];
+
+	snprintf(name, sizeof(name), "gzvm-vcpu:%d", vcpu->vcpuid);
+	return anon_inode_getfd(name, &gzvm_vcpu_fops, vcpu, O_RDWR | O_CLOEXEC);
+}
+
+/**
+ * gzvm_vm_ioctl_create_vcpu() - for GZVM_CREATE_VCPU
+ * @gzvm: Pointer to struct gzvm
+ * @cpuid: equals arg
+ *
+ * Return: Fd of vcpu, negative errno if error occurs
+ */
+int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid)
+{
+	struct gzvm_vcpu *vcpu;
+	int ret;
+
+	if (cpuid >= GZVM_MAX_VCPUS)
+		return -EINVAL;
+
+	vcpu = kzalloc(sizeof(*vcpu), GFP_KERNEL);
+	if (!vcpu)
+		return -ENOMEM;
+
+	/**
+	 * Allocate 2 pages for data sharing between driver and gz hypervisor
+	 *
+	 * |- page 0           -|- page 1      -|
+	 * |gzvm_vcpu_run|......|hwstate|.......|
+	 *
+	 */
+	vcpu->run = alloc_pages_exact(GZVM_VCPU_RUN_MAP_SIZE,
+				      GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!vcpu->run) {
+		ret = -ENOMEM;
+		goto free_vcpu;
+	}
+	vcpu->vcpuid = cpuid;
+	vcpu->gzvm = gzvm;
+	mutex_init(&vcpu->lock);
+
+	ret = gzvm_arch_create_vcpu(gzvm->vm_id, vcpu->vcpuid, vcpu->run);
+	if (ret < 0)
+		goto free_vcpu_run;
+
+	ret = create_vcpu_fd(vcpu);
+	if (ret < 0)
+		goto free_vcpu_run;
+	gzvm->vcpus[cpuid] = vcpu;
+
+	return ret;
+
+free_vcpu_run:
+	free_pages_exact(vcpu->run, GZVM_VCPU_RUN_MAP_SIZE);
+free_vcpu:
+	kfree(vcpu);
+	return ret;
+}
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index ba6bfb7ee6e5..ab5a96400f3c 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -118,6 +118,10 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_dev_ioctl_check_extension(gzvm, arg);
 		break;
 	}
+	case GZVM_CREATE_VCPU: {
+		ret = gzvm_vm_ioctl_create_vcpu(gzvm, arg);
+		break;
+	}
 	case GZVM_SET_USER_MEMORY_REGION: {
 		struct gzvm_userspace_memory_region userspace_mem;
 
@@ -151,6 +155,7 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	mutex_lock(&gzvm->lock);
 
+	gzvm_destroy_vcpus(gzvm);
 	gzvm_arch_destroy_vm(gzvm->vm_id);
 
 	mutex_lock(&gzvm_list_lock);
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index a7d6df29b34e..a4203801740c 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -17,6 +17,7 @@
  */
 #define GZVM_PA_ERR_BAD (0x7ffULL << 52)
 
+#define GZVM_VCPU_MMAP_SIZE  PAGE_SIZE
 #define INVALID_VM_ID   0xffff
 
 /*
@@ -34,8 +35,11 @@
  * The following data structures are for data transferring between driver and
  * hypervisor, and they're aligned with hypervisor definitions
  */
+#define GZVM_MAX_VCPUS		 8
 #define GZVM_MAX_MEM_REGION	10
 
+#define GZVM_VCPU_RUN_MAP_SIZE		(PAGE_SIZE * 2)
+
 /* struct mem_region_addr_range - Identical to ffa memory constituent */
 struct mem_region_addr_range {
 	/* the base IPA of the constituent memory region, aligned to 4 kiB */
@@ -63,7 +67,16 @@ struct gzvm_memslot {
 	u32 slot_id;
 };
 
+struct gzvm_vcpu {
+	struct gzvm *gzvm;
+	int vcpuid;
+	/* lock of vcpu*/
+	struct mutex lock;
+	struct gzvm_vcpu_run *run;
+};
+
 struct gzvm {
+	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
 	/* userspace tied to this vm */
 	struct mm_struct *mm;
 	struct gzvm_memslot memslot[GZVM_MAX_MEM_REGION];
@@ -80,6 +93,8 @@ int gzvm_err_to_errno(unsigned long err);
 
 void gzvm_destroy_all_vms(void);
 
+void gzvm_destroy_vcpus(struct gzvm *gzvm);
+
 /* arch-dependant functions */
 int gzvm_arch_probe(void);
 int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
@@ -90,10 +105,19 @@ int gzvm_arch_destroy_vm(u16 vm_id);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
+
 u64 gzvm_hva_to_pa_arch(u64 hva);
 u64 hva_to_pa_fast(u64 hva);
 u64 hva_to_pa_slow(u64 hva);
 int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn);
 u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn);
 
+int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid);
+int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
+				  bool is_write, __u64 *data);
+int gzvm_arch_create_vcpu(u16 vm_id, int vcpuid, void *run);
+int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
+int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid);
+int gzvm_arch_inform_exit(u16 vm_id);
+
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 77a58ee085df..bdf277fa248a 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -25,6 +25,34 @@
 /* GZVM_CAP_PVM_SET_PROTECTED_VM only sets protected but not load pvmfw */
 #define GZVM_CAP_PVM_SET_PROTECTED_VM		2
 
+/*
+ * Architecture specific registers are to be defined and ORed with
+ * the arch identifier.
+ */
+#define GZVM_REG_ARCH_ARM64	0x6000000000000000ULL
+#define GZVM_REG_ARCH_MASK	0xff00000000000000ULL
+
+/*
+ * Reg size = BIT((reg.id & GZVM_REG_SIZE_MASK) >> GZVM_REG_SIZE_SHIFT) bytes
+ */
+#define GZVM_REG_SIZE_SHIFT	52
+#define GZVM_REG_SIZE_MASK	0x00f0000000000000ULL
+
+#define GZVM_REG_SIZE_U8	0x0000000000000000ULL
+#define GZVM_REG_SIZE_U16	0x0010000000000000ULL
+#define GZVM_REG_SIZE_U32	0x0020000000000000ULL
+#define GZVM_REG_SIZE_U64	0x0030000000000000ULL
+#define GZVM_REG_SIZE_U128	0x0040000000000000ULL
+#define GZVM_REG_SIZE_U256	0x0050000000000000ULL
+#define GZVM_REG_SIZE_U512	0x0060000000000000ULL
+#define GZVM_REG_SIZE_U1024	0x0070000000000000ULL
+#define GZVM_REG_SIZE_U2048	0x0080000000000000ULL
+
+/* Register type definitions */
+#define GZVM_REG_TYPE_SHIFT	16
+/* Register type: general purpose */
+#define GZVM_REG_TYPE_GENERAL	(0x10 << GZVM_REG_TYPE_SHIFT)
+
 /* GZVM ioctls */
 #define GZVM_IOC_MAGIC			0x92	/* gz */
 
@@ -51,6 +79,11 @@ struct gzvm_memory_region {
 
 #define GZVM_SET_MEMORY_REGION     _IOW(GZVM_IOC_MAGIC,  0x40, \
 					struct gzvm_memory_region)
+/*
+ * GZVM_CREATE_VCPU receives as a parameter the vcpu slot,
+ * and returns a vcpu fd.
+ */
+#define GZVM_CREATE_VCPU           _IO(GZVM_IOC_MAGIC,   0x41)
 
 /* for GZVM_SET_USER_MEMORY_REGION */
 struct gzvm_userspace_memory_region {
@@ -66,6 +99,124 @@ struct gzvm_userspace_memory_region {
 #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
 					 struct gzvm_userspace_memory_region)
 
+/*
+ * ioctls for vcpu fds
+ */
+#define GZVM_RUN                   _IO(GZVM_IOC_MAGIC,   0x80)
+
+/* VM exit reason */
+enum {
+	GZVM_EXIT_UNKNOWN = 0x92920000,
+	GZVM_EXIT_MMIO = 0x92920001,
+	GZVM_EXIT_HYPERCALL = 0x92920002,
+	GZVM_EXIT_IRQ = 0x92920003,
+	GZVM_EXIT_EXCEPTION = 0x92920004,
+	GZVM_EXIT_DEBUG = 0x92920005,
+	GZVM_EXIT_FAIL_ENTRY = 0x92920006,
+	GZVM_EXIT_INTERNAL_ERROR = 0x92920007,
+	GZVM_EXIT_SYSTEM_EVENT = 0x92920008,
+	GZVM_EXIT_SHUTDOWN = 0x92920009,
+	GZVM_EXIT_GZ = 0x9292000a,
+};
+
+/**
+ * struct gzvm_vcpu_run: Same purpose as kvm_run, this struct is
+ *			shared between userspace, kernel and
+ *			GenieZone hypervisor
+ * @exit_reason: The reason why gzvm_vcpu_run has stopped running the vCPU
+ * @immediate_exit: Polled when the vcpu is scheduled.
+ *                  If set, immediately returns -EINTR
+ * @padding1: Reserved for future-proof and must be zero filled
+ * @mmio: The nested struct in anonymous union. Handle mmio in host side
+ * @phys_addr: The address guest tries to access
+ * @data: The value to be written (is_write is 1) or
+ *        be filled by user for reads (is_write is 0)
+ * @size: The size of written data.
+ *        Only the first `size` bytes of `data` are handled
+ * @reg_nr: The register number where the data is stored
+ * @is_write: 1 for VM to perform a write or 0 for VM to perform a read
+ * @fail_entry: The nested struct in anonymous union.
+ *              Handle invalid entry address at the first run
+ * @hardware_entry_failure_reason: The reason codes about hardware entry failure
+ * @cpu: The current processor number via smp_processor_id()
+ * @exception: The nested struct in anonymous union.
+ *             Handle exception occurred in VM
+ * @exception: Which exception vector
+ * @error_code: Exception error codes
+ * @hypercall: The nested struct in anonymous union.
+ *             Some hypercalls issued from VM must be handled
+ * @args: The hypercall's arguments
+ * @internal: The nested struct in anonymous union. The errors from hypervisor
+ * @suberror: The errors codes about GZVM_EXIT_INTERNAL_ERROR
+ * @ndata: The number of elements used in data[]
+ * @data: Keep the detailed information about GZVM_EXIT_INTERNAL_ERROR
+ * @system_event: The nested struct in anonymous union.
+ *                VM's PSCI must be handled by host
+ * @type: System event type.
+ *        Ex. GZVM_SYSTEM_EVENT_SHUTDOWN or GZVM_SYSTEM_EVENT_RESET...etc.
+ * @ndata: The number of elements used in data[]
+ * @data: Keep the detailed information about GZVM_EXIT_SYSTEM_EVENT
+ * @padding: Fix it to a reasonable size future-proof for keeping the same
+ *           struct size when adding new variables in the union is needed
+ *
+ * Keep identical layout between the 3 modules
+ */
+struct gzvm_vcpu_run {
+	/* to userspace */
+	__u32 exit_reason;
+	__u8 immediate_exit;
+	__u8 padding1[3];
+	/* union structure of collection of guest exit reason */
+	union {
+		/* GZVM_EXIT_MMIO */
+		struct {
+			/* from FAR_EL2 */
+			__u64 phys_addr;
+			__u8 data[8];
+			/* from ESR_EL2 as */
+			__u64 size;
+			/* from ESR_EL2 */
+			__u32 reg_nr;
+			/* from ESR_EL2 */
+			__u8 is_write;
+		} mmio;
+		/* GZVM_EXIT_FAIL_ENTRY */
+		struct {
+			__u64 hardware_entry_failure_reason;
+			__u32 cpu;
+		} fail_entry;
+		/* GZVM_EXIT_EXCEPTION */
+		struct {
+			__u32 exception;
+			__u32 error_code;
+		} exception;
+		/* GZVM_EXIT_HYPERCALL */
+		struct {
+			__u64 args[8];	/* in-out */
+		} hypercall;
+		/* GZVM_EXIT_INTERNAL_ERROR */
+		struct {
+			__u32 suberror;
+			__u32 ndata;
+			__u64 data[16];
+		} internal;
+		/* GZVM_EXIT_SYSTEM_EVENT */
+		struct {
+#define GZVM_SYSTEM_EVENT_SHUTDOWN       1
+#define GZVM_SYSTEM_EVENT_RESET          2
+#define GZVM_SYSTEM_EVENT_CRASH          3
+#define GZVM_SYSTEM_EVENT_WAKEUP         4
+#define GZVM_SYSTEM_EVENT_SUSPEND        5
+#define GZVM_SYSTEM_EVENT_SEV_TERM       6
+#define GZVM_SYSTEM_EVENT_S2IDLE         7
+			__u32 type;
+			__u32 ndata;
+			__u64 data[16];
+		} system_event;
+		char padding[256];
+	};
+};
+
 /**
  * struct gzvm_enable_cap: The `capability support` on GenieZone hypervisor
  * @cap: `GZVM_CAP_ARM_PROTECTED_VM` or `GZVM_CAP_ARM_VM_IPA_SIZE`
@@ -79,4 +230,17 @@ struct gzvm_enable_cap {
 #define GZVM_ENABLE_CAP            _IOW(GZVM_IOC_MAGIC,  0xa3, \
 					struct gzvm_enable_cap)
 
+/* for GZVM_GET/SET_ONE_REG */
+struct gzvm_one_reg {
+	__u64 id;
+	__u64 addr;
+};
+
+#define GZVM_GET_ONE_REG	   _IOW(GZVM_IOC_MAGIC,  0xab, \
+					struct gzvm_one_reg)
+#define GZVM_SET_ONE_REG	   _IOW(GZVM_IOC_MAGIC,  0xac, \
+					struct gzvm_one_reg)
+
+#define GZVM_REG_GENERIC	   0x0000000000000000ULL
+
 #endif /* __GZVM_H__ */
-- 
2.18.0

