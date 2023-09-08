Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABF4799088
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjIHTsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbjIHTsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:48:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAA52101;
        Fri,  8 Sep 2023 12:48:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E611C433A9;
        Fri,  8 Sep 2023 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197113;
        bh=cgEaIzwHZTyAPMNCMxGDfmUJA2R5lfAjPk2R7thf1CQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnP0Qr9wwBfxBrWzdIXFWR3+mJSNtp05XzAQoDVR4vM1wrOPVWnb255K+CAe5gFtN
         nlewU5W1Y2JLrfpmHtuoaZkYLpM7QCrVqF8Sr0Ik0DaCaZEO60FmFq3y81w00T8Zz6
         4pIUE2PxdJm8rErqzk3EHgKjnsTJ5DCspSnI6dW/ogMUV/Wf2Fp2p5BOJ6t1e4AX+R
         CEp7Ubc/eBOdE9GXFONAWVJsGmLOE3/e+8ktkU+VAtf58o9jBqDByCKlFbkfEfB3PR
         8ymblsO3pAIg7BviYVfjRSx/Y7y7iu9U/6d0AgjG1b0z3MYB5hjMF29DomK9p6CGbw
         hshG3725xkybQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/26] wifi: wil6210: fix fortify warnings
Date:   Fri,  8 Sep 2023 14:17:46 -0400
Message-Id: <20230908181806.3460164-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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

[ Upstream commit 1ad8237e971630c66a1a6194491e0837b64d00e0 ]

When compiling with gcc 13.1 and CONFIG_FORTIFY_SOURCE=y,
I've noticed the following:

In function ‘fortify_memcpy_chk’,
    inlined from ‘wil_rx_crypto_check_edma’ at drivers/net/wireless/ath/wil6210/txrx_edma.c:566:2:
./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  529 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

where the compiler complains on:

const u8 *pn;
...
pn = (u8 *)&st->ext.pn_15_0;
...
memcpy(cc->pn, pn, IEEE80211_GCMP_PN_LEN);

and:

In function ‘fortify_memcpy_chk’,
    inlined from ‘wil_rx_crypto_check’ at drivers/net/wireless/ath/wil6210/txrx.c:684:2:
./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  529 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

where the compiler complains on:

const u8 *pn = (u8 *)&d->mac.pn_15_0;
...
memcpy(cc->pn, pn, IEEE80211_GCMP_PN_LEN);

In both cases, the fortification logic interprets 'memcpy()' as 6-byte
overread of 2-byte field 'pn_15_0' of 'struct wil_rx_status_extension'
and 'pn_15_0' of 'struct vring_rx_mac', respectively. To silence
these warnings, last two fields of the aforementioned structures
are grouped using 'struct_group_attr(pn, __packed' quirk.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230621093711.80118-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/txrx.c      | 2 +-
 drivers/net/wireless/ath/wil6210/txrx.h      | 6 ++++--
 drivers/net/wireless/ath/wil6210/txrx_edma.c | 2 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.h | 6 ++++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index 237cbd5c5060b..f29ac6de71399 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -666,7 +666,7 @@ static int wil_rx_crypto_check(struct wil6210_priv *wil, struct sk_buff *skb)
 	struct wil_tid_crypto_rx *c = mc ? &s->group_crypto_rx :
 				      &s->tid_crypto_rx[tid];
 	struct wil_tid_crypto_rx_single *cc = &c->key_id[key_id];
-	const u8 *pn = (u8 *)&d->mac.pn_15_0;
+	const u8 *pn = (u8 *)&d->mac.pn;
 
 	if (!cc->key_set) {
 		wil_err_ratelimited(wil,
diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wireless/ath/wil6210/txrx.h
index 1ae1bec1b97f1..689f68d89a440 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.h
+++ b/drivers/net/wireless/ath/wil6210/txrx.h
@@ -343,8 +343,10 @@ struct vring_rx_mac {
 	u32 d0;
 	u32 d1;
 	u16 w4;
-	u16 pn_15_0;
-	u32 pn_47_16;
+	struct_group_attr(pn, __packed,
+		u16 pn_15_0;
+		u32 pn_47_16;
+	);
 } __packed;
 
 /* Rx descriptor - DMA part
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 201c8c35e0c9e..1ba1f21ebea26 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -548,7 +548,7 @@ static int wil_rx_crypto_check_edma(struct wil6210_priv *wil,
 	s = &wil->sta[cid];
 	c = mc ? &s->group_crypto_rx : &s->tid_crypto_rx[tid];
 	cc = &c->key_id[key_id];
-	pn = (u8 *)&st->ext.pn_15_0;
+	pn = (u8 *)&st->ext.pn;
 
 	if (!cc->key_set) {
 		wil_err_ratelimited(wil,
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.h b/drivers/net/wireless/ath/wil6210/txrx_edma.h
index c736f7413a35f..ee90e225bb050 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.h
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.h
@@ -330,8 +330,10 @@ struct wil_rx_status_extension {
 	u32 d0;
 	u32 d1;
 	__le16 seq_num; /* only lower 12 bits */
-	u16 pn_15_0;
-	u32 pn_47_16;
+	struct_group_attr(pn, __packed,
+		u16 pn_15_0;
+		u32 pn_47_16;
+	);
 } __packed;
 
 struct wil_rx_status_extended {
-- 
2.40.1

