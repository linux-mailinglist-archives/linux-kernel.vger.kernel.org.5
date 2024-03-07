Return-Path: <linux-kernel+bounces-95356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ECB874CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BC52827E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB1685641;
	Thu,  7 Mar 2024 10:49:19 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B485297
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808558; cv=none; b=fr4pbT9EW21Z+A4a+O7TzvxSmIxrxHzGcG4EMZ0sFbGgy9SpH/VUL0GR526j7rKK9P+QuTCRHb1Udtv5rN0ygg+bMQETnWiqdMQYxwtBdz0dNSzV1avP9yRn093kJQjhicD7puedJYCVxt4+1CR3d0bTcs37OoJDL0eFuSnMXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808558; c=relaxed/simple;
	bh=B2yfE5rq7HBRCiUWnZpz62MsCO2H8vMLjJtsiwxLWjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IfZfoAVIW0L5y9JAd8a/jx6d17W9v7vp2zL8UHfNSgCNt3aOLSXl8fRZDUn/5Yf2RhIQhcwbeJg4VGYU/ggE2Uz4eu3zUlFBVcHbZ+UkoNGx5w4WbHUjiVyDrDj7EnIcsUgat4bJnIIogumG0h1nYZ9MYPQfh5CzgpMlhbhyxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.201])
	by sina.com (172.16.235.24) with ESMTP
	id 65E99BA100006DEB; Thu, 7 Mar 2024 18:49:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 56190045089280
X-SMAIL-UIID: 7D573C995DB342E8934AA9F009DB8D77-20240307-184909-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+96127c74434e19e4609d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb] INFO: rcu detected stall in newfstatat (3)
Date: Thu,  7 Mar 2024 18:48:57 +0800
Message-Id: <20240307104857.1530-1-hdanton@sina.com>
In-Reply-To: <000000000000a4bb3506130e9bc5@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 07 Mar 2024 01:22:01 -0800
> syzbot has bisected this issue to:
> 
> commit c2368b19807affd7621f7c4638cd2e17fec13021
> Author: Jiri Pirko <jiri@nvidia.com>
> Date:   Fri Jul 29 07:10:35 2022 +0000
> 
>     net: devlink: introduce "unregistering" mark and use it during devlinks iteration
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14dc6736180000
> start commit:   29cd507cbec2 Merge tag 'integrity-v6.8-fix' of git://git.k..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f691a6180000

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

