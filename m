Return-Path: <linux-kernel+bounces-96837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36367876207
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03741F22C8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365FF54F94;
	Fri,  8 Mar 2024 10:34:02 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4FA3FBB6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894041; cv=none; b=uAQ/2jF047PyNfZbJTwh6ipPmCaE9c98S6iTQM0+3ddlo45eI7rxkW1yYexyFZvCmdNFx5pWA9flMq1Gw28mNbAfrbwoHQ26F9u2NuTsjzMiBPNvuXWE8OpmK4BgL7wc/xwhRQrMCVRt+MWmBgFErN1MHO5m/WvMNJbrEtok/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894041; c=relaxed/simple;
	bh=aX6PYg0PF3r+7Yum+f4L2Mn9y5rDseZ4DOtdqbOQ2ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KwEb/HIrgZEIKq5bUAl6PI0aBnr9O3doyFGOhmFNjE91Awl0D4MLOcc8PYDOIGN1FGVT5U3/Lvkyz/7KB+QCdiCBNS9If0QGzvXwPD3efmZYaQFxgRpL8CacOSIqILYCKBhxnz7P5PcQlAA7MfhNhmkugrx0qWKB+1WCsIXZt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.186])
	by sina.com (10.75.12.45) with ESMTP
	id 65EAE98800009EC3; Fri, 8 Mar 2024 18:33:47 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 54591931457941
X-SMAIL-UIID: 6EEAD8EDB86542B7AF578B9EC0E32228-20240308-183347-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a68ef3b1f46bc3aced5c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode (2)
Date: Fri,  8 Mar 2024 18:33:36 +0800
Message-Id: <20240308103336.1587-1-hdanton@sina.com>
In-Reply-To: <000000000000081ff305f0b14072@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Dec 2022 17:42:37 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12569d7f880000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/media/rc/imon.c
+++ y/drivers/media/rc/imon.c
@@ -1758,6 +1758,7 @@ static void usb_rx_callback_intf0(struct
 
 	switch (urb->status) {
 	case -ENOENT:		/* usbcore unlink successful! */
+	case -EPROTO:
 		return;
 
 	case -ESHUTDOWN:	/* transport endpoint was shut down */
--

