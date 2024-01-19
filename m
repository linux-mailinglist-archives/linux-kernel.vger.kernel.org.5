Return-Path: <linux-kernel+bounces-30999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D16B83274B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5377E285630
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9CC3C480;
	Fri, 19 Jan 2024 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V980FKd+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF683CF59;
	Fri, 19 Jan 2024 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658833; cv=none; b=qX0C03ONU24LjRdA+DLjZDiEVk+R7wNmXhES3qbywuGjdLDBj18Y9Hi0hNcGwtl56BdxGZ6sr57juxsCnzJfm1fYeDTs86mLTimHbW9wrkPykCcVTZdzAjunTCu+zlUgBCaz9SNc23qShrDe3/9VIuPPEtJHCyF9bkeZ/eI6lAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658833; c=relaxed/simple;
	bh=kEweRnQd0CFa7c2YQnWdk+aip9jBoCBcHHO92sZVzPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZan79QTYUDDiT/ockdRz/1LhC4QTcVMBI3avfynNwyyDOgoSGpDBEkUy3BdLfBiA1n687GbeITfetjEBJmwIxkNdgMkuZ8pNTxpGttW3NDUlKbMss83Vcj6qUi3y4uZ7KNNJqFr6H3mF1L8orJhW3FZVVtIdhPfbgNA0Yiqgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V980FKd+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J9fhRo000442;
	Fri, 19 Jan 2024 10:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=XN5anYJf6pbkexblY/v4
	IhjlgGlwt8p6Wc3cV7BgHDo=; b=V980FKd+4P4j18O2RYxZPnADIvAMewmmTMfM
	+0x1ZVI1RCrxxH9uO0hs+b2/1h5kDiK+DdoRyASWqKZZSRhYavzgF3p8Ja0IRiR3
	Ro3holBhPVFhJrvlUjV4kTnJSaSDkJ/FYzlTC0VmI5IFOndv5rnT0eu/7Yd+nRRk
	vsYB+vWqxDQ96mQmIEDRGyU9aFZsCAJvKP6YfzUeCPFAxmM+zTz7HkvJVM4Sudq4
	vkki4m7R9wK9yRpktxnqZVYdz2qIfJ9qs/Sz6uC5WEkhcHFgNRepL5iePF5xRBoC
	1eRD+FUvckMgFEs7desrC24y4jLMuHUctwmEs0Yk3tW6eyZa3g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqpp401f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:07:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JA79FU006576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:07:09 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 02:07:03 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>
Subject: [PATCH v4 3/6] soc: qcom: socinfo: add SoC Info support for QCM8550 and QCS8550 platform
Date: Fri, 19 Jan 2024 18:06:18 +0800
Message-ID: <20240119100621.11788-4-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240119100621.11788-1-quic_tengfan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
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
X-Proofpoint-GUID: 7ZUlAsakH-P5udrev-AZOXWKzU5ciGU0
X-Proofpoint-ORIG-GUID: 7ZUlAsakH-P5udrev-AZOXWKzU5ciGU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=899 clxscore=1015
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401190044

Add SoC Info support for QCM8550 and QCS8550 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 6349a0debeb5..321b39b48b80 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -437,6 +437,8 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ5322) },
 	{ qcom_board_id(IPQ5312) },
 	{ qcom_board_id(IPQ5302) },
+	{ qcom_board_id(QCS8550) },
+	{ qcom_board_id(QCM8550) },
 	{ qcom_board_id(IPQ5300) },
 };
 
-- 
2.17.1


