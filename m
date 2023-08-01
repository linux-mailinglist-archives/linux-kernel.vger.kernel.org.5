Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EA876A899
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjHAGCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjHAGCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:02:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5944E7D;
        Mon, 31 Jul 2023 23:01:59 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3715woir026178;
        Tue, 1 Aug 2023 06:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=rSy7dPqq1OG7Y6hBJX9jb9y8LyPyQfc/Of+5x7X6wfw=;
 b=iBKwCs4ccCspmHvyG8PFYisnizgHPHKUQNzSCmCWCVZwLc2YAErXMqB229vowCiCq/6H
 DLq/yKtTDq2KBEibSp4ieEP2iNN8zl2hV2BshfVkeMHVzm7HmpMs5rAt9zLWYxkJkU0/
 n720ix46ErzmuhhmPhG0tpN32iJ/p8nL/oM43ro8IZTkaDtQq58GV+7MqvC0ojnluQAT
 GkrROlzCuTPxcfh63RsjaIAGGTrrDzrEyz0Z2rhWd0/xgpfEARMXO77sBdh0QjNMGwcK
 u7SH0ibWEN5aM8VgQmXoKcpZTIwvgrO/Jvmku++rANJBXbd1lyyCI068duM6wkDrp9N2 Ng== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6a502tpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 06:01:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37161rZ0031148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 06:01:53 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 23:01:50 -0700
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [v2] usb: common: usb-conn-gpio: Prevent bailing out if initial role is none
Date:   Tue, 1 Aug 2023 11:31:35 +0530
Message-ID: <1690869695-32018-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rL03t9C0u4CngsQgmCsE9uu27tZeobvl
X-Proofpoint-ORIG-GUID: rL03t9C0u4CngsQgmCsE9uu27tZeobvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=851 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308010055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if we bootup a device without cable connected, then
usb-conn-gpio won't call set_role() since last_role is same as
current role. This happens because during probe last_role gets
initialised to zero.

To avoid this, add a new flag initial_detection in the struct
usb_conn_info, which prevents from bailing out during initial
detection.

Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
v2: Updated the bool name to initial_detection.

 drivers/usb/common/usb-conn-gpio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 766005d..501e8bc9 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -42,6 +42,7 @@ struct usb_conn_info {
 
 	struct power_supply_desc desc;
 	struct power_supply *charger;
+	bool initial_detection;
 };
 
 /*
@@ -86,11 +87,13 @@ static void usb_conn_detect_cable(struct work_struct *work)
 	dev_dbg(info->dev, "role %s -> %s, gpios: id %d, vbus %d\n",
 		usb_role_string(info->last_role), usb_role_string(role), id, vbus);
 
-	if (info->last_role == role) {
+	if (!info->initial_detection && info->last_role == role) {
 		dev_warn(info->dev, "repeated role: %s\n", usb_role_string(role));
 		return;
 	}
 
+	info->initial_detection = false;
+
 	if (info->last_role == USB_ROLE_HOST && info->vbus)
 		regulator_disable(info->vbus);
 
@@ -258,6 +261,7 @@ static int usb_conn_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&pdev->dev, true);
 
 	/* Perform initial detection */
+	info->initial_detection = true;
 	usb_conn_queue_dwork(info, 0);
 
 	return 0;
-- 
2.7.4

