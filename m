Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E7975E7A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjGXB32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjGXB2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC0D1994;
        Sun, 23 Jul 2023 18:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F76660DFE;
        Mon, 24 Jul 2023 01:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE30AC433CA;
        Mon, 24 Jul 2023 01:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161881;
        bh=RHrWYJka50+U54SvEOQk7FrV7QWOev0PKXKQZTUnHq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUfRDJwLJ4h78bpudHIwjkWmS/OkR4xunmQjEHNHIRUZgA91fBWUKFXud3V8KSACp
         6BrqAhoYo5+xkDP8v5V+Ci6Tzfcqyig6shGTPb++JeuzVjAUE5kjjHcqz0Jo5AF3mo
         +JsblYI8CLJKO5ehso7mz6uwLWWdxeOF3qA0nrOH9wAnZxOO/8zzlppxfCd8geEfC8
         iv4p4xObm4XMPSCztboIaAsb+VnDR+0Fg+2iFUabOJe3VZXEp5R4dpH8ke+5OHscGT
         M+/CfcK5go8jJLEjhD5DE1jsNGQfmwuqoBVuEii19PvCurgCc1514pWYxMBvFM4/lp
         +wagjvqDYKslg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marco Morandini <marco.morandini@polimi.it>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 14/22] HID: add quirk for 03f0:464a HP Elite Presenter Mouse
Date:   Sun, 23 Jul 2023 21:24:11 -0400
Message-Id: <20230724012419.2317649-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012419.2317649-1-sashal@kernel.org>
References: <20230724012419.2317649-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Morandini <marco.morandini@polimi.it>

[ Upstream commit 0db117359e47750d8bd310d19f13e1c4ef7fc26a ]

HP Elite Presenter Mouse HID Record Descriptor shows
two mouses (Repord ID 0x1 and 0x2), one keypad (Report ID 0x5),
two Consumer Controls (Report IDs 0x6 and 0x3).
Previous to this commit it registers one mouse, one keypad
and one Consumer Control, and it was usable only as a
digitl laser pointer (one of the two mouses). This patch defines
the 464a USB device ID and enables the HID_QUIRK_MULTI_INPUT
quirk for it, allowing to use the device both as a mouse
and a digital laser pointer.

Signed-off-by: Marco Morandini <marco.morandini@polimi.it>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2b658d820b800..6712d99ad80da 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -582,6 +582,7 @@
 #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030
 
 #define USB_VENDOR_ID_HP		0x03f0
+#define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE		0x134a
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 9f1fcbea19eb7..4229e5de06745 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -96,6 +96,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A293), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A), HID_QUIRK_ALWAYS_POLL },
-- 
2.39.2

