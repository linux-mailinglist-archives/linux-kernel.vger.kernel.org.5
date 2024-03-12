Return-Path: <linux-kernel+bounces-100404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4878796FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393C71F2678D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65757BAEC;
	Tue, 12 Mar 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bASVEehd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A25EF4FA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255461; cv=none; b=jQbUlIq+VL+j87NLA13JgR7je7VTqK/U7hpuy1/mrBjTtpjzU/MfnvcCbEyIso4fC0ig39uJwWemjLXV5AbTPlWj1/8jbjV7cBEEcIKMjW70MEmwyrcRCxGFyQHJFdyPY/DlSPMs4wOYQkLY3tRAofodCVrsjhQbs8hiP+yoZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255461; c=relaxed/simple;
	bh=iyeA3ldOlLNqP+PVU2TvhcjBexR+SvedX+3ahGGpIlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARwjoYuh82m+OZzIwaDdQul9NChD7LvpErBNHpy4aARsg4mXzA8Qcp60UwxiDNdowmGm2pX1RRHPsTWXUoOs7OIy9JsFIhi8zdz6kVQSeTyy6xZ24C2O+CmuCanVFzrz3tqrNCzzgFWj7hE/0SEUM9TVg5GC/iWeInYqFYsq2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bASVEehd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710255458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZAdnTnvxDrDZykPQQJFdxyq5N99S9alZWcJMrW7QCuE=;
	b=bASVEehdsBLgRTKI7myVthAXL+F5n/qs8PUzTtcK4QrfEtTSnRWIuK7n8gjQ0/K1nmxym4
	IZNIKV2FrAboExG85/DdrKy2MxyGt9yGLFIPsJunmw7fQs7gxrwrOk+Bgqp3YQeFXMo5ba
	r3Tkr6SyhZgtBRVfGVyhwcYlSSRU/jE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-pkXC6hrLPTug9VkDS7DcYQ-1; Tue, 12 Mar 2024 10:57:36 -0400
X-MC-Unique: pkXC6hrLPTug9VkDS7DcYQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1dd9ffd1e99so22487165ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710255455; x=1710860255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAdnTnvxDrDZykPQQJFdxyq5N99S9alZWcJMrW7QCuE=;
        b=p4qTgiIJ1quTYFBRCZ9AkQ8ldmUIfDoQjFNBsRUjrMaT65vg9dmVsDKjEm56b+CIs4
         P6w5zDh9nYwR5JHrG4jr8Ro0acQP5TTzJv6fTwHGcbL/6uxjHAFSaqNGZ9b25RA5P6dz
         gFVQpEWeWFMVqpd/q/zMT+i0Pvm5Wnz32A3kOq5YSVQGqNLiUHujN1lsa4n3qN369ls+
         IMRFtndGa6P6MrH9Z7A6/u2O67aMSaz+Be1S/za+Dlt/IDcgLjfGf7Ns75u5iT2Iq5HR
         N1nXOIJmmE13//tQQpca8LHNWGsbSe0eNGfh5eqCtqIvTvCdLmltkwF1ahI6zplNWG1g
         lWJw==
X-Forwarded-Encrypted: i=1; AJvYcCVWwxB7cUa+HuCiibE50MAZLP2G9kWwJl514PKso54q6GrP/EmExmi4Ce6vbY8qc+vyMWguW1L/17n07imJeY/RucqERpcoWXhp/tMO
X-Gm-Message-State: AOJu0YxrbgFG+M6YX8VIjIZCZl4fpHVVjGj2Fn2HQR1wNsUKhwA3it/g
	uo+5epU3/7hrIPUSRfnh2+6k2FdJW77VDZxXqM5K696JL/SBSoIlpRbF+Xz2QcIBdtTBaatvVAI
	+p9ma7kEkYBLr+3Hj4z4WePTjcoPu+7f3cId6WrvVAjG2ifk14NHVX5YtFWx0lA==
X-Received: by 2002:a17:903:40c3:b0:1dc:d50d:f669 with SMTP id t3-20020a17090340c300b001dcd50df669mr8425367pld.12.1710255455618;
        Tue, 12 Mar 2024 07:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEue6WlmlzSOSEynvjd6J79HQiHq8+QVhfK8iQwIxyW4oLsTLypjTRPqvzH+LyoQ/rTAwsi6A==
X-Received: by 2002:a17:903:40c3:b0:1dc:d50d:f669 with SMTP id t3-20020a17090340c300b001dcd50df669mr8425353pld.12.1710255455263;
        Tue, 12 Mar 2024 07:57:35 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b001ddb2256f1fsm2273357plb.93.2024.03.12.07.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 07:57:34 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzysztof.kozlowski@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syoshida@redhat.com,
	syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
Subject: [PATCH net] nfc: nci: Fix uninit-value in nci_dev_up
Date: Tue, 12 Mar 2024 23:56:57 +0900
Message-ID: <20240312145658.417288-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following unitit-value access issue [1]:

nci_ntf_packet() calls each ntf operation parsed from skb->data. When
the payload length is zero, each operation handler reads uninitialized
payload and KMSAN detects this issue. Such notification packet should be
silently discarded since it is unexpected for any notification handlers.

This patch resolved this issue by checking payload size before calling
each notification handler codes.

BUG: KMSAN: uninit-value in nci_init_req net/nfc/nci/core.c:177 [inline]
BUG: KMSAN: uninit-value in __nci_request net/nfc/nci/core.c:108 [inline]
BUG: KMSAN: uninit-value in nci_open_device net/nfc/nci/core.c:521 [inline]
BUG: KMSAN: uninit-value in nci_dev_up+0xfec/0x1b10 net/nfc/nci/core.c:632
 nci_init_req net/nfc/nci/core.c:177 [inline]
 __nci_request net/nfc/nci/core.c:108 [inline]
 nci_open_device net/nfc/nci/core.c:521 [inline]
 nci_dev_up+0xfec/0x1b10 net/nfc/nci/core.c:632
 nfc_dev_up+0x26e/0x440 net/nfc/core.c:118
 nfc_genl_dev_up+0xfe/0x1d0 net/nfc/netlink.c:770
 genl_family_rcv_msg_doit net/netlink/genetlink.c:972 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
 genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 nci_core_reset_ntf_packet net/nfc/nci/ntf.c:36 [inline]
 nci_ntf_packet+0x19dc/0x39c0 net/nfc/nci/ntf.c:782
 nci_rx_work+0x213/0x500 net/nfc/nci/core.c:1522
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2706
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2787
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 virtual_ncidev_write+0x6d/0x280 drivers/nfc/virtual_ncidev.c:120
 vfs_write+0x48b/0x1200 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:652
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5012 Comm: syz-executor935 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574 [1]
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 net/nfc/nci/ntf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 994a0a1efb58..56624387e253 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -765,6 +765,9 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
 		 nci_opcode_oid(ntf_opcode),
 		 nci_plen(skb->data));
 
+	if (!nci_plen(skb->data))
+		goto end;
+
 	/* strip the nci control header */
 	skb_pull(skb, NCI_CTRL_HDR_SIZE);
 
-- 
2.44.0


