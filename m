Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1623805689
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442268AbjLENwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345551AbjLENwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:52:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06EF19B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701784334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/k+Y8Tdfs9ltwRZOhu++CvuRNSUApgINWtqoRysI9s=;
        b=cv+1sKgQq5RDdz3NlVt8ub1vNm5rb83txO16RsGgBCEdgDTcVzw6j66HXpCyOM6YaGDKTK
        VMKwtrKr6TDTkbmKh52J9LYiWp3t7EkWLhCJFp+hNuYMsT0YjJZ+Ynb7V0E2x8qkv8Jdwf
        MaVWei29wdo1GPnDn74xbVZhrEnUzTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-kCG4QsraNpufn24efyM9sA-1; Tue, 05 Dec 2023 08:52:07 -0500
X-MC-Unique: kCG4QsraNpufn24efyM9sA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02C4C185A790;
        Tue,  5 Dec 2023 13:52:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 580BA2166B33;
        Tue,  5 Dec 2023 13:52:04 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     oneukum@suse.com
Cc:     davem@davemloft.net, edumazet@google.com, greg@kroah.com,
        jtornosm@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, stable@vger.kernel.org,
        stern@rowland.harvard.edu
Subject: [PATCH v4] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date:   Tue,  5 Dec 2023 14:51:54 +0100
Message-ID: <20231205135154.516342-1-jtornosm@redhat.com>
In-Reply-To: <4ce32363-378c-4ea3-9a4e-d7274d4f7787@suse.com>
References: <4ce32363-378c-4ea3-9a4e-d7274d4f7787@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
unbind operations are commanded from the driver. These operations are
not necessary in this situation, so avoid these logs when the device is
detached if the result of the operation is -ENODEV and if the new flag
informing about the disconnecting status is enabled.

cc: stable@vger.kernel.org
Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Follow the suggestions from Alan Stern and Oliver Neukum to check the
result of the operations (-ENODEV) and not the internal state of the USB 
layer (USB_STATE_NOTATTACHED).
V2 -> V3
- Add cc: stable line in the signed-off-by area.
V3 -> V4
- Follow the suggestions from Oliver Neukum to use only one flag when
disconnecting and include barriers to avoid memory ordering issues.

 drivers/net/usb/ax88179_178a.c | 38 +++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 4ea0e155bb0d..1c671f2a43ee 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -173,6 +173,7 @@ struct ax88179_data {
 	u8 in_pm;
 	u32 wol_supported;
 	u32 wolopts;
+	u8 disconnecting;
 };
 
 struct ax88179_int_data {
@@ -208,6 +209,7 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	BUG_ON(!dev);
 
@@ -219,9 +221,12 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	ret = fn(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 value, index, data, size);
 
-	if (unlikely(ret < 0))
-		netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
-			    index, ret);
+	if (unlikely(ret < 0)) {
+		smp_rmb();
+		if (!(ret == -ENODEV && ax179_data->disconnecting))
+			netdev_warn(dev->net, "Failed to read reg index 0x%04x: %d\n",
+				    index, ret);
+	}
 
 	return ret;
 }
@@ -231,6 +236,7 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	BUG_ON(!dev);
 
@@ -242,9 +248,12 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	ret = fn(dev, cmd, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 value, index, data, size);
 
-	if (unlikely(ret < 0))
-		netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
-			    index, ret);
+	if (unlikely(ret < 0)) {
+		smp_rmb();
+		if (!(ret == -ENODEV && ax179_data->disconnecting))
+			netdev_warn(dev->net, "Failed to write reg index 0x%04x: %d\n",
+				    index, ret);
+	}
 
 	return ret;
 }
@@ -492,6 +501,21 @@ static int ax88179_resume(struct usb_interface *intf)
 	return usbnet_resume(intf);
 }
 
+static void ax88179_disconnect(struct usb_interface *intf)
+{
+	struct usbnet *dev = usb_get_intfdata(intf);
+	struct ax88179_data *ax179_data;
+
+	if (!dev)
+		return;
+
+	ax179_data = dev->driver_priv;
+	ax179_data->disconnecting = 1;
+	smp_wmb();
+
+	usbnet_disconnect(intf);
+}
+
 static void
 ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 {
@@ -1906,7 +1930,7 @@ static struct usb_driver ax88179_178a_driver = {
 	.suspend =	ax88179_suspend,
 	.resume =	ax88179_resume,
 	.reset_resume =	ax88179_resume,
-	.disconnect =	usbnet_disconnect,
+	.disconnect =	ax88179_disconnect,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
 };
-- 
2.43.0

