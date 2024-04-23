Return-Path: <linux-kernel+bounces-155959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C88AFBCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B411F23D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D561CD02;
	Tue, 23 Apr 2024 22:35:08 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908128E2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911708; cv=none; b=Myf8d47KtwfuFytFUKXSV3/0j/FquAsGaHTZ0/HUt0mcXDFPLnsb23CR8HCsbolWNDvpYdt4fZaX7ac33EnLkFk7rosODWOYFpIOFiAwY81TdEY6M8fpPuLBZp8h3mvhZ9p9Wh8EUDq8iE6bni7cNhOj+/kW/YMOHL2BYIlYFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911708; c=relaxed/simple;
	bh=2/wHyIAjQKutF73OzgIP4vNkAke40k+ab/jDtK/328k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4l8CxB7Xih3B9J7LEhf7l1CR/xQbqqvWXyFnpWdWUCa/b+pO2IiNBrkRP2hR5Y4KLGxYZ5d4MO6O+0Nu4tLwdJdDeUmWLq76H0kG8P971b/dWVMgnZFVMtsELnzAM39xPoae0zsf0HxDdgHSHf21JGrxbyy+YanogW0HX9KkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.188])
	by sina.com (172.16.235.24) with ESMTP
	id 66283790000066E5; Tue, 24 Apr 2024 06:34:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 37018445089535
X-SMAIL-UIID: 4F539200A7044B909B6E8C184C6812E7-20240424-063459-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in __unix_gc
Date: Wed, 24 Apr 2024 06:34:58 +0800
Message-Id: <20240423223458.3126-1-hdanton@sina.com>
In-Reply-To: <000000000000f1761a0616c5c629@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Apr 2024 09:09:22 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    4d2008430ce8 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ceeb73180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  4d2008430ce8

--- x/net/unix/af_unix.c
+++ y/net/unix/af_unix.c
@@ -2646,7 +2646,7 @@ static int unix_stream_recv_urg(struct u
 }
 
 static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
-				  int flags, int copied)
+				  int flags, int copied, struct sk_buff_head *qh)
 {
 	struct unix_sock *u = unix_sk(sk);
 
@@ -2669,7 +2669,7 @@ static struct sk_buff *manage_oob(struct
 				skb_unlink(skb, &sk->sk_receive_queue);
 				WRITE_ONCE(u->oob_skb, NULL);
 				if (!WARN_ON_ONCE(skb_unref(skb)))
-					kfree_skb(skb);
+					__skb_queue_tail(qh, skb);
 				skb = skb_peek(&sk->sk_receive_queue);
 			}
 		}
@@ -2703,6 +2703,9 @@ static int unix_stream_read_generic(stru
 	int skip;
 	size_t size = state->size;
 	unsigned int last_len;
+	struct sk_buff_head qh;
+
+	__skb_queue_head_init(&qh);
 
 	if (unlikely(sk->sk_state != TCP_ESTABLISHED)) {
 		err = -EINVAL;
@@ -2746,7 +2749,7 @@ redo:
 again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
-			skb = manage_oob(skb, sk, flags, copied);
+			skb = manage_oob(skb, sk, flags, copied, &qh);
 			if (!skb && copied) {
 				unix_state_unlock(sk);
 				break;
@@ -2901,6 +2904,7 @@ unlock:
 	else
 		scm_destroy(&scm);
 out:
+	__skb_queue_purge(&qh);
 	return copied ? : err;
 }
 
--

