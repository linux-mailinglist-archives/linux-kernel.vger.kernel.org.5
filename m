Return-Path: <linux-kernel+bounces-21352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7150828E19
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6DF1F20FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F1C4A98B;
	Tue,  9 Jan 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m8NlPsuH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430D481B4;
	Tue,  9 Jan 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409IocPs003466;
	Tue, 9 Jan 2024 19:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=J86hk5ZNAM4yco10H3q8d/nCtmnOiD8TudkIuvK3R54
	=; b=m8NlPsuHzRxSYJTrWZTsm5UF20FIEirZ/YLEqL6Fveo7ObkscWnw7VdGTtk
	AlFpsxYSQg8+so5UojOofAtUKOs+Apmokcw8aGT5kugiXn6zbsF5d1yk2i+mHqop
	wyBaSQwF/bTtHbcnsy3NPqasl/rlP+hE32CH9Jb8kIs3wJbemymdkB3Zp1diqnNG
	eK4vqgc+OfCKKjfkxcORbhIVP65uiKpd4ML1tEpUTL/KoDUN26QnHjbGWl7zYjep
	dsHGen41zqM1JHuvPbDCDWG4dneNUv4Z3LGfQGmUw+arR4YNzw8SCh+Vo1fjph5L
	HbaH14JWpo7cashONpnSIRHKiJg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9bmggd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:38:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jc3JS003494
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:38:03 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:38:02 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:38:00 -0800
Subject: [PATCH v16 22/34] virt: gunyah: Add ioctl to bind guestmem to VMs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-22-634904bf4ce9@quicinc.com>
References: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
In-Reply-To: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
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
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: crWTMvyVI_IKN5KiiZJuwdyyipi-0F48
X-Proofpoint-GUID: crWTMvyVI_IKN5KiiZJuwdyyipi-0F48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

A maple tree is used to maintain a map from guest address ranges to a
guestmemfd that provides the memory for that range of memory for the
guest. The mapping of guest address range to guestmemfd is called a
binding. Implement an ioctl to add/remove bindings to the virtual
machine. The binding determines whether the memory is shared (host
retains access) or lent (host loses access).

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/guest_memfd.c | 394 +++++++++++++++++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.c      |  20 ++
 drivers/virt/gunyah/vm_mgr.h      |   9 +
 include/uapi/linux/gunyah.h       |  41 ++++
 4 files changed, 455 insertions(+), 9 deletions(-)

diff --git a/drivers/virt/gunyah/guest_memfd.c b/drivers/virt/gunyah/guest_memfd.c
index 73a3f1368081..71686f1946da 100644
--- a/drivers/virt/gunyah/guest_memfd.c
+++ b/drivers/virt/gunyah/guest_memfd.c
@@ -16,6 +16,51 @@
 
 #include "vm_mgr.h"
 
+/**
+ * struct gunyah_gmem_binding - Represents a binding of guestmem to a Gunyah VM
+ * @gfn: Guest address to place acquired folios
+ * @ghvm: Pointer to Gunyah VM in this binding
+ * @i_off: offset into the guestmem to grab folios from
+ * @file: Pointer to guest_memfd
+ * @i_entry: list entry for inode->i_private_list
+ * @flags: Access flags for the binding
+ * @nr: Number of pages covered by this binding
+ */
+struct gunyah_gmem_binding {
+	u64 gfn;
+	struct gunyah_vm *ghvm;
+
+	pgoff_t i_off;
+	struct file *file;
+	struct list_head i_entry;
+
+	u32 flags;
+	unsigned long nr;
+};
+
+static inline pgoff_t gunyah_gfn_to_off(struct gunyah_gmem_binding *b, u64 gfn)
+{
+	return gfn - b->gfn + b->i_off;
+}
+
+static inline u64 gunyah_off_to_gfn(struct gunyah_gmem_binding *b, pgoff_t off)
+{
+	return off - b->i_off + b->gfn;
+}
+
+static inline bool gunyah_guest_mem_is_lend(struct gunyah_vm *ghvm, u32 flags)
+{
+	u8 access = flags & GUNYAH_MEM_ACCESS_MASK;
+
+	if (access == GUNYAH_MEM_FORCE_LEND)
+		return true;
+	else if (access == GUNYAH_MEM_FORCE_SHARE)
+		return false;
+
+	/* RM requires all VMs to be protected (isolated) */
+	return true;
+}
+
 static struct folio *gunyah_gmem_get_huge_folio(struct inode *inode,
 						pgoff_t index)
 {
@@ -83,17 +128,55 @@ static struct folio *gunyah_gmem_get_folio(struct inode *inode, pgoff_t index)
 	return folio;
 }
 
+/**
+ * gunyah_gmem_launder_folio() - Tries to unmap one folio from virtual machine(s)
+ * @folio: The folio to unmap
+ *
+ * Returns - 0 if the folio has been reclaimed from any virtual machine(s) that
+ *           folio was mapped into.
+ */
+static int gunyah_gmem_launder_folio(struct folio *folio)
+{
+	struct address_space *const mapping = folio->mapping;
+	struct gunyah_gmem_binding *b;
+	pgoff_t index = folio_index(folio);
+	int ret = 0;
+	u64 gfn;
+
+	filemap_invalidate_lock_shared(mapping);
+	list_for_each_entry(b, &mapping->i_private_list, i_entry) {
+		/* if the mapping doesn't cover this folio: skip */
+		if (b->i_off > index || index > b->i_off + b->nr)
+			continue;
+
+		gfn = gunyah_off_to_gfn(b, index);
+		ret = gunyah_vm_reclaim_folio(b->ghvm, gfn);
+		if (WARN_RATELIMIT(ret, "failed to reclaim gfn: %08llx %d\n",
+				   gfn, ret))
+			break;
+	}
+	filemap_invalidate_unlock_shared(mapping);
+
+	return ret;
+}
+
 static vm_fault_t gunyah_gmem_host_fault(struct vm_fault *vmf)
 {
 	struct folio *folio;
 
 	folio = gunyah_gmem_get_folio(file_inode(vmf->vma->vm_file),
 				      vmf->pgoff);
-	if (!folio || folio_test_private(folio)) {
+	if (!folio)
+		return VM_FAULT_SIGBUS;
+
+	/* If the folio is lent to a VM, try to reclim it */
+	if (folio_test_private(folio) && gunyah_gmem_launder_folio(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		return VM_FAULT_SIGBUS;
 	}
+	/* gunyah_gmem_launder_folio should clear the private bit if it returns 0 */
+	BUG_ON(folio_test_private(folio));
 
 	vmf->page = folio_file_page(folio, vmf->pgoff);
 
@@ -106,9 +189,36 @@ static const struct vm_operations_struct gunyah_gmem_vm_ops = {
 
 static int gunyah_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	file_accessed(file);
-	vma->vm_ops = &gunyah_gmem_vm_ops;
-	return 0;
+	struct address_space *const mapping = file->f_mapping;
+	struct gunyah_gmem_binding *b;
+	int ret = 0;
+	u64 gfn, nr;
+
+	filemap_invalidate_lock_shared(mapping);
+	list_for_each_entry(b, &mapping->i_private_list, i_entry) {
+		if (!gunyah_guest_mem_is_lend(b->ghvm, b->flags))
+			continue;
+
+		/* if the binding doesn't cover this vma: skip */
+		if (vma->vm_pgoff + vma_pages(vma) < b->i_off)
+			continue;
+		if (vma->vm_pgoff > b->i_off + b->nr)
+			continue;
+
+		gfn = gunyah_off_to_gfn(b, vma->vm_pgoff);
+		nr = gunyah_off_to_gfn(b, vma->vm_pgoff + vma_pages(vma)) - gfn;
+		ret = gunyah_vm_reclaim_range(b->ghvm, gfn, nr);
+		if (ret)
+			break;
+	}
+	filemap_invalidate_unlock_shared(mapping);
+
+	if (!ret) {
+		file_accessed(file);
+		vma->vm_ops = &gunyah_gmem_vm_ops;
+	}
+
+	return ret;
 }
 
 /**
@@ -125,9 +235,7 @@ static int gunyah_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 static long gunyah_gmem_punch_hole(struct inode *inode, loff_t offset,
 				   loff_t len)
 {
-	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
-
-	return 0;
+	return invalidate_inode_pages2_range(inode->i_mapping, offset, offset + len - 1);
 }
 
 static long gunyah_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
@@ -204,6 +312,12 @@ static long gunyah_gmem_fallocate(struct file *file, int mode, loff_t offset,
 
 static int gunyah_gmem_release(struct inode *inode, struct file *file)
 {
+	/**
+	 * each binding increments refcount on file, so we shouldn't be here
+	 * if i_private_list not empty.
+	 */
+	BUG_ON(!list_empty(&inode->i_mapping->i_private_list));
+
 	return 0;
 }
 
@@ -216,10 +330,26 @@ static const struct file_operations gunyah_gmem_fops = {
 	.release = gunyah_gmem_release,
 };
 
+static bool gunyah_gmem_release_folio(struct folio *folio, gfp_t gfp_flags)
+{
+	/* should return true if released; launder folio returns 0 if freed */
+	return !gunyah_gmem_launder_folio(folio);
+}
+
+static int gunyah_gmem_remove_folio(struct address_space *mapping,
+				    struct folio *folio)
+{
+	if (mapping != folio->mapping)
+		return -EINVAL;
+
+	return gunyah_gmem_launder_folio(folio);
+}
+
 static const struct address_space_operations gunyah_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
-	.migrate_folio = migrate_folio,
-	.error_remove_folio = generic_error_remove_folio,
+	.release_folio = gunyah_gmem_release_folio,
+	.launder_folio = gunyah_gmem_launder_folio,
+	.error_remove_folio = gunyah_gmem_remove_folio,
 };
 
 int gunyah_guest_mem_create(struct gunyah_create_mem_args *args)
@@ -267,6 +397,7 @@ int gunyah_guest_mem_create(struct gunyah_create_mem_args *args)
 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 	mapping_set_large_folios(inode->i_mapping);
 	mapping_set_unmovable(inode->i_mapping);
+	mapping_set_release_always(inode->i_mapping);
 	/* Unmovable mappings are supposed to be marked unevictable as well. */
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
 
@@ -277,3 +408,248 @@ int gunyah_guest_mem_create(struct gunyah_create_mem_args *args)
 	put_unused_fd(fd);
 	return err;
 }
+
+void gunyah_gmem_remove_binding(struct gunyah_gmem_binding *b)
+{
+	WARN_ON(gunyah_vm_reclaim_range(b->ghvm, b->gfn, b->nr));
+	mtree_erase(&b->ghvm->bindings, b->gfn);
+	list_del(&b->i_entry);
+	fput(b->file);
+	kfree(b);
+}
+
+static inline unsigned long gunyah_gmem_page_mask(struct file *file)
+{
+	unsigned long gmem_flags = (unsigned long)file_inode(file)->i_private;
+
+	if (gmem_flags & GHMF_ALLOW_HUGEPAGE) {
+#if IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
+		return HPAGE_PMD_MASK;
+#else
+		return ULONG_MAX;
+#endif
+	}
+
+	return PAGE_MASK;
+}
+
+static int gunyah_gmem_init_binding(struct gunyah_vm *ghvm, struct file *file,
+				    struct gunyah_map_mem_args *args,
+				    struct gunyah_gmem_binding *binding)
+{
+	const unsigned long page_mask = ~gunyah_gmem_page_mask(file);
+
+	if (args->flags & ~(GUNYAH_MEM_ALLOW_RWX | GUNYAH_MEM_ACCESS_MASK))
+		return -EINVAL;
+
+	if (args->guest_addr & page_mask)
+		return -EINVAL;
+
+	if (args->offset & page_mask)
+		return -EINVAL;
+
+	if (args->size & page_mask)
+		return -EINVAL;
+
+	binding->gfn = gunyah_gpa_to_gfn(args->guest_addr);
+	binding->ghvm = ghvm;
+	binding->i_off = args->offset >> PAGE_SHIFT;
+	binding->file = file;
+	binding->flags = args->flags;
+	binding->nr = args->size >> PAGE_SHIFT;
+
+	return 0;
+}
+
+static int gunyah_gmem_trim_binding(struct gunyah_gmem_binding *b,
+				    unsigned long start_delta,
+				    unsigned long end_delta)
+{
+	struct gunyah_vm *ghvm = b->ghvm;
+	int ret;
+
+	down_write(&ghvm->bindings_lock);
+	if (!start_delta && !end_delta) {
+		ret = gunyah_vm_reclaim_range(ghvm, b->gfn, b->nr);
+		if (ret)
+			goto unlock;
+		gunyah_gmem_remove_binding(b);
+	} else if (start_delta && !end_delta) {
+		/* shrink the beginning */
+		ret = gunyah_vm_reclaim_range(ghvm, b->gfn,
+					      b->gfn + start_delta);
+		if (ret)
+			goto unlock;
+		mtree_erase(&ghvm->bindings, b->gfn);
+		b->gfn += start_delta;
+		b->i_off += start_delta;
+		b->nr -= start_delta;
+		ret = mtree_insert_range(&ghvm->bindings, b->gfn,
+					 b->gfn + b->nr - 1, b, GFP_KERNEL);
+	} else if (!start_delta && end_delta) {
+		/* Shrink the end */
+		ret = gunyah_vm_reclaim_range(ghvm, b->gfn + b->nr - end_delta,
+					      b->gfn + b->nr);
+		if (ret)
+			goto unlock;
+		mtree_erase(&ghvm->bindings, b->gfn);
+		b->nr -= end_delta;
+		ret = mtree_insert_range(&ghvm->bindings, b->gfn,
+					 b->gfn + b->nr - 1, b, GFP_KERNEL);
+	} else {
+		/* TODO: split the mapping into 2 */
+		ret = -EINVAL;
+	}
+
+unlock:
+	up_write(&ghvm->bindings_lock);
+	return ret;
+}
+
+static int gunyah_gmem_remove_mapping(struct gunyah_vm *ghvm, struct file *file,
+				      struct gunyah_map_mem_args *args)
+{
+	struct inode *inode = file_inode(file);
+	struct gunyah_gmem_binding *b = NULL;
+	unsigned long start_delta, end_delta;
+	struct gunyah_gmem_binding remove;
+	int ret;
+
+	ret = gunyah_gmem_init_binding(ghvm, file, args, &remove);
+	if (ret)
+		return ret;
+
+	ret = -ENOENT;
+	filemap_invalidate_lock(inode->i_mapping);
+	list_for_each_entry(b, &inode->i_mapping->i_private_list, i_entry) {
+		if (b->ghvm != remove.ghvm || b->flags != remove.flags ||
+		    WARN_ON(b->file != remove.file))
+			continue;
+		/**
+		 * Test if the binding to remove is within this binding
+		 *  [gfn       b          nr]
+		 *   [gfn   remove   nr]
+		 */
+		if (b->gfn > remove.gfn)
+			continue;
+		if (b->gfn + b->nr < remove.gfn + remove.nr)
+			continue;
+
+		/**
+		 * We found the binding!
+		 * Compute the delta in gfn start and make sure the offset
+		 * into guest memfd matches.
+		 */
+		start_delta = remove.gfn - b->gfn;
+		if (remove.i_off - b->i_off != start_delta)
+			continue;
+		end_delta = remove.gfn + remove.nr - b->gfn - b->nr;
+
+		ret = gunyah_gmem_trim_binding(b, start_delta, end_delta);
+		break;
+	}
+
+	filemap_invalidate_unlock(inode->i_mapping);
+	return ret;
+}
+
+static bool gunyah_gmem_binding_allowed_overlap(struct gunyah_gmem_binding *a,
+						struct gunyah_gmem_binding *b)
+{
+	/* assumes we are operating on the same file, check to be sure */
+	BUG_ON(a->file != b->file);
+
+	/**
+	 * Gunyah only guarantees we can share a page with one VM and
+	 * doesn't (currently) allow us to share same page with multiple VMs,
+	 * regardless whether host can also access.
+	 * Gunyah supports, but Linux hasn't implemented mapping same page
+	 * into 2 separate addresses in guest's address space. This doesn't
+	 * seem reasonable today, but we could do it later.
+	 * All this to justify: check that the `a` region doesn't overlap with
+	 * `b` region w.r.t. file offsets.
+	 */
+	if (a->i_off + a->nr < b->i_off)
+		return false;
+	if (a->i_off > b->i_off + b->nr)
+		return false;
+
+	return true;
+}
+
+static int gunyah_gmem_add_mapping(struct gunyah_vm *ghvm, struct file *file,
+				   struct gunyah_map_mem_args *args)
+{
+	struct gunyah_gmem_binding *b, *tmp = NULL;
+	struct inode *inode = file_inode(file);
+	int ret;
+
+	b = kzalloc(sizeof(*b), GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+
+	ret = gunyah_gmem_init_binding(ghvm, file, args, b);
+	if (ret)
+		return ret;
+
+	filemap_invalidate_lock(inode->i_mapping);
+	list_for_each_entry(tmp, &inode->i_mapping->i_private_list, i_entry) {
+		if (!gunyah_gmem_binding_allowed_overlap(b, tmp)) {
+			ret = -EEXIST;
+			goto unlock;
+		}
+	}
+
+	ret = mtree_insert_range(&ghvm->bindings, b->gfn, b->gfn + b->nr - 1,
+				 b, GFP_KERNEL);
+	if (ret)
+		goto unlock;
+
+	list_add(&b->i_entry, &inode->i_mapping->i_private_list);
+
+unlock:
+	filemap_invalidate_unlock(inode->i_mapping);
+	return ret;
+}
+
+int gunyah_gmem_modify_mapping(struct gunyah_vm *ghvm,
+			       struct gunyah_map_mem_args *args)
+{
+	u8 access = args->flags & GUNYAH_MEM_ACCESS_MASK;
+	struct file *file;
+	int ret = -EINVAL;
+
+	file = fget(args->guest_mem_fd);
+	if (!file)
+		return -EINVAL;
+
+	if (file->f_op != &gunyah_gmem_fops)
+		goto err_file;
+
+	if (args->flags & ~(GUNYAH_MEM_ALLOW_RWX | GUNYAH_MEM_UNMAP | GUNYAH_MEM_ACCESS_MASK))
+		goto err_file;
+
+	/* VM needs to have some permissions to the memory */
+	if (!(args->flags & GUNYAH_MEM_ALLOW_RWX))
+		goto err_file;
+
+	if (access != GUNYAH_MEM_DEFAULT_ACCESS &&
+	    access != GUNYAH_MEM_FORCE_LEND && access != GUNYAH_MEM_FORCE_SHARE)
+		goto err_file;
+
+	if (!PAGE_ALIGNED(args->guest_addr) || !PAGE_ALIGNED(args->offset) ||
+	    !PAGE_ALIGNED(args->size))
+		goto err_file;
+
+	if (args->flags & GUNYAH_MEM_UNMAP) {
+		args->flags &= ~GUNYAH_MEM_UNMAP;
+		ret = gunyah_gmem_remove_mapping(ghvm, file, args);
+	} else {
+		ret = gunyah_gmem_add_mapping(ghvm, file, args);
+	}
+
+err_file:
+	if (ret)
+		fput(file);
+	return ret;
+}
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 33751d5cddd2..be2061aa0a06 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -397,6 +397,8 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 	INIT_LIST_HEAD(&ghvm->resource_tickets);
 
 	mt_init(&ghvm->mm);
+	mt_init(&ghvm->bindings);
+	init_rwsem(&ghvm->bindings_lock);
 
 	ghvm->addrspace_ticket.resource_type = GUNYAH_RESOURCE_TYPE_ADDR_SPACE;
 	ghvm->addrspace_ticket.label = GUNYAH_VM_ADDRSPACE_LABEL;
@@ -551,6 +553,14 @@ static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
 		r = gunyah_vm_rm_function_instance(ghvm, &f);
 		break;
 	}
+	case GUNYAH_VM_MAP_MEM: {
+		struct gunyah_map_mem_args args;
+
+		if (copy_from_user(&args, argp, sizeof(args)))
+			return -EFAULT;
+
+		return gunyah_gmem_modify_mapping(ghvm, &args);
+	}
 	default:
 		r = -ENOTTY;
 		break;
@@ -568,6 +578,8 @@ EXPORT_SYMBOL_GPL(gunyah_vm_get);
 static void _gunyah_vm_put(struct kref *kref)
 {
 	struct gunyah_vm *ghvm = container_of(kref, struct gunyah_vm, kref);
+	struct gunyah_gmem_binding *b;
+	unsigned long idx = 0;
 	int ret;
 
 	/**
@@ -579,6 +591,13 @@ static void _gunyah_vm_put(struct kref *kref)
 
 	gunyah_vm_remove_functions(ghvm);
 
+	down_write(&ghvm->bindings_lock);
+	mt_for_each(&ghvm->bindings, b, idx, ULONG_MAX) {
+		gunyah_gmem_remove_binding(b);
+	}
+	up_write(&ghvm->bindings_lock);
+	WARN_ON(!mtree_empty(&ghvm->bindings));
+	mtree_destroy(&ghvm->bindings);
 	/**
 	 * If this fails, we're going to lose the memory for good and is
 	 * BUG_ON-worthy, but not unrecoverable (we just lose memory).
@@ -606,6 +625,7 @@ static void _gunyah_vm_put(struct kref *kref)
 			   ghvm->vm_status == GUNYAH_RM_VM_STATUS_RESET);
 	}
 
+	WARN_ON(!mtree_empty(&ghvm->mm));
 	mtree_destroy(&ghvm->mm);
 
 	if (ghvm->vm_status > GUNYAH_RM_VM_STATUS_NO_STATE) {
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 055990842959..518d05eeb642 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -36,6 +36,9 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
  * @mm: A maple tree of all memory that has been mapped to a VM.
  *      Indices are guest frame numbers; entries are either folios or
  *      RM mem parcels
+ * @bindings: A maple tree of guest memfd bindings. Indices are guest frame
+ *            numbers; entries are &struct gunyah_gmem_binding
+ * @bindings_lock: For serialization to @bindings
  * @addrspace_ticket: Resource ticket to the capability for guest VM's
  *                    address space
  * @host_private_extent_ticket: Resource ticket to the capability for our
@@ -75,6 +78,8 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
 struct gunyah_vm {
 	u16 vmid;
 	struct maple_tree mm;
+	struct maple_tree bindings;
+	struct rw_semaphore bindings_lock;
 	struct gunyah_vm_resource_ticket addrspace_ticket,
 		host_private_extent_ticket, host_shared_extent_ticket,
 		guest_private_extent_ticket, guest_shared_extent_ticket;
@@ -110,5 +115,9 @@ int gunyah_vm_reclaim_folio(struct gunyah_vm *ghvm, u64 gfn);
 int gunyah_vm_reclaim_range(struct gunyah_vm *ghvm, u64 gfn, u64 nr);
 
 int gunyah_guest_mem_create(struct gunyah_create_mem_args *args);
+int gunyah_gmem_modify_mapping(struct gunyah_vm *ghvm,
+			       struct gunyah_map_mem_args *args);
+struct gunyah_gmem_binding;
+void gunyah_gmem_remove_binding(struct gunyah_gmem_binding *binding);
 
 #endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index c5f506350364..1af4c5ae6bc3 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -87,6 +87,47 @@ struct gunyah_fn_desc {
 #define GUNYAH_VM_ADD_FUNCTION	_IOW(GUNYAH_IOCTL_TYPE, 0x4, struct gunyah_fn_desc)
 #define GUNYAH_VM_REMOVE_FUNCTION	_IOW(GUNYAH_IOCTL_TYPE, 0x7, struct gunyah_fn_desc)
 
+/**
+ * enum gunyah_map_flags- Possible flags on &struct gunyah_map_mem_args
+ * @GUNYAH_MEM_DEFAULT_SHARE: Use default host access for the VM type
+ * @GUNYAH_MEM_FORCE_LEND: Force unmapping the memory once the guest starts to use
+ * @GUNYAH_MEM_FORCE_SHARE: Allow host to continue accessing memory when guest starts to use
+ * @GUNYAH_MEM_ALLOW_READ: Allow guest to read memory
+ * @GUNYAH_MEM_ALLOW_WRITE: Allow guest to write to the memory
+ * @GUNYAH_MEM_ALLOW_EXEC: Allow guest to execute instructions in the memory
+ */
+enum gunyah_map_flags {
+	GUNYAH_MEM_DEFAULT_ACCESS = 0,
+	GUNYAH_MEM_FORCE_LEND = 1,
+	GUNYAH_MEM_FORCE_SHARE = 2,
+#define GUNYAH_MEM_ACCESS_MASK 0x7
+
+	GUNYAH_MEM_ALLOW_READ = 1UL << 4,
+	GUNYAH_MEM_ALLOW_WRITE = 1UL << 5,
+	GUNYAH_MEM_ALLOW_EXEC = 1UL << 6,
+	GUNYAH_MEM_ALLOW_RWX =
+		(GUNYAH_MEM_ALLOW_READ | GUNYAH_MEM_ALLOW_WRITE | GUNYAH_MEM_ALLOW_EXEC),
+
+	GUNYAH_MEM_UNMAP = 1UL << 8,
+};
+
+/**
+ * struct gunyah_map_mem_args - Description to provide guest memory into a VM
+ * @guest_addr: Location in guest address space to place the memory
+ * @flags: See &enum gunyah_map_flags.
+ * @guest_mem_fd: File descriptor created by GUNYAH_CREATE_GUEST_MEM
+ * @offset: Offset into the guest memory file
+ */
+struct gunyah_map_mem_args {
+	__u64 guest_addr;
+	__u32 flags;
+	__u32 guest_mem_fd;
+	__u64 offset;
+	__u64 size;
+};
+
+#define GUNYAH_VM_MAP_MEM _IOW(GUNYAH_IOCTL_TYPE, 0x9, struct gunyah_map_mem_args)
+
 /*
  * ioctls for vCPU fds
  */

-- 
2.34.1


