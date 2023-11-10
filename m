Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1897E8274
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbjKJTVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346318AbjKJTVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:21:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A95C3F372
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699634397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YCaLJYbTJ1XyaLZUKfuK+i5NirT8tMGUxj3QqhAqfd8=;
        b=SV82QS00CQ+bpjxE4hivl8lWr+0v45iXr6XqS43JA/YGM/zntYRJ6Qvmojd/S7drDsmLBO
        Pk9gxpZr2490UseJ0EPJPIoWF5GlytGUj5FfwB03mntnGagV0rLIw2t+VWWHlikNDZs+Fv
        vX68oaCjzzYbTmFoUo49og6w2aDam+k=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-6llxWThHO9Oc6jw8Mol8Rg-1; Fri, 10 Nov 2023 11:39:55 -0500
X-MC-Unique: 6llxWThHO9Oc6jw8Mol8Rg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc41aed6a5so22372545ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699634394; x=1700239194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCaLJYbTJ1XyaLZUKfuK+i5NirT8tMGUxj3QqhAqfd8=;
        b=r64J7l3Gc1ONY01KH1pAgln2Nds1JJPL3QhEnEr7iLmsgn0vSGwfM8XYlAeV9aUtIX
         +/ORaZY1ySZVsd/f0sk3l5q3YEbhz3ZBWxsiAVw/8vrXXaMr2MXvF1iEBhSpv+jKGjuv
         l0RZfUwpsvxooI28N4hXHbGizATfYWjda/cVG4Ez64MhrPkHvzo5V2yVsW80JdO1vhED
         HQ8yySxGgClWpF/Si4jVlpPbO1spIE7a9a5J+CVYduYx66+VTaDpASbNYBwxDp6Y6rwI
         DO2YoP/gsc/qQhLvCNVvqoh6u+pBXzuv1NM9sfi2FFUYMSz4hzrmK6CzEKzgVsotpfjg
         TBbw==
X-Gm-Message-State: AOJu0YwaPYhuU5y5NfD+JvZIFUU6acHad1tqYqZ6eGKUP+LBdrKHtaGE
        tkhUHSI6SocaFT+ERkVb5b5zO+K5upd+/XnsZe9E0UNgBShZxbsa7nr9AMPCS8+uRcJCM3NSci1
        WyH8FTIxzJmLsA38ankA1oxLU
X-Received: by 2002:a17:902:8491:b0:1cc:6597:f42c with SMTP id c17-20020a170902849100b001cc6597f42cmr6902527plo.21.1699634394547;
        Fri, 10 Nov 2023 08:39:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbQE2GvdXTsFkafL9xBUcTuuKJ2jOlp3ShRs40L1sXRLNw3XvwSUL0kfGUG8GiD/oZVifaVQ==
X-Received: by 2002:a17:902:8491:b0:1cc:6597:f42c with SMTP id c17-20020a170902849100b001cc6597f42cmr6902518plo.21.1699634394213;
        Fri, 10 Nov 2023 08:39:54 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902934a00b001b0358848b0sm5575655plp.161.2023.11.10.08.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 08:39:53 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] tipc: Fix kernel-infoleak due to uninitialized TLV value
Date:   Sat, 11 Nov 2023 01:39:47 +0900
Message-ID: <20231110163947.1605168-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reported the following kernel-infoleak issue:

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x4ec/0x2bc0 lib/iov_iter.c:186
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:29 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x4ec/0x2bc0 lib/iov_iter.c:186
 copy_to_iter include/linux/uio.h:197 [inline]
 simple_copy_to_iter net/core/datagram.c:532 [inline]
 __skb_datagram_iter.5+0x148/0xe30 net/core/datagram.c:420
 skb_copy_datagram_iter+0x52/0x210 net/core/datagram.c:546
 skb_copy_datagram_msg include/linux/skbuff.h:3960 [inline]
 netlink_recvmsg+0x43d/0x1630 net/netlink/af_netlink.c:1967
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg net/socket.c:1066 [inline]
 __sys_recvfrom+0x476/0x860 net/socket.c:2246
 __do_sys_recvfrom net/socket.c:2264 [inline]
 __se_sys_recvfrom net/socket.c:2260 [inline]
 __x64_sys_recvfrom+0x130/0x200 net/socket.c:2260
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x103/0x9e0 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5f7/0xb50 mm/slub.c:3523
 kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x2fd/0x770 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 tipc_tlv_alloc net/tipc/netlink_compat.c:156 [inline]
 tipc_get_err_tlv+0x90/0x5d0 net/tipc/netlink_compat.c:170
 tipc_nl_compat_recv+0x1042/0x15d0 net/tipc/netlink_compat.c:1324
 genl_family_rcv_msg_doit net/netlink/genetlink.c:972 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
 genl_rcv_msg+0x1220/0x12c0 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x4a4/0x6a0 net/netlink/af_netlink.c:2545
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0xf4b/0x1230 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1242/0x1420 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x997/0xd60 net/socket.c:2588
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2642
 __sys_sendmsg net/socket.c:2671 [inline]
 __do_sys_sendmsg net/socket.c:2680 [inline]
 __se_sys_sendmsg net/socket.c:2678 [inline]
 __x64_sys_sendmsg+0x2fa/0x4a0 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Bytes 34-35 of 36 are uninitialized
Memory access of size 36 starts at ffff88802d464a00
Data copied to user address 00007ff55033c0a0

CPU: 0 PID: 30322 Comm: syz-executor.0 Not tainted 6.6.0-14500-g1c41041124bd #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
=====================================================

tipc_add_tlv() puts TLV descriptor and value onto `skb`. This size is
calculated with TLV_SPACE() macro. It adds the size of struct tlv_desc and
the length of TLV value passed as an argument, and aligns the result to a
multiple of TLV_ALIGNTO, i.e., a multiple of 4 bytes.

If the size of struct tlv_desc plus the length of TLV value is not aligned,
the current implementation leaves the remaining bytes uninitialized. This
is the cause of the above kernel-infoleak issue.

This patch resolves this issue by clearing data up to an aligned size.

Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/netlink_compat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 5bc076f2fa74..c763008a8adb 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -102,6 +102,7 @@ static int tipc_add_tlv(struct sk_buff *skb, u16 type, void *data, u16 len)
 		return -EMSGSIZE;
 
 	skb_put(skb, TLV_SPACE(len));
+	memset(tlv, 0, TLV_SPACE(len));
 	tlv->tlv_type = htons(type);
 	tlv->tlv_len = htons(TLV_LENGTH(len));
 	if (len && data)
-- 
2.41.0

