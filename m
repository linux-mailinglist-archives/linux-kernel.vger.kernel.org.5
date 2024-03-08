Return-Path: <linux-kernel+bounces-96977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5191E876406
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5DA4B223E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A483535CA;
	Fri,  8 Mar 2024 12:09:52 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4618557880
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899791; cv=none; b=VWofeN+Y5OckW5bZAO1Jcoye1v4X24Ae3jMgIC/QHFElxA0xD21bC98ZzzXk3wYAVpHwVjoRHgRxwLEnT54mZjlgdrGthER28/HpMCBDhQJMAhBfIDitvlAzhCuz5N+LN9DIM/fmG3H9dv22DjtjTOjNXa9mJGB+8lvZrDJuYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899791; c=relaxed/simple;
	bh=qAjGdgYAZ5gXnXvfvJoY9hUIxV78LOQSHo/7T1A2Ln0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+2m9EepYtxbJ6T+fW1/SC539825NFcMSCGQpanhc1OTbv8U3d4ktCYEBLfc1R3NghzJxmgWN5Bvka8VSuNOiVRCh1v0KJWKUmAiY3BKtIfi9JGAYHapARAaqHOVVho65fkBYkWv2Pof35Uxh0mxxKxpOBBK64bEYGPotBC2OgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.223])
	by sina.com (172.16.235.24) with ESMTP
	id 65EB0002000041DB; Fri, 8 Mar 2024 20:09:40 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 82321545089465
X-SMAIL-UIID: F6EE870248784DB281733AB3491D99A0-20240308-200940-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a68ef3b1f46bc3aced5c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode (2)
Date: Fri,  8 Mar 2024 20:09:30 +0800
Message-Id: <20240308120930.1718-1-hdanton@sina.com>
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
--- x/net/batman-adv/network-coding.c
+++ y/net/batman-adv/network-coding.c
@@ -397,6 +397,7 @@ static void batadv_nc_purge_orig_hash(st
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
 	u32 i;
+	int loop = 0;
 
 	if (!hash)
 		return;
@@ -406,9 +407,14 @@ static void batadv_nc_purge_orig_hash(st
 		head = &hash->table[i];
 
 		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_node, head, hash_entry)
+		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
 			batadv_nc_purge_orig(bat_priv, orig_node,
 					     batadv_nc_to_purge_nc_node);
+			if (++loop > 20) {
+				rcu_read_unlock();
+				return;
+			}
+		}
 		rcu_read_unlock();
 	}
 }
@@ -433,6 +439,7 @@ static void batadv_nc_purge_paths(struct
 	struct batadv_nc_path *nc_path;
 	spinlock_t *lock; /* Protects lists in hash */
 	u32 i;
+	int loop = 0;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -441,6 +448,10 @@ static void batadv_nc_purge_paths(struct
 		/* For each nc_path in this bin */
 		spin_lock_bh(lock);
 		hlist_for_each_entry_safe(nc_path, node_tmp, head, hash_entry) {
+			if (++loop > 20) {
+				spin_unlock_bh(lock);
+				return;
+			}
 			/* if an helper function has been passed as parameter,
 			 * ask it if the entry has to be purged or not
 			 */
@@ -675,6 +686,7 @@ batadv_nc_process_nc_paths(struct batadv
 	struct batadv_nc_path *nc_path;
 	bool ret;
 	int i;
+	int loop = 0;
 
 	if (!hash)
 		return;
@@ -686,6 +698,10 @@ batadv_nc_process_nc_paths(struct batadv
 		/* Loop coding paths */
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(nc_path, head, hash_entry) {
+			if (++loop > 20) {
+				rcu_read_unlock();
+				return;
+			}
 			/* Loop packets */
 			spin_lock_bh(&nc_path->packet_list_lock);
 			list_for_each_entry_safe(nc_packet, nc_packet_tmp,
--

