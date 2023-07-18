Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EDA7577DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGRJZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjGRJZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:25:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953A310DF;
        Tue, 18 Jul 2023 02:25:30 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I6ki2W011157;
        Tue, 18 Jul 2023 09:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=2JI/ceV/+gBheTQl8ppCWHbt7J8E80oqaoct7rSb0T0=;
 b=CIpMAmCKOzZ2t930Wl0YI1FPoTn6hN7x3YfCKFzR4ESiJZ2lyMunB5Tj7wktfTL18QN7
 7TGqdAI4kgI6jBgN64/HHcM9HGq4eOcSXSyDiGsyANQKn6Gjhg7C22rFoaggpAeOpYIG
 KKss4iEsvLxevDFi+JtL5EhHUYiGgFi3ExVNImLxHALz42rp4t82kIh/gYbK7gRpqU5U
 e+ZWJDPArQ1bliTbNbhuwlQvvhqhgVEhsnnWGWUz8tNHS0Qj7MXzABYiln+5p/MJFJsX
 IgJWnkwXqtThuLrv9ue3SBhHLKdmLbV/BCd05VUKmtWrLcb5lriDpb7BL74opowzdSki MQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwnrrgb63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 09:25:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I9P1am025820
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 09:25:01 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 02:24:58 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee@kernel.org>, <pavel@ucw.cz>, <krzysztof.kozlowski@linaro.org>,
        "Fenglin Wu" <quic_fenglinw@quicinc.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Dylan Van Assche" <me@dylanvanassche.be>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Tom Rix <trix@redhat.com>, <linux-leds@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>
Subject: [PATCH v1] led: flash: various minor fixes for leds-qcom-flash driver
Date:   Tue, 18 Jul 2023 17:24:28 +0800
Message-ID: <20230718092439.2482320-1-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2E2T8EoQIN0PnmIJGpKIZYC5febABgEr
X-Proofpoint-ORIG-GUID: 2E2T8EoQIN0PnmIJGpKIZYC5febABgEr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=772 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the driver to address following minor issues:
 - Add a sentence in Kconfig to explain the driver can be compiled
   as a module
 - strobe off the LED channel before setting flash current to prevent
   the flash LED being lit with an incorrect brightness if it was
   already active in torch mode
 - put the child node if register any flash LED device failed.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/leds/flash/Kconfig           | 2 ++
 drivers/leds/flash/leds-qcom-flash.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
index 4ed2efc65434..4e08dbc05709 100644
--- a/drivers/leds/flash/Kconfig
+++ b/drivers/leds/flash/Kconfig
@@ -89,6 +89,8 @@ config LEDS_QCOM_FLASH
 	  the total LED current will be split symmetrically on each channel and
 	  they will be enabled/disabled at the same time.
 
+	  This driver can be built as a module, it will be called "leds-qcom-flash".
+
 config LEDS_RT4505
 	tristate "LED support for RT4505 flashlight controller"
 	depends on I2C && OF
diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index b089ca1a1901..a73d3ea5c97a 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -309,6 +309,10 @@ static int qcom_flash_strobe_set(struct led_classdev_flash *fled_cdev, bool stat
 	struct qcom_flash_led *led = flcdev_to_qcom_fled(fled_cdev);
 	int rc;
 
+	rc = set_flash_strobe(led, SW_STROBE, false);
+	if (rc)
+		return rc;
+
 	rc = set_flash_current(led, led->flash_current_ma, FLASH_MODE);
 	if (rc)
 		return rc;
@@ -745,6 +749,7 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 	return 0;
 
 release:
+	fwnode_handle_put(child);
 	while (flash_data->v4l2_flash[flash_data->leds_count] && flash_data->leds_count)
 		v4l2_flash_release(flash_data->v4l2_flash[flash_data->leds_count--]);
 	return rc;
-- 
2.25.1

