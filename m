Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E55C768AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjGaEKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGaEKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:10:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AD3E43;
        Sun, 30 Jul 2023 21:10:32 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V2mVwh019004;
        Mon, 31 Jul 2023 04:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gPvnt16QGA4ObIxg6yNEmot12urHMc4SMSDvzpuJp88=;
 b=RlLkPPOkE5u5Rw76QJjAmaE+bjsmWEzfXxz1oqz/Q2Ixelqy6P5gdoX+95bRWboGgKIz
 TB6TIPWVSz+Cy4FnNZidaQL2gHYAGBDL7J2nWo5Et/vAE47sNYVN471tMr1Y9ZGjgzvg
 Z2F7oYnp1gKwrHn4cy4KQQU5WvpDGK7Ghv4Btno6+Vpw5to6IZikvRLEieVIlZQV0OkC
 ks2J1dGpluLR+EBaAFJt96U8TaTD+RbkaXfQ1cctY1odiU4cSWHZZE1yZPBuo1Qiav9O
 Y3BibykIVP7nlHDGByK43P62j+kfZQ8LHDTB9P2kvZeDdN+V4IQdmfv4e4vjTxXKn918 Rg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ueujk90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 04:10:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V4AKiS031498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 04:10:20 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 30 Jul 2023 21:10:20 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
Subject: [PATCH 4/4] soc: qcom: aoss: Tidy up qmp_send() callers
Date:   Sun, 30 Jul 2023 21:10:13 -0700
Message-ID: <20230731041013.2950307-5-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7zMnZAXaYh_3srMd2w-mcsIwO6_BuxRf
X-Proofpoint-ORIG-GUID: 7zMnZAXaYh_3srMd2w-mcsIwO6_BuxRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With qmp_send() handling variable length messages and string formatting
he callers of qmp_send() can be cleaned up to not care about these
things.

Drop the QMP_MSG_LEN sized buffers and use the message formatting, as
appropriate.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/net/ipa/ipa_power.c    |  5 +----
 drivers/remoteproc/qcom_q6v5.c |  8 +-------
 drivers/soc/qcom/qcom_aoss.c   | 14 ++++----------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 26181eeed975..0eaa7a7f3343 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -324,15 +324,12 @@ void ipa_power_retention(struct ipa *ipa, bool enable)
 {
 	static const char fmt[] = "{ class: bcm, res: ipa_pc, val: %c }";
 	struct ipa_power *power = ipa->power;
-	char buf[36];	/* Exactly enough for fmt[]; size a multiple of 4 */
 	int ret;
 
 	if (!power->qmp)
 		return;		/* Not needed on this platform */
 
-	(void)snprintf(buf, sizeof(buf), fmt, enable ? '1' : '0');
-
-	ret = qmp_send(power->qmp, buf);
+	ret = qmp_send(power->qmp, fmt, enable ? '1' : '0');
 	if (ret)
 		dev_err(power->dev, "error %d sending QMP %sable request\n",
 			ret, enable ? "en" : "dis");
diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 8b41a73fa4d1..4ee5e67a9f03 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -23,19 +23,13 @@
 
 static int q6v5_load_state_toggle(struct qcom_q6v5 *q6v5, bool enable)
 {
-	char buf[Q6V5_LOAD_STATE_MSG_LEN];
 	int ret;
 
 	if (!q6v5->qmp)
 		return 0;
 
-	ret = snprintf(buf, sizeof(buf),
-		       "{class: image, res: load_state, name: %s, val: %s}",
+	ret = qmp_send(q6v5->qmp, "{class: image, res: load_state, name: %s, val: %s}",
 		       q6v5->load_state, enable ? "on" : "off");
-
-	WARN_ON(ret >= Q6V5_LOAD_STATE_MSG_LEN);
-
-	ret = qmp_send(q6v5->qmp, buf);
 	if (ret)
 		dev_err(q6v5->dev, "failed to toggle load state\n");
 
diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index b59c8681bcfe..4a4e12c7439a 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -266,7 +266,7 @@ EXPORT_SYMBOL(qmp_send);
 
 static int qmp_qdss_clk_prepare(struct clk_hw *hw)
 {
-	static const char buf[QMP_MSG_LEN] = "{class: clock, res: qdss, val: 1}";
+	static const char *buf = "{class: clock, res: qdss, val: 1}";
 	struct qmp *qmp = container_of(hw, struct qmp, qdss_clk);
 
 	return qmp_send(qmp, buf);
@@ -274,7 +274,7 @@ static int qmp_qdss_clk_prepare(struct clk_hw *hw)
 
 static void qmp_qdss_clk_unprepare(struct clk_hw *hw)
 {
-	static const char buf[QMP_MSG_LEN] = "{class: clock, res: qdss, val: 0}";
+	static const char *buf = "{class: clock, res: qdss, val: 0}";
 	struct qmp *qmp = container_of(hw, struct qmp, qdss_clk);
 
 	qmp_send(qmp, buf);
@@ -336,7 +336,6 @@ static int qmp_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 				  unsigned long state)
 {
 	struct qmp_cooling_device *qmp_cdev = cdev->devdata;
-	char buf[QMP_MSG_LEN] = {};
 	bool cdev_state;
 	int ret;
 
@@ -346,13 +345,8 @@ static int qmp_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 	if (qmp_cdev->state == state)
 		return 0;
 
-	snprintf(buf, sizeof(buf),
-		 "{class: volt_flr, event:zero_temp, res:%s, value:%s}",
-			qmp_cdev->name,
-			cdev_state ? "on" : "off");
-
-	ret = qmp_send(qmp_cdev->qmp, buf);
-
+	ret = qmp_send(qmp_cdev->qmp, "{class: volt_flr, event:zero_temp, res:%s, value:%s}",
+		       qmp_cdev->name, cdev_state ? "on" : "off");
 	if (!ret)
 		qmp_cdev->state = cdev_state;
 
-- 
2.25.1

