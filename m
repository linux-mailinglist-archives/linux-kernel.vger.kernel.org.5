Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BAE7D1412
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377837AbjJTQfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTQfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF7ED6C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697819665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M2W/z/qB/yLQdRDIW+WvLkoL91Gd+brZ7nXWhTcX1m8=;
        b=cOffeYXcjVCWedR/8R8Wht7wzdgoHiuvKsplFkxuMyxEIVqlo5uIQaotpv1+cqqPhGPe42
        OnEgY7EfURtCILcvUtqXKf4aY6sQgZgv1tqLWCaOnVO3p0wAOAe7LAZ7/BmSfzhaPFZEF4
        jxde9a58OvX6LZvGW0Uxv0QQ5FCzE4Q=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-mXObLTFUOhOohyrM8CoW7Q-1; Fri, 20 Oct 2023 12:34:22 -0400
X-MC-Unique: mXObLTFUOhOohyrM8CoW7Q-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-692c0c3bcc5so825615b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819661; x=1698424461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2W/z/qB/yLQdRDIW+WvLkoL91Gd+brZ7nXWhTcX1m8=;
        b=OQLg5oCIhH7fEJ6jJTua+m/fgVckSb2ueVfnokhsM7OZKHn9DcxtODZ1vlUzAxfHKl
         y17hrVSvMYk4JQT4k1KMDrd/vE5lF6cZWtycmtTtNgW44CPmQiHxvRWBFF+g2RE20mru
         7GSAoTeZ+fXA50KvtQyBOCL/wwl6m0pGaSL6Oo7QuInPeWTMGWTopbA7291YJ7duAKy5
         Gq/IhGUac4/e2dPuVyXPd2A57RPoGNjPKPCAwICJ72IZeMa3e04kSJpBQkI6VGveqhBN
         6jn1CibiA8QgTPjmJ3OOB3pP306ncLQudJDkplrnL0sQbDkrPXJzjUPGJiu68PG3c4gV
         63KQ==
X-Gm-Message-State: AOJu0Yx2vomdxXnSMeRdYwYdbwZ4cEDqN6a8aMN4GeCQjsAaO2MmyrdY
        3Vp04V7R3CJULudMedMQ0+dCHSdC7ppOOoNip4cdEs/o/EatU3wcrurfK15kRVTf+JCdRzg43dt
        tt6YF7M5Kt1jfeFnY3ELKpOjM
X-Received: by 2002:a05:6a20:394a:b0:17b:3cd6:b1bc with SMTP id r10-20020a056a20394a00b0017b3cd6b1bcmr2539108pzg.14.1697819661662;
        Fri, 20 Oct 2023 09:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEut9/SkpcMEMWSy28kknt2cSp7aswrZXIUMemNx+9qk/k5rRimE1GDtytaP32/TEaNGLU7sQ==
X-Received: by 2002:a05:6a20:394a:b0:17b:3cd6:b1bc with SMTP id r10-20020a056a20394a00b0017b3cd6b1bcmr2539097pzg.14.1697819661374;
        Fri, 20 Oct 2023 09:34:21 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id jj7-20020a170903048700b001bbfa86ca3bsm1733791plb.78.2023.10.20.09.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:34:21 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Subject: [PATCH net v2] tipc: Fix uninit-value access in tipc_nl_node_reset_link_stats()
Date:   Sat, 21 Oct 2023 01:34:15 +0900
Message-ID: <20231020163415.2445440-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported the following uninit-value access issue:

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

Link names must be null-terminated strings. If a link name which is not
null-terminated is passed through netlink, strstr() and similar functions
can cause buffer overrun. This causes the above issue.

This patch resolves the issue by using nla_strscpy() to ensure the link
name is null-terminated.

Fixes: ae36342b50a9 ("tipc: add link stat reset to new netlink api")
Reported-and-tested-by: syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5138ca807af9d2b42574
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v1->v2:
- Use nla_strscpy()
- Fix similar bugs in other functions other than syzbot reported
---
 net/tipc/node.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 3105abe97bb9..2121908e56c1 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2419,7 +2419,7 @@ int tipc_nl_node_set_link(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	int res = 0;
 	int bearer_id;
-	char *name;
+	char name[TIPC_MAX_LINK_NAME];
 	struct tipc_link *link;
 	struct tipc_node *node;
 	struct sk_buff_head xmitq;
@@ -2440,7 +2440,7 @@ int tipc_nl_node_set_link(struct sk_buff *skb, struct genl_info *info)
 	if (!attrs[TIPC_NLA_LINK_NAME])
 		return -EINVAL;
 
-	name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
+	nla_strscpy(name, attrs[TIPC_NLA_LINK_NAME], TIPC_MAX_LINK_NAME);
 
 	if (strcmp(name, tipc_bclink_name) == 0)
 		return tipc_nl_bc_link_set(net, attrs);
@@ -2500,7 +2500,7 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
 	struct net *net = genl_info_net(info);
 	struct nlattr *attrs[TIPC_NLA_LINK_MAX + 1];
 	struct tipc_nl_msg msg;
-	char *name;
+	char name[TIPC_MAX_LINK_NAME];
 	int err;
 
 	msg.portid = info->snd_portid;
@@ -2518,7 +2518,7 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
 	if (!attrs[TIPC_NLA_LINK_NAME])
 		return -EINVAL;
 
-	name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
+	nla_strscpy(name, attrs[TIPC_NLA_LINK_NAME], TIPC_MAX_LINK_NAME);
 
 	msg.skb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!msg.skb)
@@ -2563,7 +2563,7 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
 int tipc_nl_node_reset_link_stats(struct sk_buff *skb, struct genl_info *info)
 {
 	int err;
-	char *link_name;
+	char link_name[TIPC_MAX_LINK_NAME];
 	unsigned int bearer_id;
 	struct tipc_link *link;
 	struct tipc_node *node;
@@ -2584,7 +2584,7 @@ int tipc_nl_node_reset_link_stats(struct sk_buff *skb, struct genl_info *info)
 	if (!attrs[TIPC_NLA_LINK_NAME])
 		return -EINVAL;
 
-	link_name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
+	nla_strscpy(link_name, attrs[TIPC_NLA_LINK_NAME], TIPC_MAX_LINK_NAME);
 
 	err = -EINVAL;
 	if (!strcmp(link_name, tipc_bclink_name)) {
-- 
2.41.0

