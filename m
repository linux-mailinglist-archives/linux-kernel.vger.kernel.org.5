Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F127DB0BB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjJ2XKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjJ2XJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:09:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C2AD07;
        Sun, 29 Oct 2023 16:03:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20942C433CB;
        Sun, 29 Oct 2023 23:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620540;
        bh=F+KDT330zA7lLtN8EcxqS8DGK9XLFLIFJHi7Hdj9Vl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJ0pA88a7RX74BXfWubo5PKp5h2t1NjQmMIYjzlRrJ4xP9ZBg43pfWeoJFoMm+ffe
         ynQ7g68j5AM0pa1kD+DpeND404c9xfGq+hnKjj3I3DDCY54pBuESKLAZI/nT8/RSyN
         HN/Om4g1NUQYPehU+LH1oTTmjBStIOR5S//9cbXACQ00H9QHpareeA4EsnbKf8HNLb
         NiRv7+dY+uYt0LoW2G7uTfsZBOpzcXyJQkOADyy6I0vwfKiw76zxKzHKHDjKh3RWLW
         9vbTZ/OBNt8Fzpj3HnxTR5rqf1Wjk5vMAYu3dRxQbXUtqtBQ8usLc20h3Jq4Hpr3zl
         20jkn7+/3EnCw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/11] net: ipv4: fix return value check in esp_remove_trailer
Date:   Sun, 29 Oct 2023 19:01:54 -0400
Message-ID: <20231029230213.793581-3-sashal@kernel.org>
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

[ Upstream commit 513f61e2193350c7a345da98559b80f61aec4fa6 ]

In esp_remove_trailer(), to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/esp4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d5e860573ecd4..79fa2d7852efa 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -547,7 +547,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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

