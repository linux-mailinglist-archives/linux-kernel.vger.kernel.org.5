Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8F798ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344107AbjIHTM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjIHTMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:12:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6B519E;
        Fri,  8 Sep 2023 12:12:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB19C116A8;
        Fri,  8 Sep 2023 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196854;
        bh=QXXPdGa/Mfp8PMKnT6sIReUyTRkewtRVNgYn3VanRYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7cwEgpWbXcaOkbSaNZf1FWI7zSQl4DeR9rOJ6cejy/QQ+BiA7ktquKnZHAgeCLVo
         NLmJdhZOimQNuClxLNpkGLfi0u//4dH15As++BsIy6RB0SIAa6TcoVhOmHQwFoixdD
         BTx+e8gkB9lhWpjCgsWtrimIJEfWOnxkJiDtYi0eFVZg1TzbCXGwMnEWcQqGYaYVzr
         32zZ5erUIRZmTAYzrltCoux9zeJ/ubu9iJjoXrXOsshuzgDNX32UZOMR/JIIvzk+IX
         8RZDd2SWcfWqAmdqIandiUEQbZfXspfG/4iPf9QYssVHYHbPYZQqWj2cpg/ADqECNh
         CQjxgxBkzN9nA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kuba@kernel.org,
        pabeni@redhat.com, alexander@mihalicyn.com, leitao@debian.org,
        lucien.xin@gmail.com, dhowells@redhat.com, kernelxing@tencent.com,
        andriy.shevchenko@linux.intel.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 15/45] net: Use sockaddr_storage for getsockopt(SO_PEERNAME).
Date:   Fri,  8 Sep 2023 14:12:56 -0400
Message-Id: <20230908181327.3459042-15-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 8936bf53a091ad6a34b480c22002f1cb2422ab38 ]

Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") started
applying strict rules to standard string functions.

It does not work well with conventional socket code around each protocol-
specific sockaddr_XXX struct, which is cast from sockaddr_storage and has
a bigger size than fortified functions expect.  See these commits:

 commit 06d4c8a80836 ("af_unix: Fix fortify_panic() in unix_bind_bsd().")
 commit ecb4534b6a1c ("af_unix: Terminate sun_path when bind()ing pathname socket.")
 commit a0ade8404c3b ("af_packet: Fix warning of fortified memcpy() in packet_getname().")

We must cast the protocol-specific address back to sockaddr_storage
to call such functions.

However, in the case of getsockaddr(SO_PEERNAME), the rationale is a bit
unclear as the buffer is defined by char[128] which is the same size as
sockaddr_storage.

Let's use sockaddr_storage explicitly.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index c9cffb7acbeae..a80b6b8633edc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1823,14 +1823,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_PEERNAME:
 	{
-		char address[128];
+		struct sockaddr_storage address;
 
-		lv = sock->ops->getname(sock, (struct sockaddr *)address, 2);
+		lv = sock->ops->getname(sock, (struct sockaddr *)&address, 2);
 		if (lv < 0)
 			return -ENOTCONN;
 		if (lv < len)
 			return -EINVAL;
-		if (copy_to_sockptr(optval, address, len))
+		if (copy_to_sockptr(optval, &address, len))
 			return -EFAULT;
 		goto lenout;
 	}
-- 
2.40.1

