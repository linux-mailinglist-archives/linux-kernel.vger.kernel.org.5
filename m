Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60837DA220
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjJ0VAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjJ0VAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:00:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D22E187;
        Fri, 27 Oct 2023 14:00:05 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 9D8C720B74C0; Fri, 27 Oct 2023 14:00:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D8C720B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1698440404;
        bh=tjnE9pRfC9wpL1nxaW/eCyk+NG9baQ7UvLcZ/DLAOVU=;
        h=From:To:Cc:Subject:Date:From;
        b=CBOIWIE367mUa46w0DH2cViihfVP/wILGd2QxuPGXJ6dhX36MPeJQ03W/tgH7f+c9
         wYTGm0su2uLDq0O3A1rIi0V3BwpRNVbYzOeBA3Bzx06kb5x1cmTC++XZYs9gvgpcOE
         9VaFmC7M1MMubiK819RDilJ4yDVrx4XFijiSWAW8=
From:   longli@linuxonhyperv.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v2] hv_netvsc: Mark VF as slave before exposing it to user-mode
Date:   Fri, 27 Oct 2023 13:59:50 -0700
Message-Id: <1698440390-13719-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

When a VF is being exposed form the kernel, it should be marked as "slave"
before exposing to the user-mode. The VF is not usable without netvsc running
as master. The user-mode should never see a VF without the "slave" flag.

This commit moves the code of setting the slave flag to the time before VF is
exposed to user-mode.

Signed-off-by: Long Li <longli@microsoft.com>
---

Change since v1:
Use a new function to handle NETDEV_POST_INIT.

 drivers/net/hyperv/netvsc_drv.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ec77fb9dcf89..fdad58dcc6a8 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2206,9 +2206,6 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	/* set slave flag before open to prevent IPv6 addrconf */
-	vf_netdev->flags |= IFF_SLAVE;
-
 	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
@@ -2320,11 +2317,9 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 	 */
 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
 		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
-		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
-			netdev_notice(vf_netdev,
-				      "falling back to mac addr based matching\n");
+		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
+		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))
 			return ndev;
-		}
 	}
 
 	netdev_notice(vf_netdev,
@@ -2332,6 +2327,19 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 	return NULL;
 }
 
+static int netvsc_prepare_slave(struct net_device *vf_netdev)
+{
+	struct net_device *ndev;
+
+	ndev = get_netvsc_byslot(vf_netdev);
+	if (!ndev)
+		return NOTIFY_DONE;
+
+	/* set slave flag before open to prevent IPv6 addrconf */
+	vf_netdev->flags |= IFF_SLAVE;
+	return NOTIFY_DONE;
+}
+
 static int netvsc_register_vf(struct net_device *vf_netdev)
 {
 	struct net_device_context *net_device_ctx;
@@ -2753,6 +2761,8 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_POST_INIT:
+		return netvsc_prepare_slave(event_dev);
 	case NETDEV_REGISTER:
 		return netvsc_register_vf(event_dev);
 	case NETDEV_UNREGISTER:
-- 
2.34.1

