Return-Path: <linux-kernel+bounces-129999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE03897302
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727F528D0AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA314A083;
	Wed,  3 Apr 2024 14:47:39 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470413AA52
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155659; cv=none; b=m6g0iZLRl+o9iC059ccTy/6vSFAhORfeE0iWlSLlDucHlu1YKKG/ArGfES9jhsUH193W2qRWvi1gIaHVfn6o0mKge981riljb5lW6bkAIdcOq6VbBl6pQmvNc2UsU95rphdEW5Cy8Kwx9fGCdlLEnm2Kv/TtY5nif/L9R5FEV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155659; c=relaxed/simple;
	bh=8Pid9JdmhrcoZr0ymkIWECXLWqq8N6rDdyO+sMGc29Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PX5ZxfO2Y/J+qS/lzCTf14rh2xF0yvhPJxhsARW0LKOZI9VcKMbN2zpRtwYfhR+00UMiQVDo4GTgFOy+NKkVoOdKMrjb6HUn7/pUlfoo6SGEsgOeqvOk/Q4BWviREGjHOddcJ9bfAxsPOib4LqU94r3JWrzY99K0C91CNjr+7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 3 Apr
 2024 17:47:31 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 3 Apr 2024
 17:47:31 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] WARNING in carl9170_usb_send_rx_irq_urb/usb_submit_urb
Date: Wed, 3 Apr 2024 07:47:24 -0700
Message-ID: <20240403144724.14960-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0000000000002592aa05bccabae5@google.com>
References:
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

Verify endpoints in carl9170_usb_probe, leave with error if any
are missing.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
---
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
 

