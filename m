Return-Path: <linux-kernel+bounces-21342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3805B828DEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5106D1C24ACE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A893D54C;
	Tue,  9 Jan 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kvkp5i7S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D640BF3;
	Tue,  9 Jan 2024 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409FdruS011442;
	Tue, 9 Jan 2024 19:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=mCvTvHnDAvi/Z3r/fbIcWBXtbKnYIFgrJK9nQ4SRZtQ
	=; b=kvkp5i7ShIhFPfNEBWrulkEmXtEQ+gwLJ/1+msn+NXbqJ5ouKzdjF6fxpq1
	ZJaGNz9sV8hh3IAOe4Y16AWq6r+peU2NATbyLQZZh8pSudmPOLCu05eWwABKzTMd
	vBuTcd4vrXtvDF7+mbTV7XT1CbUGgda+nfyLLbtwdxZlLANUnrQpSRU80Iu5V8W2
	/dqd2bUeBASYSTQD/ZDxV2U5ul/PNMaOvkJF+AF2HkRotc8R8frIA+VM5QHLEJDc
	Ac8w0h80BDHN/bK10KN14A5SeNJ8bB1I3w+qIfE6Yg07mIz10VXz7y8MsTqAb09l
	W41CNyMhqnpPb7VkVHUtr8bi/Uw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh3me1858-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:38:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jc1X8024580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:38:01 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:38:00 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:37:56 -0800
Subject: [PATCH v16 18/34] virt: gunyah: Add interfaces to map memory into
 guest address space
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-18-634904bf4ce9@quicinc.com>
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
X-Proofpoint-ORIG-GUID: JhWjMLDtmjxLfi0BZgG3YWzgoCejQ_Wn
X-Proofpoint-GUID: JhWjMLDtmjxLfi0BZgG3YWzgoCejQ_Wn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Gunyah virtual machines are created with either all memory provided at
VM creation using the Resource Manager memory parcel construct, or
Incrementally by enabling VM demand paging.

The Gunyah demand paging support is provided directly by the hypervisor
and does not require the creation of resource manager memory parcels.

Demand paging allows the host to map/unmap contiguous pages (folios) to
a Gunyah memory extent object with the correct rights allowing its
contained pages to be mapped into the Guest VM's address space. Memory
extents are Gunyah's mechanism for handling system memory abstracting
from the direct use of physical page numbers. Memory extents are
hypervisor objects and are therefore referenced and access controlled
with capabilities.

When a virtual machine is configured for demand paging, 3 memory
extent and 1 address space capabilities are provided to the host. The
resource manager defined policy is such that memory in the "host-only"
extent (the default) is private to the host. Memory in the "guest-only"
extent can be used for guest private mappings, and are unmapped from the
host. Memory in the "host-and-guest-shared" extent can be mapped
concurrently and shared between the host and guest VMs.

Implement two functions which Linux can use to move memory between the
virtual machines: gunyah_provide_folio and gunyah_reclaim_folio. Memory
that has been provided to the guest is tracked in a maple tree to be
reclaimed later. Folios provided to the virtual machine are assumed to
be owned Gunyah stack: the folio's ->private field is used for
bookkeeping about whether page is mapped into virtual machine.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile     |   2 +-
 drivers/virt/gunyah/vm_mgr.c     |  67 +++++++++
 drivers/virt/gunyah/vm_mgr.h     |  46 ++++++
 drivers/virt/gunyah/vm_mgr_mem.c | 309 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 423 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 3f82af8c5ce7..f3c9507224ee 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mem.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o gunyah_vcpu.o
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index db3d1d18ccb8..26b6dce49970 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -17,6 +17,16 @@
 #include "rsc_mgr.h"
 #include "vm_mgr.h"
 
+#define GUNYAH_VM_ADDRSPACE_LABEL 0
+// "To" extent for memory private to guest
+#define GUNYAH_VM_MEM_EXTENT_GUEST_PRIVATE_LABEL 0
+// "From" extent for memory shared with guest
+#define GUNYAH_VM_MEM_EXTENT_HOST_SHARED_LABEL 1
+// "To" extent for memory shared with the guest
+#define GUNYAH_VM_MEM_EXTENT_GUEST_SHARED_LABEL 3
+// "From" extent for memory private to guest
+#define GUNYAH_VM_MEM_EXTENT_HOST_PRIVATE_LABEL 2
+
 static DEFINE_XARRAY(gunyah_vm_functions);
 
 static void gunyah_vm_put_function(struct gunyah_vm_function *fn)
@@ -175,6 +185,16 @@ void gunyah_vm_function_unregister(struct gunyah_vm_function *fn)
 }
 EXPORT_SYMBOL_GPL(gunyah_vm_function_unregister);
 
+static bool gunyah_vm_resource_ticket_populate_noop(
+	struct gunyah_vm_resource_ticket *ticket, struct gunyah_resource *ghrsc)
+{
+	return true;
+}
+static void gunyah_vm_resource_ticket_unpopulate_noop(
+	struct gunyah_vm_resource_ticket *ticket, struct gunyah_resource *ghrsc)
+{
+}
+
 int gunyah_vm_add_resource_ticket(struct gunyah_vm *ghvm,
 				  struct gunyah_vm_resource_ticket *ticket)
 {
@@ -342,6 +362,17 @@ static void gunyah_vm_stop(struct gunyah_vm *ghvm)
 		   ghvm->vm_status != GUNYAH_RM_VM_STATUS_RUNNING);
 }
 
+static inline void setup_extent_ticket(struct gunyah_vm *ghvm,
+				       struct gunyah_vm_resource_ticket *ticket,
+				       u32 label)
+{
+	ticket->resource_type = GUNYAH_RESOURCE_TYPE_MEM_EXTENT;
+	ticket->label = label;
+	ticket->populate = gunyah_vm_resource_ticket_populate_noop;
+	ticket->unpopulate = gunyah_vm_resource_ticket_unpopulate_noop;
+	gunyah_vm_add_resource_ticket(ghvm, ticket);
+}
+
 static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 {
 	struct gunyah_vm *ghvm;
@@ -365,6 +396,25 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 	INIT_LIST_HEAD(&ghvm->resources);
 	INIT_LIST_HEAD(&ghvm->resource_tickets);
 
+	mt_init(&ghvm->mm);
+
+	ghvm->addrspace_ticket.resource_type = GUNYAH_RESOURCE_TYPE_ADDR_SPACE;
+	ghvm->addrspace_ticket.label = GUNYAH_VM_ADDRSPACE_LABEL;
+	ghvm->addrspace_ticket.populate =
+		gunyah_vm_resource_ticket_populate_noop;
+	ghvm->addrspace_ticket.unpopulate =
+		gunyah_vm_resource_ticket_unpopulate_noop;
+	gunyah_vm_add_resource_ticket(ghvm, &ghvm->addrspace_ticket);
+
+	setup_extent_ticket(ghvm, &ghvm->host_private_extent_ticket,
+			    GUNYAH_VM_MEM_EXTENT_HOST_PRIVATE_LABEL);
+	setup_extent_ticket(ghvm, &ghvm->host_shared_extent_ticket,
+			    GUNYAH_VM_MEM_EXTENT_HOST_SHARED_LABEL);
+	setup_extent_ticket(ghvm, &ghvm->guest_private_extent_ticket,
+			    GUNYAH_VM_MEM_EXTENT_GUEST_PRIVATE_LABEL);
+	setup_extent_ticket(ghvm, &ghvm->guest_shared_extent_ticket,
+			    GUNYAH_VM_MEM_EXTENT_GUEST_SHARED_LABEL);
+
 	return ghvm;
 }
 
@@ -528,6 +578,21 @@ static void _gunyah_vm_put(struct kref *kref)
 		gunyah_vm_stop(ghvm);
 
 	gunyah_vm_remove_functions(ghvm);
+
+	/**
+	 * If this fails, we're going to lose the memory for good and is
+	 * BUG_ON-worthy, but not unrecoverable (we just lose memory).
+	 * This call should always succeed though because the VM is in not
+	 * running and RM will let us reclaim all the memory.
+	 */
+	WARN_ON(gunyah_vm_reclaim_range(ghvm, 0, U64_MAX));
+
+	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->addrspace_ticket);
+	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->host_shared_extent_ticket);
+	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->host_private_extent_ticket);
+	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->guest_shared_extent_ticket);
+	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->guest_private_extent_ticket);
+
 	gunyah_vm_clean_resources(ghvm);
 
 	if (ghvm->vm_status != GUNYAH_RM_VM_STATUS_NO_STATE &&
@@ -541,6 +606,8 @@ static void _gunyah_vm_put(struct kref *kref)
 			   ghvm->vm_status == GUNYAH_RM_VM_STATUS_RESET);
 	}
 
+	mtree_destroy(&ghvm->mm);
+
 	if (ghvm->vm_status > GUNYAH_RM_VM_STATUS_NO_STATE) {
 		gunyah_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
 
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 8c5b94101b2c..e500f6eb014e 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/kref.h>
+#include <linux/maple_tree.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
@@ -16,12 +17,42 @@
 
 #include "rsc_mgr.h"
 
+static inline u64 gunyah_gpa_to_gfn(u64 gpa)
+{
+	return gpa >> PAGE_SHIFT;
+}
+
+static inline u64 gunyah_gfn_to_gpa(u64 gfn)
+{
+	return gfn << PAGE_SHIFT;
+}
+
 long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
 			     unsigned long arg);
 
 /**
  * struct gunyah_vm - Main representation of a Gunyah Virtual machine
  * @vmid: Gunyah's VMID for this virtual machine
+ * @mm: A maple tree of all memory that has been mapped to a VM.
+ *      Indices are guest frame numbers; entries are either folios or
+ *      RM mem parcels
+ * @addrspace_ticket: Resource ticket to the capability for guest VM's
+ *                    address space
+ * @host_private_extent_ticket: Resource ticket to the capability for our
+ *                              memory extent from which to lend private
+ *                              memory to the guest
+ * @host_shared_extent_ticket: Resource ticket to the capaiblity for our
+ *                             memory extent from which to share memory
+ *                             with the guest. Distinction with
+ *                             @host_private_extent_ticket needed for
+ *                             current Qualcomm platforms; on non-Qualcomm
+ *                             platforms, this is the same capability ID
+ * @guest_private_extent_ticket: Resource ticket to the capaiblity for
+ *                               the guest's memory extent to lend private
+ *                               memory to
+ * @guest_shared_extent_ticket: Resource ticket to the capability for
+ *                              the memory extent that represents
+ *                              memory shared with the guest.
  * @rm: Pointer to the resource manager struct to make RM calls
  * @parent: For logging
  * @nb: Notifier block for RM notifications
@@ -43,6 +74,11 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
  */
 struct gunyah_vm {
 	u16 vmid;
+	struct maple_tree mm;
+	struct gunyah_vm_resource_ticket addrspace_ticket,
+		host_private_extent_ticket, host_shared_extent_ticket,
+		guest_private_extent_ticket, guest_shared_extent_ticket;
+
 	struct gunyah_rm *rm;
 
 	struct notifier_block nb;
@@ -63,4 +99,14 @@ struct gunyah_vm {
 
 };
 
+int gunyah_vm_parcel_to_paged(struct gunyah_vm *ghvm,
+			      struct gunyah_rm_mem_parcel *parcel, u64 gfn,
+			      u64 nr);
+int gunyah_vm_reclaim_parcel(struct gunyah_vm *ghvm,
+			     struct gunyah_rm_mem_parcel *parcel, u64 gfn);
+int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
+			    u64 gfn, bool share, bool write);
+int gunyah_vm_reclaim_folio(struct gunyah_vm *ghvm, u64 gfn);
+int gunyah_vm_reclaim_range(struct gunyah_vm *ghvm, u64 gfn, u64 nr);
+
 #endif
diff --git a/drivers/virt/gunyah/vm_mgr_mem.c b/drivers/virt/gunyah/vm_mgr_mem.c
new file mode 100644
index 000000000000..d3fcb4514907
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr_mem.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gunyah_vm_mgr: " fmt
+
+#include <asm/gunyah.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+
+#include "vm_mgr.h"
+
+#define WRITE_TAG (1 << 0)
+#define SHARE_TAG (1 << 1)
+
+static inline struct gunyah_resource *
+__first_resource(struct gunyah_vm_resource_ticket *ticket)
+{
+	return list_first_entry_or_null(&ticket->resources,
+					struct gunyah_resource, list);
+}
+
+int gunyah_vm_parcel_to_paged(struct gunyah_vm *ghvm,
+			      struct gunyah_rm_mem_parcel *parcel, u64 gfn,
+			      u64 nr)
+{
+	struct gunyah_rm_mem_entry *entry;
+	unsigned long i, entry_size, tag = 0;
+	struct folio *folio;
+	pgoff_t off = 0;
+	int ret;
+
+	if (parcel->n_acl_entries > 1)
+		tag |= SHARE_TAG;
+	if (parcel->acl_entries[0].perms & GUNYAH_RM_ACL_W)
+		tag |= WRITE_TAG;
+
+	for (i = 0; i < parcel->n_mem_entries; i++) {
+		entry = &parcel->mem_entries[i];
+		entry_size = PHYS_PFN(le64_to_cpu(entry->size));
+
+		folio = pfn_folio(PHYS_PFN(le64_to_cpu(entry->phys_addr)));
+		ret = mtree_insert_range(&ghvm->mm, gfn + off, gfn + off + folio_nr_pages(folio) - 1, xa_tag_pointer(folio, tag), GFP_KERNEL);
+		if (ret == -ENOMEM)
+			return ret;
+		BUG_ON(ret);
+		off += folio_nr_pages(folio);
+	}
+
+	BUG_ON(off != nr);
+
+	return 0;
+}
+
+static inline u32 donate_flags(bool share)
+{
+	if (share)
+		return FIELD_PREP_CONST(GUNYAH_MEMEXTENT_OPTION_TYPE_MASK,
+					GUNYAH_MEMEXTENT_DONATE_TO_SIBLING);
+	else
+		return FIELD_PREP_CONST(GUNYAH_MEMEXTENT_OPTION_TYPE_MASK,
+					GUNYAH_MEMEXTENT_DONATE_TO_PROTECTED);
+}
+
+static inline u32 reclaim_flags(bool share)
+{
+	if (share)
+		return FIELD_PREP_CONST(GUNYAH_MEMEXTENT_OPTION_TYPE_MASK,
+					GUNYAH_MEMEXTENT_DONATE_TO_SIBLING);
+	else
+		return FIELD_PREP_CONST(GUNYAH_MEMEXTENT_OPTION_TYPE_MASK,
+					GUNYAH_MEMEXTENT_DONATE_FROM_PROTECTED);
+}
+
+int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
+			    u64 gfn, bool share, bool write)
+{
+	struct gunyah_resource *guest_extent, *host_extent, *addrspace;
+	u32 map_flags = BIT(GUNYAH_ADDRSPACE_MAP_FLAG_PARTIAL);
+	u64 extent_attrs, gpa = gunyah_gfn_to_gpa(gfn);
+	phys_addr_t pa = PFN_PHYS(folio_pfn(folio));
+	enum gunyah_pagetable_access access;
+	size_t size = folio_size(folio);
+	enum gunyah_error gunyah_error;
+	unsigned long tag = 0;
+	int ret;
+
+	/* clang-format off */
+	if (share) {
+		guest_extent = __first_resource(&ghvm->guest_shared_extent_ticket);
+		host_extent = __first_resource(&ghvm->host_shared_extent_ticket);
+	} else {
+		guest_extent = __first_resource(&ghvm->guest_private_extent_ticket);
+		host_extent = __first_resource(&ghvm->host_private_extent_ticket);
+	}
+	/* clang-format on */
+	addrspace = __first_resource(&ghvm->addrspace_ticket);
+
+	if (!addrspace || !guest_extent || !host_extent)
+		return -ENODEV;
+
+	if (share) {
+		map_flags |= BIT(GUNYAH_ADDRSPACE_MAP_FLAG_VMMIO);
+		tag |= SHARE_TAG;
+	} else {
+		map_flags |= BIT(GUNYAH_ADDRSPACE_MAP_FLAG_PRIVATE);
+	}
+
+	if (write)
+		tag |= WRITE_TAG;
+
+	ret = mtree_insert_range(&ghvm->mm, gfn,
+				 gfn + folio_nr_pages(folio) - 1,
+				 xa_tag_pointer(folio, tag), GFP_KERNEL);
+	if (ret == -EEXIST)
+		return -EAGAIN;
+	if (ret)
+		return ret;
+
+	if (share && write)
+		access = GUNYAH_PAGETABLE_ACCESS_RW;
+	else if (share && !write)
+		access = GUNYAH_PAGETABLE_ACCESS_R;
+	else if (!share && write)
+		access = GUNYAH_PAGETABLE_ACCESS_RWX;
+	else /* !share && !write */
+		access = GUNYAH_PAGETABLE_ACCESS_RX;
+
+	gunyah_error = gunyah_hypercall_memextent_donate(donate_flags(share),
+							 host_extent->capid,
+							 guest_extent->capid,
+							 pa, size);
+	if (gunyah_error != GUNYAH_ERROR_OK) {
+		pr_err("Failed to donate memory for guest address 0x%016llx: %d\n",
+		       gpa, gunyah_error);
+		ret = gunyah_error_remap(gunyah_error);
+		goto remove;
+	}
+
+	extent_attrs =
+		FIELD_PREP_CONST(GUNYAH_MEMEXTENT_MAPPING_TYPE,
+				 ARCH_GUNYAH_DEFAULT_MEMTYPE) |
+		FIELD_PREP(GUNYAH_MEMEXTENT_MAPPING_USER_ACCESS, access) |
+		FIELD_PREP(GUNYAH_MEMEXTENT_MAPPING_KERNEL_ACCESS, access);
+	gunyah_error = gunyah_hypercall_addrspace_map(addrspace->capid,
+						      guest_extent->capid, gpa,
+						      extent_attrs, map_flags,
+						      pa, size);
+	if (gunyah_error != GUNYAH_ERROR_OK) {
+		pr_err("Failed to map guest address 0x%016llx: %d\n", gpa,
+		       gunyah_error);
+		ret = gunyah_error_remap(gunyah_error);
+		goto memextent_reclaim;
+	}
+
+	folio_get(folio);
+	if (!share)
+		folio_set_private(folio);
+	return 0;
+memextent_reclaim:
+	gunyah_error = gunyah_hypercall_memextent_donate(reclaim_flags(share),
+							 guest_extent->capid,
+							 host_extent->capid, pa,
+							 size);
+	if (gunyah_error != GUNYAH_ERROR_OK)
+		pr_err("Failed to reclaim memory donation for guest address 0x%016llx: %d\n",
+		       gpa, gunyah_error);
+remove:
+	mtree_erase(&ghvm->mm, gfn);
+	return ret;
+}
+
+static int __gunyah_vm_reclaim_folio_locked(struct gunyah_vm *ghvm, void *entry,
+					    u64 gfn, const bool sync)
+{
+	u32 map_flags = BIT(GUNYAH_ADDRSPACE_MAP_FLAG_PARTIAL);
+	struct gunyah_resource *guest_extent, *host_extent, *addrspace;
+	enum gunyah_pagetable_access access;
+	enum gunyah_error gunyah_error;
+	struct folio *folio;
+	bool write, share;
+	phys_addr_t pa;
+	size_t size;
+	int ret;
+
+	addrspace = __first_resource(&ghvm->addrspace_ticket);
+	if (!addrspace)
+		return -ENODEV;
+
+	share = !!(xa_pointer_tag(entry) & SHARE_TAG);
+	write = !!(xa_pointer_tag(entry) & WRITE_TAG);
+	folio = xa_untag_pointer(entry);
+
+	if (!sync)
+		map_flags |= BIT(GUNYAH_ADDRSPACE_MAP_FLAG_NOSYNC);
+
+	/* clang-format off */
+	if (share) {
+		guest_extent = __first_resource(&ghvm->guest_shared_extent_ticket);
+		host_extent = __first_resource(&ghvm->host_shared_extent_ticket);
+		map_flags |= BIT(GUNYAH_ADDRSPACE_MAP_FLAG_VMMIO);
+	} else {
+		guest_extent = __first_resource(&ghvm->guest_private_extent_ticket);
+		host_extent = __first_resource(&ghvm->host_private_extent_ticket);
+		map_flags |= BIT(GUNYAH_ADDRSPACE_MAP_FLAG_PRIVATE);
+	}
+	/* clang-format on */
+
+	pa = PFN_PHYS(folio_pfn(folio));
+	size = folio_size(folio);
+
+	gunyah_error = gunyah_hypercall_addrspace_unmap(addrspace->capid,
+							guest_extent->capid,
+							gunyah_gfn_to_gpa(gfn),
+							map_flags, pa, size);
+	if (gunyah_error != GUNYAH_ERROR_OK) {
+		pr_err_ratelimited(
+			"Failed to unmap guest address 0x%016llx: %d\n",
+			gunyah_gfn_to_gpa(gfn), gunyah_error);
+		ret = gunyah_error_remap(gunyah_error);
+		goto err;
+	}
+
+	gunyah_error = gunyah_hypercall_memextent_donate(reclaim_flags(share),
+							 guest_extent->capid,
+							 host_extent->capid, pa,
+							 size);
+	if (gunyah_error != GUNYAH_ERROR_OK) {
+		pr_err_ratelimited(
+			"Failed to reclaim memory donation for guest address 0x%016llx: %d\n",
+			gunyah_gfn_to_gpa(gfn), gunyah_error);
+		ret = gunyah_error_remap(gunyah_error);
+		goto err;
+	}
+
+	if (share && write)
+		access = GUNYAH_PAGETABLE_ACCESS_RW;
+	else if (share && !write)
+		access = GUNYAH_PAGETABLE_ACCESS_R;
+	else if (!share && write)
+		access = GUNYAH_PAGETABLE_ACCESS_RWX;
+	else /* !share && !write */
+		access = GUNYAH_PAGETABLE_ACCESS_RX;
+
+	gunyah_error = gunyah_hypercall_memextent_donate(donate_flags(share),
+							 guest_extent->capid,
+							 host_extent->capid, pa,
+							 size);
+	if (gunyah_error != GUNYAH_ERROR_OK) {
+		pr_err("Failed to reclaim memory donation for guest address 0x%016llx: %d\n",
+		       gfn << PAGE_SHIFT, gunyah_error);
+		ret = gunyah_error_remap(gunyah_error);
+		goto err;
+	}
+
+	BUG_ON(mtree_erase(&ghvm->mm, gfn) != entry);
+
+	folio_clear_private(folio);
+	folio_put(folio);
+	return 0;
+err:
+	return ret;
+}
+
+int gunyah_vm_reclaim_folio(struct gunyah_vm *ghvm, u64 gfn)
+{
+	struct folio *folio;
+	void *entry;
+
+	entry = mtree_load(&ghvm->mm, gfn);
+	if (!entry)
+		return 0;
+
+	folio = xa_untag_pointer(entry);
+	if (mtree_load(&ghvm->mm, gfn) != entry)
+		return -EAGAIN;
+
+	return __gunyah_vm_reclaim_folio_locked(ghvm, entry, gfn, true);
+}
+
+int gunyah_vm_reclaim_range(struct gunyah_vm *ghvm, u64 gfn, u64 nr)
+{
+	unsigned long next = gfn, g;
+	struct folio *folio;
+	int ret, ret2 = 0;
+	void *entry;
+	bool sync;
+
+	mt_for_each(&ghvm->mm, entry, next, gfn + nr) {
+		folio = xa_untag_pointer(entry);
+		g = next;
+		sync = !!mt_find_after(&ghvm->mm, &g, gfn + nr);
+
+		g = next - folio_nr_pages(folio);
+		folio_get(folio);
+		folio_lock(folio);
+		if (mtree_load(&ghvm->mm, g) == entry)
+			ret = __gunyah_vm_reclaim_folio_locked(ghvm, entry, g, sync);
+		else
+			ret = -EAGAIN;
+		folio_unlock(folio);
+		folio_put(folio);
+		if (ret && ret2 != -EAGAIN)
+			ret2 = ret;
+	}
+
+	return ret2;
+}

-- 
2.34.1


