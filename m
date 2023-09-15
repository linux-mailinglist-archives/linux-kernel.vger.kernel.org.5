Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F007A1E55
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjIOMQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjIOMQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:16:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C12707;
        Fri, 15 Sep 2023 05:15:57 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FCDmVi009936;
        Fri, 15 Sep 2023 12:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=lme6ZRDxQPrO96xV+duky2DYvl92jRnhpTyn74ULgZU=;
 b=GeBPCyglMJjoSHXAdrMK6/x5aEnvx2EWmQpK2sOrIG+TF+usr10PNqggJrQfAoS3AK2f
 FnJp5pfH9nerVWj4qzUR8cy0E1BAdGY10rYwl+w8fa2QYloQd3iNuEc3OQ/haqHRjSGj
 S2OF3PNKkRGUmYBq1eqUEGhel90JE0rp1cX3UAhX4Jfu4UANip8Ta/q06kz5s1TiuLKg
 TpBJMmein2f4VXgKCGC1YXzCiEJDXj2jjdi2IX131vgBKyPMnxsoV71lJoudPPS/UCNj
 SufK7UNX5L+Rg3QAdZ5AZjKEGr7mHCkJDbRwxw4wgkxMIkEjQRutHr3TfoX+WgBv3UG+ Fw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4dvqs85r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:15:48 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FCFlvQ012588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:15:47 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 05:15:41 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH V2 2/4] thermal/drivers/qcom: Add new feat for soc without rpm
Date:   Fri, 15 Sep 2023 17:45:02 +0530
Message-ID: <20230915121504.806672-3-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915121504.806672-1-quic_srichara@quicinc.com>
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LG7ag-H17pApl4lxxp3fFJg7Fp-w-dxK
X-Proofpoint-ORIG-GUID: LG7ag-H17pApl4lxxp3fFJg7Fp-w-dxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_08,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In IPQ5018, Tsens IP doesn't have RPM. Hence the early init to
enable tsens would not be done. So add a flag for that in feat
and skip enable checks. Without this, tsens probe fails.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v2] Fixed the name for new tsens_feature without rpm

 drivers/thermal/qcom/tsens.c | 2 +-
 drivers/thermal/qcom/tsens.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 98c356acfe98..0a43ccf02ec4 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -974,7 +974,7 @@ int __init init_common(struct tsens_priv *priv)
 	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
 	if (ret)
 		goto err_put_device;
-	if (!enabled) {
+	if (!enabled && !(priv->feat->ignore_enable)) {
 		dev_err(dev, "%s: device not enabled\n", __func__);
 		ret = -ENODEV;
 		goto err_put_device;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2805de1c6827..e254cd2df904 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -505,6 +505,8 @@ enum regfield_ids {
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
  * @has_watchdog: does this IP support watchdog functionality?
+ * @ignore_enable: does this IP reside in a soc that does not have rpm to
+ *                 do pre-init.
  * @max_sensors: maximum sensors supported by this version of the IP
  * @trip_min_temp: minimum trip temperature supported by this version of the IP
  * @trip_max_temp: maximum trip temperature supported by this version of the IP
@@ -516,6 +518,7 @@ struct tsens_features {
 	unsigned int adc:1;
 	unsigned int srot_split:1;
 	unsigned int has_watchdog:1;
+	unsigned int ignore_enable:1;
 	unsigned int max_sensors;
 	int trip_min_temp;
 	int trip_max_temp;
-- 
2.34.1

