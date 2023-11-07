Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F367E440B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343517AbjKGPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbjKGPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:48:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23E41729;
        Tue,  7 Nov 2023 07:48:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5C4C433CA;
        Tue,  7 Nov 2023 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372090;
        bh=zNa9JlkYz7HsTow3ORnnremtHxHzG3UL3kF/aaacUB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1INpFVOGnLbBDvs1l6E6Hahs9N88xlDl/zytJwPoTh7wFAZlKa107tl7Q/mdeEk/
         9bKpMdZTbL/4lhY3x878hVU7b0tQJb+qQpLFnb+xLXv1cLde2EbVKXL+8PvTqq+GBT
         SumhNWJQRp7xXV5Qj8gmHji9adBR5DqDBwK6GrdAac832sM35Hb5ItFJGsgh6rlrvd
         ZJ0hY4p32XOmP4MoLO4mE+1AjbqDaT17XNHiYi0YeQDJ93s+Mv2IpE3YPf8nLxh3cY
         rv3TGbh4KNqpDrNJCmibdgRnibEiAFAdTfXjZDYir3UvoB0U8TWqUGiPmGrrC/VG4S
         F96H+VsLp/AKA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Robert Ayrapetyan <robert.ayrapetyan@gmail.com>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 34/36] HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W
Date:   Tue,  7 Nov 2023 10:46:16 -0500
Message-ID: <20231107154654.3765336-34-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

[ Upstream commit 62cc9c3cb3ec1bf31cc116146185ed97b450836a ]

This device needs ALWAYS_POLL quirk, otherwise it keeps reconnecting
indefinitely.

Reported-by: Robert Ayrapetyan <robert.ayrapetyan@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e4d2dfd5d2536..f7973ccd84a28 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -366,6 +366,7 @@
 
 #define USB_VENDOR_ID_DELL				0x413c
 #define USB_DEVICE_ID_DELL_PIXART_USB_OPTICAL_MOUSE	0x301a
+#define USB_DEVICE_ID_DELL_PRO_WIRELESS_KM5221W		0x4503
 
 #define USB_VENDOR_ID_DELORME		0x1163
 #define USB_DEVICE_ID_DELORME_EARTHMATE	0x0100
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 3983b4f282f8f..5a48fcaa32f00 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -66,6 +66,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_STRAFE), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_PRO_WIRELESS_KM5221W), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES), HID_QUIRK_MULTI_INPUT },
-- 
2.42.0

