Return-Path: <linux-kernel+bounces-19767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE3827313
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB551F253C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408D50269;
	Mon,  8 Jan 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N3E1bpN8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A851C55;
	Mon,  8 Jan 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4087SrWp020052;
	Mon, 8 Jan 2024 15:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=UoSATDI0JClWkWGMLQJA
	2GrcmBkv8AT6PNP7LUJlb8I=; b=N3E1bpN8ZA5noCYQBEebsLHYar1CPbI3PYLf
	Dc601MGprZX7mQdsCg66Hzuk+0jKfwHYSvOc55NuqyM+lcRUTPxF5iuCeTqvYzXH
	OD4WVfiuIWs/RnsOb3zdiT9o+iMnHQkc5862UeqRahoVIZNtyf7lhSQR/hshf/no
	cUnJvK0xO7h4/OFhieKT73p5q7LCA5Dn+Id611Ft3IuHmEiG4t70w1o2IRXnM7Pc
	GR/sY5JSkEqQxeBvf5JSKs4lEC3EriS5kpPuZn/4LiqwBy61uC1QT+3VLc7AE4cq
	kTw/i68zRYFGqcooEmPX5XmpQqNb02bb81KzvQdzM1iF+ahM/A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg8mx9dyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 15:28:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408FS9aA006518
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 15:28:09 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 07:28:06 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v11 3/4] firmware: qcom: scm: Rework dload mode availability check
Date: Mon, 8 Jan 2024 20:57:33 +0530
Message-ID: <1704727654-13999-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wEuFfbjQ44oXIVpg2HNYVPAxw1eUlXJT
X-Proofpoint-ORIG-GUID: wEuFfbjQ44oXIVpg2HNYVPAxw1eUlXJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080132

QCOM_SCM_BOOT_SET_DLOAD_MODE was only valid for very older
target and firmware and for recent targets there is dload
mode tcsr registers is available to set the download mode.

So, it is better to keep it as fallback check instead of
checking its availability and failing it always.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 4421f219fe9a..87bcd5c02f2b 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -532,18 +532,16 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 static void qcom_scm_set_download_mode(bool enable)
 {
 	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
-	bool avail;
 	int ret = 0;
 
-	avail = __qcom_scm_is_call_available(__scm->dev,
-					     QCOM_SCM_SVC_BOOT,
-					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
-	if (avail) {
-		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
-	} else if (__scm->dload_mode_addr) {
+	if (__scm->dload_mode_addr) {
 		ret = qcom_scm_io_rmw(__scm->dload_mode_addr,
 				      QCOM_DLOAD_MASK,
 				      FIELD_PREP(QCOM_DLOAD_MASK, val));
+	} else if (__qcom_scm_is_call_available(__scm->dev,
+						QCOM_SCM_SVC_BOOT,
+						QCOM_SCM_BOOT_SET_DLOAD_MODE)) {
+		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
-- 
2.7.4


