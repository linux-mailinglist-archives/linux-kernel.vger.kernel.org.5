Return-Path: <linux-kernel+bounces-109473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34C8819A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFCAB21D30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9F8595C;
	Wed, 20 Mar 2024 22:50:03 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3F32C88
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975003; cv=none; b=iwHMmB2kC5UzI2kwPa6FSCYTAhmeBYjc4Qt7sHLje+bRmFDzYdG747LonRXwizNn3DvTAs1VA+9bjjHlr9HiCARh2KFMRzhpWKljOlVyuYTqfz20wQs8RFTzUfkAFM/zRIQV+N3vgyFDrrr1+JRcNtTRDAYJ2hcxnFw1tfyZADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975003; c=relaxed/simple;
	bh=On2AzfDeN4B3k/XnwmCN1N/+9YLkMTOakIN/VPeRG1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JsArnh5oiA470+QUXw7ZEvnDRCPnfkpUSB+lRQ1mytjIVwk2l8eqQDo92c1Zg0bRXUR0gNEePnM7SPjjeEsF49cQ4jnzMxpxPN82nrhGk8ZnG59Yg+J0/pl1ZwO9Z1zoT6kahNQrWM+khS+pYfwL6mY4rS6MxwE3fcN29PhqZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.196])
	by sina.com (172.16.235.25) with ESMTP
	id 65FB68100000637A; Wed, 21 Mar 2024 06:49:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 69503634210382
X-SMAIL-UIID: 740C06F9A10E49C688B1BCE877755D81-20240321-064954-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f311e026553fee3459a0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in hrtimer_run_queues
Date: Thu, 21 Mar 2024 06:49:46 +0800
Message-Id: <20240320224946.2298-1-hdanton@sina.com>
In-Reply-To: <0000000000004b02a206140b016b@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Mar 2024 15:29:19 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    ea80e3ed09ab net: ethernet: mtk_eth_soc: fix PPE hanging i..
> git tree:       net
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c64e31180000

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

