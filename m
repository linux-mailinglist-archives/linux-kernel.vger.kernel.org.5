Return-Path: <linux-kernel+bounces-21354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE29828E17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A871F20FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632E24A98A;
	Tue,  9 Jan 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nSo95nxl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E5481D3;
	Tue,  9 Jan 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409GcqSe032231;
	Tue, 9 Jan 2024 19:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=R9oS16D14s/n6UKLdxi8B+QIGsh3AN4EVEIgfOWN57I
	=; b=nSo95nxloAHcDQp3UMRYG+9ys11AoQKKhL68yJYaywuAYLuP+o701wulvxE
	5jOvyWxF1RGW0y/s4KXMTQaW0eOng9wMZR8v6zujGGy0XBaneVKoIhdizu2rpytR
	LqxdMw2BcXUqumcnvXR8QWy6tuw6891MbMrLmny4wLyjDan+vbodY7iAfd1ccKpx
	bwnoPLxwRaPaNasLlZ4Wp9ByQ/AXlXKbNMiX0kPyMfo8MxPqvLRpxd8Ke3M90rQ2
	aDj6oOPVh6RZhtWM21keb68fDjH/W+2JpJDa059W4LKRlrQ6buIACkJQQKrRg0m5
	dy783prZo25BQzaVDsnLQ16VZdQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9u9gdd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:38:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jc86C012062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:38:08 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:38:07 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:38:07 -0800
Subject: [PATCH v16 29/34] virt: gunyah: Allow userspace to initialize
 context of primary vCPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-29-634904bf4ce9@quicinc.com>
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
X-Proofpoint-GUID: r2Jg0yOIgZRWvcYW8LkdYcE94GP5WljK
X-Proofpoint-ORIG-GUID: r2Jg0yOIgZRWvcYW8LkdYcE94GP5WljK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

RM provides APIs to fill boot context the initial registers upon
starting the vCPU. Most importantly, this allows userspace to set the
initial PC for the primary vCPU when the VM starts to run.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h |  2 ++
 include/uapi/linux/gunyah.h  | 23 +++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 3b767eeeb7c2..1f3d29749174 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -395,6 +395,7 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 	mutex_init(&ghvm->resources_lock);
 	INIT_LIST_HEAD(&ghvm->resources);
 	INIT_LIST_HEAD(&ghvm->resource_tickets);
+	xa_init(&ghvm->boot_context);
 
 	mt_init(&ghvm->mm);
 	mt_init(&ghvm->bindings);
@@ -420,6 +421,66 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 	return ghvm;
 }
 
+static long gunyah_vm_set_boot_context(struct gunyah_vm *ghvm,
+				       struct gunyah_vm_boot_context *boot_ctx)
+{
+	u8 reg_set, reg_index; /* to check values are reasonable */
+	int ret;
+
+	reg_set = (boot_ctx->reg >> GUNYAH_VM_BOOT_CONTEXT_REG_SHIFT) & 0xff;
+	reg_index = boot_ctx->reg & 0xff;
+
+	switch (reg_set) {
+	case REG_SET_X:
+		if (reg_index > 31)
+			return -EINVAL;
+		break;
+	case REG_SET_PC:
+		if (reg_index)
+			return -EINVAL;
+		break;
+	case REG_SET_SP:
+		if (reg_index > 2)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = down_read_interruptible(&ghvm->status_lock);
+	if (ret)
+		return ret;
+
+	if (ghvm->vm_status != GUNYAH_RM_VM_STATUS_NO_STATE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = xa_err(xa_store(&ghvm->boot_context, boot_ctx->reg,
+			      (void *)boot_ctx->value, GFP_KERNEL));
+out:
+	up_read(&ghvm->status_lock);
+	return ret;
+}
+
+static inline int gunyah_vm_fill_boot_context(struct gunyah_vm *ghvm)
+{
+	unsigned long reg_set, reg_index, id;
+	void *entry;
+	int ret;
+
+	xa_for_each(&ghvm->boot_context, id, entry) {
+		reg_set = (id >> GUNYAH_VM_BOOT_CONTEXT_REG_SHIFT) & 0xff;
+		reg_index = id & 0xff;
+		ret = gunyah_rm_vm_set_boot_context(
+			ghvm->rm, ghvm->vmid, reg_set, reg_index, (u64)entry);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int gunyah_vm_start(struct gunyah_vm *ghvm)
 {
 	struct gunyah_rm_hyp_resources *resources;
@@ -496,6 +557,13 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
 	}
 	ghvm->vm_status = GUNYAH_RM_VM_STATUS_READY;
 
+	ret = gunyah_vm_fill_boot_context(ghvm);
+	if (ret) {
+		dev_warn(ghvm->parent, "Failed to setup boot context: %d\n",
+			 ret);
+		goto err;
+	}
+
 	ret = gunyah_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
 	if (ret) {
 		dev_warn(ghvm->parent,
@@ -614,6 +682,14 @@ static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
 
 		return gunyah_gmem_modify_mapping(ghvm, &args);
 	}
+	case GUNYAH_VM_SET_BOOT_CONTEXT: {
+		struct gunyah_vm_boot_context boot_ctx;
+
+		if (copy_from_user(&boot_ctx, argp, sizeof(boot_ctx)))
+			return -EFAULT;
+
+		return gunyah_vm_set_boot_context(ghvm, &boot_ctx);
+	}
 	default:
 		r = -ENOTTY;
 		break;
@@ -699,6 +775,7 @@ static void _gunyah_vm_put(struct kref *kref)
 				 "Failed to deallocate vmid: %d\n", ret);
 	}
 
+	xa_destroy(&ghvm->boot_context);
 	gunyah_rm_put(ghvm->rm);
 	kfree(ghvm);
 }
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 474ac866d237..4a436c3e435c 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -79,6 +79,7 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
  *                    folio; parcel_start is start of the folio)
  * @dtb.parcel_pages: Number of pages lent for the memory parcel
  * @dtb.parcel: Data for resource manager to lend the parcel
+ * @boot_context: Requested initial boot context to set when launching the VM
  *
  * Members are grouped by hot path.
  */
@@ -113,6 +114,7 @@ struct gunyah_vm {
 		u64 parcel_start, parcel_pages;
 		struct gunyah_rm_mem_parcel parcel;
 	} dtb;
+	struct xarray boot_context;
 };
 
 int gunyah_vm_parcel_to_paged(struct gunyah_vm *ghvm,
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index a89d9bedf3e5..574116f54472 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -142,6 +142,29 @@ struct gunyah_map_mem_args {
 
 #define GUNYAH_VM_MAP_MEM _IOW(GUNYAH_IOCTL_TYPE, 0x9, struct gunyah_map_mem_args)
 
+enum gunyah_vm_boot_context_reg {
+	REG_SET_X		= 0,
+	REG_SET_PC		= 1,
+	REG_SET_SP		= 2,
+};
+
+#define GUNYAH_VM_BOOT_CONTEXT_REG_SHIFT	8
+#define GUNYAH_VM_BOOT_CONTEXT_REG(reg, idx) (((reg & 0xff) << GUNYAH_VM_BOOT_CONTEXT_REG_SHIFT) |\
+					      (idx & 0xff))
+
+/**
+ * struct gunyah_vm_boot_context - Set an initial register for the VM
+ * @reg: Register to set. See GUNYAH_VM_BOOT_CONTEXT_REG_* macros
+ * @reserved: reserved for alignment
+ * @value: value to fill in the register
+ */
+struct gunyah_vm_boot_context {
+	__u32 reg;
+	__u32 reserved;
+	__u64 value;
+};
+#define GUNYAH_VM_SET_BOOT_CONTEXT	_IOW(GUNYAH_IOCTL_TYPE, 0xa, struct gunyah_vm_boot_context)
+
 /*
  * ioctls for vCPU fds
  */

-- 
2.34.1


