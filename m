Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7C7AB154
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjIVLvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjIVLvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:51:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CD6102;
        Fri, 22 Sep 2023 04:51:31 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M7HcPL016610;
        Fri, 22 Sep 2023 11:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=XUr9CdM22EqHFRwFoAZUCft2/QfUI9WwnW3zyddH7Hc=;
 b=UZIrd+jGAZutFecl3CtQqmrIkqvs6mklLwr6Wdsd4WNfLzRhdQFBh8Ahxqttvphbz0Z0
 xMRQQ4rAp55cg71AmaR4LBPFZED6wbwpGw7nIkteZzi205TWFbdqMUVVnmaiW/B/qscw
 kBgQ4xaGadtl4hbcpeBO+Hrw+96+RfD/nuY1uLpD8HskJhpQ/9Gbpapu7PVU5WgT6euj
 6ujuFEw+N1n00XOkd58j8niHX5NrKYgM8cTAEv9cITNuT/QsPXvjdLmjdW2QTsH7jtj3
 felX/c8vUc9L/ep1n2/OGY9Klgr2XQxSHSWnYRa3/m/SejRxIFXnRhAiXQk/Kh+3XwzF yg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u5n1tjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:21 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38MBpIbA027886;
        Fri, 22 Sep 2023 11:51:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3t55emancb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MBpH7G027860;
        Fri, 22 Sep 2023 11:51:17 GMT
Received: from win-platform-upstream01.qualcomm.com (win-platform-upstream01.qualcomm.com [10.242.182.84])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 38MBpHsO027854
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:51:17 +0000
Received: by win-platform-upstream01.qualcomm.com (Postfix, from userid 330701)
        id 8AA1098F; Fri, 22 Sep 2023 17:21:16 +0530 (IST)
From:   Sricharan R <srichara@win-platform-upstream01.qualcomm.com>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        quic_srichara@quicinc.com
Subject: [PATCH V3 2/4] thermal/drivers/qcom: Add new feat for soc without rpm
Date:   Fri, 22 Sep 2023 17:21:14 +0530
Message-Id: <20230922115116.2748804-3-srichara@win-platform-upstream01.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GNfKdo1sSU0h0VlEBDH8hy78gOdFM90G
X-Proofpoint-GUID: GNfKdo1sSU0h0VlEBDH8hy78gOdFM90G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_10,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1034 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

In IPQ5018, Tsens IP doesn't have RPM. Hence the early init to
enable tsens would not be done. So add a flag for that in feat
and skip enable checks. Without this, tsens probe fails.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v3] Added Dmitry's Reviewed tag

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

