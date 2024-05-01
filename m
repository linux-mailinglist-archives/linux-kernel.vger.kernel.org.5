Return-Path: <linux-kernel+bounces-164824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7FF8B8379
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305B3B2161D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B884581E;
	Wed,  1 May 2024 00:05:26 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F0163
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521926; cv=none; b=WspiQurveEUDS20h52RJfCn614yVDjpfcFTOPUKwZed9ONT7RryGNrfzpHG6zrbu8dEu8KsOCHhsVRmU3uwizFnCV2bJqRjNw+SFzAG/awCZMsUrCZfGwrHLCLMur2ftu/icPtkhaQtms0HUgxpfMe+79DaUDGtBP7okSH7uyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521926; c=relaxed/simple;
	bh=xoT+UJkJG+lxyRa60Owza3mn+OsosmSKPLvUo549pXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=buKWDGmNJbu+HBPxrWbffuPUGzUX2jvq+krteGImJPEsCY0q9ODhL7guxr2zrq6OSnbLuYlfTPGTgnJmCaUWXM9znOMC28hwGyPSq7rf+n+27P9FislEADmPFwgVQtxBgJXNNlkxw1BT8bnE7nttAJTmu0Jey5c6YiI6sAZ8C5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.115])
	by sina.com (172.16.235.25) with ESMTP
	id 66318735000014BE; Wed, 1 May 2024 08:05:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 48427634210290
X-SMAIL-UIID: CA5B7832F9D748CAAA841ECD24C5BD8D-20240501-080511-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2660b9135e6144ca41a5@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] [usb?] INFO: trying to register non-static key in skb_dequeue (3)
Date: Wed,  1 May 2024 08:05:14 +0800
Message-Id: <20240501000514.1552-1-hdanton@sina.com>
In-Reply-To: <0000000000006ca6cc061751a86a@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 08:02:25 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    3f12222a4beb usb: dwc3: core: Fix compile warning on s390 ..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118eeccf180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git  usb-testing

--- x/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ y/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -171,6 +171,7 @@ static int _rtl_usb_init_tx(struct ieee8
 	u32 i;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
+	int err = 0;
 
 	rtlusb->max_bulk_out_size = IS_HIGH_SPEED_USB(rtlusb->udev)
 						    ? USB_HIGH_SPEED_BULK_SIZE
@@ -185,7 +186,8 @@ static int _rtl_usb_init_tx(struct ieee8
 		if (!ep_num) {
 			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
 				"Invalid endpoint map setting!\n");
-			return -EINVAL;
+			err = -EINVAL;
+			break;
 		}
 	}
 
@@ -203,7 +205,7 @@ static int _rtl_usb_init_tx(struct ieee8
 		skb_queue_head_init(&rtlusb->tx_skb_queue[i]);
 		init_usb_anchor(&rtlusb->tx_pending[i]);
 	}
-	return 0;
+	return err;
 }
 
 static void _rtl_rx_work(struct tasklet_struct *t);
@@ -236,7 +238,7 @@ static int _rtl_usb_init(struct ieee8021
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_usb_priv *usb_priv = rtl_usbpriv(hw);
 	struct rtl_usb *rtlusb = rtl_usbdev(usb_priv);
-	int err;
+	int err, rc;
 	u8 epidx;
 	struct usb_interface	*usb_intf = rtlusb->intf;
 	u8 epnums = usb_intf->cur_altsetting->desc.bNumEndpoints;
@@ -286,7 +288,9 @@ static int _rtl_usb_init(struct ieee8021
 	/* usb endpoint mapping */
 	err = rtlpriv->cfg->usb_interface_cfg->usb_endpoint_mapping(hw);
 	rtlusb->usb_mq_to_hwq =  rtlpriv->cfg->usb_interface_cfg->usb_mq_to_hwq;
-	_rtl_usb_init_tx(hw);
+	rc = _rtl_usb_init_tx(hw);
+	if (!err)
+		err = rc;
 	_rtl_usb_init_rx(hw);
 	return err;
 }
--

