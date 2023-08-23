Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF59B785EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjHWRjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjHWRjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:39:00 -0400
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50547E5A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:38:56 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 23 Aug
 2023 20:38:53 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 23 Aug
 2023 20:38:52 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <wireguard@lists.zx2c4.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>,
        <lvc-project@linuxtesting.org>,
        <syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com>
Subject: [PATCH net] wireguard: receive: fix data-race around receiving_counter.counter
Date:   Wed, 23 Aug 2023 10:38:39 -0700
Message-ID: <20230823173839.43938-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller with KCSAN identified a data-race issue when accessing
keypair->receiving_counter.counter.

This patch uses READ_ONCE() and WRITE_ONCE() annotations to fix the
problem.

Fixes: a9e90d9931f3 ("wireguard: noise: separate receive counter from send counter")
Reported-by: syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/net/wireguard/receive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index 0b3f0c843550..b5232ffa8bc7 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -251,7 +251,7 @@ static bool decrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 
 	if (unlikely(!READ_ONCE(keypair->receiving.is_valid) ||
 		  wg_birthdate_has_expired(keypair->receiving.birthdate, REJECT_AFTER_TIME) ||
-		  keypair->receiving_counter.counter >= REJECT_AFTER_MESSAGES)) {
+		  READ_ONCE(keypair->receiving_counter.counter) >= REJECT_AFTER_MESSAGES)) {
 		WRITE_ONCE(keypair->receiving.is_valid, false);
 		return false;
 	}
@@ -318,7 +318,7 @@ static bool counter_validate(struct noise_replay_counter *counter, u64 their_cou
 		for (i = 1; i <= top; ++i)
 			counter->backtrack[(i + index_current) &
 				((COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1)] = 0;
-		counter->counter = their_counter;
+		WRITE_ONCE(counter->counter, their_counter);
 	}
 
 	index &= (COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1;
-- 
2.25.1

