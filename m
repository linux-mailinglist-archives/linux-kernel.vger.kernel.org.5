Return-Path: <linux-kernel+bounces-144048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7288A413C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C361C21247
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B7C1AAA5;
	Sun, 14 Apr 2024 08:31:05 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91064442F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083465; cv=none; b=lBe01dhmzDdaB3janbBibkpKqSow7xc3nMEZiDZft9uj82EJOrRc9+pBdoXsfcYhkt0Dg/EInFPMKtDwcA67i0VCYEe7QwNwJ+EHkhaQY65L/GUIDIXWpYgccWyHb7xp9CjvbuCnWwAaPtguBto9cF6JmUQjZrOUeaiFV7dx1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083465; c=relaxed/simple;
	bh=NnwDiBQtYVV7ljXU6v7Fyo8ljCpiD5v5/ka0GfK5V+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuBch7DLEDvlsZpE2V0s2UvMmGnHFETw5NCem+PaCu6xCVkbAQRSMYlVHI4GHvxbLTh4x1r91QO7S1TcJXh22boKHnWwimh+habXOq4BTby1m6fdw2pHmi1rZnOIgnrh6Y/krbXBHwRbnArWd1GjUXab5wzuRUj5bNKBnuSJDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.190])
	by sina.com (172.16.235.24) with ESMTP
	id 661B943A00002B01; Sun, 14 Apr 2024 16:30:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7145845089449
X-SMAIL-UIID: A17B53C737FB4A6693E4633CBA172864-20240414-163052-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d6282a21a27259b5f7e7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_set_handle
Date: Sun, 14 Apr 2024 16:30:44 +0800
Message-Id: <20240414083044.2191-1-hdanton@sina.com>
In-Reply-To: <000000000000ec64cd0616084ae9@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Apr 2024 23:05:32 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162d4723180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  480e035fc4c7

--- x/net/bluetooth/hci_event.c
+++ y/net/bluetooth/hci_event.c
@@ -6902,7 +6902,7 @@ static void hci_le_create_big_complete_e
 					   struct sk_buff *skb)
 {
 	struct hci_evt_le_create_big_complete *ev = data;
-	struct hci_conn *conn;
+	struct hci_conn *conn, *next;
 	__u8 i = 0;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
@@ -6912,38 +6912,29 @@ static void hci_le_create_big_complete_e
 		return;
 
 	hci_dev_lock(hdev);
-	rcu_read_lock();
-
 	/* Connect all BISes that are bound to the BIG */
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+	list_for_each_entry_safe(conn, next, &hdev->conn_hash.list, list) {
 		if (bacmp(&conn->dst, BDADDR_ANY) ||
 		    conn->type != ISO_LINK ||
 		    conn->iso_qos.bcast.big != ev->handle)
 			continue;
 
-		if (hci_conn_set_handle(conn,
-					__le16_to_cpu(ev->bis_handle[i++])))
+		if (hci_conn_set_handle(conn, __le16_to_cpu(ev->bis_handle[i++])))
 			continue;
 
 		if (!ev->status) {
 			conn->state = BT_CONNECTED;
 			set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
-			rcu_read_unlock();
 			hci_debugfs_create_conn(conn);
 			hci_conn_add_sysfs(conn);
 			hci_iso_setup_path(conn);
-			rcu_read_lock();
 			continue;
 		}
 
 		hci_connect_cfm(conn, ev->status);
-		rcu_read_unlock();
 		hci_conn_del(conn);
-		rcu_read_lock();
 	}
 
-	rcu_read_unlock();
-
 	if (!ev->status && !i)
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
@@ -6952,7 +6943,6 @@ static void hci_le_create_big_complete_e
 		 */
 		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
 				   UINT_PTR(ev->handle), NULL);
-
 	hci_dev_unlock(hdev);
 }
 
--

