Return-Path: <linux-kernel+bounces-134406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6102089B11E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E31B280F1B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4147143154;
	Sun,  7 Apr 2024 13:11:21 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00E3FB16;
	Sun,  7 Apr 2024 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495480; cv=none; b=UVQSnaSwVLG1mdHRSS9hWiYoCOe30uJlOq75MgMPAvWA9V20qn541DjnXboWkG8W1DOypYsKt9Si+X0m2rc+wV2oS8aWQel2FIEPguUupLJi00CE3/x9vEUYlgiSA/nEWFV0CI5ON/JPbBiOC7Y0BK21JWpNLU/HN0K1CPhoZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495480; c=relaxed/simple;
	bh=tOK8citKj5coWWGdrUGQDHZ0rmgq5F1rm/dGHe8XHdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GAEiu0dofjln8s6oh1SwnMIyjT0mNE5sv7Pj0FoGK8rAxZnXAJWzqQD5adR2ZVwWmONDK3p13Z2z/tf7w28xshDP2B+3RsSqmMK9Vxvo5XL0NF+zgFzh6rFG1AqAe/Ytl8DbRhD96hcd6Ts5QViRXFOANCa4RH0kwHdnVfG6AbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sun, 7 Apr
 2024 16:11:15 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 7 Apr 2024
 16:11:15 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Christian Lamparter <chunkeey@googlemail.com>, Kalle Valo
	<kvalo@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, <lvc-project@linuxtesting.org>,
	<syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com>
Subject: [PATCH] wifi: carl9170: add a proper sanity check for endpoints
Date: Sun, 7 Apr 2024 06:11:09 -0700
Message-ID: <20240407131109.26212-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Syzkaller reports [1] hitting a warning which is caused by presence
of a wrong endpoint type at the URB sumbitting stage. While there
was a check for a specific 4th endpoint, since it can switch types
between bulk and interrupt, other endpoints are trusted implicitly.
Similar warning is triggered in a couple of other syzbot issues [2].

Fix the issue by doing a comprehensive check of all endpoints
taking into account difference between high- and full-speed
configuration.

This patch has not been tested on real hardware.

[1] Syzkaller report:
..
WARNING: CPU: 0 PID: 4721 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
..
Call Trace:
 <TASK>
 carl9170_usb_send_rx_irq_urb+0x273/0x340 drivers/net/wireless/ath/carl9170/usb.c:504
 carl9170_usb_init_device drivers/net/wireless/ath/carl9170/usb.c:939 [inline]
 carl9170_usb_firmware_finish drivers/net/wireless/ath/carl9170/usb.c:999 [inline]
 carl9170_usb_firmware_step2+0x175/0x240 drivers/net/wireless/ath/carl9170/usb.c:1028
 request_firmware_work_func+0x130/0x240 drivers/base/firmware_loader/main.c:1107
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

[2] Related syzkaller crashes:
Link: https://syzkaller.appspot.com/bug?extid=e394db78ae0b0032cb4d
Link: https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1

Reported-and-tested-by: syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com
Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. as AR9170_USB_EP_CMD endpoint can switch between bulk and int,
I failed to find a prettier solution to this problem. Will be glad
to hear if there is a better option...

 drivers/net/wireless/ath/carl9170/usb.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index c4edf8355941..66d2ad561fd3 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -1069,6 +1069,33 @@ static int carl9170_usb_probe(struct usb_interface *intf,
 			ar->usb_ep_cmd_is_bulk = true;
 	}
 
+	/* Verify that all expected endpoints are present */
+	if (ar->usb_ep_cmd_is_bulk) {
+		u8 bulk_ep_addr[] = {
+			AR9170_USB_EP_RX | USB_DIR_IN,
+			AR9170_USB_EP_TX | USB_DIR_OUT,
+			AR9170_USB_EP_CMD | USB_DIR_OUT,
+			0};
+		u8 int_ep_addr[] = {
+			AR9170_USB_EP_IRQ | USB_DIR_IN,
+			0};
+		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+		    !usb_check_int_endpoints(intf, int_ep_addr))
+			return -ENODEV;
+	} else {
+		u8 bulk_ep_addr[] = {
+			AR9170_USB_EP_RX | USB_DIR_IN,
+			AR9170_USB_EP_TX | USB_DIR_OUT,
+			0};
+		u8 int_ep_addr[] = {
+			AR9170_USB_EP_IRQ | USB_DIR_IN,
+			AR9170_USB_EP_CMD | USB_DIR_OUT,
+			0};
+		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+		    !usb_check_int_endpoints(intf, int_ep_addr))
+			return -ENODEV;
+	}
+
 	usb_set_intfdata(intf, ar);
 	SET_IEEE80211_DEV(ar->hw, &intf->dev);
 

