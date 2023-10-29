Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759CB7DB0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjJ2XIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjJ2XIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:08:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF08AD06;
        Sun, 29 Oct 2023 16:03:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CE8C43140;
        Sun, 29 Oct 2023 23:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620538;
        bh=+VKJaBCBR/JhCoz892Wzq0BO8RG0rKGVNKUJBUsRMgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7YJLjSONCxPPHxxGYFlmsspOcl3pKTQy4FgoRct0DieXxxPeIKqgMBLFaFHwyyT4
         0mmscH43qq3issXXNjKqGo7Uf+h+Sg2O8aY1HdJbcPGCOio9B9B3q7/5dz+NYvLv50
         El6vh8NaWftjayt0jS3xn6pIX/24zGpAsVU15RX0jhEHfR4q5Hr32gZjCtGnRhetoI
         M2Qg0hS1dHlGaOI5b8ytXakN9LV4ncZf1y+H/9tzG/EQ2n0A81ib2z5KsJmTUEmQr3
         bRlmZyj5O+iJnLMqIutHdVfsUx7aL7Qko6jIDEP4VP4LASPjVCgrc3LSiY+TE3pSA2
         rGpQ+MsIZd8Xw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/11] net: ipv6: fix return value check in esp_remove_trailer
Date:   Sun, 29 Oct 2023 19:01:53 -0400
Message-ID: <20231029230213.793581-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230213.793581-1-sashal@kernel.org>
References: <20231029230213.793581-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit dad4e491e30b20f4dc615c9da65d2142d703b5c2 ]

In esp_remove_trailer(), to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/esp6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index e19624245e167..25c12d0ccd284 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -499,7 +499,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 
-- 
2.42.0

