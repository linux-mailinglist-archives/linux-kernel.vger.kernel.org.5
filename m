Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E2A7A60F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjISLN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjISLNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:13:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23353A9;
        Tue, 19 Sep 2023 04:12:52 -0700 (PDT)
X-UUID: 740394f256dd11ee8051498923ad61e6-20230919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VD1e+qXEqMFBPXW2F3jMvAoTbp/+vpAF8wQLl5umujY=;
        b=Rue72yjuYHUirBgDaMz6HrbxrPAOm4QNJuHppO8gQlzi84jAIy1V33b7vdINLoXTj6Z2vuIKWUEhkKKcqwdA1M0lQBn528Bng807N8m4uS9MQ3+18oZ3bplDs2jQtwJkyFBtvht/+7Cw+3AVpnfnERJrVLhtcUm0DmBo7fKXXkg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:bf092059-1912-42d0-81b9-8893abf473f3,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:382604bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 740394f256dd11ee8051498923ad61e6-20230919
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1569459223; Tue, 19 Sep 2023 19:12:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Sep 2023 19:12:41 +0800
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
Subject: [PATCH v6 15/15] virt: geniezone: Add block-based demand paging support
Date:   Tue, 19 Sep 2023 19:12:10 +0800
Message-ID: <20230919111210.19615-16-yi-de.wu@mediatek.com>
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

To balance memory usage and performance, GenieZone supports larger granularity
demand paging, called block-based demand paging. Gzvm driver uses enable_cap 
to query the hypervisor if it supports block-based demand paging and the given
granularity or not. Meanwhile, the gzvm driver allocates a shared buffer for 
storing the physical pages later.

If the hypervisor supports, every time the gzvm driver handles guest page
faults, it allocates more memory in advance (default: 2MB) for demand paging.
And fills those physical pages into the allocated shared memory, then calls
the hypervisor to map to guest's memory.

The physical pages allocated for block-based demand paging is not necessary to
be contiguous because in many cases, 2MB block is not followed. 1st, the
memory is allocated because of VMM's page fault (VMM loads kernel image to
guest memory before running). In this case, the page is allocated by the host
kernel and using PAGE_SIZE. 2nd is that guest may return memory to host via
ballooning and that is still 4KB (or PAGE_SIZE) granularity. Therefore, we do
not have to allocate physically contiguous 2MB pages.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |   2 +
 arch/arm64/geniezone/vm.c               |  19 +++-
 drivers/virt/geniezone/gzvm_mmu.c       | 110 +++++++++++++++++-------
 drivers/virt/geniezone/gzvm_vm.c        |  49 +++++++++++
 include/linux/gzvm_drv.h                |  16 ++++
 include/uapi/linux/gzvm.h               |   2 +
 6 files changed, 164 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index c21eb8ca8d4b..f57f799bbbc9 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -25,6 +25,7 @@ enum {
 	GZVM_FUNC_MEMREGION_PURPOSE = 15,
 	GZVM_FUNC_SET_DTB_CONFIG = 16,
 	GZVM_FUNC_MAP_GUEST = 17,
+	GZVM_FUNC_MAP_GUEST_BLOCK = 18,
 	NR_GZVM_FUNC,
 };
 
@@ -50,6 +51,7 @@ enum {
 #define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
 #define MT_HVC_GZVM_SET_DTB_CONFIG	GZVM_HCALL_ID(GZVM_FUNC_SET_DTB_CONFIG)
 #define MT_HVC_GZVM_MAP_GUEST		GZVM_HCALL_ID(GZVM_FUNC_MAP_GUEST)
+#define MT_HVC_GZVM_MAP_GUEST_BLOCK	GZVM_HCALL_ID(GZVM_FUNC_MAP_GUEST_BLOCK)
 
 #define GIC_V3_NR_LRS			16
 
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index d236b6cf84b3..d1948045ed72 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -299,10 +299,11 @@ static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm,
 		fallthrough;
 	case GZVM_CAP_PVM_SET_PROTECTED_VM:
 		/*
-		 * To improve performance for protected VM, we have to populate VM's memory
-		 * before VM booting
+		 * If the hypervisor doesn't support block-based demand paging, we
+		 * populate memory in advance to improve performance for protected VM.
 		 */
-		populate_mem_region(gzvm);
+		if (gzvm->demand_page_gran == PAGE_SIZE)
+			populate_mem_region(gzvm);
 		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
 		return ret;
 	case GZVM_CAP_PVM_GET_PVMFW_SIZE:
@@ -319,12 +320,16 @@ int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp)
 {
+	struct arm_smccc_res res = {0};
 	int ret;
 
 	switch (cap->cap) {
 	case GZVM_CAP_PROTECTED_VM:
 		ret = gzvm_vm_ioctl_cap_pvm(gzvm, cap, argp);
 		return ret;
+	case GZVM_CAP_BLOCK_BASED_DEMAND_PAGING:
+		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
+		return ret;
 	default:
 		break;
 	}
@@ -365,3 +370,11 @@ int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
 	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MAP_GUEST, vm_id, memslot_id,
 				    pfn, gfn, nr_pages, 0, 0, &res);
 }
+
+int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MAP_GUEST_BLOCK, vm_id,
+				    memslot_id, gfn, 0, 0, 0, 0, &res);
+}
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
index 542599f104db..02b9d89d482d 100644
--- a/drivers/virt/geniezone/gzvm_mmu.c
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -140,15 +140,30 @@ static int gzvm_insert_ppage(struct gzvm *vm, struct gzvm_pinned_page *ppage)
 	return 0;
 }
 
-static int pin_one_page(unsigned long hva, struct page **page)
+static int pin_one_page(struct gzvm *vm, unsigned long hva, u64 gpa)
 {
-	struct mm_struct *mm = current->mm;
 	unsigned int flags = FOLL_HWPOISON | FOLL_LONGTERM | FOLL_WRITE;
+	struct gzvm_pinned_page *ppage = NULL;
+	struct mm_struct *mm = current->mm;
+	struct page *page = NULL;
+
+	ppage = kmalloc(sizeof(*ppage), GFP_KERNEL_ACCOUNT);
+	if (!ppage)
+		return -ENOMEM;
 
 	mmap_read_lock(mm);
-	pin_user_pages(hva, 1, flags, page);
+	pin_user_pages(hva, 1, flags, &page);
 	mmap_read_unlock(mm);
 
+	if (!page) {
+		kfree(ppage);
+		return -EFAULT;
+	}
+
+	ppage->page = page;
+	ppage->ipa = gpa;
+	gzvm_insert_ppage(vm, ppage);
+
 	return 0;
 }
 
@@ -179,6 +194,62 @@ int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa)
 	return 0;
 }
 
+static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
+{
+	u64 pfn, __gfn, start_gfn;
+	u32 nr_entries;
+	unsigned long hva;
+	int ret, i;
+
+	nr_entries = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE;
+	start_gfn = ALIGN_DOWN(gfn, nr_entries);
+
+	mutex_lock(&vm->demand_paging_lock);
+	for (i = 0, __gfn = start_gfn; i < nr_entries; i++, __gfn++) {
+		ret = gzvm_gfn_to_pfn_memslot(&vm->memslot[memslot_id], __gfn,
+					      &pfn);
+		if (unlikely(ret)) {
+			ret = -ERR_FAULT;
+			goto err_unlock;
+		}
+		vm->demand_page_buffer[i] = pfn;
+
+		hva = gzvm_gfn_to_hva_memslot(&vm->memslot[memslot_id], __gfn);
+		ret = pin_one_page(vm, hva, PFN_PHYS(__gfn));
+		if (ret)
+			goto err_unlock;
+	}
+
+	ret = gzvm_arch_map_guest_block(vm->vm_id, memslot_id, start_gfn);
+	if (unlikely(ret)) {
+		ret = -EFAULT;
+		goto err_unlock;
+	}
+
+err_unlock:
+	mutex_unlock(&vm->demand_paging_lock);
+
+	return ret;
+}
+
+static int handle_single_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
+{
+	unsigned long hva;
+	int ret;
+	u64 pfn;
+
+	ret = gzvm_gfn_to_pfn_memslot(&vm->memslot[memslot_id], gfn, &pfn);
+	if (unlikely(ret))
+		return -EFAULT;
+
+	ret = gzvm_arch_map_guest(vm->vm_id, memslot_id, pfn, gfn, 1);
+	if (unlikely(ret))
+		return -EFAULT;
+
+	hva = gzvm_gfn_to_hva_memslot(&vm->memslot[memslot_id], gfn);
+	return pin_one_page(vm, hva, PFN_PHYS(gfn));
+}
+
 /**
  * gzvm_handle_page_fault() - Handle guest page fault, find corresponding page
  *                            for the faulting gpa
@@ -190,40 +261,17 @@ int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa)
  */
 int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu)
 {
-	struct gzvm_pinned_page *ppage = NULL;
 	struct gzvm *vm = vcpu->gzvm;
-	struct page *page = NULL;
-	unsigned long hva;
-	u64 pfn, gfn;
 	int memslot_id;
-	int ret;
+	u64 gfn;
 
 	gfn = PHYS_PFN(vcpu->run->exception.fault_gpa);
 	memslot_id = gzvm_find_memslot(vm, gfn);
 	if (unlikely(memslot_id < 0))
 		return -EFAULT;
 
-	ret = gzvm_gfn_to_pfn_memslot(&vm->memslot[memslot_id], gfn, &pfn);
-	if (unlikely(ret))
-		return -EFAULT;
-
-	ret = gzvm_arch_map_guest(vm->vm_id, memslot_id, pfn, gfn, 1);
-	if (unlikely(ret))
-		return -EFAULT;
-
-	hva = gzvm_gfn_to_hva_memslot(&vm->memslot[memslot_id], gfn);
-	pin_one_page(hva, &page);
-
-	if (!page)
-		return -EFAULT;
-
-	ppage = kmalloc(sizeof(*ppage), GFP_KERNEL_ACCOUNT);
-	if (!ppage)
-		return -ENOMEM;
-
-	ppage->page = page;
-	ppage->ipa = vcpu->run->exception.fault_gpa;
-	gzvm_insert_ppage(vm, ppage);
-
-	return 0;
+	if (vm->demand_page_gran == PAGE_SIZE)
+		return handle_single_demand_page(vm, memslot_id, gfn);
+	else
+		return handle_block_demand_page(vm, memslot_id, gfn);
 }
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 747e5cf523bf..a7d43bedfad0 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -309,6 +309,8 @@ static void gzvm_destroy_ppage(struct gzvm *gzvm)
 
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
+	size_t allocated_size;
+
 	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
 
 	mutex_lock(&gzvm->lock);
@@ -321,6 +323,11 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 	list_del(&gzvm->vm_list);
 	mutex_unlock(&gzvm_list_lock);
 
+	if (gzvm->demand_page_buffer) {
+		allocated_size = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE * sizeof(u64);
+		free_pages_exact(gzvm->demand_page_buffer, allocated_size);
+	}
+
 	mutex_unlock(&gzvm->lock);
 
 	gzvm_destroy_ppage(gzvm);
@@ -342,6 +349,46 @@ static const struct file_operations gzvm_vm_fops = {
 	.llseek		= noop_llseek,
 };
 
+/**
+ * setup_vm_demand_paging - Query hypervisor suitable demand page size and set
+ * @vm: gzvm instance for setting up demand page size
+ *
+ * Return: void
+ */
+static void setup_vm_demand_paging(struct gzvm *vm)
+{
+	u32 buf_size = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE * sizeof(u64);
+	struct gzvm_enable_cap cap = {0};
+	void *buffer;
+	int ret;
+
+	mutex_init(&vm->demand_paging_lock);
+	buffer = alloc_pages_exact(buf_size, GFP_KERNEL);
+	if (!buffer) {
+		/* Fall back to use default page size for demand paging */
+		vm->demand_page_gran = PAGE_SIZE;
+		vm->demand_page_buffer = NULL;
+		return;
+	}
+
+	cap.cap = GZVM_CAP_BLOCK_BASED_DEMAND_PAGING;
+	cap.args[0] = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE;
+	cap.args[1] = (__u64)virt_to_phys(buffer);
+	/* demand_page_buffer is freed when destroy VM */
+	vm->demand_page_buffer = buffer;
+
+	ret = gzvm_vm_ioctl_enable_cap(vm, &cap, NULL);
+	if (ret == 0) {
+		vm->demand_page_gran = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE;
+		/* freed when destroy vm */
+		vm->demand_page_buffer = buffer;
+	} else {
+		vm->demand_page_gran = PAGE_SIZE;
+		vm->demand_page_buffer = NULL;
+		free_pages_exact(buffer, buf_size);
+	}
+}
+
 static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 {
 	int ret;
@@ -376,6 +423,8 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 		return ERR_PTR(ret);
 	}
 
+	setup_vm_demand_paging(gzvm);
+
 	mutex_lock(&gzvm_list_lock);
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 77c839c02b17..a6994a1c391a 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -46,6 +46,8 @@
 
 #define GZVM_VCPU_RUN_MAP_SIZE		(PAGE_SIZE * 2)
 
+#define GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE	(2 * 1024 * 1024) /* 2MB */
+
 /* struct mem_region_addr_range - Identical to ffa memory constituent */
 struct mem_region_addr_range {
 	/* the base IPA of the constituent memory region, aligned to 4 kiB */
@@ -117,6 +119,19 @@ struct gzvm {
 
 	/* Use rb-tree to record pin/unpin page */
 	struct rb_root pinned_pages;
+
+	/*
+	 * demand page granularity: how much memory we allocate for VM in a
+	 * single page fault
+	 */
+	u32 demand_page_gran;
+	/* the mailbox for transferring large portion pages */
+	u64 *demand_page_buffer;
+	/*
+	 * lock for preventing multiple cpu using the same demand page mailbox
+	 * at the same time
+	 */
+	struct mutex  demand_paging_lock;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -137,6 +152,7 @@ int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
 int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
 			u64 nr_pages);
+int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index edac8e3ae790..a98787a18c36 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -18,6 +18,8 @@
 
 #define GZVM_CAP_VM_GPA_SIZE	0xa5
 #define GZVM_CAP_PROTECTED_VM	0xffbadab1
+/* query hypervisor supported block-based demand page */
+#define GZVM_CAP_BLOCK_BASED_DEMAND_PAGING	0x9201
 
 /* sub-commands put in args[0] for GZVM_CAP_PROTECTED_VM */
 #define GZVM_CAP_PVM_SET_PVMFW_GPA		0
-- 
2.18.0

