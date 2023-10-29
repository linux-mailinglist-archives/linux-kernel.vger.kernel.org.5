Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7397DB059
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjJ2XFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjJ2XEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:04:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05846BB;
        Sun, 29 Oct 2023 15:59:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF6BC116B0;
        Sun, 29 Oct 2023 22:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620376;
        bh=YYDBIdZcK9E5uD5quMvahrJJ+VNFxKfBEQgQZwV1tS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sxk4CCL0CpIK1KXVxZtsvohumI2Lph7A3XzzOm7SmMhlqx54U1yJoQvxUllE+Z686
         RqUPBUpQ2ZXldRoiJEI3zaiPHK5MPHoIQqC5s+1kEODZOzO2YtfFTx7OBHwsQm3X80
         mwIeWwt+HiHe7JE+wd+uuqz9SzRMPpmbYfYbSjo8plpmYkArXMO3R2XKOwuA3v5UU6
         XMDYIF/lvqZLg/ER/iwXR6CNbdIIAkK6QV4NF+LXu/0pz0mgZULa3E6idn9lk9c1cn
         waFhkwdAE4wGpA3kZIQR3q3jPcHVes98TahkqsKFIyM3e58C5qLwZ9FmQ+qibiGIj8
         lr+B6P7cQBQjA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/28] net: ipv6: fix return value check in esp_remove_trailer
Date:   Sun, 29 Oct 2023 18:58:49 -0400
Message-ID: <20231029225916.791798-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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
index 6219d97cac7a3..26d476494676e 100644
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

