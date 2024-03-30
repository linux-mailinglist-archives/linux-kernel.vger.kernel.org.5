Return-Path: <linux-kernel+bounces-125672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A568E892A67
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449F21F22550
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9333D28385;
	Sat, 30 Mar 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tmsLZ2Ij"
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06329200D3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711794517; cv=none; b=Z3q22sazFmkkGQrrKvpwR/O9QezFiTp1kzCkvfj6wyeONysNGvUw97QCk9QoIqjH6VmKD2KsywIceQAwPjIfAY3VFJ5O9zow8iaEH8X1k6fTPstC1MDPtF4vu5O20LveGLQrgCl8pAKDgQe+tb6xx7XnZlGgQklvCGaoneUmvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711794517; c=relaxed/simple;
	bh=DdGUyesaO29yiBX/6HJDE8z0HBqTtJ9YYSMchMWJ5HA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iCQoZGOX5BMoN8JExKzvKLpybqrojKYNNnQ+ijS4yEIRTobzy3HKY0Bv6T+szURsOGoRGsJRFwdWo/kjHN3W9ST/shzBh2FpHlEwRaLe/Qd6ztpq8ZliF6caNGmPi3fPyCI5wX+Q9ht8Rbs07gsj/yLx4GZneP7SzWY/4amheWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tmsLZ2Ij; arc=none smtp.client-ip=203.205.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711794206; bh=hKEL/Mq9N7QkXbDIOwRVt/wzqWM4PFux90WD/Id7GkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tmsLZ2IjpNu92RXJ+n9Ior9FKz2zMnKukudYezh5fGzKlWAyIQ4Fnmpb9kkDFC1qo
	 4MBcH6vJd7UiBr2GJPDuM63TBQxv/xUvbh2cyX+2jEtSkKBlSLQHRkPFxOxzB3zKaW
	 88//KpwKBCRRQITXE7/KrgRtFjFrU+aNSNfS7GWI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 5D8ACCE3; Sat, 30 Mar 2024 18:23:24 +0800
X-QQ-mid: xmsmtpt1711794204tcy70wsu4
Message-ID: <tencent_F5284B3A74AB762167143CC936FE968C3609@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wHYXFAfj21zDpfbfsUj/ZMbMrj+5pQx7AaknTU+/HqQi0SzMyVJ
	 mCKAP9IteLMjU6XH2knW0B+BUt8Egfnu0pj4Y3LQIA6cfPvm+0Sviu6j3ShY9bQ1ec9Oob++o6cF
	 ij7srQ+fFXfscgb8jQ6tRQIYKPNpwCMq9hxotcHzC+O+asnmhI0h3Fk2Oi20TqEo1pJSaWo1jHW/
	 HxmssSI/SYHXz0d9AScAugVya1Pi/JCRLdeGQleVJSXEr/E62yXuh8+dL2L1MkoFek8f1SZqF12v
	 HLHwCUIbiIQrJVLFoDRSnC4JBz+KsVdgPjgw4JNMUdZyBfdCAYjFSQWhu8Q+HtXaWQTllNaKARRq
	 DDAPYnDU0mGGlCElD85P0U9F8QELYrgsFubE6lc2I4NWJHkjJCLpOvQt84dhqHp6+XBKKlLpJ5Bp
	 FWOuVJzvJjlXgnfiyvKfltLaG7YU+MUEwVmGLCulXvBnAd5ws8NBlgG1zNf2XjC7/BlAnk7b7c3h
	 h4A/UFUWM4f7ki8X9TK6j9PAi4Tcstp4gXjOjxcg4lE1PzxcHOaZFwt8DHVJo51XTyQ7A+iiNpsj
	 BNrnXSzPqWQT0tF0TknsUYAtAp+DqRJu/QCtDxOk2varIYHnwqWySrE4ivXqLwdabX75iqakqTr1
	 KIkT6FZi3tecEsvDGxzlByHtsFN2RH779mJvbwmIj0H1za7NrD/ZlNjL4hb0NkWyFfd6YACoT5L7
	 YgyxZzl0AW0emd5qciAx/5e2flCPjSXQMMs4N2hreHNc1it+RJCspOJbmRgpXDvk4VQOw6zqRYih
	 uiTYva3P2IZpfd3kGm48XlwIDb79cCxJ6VMwX9OUl2+Oi0oWcXbhkRSwbNTX38zlf5f1t4f8Y2ti
	 Yy8CBJRnoy/gONWQRuHo7INaEIKsrA86V0mrrCAHZwySGKtykvQQsH73V1ROwN2jIl92wkVD6OLt
	 T9cfDbjK4=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e4374f6c021d422de3d1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in tick_setup_sched_timer
Date: Sat, 30 Mar 2024 18:23:25 +0800
X-OQ-MSGID: <20240330102324.321478-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004fbc7a0614cc4eb9@google.com>
References: <0000000000004fbc7a0614cc4eb9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test dl in tick_setup_sched_timer

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..ae8f81b26e16 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -932,11 +932,12 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
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
@@ -944,7 +945,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	spin_unlock_bh(&bucket->lock);
+	spin_unlock_irqrestore(&bucket->lock, flags);
 	return ret;
 }
 
@@ -1136,6 +1137,7 @@ static void sock_hash_free(struct bpf_map *map)
 	struct bpf_shtab_elem *elem;
 	struct hlist_node *node;
 	int i;
+	unsigned long flags;
 
 	/* After the sync no updates or deletes will be in-flight so it
 	 * is safe to walk map and remove entries without risking a race
@@ -1151,11 +1153,11 @@ static void sock_hash_free(struct bpf_map *map)
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


