Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB6A7E1F66
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjKFLGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKFLGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:06:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC10A134;
        Mon,  6 Nov 2023 03:06:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30902C433C9;
        Mon,  6 Nov 2023 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699268806;
        bh=q/xLTHFuLYcmp6NtzuTCC0cv7q+YbosYhXcrvfEUmDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peZFJ2Cx2PvFGctJiv0cWGJ08qUNymKNlkYLTLpkqoXiArTcIJNUYJI/EsGt4IR01
         oVbC/gxtOuvLRFsV84BwdE0vMOvIStwpjxcap9A9CEZyXON5ey4A+g2lWQF7Xb7zt9
         co1rbZNvoMLWQfunW+U5dM7fYiX7BsYsIIDllUtYP81863crCx+9kg2x/VHNBtNhsE
         0BxKDuV10vrHoLHrMOv9PnB8Xjc7BX4UJzqExtfzKAHRB4S4anQEQDEtoY62wAHDbT
         kI28FsWsByAt4gXXw0h7CJ6/cf35jLKQVe2e+SXU9ltrVNfd1tNWH5SOP6KIvH2Vqm
         URkZ50dMEpVQw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qzxS7-00085v-2e;
        Mon, 06 Nov 2023 12:07:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Stanley Chang <stanley_chang@realtek.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH 3/3] Revert "usb: phy: add usb phy notify port status API"
Date:   Mon,  6 Nov 2023 12:06:54 +0100
Message-ID: <20231106110654.31090-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110654.31090-1-johan+linaro@kernel.org>
References: <20231106110654.31090-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a08799cf17c22375752abfad3b4a2b34b3acb287.

The recently added Realtek PHY drivers depend on the new port status
notification mechanism which was built on the deprecated USB PHY
implementation and devicetree binding.

Specifically, using these PHYs would require describing the very same
PHY using both the generic "phy" property and the deprecated "usb-phy"
property which is clearly wrong.

We should not be building new functionality on top of the legacy USB PHY
implementation even if it is currently stuck in some kind of
transitional limbo.

Revert the new notification interface which is broken by design.

Fixes: a08799cf17c2 ("usb: phy: add usb phy notify port status API")
Cc: stable@vger.kernel.org      # 6.6
Cc: Stanley Chang <stanley_chang@realtek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/core/hub.c  | 23 -----------------------
 include/linux/usb/phy.h | 13 -------------
 2 files changed, 36 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 0ff47eeffb49..dfc30cebd4c4 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -622,29 +622,6 @@ static int hub_ext_port_status(struct usb_hub *hub, int port1, int type,
 		ret = 0;
 	}
 	mutex_unlock(&hub->status_mutex);
-
-	/*
-	 * There is no need to lock status_mutex here, because status_mutex
-	 * protects hub->status, and the phy driver only checks the port
-	 * status without changing the status.
-	 */
-	if (!ret) {
-		struct usb_device *hdev = hub->hdev;
-
-		/*
-		 * Only roothub will be notified of port state changes,
-		 * since the USB PHY only cares about changes at the next
-		 * level.
-		 */
-		if (is_root_hub(hdev)) {
-			struct usb_hcd *hcd = bus_to_hcd(hdev->bus);
-
-			if (hcd->usb_phy)
-				usb_phy_notify_port_status(hcd->usb_phy,
-							   port1 - 1, *status, *change);
-		}
-	}
-
 	return ret;
 }
 
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index b513749582d7..e4de6bc1f69b 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -144,10 +144,6 @@ struct usb_phy {
 	 */
 	int	(*set_wakeup)(struct usb_phy *x, bool enabled);
 
-	/* notify phy port status change */
-	int	(*notify_port_status)(struct usb_phy *x, int port,
-				      u16 portstatus, u16 portchange);
-
 	/* notify phy connect status change */
 	int	(*notify_connect)(struct usb_phy *x,
 			enum usb_device_speed speed);
@@ -320,15 +316,6 @@ usb_phy_set_wakeup(struct usb_phy *x, bool enabled)
 		return 0;
 }
 
-static inline int
-usb_phy_notify_port_status(struct usb_phy *x, int port, u16 portstatus, u16 portchange)
-{
-	if (x && x->notify_port_status)
-		return x->notify_port_status(x, port, portstatus, portchange);
-	else
-		return 0;
-}
-
 static inline int
 usb_phy_notify_connect(struct usb_phy *x, enum usb_device_speed speed)
 {
-- 
2.41.0

