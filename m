Return-Path: <linux-kernel+bounces-1891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1BB815559
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59591F25932
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6803529B;
	Sat, 16 Dec 2023 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i7dTOIUG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2731A82;
	Sat, 16 Dec 2023 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFNqBDV031214;
	Sat, 16 Dec 2023 00:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=+fJqyZjDlK1gDGsRn0b0lLQzU8UiFh6dKZ7oqf9fYOE
	=; b=i7dTOIUGSEwrzjFglnIkm0nT1HhBTHwg3Ihy7QlVsEavs9kiO1xvF3rIRPm
	PNMb/IO0/EegW4GAY+893FG7FqiWo5lAwbkw/bq/eA6D8ttioL8tz7kYM3EZTu7f
	2P+UESHAkj8+SsAtV6UTWtf2fVBAFYNrjbhIRZdoAcZ2drlbB0y3yqBhtacH00sb
	OpCn4j2GHSKN3LETeEfMWUqzJMIUrReZMk1Ly4cNh0j2+Q02IeCigDIFZlLxcojF
	Xx8mxbOBTowT27nnTq2eyZnkOsRwyyTQMFvDjd6yrNF/xq6eRmv/sTEGCnNlCF1t
	YNIx0F2EK5gQQSbiEoo7HG1aXXA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0p101kj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LF0k004978
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:15 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:14 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:21:05 -0800
Subject: [PATCH RFC v15 24/30] virt: gunyah: Share guest VM dtb
 configuration to Gunyah
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-24-192a5d872a30@quicinc.com>
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
X-Proofpoint-GUID: mWFg4ml3dCyYjzeM2T6lRlK1dpgLLWe4
X-Proofpoint-ORIG-GUID: mWFg4ml3dCyYjzeM2T6lRlK1dpgLLWe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160000

Gunyah Resource Manager sets up a virtual machine based on a device tree
which lives in guest memory. Resource manager requires this memory to be
provided as a memory parcel for it to read and manipulate. Construct a
memory parcel, lend it to the virtual machine, and inform resource
manager about the device tree location (the memory parcel ID and offset
into the memory parcel).

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c | 46 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/virt/gunyah/vm_mgr.h |  6 ++++++
 include/uapi/linux/gunyah.h  | 14 ++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index a31a9f0a642c..8f8d962c9f8c 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -627,8 +627,27 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
 	ghvm->vmid = ret;
 	ghvm->vm_status = GUNYAH_RM_VM_STATUS_LOAD;
 
-	ret = gunyah_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, 0, 0, 0,
-				     0, 0);
+	ghvm->dtb.parcel_start = ghvm->dtb.config.guest_phys_addr >> PAGE_SHIFT;
+	ghvm->dtb.parcel_pages = ghvm->dtb.config.size >> PAGE_SHIFT;
+	/* RM requires the DTB parcel to be lent to guard against malicious
+	 * modifications while starting VM. Force it so.
+	 */
+	ghvm->dtb.parcel.n_acl_entries = 1;
+	ret = gunyah_gmem_share_parcel(ghvm, &ghvm->dtb.parcel,
+				       &ghvm->dtb.parcel_start,
+				       &ghvm->dtb.parcel_pages);
+	if (ret) {
+		dev_warn(ghvm->parent,
+			 "Failed to allocate parcel for DTB: %d\n", ret);
+		goto err;
+	}
+
+	ret = gunyah_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth,
+				     ghvm->dtb.parcel.mem_handle, 0, 0,
+				     ghvm->dtb.config.guest_phys_addr -
+					     (ghvm->dtb.parcel_start
+					      << PAGE_SHIFT),
+				     ghvm->dtb.config.size);
 	if (ret) {
 		dev_warn(ghvm->parent, "Failed to configure VM: %d\n", ret);
 		goto err;
@@ -720,6 +739,21 @@ static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
 	long r;
 
 	switch (cmd) {
+	case GUNYAH_VM_SET_DTB_CONFIG: {
+		struct gunyah_vm_dtb_config dtb_config;
+
+		if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
+			return -EFAULT;
+
+		if (overflows_type(dtb_config.guest_phys_addr + dtb_config.size,
+				   u64))
+			return -EOVERFLOW;
+
+		ghvm->dtb.config = dtb_config;
+
+		r = 0;
+		break;
+	}
 	case GUNYAH_VM_START: {
 		r = gunyah_vm_ensure_started(ghvm);
 		break;
@@ -783,6 +817,14 @@ static void _gunyah_vm_put(struct kref *kref)
 		gunyah_vm_stop(ghvm);
 
 	gunyah_vm_remove_functions(ghvm);
+	if (ghvm->vm_status == GUNYAH_RM_VM_STATUS_LOAD) {
+		ret = gunyah_gmem_reclaim_parcel(ghvm, &ghvm->dtb.parcel,
+						 ghvm->dtb.parcel_start,
+						 ghvm->dtb.parcel_pages);
+		if (ret)
+			dev_err(ghvm->parent,
+				"Failed to reclaim DTB parcel: %d\n", ret);
+	}
 
 	mt_for_each(&ghvm->mem_layout, b, idx, ULONG_MAX)
 		gunyah_gmem_remove_binding(b);
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index a7fc7c376d1e..357414e67d72 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -60,6 +60,12 @@ struct gunyah_vm {
 	struct list_head resource_tickets;
 	struct rb_root mmio_handler_root;
 	struct rw_semaphore mmio_handler_lock;
+
+	struct {
+		struct gunyah_vm_dtb_config config;
+		u64 parcel_start, parcel_pages;
+		struct gunyah_rm_mem_parcel parcel;
+	} dtb;
 	struct xarray boot_context;
 };
 
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index a171185191ae..574116f54472 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -42,6 +42,20 @@ struct gunyah_create_mem_args {
 /*
  * ioctls for gunyah-vm fds (returned by GUNYAH_CREATE_VM)
  */
+
+/**
+ * struct gunyah_vm_dtb_config - Set the location of the VM's devicetree blob
+ * @guest_phys_addr: Address of the VM's devicetree in guest memory.
+ * @size: Maximum size of the devicetree including space for overlays.
+ *        Resource manager applies an overlay to the DTB and dtb_size should
+ *        include room for the overlay. A page of memory is typicaly plenty.
+ */
+struct gunyah_vm_dtb_config {
+	__u64 guest_phys_addr;
+	__u64 size;
+};
+#define GUNYAH_VM_SET_DTB_CONFIG	_IOW(GUNYAH_IOCTL_TYPE, 0x2, struct gunyah_vm_dtb_config)
+
 #define GUNYAH_VM_START		_IO(GUNYAH_IOCTL_TYPE, 0x3)
 
 /**

-- 
2.43.0


