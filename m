Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987517E3C27
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjKGMM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjKGMMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:12:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5963260;
        Tue,  7 Nov 2023 04:10:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B8EC433CA;
        Tue,  7 Nov 2023 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359009;
        bh=mReg+dauLzHBzFGQXhCrsX2gIABa2epUWZcZQHeDFZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXK0gRbjte0LxCOpBo8wvNCopuqoLSubDKHk5j58QNbsX76VCFLni6SwoZsDbfHo8
         n8a6dbBZmUf4IZA/mqqL2W94GZxsR0jHJwOZof4JS/DO2/vp90qQqUyF891MpDLPfs
         SzRxJUXlUeAW2vKTvy3ka/E8nBDvMVJc+zPnXZMl+AxSFq0E8X5kgUdgbK+T7RBnfF
         sX2RwOrpJds8B10i0qNGcuizDWupdTJsvXMkD5TGxFM8mjV+Vl+AyqQyasx80MHBpI
         FAr1vJeGpZdj26nDjeS01fwehMDbvUHrvzci50K/VRg9A2ICWdpUVQviZHkYru0pXK
         LCI7TgXHAENiA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 15/30] net: annotate data-races around sk->sk_tx_queue_mapping
Date:   Tue,  7 Nov 2023 07:08:30 -0500
Message-ID: <20231107120922.3757126-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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
index fc189910e63fc..df19f99d26357 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2006,21 +2006,33 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
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

