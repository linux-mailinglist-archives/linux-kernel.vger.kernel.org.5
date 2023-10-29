Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F387DB175
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjJ2XgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjJ2XEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:04:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A47D9E;
        Sun, 29 Oct 2023 16:02:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47042C43397;
        Sun, 29 Oct 2023 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620422;
        bh=R6lCd2BQPRJhg0awLOEDWNc9dCD1VE0KBm+vmPMcli0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+8qhV3rRVZS9UkOBym4bbDO/cPRq/V/zl9clADJm/wY7B/fN3eaIlbMh/ikq7TZh
         zmMl7LE0lT+3QYfZ0tK2mClmN8QSJoJEgdVYmpYKpDQfsFQIVEUgibt50X03bI6He/
         48ORUnnJYYpJKOxkyn8DJ0FHWqtsq6/6pR8pcL8zuZLJrvVf0MkO7u4J7uUtVqEClg
         Ujsdg8CFxAqJlg9LGjIpryxJHVNfyW3+okyzx7wWObkw0Yo13HIxAwN9iz5E3ysPwu
         2ygEstutckM33s9+TmXbEoG9lZBIMYNwcNWzPPrD3de+vPd0PNGLQfSrHOOXni0I6d
         OsdkLMfpkJrrg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 04/16] net: ipv6: fix return value check in esp_remove_trailer
Date:   Sun, 29 Oct 2023 18:59:50 -0400
Message-ID: <20231029230014.792490-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230014.792490-1-sashal@kernel.org>
References: <20231029230014.792490-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
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
index cb28f8928f9ee..fddc811bbde1f 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -776,7 +776,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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

