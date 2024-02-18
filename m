Return-Path: <linux-kernel+bounces-70421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF70859786
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AAB1F21565
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA026BFD3;
	Sun, 18 Feb 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlMtBNXJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE365BBA
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708268988; cv=none; b=RG2lXp23lonX/xiqb7rgUQJ+e9OAzCDjaLPNVrMaeqDyMntyDWSv1/Qf4Cm2J7k9wkmmwQ7aqydoCrGL1Vue2pMWdZWP7Ed3ZL9jg5CpDp06uG82N+88r5aJ9mxrvWZKtGtIGFXvGhyuZRfZs3YHL3F+DaNEWpcPRX+JsoN91ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708268988; c=relaxed/simple;
	bh=P/XamzW0k9s56aZD49kwH+EPycwY+7egqwFjukjRjaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rf+p/jfji24bZ3Iq0c4FAI5A8DbVgLfwNebSBuMEP4xLvFX7vvv4bYat4ary0CyBVpgq+fV3uLpVaZfgDflxry4N1TrW9JmCjbiVjmORXXbqd5SoeW7wQHDCmBFLyBBryfZY2eC0+8NTDDXzW0yaKLB5zMPZzslxNzCjY/oLvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlMtBNXJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708268985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bwoL5JJuhSW+kyiPUR3qQ3qzkCkjo9wXmM88MH4kw4I=;
	b=ZlMtBNXJQzRIpGj+lC/8+vZ5EJrLklaaZWNlydXJjpGw3wHbt0Ksukem/37E4QNVW4Admi
	ZggwWXUJc9XvxnMLppk//MIc4Jp8SAlnZ4fJRCu6y86PTqz9+NFGcRxloXw0qUD7smzH0V
	YszaKnKvFTvV9cIsMNk4SyvUHCLgS1E=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-7HOw-CEkNGCPubmU-hIlQQ-1; Sun, 18 Feb 2024 10:09:44 -0500
X-MC-Unique: 7HOw-CEkNGCPubmU-hIlQQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c5c8ef7d0dso3435874a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708268983; x=1708873783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwoL5JJuhSW+kyiPUR3qQ3qzkCkjo9wXmM88MH4kw4I=;
        b=cFWc1VoNC18yn5oikbK+OLofCll95eA5nshcWmQJnlnackoNW8prqMmz9rhkkSznmn
         KW+Ayyf0xTxE8vr4cjXFIV0VRgctsI38Rh7KSfAme0S3L5ED5FWMN2eOGE2n3S/g6OL7
         cbwAd0Gx/8Ijnee5TP9oF/KQb8vwQrLS868wFs2rJW4bti1GwomxYjLOFM2hMSMoWt6x
         qfkdaNWTA31dAm945TmbvxYI3Aq7lvRdMubtJRYRd1nbNu7oLMkzH6lGlk2QNYPQ5BVK
         o/gQ1yiWPNyjFr0UPwCFTxMdnPnQJB1R61ThNS9X8l+fqR01pmbcHmf7TtaHar7PgKdd
         dSCA==
X-Forwarded-Encrypted: i=1; AJvYcCWVNRFlSI0tKfWXl8IAm1fUjq92gi/AbRqi7wIuWR1nNnbRx3eFw+EJSkqXyN8VODE9+XRKSQCGXskqiqT8XWHT7So3BrXIzcxUn7yp
X-Gm-Message-State: AOJu0Yx/qiReS7qNb/hMKCumSAz1R+H6xeThK//Kcv70GTsdFWzXQ+rZ
	SBIEp/znIHVOHEaTQoMukUXY+0+FcBKzSJydEU5nxtPggkNZQhLzaewokruxzlBLBkqCZrXO+rv
	Xc8DmxPV3TFcILrlWF7GltV7NV9hxwJdZL+TKOp4y95MGqalJ3sMkW0Beh6nBAQ==
X-Received: by 2002:a17:90a:4dce:b0:299:3f5d:b5e8 with SMTP id r14-20020a17090a4dce00b002993f5db5e8mr3512998pjl.20.1708268983028;
        Sun, 18 Feb 2024 07:09:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWB+1HQKH3/cx4XDOVkxwc253bedsLJk+TmwcSSZJ1ojNUMxpmP+dQC/vu/lwyZiKwv8B7sQ==
X-Received: by 2002:a17:90a:4dce:b0:299:3f5d:b5e8 with SMTP id r14-20020a17090a4dce00b002993f5db5e8mr3512975pjl.20.1708268982585;
        Sun, 18 Feb 2024 07:09:42 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id nb11-20020a17090b35cb00b0029658c7bd53sm3479311pjb.5.2024.02.18.07.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 07:09:42 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com
Subject: [PATCH bpf] bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()
Date: Mon, 19 Feb 2024 00:09:33 +0900
Message-ID: <20240218150933.6004-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following NULL pointer dereference issue [1]:

BUG: kernel NULL pointer dereference, address: 0000000000000000
..
RIP: 0010:0x0
..
Call Trace:
 <TASK>
 sk_psock_verdict_data_ready+0x232/0x340 net/core/skmsg.c:1230
 unix_stream_sendmsg+0x9b4/0x1230 net/unix/af_unix.c:2293
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

If sk_psock_verdict_data_ready() and sk_psock_stop_verdict() are called
concurrently, psock->saved_data_ready can be NULL, causing the above issue.

This patch fixes this issue by calling the appropriate data ready function
using the sk_psock_data_ready() helper and protecting it from concurrency
with sk->sk_callback_lock.

Fixes: 6df7f764cd3c ("bpf, sockmap: Wake up polling after data copy")
Reported-and-tested-by: syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93 [1]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/core/skmsg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 93ecfceac1bc..4d75ef9d24bf 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1226,8 +1226,11 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 		rcu_read_lock();
 		psock = sk_psock(sk);
-		if (psock)
-			psock->saved_data_ready(sk);
+		if (psock) {
+			read_lock_bh(&sk->sk_callback_lock);
+			sk_psock_data_ready(sk, psock);
+			read_unlock_bh(&sk->sk_callback_lock);
+		}
 		rcu_read_unlock();
 	}
 }
-- 
2.43.0


