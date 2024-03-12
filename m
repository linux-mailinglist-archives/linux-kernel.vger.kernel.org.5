Return-Path: <linux-kernel+bounces-100434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C89879782
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC802848D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3F47C6D2;
	Tue, 12 Mar 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="es9oHh4H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21927B3E5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257250; cv=none; b=GU5JoI20NJRSHKVa6MiAkXDfMA/PEQj+jb7QFpSxS7nnyeCFZW35H49gH2wUeUPcSoF2cBjtkxMlzUQL/vB+zRKHkSvAi8oFLqpWZlU2hXs771P38gL9I6ip86jS5MdNjYqU8QljV73eEcd1I+J3JIfXBh0hTRzCH10WdYbv61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257250; c=relaxed/simple;
	bh=w7z1eLBV/cGTuzfm8y67GKU7V01cuMnBpwQKthEkV1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hP85q3CzjNF+ybDdiG/YwkyC3CLwmPIp272fb6ILyqIJEfiavqB0eZEQgb478o3+hgRT18d/4PtKxS2iOHADuCt2IY2s/abnUimtBk893UXHBvd03O9mVEHC2E1WFoRctFkhP+803Ts4pv7ZY9brzbQ1wjJvYXJ4yO+wd77L+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=es9oHh4H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710257247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uC39AaHxCXn4out0wHELXA5Z5h6XuwlzMRRIrhomGFU=;
	b=es9oHh4HsijzKJggidN5pBzUWOcj7tNiYYoO9wijNVbt8fykuTW5S+oyryijs/A49uH8ap
	cpVeaw5GcquNcnbvEdPmO5j416O5CUvjtbEAYAqkWnxzV6wMjGRmeiTnEnKAlgGGBm5JBW
	NBqfTrAbycnNHBUewJNft2apRmyN8gM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-DEH-UrGPN5eOJCjWMMiXFg-1; Tue, 12 Mar 2024 11:27:25 -0400
X-MC-Unique: DEH-UrGPN5eOJCjWMMiXFg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e6999fd41cso1493675b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257244; x=1710862044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uC39AaHxCXn4out0wHELXA5Z5h6XuwlzMRRIrhomGFU=;
        b=VTlExmlYU2gioL64q2qYd/apXmcfv2+l3okttN0oJeI4NX9mLoZHGt/TUgKw/yGxyq
         5st6NAlcemBC9g2OiSf5hWapiEiYpf9w4pSh75g/y4LF0/hjlmRVPVHmDen3sycDoqD0
         PnrVugQ/POdEwRxZsXqETnNZD3CgAYc/rTxs1C1mHOMx825kNQdqYDmkpJ+dO+wDLEVs
         0fQI6+sDeg2dIxaV+BdesJwomWwHnmzToiAochb3DR+cWH+PnEUM8zKLB8pHZ5pqFR1z
         0Nx+sG0MDKFkmETYOy8RRqa0wRmN/weDKdOY4w4kK21p2TaZeTlcNC5UGkP8cEFdN9ZU
         eGXg==
X-Forwarded-Encrypted: i=1; AJvYcCVH+gr5ZoMJtfzhu5UtNrmaskiHgES+OBZv6ffoYrSwAJ1m4IOsQe4ll4xK5Jta3O/RQKc7u2nouuGnZpMSXZ976Rdpn1FUXAT6yAgF
X-Gm-Message-State: AOJu0YztDj2mZSAImtkztbNvzDh3ug0LoYKRJ0VQ0gFKqBlKR746qD0y
	IV6oT5PFojLkGxUiTwqKCh//gYEEJUjYtvv9WJyz/tNXdeK2yrWARJjP03U/11XzshmXWGzDAdI
	Joiemkc5bNGCBeQs3xL54uZVAWudbblgZVNigM1i5bbE+Y+mkNXy+RtNPseuv5w==
X-Received: by 2002:a05:6a20:1824:b0:1a1:67c7:3ba4 with SMTP id bk36-20020a056a20182400b001a167c73ba4mr8580919pzb.51.1710257244525;
        Tue, 12 Mar 2024 08:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWH08GPkN3yS9nkXqOwjXA9YHlNM8PdeCaFjXBLasZR3oXnUTRMuqMWcHPzMZk6gzAxntf0Q==
X-Received: by 2002:a05:6a20:1824:b0:1a1:67c7:3ba4 with SMTP id bk36-20020a056a20182400b001a167c73ba4mr8580902pzb.51.1710257244235;
        Tue, 12 Mar 2024 08:27:24 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006e6ab7cb10esm969668pfa.186.2024.03.12.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:27:23 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com
Subject: [PATCH net] hsr: Fix uninit-value access in hsr_get_node()
Date: Wed, 13 Mar 2024 00:27:19 +0900
Message-ID: <20240312152719.724530-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported the following uninit-value access issue [1]:

=====================================================
BUG: KMSAN: uninit-value in hsr_get_node+0xa2e/0xa40 net/hsr/hsr_framereg.c:246
 hsr_get_node+0xa2e/0xa40 net/hsr/hsr_framereg.c:246
 fill_frame_info net/hsr/hsr_forward.c:577 [inline]
 hsr_forward_skb+0xe12/0x30e0 net/hsr/hsr_forward.c:615
 hsr_dev_xmit+0x1a1/0x270 net/hsr/hsr_device.c:223
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
 __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2787
 packet_alloc_skb net/packet/af_packet.c:2936 [inline]
 packet_snd net/packet/af_packet.c:3030 [inline]
 packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5033 Comm: syz-executor334 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================

If the packet type ID field in the Ethernet header is either ETH_P_PRP or
ETH_P_HSR, but it is not followed by an HSR tag, hsr_get_skb_sequence_nr()
reads an invalid value as a sequence number. This causes the above issue.

This patch fixes the issue by returning NULL if the Ethernet header is not
followed by an HSR tag.

Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
Reported-and-tested-by: syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2ef3a8ce8e91b5a50098 [1]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/hsr/hsr_framereg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 6d14d935ee82..26329db09210 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -228,6 +228,10 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	 */
 	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
 	    ethhdr->h_proto == htons(ETH_P_HSR)) {
+		/* Check if skb contains hsr_ethhdr */
+		if (skb->mac_len < sizeof(struct hsr_ethhdr))
+			return NULL;
+
 		/* Use the existing sequence_nr from the tag as starting point
 		 * for filtering duplicate frames.
 		 */
-- 
2.43.0


