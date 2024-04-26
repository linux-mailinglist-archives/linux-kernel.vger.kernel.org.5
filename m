Return-Path: <linux-kernel+bounces-159866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CDC8B3543
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1161F21FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE69143C5F;
	Fri, 26 Apr 2024 10:27:00 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A3714430A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127220; cv=none; b=sGt+7D78khejfydTmK0pxvXMnuAwaRzqrtsD6jQcGQhrR97BqJJZikwVOGOrRGRfcRJGTv10XjFCNpwLw9ap8XkmOJYc09QzR+r50vYaguLPrQGYFpjIyWNma/t7JZqnWaV/n4eRxLh8ybK3b8S/kh812WcL31AeaHAG2ogDqRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127220; c=relaxed/simple;
	bh=br2HyJl4Bcv+omT3QOE5aVFKe/V2TKFM8NowkzfJfUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EW/efZuAfe9BxOIoy6e+c/b7oAC9OM3rhp82ux6hZqYKApd+RPfffeJurTTcJ4oi0o+VJCXX1gqgichl7Z0Mwm+wk1R3hrmgJvVrRUA+7btSD9EIq64A96VhAP5Tg0KwtUEX63jqnhkA58Ukjjc6/5SU9Z3fC4pf/VbQd+eMggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.235])
	by sina.com (172.16.235.24) with ESMTP
	id 662B816100007EF6; Fri, 26 Apr 2024 18:26:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 31634945089237
X-SMAIL-UIID: 4845EC6DC0D841EA8DA68D22410E1A3D-20240426-182645-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c6a1953c27ace6cc34e5@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] WARNING in wdm_rxwork/usb_submit_urb (2)
Date: Fri, 26 Apr 2024 18:26:44 +0800
Message-Id: <20240426102644.3298-1-hdanton@sina.com>
In-Reply-To: <00000000000092e8f90616e4627f@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Apr 2024 21:40:22 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    a160e1202ca3 usb: dwc3: qcom: Add multiport suspend/resume..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166f3d27180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git  usb-testing

--- x/drivers/usb/class/cdc-wdm.c
+++ y/drivers/usb/class/cdc-wdm.c
@@ -262,6 +262,10 @@ static void wdm_int_callback(struct urb
 		case -ECONNRESET:
 			return; /* unplug */
 		case -EPIPE:
+			if (test_bit(WDM_INT_STALL, &desc->flags)) {
+				clear_bit(WDM_INT_STALL, &desc->flags);
+				return;
+			}
 			set_bit(WDM_INT_STALL, &desc->flags);
 			dev_err(&desc->intf->dev, "Stall on int endpoint\n");
 			goto sw; /* halt is cleared in work */
@@ -272,6 +276,9 @@ static void wdm_int_callback(struct urb
 		}
 	}
 
+	if (test_bit(WDM_INT_STALL, &desc->flags))
+		clear_bit(WDM_INT_STALL, &desc->flags);
+
 	if (urb->actual_length < sizeof(struct usb_cdc_notification)) {
 		dev_err(&desc->intf->dev, "wdm_int_callback - %d bytes\n",
 			urb->actual_length);
@@ -311,11 +318,12 @@ static void wdm_int_callback(struct urb
 		&& !test_bit(WDM_DISCONNECTING, &desc->flags)
 		&& !test_bit(WDM_SUSPENDING, &desc->flags)) {
 		rv = usb_submit_urb(desc->response, GFP_ATOMIC);
+		if (rv)
+			clear_bit(WDM_RESPONDING, &desc->flags);
 		dev_dbg(&desc->intf->dev, "submit response URB %d\n", rv);
 	}
 	spin_unlock_irqrestore(&desc->iuspin, flags);
 	if (rv < 0) {
-		clear_bit(WDM_RESPONDING, &desc->flags);
 		if (rv == -EPERM)
 			return;
 		if (rv == -ENOMEM) {
--

