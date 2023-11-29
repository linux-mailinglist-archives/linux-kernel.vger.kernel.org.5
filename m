Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2177FDAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjK2PQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjK2PQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333EDBE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701270985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OcpkJmyvNj3eShS3c+JKZr285NS0S6mgXrW8UfGiu30=;
        b=ZiidgwEqT1ZqJ3SNSxS1Olw7kEe54m6ZhAdv1bgNZUtfsR0/TdbbpOkJ7zYHD+9kcCnNU+
        zdt6eBrxcZoo1ipPwksQkibGmRX/X0prxWUKov1FakElWTdHEWT9OCGruvB20tr35fErTO
        W8J1+Zb9ipSfgB/NLvSDjTudoKvrYk8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-_OovbazvNDybf2Px3T3cDw-1; Wed,
 29 Nov 2023 10:16:23 -0500
X-MC-Unique: _OovbazvNDybf2Px3T3cDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16A723821344;
        Wed, 29 Nov 2023 15:16:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BF06502E;
        Wed, 29 Nov 2023 15:16:20 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jtornosm@redhat.com
Subject: [PATCH] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date:   Wed, 29 Nov 2023 16:16:11 +0100
Message-ID: <20231129151618.455618-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the device is disconnected we get the following messages showing
failed operations:
Nov 28 20:22:11 localhost kernel: usb 2-3: USB disconnect, device number 2
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: unregister 'ax88179_178a' usb-0000:02:00.0-3, ASIX AX88179 USB 3.0 Gigabit Ethernet
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: Failed to read reg index 0x0002: -19
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: Failed to write reg index 0x0002: -19
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0002: -19
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0001: -19
Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0002: -19

The reason is that although the device is detached, normal stop and
unbind operations are commanded. Avoid these unnecessary operations
when the device is detached (state is USB_STATE_NOTATTACHED) so as
not to get the error messages.

Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/usb/ax88179_178a.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 4ea0e155bb0d..e78d555dd95e 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1308,16 +1308,18 @@ static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
 	struct ax88179_data *ax179_data = dev->driver_priv;
 	u16 tmp16;
 
-	/* Configure RX control register => stop operation */
-	tmp16 = AX_RX_CTL_STOP;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
+	if (dev->udev->state != USB_STATE_NOTATTACHED) {
+		/* Configure RX control register => stop operation */
+		tmp16 = AX_RX_CTL_STOP;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
 
-	tmp16 = 0;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, &tmp16);
+		tmp16 = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, &tmp16);
 
-	/* Power down ethernet PHY */
-	tmp16 = 0;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, &tmp16);
+		/* Power down ethernet PHY */
+		tmp16 = 0;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, &tmp16);
+	}
 
 	kfree(ax179_data);
 }
@@ -1663,11 +1665,13 @@ static int ax88179_stop(struct usbnet *dev)
 {
 	u16 tmp16;
 
-	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
+	if (dev->udev->state != USB_STATE_NOTATTACHED) {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
 			 2, 2, &tmp16);
-	tmp16 &= ~AX_MEDIUM_RECEIVE_EN;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
+		tmp16 &= ~AX_MEDIUM_RECEIVE_EN;
+		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
 			  2, 2, &tmp16);
+	}
 
 	return 0;
 }
-- 
2.43.0

