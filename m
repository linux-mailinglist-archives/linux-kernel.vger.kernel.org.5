Return-Path: <linux-kernel+bounces-148248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635C88A7FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F10D1C20E56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418721327ED;
	Wed, 17 Apr 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AMSbUtKA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5F130A41;
	Wed, 17 Apr 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346487; cv=none; b=oLSGDCVG/7oCSn4nJ1OgeuZl9h5m/JmlJU4wtRBwGsmdprx0fOyfJ5M0jP3p7092h5WZiSpnfrLhfVvwu0UPOrKkhWmmJwaPhsu0WdDbts1AgMHJnij3O1ANudpbFPwqGlSTPlEtyOLjY1wRZ4NQEfKaUX0VV30CbD3X9v4P/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346487; c=relaxed/simple;
	bh=8M0cP8H9SmjO68TUZQ2nfeZxnXcBncMZDGae/QHKAmc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hfAMbJ+7hq+QCeRlQGf2iVcY5Jo0DfM6Xofja01EVzPX66qnI4KzUhVTk+xLWOpbVkApwvAIDSDSe2onOh9lvzmkp5ix+D3C8lq6WqKjq3Y9vi8l4GToWyfDcaIJCxOe3g0fHy9QiYHK1hfs3Qi6qlYRoHmpr9FIWGmMKN78Uqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AMSbUtKA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H4tNdD004668;
	Wed, 17 Apr 2024 09:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=ebN3LYyo3nXC
	VircSI3raiUdshoMu646eNhmWXeH6PE=; b=AMSbUtKAoSWaqwXGyC64sY1F80Cx
	9voYOAUomppVn4sK0dm+rxyf5ysVsozn5qI1/ZEPTyuwyvHLgbGsmxe9k7bOZrUa
	pVIbTDZLeIo/woCldonMbgVh5pZthaTHoa+KNh1o37DnjNipB+LFhTbD7cREy3UG
	JlMROHckYXDx8wD0ltgUBO4LCGR3abh5M+q/Pxzzy4/MFwmbd5PYKIczs0r60JrC
	ORPjt/vIbz/fFj3MrlscWQcVSJEXoxl8mMC3Jc8C8J4Cv4a1hRVWS9HrqS56ksVl
	Y+TG0kIAz0jRkKsZZ0SUNMoBIIQ60CZzWg9f0rYANVwP6kWXBFg4fPdvXw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj7tr0jq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 09:34:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43H9YBJV008391;
	Wed, 17 Apr 2024 09:34:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xfk4kteec-1;
	Wed, 17 Apr 2024 09:34:11 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43H9YB87008382;
	Wed, 17 Apr 2024 09:34:11 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43H9YBMF008381;
	Wed, 17 Apr 2024 09:34:11 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id F0ACE500C6C; Wed, 17 Apr 2024 15:04:09 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v2] slimbus: stream: Add null pointer check for client APIs
Date: Wed, 17 Apr 2024 15:04:08 +0530
Message-Id: <20240417093408.28639-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vyo812iT0-97hYtBDcbyzii2LPC1_bTk
X-Proofpoint-GUID: vyo812iT0-97hYtBDcbyzii2LPC1_bTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=925
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170066
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Due to incorrect sequrnce of slimbus APIs called by client
driver, facing system crash in slimbus framework APIs.

To prevent system crash, add NULL pointer check in
enable/disable/prepare/unprepare/free APIs.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
v1 -> v2:
- Update commit log.
- Update debug logs.

v1 Link: https://lore.kernel.org/linux-arm-msm/ZhgIHHP1FUeCr+vx@hu-bjorande-lv.qualcomm.com/T/
---
---
 drivers/slimbus/stream.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 1d6b38657917..76d0579cbf53 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -202,10 +202,16 @@ static int slim_get_prate_code(int rate)
 int slim_stream_prepare(struct slim_stream_runtime *rt,
 			struct slim_stream_config *cfg)
 {
-	struct slim_controller *ctrl = rt->dev->ctrl;
+	struct slim_controller *ctrl;
 	struct slim_port *port;
 	int num_ports, i, port_id, prrate;
 
+	if (!rt || !cfg) {
+		pr_err("Invalid stream rt or cfg\n");
+		return -EINVAL;
+	}
+
+	ctrl = rt->dev->ctrl;
 	if (rt->ports) {
 		dev_err(&rt->dev->dev, "Stream already Prepared\n");
 		return -EINVAL;
@@ -358,9 +364,15 @@ int slim_stream_enable(struct slim_stream_runtime *stream)
 {
 	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
 				3, SLIM_LA_MANAGER, NULL);
-	struct slim_controller *ctrl = stream->dev->ctrl;
+	struct slim_controller *ctrl;
 	int ret, i;
 
+	if (!stream) {
+		pr_err("Invalid stream\n");
+		return -EINVAL;
+	}
+
+	ctrl = stream->dev->ctrl;
 	if (ctrl->enable_stream) {
 		ret = ctrl->enable_stream(stream);
 		if (ret)
@@ -411,12 +423,18 @@ int slim_stream_disable(struct slim_stream_runtime *stream)
 {
 	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
 				3, SLIM_LA_MANAGER, NULL);
-	struct slim_controller *ctrl = stream->dev->ctrl;
+	struct slim_controller *ctrl;
 	int ret, i;
 
+	if (!stream) {
+		pr_err("Invalid stream");
+		return -EINVAL;
+	}
+
 	if (!stream->ports || !stream->num_ports)
 		return -EINVAL;
 
+	ctrl = stream->dev->ctrl;
 	if (ctrl->disable_stream)
 		ctrl->disable_stream(stream);
 
@@ -448,6 +466,11 @@ int slim_stream_unprepare(struct slim_stream_runtime *stream)
 {
 	int i;
 
+	if (!stream) {
+		pr_err("Invalid stream\n");
+		return -EINVAL;
+	}
+
 	if (!stream->ports || !stream->num_ports)
 		return -EINVAL;
 
@@ -476,8 +499,14 @@ EXPORT_SYMBOL_GPL(slim_stream_unprepare);
  */
 int slim_stream_free(struct slim_stream_runtime *stream)
 {
-	struct slim_device *sdev = stream->dev;
+	struct slim_device *sdev;
+
+	if (!stream) {
+		pr_err("Invalid stream\n");
+		return -EINVAL;
+	}
 
+	sdev = stream->dev;
 	spin_lock(&sdev->stream_list_lock);
 	list_del(&stream->node);
 	spin_unlock(&sdev->stream_list_lock);
-- 
2.17.1


