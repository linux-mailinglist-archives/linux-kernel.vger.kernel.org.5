Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A527DB088
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjJ2XHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjJ2XHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:07:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5D761BD;
        Sun, 29 Oct 2023 16:01:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC150C116B1;
        Sun, 29 Oct 2023 23:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620466;
        bh=eh+BnGU36fQ/CfwTAWI+xAvGZm/nshceb3+eqEDRVd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfOhMBXcEJJiKqhgKO3N9Czfq4qaVu9K3Ai23tkMZN8KK+liDaLl+W4w5DUKMpYqC
         75YEBmSTmSnVLYNtOR0FuB9kWuyC5MnTeWsEKqp0vI8xO+oIOsjgp/RXy3JbreKsWY
         Ep0uuxL44jN+QdMyusGgQRKbRhyvLyQ8L9nGASbnAIOxOmID6TBIJtH4TsXcVxboIF
         8yDhlOdBI58pyXkrKU312cMHG11LcpE+6mfvkmljBhLrcrY1QD5nMzm4kGdVgbZVms
         0+XUdB/2PMypNjFfW1hjX+Zu7b6aANGBJsvKiG9lR4QR/lBab5f/zicVzLayqRt0yG
         xjMJaFjm3euhg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/13] net: ipv4: fix return value check in esp_remove_trailer
Date:   Sun, 29 Oct 2023 19:00:37 -0400
Message-ID: <20231029230057.792930-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230057.792930-1-sashal@kernel.org>
References: <20231029230057.792930-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
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
index f555dd4bac653..9a8f0e36bbf91 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -567,7 +567,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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

