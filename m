Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E612C798CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjIHSRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343757AbjIHSR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:17:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726772686;
        Fri,  8 Sep 2023 11:17:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBB6C116A5;
        Fri,  8 Sep 2023 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196858;
        bh=sAJVwDnVfMC68NnK7e6bGEnmQvv4Qz9zWh7h7t9PFqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDueDMfnCslX+oAth2yeDaqk1JfRomVN/zDort4Ta3EuISCLYgNlauy5Mhw4Q9A9A
         9L+gudNIVeYBuR790uYd8w11bmCT2ew142sWP6WR5W3e6BabqVRxMJpMUghJL4fP16
         UYbeXdI9xonj1y+VkvNUbgEe+XbEjx8hYbvQyRzxhWZ5ZgiT38XUSnlp0homGTuw04
         LbFMgQbZxyThEE7bJrcWo1A5gk8ss4lWGGb6AA/uxYqlP5Y+si+KlG4DTe7KhZkTAV
         r49rP/Z2HuHVgQ9nMGRgMXXk+3PIPKqzuJ44BDyW0lM0aNgRPEf4dJ/kK1uYu14YY3
         TG9E5N1Lx1KyQ==
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
Subject: [PATCH AUTOSEL 6.5 18/45] net/ipv4: return the real errno instead of -EINVAL
Date:   Fri,  8 Sep 2023 14:12:59 -0400
Message-Id: <20230908181327.3459042-18-sashal@kernel.org>
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
index 6ba1a0fafbaab..f28c87533a465 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -236,7 +236,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
 			    __func__);
 	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
-	return -EINVAL;
+	return PTR_ERR(neigh);
 }
 
 static int ip_finish_output_gso(struct net *net, struct sock *sk,
-- 
2.40.1

