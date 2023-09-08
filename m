Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC6798D8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbjIHSWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjIHSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:20:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532826BD;
        Fri,  8 Sep 2023 11:19:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A01FC43140;
        Fri,  8 Sep 2023 18:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197123;
        bh=5IUt5jOw0j/GAMErOaqocmM4IXD72TvXgoHe9eInHFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7R5Ump92ahHhk8v4HdJdTKKiI7WijaU2+P+K9LY65V+3Hlluk4xD6qha4KYFB2WS
         pOwxmeGYstHV4F3Gm5cWF5qbZmEvmzfGiT71lozBozZtzbBFe4Vm1WeXT/dHfE4kYx
         t6BhMKv6E2zgD68yv32LcJL9mfT1h765xdVZVIgZRSt+Rj1v1XdoMvfBgOhmvDXGi3
         5MnXd8dCw9/lyLRmrsNMwXRwtqN4dxQkK7Vholfvj91GKcr4miPOfP2i+H72IsPbz7
         wBYWVTpvk02k5Q4uLHO0f+DWae4oVFUAqLYd2Iu97IBodarZQoHHPfLn/tM3CeNPEX
         UwwRaS6Jqdjeg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     xu xin <xu.xin16@zte.com.cn>, Yang Yang <yang.yang29@zte.com.cn>,
        Si Hao <si.hao@zte.com.cn>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/26] net/ipv4: return the real errno instead of -EINVAL
Date:   Fri,  8 Sep 2023 14:17:50 -0400
Message-Id: <20230908181806.3460164-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

[ Upstream commit c67180efc507e04a87f22aa68bd7dd832db006b7 ]

For now, No matter what error pointer ip_neigh_for_gw() returns,
ip_finish_output2() always return -EINVAL, which may mislead the upper
users.

For exemple, an application uses sendto to send an UDP packet, but when the
neighbor table overflows, sendto() will get a value of -EINVAL, and it will
cause users to waste a lot of time checking parameters for errors.

Return the real errno instead of -EINVAL.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Si Hao <si.hao@zte.com.cn>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Link: https://lore.kernel.org/r/20230807015408.248237-1-xu.xin16@zte.com.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index acfe58d2f1dd7..831c627e03ff8 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -234,7 +234,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
 			    __func__);
 	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
-	return -EINVAL;
+	return PTR_ERR(neigh);
 }
 
 static int ip_finish_output_gso(struct net *net, struct sock *sk,
-- 
2.40.1

