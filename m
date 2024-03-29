Return-Path: <linux-kernel+bounces-125366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A5E8924A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FD92854BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F83413C9D1;
	Fri, 29 Mar 2024 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XhZxwfMs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39D10942;
	Fri, 29 Mar 2024 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741856; cv=none; b=r66PdmsVqQRcKKsuwiJEzLJyp96+TYNnMd+WDhwkO456SsKT99djVopeXreHvYv77qnjh5JLoJSFoEGso8txNpUdsyI+zv5+P7ACfKjTAP5OkXBzK09YNW6IA1kNkaKi9+1EKbk6m1M7SZbhU/FaP+sfA3VGcRPoD4AEVi6ptwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741856; c=relaxed/simple;
	bh=hy4KenGj6FJNKXWaQloIhutlC4pmT6yKuVEgMSdejsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f4SrvmgdTxv9qvqpHswxj/fcDze518f9xluZwySRrFMoA7vzypd6Qq8l6j5kNHKPlsUbLhIn8UNpWAGdIGOTQH24dHKYsCddMch9kmwLRN9hi/mFKDfU2J0tnQkwBsSqTbZrKRw0G0ThhLxo4RWgunXCsFybeR4Z0rlzysgcF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XhZxwfMs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TJeOW0000759;
	Fri, 29 Mar 2024 19:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=7rock+tuzQRHkqfp1Y4Kn8OYDsz+pZ5CBU3sKrV+tGY=; b=Xh
	ZxwfMs8QqAYUMJTt0PVclF0OA6lmtWlvL0fvd/65OkvkRNgURFP4+b5FhRZ7yTqU
	xt3rDG9BlstBviwg/6vMjo9KXlRdu3op3E0zT20w4vZAcugchV4Raoxk/oqeqsX0
	2MPY20vEaQX86v+uSIrRJbt4r+bOTHLfMqDFY6HatcOr+HlHSYL4NQXFeP35Ac05
	VQnp/sk88sLm17xFeRgrXCRZfZDacT52N0tJPIJrNxvj20weLYph1a9VQipUtPFq
	Dkp7LRVnie9AUYWJXHmDww6atpNtLLKWYIylwXceVdKLjPnFQTCQ3FepwuACy+lo
	iol8t6dARICIgH/A05ZA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5w6g0x66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 19:50:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TJohgu024049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 19:50:43 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 12:50:43 -0700
From: Kuogee Hsieh <quic_khsieh@quicinc.com>
To: <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>, <andersson@kernel.org>
CC: Kuogee Hsieh <quic_khsieh@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] phy/qcom-qmp-combo: propagate correct return value at phy_power_on()
Date: Fri, 29 Mar 2024 12:50:35 -0700
Message-ID: <1711741835-10044-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cvI2yOkFUv_7WnJ4YM2eSZGnz7rLQjSe
X-Proofpoint-ORIG-GUID: cvI2yOkFUv_7WnJ4YM2eSZGnz7rLQjSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290178

Currently qmp_combo_dp_power_on() always return 0 in regardless of
return value of cfg->configure_dp_phy(). This patch propagate
return value of cfg->configure_dp_phy() all the way back to caller.

Changes in V3:
-- add v2 changes log

Changes in V2:
-- add Fixes tag
-- add dev_err() to qmp_v3_configure_dp_phy()
-- add dev_err() to qmp_v4_configure_dp_phy()

Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 36632fa..513d99d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2343,8 +2343,10 @@ static int qmp_v3_configure_dp_phy(struct qmp_combo *qmp)
 	writel(0x05, qmp->dp_dp_phy + QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL);
 
 	ret = qmp_combo_configure_dp_clocks(qmp);
-	if (ret)
+	if (ret) {
+		dev_err(qmp->dev, "dp phy configure failed, err=%d\n", ret);
 		return ret;
+	}
 
 	writel(0x04, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
 	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
@@ -2519,8 +2521,10 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
 	int ret;
 
 	ret = qmp_v456_configure_dp_phy(qmp);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(qmp->dev, "dp phy configure failed, err=%d\n", ret);
 		return ret;
+	}
 
 	/*
 	 * At least for 7nm DP PHY this has to be done after enabling link
@@ -2754,6 +2758,7 @@ static int qmp_combo_dp_power_on(struct phy *phy)
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *tx = qmp->dp_tx;
 	void __iomem *tx2 = qmp->dp_tx2;
+	int ret;
 
 	mutex_lock(&qmp->phy_mutex);
 
@@ -2766,11 +2771,11 @@ static int qmp_combo_dp_power_on(struct phy *phy)
 	cfg->configure_dp_tx(qmp);
 
 	/* Configure link rate, swing, etc. */
-	cfg->configure_dp_phy(qmp);
+	ret = cfg->configure_dp_phy(qmp);
 
 	mutex_unlock(&qmp->phy_mutex);
 
-	return 0;
+	return ret;
 }
 
 static int qmp_combo_dp_power_off(struct phy *phy)
-- 
2.7.4


