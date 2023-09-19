Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5377A60EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjISLOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjISLND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:13:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7A118;
        Tue, 19 Sep 2023 04:12:54 -0700 (PDT)
X-UUID: 743a7b5256dd11ee8051498923ad61e6-20230919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DUcoGtAYHoFI1ruAGw3mT00nT3wQL/qjXv5AAFn7SOs=;
        b=Ju9SvvvcdSn/4CyodrrSJZHUXR7ZVyIn1nNyoYN7F1qbhNizyf4l+aqinYhHRWyaT0BP4P6A93RAIAW6tgQwHLV+w44EzBPH48AQv2j/F8alJmmKYd+k2kIBPeqkimyKrBj7nznJdj+ivvBSEZuLUu/S4r74PGO6xxQuhtVE20k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c709b901-a9b7-4534-8b1a-3bd3f11c1f67,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:372604bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 743a7b5256dd11ee8051498923ad61e6-20230919
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1034992928; Tue, 19 Sep 2023 19:12:43 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Sep 2023 19:12:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Sep 2023 19:12:41 +0800
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
Subject: [PATCH v6 14/15] virt: geniezone: Add memory pin/unpin support
Date:   Tue, 19 Sep 2023 19:12:09 +0800
Message-ID: <20230919111210.19615-15-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230919111210.19615-1-yi-de.wu@mediatek.com>
References: <20230919111210.19615-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

From: "Jerry Wang" <ze-yu.wang@mediatek.com>

Protected VM's memory cannot be swapped out because the memory pages are
protected from host access.

Once host accesses to those protected pages, the hardware exception is
triggered and may crash the host. So, we have to make those protected
pages be ineligible for swapping or merging by the host kernel to avoid
host access. To do so, we pin the page when it is assigned (donated) to
VM and unpin when VM relinquish the pages or is destroyed. Besides, the
protected VM’s memory requires hypervisor to clear the content before
returning to host, but VMM may free those memory before clearing, it
will result in those memory pages are reclaimed and reused before
totally clearing. Using pin/unpin can also avoid the above problems.

The implementation is described as follows.
- Use rb_tree to store pinned memory pages.
- Pin the page when handling page fault.
- Unpin the pages when VM relinquish the pages or is destroyed.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 drivers/virt/geniezone/gzvm_exception.c | 28 ++++++++
 drivers/virt/geniezone/gzvm_mmu.c       | 89 +++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vcpu.c      |  7 +-
 drivers/virt/geniezone/gzvm_vm.c        | 18 +++++
 include/linux/gzvm_drv.h                | 13 ++++
 include/uapi/linux/gzvm.h               |  5 ++
 6 files changed, 157 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/geniezone/gzvm_exception.c b/drivers/virt/geniezone/gzvm_exception.c
index 31fdb4ae8db4..58d1ce305cf7 100644
--- a/drivers/virt/geniezone/gzvm_exception.c
+++ b/drivers/virt/geniezone/gzvm_exception.c
@@ -37,3 +37,31 @@ bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu)
 	else
 		return false;
 }
+
+/**
+ * gzvm_handle_guest_hvc() - Handle guest hvc
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ * Return:
+ * * true - This hvc has been processed, no need to back to VMM.
+ * * false - This hvc has not been processed, require userspace.
+ */
+bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu)
+{
+	unsigned long ipa;
+	int ret;
+
+	switch (vcpu->run->hypercall.args[0]) {
+	case GZVM_HVC_MEM_RELINQUISH:
+		ipa = vcpu->run->hypercall.args[1];
+		ret = gzvm_handle_relinquish(vcpu, ipa);
+		break;
+	default:
+		ret = false;
+		break;
+	}
+
+	if (!ret)
+		return true;
+	else
+		return false;
+}
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
index 4fdbdd8e809d..542599f104db 100644
--- a/drivers/virt/geniezone/gzvm_mmu.c
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -107,6 +107,78 @@ int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn,
 	return 0;
 }
 
+static int cmp_ppages(struct rb_node *node, const struct rb_node *parent)
+{
+	struct gzvm_pinned_page *a = container_of(node,
+						  struct gzvm_pinned_page,
+						  node);
+	struct gzvm_pinned_page *b = container_of(parent,
+						  struct gzvm_pinned_page,
+						  node);
+
+	if (a->ipa < b->ipa)
+		return -1;
+	if (a->ipa > b->ipa)
+		return 1;
+	return 0;
+}
+
+static int rb_ppage_cmp(const void *key, const struct rb_node *node)
+{
+	struct gzvm_pinned_page *p = container_of(node,
+						  struct gzvm_pinned_page,
+						  node);
+	phys_addr_t ipa = (phys_addr_t)key;
+
+	return (ipa < p->ipa) ? -1 : (ipa > p->ipa);
+}
+
+static int gzvm_insert_ppage(struct gzvm *vm, struct gzvm_pinned_page *ppage)
+{
+	if (rb_find_add(&ppage->node, &vm->pinned_pages, cmp_ppages))
+		return -EEXIST;
+	return 0;
+}
+
+static int pin_one_page(unsigned long hva, struct page **page)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned int flags = FOLL_HWPOISON | FOLL_LONGTERM | FOLL_WRITE;
+
+	mmap_read_lock(mm);
+	pin_user_pages(hva, 1, flags, page);
+	mmap_read_unlock(mm);
+
+	return 0;
+}
+
+/**
+ * gzvm_handle_relinquish() - Handle memory relinquish request from hypervisor
+ *
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ * @ipa: Start address(gpa) of a reclaimed page
+ *
+ * Return: Always return 0 because there are no cases of failure
+ */
+int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa)
+{
+	struct gzvm_pinned_page *ppage;
+	struct rb_node *node;
+	struct gzvm *vm = vcpu->gzvm;
+
+	node = rb_find((void *)ipa, &vm->pinned_pages, rb_ppage_cmp);
+
+	if (node)
+		rb_erase(node, &vm->pinned_pages);
+	else
+		return 0;
+
+	ppage = container_of(node, struct gzvm_pinned_page, node);
+	unpin_user_pages_dirty_lock(&ppage->page, 1, true);
+	kfree(ppage);
+	return 0;
+}
+
 /**
  * gzvm_handle_page_fault() - Handle guest page fault, find corresponding page
  *                            for the faulting gpa
@@ -118,7 +190,10 @@ int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn,
  */
 int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu)
 {
+	struct gzvm_pinned_page *ppage = NULL;
 	struct gzvm *vm = vcpu->gzvm;
+	struct page *page = NULL;
+	unsigned long hva;
 	u64 pfn, gfn;
 	int memslot_id;
 	int ret;
@@ -136,5 +211,19 @@ int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu)
 	if (unlikely(ret))
 		return -EFAULT;
 
+	hva = gzvm_gfn_to_hva_memslot(&vm->memslot[memslot_id], gfn);
+	pin_one_page(hva, &page);
+
+	if (!page)
+		return -EFAULT;
+
+	ppage = kmalloc(sizeof(*ppage), GFP_KERNEL_ACCOUNT);
+	if (!ppage)
+		return -ENOMEM;
+
+	ppage->page = page;
+	ppage->ipa = vcpu->run->exception.fault_gpa;
+	gzvm_insert_ppage(vm, ppage);
+
 	return 0;
 }
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 0c62fe7f2c37..c3d84644c3eb 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -36,8 +36,7 @@ static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu,
 		return -EINVAL;
 
 	if (is_write) {
-		if (vcpu->vcpuid > 0)
-			return -EPERM;
+		/* GZ hypervisor would filter out invalid vcpu register access */
 		if (copy_from_user(&data, reg_addr, reg_size))
 			return -EFAULT;
 	} else {
@@ -119,7 +118,9 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
 				need_userspace = true;
 			break;
 		case GZVM_EXIT_HYPERCALL:
-			fallthrough;
+			if (!gzvm_handle_guest_hvc(vcpu))
+				need_userspace = true;
+			break;
 		case GZVM_EXIT_DEBUG:
 			fallthrough;
 		case GZVM_EXIT_FAIL_ENTRY:
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 9f7e44521de5..747e5cf523bf 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -292,6 +292,21 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 	return ret;
 }
 
+static void gzvm_destroy_ppage(struct gzvm *gzvm)
+{
+	struct gzvm_pinned_page *ppage;
+	struct rb_node *node;
+
+	node = rb_first(&gzvm->pinned_pages);
+	while (node) {
+		ppage = rb_entry(node, struct gzvm_pinned_page, node);
+		unpin_user_pages_dirty_lock(&ppage->page, 1, true);
+		node = rb_next(node);
+		rb_erase(&ppage->node, &gzvm->pinned_pages);
+		kfree(ppage);
+	}
+}
+
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
 	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
@@ -308,6 +323,8 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	mutex_unlock(&gzvm->lock);
 
+	gzvm_destroy_ppage(gzvm);
+
 	kfree(gzvm);
 }
 
@@ -343,6 +360,7 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	gzvm->vm_id = ret;
 	gzvm->mm = current->mm;
 	mutex_init(&gzvm->lock);
+	gzvm->pinned_pages = RB_ROOT;
 
 	ret = gzvm_vm_irqfd_init(gzvm);
 	if (ret) {
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index b9e60fe5dcde..77c839c02b17 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -12,6 +12,8 @@
 #include <linux/mutex.h>
 #include <linux/gzvm.h>
 #include <linux/srcu.h>
+#include <linux/rbtree.h>
+#include <linux/mm.h>
 
 /*
  * For the normal physical address, the highest 12 bits should be zero, so we
@@ -80,6 +82,12 @@ struct gzvm_vcpu {
 	struct gzvm_vcpu_hwstate *hwstate;
 };
 
+struct gzvm_pinned_page {
+	struct rb_node node;
+	struct page *page;
+	u64 ipa;
+};
+
 struct gzvm {
 	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
 	/* userspace tied to this vm */
@@ -106,6 +114,9 @@ struct gzvm {
 	struct srcu_struct irq_srcu;
 	/* lock for irq injection */
 	struct mutex irq_lock;
+
+	/* Use rb-tree to record pin/unpin page */
+	struct rb_root pinned_pages;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -147,6 +158,8 @@ int gzvm_arch_inform_exit(u16 vm_id);
 int gzvm_find_memslot(struct gzvm *vm, u64 gpa);
 int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu);
 bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu);
+bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu);
+int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa);
 
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
 int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 1f134c55ac2a..edac8e3ae790 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -191,6 +191,11 @@ enum {
 	GZVM_EXCEPTION_PAGE_FAULT = 0x1,
 };
 
+/* hypercall definitions of GZVM_EXIT_HYPERCALL */
+enum {
+	GZVM_HVC_MEM_RELINQUISH = 0xc6000009,
+};
+
 /**
  * struct gzvm_vcpu_run: Same purpose as kvm_run, this struct is
  *			shared between userspace, kernel and
-- 
2.18.0

