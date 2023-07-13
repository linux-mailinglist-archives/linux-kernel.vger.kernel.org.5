Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D363751691
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjGMC6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGMC6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:58:10 -0400
X-Greylist: delayed 370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 19:58:08 PDT
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com [115.236.118.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7C6B4;
        Wed, 12 Jul 2023 19:58:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11874.qiye.163.com (Hmail) with ESMTPA id 65BD03C03B3;
        Thu, 13 Jul 2023 10:51:53 +0800 (CST)
From:   William Wu <william.wu@rock-chips.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        william.wu@rock-chips.com, frank.wang@rock-chips.com,
        jianwei.zheng@rock-chips.com, yangbin@rock-chips.com
Subject: [PATCH] usb: dwc3: gadget: Properly handle miss isoc event
Date:   Thu, 13 Jul 2023 10:51:49 +0800
Message-Id: <20230713025149.24276-1-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkJLHlYfSRhMTExLShpIThlVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLQ0hJVUpLS1VLWQ
        Y+
X-HM-Tid: 0a894d29837a2eb0kusn65bd03c03b3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQg6Szo6SD1OOR5PQxkCOAoC
        NBAKCQpVSlVKTUNCSUpNTEpPSUxNVTMWGhIXVQwSFxcSGhZVDA47CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTkJMNwY+
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If miss isoc event happens, the current code just set
the req status to -EXDEV and giveback the req to the usb
gadget driver, and then stop the active transfer with the
cmd DWC3_DEPCMD_ENDTRANSFER and wait for a XferNotReady
event to restart a transfer again. However, for isoc
ep in transfer, it cause to lost the isoc data of the
req.

This patch moves the miss isoc req to pending_list in
order to restart transfer immediately instead of give
back the req to the usb gadget driver.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 drivers/usb/dwc3/gadget.c | 47 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/gadget.h | 16 +++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5fd067151fbf..ef295746b241 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3454,6 +3454,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event,
 		struct dwc3_request *req, int status)
 {
+	struct dwc3 *dwc = dep->dwc;
 	int request_status;
 	int ret;
 
@@ -3475,6 +3476,28 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 		req->needs_extra_trb = false;
 	}
 
+	/*
+	 * If MISS ISOC happens, we need to move the req from started_list
+	 * to cancelled_list, then unmap the req and clear the HWO of trb.
+	 * Later in the dwc3_gadget_endpoint_trbs_complete(), it will move
+	 * the req from the cancelled_list to the pending_list, and restart
+	 * the req for isoc transfer.
+	 */
+	if (status == -EXDEV && usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+		req->remaining = 0;
+		req->needs_extra_trb = false;
+		dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
+		if (req->trb) {
+			usb_gadget_unmap_request_by_dev(dwc->sysdev,
+							&req->request,
+							req->direction);
+			req->trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+			req->trb = NULL;
+		}
+		ret = 0;
+		goto out;
+	}
+
 	/*
 	 * The event status only reflects the status of the TRB with IOC set.
 	 * For the requests that don't set interrupt on completion, the driver
@@ -3564,6 +3587,7 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event, int status)
 {
 	struct dwc3		*dwc = dep->dwc;
+	struct dwc3_request	*req, *tmp;
 	bool			no_started_trb = true;
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
@@ -3574,6 +3598,29 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	if (!dep->endpoint.desc)
 		return no_started_trb;
 
+	/*
+	 * If MISS ISOC happens, we need to do the following three steps
+	 * to restart the reqs in the cancelled_list and pending_list
+	 * in order.
+	 * Step1. Move all the reqs from pending_list to the tail of
+	 *        cancelled_list.
+	 * Step2. Move all the reqs from cancelled_list to the tail
+	 *        of pending_list.
+	 * Step3. Stop and restart an isoc transfer.
+	 */
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) && status == -EXDEV &&
+	    !list_empty(&dep->cancelled_list) &&
+	    !list_empty(&dep->pending_list)) {
+		list_for_each_entry_safe(req, tmp, &dep->pending_list, list)
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
+	}
+
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) && status == -EXDEV &&
+	    !list_empty(&dep->cancelled_list)) {
+		list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list)
+			dwc3_gadget_move_queued_request(req);
+	}
+
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 		list_empty(&dep->started_list) &&
 		(list_empty(&dep->pending_list) || status == -EXDEV))
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 55a56cf67d73..242426b67798 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -104,6 +104,22 @@ static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req,
 	list_move_tail(&req->list, &dep->cancelled_list);
 }
 
+/**
+ * dwc3_gadget_move_queued_request - move @req to the pending_list
+ * @req: the request to be moved
+ *
+ * Caller should take care of locking. This function will move @req from its
+ * current list to the endpoint's pending_list.
+ *
+ */
+static inline void dwc3_gadget_move_queued_request(struct dwc3_request *req)
+{
+	struct dwc3_ep          *dep = req->dep;
+
+	req->status = DWC3_REQUEST_STATUS_QUEUED;
+	list_move_tail(&req->list, &dep->pending_list);
+}
+
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status);
 
-- 
2.17.1

