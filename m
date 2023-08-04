Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688E076FCA9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjHDIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjHDIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:52:50 -0400
X-Greylist: delayed 92 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 01:50:19 PDT
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB58355B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:50:19 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RHKD94pTFz7S5Hk;
        Fri,  4 Aug 2023 16:50:17 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl2.zte.com.cn with SMTP id 3748nisU010349;
        Fri, 4 Aug 2023 16:49:44 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 4 Aug 2023 16:49:46 +0800 (CST)
Date:   Fri, 4 Aug 2023 16:49:46 +0800 (CST)
X-Zmail-TransId: 2b0364ccbbaaffffffff989-81c32
X-Mailer: Zmail v1.0
Message-ID: <202308041649468563730@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <davem@davemloft.net>
Cc:     <dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB1ZHBfdHVubmVsX25pYzogYWRkIG5ldCBkZXZpY2UgcmVmY291bnQgdHJhY2tlcg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3748nisU010349
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64CCBBC9.001/4RHKD94pTFz7S5Hk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Add net device refcount tracker to udp_tunnel_nic.c.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
---
 net/ipv4/udp_tunnel_nic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 029219749785..ce8f5c82b0a1 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -55,6 +55,9 @@ struct udp_tunnel_nic {
  */
 static struct workqueue_struct *udp_tunnel_nic_workqueue;

+/* To track netdev_hold and netdev_put */
+static netdevice_tracker udp_tunnel_nic_devtracker;
+
 static const char *udp_tunnel_nic_tunnel_type_name(unsigned int type)
 {
 	switch (type) {
@@ -825,7 +828,7 @@ static int udp_tunnel_nic_register(struct net_device *dev)
 	}

 	utn->dev = dev;
-	dev_hold(dev);
+	netdev_hold(dev, &udp_tunnel_nic_devtracker, GFP_KERNEL);
 	dev->udp_tunnel_nic = utn;

 	if (!(info->flags & UDP_TUNNEL_NIC_INFO_OPEN_ONLY))
@@ -879,7 +882,7 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 	udp_tunnel_nic_free(utn);
 release_dev:
 	dev->udp_tunnel_nic = NULL;
-	dev_put(dev);
+	netdev_put(dev, &udp_tunnel_nic_devtracker);
 }

 static int
-- 
2.15.2
