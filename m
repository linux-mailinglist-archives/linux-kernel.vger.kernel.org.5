Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899F17BBA04
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJFOMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjJFOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:12:46 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A15CAC;
        Fri,  6 Oct 2023 07:12:42 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id EFA6C52050C;
        Fri,  6 Oct 2023 16:12:39 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Fri, 6 Oct
 2023 16:12:39 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     <gregkh@linuxfoundation.org>, <s.hauer@pengutronix.de>,
        <jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_linyyuan@quicinc.com>, <paul@crapouillou.net>,
        <quic_eserrao@quicinc.com>, <erosca@de.adit-jv.com>,
        gah2hi <external.Hardik.Gajjar@de.bosch.com>
Subject: [PATCH] usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach
Date:   Fri, 6 Oct 2023 16:12:31 +0200
Message-ID: <20231006141231.7220-1-hgajjar@de.adit-jv.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gah2hi <external.Hardik.Gajjar@de.bosch.com>

This patch replaces the usage of netif_stop_queue with netif_device_detach
in the u_ether driver. The netif_device_detach function not only stops all
tx queues by calling netif_tx_stop_all_queues but also marks the device as
removed by clearing the __LINK_STATE_PRESENT bit.

This change helps notify user space about the disconnection of the device
more effectively, compared to netif_stop_queue, which only stops a single
transmit queue.

Signed-off-by: gah2hi <external.Hardik.Gajjar@de.bosch.com>
---
 drivers/usb/gadget/function/u_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 4bb0553da658..9d1c40c152d8 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1200,7 +1200,7 @@ void gether_disconnect(struct gether *link)
 
 	DBG(dev, "%s\n", __func__);
 
-	netif_stop_queue(dev->net);
+	netif_device_detach(dev->net);
 	netif_carrier_off(dev->net);
 
 	/* disable endpoints, forcing (synchronous) completion
-- 
2.17.1

