Return-Path: <linux-kernel+bounces-21321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40711828D8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4291F24C27
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840623D549;
	Tue,  9 Jan 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RuWbIk+W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304FA3D39A;
	Tue,  9 Jan 2024 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409FLOTm019742;
	Tue, 9 Jan 2024 19:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ZmNQftYQ9DObdFwpkA0z8j22sgDG+4nWIrT9hdY4fiQ
	=; b=RuWbIk+WvWluBTam3/XT8OhTxtqUlJZyo4xUdim7Vtw0mAdya48xt2pG2iM
	Ke2FC1lmFAtkxTEdGyfmWzKIVEkBM2WyYC2ZiWOkLkE59GivXlpf1q0H9ifrR5F9
	ZHt5S7nmDI88Zyc2o8vioCU2/SIeN9Ddfj4hAF3OPhjzbyQwxN8OmG6BlSVsQN7D
	k8RCeHQc3FkUxOcoypQ13p1mLIWdQ7ut27u9UuwjBzDN0gVyt2cUokTjEL/uMhQD
	c6jZK24JTZ67IlC8FGbZyp8GT0Hhsu5JyRdds00zHA3jMAfK/B4GGBptY1LPwbdB
	JWFEideaQU6Aj28HU8exu4xHbkA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh85t0pmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:37:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409JbqJ0003334
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:37:52 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:37:51 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:37:42 -0800
Subject: [PATCH v16 04/34] virt: gunyah: Add hypercalls to identify Gunyah
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-4-634904bf4ce9@quicinc.com>
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
X-Proofpoint-ORIG-GUID: SZJWMs5XkE7kjTL_2qezXSdD6Nq6wlJd
X-Proofpoint-GUID: SZJWMs5XkE7kjTL_2qezXSdD6Nq6wlJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Add hypercalls to identify when Linux is running in a virtual machine
under Gunyah.

There are two calls to help identify Gunyah:

1. gh_hypercall_get_uid() returns a UID when running under a Gunyah
   hypervisor.
2. gh_hypercall_hyp_identify() returns build information and a set of
   feature flags that are supported by Gunyah.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/Kbuild                    |  1 +
 arch/arm64/gunyah/Makefile           |  3 ++
 arch/arm64/gunyah/gunyah_hypercall.c | 62 ++++++++++++++++++++++++++++++++++++
 drivers/virt/Kconfig                 |  2 ++
 drivers/virt/gunyah/Kconfig          | 12 +++++++
 include/linux/gunyah.h               | 38 ++++++++++++++++++++++
 6 files changed, 118 insertions(+)

diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index 5bfbf7d79c99..e4847ba0e3c9 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -3,6 +3,7 @@ obj-y			+= kernel/ mm/ net/
 obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/
 obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
+obj-$(CONFIG_GUNYAH)	+= gunyah/
 obj-$(CONFIG_CRYPTO)	+= crypto/
 
 # for cleaning
diff --git a/arch/arm64/gunyah/Makefile b/arch/arm64/gunyah/Makefile
new file mode 100644
index 000000000000..84f1e38cafb1
--- /dev/null
+++ b/arch/arm64/gunyah/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_GUNYAH) += gunyah_hypercall.o
diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
new file mode 100644
index 000000000000..d44663334f38
--- /dev/null
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/module.h>
+#include <linux/gunyah.h>
+#include <linux/uuid.h>
+
+/* {c1d58fcd-a453-5fdb-9265-ce36673d5f14} */
+static const uuid_t GUNYAH_UUID = UUID_INIT(0xc1d58fcd, 0xa453, 0x5fdb, 0x92,
+					    0x65, 0xce, 0x36, 0x67, 0x3d, 0x5f,
+					    0x14);
+
+bool arch_is_gunyah_guest(void)
+{
+	struct arm_smccc_res res;
+	uuid_t uuid;
+	u32 *up;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
+
+	up = (u32 *)&uuid.b[0];
+	up[0] = lower_32_bits(res.a0);
+	up[1] = lower_32_bits(res.a1);
+	up[2] = lower_32_bits(res.a2);
+	up[3] = lower_32_bits(res.a3);
+
+	return uuid_equal(&uuid, &GUNYAH_UUID);
+}
+EXPORT_SYMBOL_GPL(arch_is_gunyah_guest);
+
+#define GUNYAH_HYPERCALL(fn)                                      \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
+			   ARM_SMCCC_OWNER_VENDOR_HYP, fn)
+
+/* clang-format off */
+#define GUNYAH_HYPERCALL_HYP_IDENTIFY		GUNYAH_HYPERCALL(0x8000)
+/* clang-format on */
+
+/**
+ * gunyah_hypercall_hyp_identify() - Returns build information and feature flags
+ *                               supported by Gunyah.
+ * @hyp_identity: filled by the hypercall with the API info and feature flags.
+ */
+void gunyah_hypercall_hyp_identify(
+	struct gunyah_hypercall_hyp_identify_resp *hyp_identity)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GUNYAH_HYPERCALL_HYP_IDENTIFY, &res);
+
+	hyp_identity->api_info = res.a0;
+	hyp_identity->flags[0] = res.a1;
+	hyp_identity->flags[1] = res.a2;
+	hyp_identity->flags[2] = res.a3;
+}
+EXPORT_SYMBOL_GPL(gunyah_hypercall_hyp_identify);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 40129b6f0eca..172a6a12073c 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -50,4 +50,6 @@ source "drivers/virt/acrn/Kconfig"
 
 source "drivers/virt/coco/Kconfig"
 
+source "drivers/virt/gunyah/Kconfig"
+
 endif
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
new file mode 100644
index 000000000000..6f4c85db80b5
--- /dev/null
+++ b/drivers/virt/gunyah/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config GUNYAH
+	tristate "Gunyah Virtualization drivers"
+	depends on ARM64
+	help
+	  The Gunyah drivers are the helper interfaces that run in a guest VM
+	  such as basic inter-VM IPC and signaling mechanisms, and higher level
+	  services such as memory/device sharing, IRQ sharing, and so on.
+
+	  Say Y/M here to enable the drivers needed to interact in a Gunyah
+	  virtual environment.
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 1eab631a49b6..33bcbd22d39f 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -6,9 +6,11 @@
 #ifndef _LINUX_GUNYAH_H
 #define _LINUX_GUNYAH_H
 
+#include <linux/bitfield.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/limits.h>
+#include <linux/types.h>
 
 /* Matches resource manager's resource types for VM_GET_HYP_RESOURCES RPC */
 enum gunyah_resource_type {
@@ -103,4 +105,40 @@ static inline int gunyah_error_remap(enum gunyah_error gunyah_error)
 	}
 }
 
+enum gunyah_api_feature {
+	/* clang-format off */
+	GUNYAH_FEATURE_DOORBELL		= 1,
+	GUNYAH_FEATURE_MSGQUEUE		= 2,
+	GUNYAH_FEATURE_VCPU		= 5,
+	GUNYAH_FEATURE_MEMEXTENT	= 6,
+	/* clang-format on */
+};
+
+bool arch_is_gunyah_guest(void);
+
+#define GUNYAH_API_V1 1
+
+/* Other bits reserved for future use and will be zero */
+/* clang-format off */
+#define GUNYAH_API_INFO_API_VERSION_MASK	GENMASK_ULL(13, 0)
+#define GUNYAH_API_INFO_BIG_ENDIAN		BIT_ULL(14)
+#define GUNYAH_API_INFO_IS_64BIT		BIT_ULL(15)
+#define GUNYAH_API_INFO_VARIANT_MASK 		GENMASK_ULL(63, 56)
+/* clang-format on */
+
+struct gunyah_hypercall_hyp_identify_resp {
+	u64 api_info;
+	u64 flags[3];
+};
+
+static inline u16
+gunyah_api_version(const struct gunyah_hypercall_hyp_identify_resp *gunyah_api)
+{
+	return FIELD_GET(GUNYAH_API_INFO_API_VERSION_MASK,
+			 gunyah_api->api_info);
+}
+
+void gunyah_hypercall_hyp_identify(
+	struct gunyah_hypercall_hyp_identify_resp *hyp_identity);
+
 #endif

-- 
2.34.1


