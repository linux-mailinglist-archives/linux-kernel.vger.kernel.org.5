Return-Path: <linux-kernel+bounces-134659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A5489B48E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576AD2811DF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09920433C4;
	Sun,  7 Apr 2024 23:14:39 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210263C082
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712531678; cv=none; b=A7HviHzaJ0OTgRFcigZhb4IbwGhF+q7qvDXv13kFxj1vI5qfatERYzKgdpPdgH3O/2HfEfgy8bWncNwklZf+6btzoPl93wjBKYsWa2kHZUdkbQo0SHBGYQu/zxD+l9GBZ1UcXLOqm21gGlx62qPkQ7AFV3tWpgTwyl7/v3YU6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712531678; c=relaxed/simple;
	bh=rGNxiYu9623nkOVlm/CHilWFaJtBntC4ZWb8wmpUzfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D2ZTpddH4A2eY6NsSAr/5GI3XCjMkiEp83NZn1hUrbDHFGuIiD4ATrk3M6wGiXmTQYZ5j43KIHgA/mnRxgnV4T4ZR1vgdwBF6Q8SGDfu52n7fJPb2UKZSeV4hRlSiH/9OB4d0pC5y69sMZKYDBjA+q3EoHxqzr3jBzlkF5cba/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.52])
	by sina.com (10.75.12.45) with ESMTP
	id 661328CD0000354F; Sun, 8 Apr 2024 07:14:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 26141931457857
X-SMAIL-UIID: F196EB0C01EB4835BDE4FB578B7D6778-20240408-071424-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
Date: Mon,  8 Apr 2024 07:14:14 +0800
Message-Id: <20240407231414.1496-1-hdanton@sina.com>
In-Reply-To: <000000000000dd84650615800e67@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 07 Apr 2024 04:33:29 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ee2e75180000

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

