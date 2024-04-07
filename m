Return-Path: <linux-kernel+bounces-134392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFF389B0EF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75B61F216F0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638A1CAA6;
	Sun,  7 Apr 2024 13:02:22 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EFB39AC4
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712494941; cv=none; b=f6rWjYsR9Q4Z0zVezR7FWe7YwmyUG4KskEC/X72Y8q5M91unwWiEllq3cQFetWDVEqfnlbnc4SpAaIjjytvGQ8dh+f1ZFqtaaj0DaKoGYrdWvSVW3anQnWKVpOGwzBciIIzXVFs8Yft6hv92X2Yq9cFY2owppKimEVhhnJlmzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712494941; c=relaxed/simple;
	bh=3pqHA7mAJkE3zICXhWRu2GMgmHuXniWVnScTIuiKkOw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HYhQZEdZq5YKdJr7TA5+K7iPeqFRmqoBsRsohc43r0/rocRRrutCelWYF0K+ZwHrpXh/oBU1cfNyVSQN2QKgM/jorIq02hqDnqRPxVZstAheNZNDjQjV0/qqRfxi1v7QzK1ZpsKYqhrIHqwnxj6iSvQ9zknfvRezH94yWWCVKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sun, 7 Apr
 2024 16:02:16 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 7 Apr 2024
 16:02:15 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] WARNING in vmk80xx_auto_attach/usb_submit_urb
Date: Sun, 7 Apr 2024 06:02:03 -0700
Message-ID: <20240407130203.26091-1-n.zhandarovich@fintech.ru>
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

Refactor endpoint checks to ensure there is no ambivalence
about endpoint types.

Try a specific branch to mitigate unrelated issues with boot/build.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e
---
 drivers/comedi/drivers/vmk80xx.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/comedi/drivers/vmk80xx.c b/drivers/comedi/drivers/vmk80xx.c
index 4536ed43f65b..476885403c61 100644
--- a/drivers/comedi/drivers/vmk80xx.c
+++ b/drivers/comedi/drivers/vmk80xx.c
@@ -641,33 +641,22 @@ static int vmk80xx_find_usb_endpoints(struct comedi_device *dev)
 	struct vmk80xx_private *devpriv = dev->private;
 	struct usb_interface *intf = comedi_to_usb_interface(dev);
 	struct usb_host_interface *iface_desc = intf->cur_altsetting;
-	struct usb_endpoint_descriptor *ep_desc;
-	int i;
+	struct usb_endpoint_descriptor *ep_rx_desc, *ep_tx_desc;
+	int i, ret;
 
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
-
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
 

