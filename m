Return-Path: <linux-kernel+bounces-109502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7C881A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6802826D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2474E8615C;
	Wed, 20 Mar 2024 23:50:29 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F21E87E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978628; cv=none; b=qSUkHfdNdm15Rkl1IFCVY3CpG4ZhF8uaVVbtUUFdhrvLkFIGVLcvH+62SBbBusPB9VO5qsUsN4nYlEkcLng7bfmAyGUfCXbMIkovM+h4babTNnPvkXqa1U0yoHE4z3dS5TWhy/QyzqBxpkJMKayq4BeK/gA8W126K/ICmcvpQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978628; c=relaxed/simple;
	bh=qmpifuZ9FetFF2yzVcFaw9ODKGMn6JCSt0z3HlZrlVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pSdF2NwDAjCbC4ocxugDy6bjzBDkklXzbvOts6iiudAd0gM1EH8JrPQHrlAZDALe3DJkcQoqh2N4wUnacbXj7y9NpDF5gNpoGabUGLiyIMUp6/pJRiCJTJ/cmgsDqla1A8T9Br08RXW3Aztk1CoQJTiRB1qopH1NI5Oc60rObUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.196])
	by sina.com (10.75.12.45) with ESMTP
	id 65FB75A300004886; Wed, 21 Mar 2024 07:47:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 0724831457815
X-SMAIL-UIID: B0138A16936A43E8A2ADCB001EB5BA36-20240321-074749-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8627369462e8429d7cd6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in wq_worker_tick
Date: Thu, 21 Mar 2024 07:47:41 +0800
Message-Id: <20240320234741.2355-1-hdanton@sina.com>
In-Reply-To: <000000000000d8fd6b06141e73a4@google.com>
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

