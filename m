Return-Path: <linux-kernel+bounces-21344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E11D828DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4051F1C24AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C547F57;
	Tue,  9 Jan 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JsCn3DAO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40381446D0;
	Tue,  9 Jan 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409Gxr33016339;
	Tue, 9 Jan 2024 19:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=+Qmhckol3LBZQwJot12EAf5bVy2Rf/uHyT+4To7C3J0
	=; b=JsCn3DAOL5dGuQbg9AbPFtybTs8AbU3IU2fM3psZaVJd0bp4eXfrdU2bh5F
	lxw5tC2mrLFKnWXpebotu98uqHEyO28xAVT9DcwzD1HByxVeCsTcn158gnjTsqPI
	fO/kAuTTIY0qLBYlspE2V740EKQb8L9O4Z+Ln1iP35goGy0SAPdXxBc3a+Zgkndi
	8Nd1mk0nUBzI0bpD4aZ2OFndYd5KgxMeV0Q/orT+c35hx31z/eYBDxi3Sp0kejxy
	lWsY9Xcr5DXWB39cvJg+5T91iDLwf9SSTcV1SWGNUrdb9Si5PYM2xfgRt+GOeoLW
	32vY+VLeVYgS3dzO5Z0vR5rmJNA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh85t0pnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:38:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jc5Co030549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:38:05 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:38:04 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:38:02 -0800
Subject: [PATCH v16 24/34] virt: gunyah: Share guest VM dtb configuration
 to Gunyah
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-24-634904bf4ce9@quicinc.com>
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
X-Proofpoint-ORIG-GUID: vUg_t-T6NwaXapDllJE2l2cgFSriSpBt
X-Proofpoint-GUID: vUg_t-T6NwaXapDllJE2l2cgFSriSpBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Gunyah Resource Manager sets up a virtual machine based on a device tree
which lives in guest memory. Resource manager requires this memory to be
provided as a memory parcel for it to read and manipulate. Construct a
memory parcel, lend it to the virtual machine, and inform resource
manager about the device tree location (the memory parcel ID and offset
into the memory parcel).

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c | 49 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/virt/gunyah/vm_mgr.h | 13 +++++++++++-
 include/uapi/linux/gunyah.h  | 14 +++++++++++++
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index be2061aa0a06..4379b5ba151e 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -445,8 +445,27 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
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
@@ -485,6 +504,8 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
 		goto err;
 	}
 
+	WARN_ON(gunyah_vm_parcel_to_paged(ghvm, &ghvm->dtb.parcel, ghvm->dtb.parcel_start, ghvm->dtb.parcel_pages));
+
 	ghvm->vm_status = GUNYAH_RM_VM_STATUS_RUNNING;
 	up_write(&ghvm->status_lock);
 	return ret;
@@ -531,6 +552,21 @@ static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
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
@@ -589,6 +625,15 @@ static void _gunyah_vm_put(struct kref *kref)
 	if (ghvm->vm_status == GUNYAH_RM_VM_STATUS_RUNNING)
 		gunyah_vm_stop(ghvm);
 
+	if (ghvm->vm_status == GUNYAH_RM_VM_STATUS_LOAD) {
+		ret = gunyah_gmem_reclaim_parcel(ghvm, &ghvm->dtb.parcel,
+						 ghvm->dtb.parcel_start,
+						 ghvm->dtb.parcel_pages);
+		if (ret)
+			dev_err(ghvm->parent,
+				"Failed to reclaim DTB parcel: %d\n", ret);
+	}
+
 	gunyah_vm_remove_functions(ghvm);
 
 	down_write(&ghvm->bindings_lock);
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index a79c11f1c3a5..b2ab2f1bda3a 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -72,6 +72,13 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
  * @resource_tickets: List of &struct gunyah_vm_resource_ticket
  * @auth: Authentication mechanism to be used by resource manager when
  *        launching the VM
+ * @dtb: For tracking dtb configuration when launching the VM
+ * @dtb.config: Location of the DTB in the guest memory
+ * @dtb.parcel_start: Guest frame number where the memory parcel that we lent to
+ *                    VM (DTB could start in middle of folio; we lend entire
+ *                    folio; parcel_start is start of the folio)
+ * @dtb.parcel_pages: Number of pages lent for the memory parcel
+ * @dtb.parcel: Data for resource manager to lend the parcel
  *
  * Members are grouped by hot path.
  */
@@ -101,7 +108,11 @@ struct gunyah_vm {
 
 	struct device *parent;
 	enum gunyah_rm_vm_auth_mechanism auth;
-
+	struct {
+		struct gunyah_vm_dtb_config config;
+		u64 parcel_start, parcel_pages;
+		struct gunyah_rm_mem_parcel parcel;
+	} dtb;
 };
 
 int gunyah_vm_parcel_to_paged(struct gunyah_vm *ghvm,
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 1af4c5ae6bc3..a89d9bedf3e5 100644
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
2.34.1


