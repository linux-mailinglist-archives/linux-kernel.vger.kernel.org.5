Return-Path: <linux-kernel+bounces-122729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80AC88FC29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FCC1C290AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171397D41D;
	Thu, 28 Mar 2024 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EXaEwFYm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175259B71;
	Thu, 28 Mar 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619509; cv=none; b=Dp29rK35gC5qE1Cevb2AQtMMfYd40F6pZ+Q/VJxN7hSU7rUg1kGwJQ2uLKQFcWHSQH/dcit3X3xzOCk5qAwvp7fiKUSj9eGgprbxHjsCDcxFvTm2KJp7QyEKQN6B7VZLY4QHFBtUjJxM3FUV34Y1saJSrUACFU+ScHEf9TghQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619509; c=relaxed/simple;
	bh=JdWchCtwUG08pm3O6qSP5gpEhI5pwNMCB+IvhH3O8Uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txT+ZrYstxQ43NCqjnh3+8eLsjluUhP7LkMY6k8V5fD0jJOOvUyEs6IxET91sWuVzxKE/Lt02GjobUYSvzW/NrhoZeIuI2U1U/p4yK98NSQgKLYsNwgHbWIzr+9Zk4CRcIvKmXgXXn7ezxYaGP7Jr2KaeQMgUZldjGbnoxC8A2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EXaEwFYm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S9pcA3014327;
	Thu, 28 Mar 2024 09:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vgpGGB1DPtFNZfjtCnVQauZwM6HvllqhUEOAWqnMGbA=; b=EX
	aEwFYm5pXARs/OyLcfvelQqOoPMBxdB7phoqGPN2k1XOrgonuJTi5DIlt+IFAnEW
	26sDeiHP3KlqrgnZ1SwSZGzS9edfcBcXmnPZP1zcKI5VDW5pM5aWFp5EOOa6v9nI
	oQH83yoIhUtokIUMKKRslJoUQ0Z0wkAkvtGAv/YhcThkbDA0Nd6r5nLcIULoYyLj
	G48CJ8v3CGpp9sCVGaY4kKLPcnjKIVoNeC+IZMs1DgiSWeSM1kVS7zT9OSxIAX+G
	OKP0H1awkR0bEheb5S8o3v1YtsjSTdSwkVelx4N952U+yTWAlV2rD/4XhNPpQBhc
	PyhDIhMZWqLjgtmnCcvQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x562rg19r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:51:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S9pPRB010524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:51:25 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 02:51:20 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: [PATCH 3/5] arm64: dts: qcom: x1e80100: Resize GIC Redistributor register region
Date: Thu, 28 Mar 2024 15:20:42 +0530
Message-ID: <20240328095044.2926125-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328095044.2926125-1-quic_sibis@quicinc.com>
References: <20240328095044.2926125-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Cf8nDBjq0Q9rItj0TxitqSVnKD_lWqRZ
X-Proofpoint-GUID: Cf8nDBjq0Q9rItj0TxitqSVnKD_lWqRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=667 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280065

Resize the GICR register region as it currently seeps into the CPU Control
Processor mailbox RX region.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index f5a3b39ae70e..28f65296781d 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4949,7 +4949,7 @@ apps_smmu: iommu@15000000 {
 		intc: interrupt-controller@17000000 {
 			compatible = "arm,gic-v3";
 			reg = <0 0x17000000 0 0x10000>,     /* GICD */
-			      <0 0x17080000 0 0x480000>;    /* GICR * 12 */
+			      <0 0x17080000 0 0x380000>;    /* GICR * 12 */
 
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.34.1


