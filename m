Return-Path: <linux-kernel+bounces-52535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F9849963
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E06B25655
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79AD1B95C;
	Mon,  5 Feb 2024 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dDtz8p5U"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDAA1BC2C;
	Mon,  5 Feb 2024 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134309; cv=none; b=A0O8UKUM1vPz5O1echE67BCwfKkC1DhxwqApfbph31/fd9I/nMrFZ/WeZuYtc6q28lf/H8urih+5vVTBvIHTCTJ6u6W2xn7HYHup09VbRgcbUZDQCThZacjcDeN2msqOo3wFC1EtOHa4Vn1w+tLVEJcxqE5BXUIIcRyz6a/mX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134309; c=relaxed/simple;
	bh=Jcw1GDM4jlQ1yPjGgOCSgRnrBiadMxK/DjRpSjKbUKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDPlVRaD6b6SDtca5hp8Rb5tsMQCkTQG7u8GSDt9bfQYN5q1YANHGJW3R+BLC9AulUIOG7qqotcK4Jb954TN2vMYSaVUhXcb5QpMMwsBA9NTHf2WI8q3BlJRoDu/oSQfkN8wOjAm9eD2tb46SA0uwWRN/qYlbiY0Oyr9QAa0Rxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dDtz8p5U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41572YQA016808;
	Mon, 5 Feb 2024 11:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=lkdVKgrw2arUW81RdYdmY+HiVvAv27is70cI4EXPasA=; b=dD
	tz8p5U+IUo7qF5tJhPZ/Dk7z4TAmczLBuphY9JqFFtsQLqwWYdSAZlp3XqZqwq2C
	yJiekksnluk/x9mVcIL7vKA+jtfzQsXJlwEl3EPNxKNtKcj7M/+3I6+UX08SHv94
	hywbBb1kX62WsCcg+KyGSrRFCSmVy4CStGMYkhXA5sD71ZF9YiqhfQ8fYUf0z1HX
	vGFglyGxc/JnQiezOb/9C2XKF6h5Y1bp6th4VsVgE2fZg1IGZJr5hDVV95to6ZNq
	kiZD5bdgot9lhS7S7apNHY1cocKx37hmUKRK27UfvPe8NWcWT1H/35sob0fG+CwV
	fB6WlHNjNVW2buSNiXPA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2r8x0sxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 11:58:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415BwMMc028207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 11:58:22 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 03:58:17 -0800
From: Jingyi Wang <quic_jingyw@quicinc.com>
To: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <quic_jingyw@quicinc.com>, <kernel@quicinc.com>
Subject: [RFC PATCH 4/6] arm64: dts: qcom: sm8650p: introduce sm8650p dtsi
Date: Mon, 5 Feb 2024 19:57:19 +0800
Message-ID: <20240205115721.1195336-5-quic_jingyw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZR3hG4Jebxm4-Z8cg_mmHLoN7bQ2ld_i
X-Proofpoint-GUID: ZR3hG4Jebxm4-Z8cg_mmHLoN7bQ2ld_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=576
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050091

Introduce sm8650p dtsi, sm8650p has same base functions
as sm8650 with different memory regions.

There are 3 types of reserved memory regions here:
1. Firmware related regions.
    This will be described as: reserved-region@address. Current
reserved-region may have reserved area which was not yet used, release
note of the firmware can have such kind of information.
2. Firmware related which shared with kernel access.
    Each region will have a specific node with specific label name for
later phandle reference from other driver dt node. May overlapping with
above type regions.
3. PIL regions.
    PIL regions are allocated by kernel and assigned to subsystem
firmware later.
Here is a map for this platform:
0x100000000 +------------------+
            |                  |
            | Firmware Related |
            |                  |
 0xd8000000 +------------------+
            |                  |
            | Kernel Available |
            |                  |
 0xA7000000 +------------------+
            |                  |
            |    PIL Region    |
            |                  |
 0x8BC00000 +------------------+
            |                  |
            | Firmware Related |
            |                  |
 0x80000000 +------------------+
Note that:
1. 0xA7000000 to 0xA8000000 was used by bootloader as well, not suggest
for other usage.
2. Kernel start address was start at 0xA8000000.

Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8650p.dtsi | 180 ++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8650p.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm8650p.dtsi b/arch/arm64/boot/dts/qcom/sm8650p.dtsi
new file mode 100644
index 000000000000..26dfe315b49d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8650p.dtsi
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "sm8650.dtsi"
+
+/delete-node/ &reserved_memory;
+
+/ {
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * There are 3 types of reserved memory regions here:
+		 * 1. Firmware related regions.
+		 *     This will be described as: reserved-region@address. Current
+		 * reserved-region may have reserved area which was not yet used,
+		 * release note of the firmware can have such kind of information.
+		 * 2. Firmware related which shared with kernel access.
+		 *     Each region will have a specific node with specific label
+		 * name for later phandle reference from other driver dt node. May
+		 * overlapping with above type regions.
+		 * 3. PIL regions.
+		 *     PIL regions are allocated by kernel and assigned to subsystem
+		 * firmware later.
+		 * Here is a map for this platform:
+		 * 0x100000000 +------------------+
+		 *             |                  |
+		 *             | Firmware Related |
+		 *             |                  |
+		 *  0xd8000000 +------------------+
+		 *             |                  |
+		 *             | Kernel Available |
+		 *             |                  |
+		 *  0xA7000000 +------------------+
+		 *             |                  |
+		 *             |    PIL Region    |
+		 *             |                  |
+		 *  0x8BC00000 +------------------+
+		 *             |                  |
+		 *             | Firmware Related |
+		 *             |                  |
+		 *  0x80000000 +------------------+
+		 * Note that:
+		 * 1. 0xA7000000 to 0xA8000000 was used by bootloader as well, not
+		 * suggest for other usage.
+		 * 2. Kernel start address was start at 0xA8000000.
+		 */
+
+		/* Firmware related regions */
+		reserved-region@80000000 {
+			reg = <0x0 0x80000000 0x0 0xbc00000>;
+			no-map;
+		};
+
+		aop_image_mem: aop-image-region@81c00000 {
+			reg = <0x0 0x81c00000 0x0 0x60000>;
+			no-map;
+		};
+
+		aop_cmd_db_mem: aop-cmd-db-region@81c60000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x81c60000 0x0 0x20000>;
+			no-map;
+		};
+
+		aop_config_mem: aop-config-region@81c80000 {
+			no-map;
+			reg = <0x0 0x81c80000 0x0 0x20000>;
+		};
+
+		smem_mem: smem-region@81d00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x81d00000 0x0 0x200000>;
+			hwlocks = <&tcsr_mutex 3>;
+			no-map;
+		};
+
+		adsp_mhi_mem: adsp-mhi-region@81f00000 {
+			reg = <0x0 0x81f00000 0x0 0x20000>;
+			no-map;
+		};
+
+		global_sync_mem: global-sync@82600000 {
+			reg = <0 0x82600000 0 0x100000>;
+			no-map;
+		};
+
+		mpss_dsm_mem: mpss-dsm@86b00000 {
+			reg = <0 0x86b00000 0 0x4900000>;
+			no-map;
+		};
+
+		mpss_dsm_mem_2: mpss-dsm-2@8b400000 {
+			reg = <0 0x8b400000 0 0x800000>;
+			no-map;
+		};
+
+		/* PIL region */
+		mpss_mem: mpss-region@8bc00000 {
+			reg = <0x0 0x8bc00000 0x0 0xf400000>;
+			no-map;
+		};
+
+		q6_mpss_dtb_mem: q6-mpss-dtb-region@9b000000 {
+			reg = <0x0 0x9b000000 0x0 0x80000>;
+			no-map;
+		};
+
+		ipa_fw_mem: ipa-fw-region@9b080000 {
+			reg = <0x0 0x9b080000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: ipa-gsi-region@9b090000 {
+			reg = <0x0 0x9b090000 0x0 0xa000>;
+			no-map;
+		};
+
+		gpu_micro_code_mem: gpu-micro-code-region@9b09a000 {
+			reg = <0x0 0x9b09a000 0x0 0x2000>;
+			no-map;
+		};
+
+		spss_region_mem: spss-region@9b0a0000 {
+			reg = <0x0 0x9b0a0000 0x0 0x1e0000>;
+			no-map;
+		};
+
+		spu_secure_shared_memory_mem: spu-secure-shared-memory-region@9b280000 {
+			reg = <0x0 0x9b280000 0x0 0x80000>;
+			no-map;
+		};
+
+		camera_mem: camera-region@9b300000 {
+			reg = <0x0 0x9b300000 0x0 0x800000>;
+			no-map;
+		};
+
+		video_mem: video-region@9bb00000 {
+			reg = <0x0 0x9bb00000 0x0 0x800000>;
+			no-map;
+		};
+
+		cvp_mem: cvp-region@9c300000 {
+			reg = <0x0 0x9c300000 0x0 0x700000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp-region@9ca00000 {
+			reg = <0x0 0x9ca00000 0x0 0x1400000>;
+			no-map;
+		};
+
+		q6_cdsp_dtb_mem: q6-cdsp-dtb-region@9de00000 {
+			reg = <0x0 0x9de00000 0x0 0x80000>;
+			no-map;
+		};
+
+		q6_adsp_dtb_mem: q6-adsp-dtb-region@9de80000 {
+			reg = <0x0 0x9de80000 0x0 0x80000>;
+			no-map;
+		};
+
+		adspslpi_mem: adspslpi-region@9df00000 {
+			reg = <0x0 0x9df00000 0x0 0x4080000>;
+			no-map;
+		};
+
+		/* Firmware related regions */
+		reserved-region@d8000000 {
+			reg = <0x0 0xd8000000 0x0 0x28000000>;
+			no-map;
+		};
+
+	};
+};
-- 
2.25.1


