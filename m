Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4947DB4A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjJ3H4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjJ3H4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67477A2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698652550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5t9eU8J5yxO7BvU8JT+OpUytvz6S9LcChDCUUgV2Oz8=;
        b=i1EA9OjWDZaZ6+cqHg+1OB9Me4LLObP1Hj1/h2orK07jV9TtQsx8roCVJ2MloVkcUsYhUf
        QvSOXwPKgKPmSEHNzv1X25UO6C0jF42hwXO1ueOHK2KC1g+czzl8i7I8urR5IyyJeRfL2n
        g2t87LzU5801oTe+RNx7FQEqCphqe+o=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-c9dlPGKeMfWytpr2nQnoHQ-1; Mon, 30 Oct 2023 03:55:47 -0400
X-MC-Unique: c9dlPGKeMfWytpr2nQnoHQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6bf2b098e43so2589349b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698652546; x=1699257346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t9eU8J5yxO7BvU8JT+OpUytvz6S9LcChDCUUgV2Oz8=;
        b=HGwoNp+9iChPSfb4jCvXmxgvKPdVNVj4NLzunpXvtcJFYB6PXAFPSaGwrZYntyU4uk
         UBUul6vufMZCxToql6Ir3datjprMQJ+XcHK41v01aoZ+nUt49B0jyaZsU9nMivLQ6r6r
         3rZuFQDAvWVL9l5WpNjwZDnyfg8jBnymtEJhEhk6mG1u+xn444CjreN4WwFz6dD4QGPZ
         8TZRXH+v54muM2qE0rVH2aceb1u0gcjOPUYLlkf+UZklkL2JnB0Flippwb2PVPU/hiNl
         QvQ0u5zj986N8LPfIWTSPjjaRWe3lEdcQv0dh3y9iSnd/pleaDfLu7hRNHnI5ycQPXM1
         /RZQ==
X-Gm-Message-State: AOJu0YyxBptHo6icATHdaQiS/IlGoUA047S15bNptTL7cvatwVKaBYQv
        BH6un1K0+TlY72j1I9iWGRDBFcQOGJtDVwwP//9cUJ6H6WLT+7Qsk/SraxV/5AIGF0WMJVZxozF
        wi9lGyk5V6E+pJPMJWHMUeG26
X-Received: by 2002:a05:6a20:3d0b:b0:16b:79c2:7d6e with SMTP id y11-20020a056a203d0b00b0016b79c27d6emr8487044pzi.30.1698652546282;
        Mon, 30 Oct 2023 00:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK1Rxl23x3SQRnaFLCEUYXHyALve0OUwu9/SycOUu0i0w32D2cvv1z7vkHbvguD9UjlU6/wA==
X-Received: by 2002:a05:6a20:3d0b:b0:16b:79c2:7d6e with SMTP id y11-20020a056a203d0b00b0016b79c27d6emr8487037pzi.30.1698652545956;
        Mon, 30 Oct 2023 00:55:45 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id be3-20020a170902aa0300b001c9e53b721csm3016067plb.261.2023.10.30.00.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 00:55:45 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com,
        syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Subject: [PATCH net v3] tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING
Date:   Mon, 30 Oct 2023 16:55:40 +0900
Message-ID: <20231030075540.3784537-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported the following uninit-value access issue [1]:

=====================================================
BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
BUG: KMSAN: uninit-value in strstr+0xb8/0x2f0 lib/string.c:756
 strlen lib/string.c:418 [inline]
 strstr+0xb8/0x2f0 lib/string.c:756
 tipc_nl_node_reset_link_stats+0x3ea/0xb50 net/tipc/node.c:2595
 genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
 genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
 __sys_sendmsg net/socket.c:2624 [inline]
 __do_sys_sendmsg net/socket.c:2633 [inline]
 __se_sys_sendmsg net/socket.c:2631 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
 __alloc_skb+0x318/0x740 net/core/skbuff.c:650
 alloc_skb include/linux/skbuff.h:1286 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
 netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
 __sys_sendmsg net/socket.c:2624 [inline]
 __do_sys_sendmsg net/socket.c:2633 [inline]
 __se_sys_sendmsg net/socket.c:2631 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

TIPC bearer-related names including link names must be null-terminated
strings. If a link name which is not null-terminated is passed through
netlink, strstr() and similar functions can cause buffer overrun. This
causes the above issue.

This patch changes the nla_policy for bearer-related names from NLA_STRING
to NLA_NUL_STRING. This resolves the issue by ensuring that only
null-terminated strings are accepted as bearer-related names.

syzbot reported similar uninit-value issue related to bearer names [2]. The
root cause of this issue is that a non-null-terminated bearer name was
passed. This patch also resolved this issue.

Fixes: 7be57fc69184 ("tipc: add link get/dump to new netlink api")
Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
Reported-and-tested-by: syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5138ca807af9d2b42574 [1]
Reported-and-tested-by: syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9425c47dccbcb4c17d51 [2]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v2->v3:
- Change the title
- Change the nla_policy for bearer-related names instead of using nla_strscpy()
- Resolve bearer-name related issue too
https://lore.kernel.org/all/20231020163415.2445440-1-syoshida@redhat.com/

v1->v2:
- Use nla_strscpy()
- Fix similar bugs in other functions other than syzbot reported
https://lore.kernel.org/all/20230924060325.3779150-1-syoshida@redhat.com/
---
 net/tipc/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index e8fd257c0e68..1a9a5bdaccf4 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -88,7 +88,7 @@ const struct nla_policy tipc_nl_net_policy[TIPC_NLA_NET_MAX + 1] = {
 
 const struct nla_policy tipc_nl_link_policy[TIPC_NLA_LINK_MAX + 1] = {
 	[TIPC_NLA_LINK_UNSPEC]		= { .type = NLA_UNSPEC },
-	[TIPC_NLA_LINK_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_LINK_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_LINK_NAME },
 	[TIPC_NLA_LINK_MTU]		= { .type = NLA_U32 },
 	[TIPC_NLA_LINK_BROADCAST]	= { .type = NLA_FLAG },
@@ -125,7 +125,7 @@ const struct nla_policy tipc_nl_prop_policy[TIPC_NLA_PROP_MAX + 1] = {
 
 const struct nla_policy tipc_nl_bearer_policy[TIPC_NLA_BEARER_MAX + 1]	= {
 	[TIPC_NLA_BEARER_UNSPEC]	= { .type = NLA_UNSPEC },
-	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_BEARER_NAME },
 	[TIPC_NLA_BEARER_PROP]		= { .type = NLA_NESTED },
 	[TIPC_NLA_BEARER_DOMAIN]	= { .type = NLA_U32 }
-- 
2.41.0

