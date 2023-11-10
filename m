Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E257E7FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjKJSAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjKJR7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:19 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383458A45;
        Fri, 10 Nov 2023 00:02:47 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 3360E1C0009;
        Fri, 10 Nov 2023 08:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699603365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UylwPPbht2Hmc2zuuPi5hzrxk1rL9hBKeGOaaTtVLi4=;
        b=adNudLuyHW4/6U4RdKKgOWUCa0RyMVCDhzAvm7stVMvL7UcMUj/AS+Afg/wW/yHHQ3CEhy
        aoGyZFmzcld4q/WDRVnFpcLWgQnkvBXdB+SRtZ++vAfK7IkAi8xI1w6kLSnddZmNX/rCmf
        TLNi+SC6JYMW+ZP21vcz6Rx+gHUAhJc9GuWkhXlztr3eOyXJOpllOLmXNPNdVL8J4lxgd2
        tafw4l8+m2JpM6omPHipsDCqsVpnfdmenB06qKKl7lBc4Yqt0E0O2hE6u4o2BQ8Z2EvmUo
        du2PNKh/ZpROAsdbOKt5O1OAeM3QniDUolQGEYn4Q9tqnbj4sDOL9VMNbeYQ7Q==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>, stable@vger.kernel.org
Subject: [PATCH 1/1] driver core: Remove warning on driver unbinding
Date:   Fri, 10 Nov 2023 09:02:40 +0100
Message-ID: <20231110080241.702999-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During driver unbinding, __device_links_no_driver() can raise the
following warning:
   --- 8< ---
   WARNING: CPU: 0 PID: 166 at drivers/base/core.c:1426 __device_links_no_driver+0xac/0xb4
   ...
   Call trace:
   __device_links_no_driver+0xac/0xb4
   device_links_driver_cleanup+0xa8/0xf0
   device_release_driver_internal+0x204/0x240
   device_release_driver+0x18/0x24
   bus_remove_device+0xcc/0x10c
   device_del+0x158/0x414
   platform_device_del.part.0+0x1c/0x88
   platform_device_unregister+0x24/0x40
   of_platform_device_destroy+0xfc/0x10c
   device_for_each_child_reverse+0x64/0xb4
   devm_of_platform_populate_release+0x4c/0x84
   release_nodes+0x5c/0x90
   devres_release_all+0x8c/0xdc
   device_unbind_cleanup+0x18/0x68
   device_release_driver_internal+0x20c/0x240
   device_links_unbind_consumers+0xe0/0x108
   device_release_driver_internal+0xf0/0x240
   driver_detach+0x50/0x9c
   bus_remove_driver+0x6c/0xbc
   driver_unregister+0x30/0x60
   ...
   --- 8< ---

This warning is raised because, during device removal, we unlink a
consumer while its supplier links.status is DL_DEV_UNBINDING.
Even if the link is not a SYNC_STATE_ONLY, the warning should not
appear in that case.

Filter out this warning in case of the supplier driver is unbinding.

Fixes: 8c3e315d4296 ("driver core: Update device link status correctly for SYNC_STATE_ONLY links")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/base/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 17f2568e0a79..f4b09691998e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1423,7 +1423,8 @@ static void __device_links_no_driver(struct device *dev)
 		if (link->supplier->links.status == DL_DEV_DRIVER_BOUND) {
 			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 		} else {
-			WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
+			WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY) &&
+				link->supplier->links.status != DL_DEV_UNBINDING);
 			WRITE_ONCE(link->status, DL_STATE_DORMANT);
 		}
 	}
-- 
2.41.0

