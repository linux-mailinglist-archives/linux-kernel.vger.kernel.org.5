Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D2077990A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjHKU7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjHKU7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:59:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351C110C0;
        Fri, 11 Aug 2023 13:59:04 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BKJmk4023942;
        Fri, 11 Aug 2023 20:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=lCiaswT20G+0zdcoLPjrgw5y3NJtqTw0cf7FSRz5wBA=;
 b=EOgYYW2yYUctIj90NACXMzFXsQ7Py1sSI6iVtWqpZa5kHpjxmjoVICS4DqMSex55a55S
 kkuUgwlf3e2YMyyQO9nje5w6j9oY6BG3FX7z74ytCvmp53eKmcAksdZ5wbV1KRpVqFm0
 OOL/7TijhyEejQVNsE6bXkf4QVk/YLXUKwVJK6wyJdx/74pok31rTtoM0zKC+7Q1cqvo
 483Gv4YpGO97e9c4ObI4fFp7Or4CWca5zYxr4OS31w+ri/ht6x2/u33E2RwMf/id/Scs
 nDZubYOyrNHvIJXCtj0nFhYK93wD0EsN4BE+cSXY39fDe+mT5ujzDkHXNQMqUyff5pk5 JQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yaart9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:58:53 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BKwko4018139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:58:46 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 13:58:46 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 4/4] soc: qcom: aoss: Tidy up qmp_send() callers
Date:   Fri, 11 Aug 2023 13:58:39 -0700
Message-ID: <20230811205839.727373-5-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811205839.727373-1-quic_bjorande@quicinc.com>
References: <20230811205839.727373-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VqgGFZrKrIwhV6STk7oQ0wEiRmR8CowU
X-Proofpoint-ORIG-GUID: VqgGFZrKrIwhV6STk7oQ0wEiRmR8CowU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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
index 2d8b07b22ebb..b783ce3f75a4 100644
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

