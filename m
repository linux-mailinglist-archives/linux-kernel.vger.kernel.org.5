Return-Path: <linux-kernel+bounces-21341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A45828DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FBC2882FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9FF47776;
	Tue,  9 Jan 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oy/+qHMk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064A4123A;
	Tue,  9 Jan 2024 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409IcWLY010749;
	Tue, 9 Jan 2024 19:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=6QetUZhknvq/zrDatLYqM2ZHXQHjhsAEkBKq0hM3hhM
	=; b=Oy/+qHMkiIlkN+857CH/9m5TyyxOqNi7PSPz8svGUFuyIX17FCNwIxrf8Ao
	VmEj1gLQbUia9Gko1NUNsT5rxQMqy3n9+p1VZw4AauKmnGz8U0kIMhe6dGC4lxCR
	J/iBFT7yqHbOtBRgipY0SUgEoGB4h2WAQCuFTmoUUtVOh/BonodWhBmnngqmgPev
	oZDGLoJbFCfY4dBzVuBnIpDIBzuAiduMVjG56nqDDLHwuAjSEu3CXQbpj6nh27l4
	j8m35lLI+WDoP7UOxA58ulLdT3PywtOaWWkcb+D3bFk6KTAxgE0JwhYRkHoRhMln
	2IweesuUjwOuwz99fMjzn1/jdlA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9ta0dxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:38:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jc5JL012019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:38:05 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:38:04 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:38:03 -0800
Subject: [PATCH v16 25/34] gunyah: rsc_mgr: Add RPC to enable demand paging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-25-634904bf4ce9@quicinc.com>
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
X-Proofpoint-GUID: qHVZfw7yNHI_rsHZNWwtCx4ZyRxoAyya
X-Proofpoint-ORIG-GUID: qHVZfw7yNHI_rsHZNWwtCx4ZyRxoAyya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=770
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Add Gunyah Resource Manager RPC to enable demand paging for a virtual
machine. Resource manager needs to be informed of private memory regions
which will be demand paged and the location where the DTB memory parcel
should live in the guest's address space.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/rsc_mgr.h     | 12 +++++++
 drivers/virt/gunyah/rsc_mgr_rpc.c | 71 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 68d08d3cff02..99c2db18579c 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -108,6 +108,18 @@ int gunyah_rm_get_hyp_resources(struct gunyah_rm *rm, u16 vmid,
 
 int gunyah_rm_get_vmid(struct gunyah_rm *rm, u16 *vmid);
 
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
 struct gunyah_resource *
 gunyah_rm_alloc_resource(struct gunyah_rm *rm,
 			 struct gunyah_rm_hyp_resource *hyp_resource);
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
index 0d78613827b5..f4e396fd0d47 100644
--- a/drivers/virt/gunyah/rsc_mgr_rpc.c
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -22,6 +22,8 @@
 #define GUNYAH_RM_RPC_VM_INIT			0x5600000B
 #define GUNYAH_RM_RPC_VM_GET_HYP_RESOURCES	0x56000020
 #define GUNYAH_RM_RPC_VM_GET_VMID		0x56000024
+#define GUNYAH_RM_RPC_VM_SET_DEMAND_PAGING	0x56000033
+#define GUNYAH_RM_RPC_VM_SET_ADDRESS_LAYOUT	0x56000034
 /* clang-format on */
 
 struct gunyah_rm_vm_common_vmid_req {
@@ -100,6 +102,23 @@ struct gunyah_rm_vm_config_image_req {
 	__le64 dtb_size;
 } __packed;
 
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
 /*
  * Several RM calls take only a VMID as a parameter and give only standard
  * response back. Deduplicate boilerplate code by using this common call.
@@ -481,3 +500,55 @@ int gunyah_rm_get_vmid(struct gunyah_rm *rm, u16 *vmid)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(gunyah_rm_get_vmid);
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

-- 
2.34.1


