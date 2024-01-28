Return-Path: <linux-kernel+bounces-41761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373D383F76D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EE9284963
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28746BB3F;
	Sun, 28 Jan 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5tOMvaj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257396BB21;
	Sun, 28 Jan 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458478; cv=none; b=r/i42GDreUYvB3WID3AGpWfqa+NJNKbTc5V4DVna02ayH0Bj1B+YwvcK2lSPkqILisI/TbtruvBoDAKfX4PxV277aap56s2v03aRsfwQQUenS8/PrmDjH29S8voYQg6503x3nhr0y9s/bfxo6bEEjOx6fsA73WunZsYDtwMj+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458478; c=relaxed/simple;
	bh=uC0Hs3C0WtDUEDquvWouJ2BURg+YI1K4dtBYkDHKCOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnYLKzB32GiMsb6bKZz8ChBnzC2eaaiSrfV2l9l++VIw8WeezmZ0rYzcr74llEjmfB7X7eEUaxxWevq1znREJPyT/5pMyMqIqLFjsnuhoRlnmWRkPTI39DrJwXBBUH0d1Zpc/c9ZaLGew4btJh4mJdkl7RWZ7mG9ryOes5Ksx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5tOMvaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9ADC433F1;
	Sun, 28 Jan 2024 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458477;
	bh=uC0Hs3C0WtDUEDquvWouJ2BURg+YI1K4dtBYkDHKCOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5tOMvajTdCzueptwId7GAvhmnH/vUaR++cZSYfbaqQFKPvz1mMIdRZeAvN3ZTaZI
	 XStM0nCoQNtJUeE6KX6PRW6COLDZ3PnSAH+Si3DzolGr0d/jKC3N/Nb1WvuHAXeMaH
	 BIKYQ6KwDVPuYJXc0SUPoAYy1LSCGdaTtdITGf+ZqVmDzfVr39DQKBnaMl6/RUxOlX
	 4FF6bFZxQdX/O325Ei8zJAgNQJ2D1nw8HLZ4WrXl+ZEQwfik/WVMxS592pbdtiefV4
	 rpv1YiSP4fFPeZRxXqBTUEnOLqeHsI2HymfTgOxZii98YZMT6FvHtrD8LvoFjT63gg
	 JHewdss8CdTMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@linux.intel.com,
	stanley_chang@realtek.com,
	johan+linaro@kernel.org,
	royluo@google.com,
	ricardo.canuelo@collabora.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/27] usb: hub: Add quirk to decrease IN-ep poll interval for Microchip USB491x hub
Date: Sun, 28 Jan 2024 11:13:51 -0500
Message-ID: <20240128161424.203600-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index 9163fd5af046..4f181110d00d 100644
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
 
@@ -5885,6 +5899,21 @@ static const struct usb_device_id hub_id_table[] = {
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


