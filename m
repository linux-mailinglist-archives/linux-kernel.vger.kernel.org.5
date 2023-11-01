Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF237DE102
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 13:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbjKAMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjKAMgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:36:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0747D11B;
        Wed,  1 Nov 2023 05:36:06 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SL5y36YB1zrTPC;
        Wed,  1 Nov 2023 20:32:59 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 1 Nov
 2023 20:36:01 +0800
From:   Ren Mingshuai <renmingshuai@huawei.com>
To:     <oneukum@suse.com>
CC:     <khlebnikov@openvz.org>, <davem@davemloft.net>,
        <caowangbao@huawei.com>, <yanan@huawei.com>, <liaichun@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Date:   Wed, 1 Nov 2023 20:35:59 +0800
Message-ID: <20231101123559.210756-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23ba07991dad said SKB can be NULL without describing the triggering
scenario. Always Check it before dereference to void potential NULL
pointer dereference.
Fix smatch warning:
drivers/net/usb/usbnet.c:1380 usbnet_start_xmit() error: we previously assumed 'skb' could be null (see line 1359)

Signed-off-by: Ren Mingshuai <renmingshuai@huawei.com>
---
 drivers/net/usb/usbnet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 64a9a80b2309..386cb1a4ff03 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1374,6 +1374,11 @@ netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
 		}
 	}
 
+	if (!skb) {
+		netif_dbg(dev, tx_err, dev->net, "tx skb is NULL\n");
+		goto drop;
+	}
+
 	if (!(urb = usb_alloc_urb (0, GFP_ATOMIC))) {
 		netif_dbg(dev, tx_err, dev->net, "no urb\n");
 		goto drop;
-- 
2.33.0

