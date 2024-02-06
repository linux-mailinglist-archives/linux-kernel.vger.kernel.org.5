Return-Path: <linux-kernel+bounces-54413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD684AEE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167D01F23B4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2746312B15B;
	Tue,  6 Feb 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gsDqIrN7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DFD12AAE6;
	Tue,  6 Feb 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203850; cv=none; b=B/P97FX729K2OXe//WjG3mdvpaVDvW/RCbmXghydI8qE8lBk4knOCtRZc66TgC3LfGLlNvxOQs7F5Cy3Od17OZFJZf3qflRwuB8xIwr4waecjk+fHefYx1e3zHGMO7YIN5KUK6CljUILSlml0CFntxh2TagmdqWbuxuSswuwpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203850; c=relaxed/simple;
	bh=7NqEHP/HJxs1xIo4NW7eLjE6D7NNNCdrJT8zKHV3DD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVzj2rrw9eDYKLEoQyEebCcvlQLVuie1bEI6ge5R97lvch0CHFkX1cHjA8WnlMGhw7gZFDl+NRH+vopQz8+uq8mxWOw0BX0AsZV5cCwlA0rtn4lV1LZ9CjdqyeDukbRECOIKq/o/igXUNxWQs7BBKgN0hb6joPXsVhVljQSTyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gsDqIrN7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4165aHG8005825;
	Tue, 6 Feb 2024 07:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=8xjSvbXLEzrQNMvN3OM1VuSzqsjr+s8nInWkZJt7bKg=; b=gs
	DqIrN7xYskfcDgaJCNeWize68Eo68r7KRLOqG0tGx49A3wqQv3S327jtHy5Hkryg
	sPti7iIIx8VCUWMqwjW3r9NY4dTGHsySSvA/TSF5faEJPOMHeOZHxxFfaRSMlQ3u
	n7d2cmYEiSsxT4lyqFey6KnaikiCKAnCg4ovW/fAY5wMJDxIeLRMnTfED03LbK3g
	jruazC70XDoPrSckj/xCcrvJsP17mY7Sl+HxYrSaXooF+vE1xSvbESTplV/70YOi
	f3+KuHWA8jqgqx3KmJDeKMd758nKX3zbrQkxE5PY/XQFTNirb90NqVzoQZPVjsfG
	uhZqE1/0hUVYDDC1lZTw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w399erser-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 07:17:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4167GAqG003208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 07:16:10 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 23:16:06 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
Subject: [PATCH v2 3/5] arm64: dts: qcom: sm8550: Add mapping to llcc Broadcast_AND region
Date: Mon, 5 Feb 2024 23:15:54 -0800
Message-ID: <abc952af5050fcdb4cad2cff430f59ac30fdfa89.1707202761.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1707202761.git.quic_uchalich@quicinc.com>
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TQQdIAOclxT_AF8ANuN4mrAIoZN2sAjG
X-Proofpoint-ORIG-GUID: TQQdIAOclxT_AF8ANuN4mrAIoZN2sAjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_01,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=496
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060049

Mapping Broadcast_AND region for LLCC in SM8550.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ee1ba5a8c8fc..1a52e30330c3 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4193,12 +4193,14 @@ system-cache-controller@25000000 {
 			      <0 0x25200000 0 0x200000>,
 			      <0 0x25400000 0 0x200000>,
 			      <0 0x25600000 0 0x200000>,
-			      <0 0x25800000 0 0x200000>;
+			      <0 0x25800000 0 0x200000>,
+			      <0 0x25a00000 0 0x200000>;
 			reg-names = "llcc0_base",
 				    "llcc1_base",
 				    "llcc2_base",
 				    "llcc3_base",
-				    "llcc_broadcast_base";
+				    "llcc_broadcast_base",
+				    "llcc_broadcast_and_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1


