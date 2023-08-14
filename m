Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9877C00E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjHNSv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjHNSu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:50:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58971702;
        Mon, 14 Aug 2023 11:50:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EFfX9J001504;
        Mon, 14 Aug 2023 18:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=0wudGJldtlwunr98sGpUf9GmmUa3rnET/QHaHz1GKjU=;
 b=gx/OQbrptJN5JkPxdOJGDiy+Trh69EeXgyXL0TDshJMc9KElQpEDJP/+UA3zUGVowQwX
 cwSOvak9pL7PiLCyCTWi44jsOvHXWyO2cRq50xyV+JEvyPpypOOX6DNw1MH0AP+cQtHY
 1qYSTyBCtUb/0ap+IBbTouB3SOJ7v9DzF7bDpwhLvO1vCi00itBVRHSqAhwfI2Gy1N7G
 2udx5Yt+yhq+fe2h19jm3ujpLUj9rWxYFbvmXvGPRZ9badoagR1lf2vCw5LzDpdQgVOl
 ftkz+PS/6mCIOQqpDJegUUfXPlPn3EJObq5i8gXsgopSB0+hbN6mGZxySBev2onz3jW0 dA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3j94mvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:50:50 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37EImhtU006572;
        Mon, 14 Aug 2023 18:50:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 3se35kvvjh-1;
        Mon, 14 Aug 2023 18:50:49 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EIon1K009287;
        Mon, 14 Aug 2023 18:50:49 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.27])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 37EIomYo009282;
        Mon, 14 Aug 2023 18:50:48 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 464172)
        id BA37C5005B2; Mon, 14 Aug 2023 11:50:48 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        rogerq@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v4 3/3] usb: dwc3: Modify runtime pm ops to handle bus suspend
Date:   Mon, 14 Aug 2023 11:50:43 -0700
Message-Id: <20230814185043.9252-4-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814185043.9252-1-quic_eserrao@quicinc.com>
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1NVKeTNAtkk-FSmaW215qspSanrIqpjc
X-Proofpoint-GUID: 1NVKeTNAtkk-FSmaW215qspSanrIqpjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=892 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140174
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation blocks the runtime pm operations when cable
is connected. This would block dwc3 to enter a low power state during
bus suspend scenario. Modify the runtime pm ops to handle bus suspend
case for such platforms where the controller low power mode entry/exit
is handled by the glue driver. This enablement is controlled through a
dt property and platforms capable of detecting bus resume can benefit
from this feature. Also modify the remote wakeup operations to trigger
runtime resume before sending wakeup signal.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/dwc3/core.c   | 28 ++++++++++++++++++++++++++--
 drivers/usb/dwc3/core.h   |  3 +++
 drivers/usb/dwc3/gadget.c | 32 +++++++++++++++++++++++++-------
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..9bfd9bb18caf 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1518,6 +1518,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
+	dwc->runtime_suspend_on_usb_suspend = device_property_read_bool(dev,
+				"snps,runtime-suspend-on-usb-suspend");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -2029,6 +2032,9 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
+		/* runtime resume on bus resume scenario */
+		if (PMSG_IS_AUTO(msg) && dwc->connected)
+			break;
 		ret = dwc3_core_init_for_resume(dwc);
 		if (ret)
 			return ret;
@@ -2090,8 +2096,13 @@ static int dwc3_runtime_checks(struct dwc3 *dwc)
 {
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (dwc->connected)
+		if (dwc->connected) {
+			/* bus suspend scenario */
+			if (dwc->runtime_suspend_on_usb_suspend &&
+			    dwc->suspended)
+				break;
 			return -EBUSY;
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 	default:
@@ -2107,9 +2118,22 @@ static int dwc3_runtime_suspend(struct device *dev)
 	struct dwc3     *dwc = dev_get_drvdata(dev);
 	int		ret;
 
-	if (dwc3_runtime_checks(dwc))
+	ret = dwc3_runtime_checks(dwc);
+	if (ret)
 		return -EBUSY;
 
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		/* bus suspend case */
+		if (!ret && dwc->connected)
+			return 0;
+		break;
+	case DWC3_GCTL_PRTCAP_HOST:
+	default:
+		/* do nothing */
+		break;
+	}
+
 	ret = dwc3_suspend_common(dwc, PMSG_AUTO_SUSPEND);
 	if (ret)
 		return ret;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a69ac67d89fe..f2f788a6b4b5 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1124,6 +1124,8 @@ struct dwc3_scratchpad_array {
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
  * @debug_root: root debugfs directory for this device to put its files in.
+ * @runtime_suspend_on_usb_suspend: true if dwc3 runtime suspend is allowed
+ *			during bus suspend scenario.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1340,6 +1342,7 @@ struct dwc3 {
 	int			last_fifo_depth;
 	int			num_ep_resized;
 	struct dentry		*debug_root;
+	bool			runtime_suspend_on_usb_suspend;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5fd067151fbf..978ce0e91164 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2401,15 +2401,21 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&dwc->lock, flags);
 	if (!dwc->gadget->wakeup_armed) {
 		dev_err(dwc->dev, "not armed for remote wakeup\n");
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		return -EINVAL;
 	}
-	ret = __dwc3_gadget_wakeup(dwc, true);
 
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0) {
+		pm_runtime_set_suspended(dwc->dev);
+		return ret;
+	}
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	ret = __dwc3_gadget_wakeup(dwc, true);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	pm_runtime_put_noidle(dwc->dev);
 
 	return ret;
 }
@@ -2428,6 +2434,12 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 		return -EINVAL;
 	}
 
+	ret = pm_runtime_resume_and_get(dwc->dev);
+	if (ret < 0) {
+		pm_runtime_set_suspended(dwc->dev);
+		return ret;
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	/*
 	 * If the link is in U3, signal for remote wakeup and wait for the
@@ -2438,6 +2450,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 		ret = __dwc3_gadget_wakeup(dwc, false);
 		if (ret) {
 			spin_unlock_irqrestore(&dwc->lock, flags);
+			pm_runtime_put_noidle(dwc->dev);
 			return -EINVAL;
 		}
 		dwc3_resume_gadget(dwc);
@@ -2452,6 +2465,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	pm_runtime_put_noidle(dwc->dev);
 
 	return ret;
 }
@@ -2732,21 +2746,23 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	/*
 	 * Avoid issuing a runtime resume if the device is already in the
 	 * suspended state during gadget disconnect.  DWC3 gadget was already
-	 * halted/stopped during runtime suspend.
+	 * halted/stopped during runtime suspend except for bus suspend case
+	 * where we would have skipped the controller halt.
 	 */
 	if (!is_on) {
 		pm_runtime_barrier(dwc->dev);
-		if (pm_runtime_suspended(dwc->dev))
+		if (pm_runtime_suspended(dwc->dev) && !dwc->connected)
 			return 0;
 	}
 
 	/*
 	 * Check the return value for successful resume, or error.  For a
 	 * successful resume, the DWC3 runtime PM resume routine will handle
-	 * the run stop sequence, so avoid duplicate operations here.
+	 * the run stop sequence except for bus resume case, so avoid
+	 * duplicate operations here.
 	 */
 	ret = pm_runtime_get_sync(dwc->dev);
-	if (!ret || ret < 0) {
+	if ((!ret && !dwc->connected) || ret < 0) {
 		pm_runtime_put(dwc->dev);
 		if (ret < 0)
 			pm_runtime_set_suspended(dwc->dev);
@@ -4331,6 +4347,8 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 	}
 
 	dwc->link_state = next;
+	pm_runtime_mark_last_busy(dwc->dev);
+	pm_request_autosuspend(dwc->dev);
 }
 
 static void dwc3_gadget_interrupt(struct dwc3 *dwc,
-- 
2.17.1

