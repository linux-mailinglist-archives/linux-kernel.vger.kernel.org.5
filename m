Return-Path: <linux-kernel+bounces-21333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B9F828DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D901F277E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CDA3FE40;
	Tue,  9 Jan 2024 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KlGrxGc5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316F3EA74;
	Tue,  9 Jan 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409EjSYZ004292;
	Tue, 9 Jan 2024 19:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=jdOcH+5uREAma+X+LuNjKDUhpy77XJ6kXrkSC1c7CX8
	=; b=KlGrxGc5OBrYUf9bDGI4fqF+5xX3L9z+7BdCf3wizObiiGWcQ51rnfQr6Sp
	0PRmrqZX1RhiDjht6PYl5TT/p3M6JVBAaMg9gsL/uQym5AuS3KWh9JO6q13aHVH3
	JOw0AuhV12GqaiezNXvotX0cCR3HLW5GHcl4QnvU7u83QjgOyiVMQSgak8xOMn6G
	9q0PBaNGpoNzQsY84RM6Vo6BZ0Ox6Hnbr4yZjnp1UQnuhomekFk6vv5f2ygpCKwk
	p1Rfhs1OJ0wviwLX+eyThMHMtDftjjYntBOfO1f9T9iUCTHWeT3H+zWMNqDk4M/s
	SpeT4Gvhn/YpDt5HGHfITcvRfCQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgxxbhtdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:37:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409JbtFk024536
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:37:55 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:37:54 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:37:47 -0800
Subject: [PATCH v16 09/34] gunyah: rsc_mgr: Add VM lifecycle RPC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-9-634904bf4ce9@quicinc.com>
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
X-Proofpoint-ORIG-GUID: l8dGEkiNtnOwwtVWaPmjPcS74FvkOAye
X-Proofpoint-GUID: l8dGEkiNtnOwwtVWaPmjPcS74FvkOAye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Add Gunyah Resource Manager RPC interfaces to launch an unauthenticated
virtual machine.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile      |   2 +-
 drivers/virt/gunyah/rsc_mgr.h     |  78 +++++++++++++
 drivers/virt/gunyah/rsc_mgr_rpc.c | 238 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 317 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index ceccbbe68b38..47f1fae5419b 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gunyah_rsc_mgr-y += rsc_mgr.o vm_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 21318ef25040..205b9ea735e5 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -20,6 +20,84 @@ int gunyah_rm_notifier_unregister(struct gunyah_rm *rm,
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
 
 int gunyah_rm_call(struct gunyah_rm *rsc_mgr, u32 message_id,
 		   const void *req_buf, size_t req_buf_size, void **resp_buf,
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
new file mode 100644
index 000000000000..141ce0145e91
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "rsc_mgr.h"
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
+#define GUNYAH_RM_RPC_VM_GET_HYP_RESOURCES	0x56000020
+/* clang-format on */
+
+struct gunyah_rm_vm_common_vmid_req {
+	__le16 vmid;
+	__le16 _padding;
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

-- 
2.34.1


