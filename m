Return-Path: <linux-kernel+bounces-1883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A5181553B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB171F25798
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBAA1DFF2;
	Sat, 16 Dec 2023 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S+YBWtgP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EB9134C0;
	Sat, 16 Dec 2023 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG0Kf5x006568;
	Sat, 16 Dec 2023 00:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=IC3bcqcwKy8KffxllZXS23XN2gL4nURWbQSLOfvNnAU
	=; b=S+YBWtgPCDuzmbm2bV2ViPHohni9kLP+h1SLlnTk6YvNRnFrDfQwexblwa+
	833rhGublJYHiBuCUOE8Bc2HoUC3k1O5y1s/IsIlvZtfKmhLI3DXq+5l8ZBCBtHz
	e4t04YJPNakHCold2EPxNghPgGtNdsBMcxYp7e0lPa+m7Z+wOn+IiVsPskkgtS7p
	cu8lm1BWxOx+vOCvd38QFBpf5zkrWxwo9QFgPkBNp8qVXNJijzPqyELCUf/JlDwm
	rRwEpubnGyHGNrTwm9MLGu1DE99NBeDdLgNTzkoBTOJwAUFDW5T7rGlrxVUWH9wJ
	8/efdUmB/LbW6gLZ4BYnoHoYeaA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v118s801t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LAbi015616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:10 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:09 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:20:56 -0800
Subject: [PATCH RFC v15 15/30] gunyah: Add hypercalls for demand paging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-15-192a5d872a30@quicinc.com>
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
X-Proofpoint-ORIG-GUID: cGamZTK9kCVm63Vm9fSgArhy6xIUUNve
X-Proofpoint-GUID: cGamZTK9kCVm63Vm9fSgArhy6xIUUNve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=556 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312160001

Three hypercalls are needed to support demand paging.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/gunyah/gunyah_hypercall.c | 60 +++++++++++++++++++++++++++
 arch/arm64/include/asm/gunyah.h      | 21 ++++++++++
 include/linux/gunyah.h               | 79 ++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
index cadc512934c4..468a5bcb98b1 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -39,6 +39,9 @@ EXPORT_SYMBOL_GPL(arch_is_gunyah_guest);
 #define GUNYAH_HYPERCALL_HYP_IDENTIFY		GUNYAH_HYPERCALL(0x8000)
 #define GUNYAH_HYPERCALL_MSGQ_SEND		GUNYAH_HYPERCALL(0x801B)
 #define GUNYAH_HYPERCALL_MSGQ_RECV		GUNYAH_HYPERCALL(0x801C)
+#define GUNYAH_HYPERCALL_ADDRSPACE_MAP		GUNYAH_HYPERCALL(0x802B)
+#define GUNYAH_HYPERCALL_ADDRSPACE_UNMAP		GUNYAH_HYPERCALL(0x802C)
+#define GUNYAH_HYPERCALL_MEMEXTENT_DONATE		GUNYAH_HYPERCALL(0x8061)
 /* clang-format on */
 
 /**
@@ -92,5 +95,62 @@ enum gunyah_error gunyah_hypercall_msgq_recv(u64 capid, void *buff, size_t size,
 }
 EXPORT_SYMBOL_GPL(gunyah_hypercall_msgq_recv);
 
+enum gunyah_error gunyah_hypercall_addrspace_map(u64 capid, u64 extent_capid, u64 vbase,
+					u32 extent_attrs, u32 flags, u64 offset, u64 size)
+{
+	struct arm_smccc_1_2_regs args = {
+		.a0 = GUNYAH_HYPERCALL_ADDRSPACE_MAP,
+		.a1 = capid,
+		.a2 = extent_capid,
+		.a3 = vbase,
+		.a4 = extent_attrs,
+		.a5 = flags,
+		.a6 = offset,
+		.a7 = size,
+		/* C language says this will be implictly zero. Gunyah requires 0, so be explicit */
+		.a8 = 0,
+	};
+	struct arm_smccc_1_2_regs res;
+
+	arm_smccc_1_2_hvc(&args, &res);
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gunyah_hypercall_addrspace_map);
+
+enum gunyah_error gunyah_hypercall_addrspace_unmap(u64 capid, u64 extent_capid, u64 vbase,
+					u32 flags, u64 offset, u64 size)
+{
+	struct arm_smccc_1_2_regs args = {
+		.a0 = GUNYAH_HYPERCALL_ADDRSPACE_UNMAP,
+		.a1 = capid,
+		.a2 = extent_capid,
+		.a3 = vbase,
+		.a4 = flags,
+		.a5 = offset,
+		.a6 = size,
+		/* C language says this will be implictly zero. Gunyah requires 0, so be explicit */
+		.a7 = 0,
+	};
+	struct arm_smccc_1_2_regs res;
+
+	arm_smccc_1_2_hvc(&args, &res);
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gunyah_hypercall_addrspace_unmap);
+
+enum gunyah_error gunyah_hypercall_memextent_donate(u32 options, u64 from_capid, u64 to_capid,
+					    u64 offset, u64 size)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GUNYAH_HYPERCALL_MEMEXTENT_DONATE, options, from_capid, to_capid,
+				offset, size, 0, &res);
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gunyah_hypercall_memextent_donate);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
index 0cd3debe22b6..4adf24977fd1 100644
--- a/arch/arm64/include/asm/gunyah.h
+++ b/arch/arm64/include/asm/gunyah.h
@@ -33,4 +33,25 @@ static inline int arch_gunyah_fill_irq_fwspec_params(u32 virq,
 	return 0;
 }
 
+enum arch_gunyah_memtype {
+	/* clang-format off */
+	GUNYAH_MEMTYPE_DEVICE_nGnRnE	= 0,
+	GUNYAH_DEVICE_nGnRE		= 1,
+	GUNYAH_DEVICE_nGRE		= 2,
+	GUNYAH_DEVICE_GRE		= 3,
+
+	GUNYAH_NORMAL_NC	= 0b0101,
+	GUNYAH_NORMAL_ONC_IWT	= 0b0110,
+	GUNYAH_NORMAL_ONC_IWB	= 0b0111,
+	GUNYAH_NORMAL_OWT_INC	= 0b1001,
+	GUNYAH_NORMAL_WT	= 0b1010,
+	GUNYAH_NORMAL_OWT_IWB	= 0b1011,
+	GUNYAH_NORMAL_OWB_INC	= 0b1101,
+	GUNYAH_NORMAL_OWB_IWT	= 0b1110,
+	GUNYAH_NORMAL_WB	= 0b1111,
+	/* clang-format on */
+};
+
+#define ARCH_GUNYAH_DEFAULT_MEMTYPE	GUNYAH_NORMAL_WB
+
 #endif
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index ecd62d0e36ad..86f48dc1d56d 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -151,4 +151,83 @@ enum gunyah_error gunyah_hypercall_msgq_send(u64 capid, size_t size, void *buff,
 enum gunyah_error gunyah_hypercall_msgq_recv(u64 capid, void *buff, size_t size,
 					     size_t *recv_size, bool *ready);
 
+#define GUNYAH_ADDRSPACE_SELF_CAP 0
+
+enum gunyah_pagetable_access {
+	/* clang-format off */
+	GUNYAH_PAGETABLE_ACCESS_NONE		= 0,
+	GUNYAH_PAGETABLE_ACCESS_X		= 1,
+	GUNYAH_PAGETABLE_ACCESS_W		= 2,
+	GUNYAH_PAGETABLE_ACCESS_R		= 4,
+	GUNYAH_PAGETABLE_ACCESS_RX		= 5,
+	GUNYAH_PAGETABLE_ACCESS_RW		= 6,
+	GUNYAH_PAGETABLE_ACCESS_RWX		= 7,
+	/* clang-format on */
+};
+
+/* clang-format off */
+#define GUNYAH_MEMEXTENT_MAPPING_USER_ACCESS		GENMASK_ULL(2, 0)
+#define GUNYAH_MEMEXTENT_MAPPING_KERNEL_ACCESS		GENMASK_ULL(6, 4)
+#define GUNYAH_MEMEXTENT_MAPPING_TYPE			GENMASK_ULL(23, 16)
+/* clang-format on */
+
+enum gunyah_memextent_donate_type {
+	/* clang-format off */
+	GUNYAH_MEMEXTENT_DONATE_TO_CHILD		= 0,
+	GUNYAH_MEMEXTENT_DONATE_TO_PARENT		= 1,
+	GUNYAH_MEMEXTENT_DONATE_TO_SIBLING		= 2,
+	GUNYAH_MEMEXTENT_DONATE_TO_PROTECTED		= 3,
+	GUNYAH_MEMEXTENT_DONATE_FROM_PROTECTED		= 4,
+	/* clang-format on */
+};
+
+enum gunyah_addrspace_map_flag_bits {
+	/* clang-format off */
+	GUNYAH_ADDRSPACE_MAP_FLAG_PARTIAL	= 0,
+	GUNYAH_ADDRSPACE_MAP_FLAG_PRIVATE	= 1,
+	GUNYAH_ADDRSPACE_MAP_FLAG_VMMIO		= 2,
+	GUNYAH_ADDRSPACE_MAP_FLAG_NOSYNC	= 31,
+	/* clang-format on */
+};
+
+enum gunyah_error gunyah_hypercall_addrspace_map(u64 capid, u64 extent_capid,
+						 u64 vbase, u32 extent_attrs,
+						 u32 flags, u64 offset,
+						 u64 size);
+enum gunyah_error gunyah_hypercall_addrspace_unmap(u64 capid, u64 extent_capid,
+						   u64 vbase, u32 flags,
+						   u64 offset, u64 size);
+
+/* clang-format off */
+#define GUNYAH_MEMEXTENT_OPTION_TYPE_MASK	GENMASK_ULL(7, 0)
+#define GUNYAH_MEMEXTENT_OPTION_NOSYNC		BIT(31)
+/* clang-format on */
+
+enum gunyah_error gunyah_hypercall_memextent_donate(u32 options, u64 from_capid,
+						    u64 to_capid, u64 offset,
+						    u64 size);
+
+struct gunyah_hypercall_vcpu_run_resp {
+	union {
+		enum {
+			/* clang-format off */
+			/* VCPU is ready to run */
+			GUNYAH_VCPU_STATE_READY			= 0,
+			/* VCPU is sleeping until an interrupt arrives */
+			GUNYAH_VCPU_STATE_EXPECTS_WAKEUP	= 1,
+			/* VCPU is powered off */
+			GUNYAH_VCPU_STATE_POWERED_OFF		= 2,
+			/* VCPU is blocked in EL2 for unspecified reason */
+			GUNYAH_VCPU_STATE_BLOCKED		= 3,
+			/* VCPU has returned for MMIO READ */
+			GUNYAH_VCPU_ADDRSPACE_VMMIO_READ	= 4,
+			/* VCPU has returned for MMIO WRITE */
+			GUNYAH_VCPU_ADDRSPACE_VMMIO_WRITE	= 5,
+			/* clang-format on */
+		} state;
+		u64 sized_state;
+	};
+	u64 state_data[3];
+};
+
 #endif

-- 
2.43.0


