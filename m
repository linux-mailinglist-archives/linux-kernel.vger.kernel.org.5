Return-Path: <linux-kernel+bounces-41600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E223583F52E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2045D1C20F93
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C1200AA;
	Sun, 28 Jan 2024 11:28:40 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE981F60B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706441320; cv=none; b=if6APmdKwEBoOAuZl105U04cjWfXozmPdt39MaRdN+x2W9VJYB7yv7Gl60Rv8ALAsvI8p6UlhL0aA66BJxIqtHFhNuAbJKOodZH0cwYHbtMd5cCmxte9Sgu7MSEIMXBNxrGuS6mYvWrFadJoF2Qm1dANFkR9tBX58WdFJd4NvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706441320; c=relaxed/simple;
	bh=pgM5f+lftG3/Fldgk+3owBs7XN3I/60sQYwS/xInNkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNlAevycfnal8SwMx22ojzUiYlJwXZTrPb1fPLHg4/Fx6O4uQfIa4AQplL21UTwNk3Ioc/JgjaMOyu7cQNvkEiIb2Va6oO2m78NTXW6XuEs16vJ+Wl9ZUZ4BerBWBo8dWQBNKPUtIAVI0bXTKOV97VLV+ggIR2rM/3myIVMlTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.210])
	by sina.com (172.16.235.24) with ESMTP
	id 65B63A5500003E03; Sun, 28 Jan 2024 19:28:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 74785645089398
X-SMAIL-UIID: A654D357F48240759A5F1057ED89CDA1-20240128-192824-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Date: Sun, 28 Jan 2024 19:28:15 +0800
Message-Id: <20240128112815.1161-1-hdanton@sina.com>
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
--- x/include/net/bluetooth/hci_core.h
+++ y/include/net/bluetooth/hci_core.h
@@ -797,7 +797,10 @@ struct hci_chan {
 	struct list_head list;
 	__u16 handle;
 	struct hci_conn *conn;
-	struct sk_buff_head data_q;
+	union {
+		struct sk_buff_head 	data_q;
+		struct rcu_head 	rcu;
+	};
 	unsigned int	sent;
 	__u8		state;
 	bool		amp;
--

