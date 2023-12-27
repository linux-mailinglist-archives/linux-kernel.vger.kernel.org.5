Return-Path: <linux-kernel+bounces-11999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0B681EEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBA9B211D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565DB446C0;
	Wed, 27 Dec 2023 11:53:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A87446AF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.138])
	by sina.com (172.16.235.24) with ESMTP
	id 658C0F80000069D4; Wed, 27 Dec 2023 19:50:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 93537145089319
X-SMAIL-UIID: E187295F068C4AC89C1FD51D436C22B2-20231227-195026-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d6cd076b385aefcb6b16@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] WARNING in l2cap_do_send (2)
Date: Wed, 27 Dec 2023 19:50:13 +0800
Message-Id: <20231227115014.1612-1-hdanton@sina.com>
In-Reply-To: <00000000000081a088060d7190cb@google.com>
References: <00000000000081a088060d7190cb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Dec 2023 14:54:27 -0800
> HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14125c81e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/bluetooth/hci_core.c
+++ y/net/bluetooth/hci_core.c
@@ -3237,7 +3237,13 @@ void hci_send_acl(struct hci_chan *chan,
 
 	hci_queue_acl(chan, &chan->data_q, skb, flags);
 
-	queue_work(hdev->workqueue, &hdev->tx_work);
+	rcu_read_lock();
+	if (test_bit(HCI_RESET, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
+		;
+	else
+		queue_work(hdev->workqueue, &hdev->tx_work);
+	rcu_read_unlock();
 }
 
 /* Send SCO data */
--

