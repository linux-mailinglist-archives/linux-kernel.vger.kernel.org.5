Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001F4798607
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjIHKnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIHKnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:43:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FAE1BC6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:43:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf1935f6c2so13408375ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694169794; x=1694774594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQQCzIcQzKZ8gCy9/YOy22vWaOQGGG4cGUxmxyznMXg=;
        b=JbjvLvSp2NaMyRfITtj2eVN2gl4MFeF5cXMu6v0Uh3ibn8EpvfvrfxjUSsw6rt2xdh
         bCEKi0Zlz64VuLjKrE8Y29JaOtpuwl+PxAQcSM9Y7oi4LrUdvsYQcSajB4/fdHoa0MuX
         zYmIKe52+3XhIqmWkSAqmfkS9kjK3aCqKdZoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694169794; x=1694774594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQQCzIcQzKZ8gCy9/YOy22vWaOQGGG4cGUxmxyznMXg=;
        b=d1SvIsHSbbqqUFCG9ztrVKCaGNYWmVT/VuvqQMxoJtM1HPjIyVyAXr1V3mZcMGzqyF
         wlfaILRfaYn4lO4xAYCnlV7D8F8VDxnzazZV7uUDpbiRE1LTypFmQeAPUiCbXoxP8+Xg
         5gK5vRUCphTNDBjlgzzVjwfc5rIOTG4Xval9NHEPqz16HsAGdi+w62kB5LdjQgMRi31w
         j7SZ0I8ElCDmGhCEYKf3/fah8UMUCJYnEuU5EQHSmlqUm0I6GEUUfVtZ9gJzAUZFhZxz
         3/lOifMaEpe3oBrN/DvVLoo1TnUp5RL3V7qLHbOYNr4FOF7hBJXmr3YOeSO55gStp0pV
         Skkg==
X-Gm-Message-State: AOJu0YxS7+fIZGF9OnQ52mTB+bzvmvSkqiyT9mum5akqMwnlrMa7iIT+
        PUjpRBB5Ovt2/5xukChslIq5I1+6F0UOjlCkQy8=
X-Google-Smtp-Source: AGHT+IF17AK2gxbzIfElg2MZPbCBDsW6PFsJLXynEYAQ05RCuZ4czR6tNqV7ulot8/XI2h6pYXJuPQ==
X-Received: by 2002:a17:902:c942:b0:1c1:d5d1:a364 with SMTP id i2-20020a170902c94200b001c1d5d1a364mr2372755pla.33.1694169794463;
        Fri, 08 Sep 2023 03:43:14 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:cfe5:1210:6170:87ad])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902ec9200b001bbd1562e75sm1287154plg.55.2023.09.08.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:43:14 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Matthew Wang <matthewmwang@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
Date:   Fri,  8 Sep 2023 18:41:12 +0800
Message-ID: <20230908104308.1546501-1-treapking@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only skip the code path trying to access the rfc1042 headers when the
buffer is too small, so the driver can still process packets without
rfc1042 headers.

Fixes: 119585281617 ("wifi: mwifiex: Fix OOB and integer underflow when rx packets")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v3:
- Really apply the sizeof call fix as it was missed in the previous patch

Changes in v2:
- Fix sizeof call (sizeof(rx_pkt_hdr) --> sizeof(*rx_pkt_hdr))

 drivers/net/wireless/marvell/mwifiex/sta_rx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 65420ad67416..257737137cd7 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -86,7 +86,8 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_len = le16_to_cpu(local_rx_pd->rx_pkt_length);
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
 
-	if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
+	if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
+	    rx_pkt_off > skb->len) {
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "wrong rx packet offset: len=%d, rx_pkt_off=%d\n",
 			    skb->len, rx_pkt_off);
@@ -95,12 +96,13 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 		return -1;
 	}
 
-	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
-		     sizeof(bridge_tunnel_header))) ||
-	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
-		     sizeof(rfc1042_header)) &&
-	     ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
-	     ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX)) {
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off <= skb->len &&
+	    ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		      sizeof(bridge_tunnel_header))) ||
+	     (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		      sizeof(rfc1042_header)) &&
+	      ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
+	      ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX))) {
 		/*
 		 *  Replace the 803 header and rfc1042 header (llc/snap) with an
 		 *    EthernetII header, keep the src/dst and snap_type
-- 
2.42.0.283.g2d96d420d3-goog

