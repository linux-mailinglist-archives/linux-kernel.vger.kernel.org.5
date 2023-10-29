Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5E7DAF15
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJ2W4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjJ2Wzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:55:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F7310EA;
        Sun, 29 Oct 2023 15:55:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1766CC433C9;
        Sun, 29 Oct 2023 22:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620112;
        bh=cfI29PQJSiYahbkvtclk8BjJZ5sHHb1RQDEd7GQkkuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKdsOjfZYpUlvlsdpKo9utpvZt2kSOfdGUqQAsGvT37obDoPN8IyTAGrS0Au/4S9m
         euwxuLWQ4SV+SKkNiXmBtBH6BbYI5tQzIu+bGDTI1GIIM6YUuJ+1mF96oGMEVHIV+t
         vuxkdHq/5T+Y30K49Rgi9AemjESMconnM5zk4pD0Vqwqk0BKP6LOhbYuFeODyZSDiM
         KavfT240wOaS94Q/+SdjQ64TFyS07Z8nVF+XAyd2h8fxPCFvQQtmReWM4JAsSplz0d
         8cQc2dOlbjr29Yxf3dzFeZv9YCIblSFrQPspqf2MzEvQfBgCIAmQWX2UXb0X3j50/2
         BdsPQG4KVss/w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 20/52] net: ipv6: fix return value check in esp_remove_trailer
Date:   Sun, 29 Oct 2023 18:53:07 -0400
Message-ID: <20231029225441.789781-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
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
index fddd0cbdede15..e023d29e919c1 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -770,7 +770,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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

