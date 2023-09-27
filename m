Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5798D7AFC19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjI0Ha6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjI0Haz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:30:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE953BF;
        Wed, 27 Sep 2023 00:30:54 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R4D74d028176;
        Wed, 27 Sep 2023 07:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=3uH8tkNO63y+IIorgBzPxHyBrMidEpZshNsVgVuQAgs=;
 b=cO8gEkETKZaDNBXKinaCowNAa+dpyB/HzIZu1dnoOXuE/yOQEKnp5aePjQG/WTMyW8GY
 hrmYviWGtabEuxkSL77wUzQtKb97asvxSuGp8dPLtB7KlkZlIMI+zYQpTjW0zvBKAM2S
 LOAEcJ3J9OgokuvCqCAhl/R+oVweAqeLyd6YL6IWIx1y1/gK/0i9vdfp+v7VrlI2jhKB
 HZ52o1s1yzJCxEYUmTQC9P39aVq0IpKWCneH6/XE+I+3wASaMWZ1M45LEPRdhiVzrM7J
 WLwAV8qhfzuRtvrAXH1MsaSTi4l9wiBbyR+gV/oPEKUTsFg9ZvC4JDnK+B0Bo6YvMfYZ 6Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc179hv2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 07:30:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R7UjoB024716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 07:30:45 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 27 Sep 2023 00:30:41 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Ivan Orlov <ivan.orlov0322@gmail.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v5] usb: gadget: udc: Handle gadget_connect failure during bind operation
Date:   Wed, 27 Sep 2023 13:00:27 +0530
Message-ID: <20230927073027.27952-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9VRe691i13mLZFHa-NumTPlkrc7PHs9Y
X-Proofpoint-ORIG-GUID: 9VRe691i13mLZFHa-NumTPlkrc7PHs9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=996
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event gadget_connect call (which invokes pullup) fails,
propagate the error to udc bind operation which in turn sends the
error to configfs. The userspace can then retry enumeration if
it chooses to.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Changes in v5: Addressed proper unlocking of control_lock mutex

 drivers/usb/gadget/udc/core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 7d49d8a0b00c..824fe64e078a 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1125,12 +1125,12 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 /* ------------------------------------------------------------------------- */
 
 /* Acquire connect_lock before calling this function. */
-static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
+static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
 {
 	if (udc->vbus)
-		usb_gadget_connect_locked(udc->gadget);
+		return usb_gadget_connect_locked(udc->gadget);
 	else
-		usb_gadget_disconnect_locked(udc->gadget);
+		return usb_gadget_disconnect_locked(udc->gadget);
 }
 
 static void vbus_event_work(struct work_struct *work)
@@ -1604,12 +1604,23 @@ static int gadget_bind_driver(struct device *dev)
 	}
 	usb_gadget_enable_async_callbacks(udc);
 	udc->allow_connect = true;
-	usb_udc_connect_control_locked(udc);
+	ret = usb_udc_connect_control_locked(udc);
+	if (ret)
+		goto err_connect_control;
+
 	mutex_unlock(&udc->connect_lock);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
 
+ err_connect_control:
+	udc->allow_connect = false;
+	usb_gadget_disable_async_callbacks(udc);
+	if (gadget->irq)
+		synchronize_irq(gadget->irq);
+	usb_gadget_udc_stop_locked(udc);
+	mutex_unlock(&udc->connect_lock);
+
  err_start:
 	driver->unbind(udc->gadget);
 
-- 
2.42.0

