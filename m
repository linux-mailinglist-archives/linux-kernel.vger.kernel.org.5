Return-Path: <linux-kernel+bounces-1888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4D7815550
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045FCB24793
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2328B328D2;
	Sat, 16 Dec 2023 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mx1hzJaM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB79182A4;
	Sat, 16 Dec 2023 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFNSS0b027076;
	Sat, 16 Dec 2023 00:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=/cYOlK65HujdYzwJs0ckTKZs9llWD5IUZ2Dzlq7BYnI
	=; b=mx1hzJaMIuuBYbnW+BfgQP5lN222evWI0RsOSIs+jWJVAvCg3YM3BlKfcq0
	89ceV7FDqvSlDJTumEHa0oAm3MUxf9yzQ/YLzjpCf9nka37eM2jCKHdk/CaVXTr3
	0t+BYcbBVMVi7R+dDt4MhQJA2ao3bPMXlsXY5B6kYpNTJX4igwbfk/W8T4FcANhx
	mZ6ZR3xnlQtpvdsgY+1u6RgNM4APA8QQOryapR1nSKHPlo0nFV57dadtNrQwpGQG
	a8ciUMnU2o7dKLN75E5UXasRd24coJLDI4jqFJa12VlcnA5+Wv7nRqHmdi6zxYDT
	gbfaRluUvmm/u1ivy67cHWDJ9xg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0k90t5ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LD37015665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:13 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:12 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:21:02 -0800
Subject: [PATCH RFC v15 21/30] virt: gunyah: Add ioctl to bind guestmem to
 VMs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-21-192a5d872a30@quicinc.com>
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
X-Proofpoint-ORIG-GUID: t9N_XQ52W1tJiv5yM9H5eglzb0MovlC9
X-Proofpoint-GUID: t9N_XQ52W1tJiv5yM9H5eglzb0MovlC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160001

A maple tree is used to maintain a map from guest address ranges to a
guestmemfd that provides the memory for that range of memory for the
guest. The mapping of guest address range to guestmemfd is called a
binding. Implement an ioctl to add/remove bindings to the virtual
machine. The binding determines whether the memory is shared (host
retains access) or lent (host loses access).

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/guest_memfd.c | 277 ++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.c      |  15 +++
 drivers/virt/gunyah/vm_mgr.h      |   6 +
 include/uapi/linux/gunyah.h       |  41 ++++++
 4 files changed, 339 insertions(+)

diff --git a/drivers/virt/gunyah/guest_memfd.c b/drivers/virt/gunyah/guest_memfd.c
index 709aae9a1f44..c38380c4dc50 100644
--- a/drivers/virt/gunyah/guest_memfd.c
+++ b/drivers/virt/gunyah/guest_memfd.c
@@ -9,11 +9,61 @@
 #include <linux/types.h>
 #include <linux/falloc.h>
 #include <linux/file.h>
+#include <linux/maple_tree.h>
 #include <linux/migrate.h>
 #include <linux/pagemap.h>
 
 #include <uapi/linux/gunyah.h>
 
+#include "vm_mgr.h"
+
+/**
+ * struct gunyah_gmem_binding - Represents a binding of guestmem to a Gunyah VM
+ * @gfn: Guest address to place acquired folios
+ * @ghvm: Pointer to Gunyah VM in this binding
+ * @mt: Maple tree to track folios which have been provided to the VM
+ * @i_off: offset into the guestmem to grab folios from
+ * @inode: Pointer to guest mem inode
+ * @i_entry: list entry for inode->i_private_list
+ * @flags: Access flags for the binding
+ * @nr: Number of pages covered by this binding
+ */
+struct gunyah_gmem_binding {
+	u64 gfn;
+	struct gunyah_vm *ghvm;
+	struct maple_tree mt;
+
+	pgoff_t i_off;
+	struct inode *inode;
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
@@ -191,8 +241,15 @@ static long gunyah_gmem_fallocate(struct file *file, int mode, loff_t offset,
 
 static int gunyah_gmem_release(struct inode *inode, struct file *file)
 {
+	struct gunyah_gmem_binding *b, *n;
+
 	gunyah_gmem_punch_hole(inode, 0, U64_MAX);
 
+	list_for_each_entry_safe(b, n, &inode->i_mapping->i_private_list,
+				 i_entry) {
+		gunyah_gmem_remove_binding(b);
+	}
+
 	return 0;
 }
 
@@ -267,3 +324,223 @@ int gunyah_guest_mem_create(struct gunyah_create_mem_args *args)
 	put_unused_fd(fd);
 	return err;
 }
+
+void gunyah_gmem_remove_binding(struct gunyah_gmem_binding *b)
+{
+	mtree_erase(&b->ghvm->mem_layout, b->gfn);
+	list_del(&b->i_entry);
+	kfree(b);
+}
+
+static inline unsigned long gunyah_gmem_page_mask(struct inode *inode)
+{
+	unsigned long gmem_flags = (unsigned long)inode->i_private;
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
+static int gunyah_gmem_init_binding(struct gunyah_vm *ghvm, struct inode *inode,
+				    struct gunyah_map_mem_args *args,
+				    struct gunyah_gmem_binding *binding)
+{
+	const unsigned long page_mask = ~gunyah_gmem_page_mask(inode);
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
+	binding->inode = inode;
+	binding->flags = args->flags;
+	binding->nr = args->size >> PAGE_SHIFT;
+
+	return 0;
+}
+
+static int gunyah_gmem_remove_mapping(struct gunyah_vm *ghvm,
+				      struct inode *inode,
+				      struct gunyah_map_mem_args *args)
+{
+	struct gunyah_gmem_binding argb;
+	struct gunyah_gmem_binding *b = NULL;
+	unsigned long start_delta, end_delta;
+	int ret;
+
+	ret = gunyah_gmem_init_binding(ghvm, inode, args, &argb);
+	if (ret)
+		return ret;
+
+	filemap_invalidate_lock(inode->i_mapping);
+	list_for_each_entry(b, &inode->i_mapping->i_private_list, i_entry) {
+		if (b->ghvm != argb.ghvm || b->flags != argb.flags ||
+		    WARN_ON(b->inode != argb.inode))
+			continue;
+		/* Check if argb guest addresses is within b */
+		if (b->gfn > argb.gfn)
+			continue;
+		if (b->gfn + b->nr < argb.gfn + argb.nr)
+			continue;
+		start_delta = argb.gfn - b->gfn;
+		if (argb.i_off - b->i_off != start_delta)
+			continue;
+		end_delta = argb.gfn + argb.nr - b->gfn - b->nr;
+		if (!start_delta && !end_delta) {
+			/* wipe the mapping entirely */
+			gunyah_gmem_remove_binding(b);
+			goto out;
+		} else if (start_delta && !end_delta) {
+			/* shrink the end */
+			down_write(&ghvm->mem_lock);
+			mtree_erase(&b->ghvm->mem_layout, b->gfn);
+			b->nr = start_delta;
+			ret = mtree_insert_range(&ghvm->mem_layout, b->gfn,
+						 b->gfn + b->nr - 1, b,
+						 GFP_KERNEL);
+			up_write(&ghvm->mem_lock);
+			goto out;
+		} else if (!start_delta && end_delta) {
+			/* Shrink the beginning */
+			down_write(&ghvm->mem_lock);
+			mtree_erase(&b->ghvm->mem_layout, b->gfn);
+			b->gfn += argb.nr;
+			b->i_off += argb.nr;
+			b->nr -= argb.nr;
+			ret = mtree_insert_range(&ghvm->mem_layout, b->gfn,
+						 b->gfn + b->nr - 1, b,
+						 GFP_KERNEL);
+			up_write(&ghvm->mem_lock);
+			goto out;
+		} else {
+			/* TODO: split the mapping into 2 */
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	ret = -ENOENT;
+out:
+	filemap_invalidate_unlock(inode->i_mapping);
+	return ret;
+}
+
+static bool gunyah_gmem_binding_allowed_overlap(struct gunyah_gmem_binding *a,
+						struct gunyah_gmem_binding *b)
+{
+	/* Bindings can't overlap within a VM. Only one guest mem can
+	 * provide for a given guest address
+	 */
+	if (a->ghvm == b->ghvm && a->gfn + a->nr <= b->gfn &&
+	    a->gfn >= b->gfn + b->nr)
+		return false;
+
+	/* Gunyah only guarantees we can share a page with one VM and
+	 * doesn't (currently) allow us to share same page with multiple VMs,
+	 * regardless whether host can also access.
+	 */
+	if (a->inode == b->inode) {
+		if (a->ghvm == b->ghvm) {
+			if (gunyah_guest_mem_is_lend(a->ghvm, a->flags) ||
+			    gunyah_guest_mem_is_lend(b->ghvm, b->flags))
+				return false;
+		} else {
+			if (a->i_off + a->nr < b->i_off)
+				return false;
+			if (a->i_off > b->i_off + b->nr)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static int gunyah_gmem_add_mapping(struct gunyah_vm *ghvm, struct inode *inode,
+				   struct gunyah_map_mem_args *args)
+{
+	struct gunyah_gmem_binding *b, *tmp = NULL;
+	int ret;
+
+	b = kzalloc(sizeof(*b), GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+
+	ret = gunyah_gmem_init_binding(ghvm, inode, args, b);
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
+	ret = mtree_insert_range(&ghvm->mem_layout, b->gfn, b->gfn + b->nr - 1,
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
+int gunyah_gmem_modify_binding(struct gunyah_vm *ghvm,
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
+		ret = gunyah_gmem_remove_mapping(ghvm, file_inode(file), args);
+	} else {
+		ret = gunyah_gmem_add_mapping(ghvm, file_inode(file), args);
+	}
+
+err_file:
+	fput(file);
+	return ret;
+}
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index cd978d1ce93f..5666070453aa 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -519,6 +519,8 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 	mutex_init(&ghvm->fn_lock);
 
 	mt_init(&ghvm->gm);
+	mt_init(&ghvm->mem_layout);
+	init_rwsem(&ghvm->mem_lock);
 
 	ghvm->addrspace_ticket.resource_type = GUNYAH_RESOURCE_TYPE_ADDR_SPACE;
 	ghvm->addrspace_ticket.label = GUNYAH_VM_ADDRSPACE_LABEL;
@@ -673,6 +675,14 @@ static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
 		r = gunyah_vm_rm_function_instance(ghvm, &f);
 		break;
 	}
+	case GUNYAH_VM_MAP_MEM: {
+		struct gunyah_map_mem_args args;
+
+		if (copy_from_user(&args, argp, sizeof(args)))
+			return -EFAULT;
+
+		return gunyah_gmem_modify_binding(ghvm, &args);
+	}
 	default:
 		r = -ENOTTY;
 		break;
@@ -690,6 +700,8 @@ EXPORT_SYMBOL_GPL(gunyah_vm_get);
 static void _gunyah_vm_put(struct kref *kref)
 {
 	struct gunyah_vm *ghvm = container_of(kref, struct gunyah_vm, kref);
+	struct gunyah_gmem_binding *b;
+	unsigned long idx = 0;
 	int ret;
 
 	if (ghvm->vm_status == GUNYAH_RM_VM_STATUS_RUNNING)
@@ -697,6 +709,9 @@ static void _gunyah_vm_put(struct kref *kref)
 
 	gunyah_vm_remove_functions(ghvm);
 
+	mt_for_each(&ghvm->mem_layout, b, idx, ULONG_MAX)
+		gunyah_gmem_remove_binding(b);
+	mtree_destroy(&ghvm->mem_layout);
 	gunyah_vm_reclaim_memory(ghvm);
 
 	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->addrspace_ticket);
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index d26693d10d22..8f1c3ade08dd 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -36,6 +36,8 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
 struct gunyah_vm {
 	u16 vmid;
 	struct maple_tree gm;
+	struct maple_tree mem_layout;
+	struct rw_semaphore mem_lock;
 	struct gunyah_vm_resource_ticket addrspace_ticket,
 		host_private_extent_ticket, host_shared_extent_ticket,
 		guest_private_extent_ticket, guest_shared_extent_ticket;
@@ -78,5 +80,9 @@ void gunyah_vm_reclaim_memory(struct gunyah_vm *ghvm);
 int gunyah_vm_mmio_write(struct gunyah_vm *ghvm, u64 addr, u32 len, u64 data);
 
 int gunyah_guest_mem_create(struct gunyah_create_mem_args *args);
+int gunyah_gmem_modify_binding(struct gunyah_vm *ghvm,
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
2.43.0


