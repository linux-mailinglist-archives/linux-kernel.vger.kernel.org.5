Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADAD798DC7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbjIHSYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344351AbjIHSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:22:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733A4358A;
        Fri,  8 Sep 2023 11:19:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BE9C43142;
        Fri,  8 Sep 2023 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197166;
        bh=Q+IjZG0Tp79KNBmY2MwgESORfBuGdtAgKIZeNd4EABE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deaLQm1B/3zlhlAqHSjxPL7zRC/5c0HxRXcgvuo/OyBi0vWhWPY8gQO5k+cd585q1
         cI/Fxmj47bGPSUACAPrFMH72QKz30ewOTVhiuMgE9dkzTKxRSQU2N6qKqFTEbCtqDs
         3e3EohVxIijmQCRmDKQBeMLpU++lQx7t5EJr1ygUsaRpQtvOGg0CHA+JvUr+Yow5v9
         1hIOSaERgYwqwvNA9MJvuv7h/ON77dsNgnjpDHTfAzYWWxATdmGGaOxArjcJnQFiQa
         YEgiiP3hkCEGMM54GmK0JanwqSFP9u3+6L/jj0DT57viGND9+QcY5U3VZtzfp7N1Np
         iGECS9/k/nIcg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/15] wifi: ath9k: fix fortify warnings
Date:   Fri,  8 Sep 2023 14:19:06 -0400
Message-Id: <20230908181920.3460520-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181920.3460520-1-sashal@kernel.org>
References: <20230908181920.3460520-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 810e41cebb6c6e394f2068f839e1a3fc745a5dcc ]

When compiling with gcc 13.1 and CONFIG_FORTIFY_SOURCE=y,
I've noticed the following:

In function ‘fortify_memcpy_chk’,
    inlined from ‘ath_tx_complete_aggr’ at drivers/net/wireless/ath/ath9k/xmit.c:556:4,
    inlined from ‘ath_tx_process_buffer’ at drivers/net/wireless/ath/ath9k/xmit.c:773:3:
./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  529 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In function ‘fortify_memcpy_chk’,
    inlined from ‘ath_tx_count_frames’ at drivers/net/wireless/ath/ath9k/xmit.c:473:3,
    inlined from ‘ath_tx_complete_aggr’ at drivers/net/wireless/ath/ath9k/xmit.c:572:2,
    inlined from ‘ath_tx_process_buffer’ at drivers/net/wireless/ath/ath9k/xmit.c:773:3:
./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  529 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In both cases, the compiler complains on:

memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);

which is the legal way to copy both 'ba_low' and following 'ba_high'
members of 'struct ath_tx_status' at once (that is, issue one 8-byte
'memcpy()' for two 4-byte fields). Since the fortification logic seems
interprets this trick as an attempt to overread 4-byte 'ba_low', silence
relevant warnings by using the convenient 'struct_group()' quirk.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230620080855.396851-2-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/mac.h  | 6 ++++--
 drivers/net/wireless/ath/ath9k/xmit.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/mac.h b/drivers/net/wireless/ath/ath9k/mac.h
index fd6aa49adadfe..9b00e77a6fc3c 100644
--- a/drivers/net/wireless/ath/ath9k/mac.h
+++ b/drivers/net/wireless/ath/ath9k/mac.h
@@ -113,8 +113,10 @@ struct ath_tx_status {
 	u8 qid;
 	u16 desc_id;
 	u8 tid;
-	u32 ba_low;
-	u32 ba_high;
+	struct_group(ba,
+		u32 ba_low;
+		u32 ba_high;
+	);
 	u32 evm0;
 	u32 evm1;
 	u32 evm2;
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 6555abf02f18b..84c68aefc171a 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -421,7 +421,7 @@ static void ath_tx_count_frames(struct ath_softc *sc, struct ath_buf *bf,
 	isaggr = bf_isaggr(bf);
 	if (isaggr) {
 		seq_st = ts->ts_seqnum;
-		memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+		memcpy(ba, &ts->ba, WME_BA_BMP_SIZE >> 3);
 	}
 
 	while (bf) {
@@ -504,7 +504,7 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 	if (isaggr && txok) {
 		if (ts->ts_flags & ATH9K_TX_BA) {
 			seq_st = ts->ts_seqnum;
-			memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+			memcpy(ba, &ts->ba, WME_BA_BMP_SIZE >> 3);
 		} else {
 			/*
 			 * AR5416 can become deaf/mute when BA
-- 
2.40.1

