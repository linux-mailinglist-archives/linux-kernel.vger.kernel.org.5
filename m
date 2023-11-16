Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB07EE46C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjKPPa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjKPP33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:29:29 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE28D59;
        Thu, 16 Nov 2023 07:29:22 -0800 (PST)
X-UUID: e4748be4849411eea33bb35ae8d461a2-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YEFAQCpQtvPMpBSo+0cMK6dQupZwQxiYbPOQPkZ+ZA4=;
        b=TBbRaytWyspG0IoHdKU4JcQbhs3ub4hXc7g6prQ63sLl6rhsmv+KqtBFcsDbyyDPRvM+2L1SZpKZ8ZrkCfnAleqJTX1j+5/FD6M49ybc0sDdYud/RHzA04v9QY0bfi8xIOwaU5QXEH4A+9x47xZFCtU+0B7VdTuk7Vfb5vYKaEc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:3b6829eb-4a9a-42ce-aefd-842240feb41d,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:975c7995-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e4748be4849411eea33bb35ae8d461a2-20231116
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 945544173; Thu, 16 Nov 2023 23:29:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 23:29:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 16 Nov 2023 23:29:10 +0800
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
        "My Chuang" <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>,
        "Kevenny Hsieh" <kevenny.hsieh@mediatek.com>
Subject: [PATCH v7 09/16] virt: geniezone: Add irqfd support
Date:   Thu, 16 Nov 2023 23:27:49 +0800
Message-ID: <20231116152756.4250-10-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231116152756.4250-1-yi-de.wu@mediatek.com>
References: <20231116152756.4250-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.231500-8.000000
X-TMASE-MatchedRID: D+DNda75joyT+V7OGy1eF7CvlllU7Dl15E5u1OdPWsTgr/zYTDOZCJeq
        sXSeEviPpSHzbpDtJi1Yo3G+rvxrNao77AcuQhw7A9lly13c/gGZ2scyRQcerz6DYdLKc78CxfJ
        mJLSy2rYPRm7vZvATR5urMMf0bt5M/YThwZVOWJKmG+fak9r3agrefVId6fzVZ5yuplze9pssVU
        53f9voZBgdl9SWxnPJVoAmHMW7f3t/+iNkyaz33ws9VkfCh3uAEbs7d+z9c8vjsTquy0JRizzAK
        7q1A+IiJVwLGBypRhaJ2bX8lNKTfG1yv+64My/eQuFiD+xrWCwxXH/dlhvLv/t4POt4bDKR4nmg
        1woDU7al6qI2izqkidSArurYxE2pnZCu38NkgL9VXhlmZsTdjARryDXHx6oXDtPbEOCY2f6IbCF
        Fbr32N7FwN+qSs8wuYB7Rg0hkocmW+cf6nEkoSuQoIU4rAATMIZm2INWXDp4PIi+nG+iNN6nn4h
        ZeU6w6HEXpGNdFlNwRCKHXY1XXLGX3SpdG0+lWDB+ErBr0bAMrHkgIan9a0ddMDzSLr8ovZYNYI
        CIPuYi0xgJ2yHF4fogWROA0BBvYSwojFX8WCDC+dJWHbg4ITilayzmQ9QV0S4KPPiCB23AChdJp
        Cl+Gky37gDEBTOpEOME7yje9iCU9S3IiQd+eNeTuT3JcmKqqAZn/4A9db2SYFp2iw4hoIZPGlAh
        wdrelxHy4fm/VTOGAMuqetGVetnyef22ep6XYymsk/wUE4hrUENGIHh54I1gcOvuKrHxPCiCjfC
        6TUpYe73StWgtYZmBtnr1k76I4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.231500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4DDFD0CF141C87A694DA0C030A82BDBE24A075D4BC6B8AE1D01503D91233B6152000:8
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

irqfd enables other threads than vcpu threads to inject virtual
interrupt through irqfd asynchronously rather through ioctl interface.
This interface is necessary for VMM which creates separated thread for
IO handling or uses vhost devices.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: kevenny hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  18 ++
 drivers/virt/geniezone/Makefile         |   3 +-
 drivers/virt/geniezone/gzvm_irqfd.c     | 382 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_main.c      |  12 +-
 drivers/virt/geniezone/gzvm_vcpu.c      |   1 +
 drivers/virt/geniezone/gzvm_vm.c        |  18 ++
 include/linux/gzvm_drv.h                |  25 ++
 include/uapi/linux/gzvm.h               |  26 ++
 8 files changed, 483 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/geniezone/gzvm_irqfd.c

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 6338e88e98e1..0131dd04dd93 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -45,6 +45,8 @@ enum {
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 #define MT_HVC_GZVM_INFORM_EXIT		GZVM_HCALL_ID(GZVM_FUNC_INFORM_EXIT)
 
+#define GIC_V3_NR_LRS			16
+
 /**
  * gzvm_hypcall_wrapper() - the wrapper for hvc calls
  * @a0-a7: arguments passed in registers 0 to 7
@@ -68,6 +70,22 @@ static inline u16 get_vcpuid_from_tuple(unsigned int tuple)
 	return (u16)(tuple & 0xffff);
 }
 
+/**
+ * struct gzvm_vcpu_hwstate: Sync architecture state back to host for handling
+ * @nr_lrs: The available LRs(list registers) in Soc.
+ * @__pad: add an explicit '__u32 __pad;' in the middle to make it clear
+ *         what the actual layout is.
+ * @lr: The array of LRs(list registers).
+ *
+ * - Keep the same layout of hypervisor data struct.
+ * - Sync list registers back for acking virtual device interrupt status.
+ */
+struct gzvm_vcpu_hwstate {
+	__le32 nr_lrs;
+	__le32 __pad;
+	__le64 lr[GIC_V3_NR_LRS];
+};
+
 static inline unsigned int
 assemble_vm_vcpu_tuple(u16 vmid, u16 vcpuid)
 {
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index ad3a7a8b2fa4..05203166bf09 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -7,4 +7,5 @@
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_mmu.o \
-	  $(GZVM_DIR)/gzvm_vm.o $(GZVM_DIR)/gzvm_vcpu.o
+	  $(GZVM_DIR)/gzvm_vm.o $(GZVM_DIR)/gzvm_vcpu.o \
+	  $(GZVM_DIR)/gzvm_irqfd.o
diff --git a/drivers/virt/geniezone/gzvm_irqfd.c b/drivers/virt/geniezone/gzvm_irqfd.c
new file mode 100644
index 000000000000..fe77d074cf20
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_irqfd.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/eventfd.h>
+#include <linux/syscalls.h>
+#include <linux/gzvm_drv.h>
+#include "gzvm_common.h"
+
+struct gzvm_irq_ack_notifier {
+	struct hlist_node link;
+	unsigned int gsi;
+	void (*irq_acked)(struct gzvm_irq_ack_notifier *ian);
+};
+
+/**
+ * struct gzvm_kernel_irqfd: gzvm kernel irqfd descriptor.
+ * @gzvm: Pointer to struct gzvm.
+ * @wait: Wait queue entry.
+ * @gsi: Used for level IRQ fast-path.
+ * @eventfd: Used for setup/shutdown.
+ * @list: struct list_head.
+ * @pt: struct poll_table_struct.
+ * @shutdown: struct work_struct.
+ */
+struct gzvm_kernel_irqfd {
+	struct gzvm *gzvm;
+	wait_queue_entry_t wait;
+
+	int gsi;
+
+	struct eventfd_ctx *eventfd;
+	struct list_head list;
+	poll_table pt;
+	struct work_struct shutdown;
+};
+
+static struct workqueue_struct *irqfd_cleanup_wq;
+
+/**
+ * irqfd_set_irq(): irqfd to inject virtual interrupt.
+ * @gzvm: Pointer to gzvm.
+ * @irq: This is spi interrupt number (starts from 0 instead of 32).
+ * @level: irq triggered level.
+ */
+static void irqfd_set_irq(struct gzvm *gzvm, u32 irq, int level)
+{
+	if (level)
+		gzvm_irqchip_inject_irq(gzvm, 0, irq, level);
+}
+
+/**
+ * irqfd_shutdown() - Race-free decouple logic (ordering is critical).
+ * @work: Pointer to work_struct.
+ */
+static void irqfd_shutdown(struct work_struct *work)
+{
+	struct gzvm_kernel_irqfd *irqfd =
+		container_of(work, struct gzvm_kernel_irqfd, shutdown);
+	struct gzvm *gzvm = irqfd->gzvm;
+	u64 cnt;
+
+	/* Make sure irqfd has been initialized in assign path. */
+	synchronize_srcu(&gzvm->irq_srcu);
+
+	/*
+	 * Synchronize with the wait-queue and unhook ourselves to prevent
+	 * further events.
+	 */
+	eventfd_ctx_remove_wait_queue(irqfd->eventfd, &irqfd->wait, &cnt);
+
+	/*
+	 * It is now safe to release the object's resources
+	 */
+	eventfd_ctx_put(irqfd->eventfd);
+	kfree(irqfd);
+}
+
+/**
+ * irqfd_is_active() - Assumes gzvm->irqfds.lock is held.
+ * @irqfd: Pointer to gzvm_kernel_irqfd.
+ *
+ * Return:
+ * * true			- irqfd is active.
+ */
+static bool irqfd_is_active(struct gzvm_kernel_irqfd *irqfd)
+{
+	return list_empty(&irqfd->list) ? false : true;
+}
+
+/**
+ * irqfd_deactivate() - Mark the irqfd as inactive and schedule it for removal.
+ *			assumes gzvm->irqfds.lock is held.
+ * @irqfd: Pointer to gzvm_kernel_irqfd.
+ */
+static void irqfd_deactivate(struct gzvm_kernel_irqfd *irqfd)
+{
+	if (!irqfd_is_active(irqfd))
+		return;
+
+	list_del_init(&irqfd->list);
+
+	queue_work(irqfd_cleanup_wq, &irqfd->shutdown);
+}
+
+/**
+ * irqfd_wakeup() - Callback of irqfd wait queue, would be woken by writing to
+ *                  irqfd to do virtual interrupt injection.
+ * @wait: Pointer to wait_queue_entry_t.
+ * @mode: Unused.
+ * @sync: Unused.
+ * @key: Get flags about Epoll events.
+ *
+ * Return:
+ * * 0			- Success
+ */
+static int irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync,
+			void *key)
+{
+	struct gzvm_kernel_irqfd *irqfd =
+		container_of(wait, struct gzvm_kernel_irqfd, wait);
+	__poll_t flags = key_to_poll(key);
+	struct gzvm *gzvm = irqfd->gzvm;
+
+	if (flags & EPOLLIN) {
+		u64 cnt;
+
+		eventfd_ctx_do_read(irqfd->eventfd, &cnt);
+		/* gzvm's irq injection is not blocked, don't need workq */
+		irqfd_set_irq(gzvm, irqfd->gsi, 1);
+	}
+
+	if (flags & EPOLLHUP) {
+		/* The eventfd is closing, detach from GZVM */
+		unsigned long iflags;
+
+		spin_lock_irqsave(&gzvm->irqfds.lock, iflags);
+
+		/*
+		 * Do more check if someone deactivated the irqfd before
+		 * we could acquire the irqfds.lock.
+		 */
+		if (irqfd_is_active(irqfd))
+			irqfd_deactivate(irqfd);
+
+		spin_unlock_irqrestore(&gzvm->irqfds.lock, iflags);
+	}
+
+	return 0;
+}
+
+static void irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
+				    poll_table *pt)
+{
+	struct gzvm_kernel_irqfd *irqfd =
+		container_of(pt, struct gzvm_kernel_irqfd, pt);
+	add_wait_queue_priority(wqh, &irqfd->wait);
+}
+
+static int gzvm_irqfd_assign(struct gzvm *gzvm, struct gzvm_irqfd *args)
+{
+	struct gzvm_kernel_irqfd *irqfd, *tmp;
+	struct fd f;
+	struct eventfd_ctx *eventfd = NULL;
+	int ret;
+	int idx;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL_ACCOUNT);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->gzvm = gzvm;
+	irqfd->gsi = args->gsi;
+
+	INIT_LIST_HEAD(&irqfd->list);
+	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
+
+	f = fdget(args->fd);
+	if (!f.file) {
+		ret = -EBADF;
+		goto out;
+	}
+
+	eventfd = eventfd_ctx_fileget(f.file);
+	if (IS_ERR(eventfd)) {
+		ret = PTR_ERR(eventfd);
+		goto fail;
+	}
+
+	irqfd->eventfd = eventfd;
+
+	/*
+	 * Install our own custom wake-up handling so we are notified via
+	 * a callback whenever someone signals the underlying eventfd
+	 */
+	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
+	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
+
+	spin_lock_irq(&gzvm->irqfds.lock);
+
+	ret = 0;
+	list_for_each_entry(tmp, &gzvm->irqfds.items, list) {
+		if (irqfd->eventfd != tmp->eventfd)
+			continue;
+		/* This fd is used for another irq already. */
+		pr_err("already used: gsi=%d fd=%d\n", args->gsi, args->fd);
+		ret = -EBUSY;
+		spin_unlock_irq(&gzvm->irqfds.lock);
+		goto fail;
+	}
+
+	idx = srcu_read_lock(&gzvm->irq_srcu);
+
+	list_add_tail(&irqfd->list, &gzvm->irqfds.items);
+
+	spin_unlock_irq(&gzvm->irqfds.lock);
+
+	vfs_poll(f.file, &irqfd->pt);
+
+	srcu_read_unlock(&gzvm->irq_srcu, idx);
+
+	/*
+	 * do not drop the file until the irqfd is fully initialized, otherwise
+	 * we might race against the EPOLLHUP
+	 */
+	fdput(f);
+	return 0;
+
+fail:
+	if (eventfd && !IS_ERR(eventfd))
+		eventfd_ctx_put(eventfd);
+
+	fdput(f);
+
+out:
+	kfree(irqfd);
+	return ret;
+}
+
+static void gzvm_notify_acked_gsi(struct gzvm *gzvm, int gsi)
+{
+	struct gzvm_irq_ack_notifier *gian;
+
+	hlist_for_each_entry_srcu(gian, &gzvm->irq_ack_notifier_list,
+				  link, srcu_read_lock_held(&gzvm->irq_srcu))
+		if (gian->gsi == gsi)
+			gian->irq_acked(gian);
+}
+
+void gzvm_notify_acked_irq(struct gzvm *gzvm, unsigned int gsi)
+{
+	int idx;
+
+	idx = srcu_read_lock(&gzvm->irq_srcu);
+	gzvm_notify_acked_gsi(gzvm, gsi);
+	srcu_read_unlock(&gzvm->irq_srcu, idx);
+}
+
+/**
+ * gzvm_irqfd_deassign() - Shutdown any irqfd's that match fd+gsi.
+ * @gzvm: Pointer to gzvm.
+ * @args: Pointer to gzvm_irqfd.
+ *
+ * Return:
+ * * 0			- Success.
+ * * Negative value	- Failure.
+ */
+static int gzvm_irqfd_deassign(struct gzvm *gzvm, struct gzvm_irqfd *args)
+{
+	struct gzvm_kernel_irqfd *irqfd, *tmp;
+	struct eventfd_ctx *eventfd;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	spin_lock_irq(&gzvm->irqfds.lock);
+
+	list_for_each_entry_safe(irqfd, tmp, &gzvm->irqfds.items, list) {
+		if (irqfd->eventfd == eventfd && irqfd->gsi == args->gsi)
+			irqfd_deactivate(irqfd);
+	}
+
+	spin_unlock_irq(&gzvm->irqfds.lock);
+	eventfd_ctx_put(eventfd);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed
+	 * so that we guarantee there will not be any more interrupts on this
+	 * gsi once this deassign function returns.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+
+	return 0;
+}
+
+int gzvm_irqfd(struct gzvm *gzvm, struct gzvm_irqfd *args)
+{
+	for (int i = 0; i < ARRAY_SIZE(args->pad); i++) {
+		if (args->pad[i])
+			return -EINVAL;
+	}
+
+	if (args->flags &
+	    ~(GZVM_IRQFD_FLAG_DEASSIGN | GZVM_IRQFD_FLAG_RESAMPLE))
+		return -EINVAL;
+
+	if (args->flags & GZVM_IRQFD_FLAG_DEASSIGN)
+		return gzvm_irqfd_deassign(gzvm, args);
+
+	return gzvm_irqfd_assign(gzvm, args);
+}
+
+/**
+ * gzvm_vm_irqfd_init() - Initialize irqfd data structure per VM
+ *
+ * @gzvm: Pointer to struct gzvm.
+ *
+ * Return:
+ * * 0			- Success.
+ * * Negative		- Failure.
+ */
+int gzvm_vm_irqfd_init(struct gzvm *gzvm)
+{
+	mutex_init(&gzvm->irq_lock);
+
+	spin_lock_init(&gzvm->irqfds.lock);
+	INIT_LIST_HEAD(&gzvm->irqfds.items);
+	if (init_srcu_struct(&gzvm->irq_srcu))
+		return -EINVAL;
+	INIT_HLIST_HEAD(&gzvm->irq_ack_notifier_list);
+
+	return 0;
+}
+
+/**
+ * gzvm_vm_irqfd_release() - This function is called as the gzvm VM fd is being
+ *			  released. Shutdown all irqfds that still remain open.
+ * @gzvm: Pointer to gzvm.
+ */
+void gzvm_vm_irqfd_release(struct gzvm *gzvm)
+{
+	struct gzvm_kernel_irqfd *irqfd, *tmp;
+
+	spin_lock_irq(&gzvm->irqfds.lock);
+
+	list_for_each_entry_safe(irqfd, tmp, &gzvm->irqfds.items, list)
+		irqfd_deactivate(irqfd);
+
+	spin_unlock_irq(&gzvm->irqfds.lock);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+}
+
+/**
+ * gzvm_drv_irqfd_init() - Erase flushing work items when a VM exits.
+ *
+ * Return:
+ * * 0			- Success.
+ * * Negative		- Failure.
+ *
+ * Create a host-wide workqueue for issuing deferred shutdown requests
+ * aggregated from all vm* instances. We need our own isolated
+ * queue to ease flushing work items when a VM exits.
+ */
+int gzvm_drv_irqfd_init(void)
+{
+	irqfd_cleanup_wq = alloc_workqueue("gzvm-irqfd-cleanup", 0, 0);
+	if (!irqfd_cleanup_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void gzvm_drv_irqfd_exit(void)
+{
+	destroy_workqueue(irqfd_cleanup_wq);
+}
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index 30f6c3975026..4e5d1b83df4a 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -97,16 +97,26 @@ static struct miscdevice gzvm_dev = {
 
 static int gzvm_drv_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	if (gzvm_arch_probe() != 0) {
 		dev_err(&pdev->dev, "Not found available conduit\n");
 		return -ENODEV;
 	}
 
-	return misc_register(&gzvm_dev);
+	ret = misc_register(&gzvm_dev);
+	if (ret)
+		return ret;
+
+	ret = gzvm_drv_irqfd_init();
+	if (ret)
+		return ret;
+	return 0;
 }
 
 static int gzvm_drv_remove(struct platform_device *pdev)
 {
+	gzvm_drv_irqfd_exit();
 	gzvm_destroy_all_vms();
 	misc_deregister(&gzvm_dev);
 	return 0;
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 39c471d0d257..598f0ed2dbb5 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -228,6 +228,7 @@ int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid)
 		ret = -ENOMEM;
 		goto free_vcpu;
 	}
+	vcpu->hwstate = (void *)vcpu->run + PAGE_SIZE;
 	vcpu->vcpuid = cpuid;
 	vcpu->gzvm = gzvm;
 	mutex_init(&vcpu->lock);
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 8d6b7aebaf3a..2ab4391ff16a 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -213,6 +213,16 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_create_device(gzvm, argp);
 		break;
 	}
+	case GZVM_IRQFD: {
+		struct gzvm_irqfd data;
+
+		if (copy_from_user(&data, argp, sizeof(data))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = gzvm_irqfd(gzvm, &data);
+		break;
+	}
 	case GZVM_ENABLE_CAP: {
 		struct gzvm_enable_cap cap;
 
@@ -236,6 +246,7 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	mutex_lock(&gzvm->lock);
 
+	gzvm_vm_irqfd_release(gzvm);
 	gzvm_destroy_vcpus(gzvm);
 	gzvm_arch_destroy_vm(gzvm->vm_id);
 
@@ -281,6 +292,13 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	gzvm->mm = current->mm;
 	mutex_init(&gzvm->lock);
 
+	ret = gzvm_vm_irqfd_init(gzvm);
+	if (ret) {
+		pr_err("Failed to initialize irqfd\n");
+		kfree(gzvm);
+		return ERR_PTR(ret);
+	}
+
 	mutex_lock(&gzvm_list_lock);
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 805a866acecc..676e6b5714e8 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/gzvm.h>
+#include <linux/srcu.h>
 
 /*
  * For the normal physical address, the highest 12 bits should be zero, so we
@@ -30,6 +31,7 @@
 #define ERR_NOT_SUPPORTED       (-24)
 #define ERR_NOT_IMPLEMENTED     (-27)
 #define ERR_FAULT               (-40)
+#define GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID       1
 
 /*
  * The following data structures are for data transferring between driver and
@@ -73,6 +75,7 @@ struct gzvm_vcpu {
 	/* lock of vcpu*/
 	struct mutex lock;
 	struct gzvm_vcpu_run *run;
+	struct gzvm_vcpu_hwstate *hwstate;
 };
 
 struct gzvm {
@@ -82,8 +85,23 @@ struct gzvm {
 	struct gzvm_memslot memslot[GZVM_MAX_MEM_REGION];
 	/* lock for list_add*/
 	struct mutex lock;
+
+	struct {
+		/* lock for irqfds list operation */
+		spinlock_t        lock;
+		struct list_head  items;
+		struct list_head  resampler_list;
+		/* lock for irqfds resampler */
+		struct mutex      resampler_lock;
+	} irqfds;
+
 	struct list_head vm_list;
 	u16 vm_id;
+
+	struct hlist_head irq_ack_notifier_list;
+	struct srcu_struct irq_srcu;
+	/* lock for irq injection */
+	struct mutex irq_lock;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -124,4 +142,11 @@ int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
 int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
 			 u32 irq, bool level);
 
+void gzvm_notify_acked_irq(struct gzvm *gzvm, unsigned int gsi);
+int gzvm_irqfd(struct gzvm *gzvm, struct gzvm_irqfd *args);
+int gzvm_drv_irqfd_init(void);
+void gzvm_drv_irqfd_exit(void);
+int gzvm_vm_irqfd_init(struct gzvm *gzvm);
+void gzvm_vm_irqfd_release(struct gzvm *gzvm);
+
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index a1f6acdc4055..cb02f278972f 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -309,4 +309,30 @@ struct gzvm_one_reg {
 
 #define GZVM_REG_GENERIC	   0x0000000000000000ULL
 
+#define GZVM_IRQFD_FLAG_DEASSIGN	BIT(0)
+/*
+ * GZVM_IRQFD_FLAG_RESAMPLE indicates resamplefd is valid and specifies
+ * the irqfd to operate in resampling mode for level triggered interrupt
+ * emulation.
+ */
+#define GZVM_IRQFD_FLAG_RESAMPLE	BIT(1)
+
+/**
+ * struct gzvm_irqfd: gzvm irqfd descriptor
+ * @fd: File descriptor.
+ * @gsi: Used for level IRQ fast-path.
+ * @flags: FLAG_DEASSIGN or FLAG_RESAMPLE.
+ * @resamplefd: The file descriptor of the resampler.
+ * @pad: Reserved for future-proof.
+ */
+struct gzvm_irqfd {
+	__u32 fd;
+	__u32 gsi;
+	__u32 flags;
+	__u32 resamplefd;
+	__u8  pad[16];
+};
+
+#define GZVM_IRQFD	_IOW(GZVM_IOC_MAGIC, 0x76, struct gzvm_irqfd)
+
 #endif /* __GZVM_H__ */
-- 
2.18.0

