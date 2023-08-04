Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2B76FC6E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHDItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHDItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:12 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F243C49FC;
        Fri,  4 Aug 2023 01:49:08 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4RHKBl75klzZK6m;
        Fri,  4 Aug 2023 16:49:03 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4RHKBS5XZ3z5BfmN;
        Fri,  4 Aug 2023 16:48:48 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RHKBP46FGz7QYS7;
        Fri,  4 Aug 2023 16:48:45 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl1.zte.com.cn with SMTP id 3748mV09049239;
        Fri, 4 Aug 2023 16:48:31 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 4 Aug 2023 16:48:33 +0800 (CST)
Date:   Fri, 4 Aug 2023 16:48:33 +0800 (CST)
X-Zmail-TransId: 2b0364ccbb6161e-7e8ca
X-Mailer: Zmail v1.0
Message-ID: <202308041648338823694@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <davem@davemloft.net>
Cc:     <dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBuZXQvaXB2NDogcmV0dXJuIHRoZSByZWFsIGVycm5vIGluc3RlYWQgb2YgLUVJTlZBTA==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3748mV09049239
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64CCBB7E.001/4RHKBl75klzZK6m
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

For now, no matter what error pointer ip_neigh_for_gw() returns,
ip_finish_output2() always return -EINVAL, which may mislead the upper
users.

For exemple, an application uses sendto to send an UDP packet, but when the
neighbor table overflows, sendto() will get a value of -EINVAL, and it will
cause users to waste a lot of time checking parameters for errors.

Return the real errno instead of -EINVAL.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Si Hao <si.hao@zte.com.cn>
Cc: Dai Shixin <dai.shixin@zte.com.cn>
Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
---
 net/ipv4/ip_output.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6ba1a0fafbaa..2d7cf083dff9 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -201,6 +201,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
 	bool is_v6gw = false;
+	int res;

 	if (rt->rt_type == RTN_MULTICAST) {
 		IP_UPD_PO_STATS(net, IPSTATS_MIB_OUTMCAST, skb->len);
@@ -214,8 +215,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	}

 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
-		int res = lwtunnel_xmit(skb);
-
+		res = lwtunnel_xmit(skb);
 		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
 			return res;
 	}
@@ -223,8 +223,6 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	rcu_read_lock();
 	neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	if (!IS_ERR(neigh)) {
-		int res;
-
 		sock_confirm_neigh(skb, neigh);
 		/* if crossing protocols, can not use the cached header */
 		res = neigh_output(neigh, skb, is_v6gw);
@@ -236,7 +234,8 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
 			    __func__);
 	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
-	return -EINVAL;
+	res = PTR_ERR(neigh);
+	return res;
 }

 static int ip_finish_output_gso(struct net *net, struct sock *sk,
-- 
2.15.2
