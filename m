Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59047E3C8D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjKGMRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjKGMQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:16:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C9846B3;
        Tue,  7 Nov 2023 04:12:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213EEC43395;
        Tue,  7 Nov 2023 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359136;
        bh=TtWCg/eP5F31DlPLAlF2GSU1qVOUUjLiPvLmgJtHgMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qNoWaw46Dv2XYPy5XO4E0DKWUL6GXx5S+tB/4srBU2edunhTsMS6/NIQFVOKGWC3t
         GoZHvbkZ9u0AdJSkyQjDsV1woq9eA/zEQrnj3+otcXCWhgQ0UotS1ilGDkjWAqP+BP
         aFvlq8b+cT7TQCv3de9N32+paHxfq0m72R3jt/H06j9gw4lBTxyZZFxjpbd68Zcbou
         C0Ey94MmoD6bIF2aNVUi0LLSUWQlvCg3A1vzESIIpeJaUWQsSYStjoxq5ThuhHoJuF
         GQ0nJPZC4OlsnuVsd4tF9ka6d+N+IPUyPXH8zaFOEpcvuI0Uxj0qO6fRsBV+vNjClD
         2m0+kfyedRRxg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 07/12] net: annotate data-races around sk->sk_tx_queue_mapping
Date:   Tue,  7 Nov 2023 07:11:44 -0500
Message-ID: <20231107121158.3758348-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121158.3758348-1-sashal@kernel.org>
References: <20231107121158.3758348-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0bb4d124d34044179b42a769a0c76f389ae973b6 ]

This field can be read or written without socket lock being held.

Add annotations to avoid load-store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 640bd7a367779..d148dc95c9e9c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1923,21 +1923,33 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
 	/* sk_tx_queue_mapping accept only upto a 16-bit value */
 	if (WARN_ON_ONCE((unsigned short)tx_queue >= USHRT_MAX))
 		return;
-	sk->sk_tx_queue_mapping = tx_queue;
+	/* Paired with READ_ONCE() in sk_tx_queue_get() and
+	 * other WRITE_ONCE() because socket lock might be not held.
+	 */
+	WRITE_ONCE(sk->sk_tx_queue_mapping, tx_queue);
 }
 
 #define NO_QUEUE_MAPPING	USHRT_MAX
 
 static inline void sk_tx_queue_clear(struct sock *sk)
 {
-	sk->sk_tx_queue_mapping = NO_QUEUE_MAPPING;
+	/* Paired with READ_ONCE() in sk_tx_queue_get() and
+	 * other WRITE_ONCE() because socket lock might be not held.
+	 */
+	WRITE_ONCE(sk->sk_tx_queue_mapping, NO_QUEUE_MAPPING);
 }
 
 static inline int sk_tx_queue_get(const struct sock *sk)
 {
-	if (sk && sk->sk_tx_queue_mapping != NO_QUEUE_MAPPING)
-		return sk->sk_tx_queue_mapping;
+	if (sk) {
+		/* Paired with WRITE_ONCE() in sk_tx_queue_clear()
+		 * and sk_tx_queue_set().
+		 */
+		int val = READ_ONCE(sk->sk_tx_queue_mapping);
 
+		if (val != NO_QUEUE_MAPPING)
+			return val;
+	}
 	return -1;
 }
 
-- 
2.42.0

