Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799317ABAD5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjIVVEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjIVVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:04:52 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67349AC;
        Fri, 22 Sep 2023 14:04:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9AAC4C0002;
        Fri, 22 Sep 2023 21:04:40 +0000 (UTC)
From:   Ilya Maximets <i.maximets@ovn.org>
To:     netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Madhu Koriginja <madhu.koriginja@nxp.com>,
        Frode Nordahl <frode.nordahl@canonical.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net] ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling
Date:   Fri, 22 Sep 2023 23:04:58 +0200
Message-ID: <20230922210530.2045146-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 300
X-GND-Status: SPAM
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b0e214d21203 ("netfilter: keep conntrack reference until
IPsecv6 policy checks are done") is a direct copy of the old
commit b59c270104f0 ("[NETFILTER]: Keep conntrack reference until
IPsec policy checks are done") but for IPv6.  However, it also
copies a bug that this old commit had.  That is: when the third
packet of 3WHS connection establishment contains payload, it is
added into socket receive queue without the XFRM check and the
drop of connection tracking context.

That leads to nf_conntrack module being impossible to unload as
it waits for all the conntrack references to be dropped while
the packet release is deferred in per-cpu cache indefinitely, if
not consumed by the application.

The issue for IPv4 was fixed in commit 6f0012e35160 ("tcp: add a
missing nf_reset_ct() in 3WHS handling") by adding a missing XFRM
check and correctly dropping the conntrack context.  However, the
issue was introduced to IPv6 code afterwards.  Fixing it the
same way for IPv6 now.

Fixes: b0e214d21203 ("netfilter: keep conntrack reference until IPsecv6 policy checks are done")
Link: https://lore.kernel.org/netdev/d589a999-d4dd-2768-b2d5-89dec64a4a42@ovn.org/
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/ipv6/tcp_ipv6.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3a88545a265d..44b6949d72b2 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1640,9 +1640,12 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		struct sock *nsk;
 
 		sk = req->rsk_listener;
-		drop_reason = tcp_inbound_md5_hash(sk, skb,
-						   &hdr->saddr, &hdr->daddr,
-						   AF_INET6, dif, sdif);
+		if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
+			drop_reason = SKB_DROP_REASON_XFRM_POLICY;
+		else
+			drop_reason = tcp_inbound_md5_hash(sk, skb,
+							   &hdr->saddr, &hdr->daddr,
+							   AF_INET6, dif, sdif);
 		if (drop_reason) {
 			sk_drops_add(sk, skb);
 			reqsk_put(req);
@@ -1689,6 +1692,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			}
 			goto discard_and_relse;
 		}
+		nf_reset_ct(skb);
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-- 
2.41.0

