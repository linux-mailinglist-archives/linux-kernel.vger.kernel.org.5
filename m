Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546957EE464
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjKPPaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjKPP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:29:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB21AD;
        Thu, 16 Nov 2023 07:29:21 -0800 (PST)
X-UUID: e4393a9e849411eea33bb35ae8d461a2-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=e3nmNvfluYtwqKVFWAX0YtUusirbiaJDF4mVmFN5swk=;
        b=Avf500JYTTJJ2ea+ohe1lIc7Bnemg9AiM/zstgUMfDKJBLUkhsdnpgvPxcxBHXBcW9xpQYpPUoMB+sUzRnjcE+vntDqvhwTe5cp05D+xj8GmxiXPCJUM0ZOx221+T6LxdaWqRIt/2gbIz8/p+J9FXGSEV5WtsciHjgAF5sTotaI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:4fa50ffc-7802-4ad6-84f5-f28f340042dc,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:e8392460-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e4393a9e849411eea33bb35ae8d461a2-20231116
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 674268061; Thu, 16 Nov 2023 23:29:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 23:29:09 +0800
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
        "My Chuang" <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>,
        "Kevenny Hsieh" <kevenny.hsieh@mediatek.com>
Subject: [PATCH v7 06/16] virt: geniezone: Add vm capability check
Date:   Thu, 16 Nov 2023 23:27:46 +0800
Message-ID: <20231116152756.4250-7-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231116152756.4250-1-yi-de.wu@mediatek.com>
References: <20231116152756.4250-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.677700-8.000000
X-TMASE-MatchedRID: 1qaXb5wSpVtWj3HFS14pKxn0UD4GU5Iq5E5u1OdPWsTgr/zYTDOZCJeq
        sXSeEviPpSHzbpDtJi1Yo3G+rvxrNYJrRWPc34Z+A9lly13c/gGZ2scyRQcerwqiCYa6w8tv0ZI
        Z9x7ls0KIi0Yt2qmJZY3/d0NuPcI1QkfxbJAyTm7J1E39jKDimIZR+1Pw4IhPFJViChKBgZl84U
        qAu2N/T0ZgKP3Oigba2SmlTd3Epns/uACEfpgIcZJrW03DacWE/Hd4CUWIS/FXopZjyO6CZVX+F
        sbKS7V03P38zdjijVk5abkgLujSymF9INTZ2jjMzfqlpbtmcWj54F/2i/DwjU1KG1YrOQW/+cIj
        9hDzxfzAngdVWMbHp59vpuXVh9T3HxPMjOKY7A9t1O49r1VEa8RB0bsfrpPI0PU0TdJoUtdpu7V
        BAUdcdtEniYfKBURW7DRC7PcbUfTCQzaqQj64uANumAzNBuL4DSl3AJkX6KoW2Paguf476Uq7c1
        ge+qTcFO1OgQl20X6Oh+wyNBrFXDJiNuKohDcKzKSG3JdyKAPqtV2AGMNParsc3Lhg3nYY
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.677700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: FC50C6FC554ECA9C2F40680EF675AE18B7974D3EF26326EADBAF25FC5D0E66AC2000:8
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

Inquire the `capability support` on GenieZone hypervisor.
Example:
`GZVM_CAP_PROTECTED_VM` or `GZVM_CAP_VM_GPA_SIZE`.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: kevenny hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |   2 +
 arch/arm64/geniezone/vm.c               | 243 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_main.c      |  27 +++
 drivers/virt/geniezone/gzvm_vm.c        |  21 ++
 include/linux/gzvm_drv.h                |   6 +-
 include/uapi/linux/gzvm.h               |  31 +++
 6 files changed, 329 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index a0268adf3d8f..f286ad1efdf8 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -13,6 +13,7 @@ enum {
 	GZVM_FUNC_DESTROY_VM = 1,
 	GZVM_FUNC_SET_MEMREGION = 4,
 	GZVM_FUNC_PROBE = 12,
+	GZVM_FUNC_ENABLE_CAP = 13,
 	NR_GZVM_FUNC,
 };
 
@@ -26,6 +27,7 @@ enum {
 #define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
 #define MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
+#define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 
 /**
  * gzvm_hypcall_wrapper() - the wrapper for hvc calls
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index c051dd6e590f..d6b3f148a823 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -51,6 +51,40 @@ int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 				    buf_size, region, 0, 0, 0, 0, &res);
 }
 
+static int gzvm_cap_vm_gpa_size(void __user *argp)
+{
+	__u64 value = CONFIG_ARM64_PA_BITS;
+
+	if (copy_to_user(argp, &value, sizeof(__u64)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp)
+{
+	int ret;
+
+	switch (cap) {
+	case GZVM_CAP_PROTECTED_VM: {
+		__u64 success = 1;
+
+		if (copy_to_user(argp, &success, sizeof(__u64)))
+			return -EFAULT;
+
+		return 0;
+	}
+	case GZVM_CAP_VM_GPA_SIZE: {
+		ret = gzvm_cap_vm_gpa_size(argp);
+		return ret;
+	}
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 /**
  * gzvm_arch_create_vm() - create vm
  * @vm_type: VM type. Only supports Linux VM now.
@@ -77,6 +111,215 @@ int gzvm_arch_destroy_vm(u16 vm_id)
 				    0, 0, &res);
 }
 
+static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm,
+				   struct gzvm_enable_cap *cap,
+				   struct arm_smccc_res *res)
+{
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_ENABLE_CAP, gzvm->vm_id,
+				    cap->cap, cap->args[0], cap->args[1],
+				    cap->args[2], cap->args[3], cap->args[4],
+				    res);
+}
+
+/**
+ * gzvm_vm_ioctl_get_pvmfw_size() - Get pvmfw size from hypervisor, return
+ *				    in x1, and return to userspace in args
+ * @gzvm: Pointer to struct gzvm.
+ * @cap: Pointer to struct gzvm_enable_cap.
+ * @argp: Pointer to struct gzvm_enable_cap in user space.
+ *
+ * Return:
+ * * 0			- Succeed
+ * * -EINVAL		- Hypervisor return invalid results
+ * * -EFAULT		- Fail to copy back to userspace buffer
+ */
+static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
+					struct gzvm_enable_cap *cap,
+					void __user *argp)
+{
+	struct arm_smccc_res res = {0};
+
+	if (gzvm_vm_arch_enable_cap(gzvm, cap, &res) != 0)
+		return -EINVAL;
+
+	cap->args[1] = res.a1;
+	if (copy_to_user(argp, cap, sizeof(*cap)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * fill_constituents() - Populate pa to buffer until full
+ * @consti: Pointer to struct mem_region_addr_range.
+ * @consti_cnt: Constituent count.
+ * @max_nr_consti: Maximum number of constituent count.
+ * @gfn: Guest frame number.
+ * @total_pages: Total page numbers.
+ * @slot: Pointer to struct gzvm_memslot.
+ *
+ * Return: how many pages we've fill in, negative if error
+ */
+static int fill_constituents(struct mem_region_addr_range *consti,
+			     int *consti_cnt, int max_nr_consti, u64 gfn,
+			     u32 total_pages, struct gzvm_memslot *slot)
+{
+	u64 pfn, prev_pfn, gfn_end;
+	int nr_pages = 1;
+	int i = 0;
+
+	if (unlikely(total_pages == 0))
+		return -EINVAL;
+	gfn_end = gfn + total_pages;
+
+	/* entry 0 */
+	if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
+		return -EFAULT;
+	consti[0].address = PFN_PHYS(pfn);
+	consti[0].pg_cnt = 1;
+	gfn++;
+	prev_pfn = pfn;
+
+	while (i < max_nr_consti && gfn < gfn_end) {
+		if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
+			return -EFAULT;
+		if (pfn == (prev_pfn + 1)) {
+			consti[i].pg_cnt++;
+		} else {
+			i++;
+			if (i >= max_nr_consti)
+				break;
+			consti[i].address = PFN_PHYS(pfn);
+			consti[i].pg_cnt = 1;
+		}
+		prev_pfn = pfn;
+		gfn++;
+		nr_pages++;
+	}
+	if (i != max_nr_consti)
+		i++;
+	*consti_cnt = i;
+
+	return nr_pages;
+}
+
+/**
+ * populate_mem_region() - Iterate all mem slot and populate pa to buffer until it's full
+ * @gzvm: Pointer to struct gzvm.
+ *
+ * Return: 0 if it is successful, negative if error
+ */
+static int populate_mem_region(struct gzvm *gzvm)
+{
+	int slot_cnt = 0;
+
+	while (slot_cnt < GZVM_MAX_MEM_REGION && gzvm->memslot[slot_cnt].npages != 0) {
+		struct gzvm_memslot *memslot = &gzvm->memslot[slot_cnt];
+		struct gzvm_memory_region_ranges *region;
+		int max_nr_consti, remain_pages;
+		u64 gfn, gfn_end;
+		u32 buf_size;
+
+		buf_size = PAGE_SIZE * 2;
+		region = alloc_pages_exact(buf_size, GFP_KERNEL);
+		if (!region)
+			return -ENOMEM;
+
+		max_nr_consti = (buf_size - sizeof(*region)) /
+				sizeof(struct mem_region_addr_range);
+
+		region->slot = memslot->slot_id;
+		remain_pages = memslot->npages;
+		gfn = memslot->base_gfn;
+		gfn_end = gfn + remain_pages;
+
+		while (gfn < gfn_end) {
+			int nr_pages;
+
+			nr_pages = fill_constituents(region->constituents,
+						     &region->constituent_cnt,
+						     max_nr_consti, gfn,
+						     remain_pages, memslot);
+
+			if (nr_pages < 0) {
+				pr_err("Failed to fill constituents\n");
+				free_pages_exact(region, buf_size);
+				return -EFAULT;
+			}
+
+			region->gpa = PFN_PHYS(gfn);
+			region->total_pages = nr_pages;
+			remain_pages -= nr_pages;
+			gfn += nr_pages;
+
+			if (gzvm_arch_set_memregion(gzvm->vm_id, buf_size,
+						    virt_to_phys(region))) {
+				pr_err("Failed to register memregion to hypervisor\n");
+				free_pages_exact(region, buf_size);
+				return -EFAULT;
+			}
+		}
+		free_pages_exact(region, buf_size);
+		++slot_cnt;
+	}
+	return 0;
+}
+
+/**
+ * gzvm_vm_ioctl_cap_pvm() - Proceed GZVM_CAP_PROTECTED_VM's subcommands
+ * @gzvm: Pointer to struct gzvm.
+ * @cap: Pointer to struct gzvm_enable_cap.
+ * @argp: Pointer to struct gzvm_enable_cap in user space.
+ *
+ * Return:
+ * * 0			- Succeed
+ * * -EINVAL		- Invalid subcommand or arguments
+ */
+static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm,
+				 struct gzvm_enable_cap *cap,
+				 void __user *argp)
+{
+	struct arm_smccc_res res = {0};
+	int ret;
+
+	switch (cap->args[0]) {
+	case GZVM_CAP_PVM_SET_PVMFW_GPA:
+		fallthrough;
+	case GZVM_CAP_PVM_SET_PROTECTED_VM:
+		/*
+		 * To improve performance for protected VM, we have to populate VM's memory
+		 * before VM booting
+		 */
+		populate_mem_region(gzvm);
+		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
+		return ret;
+	case GZVM_CAP_PVM_GET_PVMFW_SIZE:
+		ret = gzvm_vm_ioctl_get_pvmfw_size(gzvm, cap, argp);
+		return ret;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
+				  struct gzvm_enable_cap *cap,
+				  void __user *argp)
+{
+	int ret;
+
+	switch (cap->cap) {
+	case GZVM_CAP_PROTECTED_VM:
+		ret = gzvm_vm_ioctl_cap_pvm(gzvm, cap, argp);
+		return ret;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 /**
  * gzvm_hva_to_pa_arch() - converts hva to pa with arch-specific way
  * @hva: Host virtual address.
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index 4e7d60067c55..30f6c3975026 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -41,6 +41,28 @@ int gzvm_err_to_errno(unsigned long err)
 	return -EINVAL;
 }
 
+/**
+ * gzvm_dev_ioctl_check_extension() - Check if given capability is support
+ *				      or not
+ *
+ * @gzvm: Pointer to struct gzvm
+ * @args: Pointer in u64 from userspace
+ *
+ * Return:
+ * * 0			- Supported, no error
+ * * -EOPNOTSUPP	- Unsupported
+ * * -EFAULT		- Failed to get data from userspace
+ */
+long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args)
+{
+	__u64 cap;
+	void __user *argp = (void __user *)args;
+
+	if (copy_from_user(&cap, argp, sizeof(uint64_t)))
+		return -EFAULT;
+	return gzvm_arch_check_extension(gzvm, cap, argp);
+}
+
 static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
 			   unsigned long user_args)
 {
@@ -50,6 +72,11 @@ static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
 	case GZVM_CREATE_VM:
 		ret = gzvm_dev_ioctl_create_vm(user_args);
 		return ret;
+	case GZVM_CHECK_EXTENSION:
+		if (!user_args)
+			return -EINVAL;
+		ret = gzvm_dev_ioctl_check_extension(NULL, user_args);
+		return ret;
 	default:
 		break;
 	}
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 326cc9e93d92..ba6bfb7ee6e5 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -98,6 +98,13 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 	return register_memslot_addr_range(gzvm, memslot);
 }
 
+static int gzvm_vm_ioctl_enable_cap(struct gzvm *gzvm,
+				    struct gzvm_enable_cap *cap,
+				    void __user *argp)
+{
+	return gzvm_vm_ioctl_arch_enable_cap(gzvm, cap, argp);
+}
+
 /* gzvm_vm_ioctl() - Ioctl handler of VM FD */
 static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 			  unsigned long arg)
@@ -107,6 +114,10 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 	struct gzvm *gzvm = filp->private_data;
 
 	switch (ioctl) {
+	case GZVM_CHECK_EXTENSION: {
+		ret = gzvm_dev_ioctl_check_extension(gzvm, arg);
+		break;
+	}
 	case GZVM_SET_USER_MEMORY_REGION: {
 		struct gzvm_userspace_memory_region userspace_mem;
 
@@ -117,6 +128,16 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
 		break;
 	}
+	case GZVM_ENABLE_CAP: {
+		struct gzvm_enable_cap cap;
+
+		if (copy_from_user(&cap, argp, sizeof(cap))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = gzvm_vm_ioctl_enable_cap(gzvm, &cap, argp);
+		break;
+	}
 	default:
 		ret = -ENOTTY;
 	}
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index aa1eaf4d43b4..a7d6df29b34e 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -73,6 +73,7 @@ struct gzvm {
 	u16 vm_id;
 };
 
+long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
 int gzvm_dev_ioctl_create_vm(unsigned long vm_type);
 
 int gzvm_err_to_errno(unsigned long err);
@@ -83,9 +84,12 @@ void gzvm_destroy_all_vms(void);
 int gzvm_arch_probe(void);
 int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 			    phys_addr_t region);
+int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp);
 int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
-
+int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
+				  struct gzvm_enable_cap *cap,
+				  void __user *argp);
 u64 gzvm_hva_to_pa_arch(u64 hva);
 u64 hva_to_pa_fast(u64 hva);
 u64 hva_to_pa_slow(u64 hva);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index d2d5e6cfc2c9..77a58ee085df 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -16,12 +16,30 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+#define GZVM_CAP_VM_GPA_SIZE	0xa5
+#define GZVM_CAP_PROTECTED_VM	0xffbadab1
+
+/* sub-commands put in args[0] for GZVM_CAP_PROTECTED_VM */
+#define GZVM_CAP_PVM_SET_PVMFW_GPA		0
+#define GZVM_CAP_PVM_GET_PVMFW_SIZE		1
+/* GZVM_CAP_PVM_SET_PROTECTED_VM only sets protected but not load pvmfw */
+#define GZVM_CAP_PVM_SET_PROTECTED_VM		2
+
 /* GZVM ioctls */
 #define GZVM_IOC_MAGIC			0x92	/* gz */
 
 /* ioctls for /dev/gzvm fds */
 #define GZVM_CREATE_VM             _IO(GZVM_IOC_MAGIC,   0x01) /* Returns a Geniezone VM fd */
 
+/*
+ * Check if the given capability is supported or not.
+ * The argument is capability. Ex. GZVM_CAP_PROTECTED_VM or GZVM_CAP_VM_GPA_SIZE
+ * return is 0 (supported, no error)
+ * return is -EOPNOTSUPP (unsupported)
+ * return is -EFAULT (failed to get the argument from userspace)
+ */
+#define GZVM_CHECK_EXTENSION       _IO(GZVM_IOC_MAGIC,   0x03)
+
 /* ioctls for VM fds */
 /* for GZVM_SET_MEMORY_REGION */
 struct gzvm_memory_region {
@@ -48,4 +66,17 @@ struct gzvm_userspace_memory_region {
 #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
 					 struct gzvm_userspace_memory_region)
 
+/**
+ * struct gzvm_enable_cap: The `capability support` on GenieZone hypervisor
+ * @cap: `GZVM_CAP_ARM_PROTECTED_VM` or `GZVM_CAP_ARM_VM_IPA_SIZE`
+ * @args: x3-x7 registers can be used for additional args
+ */
+struct gzvm_enable_cap {
+	__u64 cap;
+	__u64 args[5];
+};
+
+#define GZVM_ENABLE_CAP            _IOW(GZVM_IOC_MAGIC,  0xa3, \
+					struct gzvm_enable_cap)
+
 #endif /* __GZVM_H__ */
-- 
2.18.0

