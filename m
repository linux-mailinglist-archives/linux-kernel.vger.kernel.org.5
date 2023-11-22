Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C937F4AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbjKVPhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbjKVPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:36:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4354211F;
        Wed, 22 Nov 2023 07:35:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9195FC433CB;
        Wed, 22 Nov 2023 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667299;
        bh=jqu5Q4t8p2JD2LS+G0ijsdOaSqeJMSxsAA7u9QbWSRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCC/aRvkoIbj3ny23glDw64Tr6Ra2ZjoX73kr77jLtF8Db1Dl4BIhl4DinEKdEMCe
         +ByDTgWYVqcH6BP7Y2pYXDUCHIyziecnGH0s61KJdhW2Hn8fesO/qID+c7Vqg8nYxM
         Du8WRSxmccZgl7CCUliV1FzppxOJ4+re5G6qN8GxyZPwekpQ6gGwCeeUITT3Urh79i
         02rYWpjxyafBhqw1BNmiqSFR1QUxytfTyhCBH2Cp1oQgCFzVPTimrc+iqLEd3+B10O
         jf72baxn4WioGtRQyRTT/fx7KGmBpGph0dfXy8p3z4K9BjypWydooRl5DS4gQg5BiU
         j42B0ii+Jm/QQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Pakhunov <alexey.pakhunov@spacex.com>,
        Vincent Wong <vincent.wong2@spacex.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, mchan@broadcom.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 7/9] tg3: Increment tx_dropped in tg3_tso_bug()
Date:   Wed, 22 Nov 2023 10:34:31 -0500
Message-ID: <20231122153440.852807-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153440.852807-1-sashal@kernel.org>
References: <20231122153440.852807-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.63
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

[ Upstream commit 17dd5efe5f36a96bd78012594fabe21efb01186b ]

tg3_tso_bug() drops a packet if it cannot be segmented for any reason.
The number of discarded frames should be incremented accordingly.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://lore.kernel.org/r/20231113182350.37472-2-alexey.pakhunov@spacex.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 830f542a7c6d2..f60a16de565ed 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7879,8 +7879,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
-- 
2.42.0

