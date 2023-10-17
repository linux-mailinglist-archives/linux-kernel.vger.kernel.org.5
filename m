Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08237CC49B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbjJQNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbjJQNT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:19:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAC9198;
        Tue, 17 Oct 2023 06:19:50 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HCiLAE029249;
        Tue, 17 Oct 2023 13:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=AlcgEQhkV+CHWGIIVMx9+hfGbBgrSjeMLC+vJ2luDV4=;
 b=hTtTMYMp2TLd/LsJrkqlcYy18gI9gDFly+1vM9OonK4kLHsTlF6H1b0dPbkdNGyG0Nf6
 soj7OsdcKxoLb/bhoy/OJGsKtbuiobQ2Cdpgk8dqN8AAHo9EVuHtVKcgOGdc2mTqQ/Zy
 4N07/1cDfKTsQ9GYm3EytZmo35UdggUijspNLtVvJ9Rc+9+8pKwbWkEQLm0uLq0iDnLR
 1dYQoVirWbNnU710ErIy08U5xvgKzPI0rXUEZbgM6KWM1/k3A+r+FtCE4C6WMN/JSeg5
 ZHyFUhXNK8FFiJRld0eJiZYsEGk7ua+evQPdFdyGyoHLT5BWpSnDsrLunVs7O3xXtljt 2A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsnearqfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:19:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HDJffC031191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:19:41 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 06:19:37 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <quic_wcheng@quicinc.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC 8/8] usb: dwc3: core: Skip set_mode notification if cable is disconnected
Date:   Tue, 17 Oct 2023 18:48:51 +0530
Message-ID: <20231017131851.8299-8-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131851.8299-1-quic_kriskura@quicinc.com>
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nbexWgWYIv3y0j0BHEC-vxIxYccZY9hc
X-Proofpoint-ORIG-GUID: nbexWgWYIv3y0j0BHEC-vxIxYccZY9hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In device mode use cases, the following sequence of actions are observed:

1. Cable disconnect happens and clears qscratch HS_PHY_CTRL_REG properly
2. Disconnect event is generated and "connected" flag turns false.
3. Then the setmode notification from core goes to glue
4. Glue will set back the qscratch HS_PHY_CTRL_REG bits again.

At this point, since the cable is removed, setting qscratch bits shouldn't
affect anything. But it is observed that after setting this bits, the
controller generated Event-0x101 and Event-0x30601 (bus reset and suspend)
in order. In bus reset, we set back the "connected" flag and this blocks
suspend again.

So send set_mode call only if the cable is connected, else skip it.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/core.c | 3 ++-
 drivers/usb/dwc3/core.h | 2 ++
 drivers/usb/dwc3/drd.c  | 6 +++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b4d1d1c98dd5..6ef1e3558384 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -137,7 +137,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 	if (!desired_dr_role)
 		goto out;
 
-	dwc3_notify_set_mode(dwc, desired_dr_role);
+	if (dwc->cable_disconnected == false)
+		dwc3_notify_set_mode(dwc, desired_dr_role);
 
 	if (desired_dr_role == dwc->current_dr_role)
 		goto out;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5ed7fd5eb776..1b79c407a798 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1365,6 +1365,8 @@ struct dwc3 {
 
 	void			*glue_data;
 	const struct dwc3_glue_ops *glue_ops;
+
+	bool			cable_disconnected;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 947faeef0e4d..b3a87c40c4f1 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -446,6 +446,8 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
 	struct dwc3 *dwc = usb_role_switch_get_drvdata(sw);
 	u32 mode;
 
+	dwc->cable_disconnected = false;
+
 	switch (role) {
 	case USB_ROLE_HOST:
 		mode = DWC3_GCTL_PRTCAP_HOST;
@@ -467,8 +469,10 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
 	 * glue needs to know that we are disconnected. It must not notify
 	 * the change of mode to default mode.
 	 */
-	if (role == USB_ROLE_NONE)
+	if (role == USB_ROLE_NONE) {
+		dwc->cable_disconnected = true;
 		dwc3_notify_cable_disconnect(dwc);
+	}
 
 	dwc3_set_mode(dwc, mode);
 	return 0;
-- 
2.42.0

