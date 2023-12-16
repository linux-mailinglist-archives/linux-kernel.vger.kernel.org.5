Return-Path: <linux-kernel+bounces-1885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8506B815540
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36031C223B1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5A1E4B8;
	Sat, 16 Dec 2023 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mtI81Ov4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035B15487;
	Sat, 16 Dec 2023 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG06JiB031931;
	Sat, 16 Dec 2023 00:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=yd0ujJbXUCG0HEeQ97AI8hL5w0yeYQxF/m/DtIuMX4M
	=; b=mtI81Ov4K3HHtLbLSInBPxOaJdd9TQ6mR2ynK7Ojm/xS2ykode/WULKKRS0
	rXJxcieeI49epCtHUjL5i1uOjH4DyDJJu7HzMIbn2n1r12xqn3c6blOw6R2Xt7Sd
	1H9GFI9V1fAKTQxp4j038S9sXDdwHBfDAAfihYdmTFhaTDSUwnNldUCqyW7aYTb7
	0xOi63M/zWJmcj8t+i26ix6McGSPj8qnG3c80mpavCJesrsdji5TBCfHtWXuNxQk
	X0LDLWoKLG/LCSCwZItZEFCyc8iDz/kBS1FtN9Je4qgvDJbYirGtoKuScWA08mw0
	sClIjHCF0oKt/VV6v3bLQ/DX6Iw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hqcjf8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LFEk006377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:15 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:14 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:21:04 -0800
Subject: [PATCH RFC v15 23/30] virt: gunyah: Allow userspace to initialize
 context of primary vCPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-23-192a5d872a30@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 13KfA0gwHXNKQRz-5J2CMUNFxhXrVfsf
X-Proofpoint-GUID: 13KfA0gwHXNKQRz-5J2CMUNFxhXrVfsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=822 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160001

RM provides APIs to fill boot context the initial registers upon
starting the vCPU.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h |  1 +
 include/uapi/linux/gunyah.h  | 23 ++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 5666070453aa..a31a9f0a642c 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -542,6 +542,66 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
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
@@ -582,6 +642,13 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
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
@@ -683,6 +750,14 @@ static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
 
 		return gunyah_gmem_modify_binding(ghvm, &args);
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
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 1cad729b017a..a7fc7c376d1e 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -60,6 +60,7 @@ struct gunyah_vm {
 	struct list_head resource_tickets;
 	struct rb_root mmio_handler_root;
 	struct rw_semaphore mmio_handler_lock;
+	struct xarray boot_context;
 };
 
 int gunyah_vm_mmio_write(struct gunyah_vm *ghvm, u64 addr, u32 len, u64 data);
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 1af4c5ae6bc3..a171185191ae 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -128,6 +128,29 @@ struct gunyah_map_mem_args {
 
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
2.43.0


