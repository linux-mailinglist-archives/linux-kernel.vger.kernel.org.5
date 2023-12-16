Return-Path: <linux-kernel+bounces-1886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21E81554B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6882C1F255A5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53932FC5F;
	Sat, 16 Dec 2023 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JIX6uOkw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34215AEA;
	Sat, 16 Dec 2023 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFNZFfT004744;
	Sat, 16 Dec 2023 00:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=EK6PaN/SzqxP6V9oHPvTpZJBwg0U4uYIaeICLpAcX5Q
	=; b=JIX6uOkw0icXxtq+gDvzmAtLtWCvoqgBfR0pjmwyiyGDwnlr7SQRfJFPA3n
	DbkKw0wX5MYPB8jL86V/rwtOQzjWRMgckKSGoXhpPD58REOsz9mLKN9rv2wcMbzO
	W4rGrd3WoMULYGdDtMSf6HOUKr3xQUedVEyTJORmQ56nkB346PMtQT1aMu1WSwQ9
	4zSBFXra4zGqTepUFW8G8ZIUeUAT9NM1bTRmG8r30jePdwhcjzW77Zz+MCzTX48e
	nHbQWU+AYvQ4WlAIuwlZJJDv9wRkDaviblFvApncVrsdu7YWCU68kLbcSvpDp16M
	zpYXiOGA4cFq2uktLEyqSP0ZiJQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0vv9ghj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LAe2006343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:10 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:09 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:20:57 -0800
Subject: [PATCH RFC v15 16/30] virt: gunyah: Add interfaces to map memory
 into guest address space
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-16-192a5d872a30@quicinc.com>
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
X-Proofpoint-GUID: Y3nWYmRkIouILFFabqncMGF_nPqhrNzi
X-Proofpoint-ORIG-GUID: Y3nWYmRkIouILFFabqncMGF_nPqhrNzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312160001

Gunyah virtual machines are created with all memory provided upon VM
creation using Resource Manager's memory parcel construct or by enabling
demand paging. Demand paging allows the host to map/unmap contiguous
pages (folios) on its own, typically done when a guest vCPU faults on
those pages. In order to map folios to a guest virtual machine, the
host needs to add the folio to a memory extent that can be mapped into
the guest virtual machine's address space and then map the folio into
the guest address space. Memory extents are Gunyah's mechanism for
access control and provide capability-based modifications to what memory
virtual machines are allowed to access.

When a virtual machine is configured for demand paging, 3 memory
extent and 1 address space capabilities are provided to the host. The
memory extents give the host ability to move memory between "host-only",
"guest-only", and "host-and-guest-shared" extents. The guest address
space can only map memory which is in the "guest-only" or
"host-and-guest-shared" extents. Similarly, the host address space can
only have mapped memory which is in the "host-only" or
"host-and-guest-shared" extents.

Implement two functions which Linux can use to move memory between the
virtual machines: gunyah_provide_folio and gunyah_reclaim_folio. Memory
that has been provided to the guest is tracked in a maple tree to be
reclaimed later. Folios provided to the virtual machine are assumed to
be owned Gunyah stack: the folio's ->private field is used for
bookkeeping about whether page is mapped into virtual machine.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile     |   2 +-
 drivers/virt/gunyah/vm_mgr.c     |  60 ++++++++
 drivers/virt/gunyah/vm_mgr.h     |  30 ++++
 drivers/virt/gunyah/vm_mgr_mem.c | 314 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 405 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 47f1fae5419b..ccce90438434 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mem.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 8feb9302d7d2..a5450dc8cc28 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -18,6 +18,15 @@
 
 #include "vm_mgr.h"
 
+#define GUNYAH_VM_ADDRSPACE_LABEL 0
+// For memory private to guest
+#define GUNYAH_VM_MEM_EXTENT_GUEST_PRIVATE_LABEL 0
+#define GUNYAH_VM_MEM_EXTENT_HOST_SHARED_LABEL 1
+// For memory shared with the guest
+#define GUNYAH_VM_MEM_EXTENT_GUEST_SHARED_LABEL 3
+// Our own mem extent
+#define GUNYAH_VM_MEM_EXTENT_HOST_PRIVATE_LABEL 2
+
 static DEFINE_XARRAY(gunyah_vm_functions);
 
 static void gunyah_vm_put_function(struct gunyah_vm_function *fn)
@@ -185,6 +194,16 @@ void gunyah_vm_function_unregister(struct gunyah_vm_function *fn)
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
@@ -459,6 +478,17 @@ static void gunyah_vm_stop(struct gunyah_vm *ghvm)
 		   ghvm->vm_status == GUNYAH_RM_VM_STATUS_EXITED);
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
@@ -483,6 +513,25 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 	INIT_LIST_HEAD(&ghvm->functions);
 	mutex_init(&ghvm->fn_lock);
 
+	mt_init(&ghvm->gm);
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
 
@@ -642,6 +691,15 @@ static void _gunyah_vm_put(struct kref *kref)
 		gunyah_vm_stop(ghvm);
 
 	gunyah_vm_remove_functions(ghvm);
+
+	gunyah_vm_reclaim_memory(ghvm);
+
+	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->addrspace_ticket);
+	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->host_shared_extent_ticket);
+	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->host_private_extent_ticket);
+	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->guest_shared_extent_ticket);
+	gunyah_vm_remove_resource_ticket(ghvm, &ghvm->guest_private_extent_ticket);
+
 	gunyah_vm_clean_resources(ghvm);
 
 	if (ghvm->vm_status != GUNYAH_RM_VM_STATUS_NO_STATE &&
@@ -655,6 +713,8 @@ static void _gunyah_vm_put(struct kref *kref)
 			   ghvm->vm_status == GUNYAH_RM_VM_STATUS_RESET);
 	}
 
+	mtree_destroy(&ghvm->gm);
+
 	if (ghvm->vm_status > GUNYAH_RM_VM_STATUS_NO_STATE) {
 		gunyah_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
 
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index a26bf81e94fc..d2f6ac212169 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -8,8 +8,10 @@
 
 #include <linux/device.h>
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/gunyah_vm_mgr.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/maple_tree.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/rbtree.h>
@@ -18,11 +20,26 @@
 
 #include <uapi/linux/gunyah.h>
 
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
 
 struct gunyah_vm {
 	u16 vmid;
+	struct maple_tree gm;
+	struct gunyah_vm_resource_ticket addrspace_ticket,
+		host_private_extent_ticket, host_shared_extent_ticket,
+		guest_private_extent_ticket, guest_shared_extent_ticket;
+
 	struct gunyah_rm *rm;
 	struct device *parent;
 	enum gunyah_rm_vm_auth_mechanism auth;
@@ -44,4 +61,17 @@ struct gunyah_vm {
 
 int gunyah_vm_mmio_write(struct gunyah_vm *ghvm, u64 addr, u32 len, u64 data);
 
+int gunyah_vm_share_parcel(struct gunyah_vm *ghvm,
+			   struct gunyah_rm_mem_parcel *parcel, u64 gfn,
+			   u64 nr);
+int gunyah_vm_parcel_to_paged(struct gunyah_vm *ghvm,
+			      struct gunyah_rm_mem_parcel *parcel, u64 gfn,
+			      u64 nr);
+int gunyah_vm_reclaim_parcel(struct gunyah_vm *ghvm,
+			     struct gunyah_rm_mem_parcel *parcel, u64 gfn);
+int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
+			    u64 gfn, bool share, bool write);
+int gunyah_vm_reclaim_folio(struct gunyah_vm *ghvm, u64 gfn);
+void gunyah_vm_reclaim_memory(struct gunyah_vm *ghvm);
+
 #endif
diff --git a/drivers/virt/gunyah/vm_mgr_mem.c b/drivers/virt/gunyah/vm_mgr_mem.c
new file mode 100644
index 000000000000..d61fceeeac60
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr_mem.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
+#define MEM_PARCEL_TAG (1 << 2)
+
+static inline struct gunyah_resource *
+__first_resource(struct gunyah_vm_resource_ticket *ticket)
+{
+	return list_first_entry_or_null(&ticket->resources,
+					struct gunyah_resource, list);
+}
+
+int gunyah_vm_share_parcel(struct gunyah_vm *ghvm,
+			   struct gunyah_rm_mem_parcel *parcel, u64 gfn, u64 nr)
+{
+	int ret;
+
+	ret = mtree_insert_range(&ghvm->gm, gfn, gfn + nr - 1,
+				 xa_tag_pointer(parcel, MEM_PARCEL_TAG),
+				 GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	ret = gunyah_rm_mem_share(ghvm->rm, parcel);
+	if (ret)
+		mtree_erase(&ghvm->gm, gfn);
+
+	return ret;
+}
+
+int gunyah_vm_parcel_to_paged(struct gunyah_vm *ghvm,
+			      struct gunyah_rm_mem_parcel *parcel, u64 gfn,
+			      u64 nr)
+{
+	struct gunyah_rm_mem_entry *entry;
+	struct folio *folio;
+	unsigned long g, e, tag = 0;
+	pgoff_t off;
+	int ret;
+
+	if (parcel->n_acl_entries > 1)
+		tag |= SHARE_TAG;
+	if (parcel->acl_entries[0].perms & GUNYAH_RM_ACL_W)
+		tag |= WRITE_TAG;
+
+	for (e = 0, g = gfn; g < gfn + nr && e < parcel->n_mem_entries; e++) {
+		entry = &parcel->mem_entries[e];
+		folio = pfn_folio(PHYS_PFN(entry->phys_addr));
+
+		for (off = 0; off < PHYS_PFN(entry->size);
+		     off += folio_nr_pages(folio)) {
+			ret = mtree_store_range(&ghvm->gm, g + off, g + off - 1,
+						xa_tag_pointer(folio, tag),
+						GFP_KERNEL);
+			if (ret == -ENOMEM)
+				return ret;
+			BUG_ON(ret);
+
+			folio = folio_next(folio);
+		}
+	}
+
+	return 0;
+}
+
+int gunyah_vm_reclaim_parcel(struct gunyah_vm *ghvm,
+			     struct gunyah_rm_mem_parcel *parcel, u64 gfn)
+{
+	int ret;
+
+	ret = gunyah_rm_mem_reclaim(ghvm->rm, parcel);
+	if (ret)
+		return ret;
+
+	mtree_erase(&ghvm->gm, gfn);
+
+	return ret;
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
+	if (share) {
+		guest_extent = __first_resource(&ghvm->guest_shared_extent_ticket);
+		host_extent = __first_resource(&ghvm->host_shared_extent_ticket);
+	} else {
+		guest_extent = __first_resource(&ghvm->guest_private_extent_ticket);
+		host_extent = __first_resource(&ghvm->host_private_extent_ticket);
+	}
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
+	ret = mtree_insert_range(&ghvm->gm, gfn,
+				 gfn + folio_nr_pages(folio) - 1,
+				 xa_tag_pointer(folio, tag), GFP_KERNEL);
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
+	mtree_erase(&ghvm->gm, gfn);
+	return ret;
+}
+
+int gunyah_vm_reclaim_folio(struct gunyah_vm *ghvm, u64 gfn)
+{
+	const u32 map_flags = BIT(GUNYAH_ADDRSPACE_MAP_FLAG_PARTIAL);
+	struct gunyah_resource *guest_extent, *host_extent, *addrspace;
+	enum gunyah_pagetable_access access;
+	enum gunyah_error gunyah_error;
+	struct folio *folio;
+	bool write, share;
+	phys_addr_t pa;
+	size_t size;
+	void *entry;
+	int ret;
+
+	addrspace = __first_resource(&ghvm->addrspace_ticket);
+	if (!addrspace)
+		return -ENODEV;
+
+	entry = mtree_load(&ghvm->gm, gfn);
+	if (!entry)
+		return 0;
+
+	share = !!(xa_pointer_tag(entry) & SHARE_TAG);
+	write = !!(xa_pointer_tag(entry) & WRITE_TAG);
+	folio = xa_untag_pointer(entry);
+	folio_lock(folio);
+	if (mtree_load(&ghvm->gm, gfn) != entry) {
+		ret = -EAGAIN;
+		goto err;
+	}
+
+	if (share) {
+		guest_extent = __first_resource(&ghvm->guest_shared_extent_ticket);
+		host_extent = __first_resource(&ghvm->host_shared_extent_ticket);
+	} else {
+		guest_extent = __first_resource(&ghvm->guest_private_extent_ticket);
+		host_extent = __first_resource(&ghvm->host_private_extent_ticket);
+	}
+
+	pa = PFN_PHYS(folio_pfn(folio));
+	size = folio_size(folio);
+
+	gunyah_error = gunyah_hypercall_addrspace_unmap(addrspace->capid,
+							guest_extent->capid,
+							gfn << PAGE_SHIFT,
+							map_flags, pa, size);
+	if (gunyah_error != GUNYAH_ERROR_OK) {
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
+	BUG_ON(mtree_erase(&ghvm->gm, gfn) != entry);
+
+	folio_unlock(folio);
+	folio_put(folio);
+	return 0;
+err:
+	folio_unlock(folio);
+	return ret;
+}
+
+void gunyah_vm_reclaim_memory(struct gunyah_vm *ghvm)
+{
+	unsigned long gfn = 0;
+	void *entry;
+	int ret = 0;
+
+	mt_for_each(&ghvm->gm, entry, gfn, ULONG_MAX) {
+		if (xa_pointer_tag(entry) == MEM_PARCEL_TAG) {
+			ret = gunyah_vm_reclaim_parcel(
+				ghvm, xa_untag_pointer(entry), gfn);
+			if (ret)
+				dev_err(ghvm->parent,
+					"Failed to reclaim guest parcel at %lx: %d\n",
+					gfn << PAGE_SHIFT, ret);
+		} else {
+			gunyah_vm_reclaim_folio(ghvm, gfn);
+		}
+	}
+}

-- 
2.43.0


