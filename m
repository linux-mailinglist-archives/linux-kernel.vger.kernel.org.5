Return-Path: <linux-kernel+bounces-1890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD2815555
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B17B286FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD1E3526D;
	Sat, 16 Dec 2023 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HpNtul72"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECAA1640C;
	Sat, 16 Dec 2023 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFN9ZZq010769;
	Sat, 16 Dec 2023 00:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ldkP+25ZzPVXxFYj2IhNVzk916Iu9dwPkeRF9ayDBAI
	=; b=HpNtul72bvWsP7vvVu0/5cuFPfvf3kzkflvsboqVMh9aymQL51ovyfqxiTH
	QGxEjXU7bCloB53CuAy3mB2W/zOS6LgIZDJolvxSu8Hq1Olkao/SIVr3DuJm2oZt
	I1gej66JEpZmzoIPo61uMx0YoYMrRNnrvnl9hVaWUj99FSeCcOpOzLcuWiAu264J
	lL0/FxqUnnq/xZk1tpAo969idmDvlLwGicnQ1kTsdweTvxLyALRfKU/dI867cEYa
	o8avt7UgpyKT517QidWTqoT36UJSr3Gcb5haWs9/AR9QZkQlv7iF9UI9QAicGtff
	WwO2veM56miIzada2vIs0y0lFmw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0m46hwe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LBIX006348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:11 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:10 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:20:58 -0800
Subject: [PATCH RFC v15 17/30] gunyah: rsc_mgr: Add platform ops on
 mem_lend/mem_reclaim
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-17-192a5d872a30@quicinc.com>
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
X-Proofpoint-GUID: Txm6gMjIyx9QJMHNU61otRjXuRRVDzZ7
X-Proofpoint-ORIG-GUID: Txm6gMjIyx9QJMHNU61otRjXuRRVDzZ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160001

On Qualcomm platforms, there is a firmware entity which controls access
to physical pages. In order to share memory with another VM, this entity
needs to be informed that the guest VM should have access to the memory.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Kconfig                 |   4 +
 drivers/virt/gunyah/Makefile                |   1 +
 drivers/virt/gunyah/gunyah_platform_hooks.c | 115 ++++++++++++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h               |  10 +++
 drivers/virt/gunyah/rsc_mgr_rpc.c           |  20 ++++-
 drivers/virt/gunyah/vm_mgr_mem.c            |  32 +++++---
 include/linux/gunyah_rsc_mgr.h              |  37 +++++++++
 7 files changed, 206 insertions(+), 13 deletions(-)

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 6f4c85db80b5..23ba523d25dc 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -3,6 +3,7 @@
 config GUNYAH
 	tristate "Gunyah Virtualization drivers"
 	depends on ARM64
+	select GUNYAH_PLATFORM_HOOKS
 	help
 	  The Gunyah drivers are the helper interfaces that run in a guest VM
 	  such as basic inter-VM IPC and signaling mechanisms, and higher level
@@ -10,3 +11,6 @@ config GUNYAH
 
 	  Say Y/M here to enable the drivers needed to interact in a Gunyah
 	  virtual environment.
+
+config GUNYAH_PLATFORM_HOOKS
+	tristate
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index ccce90438434..09e0fbca33fe 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -3,3 +3,4 @@
 gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mem.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o
+obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
diff --git a/drivers/virt/gunyah/gunyah_platform_hooks.c b/drivers/virt/gunyah/gunyah_platform_hooks.c
new file mode 100644
index 000000000000..d2d6df21b784
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_platform_hooks.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/rwsem.h>
+#include <linux/gunyah_rsc_mgr.h>
+
+#include "rsc_mgr.h"
+
+static const struct gunyah_rm_platform_ops *rm_platform_ops;
+static DECLARE_RWSEM(rm_platform_ops_lock);
+
+int gunyah_rm_platform_pre_mem_share(struct gunyah_rm *rm,
+				     struct gunyah_rm_mem_parcel *mem_parcel)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->pre_mem_share)
+		ret = rm_platform_ops->pre_mem_share(rm, mem_parcel);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_platform_pre_mem_share);
+
+int gunyah_rm_platform_post_mem_reclaim(struct gunyah_rm *rm,
+					struct gunyah_rm_mem_parcel *mem_parcel)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->post_mem_reclaim)
+		ret = rm_platform_ops->post_mem_reclaim(rm, mem_parcel);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_platform_post_mem_reclaim);
+
+int gunyah_rm_platform_pre_demand_page(struct gunyah_rm *rm, u16 vmid,
+				       u32 flags, struct folio *folio)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->pre_demand_page)
+		ret = rm_platform_ops->pre_demand_page(rm, vmid, flags, folio);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_platform_pre_demand_page);
+
+int gunyah_rm_platform_reclaim_demand_page(struct gunyah_rm *rm, u16 vmid,
+					   u32 flags, struct folio *folio)
+{
+	int ret = 0;
+
+	down_read(&rm_platform_ops_lock);
+	if (rm_platform_ops && rm_platform_ops->pre_demand_page)
+		ret = rm_platform_ops->release_demand_page(rm, vmid, flags,
+							   folio);
+	up_read(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_platform_reclaim_demand_page);
+
+int gunyah_rm_register_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops)
+{
+	int ret = 0;
+
+	down_write(&rm_platform_ops_lock);
+	if (!rm_platform_ops)
+		rm_platform_ops = platform_ops;
+	else
+		ret = -EEXIST;
+	up_write(&rm_platform_ops_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_register_platform_ops);
+
+void gunyah_rm_unregister_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops)
+{
+	down_write(&rm_platform_ops_lock);
+	if (rm_platform_ops == platform_ops)
+		rm_platform_ops = NULL;
+	up_write(&rm_platform_ops_lock);
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_unregister_platform_ops);
+
+static void _devm_gunyah_rm_unregister_platform_ops(void *data)
+{
+	gunyah_rm_unregister_platform_ops(
+		(const struct gunyah_rm_platform_ops *)data);
+}
+
+int devm_gunyah_rm_register_platform_ops(
+	struct device *dev, const struct gunyah_rm_platform_ops *ops)
+{
+	int ret;
+
+	ret = gunyah_rm_register_platform_ops(ops);
+	if (ret)
+		return ret;
+
+	return devm_add_action(dev, _devm_gunyah_rm_unregister_platform_ops,
+			       (void *)ops);
+}
+EXPORT_SYMBOL_GPL(devm_gunyah_rm_register_platform_ops);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Platform Hooks");
diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 4ce6ec3668d4..65ffcb63754a 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -15,4 +15,14 @@ int gunyah_rm_call(struct gunyah_rm *rsc_mgr, u32 message_id,
 		   const void *req_buf, size_t req_buf_size, void **resp_buf,
 		   size_t *resp_buf_size);
 
+int gunyah_rm_platform_pre_mem_share(struct gunyah_rm *rm,
+				     struct gunyah_rm_mem_parcel *mem_parcel);
+int gunyah_rm_platform_post_mem_reclaim(
+	struct gunyah_rm *rm, struct gunyah_rm_mem_parcel *mem_parcel);
+
+int gunyah_rm_platform_pre_demand_page(struct gunyah_rm *rm, u16 vmid,
+				       u32 flags, struct folio *folio);
+int gunyah_rm_platform_reclaim_demand_page(struct gunyah_rm *rm, u16 vmid,
+					   u32 flags, struct folio *folio);
+
 #endif
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
index 9954512dbdde..ce68933f9968 100644
--- a/drivers/virt/gunyah/rsc_mgr_rpc.c
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -241,6 +241,12 @@ int gunyah_rm_mem_share(struct gunyah_rm *rm, struct gunyah_rm_mem_parcel *p)
 	if (!msg)
 		return -ENOMEM;
 
+	ret = gunyah_rm_platform_pre_mem_share(rm, p);
+	if (ret) {
+		kfree(msg);
+		return ret;
+	}
+
 	req_header = msg;
 	acl = (void *)req_header + sizeof(*req_header);
 	mem = (void *)acl + acl_size;
@@ -266,8 +272,10 @@ int gunyah_rm_mem_share(struct gunyah_rm *rm, struct gunyah_rm_mem_parcel *p)
 			     &resp_size);
 	kfree(msg);
 
-	if (ret)
+	if (ret) {
+		gunyah_rm_platform_post_mem_reclaim(rm, p);
 		return ret;
+	}
 
 	p->mem_handle = le32_to_cpu(*resp);
 	kfree(resp);
@@ -298,9 +306,15 @@ int gunyah_rm_mem_reclaim(struct gunyah_rm *rm,
 	struct gunyah_rm_mem_release_req req = {
 		.mem_handle = cpu_to_le32(parcel->mem_handle),
 	};
+	int ret;
 
-	return gunyah_rm_call(rm, GUNYAH_RM_RPC_MEM_RECLAIM, &req, sizeof(req),
-			      NULL, NULL);
+	ret = gunyah_rm_call(rm, GUNYAH_RM_RPC_MEM_RECLAIM, &req, sizeof(req),
+			     NULL, NULL);
+	/* Only call platform mem reclaim hooks if we reclaimed the memory */
+	if (ret)
+		return ret;
+
+	return gunyah_rm_platform_post_mem_reclaim(rm, parcel);
 }
 
 /**
diff --git a/drivers/virt/gunyah/vm_mgr_mem.c b/drivers/virt/gunyah/vm_mgr_mem.c
index d61fceeeac60..e1675633804f 100644
--- a/drivers/virt/gunyah/vm_mgr_mem.c
+++ b/drivers/virt/gunyah/vm_mgr_mem.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 
+#include "rsc_mgr.h"
 #include "vm_mgr.h"
 
 #define WRITE_TAG (1 << 0)
@@ -120,7 +121,7 @@ int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
 	size_t size = folio_size(folio);
 	enum gunyah_error gunyah_error;
 	unsigned long tag = 0;
-	int ret;
+	int ret, tmp;
 
 	if (share) {
 		guest_extent = __first_resource(&ghvm->guest_shared_extent_ticket);
@@ -159,6 +160,11 @@ int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
 	else /* !share && !write */
 		access = GUNYAH_PAGETABLE_ACCESS_RX;
 
+	ret = gunyah_rm_platform_pre_demand_page(ghvm->rm, ghvm->vmid, access,
+						 folio);
+	if (ret)
+		goto remove;
+
 	gunyah_error = gunyah_hypercall_memextent_donate(donate_flags(share),
 							 host_extent->capid,
 							 guest_extent->capid,
@@ -167,7 +173,7 @@ int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
 		pr_err("Failed to donate memory for guest address 0x%016llx: %d\n",
 		       gpa, gunyah_error);
 		ret = gunyah_error_remap(gunyah_error);
-		goto remove;
+		goto platform_release;
 	}
 
 	extent_attrs =
@@ -196,6 +202,14 @@ int gunyah_vm_provide_folio(struct gunyah_vm *ghvm, struct folio *folio,
 	if (gunyah_error != GUNYAH_ERROR_OK)
 		pr_err("Failed to reclaim memory donation for guest address 0x%016llx: %d\n",
 		       gpa, gunyah_error);
+platform_release:
+	tmp = gunyah_rm_platform_reclaim_demand_page(ghvm->rm, ghvm->vmid,
+						     access, folio);
+	if (tmp) {
+		pr_err("Platform failed to reclaim memory for guest address 0x%016llx: %d",
+		       gpa, tmp);
+		return ret;
+	}
 remove:
 	mtree_erase(&ghvm->gm, gfn);
 	return ret;
@@ -272,14 +286,12 @@ int gunyah_vm_reclaim_folio(struct gunyah_vm *ghvm, u64 gfn)
 	else /* !share && !write */
 		access = GUNYAH_PAGETABLE_ACCESS_RX;
 
-	gunyah_error = gunyah_hypercall_memextent_donate(donate_flags(share),
-							 guest_extent->capid,
-							 host_extent->capid, pa,
-							 size);
-	if (gunyah_error != GUNYAH_ERROR_OK) {
-		pr_err("Failed to reclaim memory donation for guest address 0x%016llx: %d\n",
-		       gfn << PAGE_SHIFT, gunyah_error);
-		ret = gunyah_error_remap(gunyah_error);
+	ret = gunyah_rm_platform_reclaim_demand_page(ghvm->rm, ghvm->vmid,
+						     access, folio);
+	if (ret) {
+		pr_err_ratelimited(
+			"Platform failed to reclaim memory for guest address 0x%016llx: %d",
+			gunyah_gfn_to_gpa(gfn), ret);
 		goto err;
 	}
 
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 0f61c2b10817..f177f8dbcd4c 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -168,4 +168,41 @@ gunyah_rm_alloc_resource(struct gunyah_rm *rm,
 			 struct gunyah_rm_hyp_resource *hyp_resource);
 void gunyah_rm_free_resource(struct gunyah_resource *ghrsc);
 
+struct gunyah_rm_platform_ops {
+	int (*pre_mem_share)(struct gunyah_rm *rm,
+			     struct gunyah_rm_mem_parcel *mem_parcel);
+	int (*post_mem_reclaim)(struct gunyah_rm *rm,
+				struct gunyah_rm_mem_parcel *mem_parcel);
+
+	int (*pre_demand_page)(struct gunyah_rm *rm, u16 vmid, u32 flags,
+			       struct folio *folio);
+	int (*release_demand_page)(struct gunyah_rm *rm, u16 vmid, u32 flags,
+				   struct folio *folio);
+};
+
+#if IS_ENABLED(CONFIG_GUNYAH_PLATFORM_HOOKS)
+int gunyah_rm_register_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops);
+void gunyah_rm_unregister_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops);
+int devm_gunyah_rm_register_platform_ops(
+	struct device *dev, const struct gunyah_rm_platform_ops *ops);
+#else
+static inline int gunyah_rm_register_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops)
+{
+	return 0;
+}
+static inline void gunyah_rm_unregister_platform_ops(
+	const struct gunyah_rm_platform_ops *platform_ops)
+{
+}
+static inline int
+devm_gunyah_rm_register_platform_ops(struct device *dev,
+				     const struct gunyah_rm_platform_ops *ops)
+{
+	return 0;
+}
+#endif
+
 #endif

-- 
2.43.0


