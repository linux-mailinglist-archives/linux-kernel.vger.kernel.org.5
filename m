Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA675752E06
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjGMXmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjGMXmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:42:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298642707;
        Thu, 13 Jul 2023 16:42:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66767d628e2so894220b3a.2;
        Thu, 13 Jul 2023 16:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689291719; x=1691883719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RavftxM7stIkYQ2IJPruUWiOpFM2KNLE8/u9G61hE4A=;
        b=MuJE1t4T255NCEZrBBpi0yNwry35P/wlbqLeRmCJoeetMdL2iwt4om53GKdD5JEvab
         rnNQFYFiuJheLARUpzyOdO+OB8Dg6XaCtXCuKJpTSOYFP6wQXhoQ8AZkO/Pahspf6Mku
         /8QeCLtB6VwOSRTjAc8xIyhappD46Y7iEHCssVip+VMcmhba+PgY3i/4nry8//z7BWC8
         s954ToOV3VjEtN1upnzaQN3vAau++1JnXa2GEcGShbUu77m/NOtiJDNPw0MgUV/l0cDC
         pkCQ1EWOrxrbg85LbB9sl8Lt9Wt3UMyKd9j7FOaDn1RQWh4fq3sjAoIGRMCLz+1YB0TS
         0srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689291719; x=1691883719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RavftxM7stIkYQ2IJPruUWiOpFM2KNLE8/u9G61hE4A=;
        b=ijHEgyX5sQCjWwSnNWhlpepqmBfTnBgejKtoYgGnz1bvdXGcxpkHMjoRvx919SKeaj
         +dR0K9pwmb9+62nA9ngrHTUVNGSTHXudtf53ckXFCd/vXDEFs6AMu05cKIfENWZg25Eu
         A1JJtA1eAWrn+pVYzucM7KC8FrwZktrcjdMll60VwlsWsTh7w7U3txc/ZAWE7o4s/SrY
         JI4xdbJ9xoBMkJejsPda8QeOChFB/u9gJmsaRzh2AXCZ4BkEDRPg9fcw2qA9fHBV4QUg
         y2lJ6EXSyjhASTFZyl49jzuunknpYR1gQ75Cr7OhMZHmUaMoLr0Mh34e8/7YigSwxYiG
         YDog==
X-Gm-Message-State: ABy/qLYpvOS54DrVRmTRgLFsHVZxXEz4w3oqGhlP8ck6whdHVPfBQmXZ
        /0N+WLo3+z8ZXXHebvJhZ7oJELfgGMlQONLDJ2s=
X-Google-Smtp-Source: APBJJlFfv7VasI4YZaVvcUzi2+APdnETq0oX/B50Js9LdFkM+A+5Vt0QH3Z0YfjEXSo/HY6K93ROdQ==
X-Received: by 2002:a05:6a00:14c6:b0:682:7d8a:f887 with SMTP id w6-20020a056a0014c600b006827d8af887mr2661411pfu.30.1689291719479;
        Thu, 13 Jul 2023 16:41:59 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b0067a50223e3bsm5927984pfo.111.2023.07.13.16.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 16:41:59 -0700 (PDT)
From:   Polaris Pi <pinkperfect2021@gmail.com>
To:     kuba@kernel.org, amitkarwar@gmail.com, kvalo@kernel.org,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Polaris Pi <pinkperfect2021@gmail.com>
Subject: [PATCH v4] wifi: mwifiex: Fix OOB and integer underflow when rx packets
Date:   Thu, 13 Jul 2023 23:41:50 +0000
Message-Id: <20230713234150.2533384-1-pinkperfect2021@gmail.com>
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
 drivers/net/wireless/marvell/mwifiex/sta_rx.c   |  3 ++-
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 10 +++-------
 drivers/net/wireless/marvell/mwifiex/util.c     |  5 +++++
 3 files changed, 10 insertions(+), 8 deletions(-)

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
index e495f7eaea03..f84ed22518c6 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -367,20 +367,15 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
 	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
 
-	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
-
 	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
-	     le16_to_cpu(uap_rx_pd->rx_pkt_length)) > (u16) skb->len) {
+	     le16_to_cpu(uap_rx_pd->rx_pkt_length)) > (u16)skb->len ||
+	     skb->len - le16_to_cpu(uap_rx_pd->rx_pkt_offset) < sizeof(*rx_pkt_hdr)) {
 		mwifiex_dbg(adapter, ERROR,
 			    "wrong rx packet: len=%d, offset=%d, length=%d\n",
 			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset),
 			    le16_to_cpu(uap_rx_pd->rx_pkt_length));
 		priv->stats.rx_dropped++;
 
-		node = mwifiex_get_sta_entry(priv, ta);
-		if (node)
-			node->stats.tx_failed++;
-
 		dev_kfree_skb_any(skb);
 		return 0;
 	}
@@ -393,6 +388,7 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 		return ret;
 	}
 
+	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
 
 	if (rx_pkt_type != PKT_TYPE_BAR && uap_rx_pd->priority < MAX_NUM_TID) {
 		spin_lock_bh(&priv->sta_list_spinlock);
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

