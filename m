Return-Path: <linux-kernel+bounces-148462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1768A82E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596A51F21EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5113CFAF;
	Wed, 17 Apr 2024 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="baT7LiQK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6413F42D;
	Wed, 17 Apr 2024 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355807; cv=none; b=ANm3TfHypqpWT1KlrThCsHCR1rz2PtWIznKJWiPN1XNEqAqouhe5QMqdVVswJQnHyK3GwtDjHjwAvMOe873+Ik7EmSFxigKn8FGgMSD5NS687EW57U3v9yJaYh9WUgry7lmtg4MjlO9VAtSjZTgKDM1LZ0QAmZarwDrmQSxJ5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355807; c=relaxed/simple;
	bh=eRwiF0ii7qyNDlz+YhOOeQim5tdK7BFYPPtypXyNvhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/3Gz/GMO2pP4DhnaAZO5Tq+PLgjuLnTX+U/yt9OMtf1uzFcnbNJi66GKo57zS70cf9a9Li12eFHFCoXYrWO8P8gIM5V1hlqSAj+wvvttqbhKD4vylFyRHqD5eJqK2bkvyLagqga7L7puEqEz181jFd9tXZGEwg9OA9B96XNcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=baT7LiQK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H90EON012716;
	Wed, 17 Apr 2024 12:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Y/sMhmgtRWOF4u2uKGCZzKR6rd8EsR1PEHVG7Ff97/E=; b=ba
	T7LiQKdfKJcafs2Zuwetyjxv+BfHG4FCqVB+33ZjHqomExEslMpaQiVwraoywKXa
	tkBHmRciijAKpk5HnbMnmVweKo76MpzwpIjToJ/AvF8JqH3MFpFatQXCFaQRmzQc
	Ce4QX9f5CUCcEAluc5yvwIqRLILV+YrzX8Xgb0DmX0XtZQH+HDvoLpVJJhnPatsi
	eAVhB0eEZtJ8WZ1lcCyvvKIRGMboDx+kMbkoYTifcYtRFlBPPmw45GQ0EMJ0vDuC
	M96jB4J2JXfTH3TNIHI6iN1U19LWnholV96oPJtwqAcj/f7SkCAu8aHNSeONqB0r
	Z+sslSOWsEJKzWic7vbw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj8h78uur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:09:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HC9uvC001177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:09:56 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 05:09:52 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>,
        <quic_tsoni@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v3 1/2] arm64: dts: qcom: qcm6490-idp: Enable various remoteprocs
Date: Wed, 17 Apr 2024 17:39:27 +0530
Message-ID: <20240417120928.32344-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240417120928.32344-1-quic_kbajaj@quicinc.com>
References: <20240417120928.32344-1-quic_kbajaj@quicinc.com>
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
X-Proofpoint-GUID: DfKhmWf_PrgKTZyd1VVaOxhQ2LLc0TDQ
X-Proofpoint-ORIG-GUID: DfKhmWf_PrgKTZyd1VVaOxhQ2LLc0TDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_09,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=733
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170084

Enable the ADSP, CDSP, MPSS and WPSS that are found on the SoC.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index f8f8a43f638d..01ea64b16969 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -580,6 +580,26 @@ &qupv3_id_0 {
 	status = "okay";
 };

+&remoteproc_adsp {
+	firmware-name = "qcom/qcm6490/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/qcm6490/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/qcm6490/modem.mbn";
+	status = "okay";
+};
+
+&remoteproc_wpss {
+	firmware-name = "qcom/qcm6490/wpss.mbn";
+	status = "okay";
+};
+
 &sdhc_1 {
 	non-removable;
 	no-sd;
--
2.42.0


