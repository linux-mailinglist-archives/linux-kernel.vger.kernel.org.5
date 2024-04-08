Return-Path: <linux-kernel+bounces-135739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B4C89CA99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CC72892AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87680143893;
	Mon,  8 Apr 2024 17:16:45 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13D142E68
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596605; cv=none; b=aYFs4Ngi54aFHTgTH7bNIc9rLVc7Pvxby9BV/Lr7p+2mbr38nlcLx7MzoIkG8RIW7plQRf/UmCNXjtoFvwZy1kzWwW91xmUDtDqWFeYf9TB2IRbDvhK2ficjk6kNOBZCeH+DBODHuKY9h6yET0fT6DECn6E4ywY9ykGMeJOgnaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596605; c=relaxed/simple;
	bh=s81tOdRKg0MWtUzX7+hk49va1Z3UzIw6hgqY5JtFMI0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qgix10OuzlBT06/JW5TsLecS7k8sI6/detu6kBptmzXzx9gJB3ZY6iDjLyfGiRncwCOLlfM9Fvx7/gWiT6gFV1WjXw9c6Jl+J8r5Bjq/oJRkLpHyzCMVXq/6JMKiH2/qDiv+PGfOrGco43zPmG8uO9myFD20emxPhe9ZPgAWgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 8 Apr
 2024 20:16:37 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 8 Apr 2024
 20:16:36 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Ian Abbott <abbotti@mev.co.uk>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, H Hartley Sweeten
	<hsweeten@visionengravers.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com>
Subject: [PATCH v2] comedi: vmk80xx: fix incomplete endpoint checking
Date: Mon, 8 Apr 2024 10:16:33 -0700
Message-ID: <20240408171633.31649-1-n.zhandarovich@fintech.ru>
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

While vmk80xx does have endpoint checking implemented, some things
can fall through the cracks. Depending on the hardware model,
URBs can have either bulk or interrupt type, and current version
of vmk80xx_find_usb_endpoints() function does not take that fully
into account. While this warning does not seem to be too harmful,
at the very least it will crash systems with 'panic_on_warn' set on
them.

Fix the issue found by Syzkaller [1] by somewhat simplifying the
endpoint checking process with usb_find_common_endpoints() and
ensuring that only expected endpoint types are present.

This patch has not been tested on real hardware.

[1] Syzkaller report:
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 781 at drivers/usb/core/urb.c:504 usb_submit_urb+0xc4e/0x18c0 drivers/usb/core/urb.c:503
..
Call Trace:
 <TASK>
 usb_start_wait_urb+0x113/0x520 drivers/usb/core/message.c:59
 vmk80xx_reset_device drivers/comedi/drivers/vmk80xx.c:227 [inline]
 vmk80xx_auto_attach+0xa1c/0x1a40 drivers/comedi/drivers/vmk80xx.c:818
 comedi_auto_config+0x238/0x380 drivers/comedi/drivers.c:1067
 usb_probe_interface+0x5cd/0xb00 drivers/usb/core/driver.c:399
..

Similar issue also found by Syzkaller:
Link: https://syzkaller.appspot.com/bug?extid=5205eb2f17de3e01946e

Reported-and-tested-by: syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com
Fixes: 49253d542cc0 ("staging: comedi: vmk80xx: factor out usb endpoint detection")
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v2: removed unused variable 'i' to silence compiler warning per
Ian Abbott's <abbotti@mev.co.uk> helpful suggestion.

 drivers/comedi/drivers/vmk80xx.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/comedi/drivers/vmk80xx.c b/drivers/comedi/drivers/vmk80xx.c
index 4536ed43f65b..84dce5184a77 100644
--- a/drivers/comedi/drivers/vmk80xx.c
+++ b/drivers/comedi/drivers/vmk80xx.c
@@ -641,33 +641,22 @@ static int vmk80xx_find_usb_endpoints(struct comedi_device *dev)
 	struct vmk80xx_private *devpriv = dev->private;
 	struct usb_interface *intf = comedi_to_usb_interface(dev);
 	struct usb_host_interface *iface_desc = intf->cur_altsetting;
-	struct usb_endpoint_descriptor *ep_desc;
-	int i;
-
-	if (iface_desc->desc.bNumEndpoints != 2)
-		return -ENODEV;
-
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
-		ep_desc = &iface_desc->endpoint[i].desc;
-
-		if (usb_endpoint_is_int_in(ep_desc) ||
-		    usb_endpoint_is_bulk_in(ep_desc)) {
-			if (!devpriv->ep_rx)
-				devpriv->ep_rx = ep_desc;
-			continue;
-		}
+	struct usb_endpoint_descriptor *ep_rx_desc, *ep_tx_desc;
+	int ret;
 
-		if (usb_endpoint_is_int_out(ep_desc) ||
-		    usb_endpoint_is_bulk_out(ep_desc)) {
-			if (!devpriv->ep_tx)
-				devpriv->ep_tx = ep_desc;
-			continue;
-		}
-	}
+	if (devpriv->model == VMK8061_MODEL)
+		ret = usb_find_common_endpoints(iface_desc, &ep_rx_desc,
+						&ep_tx_desc, NULL, NULL);
+	else
+		ret = usb_find_common_endpoints(iface_desc, NULL, NULL,
+						&ep_rx_desc, &ep_tx_desc);
 
-	if (!devpriv->ep_rx || !devpriv->ep_tx)
+	if (ret)
 		return -ENODEV;
 
+	devpriv->ep_rx = ep_rx_desc;
+	devpriv->ep_tx = ep_tx_desc;
+
 	if (!usb_endpoint_maxp(devpriv->ep_rx) || !usb_endpoint_maxp(devpriv->ep_tx))
 		return -EINVAL;
 

