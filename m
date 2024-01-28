Return-Path: <linux-kernel+bounces-41689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D9D83F671
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F0D2811A6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D58C3CF53;
	Sun, 28 Jan 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB6adKo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6851E3C6A3;
	Sun, 28 Jan 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458305; cv=none; b=h+Kp9WrnmY7hbHN/9GUvArBa7zMFkuhhqC/M2o5NkWSfHSj9PKNgkQgv2+J4hxAEcV36hwEp8Zna0jObkjHAUVB1MEfGesxIjKvyeSEUSGLRL4BVQUyI92T7DXaysDGC9PgK0QsarWJHjgpiDocnz62TdwN78WIwnsKIedP3vLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458305; c=relaxed/simple;
	bh=PRJmVivPRsbw+deY3+VFxLBlXQBACfe+kO3GRuFU7Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pS1gPUGd6t9uRnnofa30rB8fyKXfWwgE9astNU6ZwXsd2alAFcM1bGIDKgN37mLjFqJj7TnykixVwXCjSlLYkr+Kb9u9QxqT4cEA8MGI072eBoVIuiswa5E4DQjKYdkKVhdh4yVSAh77xAsMJUKQJ6NNO3HEFZjGQnQFPQNMhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB6adKo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912F7C43390;
	Sun, 28 Jan 2024 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458304;
	bh=PRJmVivPRsbw+deY3+VFxLBlXQBACfe+kO3GRuFU7Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hB6adKo+g4y3HPsuiYTRKx3zSmv1N6eX+krIKP8+TP5OcAFZwBn3bqqt1q5A0Oglg
	 JlnLzL9EUt02m7NCGJqZPcHqnr0EiHRNDfAmrX2pu0rsfM4uI0PhItFmJDkPrWzMSr
	 CnTebdChpHHiF+AmCA5cXnJpBm1c5Ab0pbrIqBSXU4z5CRnZNnmU2UUt+p3I07l1lh
	 5G/pc6pH4IMAc8qsczWu8Ua71BnNLfSyd3zHUVa+vDYMFeLeTvdq38C2WBnHbMRfEu
	 sq/b0EwK4+kngIorhHu5G1+2BfnZNwiXg33Cqdfrqot/q487twZWB2xaKgC+hTT5ag
	 1UCeY9VM/A7Dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	johan+linaro@kernel.org,
	mathias.nyman@linux.intel.com,
	ricardo.canuelo@collabora.com,
	stanley_chang@realtek.com,
	heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 07/39] usb: hub: Add quirk to decrease IN-ep poll interval for Microchip USB491x hub
Date: Sun, 28 Jan 2024 11:10:27 -0500
Message-ID: <20240128161130.200783-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Hardik Gajjar <hgajjar@de.adit-jv.com>

[ Upstream commit 855d75cf8311fee156fabb5639bb53757ca83dd4 ]

There is a potential delay in notifying Linux USB drivers of downstream
USB bus activity when connecting a high-speed or superSpeed device via the
Microchip USB491x hub. This delay is due to the fixed bInterval value of
12 in the silicon of the Microchip USB491x hub.

Microchip requested to ignore the device descriptor and decrease that
value to 9 as it was too late to modify that in silicon.

This patch speeds up the USB enummeration process that helps to pass
Apple Carplay certifications and improve the User experience when utilizing
the USB device via Microchip Multihost USB491x Hub.

A new hub quirk HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL speeds up
the notification process for Microchip USB491x hub by limiting
the maximum bInterval value to 9.

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20231205181829.127353-2-hgajjar@de.adit-jv.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 7deeba174858..ef8d9bda94ac 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -47,12 +47,18 @@
 #define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
 #define USB_PRODUCT_TUSB8041_USB3		0x8140
 #define USB_PRODUCT_TUSB8041_USB2		0x8142
+#define USB_VENDOR_MICROCHIP			0x0424
+#define USB_PRODUCT_USB4913			0x4913
+#define USB_PRODUCT_USB4914			0x4914
+#define USB_PRODUCT_USB4915			0x4915
 #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	BIT(0)
 #define HUB_QUIRK_DISABLE_AUTOSUSPEND		BIT(1)
+#define HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL	BIT(2)
 
 #define USB_TP_TRANSMISSION_DELAY	40	/* ns */
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
 #define USB_PING_RESPONSE_TIME		400	/* ns */
+#define USB_REDUCE_FRAME_INTR_BINTERVAL	9
 
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
@@ -1904,6 +1910,14 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		usb_autopm_get_interface_no_resume(intf);
 	}
 
+	if ((id->driver_info & HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL) &&
+	    desc->endpoint[0].desc.bInterval > USB_REDUCE_FRAME_INTR_BINTERVAL) {
+		desc->endpoint[0].desc.bInterval =
+			USB_REDUCE_FRAME_INTR_BINTERVAL;
+		/* Tell the HCD about the interrupt ep's new bInterval */
+		usb_set_interface(hdev, 0, 0);
+	}
+
 	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0) {
 		onboard_hub_create_pdevs(hdev, &hub->onboard_hub_devs);
 
@@ -5895,6 +5909,21 @@ static const struct usb_device_id hub_id_table[] = {
       .idVendor = USB_VENDOR_TEXAS_INSTRUMENTS,
       .idProduct = USB_PRODUCT_TUSB8041_USB3,
       .driver_info = HUB_QUIRK_DISABLE_AUTOSUSPEND},
+	{ .match_flags = USB_DEVICE_ID_MATCH_VENDOR
+			| USB_DEVICE_ID_MATCH_PRODUCT,
+	  .idVendor = USB_VENDOR_MICROCHIP,
+	  .idProduct = USB_PRODUCT_USB4913,
+	  .driver_info = HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL},
+	{ .match_flags = USB_DEVICE_ID_MATCH_VENDOR
+			| USB_DEVICE_ID_MATCH_PRODUCT,
+	  .idVendor = USB_VENDOR_MICROCHIP,
+	  .idProduct = USB_PRODUCT_USB4914,
+	  .driver_info = HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL},
+	{ .match_flags = USB_DEVICE_ID_MATCH_VENDOR
+			| USB_DEVICE_ID_MATCH_PRODUCT,
+	  .idVendor = USB_VENDOR_MICROCHIP,
+	  .idProduct = USB_PRODUCT_USB4915,
+	  .driver_info = HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL},
     { .match_flags = USB_DEVICE_ID_MATCH_DEV_CLASS,
       .bDeviceClass = USB_CLASS_HUB},
     { .match_flags = USB_DEVICE_ID_MATCH_INT_CLASS,
-- 
2.43.0


