Return-Path: <linux-kernel+bounces-112510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E941887AB2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F244D1F213A5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592BA5B666;
	Sat, 23 Mar 2024 22:47:27 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B115CB5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711234046; cv=none; b=k+IATebPfq6VhbvL/0lavoQpR+Hq9xK72WCRpnDXeB8pO8CRY2Vj/HKRutY3Ljj0YXJU0BUMGPXVCwk8u9jIHbfXvwilHC2yVel3FeDgBO1iTI2/mDXqVqlhxf2yyvRo4WeQpgFrbIqNnbOUEMDC1K60xe5i38Z/kqWqP2OoBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711234046; c=relaxed/simple;
	bh=qmpifuZ9FetFF2yzVcFaw9ODKGMn6JCSt0z3HlZrlVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uU80Tx/LVAEp3GpONzfZyvMBk+vKgQppaL7SkWoVO6Tberof3RZQok3n8R7FJvUvGhjcxb8Gy/j1q9ILLDvcESaov1ChaIFGi9NKgXqBjKkP6222c4+jCTdulf7HerZ0hM9MoR9rgDP6gC4EQkXxqJKgbsQK/D9uno4wrsiLEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.171])
	by sina.com (172.16.235.24) with ESMTP
	id 65FF5BEB000006B9; Sat, 24 Mar 2024 06:47:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 0786845089258
X-SMAIL-UIID: 5FC8FF47085C4E5C9330908AEF772146-20240324-064710-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
Date: Sun, 24 Mar 2024 06:46:57 +0800
Message-Id: <20240323224657.2722-1-hdanton@sina.com>
In-Reply-To: <000000000000901b1c0614010091@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git  ea80e3ed09ab

--- x/net/core/sock_map.c
+++ y/net/core/sock_map.c
@@ -932,11 +932,12 @@ static long sock_hash_delete_elem(struct
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
+	unsigned long flags;
 
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	spin_lock_bh(&bucket->lock);
+	spin_lock_irqsave(&bucket->lock, flags);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -944,7 +945,7 @@ static long sock_hash_delete_elem(struct
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	spin_unlock_bh(&bucket->lock);
+	spin_unlock_irqrestore(&bucket->lock, flags);
 	return ret;
 }
 
@@ -1143,6 +1144,8 @@ static void sock_hash_free(struct bpf_ma
 	 */
 	synchronize_rcu();
 	for (i = 0; i < htab->buckets_num; i++) {
+		unsigned long flags;
+
 		bucket = sock_hash_select_bucket(htab, i);
 
 		/* We are racing with sock_hash_delete_from_link to
@@ -1151,11 +1154,11 @@ static void sock_hash_free(struct bpf_ma
 		 * exists, psock exists and holds a ref to socket. That
 		 * lets us to grab a socket ref too.
 		 */
-		spin_lock_bh(&bucket->lock);
+		spin_lock_irqsave(&bucket->lock, flags);
 		hlist_for_each_entry(elem, &bucket->head, node)
 			sock_hold(elem->sk);
 		hlist_move_list(&bucket->head, &unlink_list);
-		spin_unlock_bh(&bucket->lock);
+		spin_unlock_irqrestore(&bucket->lock, flags);
 
 		/* Process removed entries out of atomic context to
 		 * block for socket lock before deleting the psock's
--

