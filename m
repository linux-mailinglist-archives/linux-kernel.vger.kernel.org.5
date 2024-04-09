Return-Path: <linux-kernel+bounces-137101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5693089DC6C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883091C2106A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10E4F5EA;
	Tue,  9 Apr 2024 14:36:51 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414832C695;
	Tue,  9 Apr 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673410; cv=none; b=nDWnW8YJvg31LeO2iwO6xG+m67wd8+tOeLQwR3p1JyUitrjZ3Xw2mQQ1mfw/U/t+/22Bs6h2YtOgoiSLYY2JP0eWmqRYHcYn/rao3GF9dhIqfRbVqgtmsXbdHVDuLzp5m7Hceq4jMkkdZuyRsh4bf6o73rkAGmD1H/iG2tM4T3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673410; c=relaxed/simple;
	bh=V48YeIPzcwVGjA7uCl+5dsWCWJXiaVFOuOZsOxK/qMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oMs+khCXxhdWv+s0Y/ZyoUR7xe1ew3mf4u3ucdNXb4lTD3dLJS+/CeUWJ1sCXATJNk6h1su9MedUHvyE1Y1l00qlPZlAm692OGKcNUzMlioerlDEH8jDiXAy8dE2vr7mdYjA+03ah7svTFfiAoihdk+R1osY55LzR8G9gPm9ka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 9 Apr
 2024 17:36:37 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 9 Apr 2024
 17:36:37 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Hans Verkuil
	<hverkuil-cisco@xs4all.nl>, Dongliang Mu <dzm91@hust.edu.cn>, Andrew Morton
	<akpm@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>,
	<syzbot+12002a39b8c60510f8fb@syzkaller.appspotmail.com>
Subject: [PATCH] media: usb: siano: fix endpoint checks in smsusb_init_device()
Date: Tue, 9 Apr 2024 07:36:34 -0700
Message-ID: <20240409143634.33230-1-n.zhandarovich@fintech.ru>
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

Syzkaller reported a warning [1] in smsusb_submit_urb() which occurs
if an attempt is made to send a bulk URB using the wrong endpoint
type. The current approach to perform endpoint checking does not
explicitly check if an endpoint in question has its type set to bulk.

Fix this issue by using functions usb_endpoint_is_bulk_XXX() to
enable testing for correct ep types.

This patch has not been tested on real hardware.

[1] Syzkaller report:
usb 1-1: string descriptor 0 read error: -71
smsusb:smsusb_probe: board id=2, interface number 0
smsusb:siano_media_device_register: media controller created
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 3147 at drivers/usb/core/urb.c:494 usb_submit_urb+0xacd/0x1550 drivers/usb/core/urb.c:493
..
Call Trace:
 smsusb_start_streaming+0x16/0x1d0 drivers/media/usb/siano/smsusb.c:195
 smsusb_init_device+0xd85/0x12d0 drivers/media/usb/siano/smsusb.c:475
 smsusb_probe+0x496/0xa90 drivers/media/usb/siano/smsusb.c:566
 usb_probe_interface+0x633/0xb40 drivers/usb/core/driver.c:396
 really_probe+0x3cb/0x1020 drivers/base/dd.c:580
 driver_probe_device+0x178/0x350 drivers/base/dd.c:763
..
 hub_event+0x48d/0xd90 drivers/usb/core/hub.c:5644
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1300 kernel/workqueue.c:2422
 kthread+0x39a/0x3c0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Reported-and-tested-by: syzbot+12002a39b8c60510f8fb@syzkaller.appspotmail.com
Fixes: 31e0456de5be ("media: usb: siano: Fix general protection fault in smsusb")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/media/usb/siano/smsusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 723510520d09..daaac121c670 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -405,10 +405,10 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 		struct usb_endpoint_descriptor *desc =
 				&intf->cur_altsetting->endpoint[i].desc;
 
-		if (desc->bEndpointAddress & USB_DIR_IN) {
+		if (usb_endpoint_is_bulk_in(desc)) {
 			dev->in_ep = desc->bEndpointAddress;
 			align = usb_endpoint_maxp(desc) - sizeof(struct sms_msg_hdr);
-		} else {
+		} else if (usb_endpoint_is_bulk_out(desc)) {
 			dev->out_ep = desc->bEndpointAddress;
 		}
 	}

