Return-Path: <linux-kernel+bounces-1878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF9D815526
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D0E1C2474D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB314001;
	Sat, 16 Dec 2023 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kat3yxwR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D78478;
	Sat, 16 Dec 2023 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFNwAFE004538;
	Sat, 16 Dec 2023 00:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=097Lg5UbfQcA28si9W7NPg/edYUMo3HojM0j6uxPB9A
	=; b=kat3yxwRpOQkMdG39Jm4DuN9YrLwkX4DiquBeSy72/Wq4si6Y51jJiqdQx2
	UKlboxYt5MGfPMiCiDXFL4qHCSAYpx8IoXojH4HVkjHzD+Wo8tWFLppF4mmY8YoZ
	FQ7f2auyfN6eZc+x62f6zy+Jo7TR+WXr+qBPcmpZdQ/1EUVL1Du7FBgzMHhD0qTL
	ciTwei/CNNkaTza1FvtsfuGMDulb/eylDp16CyzQde6MKikc/YdoeZXPDYtOPzD2
	7YTIY/U719/E9HmG3VdW3zwE1PF9dK123Gpud/pfDchtWXSWXHuq3mj0C75fZrvZ
	xuG31OgvAXxPDI5wz6kXdMqXoqQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hb1te8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0L5vG015533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:05 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:04 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:20:49 -0800
Subject: [PATCH RFC v15 08/30] gunyah: rsc_mgr: Add VM lifecycle RPC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-8-192a5d872a30@quicinc.com>
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
X-Proofpoint-GUID: bFBq5_zDxgzvm16wmXcgmF-2zqnatjci
X-Proofpoint-ORIG-GUID: bFBq5_zDxgzvm16wmXcgmF-2zqnatjci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312160000

Add Gunyah Resource Manager RPC to launch an unauthenticated VM.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile      |   2 +-
 drivers/virt/gunyah/rsc_mgr_rpc.c | 570 ++++++++++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    | 144 ++++++++++
 3 files changed, 715 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index c2308389f551..b1bdf3e84155 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gunyah_rsc_mgr-y += rsc_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
new file mode 100644
index 000000000000..9954512dbdde
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/gunyah_rsc_mgr.h>
+#include "rsc_mgr.h"
+
+/* Message IDs: Memory Management */
+#define GUNYAH_RM_RPC_MEM_LEND 0x51000012
+#define GUNYAH_RM_RPC_MEM_SHARE 0x51000013
+#define GUNYAH_RM_RPC_MEM_RECLAIM 0x51000015
+#define GUNYAH_RM_RPC_MEM_APPEND 0x51000018
+
+/* Message IDs: VM Management */
+/* clang-format off */
+#define GUNYAH_RM_RPC_VM_ALLOC_VMID		0x56000001
+#define GUNYAH_RM_RPC_VM_DEALLOC_VMID		0x56000002
+#define GUNYAH_RM_RPC_VM_START			0x56000004
+#define GUNYAH_RM_RPC_VM_STOP			0x56000005
+#define GUNYAH_RM_RPC_VM_RESET			0x56000006
+#define GUNYAH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
+#define GUNYAH_RM_RPC_VM_INIT			0x5600000B
+#define GUNYAH_RM_RPC_VM_SET_BOOT_CONTEXT	0x5600000C
+#define GUNYAH_RM_RPC_VM_GET_HYP_RESOURCES	0x56000020
+#define GUNYAH_RM_RPC_VM_GET_VMID		0x56000024
+#define GUNYAH_RM_RPC_VM_SET_DEMAND_PAGING	0x56000033
+#define GUNYAH_RM_RPC_VM_SET_ADDRESS_LAYOUT	0x56000034
+/* clang-format on */
+
+/* Message IDs: Miscellaneous */
+/* clang-format off */
+#define GUNYAH_RM_RPC_GET_LOG_ADDRESS		0x56000100
+/* clang-format on */
+
+struct gunyah_rm_vm_common_vmid_req {
+	__le16 vmid;
+	__le16 _padding;
+} __packed;
+
+/* Call: MEM_LEND, MEM_SHARE */
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
+/* Call: VM_ALLOC */
+struct gunyah_rm_vm_alloc_vmid_resp {
+	__le16 vmid;
+	__le16 _padding;
+} __packed;
+
+/* Call: VM_STOP */
+#define GUNYAH_RM_VM_STOP_FLAG_FORCE_STOP BIT(0)
+
+#define GUNYAH_RM_VM_STOP_REASON_FORCE_STOP 3
+
+struct gunyah_rm_vm_stop_req {
+	__le16 vmid;
+	u8 flags;
+	u8 _padding;
+	__le32 stop_reason;
+} __packed;
+
+/* Call: VM_CONFIG_IMAGE */
+struct gunyah_rm_vm_config_image_req {
+	__le16 vmid;
+	__le16 auth_mech;
+	__le32 mem_handle;
+	__le64 image_offset;
+	__le64 image_size;
+	__le64 dtb_offset;
+	__le64 dtb_size;
+} __packed;
+
+#define GUNYAH_RM_MAX_MEM_ENTRIES 512
+
+/* Call: VM_SET_BOOT_CONTEXT */
+struct gunyah_rm_vm_set_boot_context_req {
+	__le16 vmid;
+	u8 reg_set;
+	u8 reg_index;
+	__le32 _padding;
+	__le64 value;
+} __packed;
+
+/* Call: VM_SET_DEMAND_PAGING */
+struct gunyah_rm_vm_set_demand_paging_req {
+	__le16 vmid;
+	__le16 _padding;
+	__le32 range_count;
+	DECLARE_FLEX_ARRAY(struct gunyah_rm_mem_entry, ranges);
+} __packed;
+
+/* Call: VM_SET_ADDRESS_LAYOUT */
+struct gunyah_rm_vm_set_address_layout_req {
+	__le16 vmid;
+	__le16 _padding;
+	__le32 range_id;
+	__le64 range_base;
+	__le64 range_size;
+} __packed;
+
+/*
+ * Several RM calls take only a VMID as a parameter and give only standard
+ * response back. Deduplicate boilerplate code by using this common call.
+ */
+static int gunyah_rm_common_vmid_call(struct gunyah_rm *rm, u32 message_id,
+				      u16 vmid)
+{
+	struct gunyah_rm_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+
+	return gunyah_rm_call(rm, message_id, &req_payload, sizeof(req_payload),
+			      NULL, NULL);
+}
+
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
+/**
+ * gunyah_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: Use 0 to dynamically allocate a VM. A reserved VMID can be supplied
+ *        to request allocation of a platform-defined VM.
+ *
+ * Return: the allocated VMID or negative value on error
+ */
+int gunyah_rm_alloc_vmid(struct gunyah_rm *rm, u16 vmid)
+{
+	struct gunyah_rm_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+	struct gunyah_rm_vm_alloc_vmid_resp *resp_payload;
+	size_t resp_size;
+	void *resp;
+	int ret;
+
+	ret = gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_ALLOC_VMID, &req_payload,
+			     sizeof(req_payload), &resp, &resp_size);
+	if (ret)
+		return ret;
+
+	if (!vmid) {
+		resp_payload = resp;
+		ret = le16_to_cpu(resp_payload->vmid);
+		kfree(resp);
+	}
+
+	return ret;
+}
+
+/**
+ * gunyah_rm_dealloc_vmid() - Dispose of a VMID
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gunyah_rm_alloc_vmid
+ */
+int gunyah_rm_dealloc_vmid(struct gunyah_rm *rm, u16 vmid)
+{
+	return gunyah_rm_common_vmid_call(rm, GUNYAH_RM_RPC_VM_DEALLOC_VMID,
+					  vmid);
+}
+
+/**
+ * gunyah_rm_vm_reset() - Reset a VM's resources
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gunyah_rm_alloc_vmid
+ *
+ * As part of tearing down the VM, request RM to clean up all the VM resources
+ * associated with the VM. Only after this, Linux can clean up all the
+ * references it maintains to resources.
+ */
+int gunyah_rm_vm_reset(struct gunyah_rm *rm, u16 vmid)
+{
+	return gunyah_rm_common_vmid_call(rm, GUNYAH_RM_RPC_VM_RESET, vmid);
+}
+
+/**
+ * gunyah_rm_vm_start() - Move a VM into "ready to run" state
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gunyah_rm_alloc_vmid
+ *
+ * On VMs which use proxy scheduling, vcpu_run is needed to actually run the VM.
+ * On VMs which use Gunyah's scheduling, the vCPUs start executing in accordance with Gunyah
+ * scheduling policies.
+ */
+int gunyah_rm_vm_start(struct gunyah_rm *rm, u16 vmid)
+{
+	return gunyah_rm_common_vmid_call(rm, GUNYAH_RM_RPC_VM_START, vmid);
+}
+
+/**
+ * gunyah_rm_vm_stop() - Send a request to Resource Manager VM to forcibly stop a VM.
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gunyah_rm_alloc_vmid
+ */
+int gunyah_rm_vm_stop(struct gunyah_rm *rm, u16 vmid)
+{
+	struct gunyah_rm_vm_stop_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+		.flags = GUNYAH_RM_VM_STOP_FLAG_FORCE_STOP,
+		.stop_reason = cpu_to_le32(GUNYAH_RM_VM_STOP_REASON_FORCE_STOP),
+	};
+
+	return gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_STOP, &req_payload,
+			      sizeof(req_payload), NULL, NULL);
+}
+
+/**
+ * gunyah_rm_vm_configure() - Prepare a VM to start and provide the common
+ *			  configuration needed by RM to configure a VM
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gunyah_rm_alloc_vmid
+ * @auth_mechanism: Authentication mechanism used by resource manager to verify
+ *                  the virtual machine
+ * @mem_handle: Handle to a previously shared memparcel that contains all parts
+ *              of the VM image subject to authentication.
+ * @image_offset: Start address of VM image, relative to the start of memparcel
+ * @image_size: Size of the VM image
+ * @dtb_offset: Start address of the devicetree binary with VM configuration,
+ *              relative to start of memparcel.
+ * @dtb_size: Maximum size of devicetree binary.
+ */
+int gunyah_rm_vm_configure(struct gunyah_rm *rm, u16 vmid,
+			   enum gunyah_rm_vm_auth_mechanism auth_mechanism,
+			   u32 mem_handle, u64 image_offset, u64 image_size,
+			   u64 dtb_offset, u64 dtb_size)
+{
+	struct gunyah_rm_vm_config_image_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+		.auth_mech = cpu_to_le16(auth_mechanism),
+		.mem_handle = cpu_to_le32(mem_handle),
+		.image_offset = cpu_to_le64(image_offset),
+		.image_size = cpu_to_le64(image_size),
+		.dtb_offset = cpu_to_le64(dtb_offset),
+		.dtb_size = cpu_to_le64(dtb_size),
+	};
+
+	return gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_CONFIG_IMAGE, &req_payload,
+			      sizeof(req_payload), NULL, NULL);
+}
+
+/**
+ * gunyah_rm_vm_init() - Move the VM to initialized state.
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier
+ *
+ * RM will allocate needed resources for the VM.
+ */
+int gunyah_rm_vm_init(struct gunyah_rm *rm, u16 vmid)
+{
+	return gunyah_rm_common_vmid_call(rm, GUNYAH_RM_RPC_VM_INIT, vmid);
+}
+
+int gunyah_rm_vm_set_boot_context(struct gunyah_rm *rm, u16 vmid, u8 reg_set,
+				  u8 reg_index, u64 value)
+{
+	struct gunyah_rm_vm_set_boot_context_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+		.reg_set = reg_set,
+		.reg_index = reg_index,
+		.value = cpu_to_le64(value),
+	};
+
+	return gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_SET_BOOT_CONTEXT,
+			      &req_payload, sizeof(req_payload), NULL, NULL);
+}
+
+/**
+ * gunyah_rm_get_hyp_resources() - Retrieve hypervisor resources (capabilities) associated with a VM
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VMID of the other VM to get the resources of
+ * @resources: Set by gunyah_rm_get_hyp_resources and contains the returned hypervisor resources.
+ *             Caller must free the resources pointer if successful.
+ */
+int gunyah_rm_get_hyp_resources(struct gunyah_rm *rm, u16 vmid,
+				struct gunyah_rm_hyp_resources **resources)
+{
+	struct gunyah_rm_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+	struct gunyah_rm_hyp_resources *resp;
+	size_t resp_size;
+	int ret;
+
+	ret = gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_GET_HYP_RESOURCES,
+			     &req_payload, sizeof(req_payload), (void **)&resp,
+			     &resp_size);
+	if (ret)
+		return ret;
+
+	if (!resp_size)
+		return -EBADMSG;
+
+	if (resp_size < struct_size(resp, entries, 0) ||
+	    resp_size !=
+		    struct_size(resp, entries, le32_to_cpu(resp->n_entries))) {
+		kfree(resp);
+		return -EBADMSG;
+	}
+
+	*resources = resp;
+	return 0;
+}
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
+
+/**
+ * gunyah_rm_vm_set_demand_paging() - Enable demand paging of memory regions
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VMID of the other VM
+ * @count: Number of demand paged memory regions
+ * @entries: Array of the regions
+ */
+int gunyah_rm_vm_set_demand_paging(struct gunyah_rm *rm, u16 vmid, u32 count,
+				   struct gunyah_rm_mem_entry *entries)
+{
+	struct gunyah_rm_vm_set_demand_paging_req *req __free(kfree) = NULL;
+	size_t req_size;
+
+	req_size = struct_size(req, ranges, count);
+	if (req_size == SIZE_MAX)
+		return -EINVAL;
+
+	req = kzalloc(req_size, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->vmid = cpu_to_le16(vmid);
+	req->range_count = cpu_to_le32(count);
+	memcpy(req->ranges, entries, sizeof(*entries) * count);
+
+	return gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_SET_DEMAND_PAGING, req,
+			      req_size, NULL, NULL);
+}
+
+/**
+ * gunyah_rm_vm_set_address_layout() - Set the start address of images
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VMID of the other VM
+ * @range_id: Which image to set
+ * @base_address: Base address
+ * @size: Size
+ */
+int gunyah_rm_vm_set_address_layout(struct gunyah_rm *rm, u16 vmid,
+				    enum gunyah_rm_range_id range_id,
+				    u64 base_address, u64 size)
+{
+	struct gunyah_rm_vm_set_address_layout_req req = {
+		.vmid = cpu_to_le16(vmid),
+		.range_id = cpu_to_le32(range_id),
+		.range_base = cpu_to_le64(base_address),
+		.range_size = cpu_to_le64(size),
+	};
+
+	return gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_SET_ADDRESS_LAYOUT, &req,
+			      sizeof(req), NULL, NULL);
+}
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index e151f66be96e..7bd2bee91f3e 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -10,6 +10,7 @@
 #include <linux/gunyah.h>
 
 #define GUNYAH_VMID_INVAL U16_MAX
+#define GUNYAH_MEM_HANDLE_INVAL U32_MAX
 
 struct gunyah_rm;
 int gunyah_rm_notifier_register(struct gunyah_rm *rm,
@@ -19,4 +20,147 @@ int gunyah_rm_notifier_unregister(struct gunyah_rm *rm,
 struct device *gunyah_rm_get(struct gunyah_rm *rm);
 void gunyah_rm_put(struct gunyah_rm *rm);
 
+struct gunyah_rm_vm_exited_payload {
+	__le16 vmid;
+	__le16 exit_type;
+	__le32 exit_reason_size;
+	u8 exit_reason[];
+} __packed;
+
+enum gunyah_rm_notification_id {
+	/* clang-format off */
+	GUNYAH_RM_NOTIFICATION_VM_EXITED		 = 0x56100001,
+	GUNYAH_RM_NOTIFICATION_VM_STATUS		 = 0x56100008,
+	/* clang-format on */
+};
+
+enum gunyah_rm_vm_status {
+	/* clang-format off */
+	GUNYAH_RM_VM_STATUS_NO_STATE		= 0,
+	GUNYAH_RM_VM_STATUS_INIT		= 1,
+	GUNYAH_RM_VM_STATUS_READY		= 2,
+	GUNYAH_RM_VM_STATUS_RUNNING		= 3,
+	GUNYAH_RM_VM_STATUS_PAUSED		= 4,
+	GUNYAH_RM_VM_STATUS_LOAD		= 5,
+	GUNYAH_RM_VM_STATUS_AUTH		= 6,
+	GUNYAH_RM_VM_STATUS_INIT_FAILED		= 8,
+	GUNYAH_RM_VM_STATUS_EXITED		= 9,
+	GUNYAH_RM_VM_STATUS_RESETTING		= 10,
+	GUNYAH_RM_VM_STATUS_RESET		= 11,
+	/* clang-format on */
+};
+
+struct gunyah_rm_vm_status_payload {
+	__le16 vmid;
+	u16 reserved;
+	u8 vm_status;
+	u8 os_status;
+	__le16 app_status;
+} __packed;
+
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
+/* RPC Calls */
+int gunyah_rm_mem_share(struct gunyah_rm *rm,
+			struct gunyah_rm_mem_parcel *parcel);
+int gunyah_rm_mem_reclaim(struct gunyah_rm *rm,
+			  struct gunyah_rm_mem_parcel *parcel);
+
+int gunyah_rm_alloc_vmid(struct gunyah_rm *rm, u16 vmid);
+int gunyah_rm_dealloc_vmid(struct gunyah_rm *rm, u16 vmid);
+int gunyah_rm_vm_reset(struct gunyah_rm *rm, u16 vmid);
+int gunyah_rm_vm_start(struct gunyah_rm *rm, u16 vmid);
+int gunyah_rm_vm_stop(struct gunyah_rm *rm, u16 vmid);
+
+enum gunyah_rm_vm_auth_mechanism {
+	/* clang-format off */
+	GUNYAH_RM_VM_AUTH_NONE			= 0,
+	GUNYAH_RM_VM_AUTH_QCOM_PIL_ELF		= 1,
+	GUNYAH_RM_VM_AUTH_QCOM_ANDROID_PVM	= 2,
+	/* clang-format on */
+};
+
+int gunyah_rm_vm_configure(struct gunyah_rm *rm, u16 vmid,
+			   enum gunyah_rm_vm_auth_mechanism auth_mechanism,
+			   u32 mem_handle, u64 image_offset, u64 image_size,
+			   u64 dtb_offset, u64 dtb_size);
+int gunyah_rm_vm_init(struct gunyah_rm *rm, u16 vmid);
+int gunyah_rm_vm_set_boot_context(struct gunyah_rm *rm, u16 vmid, u8 reg_set,
+				  u8 reg_index, u64 value);
+
+struct gunyah_rm_hyp_resource {
+	u8 type;
+	u8 reserved;
+	__le16 partner_vmid;
+	__le32 resource_handle;
+	__le32 resource_label;
+	__le64 cap_id;
+	__le32 virq_handle;
+	__le32 virq;
+	__le64 base;
+	__le64 size;
+} __packed;
+
+struct gunyah_rm_hyp_resources {
+	__le32 n_entries;
+	struct gunyah_rm_hyp_resource entries[];
+} __packed;
+
+int gunyah_rm_get_hyp_resources(struct gunyah_rm *rm, u16 vmid,
+				struct gunyah_rm_hyp_resources **resources);
+int gunyah_rm_get_vmid(struct gunyah_rm *rm, u16 *vmid);
+
+int gunyah_rm_vm_set_demand_paging(struct gunyah_rm *rm, u16 vmid, u32 count,
+				   struct gunyah_rm_mem_entry *mem_entries);
+
+enum gunyah_rm_range_id {
+	GUNYAH_RM_RANGE_ID_IMAGE = 0,
+	GUNYAH_RM_RANGE_ID_FIRMWARE = 1,
+};
+
+int gunyah_rm_vm_set_address_layout(struct gunyah_rm *rm, u16 vmid,
+				    enum gunyah_rm_range_id range_id,
+				    u64 base_address, u64 size);
+
 #endif

-- 
2.43.0


