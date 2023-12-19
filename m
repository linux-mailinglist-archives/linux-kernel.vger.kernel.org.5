Return-Path: <linux-kernel+bounces-4541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423DA817F08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4282284BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78C79C2;
	Tue, 19 Dec 2023 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QG8hbGcZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6563AC;
	Tue, 19 Dec 2023 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BINwdGl007887;
	Tue, 19 Dec 2023 00:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=HXkKOk+qyGmo+SSgiM6/
	1VPUGqm1G7gWsd+RnDYl6pU=; b=QG8hbGcZhpIgchiNMv5yWKwp6mCPPA/r8G0c
	cu5cUUw0O2FEz4kq+pZ8jcffi96zAKttOZ+3igOPbqXaXwZRTsSdDRHv/tO9tlvP
	2Dbv7EapIYKMtDHEG7i+bTwQ01cIWJVwqYgF6iREQ3AUGgPJr+6DV6tEE2ONjnXS
	CCi/vnSrpYVxQ4xazILQ1X3E+AgjrgWNEsy1q0DWUt7f8acseTVeQQ6trvMD6QM6
	tVe8dfbyS76vAA+urF3y0pfmATWUT562iXA77En2IY78DRponmv4P6pdsFb0Jrjf
	4BLi/L/4LgD1h8lwYpZHBderTpcIBGc3rymxEP2DrNWhKJmMwg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2nxs9ray-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:51:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ0pMxv017496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:51:22 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 16:51:19 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v3 3/6] soc: qcom: socinfo: add SoC Info support for the QCS8550 platform
Date: Tue, 19 Dec 2023 08:50:04 +0800
Message-ID: <20231219005007.11644-4-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219005007.11644-1-quic_tengfan@quicinc.com>
References: <20231219005007.11644-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z1kJxuaAfmoH10VfGSSD2kTxvUkqllwR
X-Proofpoint-ORIG-GUID: Z1kJxuaAfmoH10VfGSSD2kTxvUkqllwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=936
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312190004

Add SoC Info support for the QCS8550 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 6349a0debeb5..e059b0b0f11f 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -437,6 +437,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ5322) },
 	{ qcom_board_id(IPQ5312) },
 	{ qcom_board_id(IPQ5302) },
+	{ qcom_board_id(QCS8550) },
 	{ qcom_board_id(IPQ5300) },
 };
 
-- 
2.17.1


