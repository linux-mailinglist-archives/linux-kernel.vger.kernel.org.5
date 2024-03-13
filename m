Return-Path: <linux-kernel+bounces-101414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9449787A6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C1E1F23B67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0282D47781;
	Wed, 13 Mar 2024 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aFofx7of"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4D40C15;
	Wed, 13 Mar 2024 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328152; cv=none; b=DZY59NIzfR0o0/oI9dE/td/04Cgf4LqnA3kv1UpA4Ovpy9EKRcTexCOgFlu9KJQOQNpC4EAGYI+xXn1qmPU+/sCEP9zz47sLAqs4rKCAQYsKFjhja9EwYbXHg2Zmlohd4QPzKyZMNgW2ovOeX+nA7lQJN1qUhXRDWwc9euN5fic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328152; c=relaxed/simple;
	bh=GdaNCXq0HLFb4IL9/uyDoTiLk6PDxVDs6bXsCPqOz60=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=pMKYp+nrzpnPCBmYPirM0ubnSYRghluNgBcmCMwyUN7s5a1V8ik6oSDi9dEj4xaXtzGdAQPnhO89/hwyC5IPxUpSMa5adZo1a2BT+7qXVpiUosjcwAYovxeB4oiVt6mcLWJwU5r6b1CF650arm7jao7uVL8tC1wiS29TCTy9FoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aFofx7of; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DAkvI6020880;
	Wed, 13 Mar 2024 11:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=qyPDOYgs3/5W27
	Ag5hEy2zRW2QCFYTxLo4jyReBXbLQ=; b=aFofx7ofiRZ9W6sG6boF9w4XFOw+V0
	Glej0wfzjf/KeBT9wp/yHCOM9qlIj8QiQsoTnzoQkEIFTKsWyCoxdmBzfLXj1bwK
	lvN+F6vASvb1WM3+HDhSCFsNgyzFFYFxk/P2rSCk6WHPzkeOQSJWNXv9Gh74L6pG
	isOVKK+3icl1860ZWniM69JweW3Hu1lzDE9Q6SJA7j4ku70oSPWC9i1ttisLiiEJ
	4EcM2rQzgJj3dwij70jbErxfXNEh7vnOhGuwxs8R0On+71SVWt49rCItLwiycr7/
	o4u+SED+NQUvJ8cqS0Vw4TIMuOCPzUWLLkE1uN3qlgo/fctp3m/r7yGg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuapeg1cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 11:09:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DB95Vm017940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 11:09:05 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 04:09:00 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH 0/3] Add DT support for video clock controller on SM8150
Date: Wed, 13 Mar 2024 16:38:26 +0530
Message-ID: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqJ8WUC/x3MTQqAIBBA4avErBtQ++8q0aJ0rFmkoSFBdPek5
 bd474FIgSnCWDwQKHFk7zJkWYDeF7cRsskGJVQtKtFjYkNea4xHLxuB5kLnDWFrZVut9aBspyH
 HZyDL9z+e5vf9ADbQOndoAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YISqd6W2NvhviUXcEwrLzB8IWin0pvms
X-Proofpoint-GUID: YISqd6W2NvhviUXcEwrLzB8IWin0pvms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=703 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130083

Also, add the index based lookup support and update the device tree
bindings as per latest convention.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Satya Priya Kakitapalli (3):
      dt-bindings: clock: qcom: Update SM8150 videocc bindings
      clk: qcom: videocc-sm8150: Add index based clk lookup
      arm64: dts: qcom: sm8150: Add video clock controller node

 .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml      |  1 +
 Documentation/devicetree/bindings/clock/qcom,videocc.yaml   |  3 ---
 arch/arm64/boot/dts/qcom/sa8155p.dtsi                       |  4 ++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi                        | 13 +++++++++++++
 drivers/clk/qcom/videocc-sm8150.c                           |  8 ++++++--
 5 files changed, 24 insertions(+), 5 deletions(-)
---
base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
change-id: 20240308-videocc-sm8150-dt-node-6f163b492f7c

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>


