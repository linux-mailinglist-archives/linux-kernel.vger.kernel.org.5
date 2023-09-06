Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7917939E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbjIFK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbjIFK3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:29:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60F4CF4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:29:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so3042071b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693996186; x=1694600986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+owG17nq22VwtZZibnF77JmIyluppq/Dc52KA5d+8I=;
        b=j32XOsCh0pD3fRx60/Mx/+SODKxTetWFfYDJhFOGhXociHcmd+hF0gwAxcMZGnoLRE
         8BO9ud2BCLN5pDy9G3bhJTbER2K4G101+EExw4M1TiWibp9A9Khe/87s/MkVC96RrT8I
         LInEx8PpQgWYVJSrb1kanpyFIVp43UKWR+H8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693996186; x=1694600986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+owG17nq22VwtZZibnF77JmIyluppq/Dc52KA5d+8I=;
        b=Z8sYth7AHZ1zwfUcS66ZNzlzi07c6dNdsoFdfbOP4vVatGRB4iynYHlgZZor4CPLy/
         CKyFhxITFdWXOYPCY0Jcj9JueZ7TD5oCDG7PSD+DnBLJfbrED6k9ReUJj3tkA1Zrn7BF
         0ly387ox/+Bj3Ta/LfW21fQWJ2fNFfQGOet9/qPEITjWE1kCZyztwjb2FU997+33mOnY
         nG4MjLTVbWhF2NxOL1yo3e7/XomZIakCu5JLFiBR2LWVcsS4uloLEIoHqvvUVGucTh+h
         FbNTYwHcJLB1Unj33xUxpIgMAxTT1wqSxPjI3e0xfPV9zEWLAeBxNqe2xAOhqB4kyH7T
         dgsg==
X-Gm-Message-State: AOJu0YxMyH5wlSVD3ljAXGnRlXGsG5onauzQwmRB4joLheFrS16P/ltM
        ZIBVr5QEULHmlp9R9bHJLR5o7A==
X-Google-Smtp-Source: AGHT+IGxD4+nr/PrDHnNRmR0yvKtaPrz6EN00Tkrjtb4CAgW7P0eDpvJJO7ouRTXhlj9xWfxx5GXVQ==
X-Received: by 2002:a05:6a00:2281:b0:68c:70:d175 with SMTP id f1-20020a056a00228100b0068c0070d175mr19113640pfe.13.1693996186143;
        Wed, 06 Sep 2023 03:29:46 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:56d0:a851:8f06:9964])
        by smtp.gmail.com with ESMTPSA id s18-20020a63af52000000b00528da88275bsm10938511pgo.47.2023.09.06.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:29:45 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     Brian Norris <briannorris@chromium.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Matthew Wang <matthewmwang@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
Date:   Wed,  6 Sep 2023 18:29:12 +0800
Message-ID: <20230906102940.1120269-1-treapking@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/net/wireless/marvell/mwifiex/sta_rx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 65420ad67416..ebb65f3c086c 100644
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
+	if (sizeof(rx_pkt_hdr) + rx_pkt_off <= skb->len &&
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

