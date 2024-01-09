Return-Path: <linux-kernel+bounces-21338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B040E828DD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447CD2889CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F5C4439D;
	Tue,  9 Jan 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zo9chhnS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25425405C5;
	Tue,  9 Jan 2024 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409J7Wtr027734;
	Tue, 9 Jan 2024 19:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ot2Rc6FWYqawtwAbAQxff+CJFZOjsl6S/t9tlgViSq4
	=; b=Zo9chhnSm40/QbbTZ9T3vvSYbbmWNVbM7fMd5RB8IB6vR3+ZlIfKAGCoG6C
	0uHKIVHrZ11CGbnUyXPmlnzXP7CjmEXgwvg34yHZaAgHa/At3sBI5Uq04qz33RKD
	jL9t4elpnYHd6+aiMR/ceFosZpLnMv2HFCH4LTuy1KfN6Kn4JQJIfc9ti3RLZB9B
	PCA9PBZXnKj0htcVLnfGOG3pMvxR8rbD4Jn/jENhB6khhqwsPbwWAgJiUmxfABlG
	26zb18mXIeU/+xyYTSxbI68ZPe4/xLRRteAFR+eUWcslZtELzNUHiSSO049HSgjD
	5Ot61cw21zAB9X/D7KBEbOLMNjQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9vfgdrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:38:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jc0T0011951
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:38:00 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:37:59 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:37:55 -0800
Subject: [PATCH v16 17/34] gunyah: rsc_mgr: Add memory parcel RPC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-17-634904bf4ce9@quicinc.com>
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
X-Proofpoint-GUID: yuWyby_01twjbm-t5tFkMTfKW7_PGkc_
X-Proofpoint-ORIG-GUID: yuWyby_01twjbm-t5tFkMTfKW7_PGkc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

In a Gunyah hypervisor system using the Gunyah Resource Manager, the
"standard" unit of donating, lending and sharing memory is called a
memory parcel (memparcel).  A memparcel is an abstraction used by the
resource manager for securely managing donating, lending and sharing
memory, which may be physically and virtually fragmented, without
dealing directly with physical memory addresses.

Memparcels are created and managed through the RM RPC functions for
lending, sharing and reclaiming memory from VMs.

When creating a new VM the initial VM memory containing the VM image and
the VM's device tree blob must be provided as a memparcel. The memparcel
must be created using the RM RPC for lending and mapping the memory to
the VM.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/rsc_mgr.h     |   9 ++
 drivers/virt/gunyah/rsc_mgr_rpc.c | 231 ++++++++++++++++++++++++++++++++++++++
 include/linux/gunyah.h            |  43 +++++++
 3 files changed, 283 insertions(+)

diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 52711de77bb7..ec8ad8149e8e 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 
 #define GUNYAH_VMID_INVAL U16_MAX
+#define GUNYAH_MEM_HANDLE_INVAL U32_MAX
 
 struct gunyah_rm;
 
@@ -58,6 +59,12 @@ struct gunyah_rm_vm_status_payload {
 	__le16 app_status;
 } __packed;
 
+/* RPC Calls */
+int gunyah_rm_mem_share(struct gunyah_rm *rm,
+			struct gunyah_rm_mem_parcel *parcel);
+int gunyah_rm_mem_reclaim(struct gunyah_rm *rm,
+			  struct gunyah_rm_mem_parcel *parcel);
+
 int gunyah_rm_alloc_vmid(struct gunyah_rm *rm, u16 vmid);
 int gunyah_rm_dealloc_vmid(struct gunyah_rm *rm, u16 vmid);
 int gunyah_rm_vm_reset(struct gunyah_rm *rm, u16 vmid);
@@ -99,6 +106,8 @@ struct gunyah_rm_hyp_resources {
 int gunyah_rm_get_hyp_resources(struct gunyah_rm *rm, u16 vmid,
 				struct gunyah_rm_hyp_resources **resources);
 
+int gunyah_rm_get_vmid(struct gunyah_rm *rm, u16 *vmid);
+
 struct gunyah_resource *
 gunyah_rm_alloc_resource(struct gunyah_rm *rm,
 			 struct gunyah_rm_hyp_resource *hyp_resource);
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
index 141ce0145e91..bc44bde990ce 100644
--- a/drivers/virt/gunyah/rsc_mgr_rpc.c
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -5,6 +5,12 @@
 
 #include "rsc_mgr.h"
 
+/* Message IDs: Memory Management */
+#define GUNYAH_RM_RPC_MEM_LEND 0x51000012
+#define GUNYAH_RM_RPC_MEM_SHARE 0x51000013
+#define GUNYAH_RM_RPC_MEM_RECLAIM 0x51000015
+#define GUNYAH_RM_RPC_MEM_APPEND 0x51000018
+
 /* Message IDs: VM Management */
 /* clang-format off */
 #define GUNYAH_RM_RPC_VM_ALLOC_VMID		0x56000001
@@ -15,6 +21,7 @@
 #define GUNYAH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
 #define GUNYAH_RM_RPC_VM_INIT			0x5600000B
 #define GUNYAH_RM_RPC_VM_GET_HYP_RESOURCES	0x56000020
+#define GUNYAH_RM_RPC_VM_GET_VMID		0x56000024
 /* clang-format on */
 
 struct gunyah_rm_vm_common_vmid_req {
@@ -22,6 +29,48 @@ struct gunyah_rm_vm_common_vmid_req {
 	__le16 _padding;
 } __packed;
 
+/* Call: MEM_LEND, MEM_SHARE */
+#define GUNYAH_RM_MAX_MEM_ENTRIES 512
+
+#define GUNYAH_MEM_SHARE_REQ_FLAGS_APPEND BIT(1)
+
+struct gunyah_rm_mem_share_req_header {
+	u8 mem_type;
+	u8 _padding0;
+	u8 flags;
+	u8 _padding1;
+	__le32 label;
+} __packed;
+
+struct gunyah_rm_mem_share_req_acl_section {
+	__le32 n_entries;
+	struct gunyah_rm_mem_acl_entry entries[];
+} __packed;
+
+struct gunyah_rm_mem_share_req_mem_section {
+	__le16 n_entries;
+	__le16 _padding;
+	struct gunyah_rm_mem_entry entries[];
+} __packed;
+
+/* Call: MEM_RELEASE */
+struct gunyah_rm_mem_release_req {
+	__le32 mem_handle;
+	u8 flags; /* currently not used */
+	u8 _padding0;
+	__le16 _padding1;
+} __packed;
+
+/* Call: MEM_APPEND */
+#define GUNYAH_MEM_APPEND_REQ_FLAGS_END BIT(0)
+
+struct gunyah_rm_mem_append_req_header {
+	__le32 mem_handle;
+	u8 flags;
+	u8 _padding0;
+	__le16 _padding1;
+} __packed;
+
 /* Call: VM_ALLOC */
 struct gunyah_rm_vm_alloc_vmid_resp {
 	__le16 vmid;
@@ -66,6 +115,159 @@ static int gunyah_rm_common_vmid_call(struct gunyah_rm *rm, u32 message_id,
 			      NULL, NULL);
 }
 
+static int gunyah_rm_mem_append(struct gunyah_rm *rm, u32 mem_handle,
+				struct gunyah_rm_mem_entry *entries,
+				size_t n_entries)
+{
+	struct gunyah_rm_mem_append_req_header *req __free(kfree) = NULL;
+	struct gunyah_rm_mem_share_req_mem_section *mem;
+	int ret = 0;
+	size_t n;
+
+	req = kzalloc(sizeof(*req) + struct_size(mem, entries, GUNYAH_RM_MAX_MEM_ENTRIES),
+		      GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->mem_handle = cpu_to_le32(mem_handle);
+	mem = (void *)(req + 1);
+
+	while (n_entries) {
+		req->flags = 0;
+		if (n_entries > GUNYAH_RM_MAX_MEM_ENTRIES) {
+			n = GUNYAH_RM_MAX_MEM_ENTRIES;
+		} else {
+			req->flags |= GUNYAH_MEM_APPEND_REQ_FLAGS_END;
+			n = n_entries;
+		}
+
+		mem->n_entries = cpu_to_le16(n);
+		memcpy(mem->entries, entries, sizeof(*entries) * n);
+
+		ret = gunyah_rm_call(rm, GUNYAH_RM_RPC_MEM_APPEND, req,
+				     sizeof(*req) + struct_size(mem, entries, n),
+				     NULL, NULL);
+		if (ret)
+			break;
+
+		entries += n;
+		n_entries -= n;
+	}
+
+	return ret;
+}
+
+/**
+ * gunyah_rm_mem_share() - Share memory with other virtual machines.
+ * @rm: Handle to a Gunyah resource manager
+ * @p: Information about the memory to be shared.
+ *
+ * Sharing keeps Linux's access to the memory while the memory parcel is shared.
+ */
+int gunyah_rm_mem_share(struct gunyah_rm *rm, struct gunyah_rm_mem_parcel *p)
+{
+	u32 message_id = p->n_acl_entries == 1 ? GUNYAH_RM_RPC_MEM_LEND :
+						 GUNYAH_RM_RPC_MEM_SHARE;
+	size_t msg_size, initial_mem_entries = p->n_mem_entries, resp_size;
+	struct gunyah_rm_mem_share_req_acl_section *acl;
+	struct gunyah_rm_mem_share_req_mem_section *mem;
+	struct gunyah_rm_mem_share_req_header *req_header;
+	size_t acl_size, mem_size;
+	u32 *attr_section;
+	bool need_append = false;
+	__le32 *resp;
+	void *msg;
+	int ret;
+
+	if (!p->acl_entries || !p->n_acl_entries || !p->mem_entries ||
+	    !p->n_mem_entries || p->n_acl_entries > U8_MAX ||
+	    p->mem_handle != GUNYAH_MEM_HANDLE_INVAL)
+		return -EINVAL;
+
+	if (initial_mem_entries > GUNYAH_RM_MAX_MEM_ENTRIES) {
+		initial_mem_entries = GUNYAH_RM_MAX_MEM_ENTRIES;
+		need_append = true;
+	}
+
+	acl_size = struct_size(acl, entries, p->n_acl_entries);
+	mem_size = struct_size(mem, entries, initial_mem_entries);
+
+	/* The format of the message goes:
+	 * request header
+	 * ACL entries (which VMs get what kind of access to this memory parcel)
+	 * Memory entries (list of memory regions to share)
+	 * Memory attributes (currently unused, we'll hard-code the size to 0)
+	 */
+	msg_size = sizeof(struct gunyah_rm_mem_share_req_header) + acl_size +
+		   mem_size +
+		   sizeof(u32); /* for memory attributes, currently unused */
+
+	msg = kzalloc(msg_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	req_header = msg;
+	acl = (void *)req_header + sizeof(*req_header);
+	mem = (void *)acl + acl_size;
+	attr_section = (void *)mem + mem_size;
+
+	req_header->mem_type = p->mem_type;
+	if (need_append)
+		req_header->flags |= GUNYAH_MEM_SHARE_REQ_FLAGS_APPEND;
+	req_header->label = cpu_to_le32(p->label);
+
+	acl->n_entries = cpu_to_le32(p->n_acl_entries);
+	memcpy(acl->entries, p->acl_entries,
+	       flex_array_size(acl, entries, p->n_acl_entries));
+
+	mem->n_entries = cpu_to_le16(initial_mem_entries);
+	memcpy(mem->entries, p->mem_entries,
+	       flex_array_size(mem, entries, initial_mem_entries));
+
+	/* Set n_entries for memory attribute section to 0 */
+	*attr_section = 0;
+
+	ret = gunyah_rm_call(rm, message_id, msg, msg_size, (void **)&resp,
+			     &resp_size);
+	kfree(msg);
+
+	if (ret)
+		return ret;
+
+	p->mem_handle = le32_to_cpu(*resp);
+	kfree(resp);
+
+	if (need_append) {
+		ret = gunyah_rm_mem_append(
+			rm, p->mem_handle, &p->mem_entries[initial_mem_entries],
+			p->n_mem_entries - initial_mem_entries);
+		if (ret) {
+			gunyah_rm_mem_reclaim(rm, p);
+			p->mem_handle = GUNYAH_MEM_HANDLE_INVAL;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * gunyah_rm_mem_reclaim() - Reclaim a memory parcel
+ * @rm: Handle to a Gunyah resource manager
+ * @parcel: Information about the memory to be reclaimed.
+ *
+ * RM maps the associated memory back into the stage-2 page tables of the owner VM.
+ */
+int gunyah_rm_mem_reclaim(struct gunyah_rm *rm,
+			  struct gunyah_rm_mem_parcel *parcel)
+{
+	struct gunyah_rm_mem_release_req req = {
+		.mem_handle = cpu_to_le32(parcel->mem_handle),
+	};
+
+	return gunyah_rm_call(rm, GUNYAH_RM_RPC_MEM_RECLAIM, &req, sizeof(req),
+			      NULL, NULL);
+}
+
 /**
  * gunyah_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
  * @rm: Handle to a Gunyah resource manager
@@ -236,3 +438,32 @@ int gunyah_rm_get_hyp_resources(struct gunyah_rm *rm, u16 vmid,
 	*resources = resp;
 	return 0;
 }
+
+/**
+ * gunyah_rm_get_vmid() - Retrieve VMID of this virtual machine
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: Filled with the VMID of this VM
+ */
+int gunyah_rm_get_vmid(struct gunyah_rm *rm, u16 *vmid)
+{
+	static u16 cached_vmid = GUNYAH_VMID_INVAL;
+	size_t resp_size;
+	__le32 *resp;
+	int ret;
+
+	if (cached_vmid != GUNYAH_VMID_INVAL) {
+		*vmid = cached_vmid;
+		return 0;
+	}
+
+	ret = gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_GET_VMID, NULL, 0,
+			     (void **)&resp, &resp_size);
+	if (ret)
+		return ret;
+
+	*vmid = cached_vmid = lower_16_bits(le32_to_cpu(*resp));
+	kfree(resp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_get_vmid);
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index a517c5c33a75..9065f5758c39 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -156,6 +156,49 @@ int gunyah_vm_add_resource_ticket(struct gunyah_vm *ghvm,
 void gunyah_vm_remove_resource_ticket(struct gunyah_vm *ghvm,
 				      struct gunyah_vm_resource_ticket *ticket);
 
+#define GUNYAH_RM_ACL_X BIT(0)
+#define GUNYAH_RM_ACL_W BIT(1)
+#define GUNYAH_RM_ACL_R BIT(2)
+
+struct gunyah_rm_mem_acl_entry {
+	__le16 vmid;
+	u8 perms;
+	u8 reserved;
+} __packed;
+
+struct gunyah_rm_mem_entry {
+	__le64 phys_addr;
+	__le64 size;
+} __packed;
+
+enum gunyah_rm_mem_type {
+	GUNYAH_RM_MEM_TYPE_NORMAL = 0,
+	GUNYAH_RM_MEM_TYPE_IO = 1,
+};
+
+/*
+ * struct gunyah_rm_mem_parcel - Info about memory to be lent/shared/donated/reclaimed
+ * @mem_type: The type of memory: normal (DDR) or IO
+ * @label: An client-specified identifier which can be used by the other VMs to identify the purpose
+ *         of the memory parcel.
+ * @n_acl_entries: Count of the number of entries in the @acl_entries array.
+ * @acl_entries: An array of access control entries. Each entry specifies a VM and what access
+ *               is allowed for the memory parcel.
+ * @n_mem_entries: Count of the number of entries in the @mem_entries array.
+ * @mem_entries: An array of regions to be associated with the memory parcel. Addresses should be
+ *               (intermediate) physical addresses from Linux's perspective.
+ * @mem_handle: On success, filled with memory handle that RM allocates for this memory parcel
+ */
+struct gunyah_rm_mem_parcel {
+	enum gunyah_rm_mem_type mem_type;
+	u32 label;
+	size_t n_acl_entries;
+	struct gunyah_rm_mem_acl_entry *acl_entries;
+	size_t n_mem_entries;
+	struct gunyah_rm_mem_entry *mem_entries;
+	u32 mem_handle;
+};
+
 /******************************************************************************/
 /* Common arch-independent definitions for Gunyah hypercalls                  */
 #define GUNYAH_CAPID_INVAL U64_MAX

-- 
2.34.1


