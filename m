Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5EE7A60D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjISLNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjISLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:12:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822AEF7;
        Tue, 19 Sep 2023 04:12:50 -0700 (PDT)
X-UUID: 72e2c9f856dd11ee8051498923ad61e6-20230919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wsK1/eZSmMqEjydw3iWNH1+7tn33AYiSxM6eMa+gzkQ=;
        b=OhqXgA5AJkp8qd6N47D9cZLsIVeDo6kxlXhw3xVrbi4WFtajzR8SeCZYyQEJK20vate+OfcNWcyIbG+mSpO6vPKbR80rJepsT3I6rWwiYYN5QBrQhcSoLnXoYwQBAjfbGwnsL9iI9bIZ1DDBsphvlO6A4RlljHaBIflTceHbxwc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:59ae8e61-2561-469d-ac84-da38df4b9c40,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:65581e14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 72e2c9f856dd11ee8051498923ad61e6-20230919
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1818706195; Tue, 19 Sep 2023 19:12:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Sep 2023 19:12:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Sep 2023 19:12:39 +0800
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
        Kevenny Hsieh <kevenny.hsieh@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: [PATCH v6 04/15] virt: geniezone: Add vm support
Date:   Tue, 19 Sep 2023 19:11:59 +0800
Message-ID: <20230919111210.19615-5-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230919111210.19615-1-yi-de.wu@mediatek.com>
References: <20230919111210.19615-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

The VM component is responsible for setting up the capability and memory
management for the protected VMs. The capability is mainly about the
lifecycle control and boot context initialization.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 MAINTAINERS                             |   1 +
 arch/arm64/geniezone/gzvm_arch_common.h |   9 ++
 arch/arm64/geniezone/vm.c               |  29 +++++++
 drivers/virt/geniezone/Makefile         |   2 +-
 drivers/virt/geniezone/gzvm_main.c      |  19 +++++
 drivers/virt/geniezone/gzvm_vm.c        | 107 ++++++++++++++++++++++++
 include/linux/gzvm_drv.h                |  26 ++++++
 include/uapi/linux/gzvm.h               |  25 ++++++
 8 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/geniezone/gzvm_vm.c
 create mode 100644 include/uapi/linux/gzvm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a9890520566..8ff417653f21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8806,6 +8806,7 @@ F:	Documentation/virt/geniezone/
 F:	arch/arm64/geniezone/
 F:	drivers/virt/geniezone/
 F:	include/linux/gzvm_drv.h
+F:	include/uapi/linux/gzvm.h
 
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 402f5ef7dfb4..f4439e43b018 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -9,6 +9,8 @@
 #include <linux/arm-smccc.h>
 
 enum {
+	GZVM_FUNC_CREATE_VM = 0,
+	GZVM_FUNC_DESTROY_VM = 1,
 	GZVM_FUNC_PROBE = 12,
 	NR_GZVM_FUNC,
 };
@@ -19,6 +21,8 @@ enum {
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32,	\
 			   SMC_ENTITY_MTK, (GZVM_FUNCID_START + (func)))
 
+#define MT_HVC_GZVM_CREATE_VM		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VM)
+#define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 
 /**
@@ -38,4 +42,9 @@ static inline int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
 	return gzvm_err_to_errno(res->a0);
 }
 
+static inline u16 get_vmid_from_tuple(unsigned int tuple)
+{
+	return (u16)(tuple >> 16);
+}
+
 #endif /* __GZVM_ARCH_COMMON_H__ */
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index dc52150790ef..a17bc628a496 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -7,9 +7,12 @@
 #include <linux/err.h>
 #include <linux/uaccess.h>
 
+#include <linux/gzvm.h>
 #include <linux/gzvm_drv.h>
 #include "gzvm_arch_common.h"
 
+#define PAR_PA47_MASK ((((1UL << 48) - 1) >> 12) << 12)
+
 int gzvm_arch_probe(void)
 {
 	struct arm_smccc_res res;
@@ -20,3 +23,29 @@ int gzvm_arch_probe(void)
 
 	return 0;
 }
+
+/**
+ * gzvm_arch_create_vm() - create vm
+ * @vm_type: VM type. Only supports Linux VM now.
+ *
+ * Return:
+ * * positive value	- VM ID
+ * * -ENOMEM		- Memory not enough for storing VM data
+ */
+int gzvm_arch_create_vm(unsigned long vm_type)
+{
+	struct arm_smccc_res res;
+	int ret;
+
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VM, vm_type, 0, 0, 0, 0,
+				   0, 0, &res);
+	return ret ? ret : res.a1;
+}
+
+int gzvm_arch_destroy_vm(u16 vm_id)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VM, vm_id, 0, 0, 0, 0,
+				    0, 0, &res);
+}
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 8c1f0053e773..066efddc0b9c 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -6,5 +6,5 @@
 
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
-gzvm-y := $(GZVM_DIR)/gzvm_main.o
+gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o
 
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index f7d4f0646d97..4e7d60067c55 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/file.h>
 #include <linux/kdev_t.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -40,7 +41,24 @@ int gzvm_err_to_errno(unsigned long err)
 	return -EINVAL;
 }
 
+static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long user_args)
+{
+	long ret;
+
+	switch (cmd) {
+	case GZVM_CREATE_VM:
+		ret = gzvm_dev_ioctl_create_vm(user_args);
+		return ret;
+	default:
+		break;
+	}
+
+	return -ENOTTY;
+}
+
 static const struct file_operations gzvm_chardev_ops = {
+	.unlocked_ioctl = gzvm_dev_ioctl,
 	.llseek		= noop_llseek,
 };
 
@@ -62,6 +80,7 @@ static int gzvm_drv_probe(struct platform_device *pdev)
 
 static int gzvm_drv_remove(struct platform_device *pdev)
 {
+	gzvm_destroy_all_vms();
 	misc_deregister(&gzvm_dev);
 	return 0;
 }
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
new file mode 100644
index 000000000000..d5e850af924a
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/kdev_t.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gzvm_drv.h>
+
+static DEFINE_MUTEX(gzvm_list_lock);
+static LIST_HEAD(gzvm_list);
+
+static void gzvm_destroy_vm(struct gzvm *gzvm)
+{
+	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
+
+	mutex_lock(&gzvm->lock);
+
+	gzvm_arch_destroy_vm(gzvm->vm_id);
+
+	mutex_lock(&gzvm_list_lock);
+	list_del(&gzvm->vm_list);
+	mutex_unlock(&gzvm_list_lock);
+
+	mutex_unlock(&gzvm->lock);
+
+	kfree(gzvm);
+}
+
+static int gzvm_vm_release(struct inode *inode, struct file *filp)
+{
+	struct gzvm *gzvm = filp->private_data;
+
+	gzvm_destroy_vm(gzvm);
+	return 0;
+}
+
+static const struct file_operations gzvm_vm_fops = {
+	.release        = gzvm_vm_release,
+	.llseek		= noop_llseek,
+};
+
+static struct gzvm *gzvm_create_vm(unsigned long vm_type)
+{
+	int ret;
+	struct gzvm *gzvm;
+
+	gzvm = kzalloc(sizeof(*gzvm), GFP_KERNEL);
+	if (!gzvm)
+		return ERR_PTR(-ENOMEM);
+
+	ret = gzvm_arch_create_vm(vm_type);
+	if (ret < 0) {
+		kfree(gzvm);
+		return ERR_PTR(ret);
+	}
+
+	gzvm->vm_id = ret;
+	gzvm->mm = current->mm;
+	mutex_init(&gzvm->lock);
+
+	mutex_lock(&gzvm_list_lock);
+	list_add(&gzvm->vm_list, &gzvm_list);
+	mutex_unlock(&gzvm_list_lock);
+
+	pr_debug("VM-%u is created\n", gzvm->vm_id);
+
+	return gzvm;
+}
+
+/**
+ * gzvm_dev_ioctl_create_vm - Create vm fd
+ * @vm_type: VM type. Only supports Linux VM now.
+ *
+ * Return: fd of vm, negative if error
+ */
+int gzvm_dev_ioctl_create_vm(unsigned long vm_type)
+{
+	struct gzvm *gzvm;
+
+	gzvm = gzvm_create_vm(vm_type);
+	if (IS_ERR(gzvm))
+		return PTR_ERR(gzvm);
+
+	return anon_inode_getfd("gzvm-vm", &gzvm_vm_fops, gzvm,
+			       O_RDWR | O_CLOEXEC);
+}
+
+void gzvm_destroy_all_vms(void)
+{
+	struct gzvm *gzvm, *tmp;
+
+	mutex_lock(&gzvm_list_lock);
+	if (list_empty(&gzvm_list))
+		goto out;
+
+	list_for_each_entry_safe(gzvm, tmp, &gzvm_list, vm_list)
+		gzvm_destroy_vm(gzvm);
+
+out:
+	mutex_unlock(&gzvm_list_lock);
+}
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 907f2f984de9..f1dce23838e4 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -6,6 +6,12 @@
 #ifndef __GZVM_DRV_H__
 #define __GZVM_DRV_H__
 
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/gzvm.h>
+
+#define INVALID_VM_ID   0xffff
+
 /*
  * These are the definitions of APIs between GenieZone hypervisor and driver,
  * there's no need to be visible to uapi. Furthermore, we need GenieZone
@@ -17,9 +23,29 @@
 #define ERR_NOT_IMPLEMENTED     (-27)
 #define ERR_FAULT               (-40)
 
+/*
+ * The following data structures are for data transferring between driver and
+ * hypervisor, and they're aligned with hypervisor definitions
+ */
+
+struct gzvm {
+	/* userspace tied to this vm */
+	struct mm_struct *mm;
+	/* lock for list_add*/
+	struct mutex lock;
+	struct list_head vm_list;
+	u16 vm_id;
+};
+
+int gzvm_dev_ioctl_create_vm(unsigned long vm_type);
+
 int gzvm_err_to_errno(unsigned long err);
 
+void gzvm_destroy_all_vms(void);
+
 /* arch-dependant functions */
 int gzvm_arch_probe(void);
+int gzvm_arch_create_vm(unsigned long vm_type);
+int gzvm_arch_destroy_vm(u16 vm_id);
 
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
new file mode 100644
index 000000000000..c26c7720fab7
--- /dev/null
+++ b/include/uapi/linux/gzvm.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+/**
+ * DOC: UAPI of GenieZone Hypervisor
+ *
+ * This file declares common data structure shared among user space,
+ * kernel space, and GenieZone hypervisor.
+ */
+#ifndef __GZVM_H__
+#define __GZVM_H__
+
+#include <linux/const.h>
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* GZVM ioctls */
+#define GZVM_IOC_MAGIC			0x92	/* gz */
+
+/* ioctls for /dev/gzvm fds */
+#define GZVM_CREATE_VM             _IO(GZVM_IOC_MAGIC,   0x01) /* Returns a Geniezone VM fd */
+
+#endif /* __GZVM_H__ */
-- 
2.18.0

