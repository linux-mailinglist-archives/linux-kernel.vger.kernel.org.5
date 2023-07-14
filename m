Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6772F753A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjGNMCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjGNMCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:02:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CDF211C;
        Fri, 14 Jul 2023 05:02:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b89600a37fso10977425ad.2;
        Fri, 14 Jul 2023 05:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689336156; x=1691928156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+OdrVc56e5RTuGTUrMy61ven4IlP20DP2UghO8h8RM=;
        b=AzIMpdwlDQJ2KUyfUMnKMVov3Csi/ihnnmuI0jugRRL7/8oVFPoLGWdjUP01q2sK2m
         pX3ft9HdvKv0TE5/hErX3pAUJC6j7X7a25fbPHi7aLH4lselSMKarrKHxk36Z5ZDVoJM
         h28wVe/zIOggYsHjijzc5wGfGxeGJuLnzS7QPK0Vw7rtGfJxhAHn515rDI6gJObO+qS2
         TfbYFuybWVsgK7jIMDFdoXLQlwujLPCKrUpjEh25asmAnb2sb/ct7MKbVdrFaXESprWN
         c5Zbi/rDQamWr7SdQVoc4RMzM5+5Ah87qrlrDDNewZ/q1KkKwKDdRvmNwUPvF4i/Tk+A
         S4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689336156; x=1691928156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+OdrVc56e5RTuGTUrMy61ven4IlP20DP2UghO8h8RM=;
        b=GD50c2svbmNOT1CaKMPebHQh0N0fVzPlbuPTe7PaVFyRZ34W5rLsYLGAfuTn9jB7Nl
         EBjasOoAxGVRfP9Gmm9vF9yzbFaZ8nkrXl0T4tQ0r/twANNkR6GD/b+iLg8vYkRCdp+K
         FbW8ziF5tFXpLZ028R8Wzwdl/5rOzTq6f7mEbHvGUbfb71cBh71mbXH+gfON6fYnuC+3
         D/kZzHKsgdqnW9W6hzFzy3ETS79fRgW636BIFinDqFgnHS+CuL0QwU1WXgLpGlt45MyV
         RmTOIvUCi4zzUezTvqPKjVEpLuZnpEcQnmuWvGOUgRQitCQUQzkStzCKybqJbGCw5k25
         InQA==
X-Gm-Message-State: ABy/qLZCi71uNVuTauaZkEgyXOJdgHzQRwWGrT+kxnHAaDEmFUg1CR1+
        YsGJG+NFd1hFXSEhQx772rU=
X-Google-Smtp-Source: APBJJlHej3x4nD/U+DIesYA9vD9DFRscADJJ/Jdwi47liaBoBDxN+tgO6LVu/jyQivZn0kJjqnPsyQ==
X-Received: by 2002:a17:902:b285:b0:1b8:af5e:853f with SMTP id u5-20020a170902b28500b001b8af5e853fmr3334432plr.24.1689336156350;
        Fri, 14 Jul 2023 05:02:36 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902c1c900b001b567bbe82dsm7634350plc.150.2023.07.14.05.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:02:35 -0700 (PDT)
From:   Polaris Pi <pinkperfect2021@gmail.com>
To:     kuba@kernel.org, amitkarwar@gmail.com, kvalo@kernel.org,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Polaris Pi <pinkperfect2021@gmail.com>
Subject: [PATCH v5] wifi: mwifiex: Fix OOB and integer underflow when rx packets
Date:   Fri, 14 Jul 2023 12:02:22 +0000
Message-Id: <20230714120222.3920248-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure mwifiex_process_mgmt_packet and its callers
mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet
not out-of-bounds access the skb->data buffer.

Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80211")
Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
---
V5: Follow chromeos comments: preserve the original flow of mwifiex_process_uap_rx_packet
---
 drivers/net/wireless/marvell/mwifiex/sta_rx.c   |  3 ++-
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 11 +++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c     |  5 +++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 13659b02ba88..88aaec645291 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -194,7 +194,8 @@ int mwifiex_process_sta_rx_packet(struct mwifiex_private *priv,
 
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
 
-	if ((rx_pkt_offset + rx_pkt_length) > (u16) skb->len) {
+	if ((rx_pkt_offset + rx_pkt_length) > (u16)skb->len ||
+	    skb->len - rx_pkt_offset < sizeof(*rx_pkt_hdr)) {
 		mwifiex_dbg(adapter, ERROR,
 			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
 			    skb->len, rx_pkt_offset, rx_pkt_length);
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index e495f7eaea03..32f4626a4d76 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -367,6 +367,17 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
 	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
 
+	if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len ||
+	    skb->len - le16_to_cpu(uap_rx_pd->rx_pkt_offset) < sizeof(*rx_pkt_hdr)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "wrong rx packet offset: len=%d, offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
 	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
 
 	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 94c2d219835d..31e1a82883e4 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -399,6 +399,11 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 
 	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
 
+	if (pkt_len < sizeof(struct ieee80211_hdr) || skb->len < pkt_len) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length");
+		return -1;
+	}
+
 	ieee_hdr = (void *)skb->data;
 	if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
 		if (mwifiex_parse_mgmt_packet(priv, (u8 *)ieee_hdr,
-- 
2.25.1

