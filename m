Return-Path: <linux-kernel+bounces-1893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F7815562
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC751F2592F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0237D2E;
	Sat, 16 Dec 2023 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LBd4BiIk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1235263;
	Sat, 16 Dec 2023 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG0A3mA005535;
	Sat, 16 Dec 2023 00:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=AoJz6x3XHRsvMZUmjQluSOPQZI6QBrPLiwr7IUcs9qI
	=; b=LBd4BiIkq0UL8rGuEy1QUc1P6ieFNK6mqw+NsFobix2XJghYV2uMfsFtjdf
	QjfWxbVi7dJWoFxOxmmyPyVZDhEB75c4jXTZ+BsJjNZ6CPhBEU1lNUUz9QQ4+gBZ
	eEh7Z8yEGOxaPrYNtZ1DI5lcmTjT+gzj1JwLHCsHXqhOZ8Qlx/0OhZxKOsbRGWk4
	Zo/8qdxSlyMMTL4pndzfEp6X1VvdZ5b1DmZ12xJs6bSr1lny8AjtCb5gKCZ+Fjdq
	UqIqoTWfWVhqx//q7H+XL4U7a7tsQYGhDzOYhrxtebOKoOKPbqA+OWTEH2Hj5nEk
	MMEFzONTklb0ZzaeOwoIY7gsz7A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hqcjf8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LGjD015189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:15 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:21:07 -0800
Subject: [PATCH RFC v15 26/30] virt: gunyah: Add Qualcomm Gunyah platform
 ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-26-192a5d872a30@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 5kHKOPXIMXrRSzcPItxdXfpH0sZPhm_H
X-Proofpoint-GUID: 5kHKOPXIMXrRSzcPItxdXfpH0sZPhm_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160001

Qualcomm platforms have a firmware entity which performs access control
to physical pages. Dynamically started Gunyah virtual machines use the
QCOM_SCM_RM_MANAGED_VMID for access. Linux thus needs to assign access
to the memory used by guest VMs. Gunyah doesn't do this operation for us
since it is the current VM (typically VMID_HLOS) delegating the access
and not Gunyah itself. Use the Gunyah platform ops to achieve this so
that only Qualcomm platforms attempt to make the needed SCM calls.

Reviewed-by: Alex Elder <elder@linaro.org>
Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Kconfig       |  13 +++
 drivers/virt/gunyah/Makefile      |   1 +
 drivers/virt/gunyah/gunyah_qcom.c | 218 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 23ba523d25dc..fe2823dc48ba 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -4,6 +4,7 @@ config GUNYAH
 	tristate "Gunyah Virtualization drivers"
 	depends on ARM64
 	select GUNYAH_PLATFORM_HOOKS
+	imply GUNYAH_QCOM_PLATFORM if ARCH_QCOM
 	help
 	  The Gunyah drivers are the helper interfaces that run in a guest VM
 	  such as basic inter-VM IPC and signaling mechanisms, and higher level
@@ -14,3 +15,15 @@ config GUNYAH
 
 config GUNYAH_PLATFORM_HOOKS
 	tristate
+
+config GUNYAH_QCOM_PLATFORM
+	tristate "Support for Gunyah on Qualcomm platforms"
+	depends on GUNYAH
+	select GUNYAH_PLATFORM_HOOKS
+	select QCOM_SCM
+	help
+	  Enable support for interacting with Gunyah on Qualcomm
+	  platforms. Interaction with Qualcomm firmware requires
+	  extra platform-specific support.
+
+	  Say Y/M here to use Gunyah on Qualcomm platforms.
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 9d514b2baa3a..c4505fce177d 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -4,3 +4,4 @@ gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mem.o guest_memfd.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o gunyah_vcpu.o
 obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
+obj-$(CONFIG_GUNYAH_QCOM_PLATFORM) += gunyah_qcom.o
diff --git a/drivers/virt/gunyah/gunyah_qcom.c b/drivers/virt/gunyah/gunyah_qcom.c
new file mode 100644
index 000000000000..58309e40da93
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_qcom.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+#define QCOM_SCM_RM_MANAGED_VMID 0x3A
+#define QCOM_SCM_MAX_MANAGED_VMID 0x3F
+
+static int
+qcom_scm_gunyah_rm_pre_mem_share(struct gunyah_rm *rm,
+				 struct gunyah_rm_mem_parcel *mem_parcel)
+{
+	struct qcom_scm_vmperm *new_perms __free(kfree) = NULL;
+	u64 src, src_cpy;
+	int ret = 0, i, n;
+	u16 vmid;
+
+	new_perms = kcalloc(mem_parcel->n_acl_entries, sizeof(*new_perms),
+			    GFP_KERNEL);
+	if (!new_perms)
+		return -ENOMEM;
+
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
+		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			new_perms[n].vmid = vmid;
+		else
+			new_perms[n].vmid = QCOM_SCM_RM_MANAGED_VMID;
+		if (mem_parcel->acl_entries[n].perms & GUNYAH_RM_ACL_X)
+			new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
+		if (mem_parcel->acl_entries[n].perms & GUNYAH_RM_ACL_W)
+			new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
+		if (mem_parcel->acl_entries[n].perms & GUNYAH_RM_ACL_R)
+			new_perms[n].perm |= QCOM_SCM_PERM_READ;
+	}
+
+	src = BIT_ULL(QCOM_SCM_VMID_HLOS);
+
+	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
+		src_cpy = src;
+		ret = qcom_scm_assign_mem(
+			le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
+			le64_to_cpu(mem_parcel->mem_entries[i].size), &src_cpy,
+			new_perms, mem_parcel->n_acl_entries);
+		if (ret)
+			break;
+	}
+
+	/* Did it work ok? */
+	if (!ret)
+		return 0;
+
+	src = 0;
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
+		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			src |= BIT_ULL(vmid);
+		else
+			src |= BIT_ULL(QCOM_SCM_RM_MANAGED_VMID);
+	}
+
+	new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
+
+	for (i--; i >= 0; i--) {
+		src_cpy = src;
+		WARN_ON_ONCE(qcom_scm_assign_mem(
+			le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
+			le64_to_cpu(mem_parcel->mem_entries[i].size), &src_cpy,
+			new_perms, 1));
+	}
+
+	return ret;
+}
+
+static int
+qcom_scm_gunyah_rm_post_mem_reclaim(struct gunyah_rm *rm,
+				    struct gunyah_rm_mem_parcel *mem_parcel)
+{
+	struct qcom_scm_vmperm new_perms;
+	u64 src = 0, src_cpy;
+	int ret = 0, i, n;
+	u16 vmid;
+
+	new_perms.vmid = QCOM_SCM_VMID_HLOS;
+	new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE |
+			 QCOM_SCM_PERM_READ;
+
+	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
+		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
+		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
+			src |= (1ull << vmid);
+		else
+			src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
+	}
+
+	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
+		src_cpy = src;
+		ret = qcom_scm_assign_mem(
+			le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
+			le64_to_cpu(mem_parcel->mem_entries[i].size), &src_cpy,
+			&new_perms, 1);
+		WARN_ON_ONCE(ret);
+	}
+
+	return ret;
+}
+
+static int
+qcom_scm_gunyah_rm_pre_demand_page(struct gunyah_rm *rm, u16 vmid,
+				   enum gunyah_pagetable_access access,
+				   struct folio *folio)
+{
+	struct qcom_scm_vmperm new_perms[2];
+	unsigned int n = 1;
+	u64 src;
+
+	new_perms[0].vmid = QCOM_SCM_RM_MANAGED_VMID;
+	new_perms[0].perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE |
+			    QCOM_SCM_PERM_READ;
+	if (access != GUNYAH_PAGETABLE_ACCESS_X &&
+	    access != GUNYAH_PAGETABLE_ACCESS_RX &&
+	    access != GUNYAH_PAGETABLE_ACCESS_RWX) {
+		new_perms[1].vmid = QCOM_SCM_VMID_HLOS;
+		new_perms[1].perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE |
+				    QCOM_SCM_PERM_READ;
+		n++;
+	}
+
+	src = BIT_ULL(QCOM_SCM_VMID_HLOS);
+
+	return qcom_scm_assign_mem(__pfn_to_phys(folio_pfn(folio)),
+				   folio_size(folio), &src, new_perms, n);
+}
+
+static int
+qcom_scm_gunyah_rm_release_demand_page(struct gunyah_rm *rm, u16 vmid,
+				       enum gunyah_pagetable_access access,
+				       struct folio *folio)
+{
+	struct qcom_scm_vmperm new_perms;
+	u64 src;
+
+	new_perms.vmid = QCOM_SCM_VMID_HLOS;
+	new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE |
+			 QCOM_SCM_PERM_READ;
+
+	src = BIT_ULL(QCOM_SCM_RM_MANAGED_VMID);
+
+	if (access != GUNYAH_PAGETABLE_ACCESS_X &&
+	    access != GUNYAH_PAGETABLE_ACCESS_RX &&
+	    access != GUNYAH_PAGETABLE_ACCESS_RWX)
+		src |= BIT_ULL(QCOM_SCM_VMID_HLOS);
+
+	return qcom_scm_assign_mem(__pfn_to_phys(folio_pfn(folio)),
+				   folio_size(folio), &src, &new_perms, 1);
+}
+
+static struct gunyah_rm_platform_ops qcom_scm_gunyah_rm_platform_ops = {
+	.pre_mem_share = qcom_scm_gunyah_rm_pre_mem_share,
+	.post_mem_reclaim = qcom_scm_gunyah_rm_post_mem_reclaim,
+	.pre_demand_page = qcom_scm_gunyah_rm_pre_demand_page,
+	.release_demand_page = qcom_scm_gunyah_rm_release_demand_page,
+};
+
+/* {19bd54bd-0b37-571b-946f-609b54539de6} */
+static const uuid_t QCOM_EXT_UUID = UUID_INIT(0x19bd54bd, 0x0b37, 0x571b, 0x94,
+					      0x6f, 0x60, 0x9b, 0x54, 0x53,
+					      0x9d, 0xe6);
+
+#define GUNYAH_QCOM_EXT_CALL_UUID_ID                              \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
+			   ARM_SMCCC_OWNER_VENDOR_HYP, 0x3f01)
+
+static bool gunyah_has_qcom_extensions(void)
+{
+	struct arm_smccc_res res;
+	uuid_t uuid;
+	u32 *up;
+
+	arm_smccc_1_1_smc(GUNYAH_QCOM_EXT_CALL_UUID_ID, &res);
+
+	up = (u32 *)&uuid.b[0];
+	up[0] = lower_32_bits(res.a0);
+	up[1] = lower_32_bits(res.a1);
+	up[2] = lower_32_bits(res.a2);
+	up[3] = lower_32_bits(res.a3);
+
+	return uuid_equal(&uuid, &QCOM_EXT_UUID);
+}
+
+static int __init qcom_gunyah_platform_hooks_register(void)
+{
+	if (!gunyah_has_qcom_extensions())
+		return -ENODEV;
+
+	pr_info("Enabling Gunyah hooks for Qualcomm platforms.\n");
+
+	return gunyah_rm_register_platform_ops(
+		&qcom_scm_gunyah_rm_platform_ops);
+}
+
+static void __exit qcom_gunyah_platform_hooks_unregister(void)
+{
+	gunyah_rm_unregister_platform_ops(&qcom_scm_gunyah_rm_platform_ops);
+}
+
+module_init(qcom_gunyah_platform_hooks_register);
+module_exit(qcom_gunyah_platform_hooks_unregister);
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Platform Hooks for Gunyah");
+MODULE_LICENSE("GPL");

-- 
2.43.0


