Return-Path: <linux-kernel+bounces-12617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC9F81F7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E05D1F225A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487396FCF;
	Thu, 28 Dec 2023 11:39:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484406FBE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.182])
	by sina.com (172.16.235.25) with ESMTP
	id 658D5DE200004E96; Thu, 28 Dec 2023 19:37:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 17714734210344
X-SMAIL-UIID: 417FC9C255D24E9990460A3C094297CE-20231228-193710-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d6cd076b385aefcb6b16@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] WARNING in l2cap_do_send (2)
Date: Thu, 28 Dec 2023 19:36:57 +0800
Message-Id: <20231228113657.1673-1-hdanton@sina.com>
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
@@ -3235,9 +3235,12 @@ void hci_send_acl(struct hci_chan *chan,
 
 	BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
 
+	if (!mutex_trylock(&hdev->req_lock))
+		return;
 	hci_queue_acl(chan, &chan->data_q, skb, flags);
 
 	queue_work(hdev->workqueue, &hdev->tx_work);
+	mutex_unlock(&hdev->req_lock);
 }
 
 /* Send SCO data */
--

