Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF03A7AC6B3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjIXGE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXGE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFA7101
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 23:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695535414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=95dcBVemM5GhqnMGHhoTgUNEDXpSohpfAJrS5+uZkCM=;
        b=J5vj3ikvPsl2UAIu9xI6iliWr53GZq1e6B5paE4ZJkLxb/mVvA+lmhFG9MKPyaLVkY3FAU
        58v6l3KASEJbwjNRIejFCsYyoXdwUGkERfwW8DsmryGkW4cao1XcB7YqUk7JtXcNsC7Wu+
        qSGosmkJ0SfwrMNkMZF2NVWPTAYyYRU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-p1iOCMF4NkuKa7cn5fJ8iw-1; Sun, 24 Sep 2023 02:03:32 -0400
X-MC-Unique: p1iOCMF4NkuKa7cn5fJ8iw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2773b534dd2so617897a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 23:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695535411; x=1696140211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95dcBVemM5GhqnMGHhoTgUNEDXpSohpfAJrS5+uZkCM=;
        b=vazVyL+15vU+XLN/kB6Frvw420ZReA/nh/2SgrE9caJOEs8Zbe9SpsB8ok2LXBCaPx
         nf/A7gjVh+y9+lNjPoRS7VH1GMQa68i5U880Qb4b1gECqydniL6I3MBjW/9HN3FxOwUC
         F5JsEVoz1Q7C5cjMwB/XEQjewh+0J1i1l0jAAWx4ME8VunW1D6EfnGeSpxORaOiTEZIM
         CyH6+RmXmmLOfAWkIg4ppXeGeeot4bjIgDfD743Y8ksbHpFjy/pGBhULTJRNi0oM7oBb
         OTzUhMY7RaG1givwovPCYqfJzjaJuGGDwf2Fn+3xlFu2kxA8Edlm8ObqYT5BT3TbjakZ
         DbKQ==
X-Gm-Message-State: AOJu0YymH7LhCZy+k4dsnrLKA1eebhwSFErXSW0tHQmSb5t0seA/nOhM
        qxWRhQb33S7Q7CXsUaFcbC3rqVlSCKfi/FmD+XeqOG3VgWw2SkrjbCX7zY3SfY5mRqUfhRY8vkl
        CP/5Ip2wS3u9AB3OPyYtO4ikN
X-Received: by 2002:a17:90b:4c92:b0:25d:eca9:1621 with SMTP id my18-20020a17090b4c9200b0025deca91621mr2156640pjb.6.1695535411323;
        Sat, 23 Sep 2023 23:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzc6g2VxeSFFA1pRFagT5GtyabcUKpPjtAq/MWnCPL9Fy7EZYFoZ69r6Dscmbis/qAG507ig==
X-Received: by 2002:a17:90b:4c92:b0:25d:eca9:1621 with SMTP id my18-20020a17090b4c9200b0025deca91621mr2156633pjb.6.1695535410990;
        Sat, 23 Sep 2023 23:03:30 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id ki19-20020a17090ae91300b0026b41363887sm7516644pjb.27.2023.09.23.23.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 23:03:30 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Subject: [PATCH] tipc: Fix uninit-value access in tipc_nl_node_reset_link_stats()
Date:   Sun, 24 Sep 2023 15:03:25 +0900
Message-ID: <20230924060325.3779150-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

This patch fixes this issue by returning -EINVAL if a non-null-terminated
link name is passed.

Fixes: ae36342b50a9 ("tipc: add link stat reset to new netlink api")
Reported-and-tested-by: syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5138ca807af9d2b42574
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/node.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 3105abe97bb9..f167bdafc034 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2586,6 +2586,10 @@ int tipc_nl_node_reset_link_stats(struct sk_buff *skb, struct genl_info *info)
 
 	link_name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
 
+	if (link_name[strnlen(link_name,
+			      nla_len(attrs[TIPC_NLA_LINK_NAME]))] != '\0')
+		return -EINVAL;
+
 	err = -EINVAL;
 	if (!strcmp(link_name, tipc_bclink_name)) {
 		err = tipc_bclink_reset_stats(net, tipc_bc_sndlink(net));
-- 
2.41.0

