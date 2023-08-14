Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0332C77C00A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjHNSvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjHNSu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:50:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB79510F7;
        Mon, 14 Aug 2023 11:50:55 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E8DjFW015513;
        Mon, 14 Aug 2023 18:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=jVbe2XeCWv7UaQVqT4HDHH912Y0qguYXXF0TNt6HQeI=;
 b=mr+fa1KFwi7qFydOxAXZAosotZ7Xp6Rt/7QMRGOTWFUDjNuMAqCVSFLviGnGmHA4Dz8+
 H7n1+wdvCphqm6Bz0lRet9JL78jyIgi+MJUhLq2wvK71SoW8+Wb3SGz4blAYaa+asg5j
 c8KlWFeiJ4gYOarkcSdxxyY8HN315cvwxtdramfkajrX9Ir7pz8eGk33+apEQW8NkDF8
 KonzgW6TgX0PCpEQhxK+0XFl8LnR6Ql8fQBDxS1+T+cpxcbKQPNrnoeF/AdL1nOQlqGC
 5rO8b0UOoBMJuPBh+BMDTGx3w9c60VEVtQi2FZc0hb8MV95P49U6fhwR6+9hBmLA09yL PQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3tymm7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:50:50 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37EIondE016195;
        Mon, 14 Aug 2023 18:50:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 3se35kvwe7-1;
        Mon, 14 Aug 2023 18:50:49 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EIom7W016183;
        Mon, 14 Aug 2023 18:50:48 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.27])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 37EIomHI016181;
        Mon, 14 Aug 2023 18:50:48 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 464172)
        id B54F65005B0; Mon, 14 Aug 2023 11:50:48 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        rogerq@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v4 1/3] usb: function: u_ether: Handle rx requests during suspend/resume
Date:   Mon, 14 Aug 2023 11:50:41 -0700
Message-Id: <20230814185043.9252-2-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814185043.9252-1-quic_eserrao@quicinc.com>
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5hTfsHOA-UkMoy9HBk4Ja21IklaRCOL_
X-Proofpoint-ORIG-GUID: 5hTfsHOA-UkMoy9HBk4Ja21IklaRCOL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=914 mlxscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140174
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UDCs might have a vote against runtime suspend if there is any
request queued by the function driver. This would block the UDC driver
to enter runtime suspend state when the host sends bus suspend
notification. While tx requests get dequeued after completion, rx
requests always remain queued for the next OUT data to be handled. Since
during bus suspend scenario there are no active OUT transfers we can
dequeue these requests when the function driver suspend callback gets
called and queue them back during resume callback. Implement this
mechanism by adding a new list for queued requests.

Also move the gether_wakeup_host API to work queue context to better
align with the remote wakeup op's synchronous operation.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/function/u_ether.c | 47 ++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index a366abb45623..107677b7656f 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -62,7 +62,7 @@ struct eth_dev {
 	struct usb_gadget	*gadget;
 
 	spinlock_t		req_lock;	/* guard {rx,tx}_reqs */
-	struct list_head	tx_reqs, rx_reqs;
+	struct list_head	tx_reqs, rx_reqs, rx_queued_reqs;
 	atomic_t		tx_qlen;
 
 	struct sk_buff_head	rx_frames;
@@ -75,7 +75,7 @@ struct eth_dev {
 						struct sk_buff *skb,
 						struct sk_buff_head *list);
 
-	struct work_struct	work;
+	struct work_struct	work, wakeup_work;
 
 	unsigned long		todo;
 #define	WORK_RX_MEMORY		0
@@ -213,7 +213,7 @@ rx_submit(struct eth_dev *dev, struct usb_request *req, gfp_t gfp_flags)
 		if (skb)
 			dev_kfree_skb_any(skb);
 		spin_lock_irqsave(&dev->req_lock, flags);
-		list_add(&req->list, &dev->rx_reqs);
+		list_move_tail(&req->list, &dev->rx_reqs);
 		spin_unlock_irqrestore(&dev->req_lock, flags);
 	}
 	return retval;
@@ -303,7 +303,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 	if (!netif_running(dev->net)) {
 clean:
 		spin_lock(&dev->req_lock);
-		list_add(&req->list, &dev->rx_reqs);
+		list_move_tail(&req->list, &dev->rx_reqs);
 		spin_unlock(&dev->req_lock);
 		req = NULL;
 	}
@@ -378,7 +378,7 @@ static void rx_fill(struct eth_dev *dev, gfp_t gfp_flags)
 	spin_lock_irqsave(&dev->req_lock, flags);
 	while (!list_empty(&dev->rx_reqs)) {
 		req = list_first_entry(&dev->rx_reqs, struct usb_request, list);
-		list_del_init(&req->list);
+		list_move_tail(&req->list, &dev->rx_queued_reqs);
 		spin_unlock_irqrestore(&dev->req_lock, flags);
 
 		if (rx_submit(dev, req, gfp_flags) < 0) {
@@ -438,9 +438,11 @@ static inline int is_promisc(u16 cdc_filter)
 	return cdc_filter & USB_CDC_PACKET_TYPE_PROMISCUOUS;
 }
 
-static int ether_wakeup_host(struct gether *port)
+static void ether_wakeup_work(struct work_struct *w)
 {
 	int			ret;
+	struct eth_dev		*dev = container_of(w, struct eth_dev, wakeup_work);
+	struct gether		*port = dev->port_usb;
 	struct usb_function	*func = &port->func;
 	struct usb_gadget	*gadget = func->config->cdev->gadget;
 
@@ -449,7 +451,8 @@ static int ether_wakeup_host(struct gether *port)
 	else
 		ret = usb_gadget_wakeup(gadget);
 
-	return ret;
+	if (ret)
+		DBG(dev, "failed to trigger wakeup:%d\n", ret);
 }
 
 static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
@@ -476,7 +479,7 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
 		DBG(dev, "Port suspended. Triggering wakeup\n");
 		netif_stop_queue(net);
 		spin_unlock_irqrestore(&dev->lock, flags);
-		ether_wakeup_host(dev->port_usb);
+		schedule_work(&dev->wakeup_work);
 		return NETDEV_TX_BUSY;
 	}
 
@@ -754,8 +757,10 @@ struct eth_dev *gether_setup_name(struct usb_gadget *g,
 	spin_lock_init(&dev->lock);
 	spin_lock_init(&dev->req_lock);
 	INIT_WORK(&dev->work, eth_work);
+	INIT_WORK(&dev->wakeup_work, ether_wakeup_work);
 	INIT_LIST_HEAD(&dev->tx_reqs);
 	INIT_LIST_HEAD(&dev->rx_reqs);
+	INIT_LIST_HEAD(&dev->rx_queued_reqs);
 
 	skb_queue_head_init(&dev->rx_frames);
 
@@ -825,8 +830,10 @@ struct net_device *gether_setup_name_default(const char *netname)
 	spin_lock_init(&dev->lock);
 	spin_lock_init(&dev->req_lock);
 	INIT_WORK(&dev->work, eth_work);
+	INIT_WORK(&dev->wakeup_work, ether_wakeup_work);
 	INIT_LIST_HEAD(&dev->tx_reqs);
 	INIT_LIST_HEAD(&dev->rx_reqs);
+	INIT_LIST_HEAD(&dev->rx_queued_reqs);
 
 	skb_queue_head_init(&dev->rx_frames);
 
@@ -1043,6 +1050,7 @@ EXPORT_SYMBOL_GPL(gether_set_ifname);
 void gether_suspend(struct gether *link)
 {
 	struct eth_dev *dev = link->ioport;
+	struct usb_request *req;
 	unsigned long flags;
 
 	if (!dev)
@@ -1053,9 +1061,20 @@ void gether_suspend(struct gether *link)
 		 * There is a transfer in progress. So we trigger a remote
 		 * wakeup to inform the host.
 		 */
-		ether_wakeup_host(dev->port_usb);
+		schedule_work(&dev->wakeup_work);
 		return;
 	}
+	/* Dequeue the submitted requests. */
+	spin_lock(&dev->req_lock);
+	while (!list_empty(&dev->rx_queued_reqs)) {
+		req = list_last_entry(&dev->rx_queued_reqs, struct usb_request, list);
+		list_move_tail(&req->list, &dev->rx_reqs);
+		spin_unlock(&dev->req_lock);
+		usb_ep_dequeue(dev->port_usb->out_ep, req);
+		spin_lock(&dev->req_lock);
+	}
+	spin_unlock(&dev->req_lock);
+
 	spin_lock_irqsave(&dev->lock, flags);
 	link->is_suspend = true;
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -1070,6 +1089,7 @@ void gether_resume(struct gether *link)
 	if (!dev)
 		return;
 
+	defer_kevent(dev, WORK_RX_MEMORY);
 	if (netif_queue_stopped(dev->net))
 		netif_start_queue(dev->net);
 
@@ -1231,6 +1251,15 @@ void gether_disconnect(struct gether *link)
 		usb_ep_free_request(link->out_ep, req);
 		spin_lock(&dev->req_lock);
 	}
+
+	while (!list_empty(&dev->rx_queued_reqs)) {
+		req = list_first_entry(&dev->rx_queued_reqs, struct usb_request, list);
+		list_del(&req->list);
+
+		spin_unlock(&dev->req_lock);
+		usb_ep_free_request(link->out_ep, req);
+		spin_lock(&dev->req_lock);
+	}
 	spin_unlock(&dev->req_lock);
 	link->out_ep->desc = NULL;
 
-- 
2.17.1

