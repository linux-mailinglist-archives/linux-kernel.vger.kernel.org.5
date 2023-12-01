Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB2C800A1C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378630AbjLALv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378585AbjLALvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:51:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DBD1707
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701431519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fycN3hZGNRl6X4amyCpma7UV8ZHfLxVOfAL+B4rgRck=;
        b=HpjnCW0kr6goHhzPQT/vV9E8i1FlXOw3UMinxcOBGnGFJiUODuEwdLjWfkEqEPhWhzyPQ9
        5N9QFvQv4kGbiGIicV0UBdbw/LfqwiegOYO6jr40kNR0bq0Liv+InFHG6SGapNbNz9PslV
        ELGoZe2CSZP+OHUD3dkX/RQTi7cCy/4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-DfTxXO3AO86EyAC7MNdX8Q-1; Fri, 01 Dec 2023 06:51:57 -0500
X-MC-Unique: DfTxXO3AO86EyAC7MNdX8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E172831520;
        Fri,  1 Dec 2023 11:51:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1413C2166B26;
        Fri,  1 Dec 2023 11:51:54 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     stern@rowland.harvard.edu
Cc:     davem@davemloft.net, edumazet@google.com, jtornosm@redhat.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, pabeni@redhat.com
Subject: [PATCH v2] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date:   Fri,  1 Dec 2023 12:51:43 +0100
Message-ID: <20231201115143.177081-1-jtornosm@redhat.com>
In-Reply-To: <e8e4ac26-9168-452c-80bc-f32904808cc9@rowland.harvard.edu>
References: <e8e4ac26-9168-452c-80bc-f32904808cc9@rowland.harvard.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
unbind operations are commanded from the driver. These operations are
not necessary in this situation, so avoid these logs when the device is
detached if the result of the operation is -ENODEV and if the new flag
informing about the stopping or unbind operation is enabled.

Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Follow the suggestions from Alan Stern and Oliver Neukum to check the
result of the operations (-ENODEV) and not the internal state of the USB 
layer (USB_STATE_NOTATTACHED).

 drivers/net/usb/ax88179_178a.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 4ea0e155bb0d..105bae360128 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -173,6 +173,7 @@ struct ax88179_data {
 	u8 in_pm;
 	u32 wol_supported;
 	u32 wolopts;
+	u8 stopping_unbinding;
 };
 
 struct ax88179_int_data {
@@ -208,6 +209,7 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	BUG_ON(!dev);
 
@@ -219,7 +221,7 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	ret = fn(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely(ret < 0 && !(ret == -ENODEV && ax179_data->stopping_unbinding)))
 		netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
 			    index, ret);
 
@@ -231,6 +233,7 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	BUG_ON(!dev);
 
@@ -242,7 +245,7 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	ret = fn(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely(ret < 0 && !(ret == -ENODEV && ax179_data->stopping_unbinding)))
 		netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
 			    index, ret);
 
@@ -1308,6 +1311,8 @@ static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
 	struct ax88179_data *ax179_data = dev->driver_priv;
 	u16 tmp16;
 
+	ax179_data->stopping_unbinding = 1;
+
 	/* Configure RX control register => stop operation */
 	tmp16 = AX_RX_CTL_STOP;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
@@ -1319,6 +1324,8 @@ static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
 	tmp16 = 0;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, &tmp16);
 
+	ax179_data->stopping_unbinding = 0;
+
 	kfree(ax179_data);
 }
 
@@ -1661,14 +1668,19 @@ static int ax88179_reset(struct usbnet *dev)
 
 static int ax88179_stop(struct usbnet *dev)
 {
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	u16 tmp16;
 
+	ax179_data->stopping_unbinding = 1;
+
 	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
 			 2, 2, &tmp16);
 	tmp16 &= ~AX_MEDIUM_RECEIVE_EN;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
 			  2, 2, &tmp16);
 
+	ax179_data->stopping_unbinding = 0;
+
 	return 0;
 }
 
-- 
2.43.0

