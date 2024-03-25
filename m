Return-Path: <linux-kernel+bounces-116822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861388A434
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449A52E0B97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A218E0F8;
	Mon, 25 Mar 2024 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gx91C27I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EE1AF8CD;
	Mon, 25 Mar 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362081; cv=none; b=Z9aFkYAY7yUGpvuiq6bWY6t3Nxg0EV3XrMSfPr6VTUo/KSPWsw6pWB25udUm5bWrWxOVM3h78h3GcXi/J+gj8zeuBZykv+Jht7B0cpS0aYcXrb0q1JzimAYuLo7qauxyoTKRnmDBLmCp/oDU7ep8C7jyfhTjj5sizrc9hdS4xFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362081; c=relaxed/simple;
	bh=rmUgwPKnMZ2SbbQ5ys8ICa8KHER4uzmMmTU4uQ5RE+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYLzVCejGWazMYh9CHysFgvpRa1oAMJbgCnomXItLUgbE7cpAGTAGZjnO6l9eBzBq6dtfACGR4gr6F/Kt2Hx2nxe5ybbfSPs5XsSkv+N2DFpXzh2/jolKi5O3tNC16XYLEcK+bDzOZtzLmDJP9z58duN6UVB+SNM8q0xM9GjlEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gx91C27I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P8U5iI028809;
	Mon, 25 Mar 2024 10:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=MsW3qmcuSM3EjW5j4LiZgKtFk2Tzr6aqmZqv+GdO7wU=; b=gx
	91C27IrhyP/dGlC9t8iO8QAkHeoa1xEQ3rmtYpUtBDeqcvh/OqObTa1K7m0Aoaq6
	0StJf6PR9JlBWUnLlUEWW62zsPjTQeTCh4Z7r9nPIxetwSnTyVCn81njLS6zDdV0
	NBNpOFmIcH4HDW2yNgegK55qoO+p30X7zBQ/NRBMSp6ySQYrUlbB28vfZV+kK7Iq
	2SCRR+7jcUprSDLQ25gM4W8hFTnhLU231lT6PQ4cKMxwI2gquN1BAnXN7NCZH9c7
	naE4y3sZu3eXyGo6QjeQBw9fW9t44qAUyCNIF6/GGN5O+BEeko6q1cn+W2h27Me2
	1L08C6x6qSltMBgTF6BA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x34dqge2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:21:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PAL17x030979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:21:01 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 03:20:56 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 1/4] dt-bindings: clock: Add interconnect-cells
Date: Mon, 25 Mar 2024 15:50:33 +0530
Message-ID: <20240325102036.95484-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325102036.95484-1-quic_varada@quicinc.com>
References: <20240325102036.95484-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7EhsKU-ofCHWDine0EAnAjN4uZOT8TRs
X-Proofpoint-GUID: 7EhsKU-ofCHWDine0EAnAjN4uZOT8TRs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250056

Add interconnect-cells to clock provider so that it can be
used as icc provider

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
index 944a0ea79cd6..824781cbdf34 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
@@ -33,6 +33,9 @@ properties:
       - description: PCIE30 PHY3 pipe clock source
       - description: USB3 PHY pipe clock source
 
+  '#interconnect-cells':
+    const: 1
+
 required:
   - compatible
   - clocks
-- 
2.34.1


