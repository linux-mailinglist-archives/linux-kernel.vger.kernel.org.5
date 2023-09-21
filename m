Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425CE7AA434
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjIUWCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjIUWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:02:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A48271E;
        Thu, 21 Sep 2023 14:49:35 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LLGdLs020622;
        Thu, 21 Sep 2023 21:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ZseVt8TpXNsPnD9gXvZiESwKDgOnEM+cyJSdOPfVtyQ=;
 b=lBolqkkkqztymt1dXfYc7FKe1h92tjLFV4yU0xSQan9awKeycOYYD5dEepjhSmq/FpPL
 Wwfo46yBtn9gImVbw5F1sVTZ4ErzRW/KDZd3wUqQisKnzZJSMzmmci8qCO1wlc8C0Rf+
 jdbJi8umOzz+cRAwB34AUPEefZed5VgFqdprijWxm+rHlBJzlsh5zRBTlIowFdFJ3MZa
 G8hH7yyLyjXvyb5S2c2dx118dzPC/39l7C41v+B8zW+fMK1kI7PFddkK8H9Ex44zd+zn
 Mf9Prm2mwIH1jLTiXFvHy9xwl41PfeK2FZVN1w8FJ1NVsgn+1jQjGzLt6Gg5jgaIVOTy ZA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u0hgbuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:48:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LLmrKo031031
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:48:53 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 21 Sep 2023 14:48:53 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v7 02/33] xhci: add helper to stop endpoint and wait for completion
Date:   Thu, 21 Sep 2023 14:48:12 -0700
Message-ID: <20230921214843.18450-3-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921214843.18450-1-quic_wcheng@quicinc.com>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LgI0xRcvfOVAlYKOfwKnz2s5pci5exze
X-Proofpoint-GUID: LgI0xRcvfOVAlYKOfwKnz2s5pci5exze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Expose xhci_stop_endpoint_sync() which is a synchronous variant of
xhci_queue_stop_endpoint().  This is useful for client drivers that are
using the secondary interrupters, and need to stop/clean up the current
session.  The stop endpoint command handler will also take care of cleaning
up the ring.

Modifications to repurpose the new API into existing stop endpoint
sequences was implemented by Wesley Cheng.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-hub.c | 29 +++---------------
 drivers/usb/host/xhci.c     | 60 +++++++++++++++++++++++++++----------
 drivers/usb/host/xhci.h     |  2 ++
 3 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 0054d02239e2..2f7309bdc922 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -489,7 +489,6 @@ EXPORT_SYMBOL_GPL(xhci_find_slot_id_by_port);
 static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
 {
 	struct xhci_virt_device *virt_dev;
-	struct xhci_command *cmd;
 	unsigned long flags;
 	int ret;
 	int i;
@@ -501,10 +500,6 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
 
 	trace_xhci_stop_device(virt_dev);
 
-	cmd = xhci_alloc_command(xhci, true, GFP_NOIO);
-	if (!cmd)
-		return -ENOMEM;
-
 	spin_lock_irqsave(&xhci->lock, flags);
 	for (i = LAST_EP_INDEX; i > 0; i--) {
 		if (virt_dev->eps[i].ring && virt_dev->eps[i].ring->dequeue) {
@@ -521,7 +516,7 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
 			if (!command) {
 				spin_unlock_irqrestore(&xhci->lock, flags);
 				ret = -ENOMEM;
-				goto cmd_cleanup;
+				goto out;
 			}
 
 			ret = xhci_queue_stop_endpoint(xhci, command, slot_id,
@@ -529,30 +524,14 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
 			if (ret) {
 				spin_unlock_irqrestore(&xhci->lock, flags);
 				xhci_free_command(xhci, command);
-				goto cmd_cleanup;
+				goto out;
 			}
 		}
 	}
-	ret = xhci_queue_stop_endpoint(xhci, cmd, slot_id, 0, suspend);
-	if (ret) {
-		spin_unlock_irqrestore(&xhci->lock, flags);
-		goto cmd_cleanup;
-	}
-
-	xhci_ring_cmd_db(xhci);
 	spin_unlock_irqrestore(&xhci->lock, flags);
+	ret = xhci_stop_endpoint_sync(xhci, &virt_dev->eps[0], suspend);
 
-	/* Wait for last stop endpoint command to finish */
-	wait_for_completion(cmd->completion);
-
-	if (cmd->status == COMP_COMMAND_ABORTED ||
-	    cmd->status == COMP_COMMAND_RING_STOPPED) {
-		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
-		ret = -ETIME;
-	}
-
-cmd_cleanup:
-	xhci_free_command(xhci, cmd);
+out:
 	return ret;
 }
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3fd2b58ee1d3..163d533d6200 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2758,6 +2758,46 @@ static int xhci_reserve_bandwidth(struct xhci_hcd *xhci,
 	return -ENOMEM;
 }
 
+/*
+ * Synchronous XHCI stop endpoint helper.  Issues the stop endpoint command and
+ * waits for the command completion before returning.
+ */
+int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep *ep, int suspend)
+{
+	struct xhci_command *command;
+	unsigned long flags;
+	int ret;
+
+	command = xhci_alloc_command(xhci, true, GFP_KERNEL);
+	if (!command)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&xhci->lock, flags);
+	ret = xhci_queue_stop_endpoint(xhci, command, ep->vdev->slot_id,
+				       ep->ep_index, suspend);
+	if (ret < 0) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		goto out;
+	}
+
+	xhci_ring_cmd_db(xhci);
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
+	ret = wait_for_completion_timeout(command->completion, msecs_to_jiffies(3000));
+	if (!ret)
+		xhci_warn(xhci, "%s: Unable to stop endpoint.\n",
+				__func__);
+
+	if (command->status == COMP_COMMAND_ABORTED ||
+	    command->status == COMP_COMMAND_RING_STOPPED) {
+		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
+		ret = -ETIME;
+	}
+out:
+	xhci_free_command(xhci, command);
+
+	return ret;
+}
 
 /* Issue a configure endpoint command or evaluate context command
  * and wait for it to finish.
@@ -3078,7 +3118,7 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 	struct xhci_virt_device *vdev;
 	struct xhci_virt_ep *ep;
 	struct xhci_input_control_ctx *ctrl_ctx;
-	struct xhci_command *stop_cmd, *cfg_cmd;
+	struct xhci_command *cfg_cmd;
 	unsigned int ep_index;
 	unsigned long flags;
 	u32 ep_flag;
@@ -3118,10 +3158,6 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 	if (ep_flag == SLOT_FLAG || ep_flag == EP0_FLAG)
 		return;
 
-	stop_cmd = xhci_alloc_command(xhci, true, GFP_NOWAIT);
-	if (!stop_cmd)
-		return;
-
 	cfg_cmd = xhci_alloc_command_with_ctx(xhci, true, GFP_NOWAIT);
 	if (!cfg_cmd)
 		goto cleanup;
@@ -3144,23 +3180,16 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 		goto cleanup;
 	}
 
-	err = xhci_queue_stop_endpoint(xhci, stop_cmd, udev->slot_id,
-					ep_index, 0);
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
+	err = xhci_stop_endpoint_sync(xhci, ep, 0);
 	if (err < 0) {
-		spin_unlock_irqrestore(&xhci->lock, flags);
-		xhci_free_command(xhci, cfg_cmd);
 		xhci_dbg(xhci, "%s: Failed to queue stop ep command, %d ",
 				__func__, err);
 		goto cleanup;
 	}
 
-	xhci_ring_cmd_db(xhci);
-	spin_unlock_irqrestore(&xhci->lock, flags);
-
-	wait_for_completion(stop_cmd->completion);
-
 	spin_lock_irqsave(&xhci->lock, flags);
-
 	/* config ep command clears toggle if add and drop ep flags are set */
 	ctrl_ctx = xhci_get_input_control_ctx(cfg_cmd->in_ctx);
 	if (!ctrl_ctx) {
@@ -3192,7 +3221,6 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
 	xhci_free_command(xhci, cfg_cmd);
 cleanup:
-	xhci_free_command(xhci, stop_cmd);
 	spin_lock_irqsave(&xhci->lock, flags);
 	if (ep->ep_state & EP_SOFT_CLEAR_TOGGLE)
 		ep->ep_state &= ~EP_SOFT_CLEAR_TOGGLE;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index d706a27ec0a3..898b6434dc27 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2125,6 +2125,8 @@ void xhci_ring_doorbell_for_active_rings(struct xhci_hcd *xhci,
 void xhci_cleanup_command_queue(struct xhci_hcd *xhci);
 void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring);
 unsigned int count_trbs(u64 addr, u64 len);
+int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+			    int suspend);
 
 /* xHCI roothub code */
 void xhci_set_link_state(struct xhci_hcd *xhci, struct xhci_port *port,
