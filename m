Return-Path: <linux-kernel+bounces-148361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EBE8A8176
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC84282561
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A587D13C9A3;
	Wed, 17 Apr 2024 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ikIsZi49"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC213C91A;
	Wed, 17 Apr 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351433; cv=none; b=JcbNdKaENtLe/CXGb+LfYXB7UTKHsF5rJHjdclIAdNnZwgk9hkUJ3fsF0FIGao4eCy6t+AdgsGs9R0Q7EI4RWRRtakHZ60tCioVX+TC9KIJvGva2JrtxR6TlugBazVZNl6v1bHKD6t54eUtYExAuVpSPQ4EO97kJzay1N1rSEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351433; c=relaxed/simple;
	bh=JdgO9PoNM0VzJcfn9cBhaAVQ3wOxEFlNhbOS+yhBllc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g43Sfpw2YXTZvf5To6nxpH6pCfsEzuJl5OKu3RU1ylfYSO5cgMaQZo4E7IP4euxd02bYaL6TbUvvWpyE7N3K2mywd1bVdgYVJlX72S/gXecj6UYa4SL4/jle/cA4o7+2N1DwfkcePijeS/5U+IJZyWypNKW6bOqtXgNjI3OQysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ikIsZi49; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H7Gfr7026438;
	Wed, 17 Apr 2024 10:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=6M9ic2968FoET+wNPveATiyfs7KXTmB6Y7mEswOQWcQ=; b=ik
	IsZi49OlW6l2WZUuwYAXzXCwjwYkDb6AkicItJr2zdm0iY7ezAuoIM+nvdvWJZZG
	tZNdULoJQPX9tDY+zhkHOOQmU7vBd3q83qs3OQxbr8Ye1pz6KniTgwr4mCY3oHks
	1pZ/YTRvbGx6fXpVr/rLinYxjyQOhA9saDp7u0Zlpz4IwA1yPdFbVX+JkKxcMTKm
	k1HeGAtQWtOnAV2vgHj8l7acclCqcxyw7MvH+blEXxGfI9272mnWdU5wfm7wQT82
	cDml3/vd70v/wVO2N26AJ7peofxb+2ebqO96uH3ubBk9lU+W4ZldFFgIQiSyl/ol
	3iz3HFUOrEeKnohJNeHw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj9w58fr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:57:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HAv616015666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:57:06 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 03:57:01 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v8 6/7] clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
Date: Wed, 17 Apr 2024 16:26:04 +0530
Message-ID: <20240417105605.836705-7-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417105605.836705-1-quic_varada@quicinc.com>
References: <20240417105605.836705-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ucXb7m5ZCSpOKkZooWVacRMN22fbHNK5
X-Proofpoint-GUID: ucXb7m5ZCSpOKkZooWVacRMN22fbHNK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170075

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v8: Bind clock and interconnect using master and slave ids
    Use indices instead of clock pointers
v7: Auto select INTERCONNECT & INTERCONNECT_CLK in COMMON_CLK_QCOM
    to address build break with random config build test, with the
    following combination

	CONFIG_COMMON_CLK_QCOM=y
		and
	CONFIG_INTERCONNECT_CLK=m

    the following error is seen as devm_icc_clk_register is in a
    module and being referenced from vmlinux.

	powerpc64-linux-ld: drivers/clk/qcom/common.o: in function `qcom_cc_really_probe':
	>> common.c:(.text+0x980): undefined reference to `devm_icc_clk_register'

v6: Move enum to dt-bindings and share between here and DT
    first_id -> icc_first_node_id
v5: Split from common.c changes into separate patch
    No functional changes
---
 drivers/clk/qcom/Kconfig       |  2 ++
 drivers/clk/qcom/gcc-ipq9574.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8ab08e7b5b6c..b65a373f2e6b 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -17,6 +17,8 @@ menuconfig COMMON_CLK_QCOM
 	select RATIONAL
 	select REGMAP_MMIO
 	select RESET_CONTROLLER
+	select INTERCONNECT
+	select INTERCONNECT_CLK
 
 if COMMON_CLK_QCOM
 
diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 0a3f846695b8..7983e9ba0f35 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/interconnect-clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -12,6 +13,7 @@
 
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq9574.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -4301,6 +4303,32 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
 	[GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
 };
 
+#define IPQ_APPS_ID			9574	/* some unique value */
+
+static struct qcom_icc_hws_data icc_ipq9574_hws[] = {
+	HWS_DATA(ANOC_PCIE0, GCC_ANOC_PCIE0_1LANE_M_CLK),
+	HWS_DATA(SNOC_PCIE0, GCC_SNOC_PCIE0_1LANE_S_CLK),
+	HWS_DATA(ANOC_PCIE1, GCC_ANOC_PCIE1_1LANE_M_CLK),
+	HWS_DATA(SNOC_PCIE1, GCC_SNOC_PCIE1_1LANE_S_CLK),
+	HWS_DATA(ANOC_PCIE2, GCC_ANOC_PCIE2_2LANE_M_CLK),
+	HWS_DATA(SNOC_PCIE2, GCC_SNOC_PCIE2_2LANE_S_CLK),
+	HWS_DATA(ANOC_PCIE3, GCC_ANOC_PCIE3_2LANE_M_CLK),
+	HWS_DATA(SNOC_PCIE3, GCC_SNOC_PCIE3_2LANE_S_CLK),
+	HWS_DATA(USB, GCC_SNOC_USB_CLK),
+	HWS_DATA(USB_AXI, GCC_ANOC_USB_AXI_CLK),
+	HWS_DATA(NSSNOC_NSSCC, GCC_NSSNOC_NSSCC_CLK),
+	HWS_DATA(NSSNOC_SNOC_0, GCC_NSSNOC_SNOC_CLK),
+	HWS_DATA(NSSNOC_SNOC_1, GCC_NSSNOC_SNOC_1_CLK),
+	HWS_DATA(NSSNOC_PCNOC_1, GCC_NSSNOC_PCNOC_1_CLK),
+	HWS_DATA(NSSNOC_QOSGEN_REF, GCC_NSSNOC_QOSGEN_REF_CLK),
+	HWS_DATA(NSSNOC_TIMEOUT_REF, GCC_NSSNOC_TIMEOUT_REF_CLK),
+	HWS_DATA(NSSNOC_XO_DCD, GCC_NSSNOC_XO_DCD_CLK),
+	HWS_DATA(NSSNOC_ATB, GCC_NSSNOC_ATB_CLK),
+	HWS_DATA(MEM_NOC_NSSNOC, GCC_MEM_NOC_NSSNOC_CLK),
+	HWS_DATA(NSSNOC_MEMNOC, GCC_NSSNOC_MEMNOC_CLK),
+	HWS_DATA(NSSNOC_MEM_NOC_1, GCC_NSSNOC_MEM_NOC_1_CLK),
+};
+
 static const struct of_device_id gcc_ipq9574_match_table[] = {
 	{ .compatible = "qcom,ipq9574-gcc" },
 	{ }
@@ -4323,6 +4351,9 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq9574_resets),
 	.clk_hws = gcc_ipq9574_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq9574_hws),
+	.icc_hws = icc_ipq9574_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq9574_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq9574_probe(struct platform_device *pdev)
-- 
2.34.1


