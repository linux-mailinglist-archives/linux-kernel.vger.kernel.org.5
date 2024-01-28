Return-Path: <linux-kernel+bounces-41575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF93583F4C1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6A01F217AD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B8DF60;
	Sun, 28 Jan 2024 09:18:05 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681BBDF4D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706433485; cv=none; b=Z/9KKY0BQQcr4GERh+epVG9erXTUX/vEFPFOBq3WLFffvoG711HJ/vXs+AXtPKw9R+46HhYQCCBCkCpF/XZU+clOI0mctBx9Dq9zzCFEnz1TnC89naXAisXA8m3fSLN/nf9+nmFX5oTKjhX7S5oxORCilxmqLa4voYxJRUc6t0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706433485; c=relaxed/simple;
	bh=A3N8OrusEIYjLUn0naVced/+/Z2BwOQ7Z06AKu8bBl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcK/teCKbXWIXyS6ZDQW7DuqV3EJWzn+Hk0bC1Gyafrp/aTCIB6o3EWjmZg/BnS6x6rV4lJREy111cRvixZNH/AGIR1ah/qt0hwMr8wDBlF6myUhR7GPX1iYL75wZtiBx4kA+YgwiTN1jeTW1v2J09jU+DJOTEe7b/jZ0WupELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.210])
	by sina.com (172.16.235.25) with ESMTP
	id 65B61B2F000025A1; Sun, 28 Jan 2024 17:15:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 43148934210408
X-SMAIL-UIID: 381565D755044C2587314952ADBB638B-20240128-171531-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Date: Sun, 28 Jan 2024 17:15:21 +0800
Message-Id: <20240128091521.1102-1-hdanton@sina.com>
In-Reply-To: <000000000000ba736b060ff5da23@google.com>
References: <000000000000ba736b060ff5da23@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jan 2024 15:34:31 -0800
> HEAD commit:    7ed2632ec7d7 drm/ttm: fix ttm pool initialization for no-d..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116e5bbfe80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/include/net/bluetooth/hci_core.h
+++ y/include/net/bluetooth/hci_core.h
@@ -758,7 +758,10 @@ struct hci_conn {
 
 	unsigned int	sent;
 
-	struct sk_buff_head data_q;
+	union {
+		struct sk_buff_head 	data_q;
+		struct rcu_head 	rcu;
+	};
 	struct list_head chan_list;
 
 	struct delayed_work disc_work;
--- x/net/bluetooth/hci_conn.c
+++ y/net/bluetooth/hci_conn.c
@@ -2819,16 +2819,13 @@ void hci_chan_del(struct hci_chan *chan)
 	BT_DBG("%s hcon %p chan %p", hdev->name, conn, chan);
 
 	list_del_rcu(&chan->list);
-
-	synchronize_rcu();
-
 	/* Prevent new hci_chan's to be created for this hci_conn */
 	set_bit(HCI_CONN_DROP, &conn->flags);
 
 	hci_conn_put(conn);
 
 	skb_queue_purge(&chan->data_q);
-	kfree(chan);
+	kfree_rcu(chan, rcu);
 }
 
 void hci_chan_list_flush(struct hci_conn *conn)
--

