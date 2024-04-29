Return-Path: <linux-kernel+bounces-162561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433DF8B5D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8042282B47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0472B8562E;
	Mon, 29 Apr 2024 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUxKW8+j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8485632
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403777; cv=none; b=uXpJRqp+duzwzD9lroITsyEUPkKvaLVelL1P1MFj9XOP82+mxamnQnpzqMyBLSh12BTfmP5A8JsbhDH+2ELPPblE59hAb96IGjM62g2o3t3bvowNDrDm8aAp2Tg+DHyVn7E31mxBOurvzSH7W70s+IdLNVMi9nVqg1oC6c2qqX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403777; c=relaxed/simple;
	bh=JInUyCfWa4cj2hSY+8TlfNabBmIPS0UDzEe5ma2bn5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEugS4eD8oCgbezTinEdPKk/mAj0o3pGDW+H7CqwJUWdpLhswhdq4IYZUUwwozHr8Vnuwsx1ZFQ6lwFI6t+395WrRO2TjahCWSvgyNXX9pIEBkYITAPF0AkoawF7Bt+ldC5YpU6rcVZnhGjip+Y4JPIooTofJ0NffD2xsbXi1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUxKW8+j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714403774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k9nifAwGr2Zp6gvAQ7eF6eUdfZNy/PCRT7il66zHEGQ=;
	b=XUxKW8+jAA+WeG6/fdU4oJYm71MXGCX0MIunRMU0textbyYnWRP26RSTfOF5pOjZH1DfzM
	85WlKc77CV1V3jqQztr+qlICPYaAOTZWJP7AxRM75FqUPQxThgiuUVy0+XjOeV+RfnW1pl
	eZkXuBgvUhrxpCZYceO7veJovJahs9c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-EL694DlpMA--J8_B3GcpxA-1; Mon, 29 Apr 2024 11:16:13 -0400
X-MC-Unique: EL694DlpMA--J8_B3GcpxA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a2dbaacff8so5317385a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403772; x=1715008572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9nifAwGr2Zp6gvAQ7eF6eUdfZNy/PCRT7il66zHEGQ=;
        b=cEAY2Ap/fgLbvUCcg0SyNmH3qAk8+ScOQ9TRNAJbqFU+tYlNE9fg12ArzlFvPIB7lR
         tcyFLe6I1x6XcsLgAv34uGZrao9C/63wc6UBwOTphBb/LQ2xMxiDLX/G3DFB+G/OLifz
         OmsB+VTHif+zLBdLe8kjk4cd04dwURanSa/7yIzoPfP+BNkYBA5ZHbKysbXq5/d+aa4s
         0koI/mJ6M6rjsoBZj/FFFNdKcvl91W9GQ9jbbu7sjiGuz45lZCNp6JLd4bEtG2tzWwWS
         NltgYdIkrXHqmk5eMmC2xTQ6kkaz6pnhd/w/FSa75n1vOrWfy9RF0YPH7PB+zf4NxY01
         s6EA==
X-Forwarded-Encrypted: i=1; AJvYcCXOdgl19T52SjAiaksnsM/kfTuEWKALZlhc1QQlS6Ejo6pkom+Ha20eZzloOiFmxxTzealu5ipZpS3uB/p48iYyS7EKVYZJlhSNmHfH
X-Gm-Message-State: AOJu0Yzd2r/v4l00S5nTViT6w1jrY0/QCgXjBG8ZT95uI6L26ETlQiKp
	mWur2m5vaNnsJy+Co7j27E5wCTZdKOvSEr3lDOpNaPzqc9+zk+Jkys8IFY5JvQMjUHWMzjGuVKl
	u/5lsL0EUzcwWoWS1yLK4Ujh8gWNFHLV/3i4sX9beViQC32tOp7/h8qlSCrhWoA==
X-Received: by 2002:a17:90a:c292:b0:2ae:bbf7:30fa with SMTP id f18-20020a17090ac29200b002aebbf730famr8504459pjt.3.1714403771778;
        Mon, 29 Apr 2024 08:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPSUIoPmz7NnF1amN3oBULQy1w4IN8FGpSu183OjoavIw2Db/Ild1Dxk/V3NT0S8XGUWTzzw==
X-Received: by 2002:a17:90a:c292:b0:2ae:bbf7:30fa with SMTP id f18-20020a17090ac29200b002aebbf730famr8504428pjt.3.1714403771253;
        Mon, 29 Apr 2024 08:16:11 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id nv5-20020a17090b1b4500b002a2f055e52csm20840663pjb.34.2024.04.29.08.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:16:10 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH net] ipv4: Fix uninit-value access in __ip_make_skb()
Date: Tue, 30 Apr 2024 00:16:05 +0900
Message-ID: <20240429151605.2055465-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported uninit-value access in __ip_make_skb() [1].  __ip_make_skb()
tests HDRINCL to know if the skb has icmphdr. However, HDRINCL can cause a
race condition. If calling setsockopt(2) with IP_HDRINCL changes HDRINCL
while __ip_make_skb() is running, the function will access icmphdr in the
skb even if it is not included. This causes the issue reported by KMSAN.

Check FLOWI_FLAG_KNOWN_NH on fl4->flowi4_flags instead of testing HDRINCL
on the socket.

Also, fl4->fl4_icmp_type and fl4->fl4_icmp_code are not initialized. These
are union in struct flowi4 and are implicitly initialized by
flowi4_init_output(), but we should not rely on specific union layout.

Initialize these explicitly in raw_sendmsg().

[1]
BUG: KMSAN: uninit-value in __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
 __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
 ip_finish_skb include/net/ip.h:243 [inline]
 ip_push_pending_frames+0x4c/0x5c0 net/ipv4/ip_output.c:1508
 raw_sendmsg+0x2381/0x2690 net/ipv4/raw.c:654
 inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x274/0x3c0 net/socket.c:745
 __sys_sendto+0x62c/0x7b0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2199
 do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x5f6/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35a/0x7c0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1318 [inline]
 __ip_append_data+0x49ab/0x68c0 net/ipv4/ip_output.c:1128
 ip_append_data+0x1e7/0x260 net/ipv4/ip_output.c:1365
 raw_sendmsg+0x22b1/0x2690 net/ipv4/raw.c:648
 inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x274/0x3c0 net/socket.c:745
 __sys_sendto+0x62c/0x7b0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2199
 do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 15709 Comm: syz-executor.7 Not tainted 6.8.0-11567-gb3603fcb79b1 #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014

Fixes: 99e5acae193e ("ipv4: Fix potential uninit variable access bug in __ip_make_skb()")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v1->v2: https://lore.kernel.org/all/20240324050554.1609460-1-syoshida@redhat.com/
- Explicitly initialize fl4->fl4_icmp_type and fl4->fl4_icmp_code because
  we should not rely on a specific union layout.
---
 net/ipv4/ip_output.c | 2 +-
 net/ipv4/raw.c       | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1fe794967211..39229fd0601a 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1473,7 +1473,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 		 * by icmp_hdr(skb)->type.
 		 */
 		if (sk->sk_type == SOCK_RAW &&
-		    !inet_test_bit(HDRINCL, sk))
+		    !(fl4->flowi4_flags & FLOWI_FLAG_KNOWN_NH))
 			icmp_type = fl4->fl4_icmp_type;
 		else
 			icmp_type = icmp_hdr(skb)->type;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index dcb11f22cbf2..4cb43401e0e0 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -612,6 +612,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
 			   daddr, saddr, 0, 0, sk->sk_uid);
 
+	fl4.fl4_icmp_type = 0;
+	fl4.fl4_icmp_code = 0;
+
 	if (!hdrincl) {
 		rfv.msg = msg;
 		rfv.hlen = 0;
-- 
2.44.0


