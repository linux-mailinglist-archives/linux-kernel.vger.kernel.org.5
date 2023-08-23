Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761E578636B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbjHWWbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbjHWWbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CACB1701;
        Wed, 23 Aug 2023 15:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C7562369;
        Wed, 23 Aug 2023 22:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F293C433C8;
        Wed, 23 Aug 2023 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692829867;
        bh=7LddEz2AC5zh2tF8Hq6Rqi34+txun2qg3JRu3gII7P4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASQx5g1LUUoFGyQaaK4qN2QP2Cu3UunhFaR1+PFBMr4h+z4bm7g9ALVBQ8Zi8fuZt
         Y3vCUH9nf/Vi2cLS6q4kF9Y7toF31nSLYdXivLxWPMbfC7bZn/6JEhzqiaRc4uPRVY
         /y/bple93yQDmkE8iHt3w88CzubgT1G1SpU+toRrwy3QRGkHUhFGS63zPiofOVa558
         PtA2cRln0uxTCVMx+qJHUILa3d2d2NBcg5AGMNOTIP/lXhFhy7ZJlub/fOedlYD9xP
         xRS/CINTBH+aK4NSwvXso9XHui7HG6BdSemvpqxp5JY4Gb4vg46Myi4gG04/LGMfzV
         TVJWPYwHESoIw==
Date:   Wed, 23 Aug 2023 16:32:06 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] wifi: mwifiex: Replace one-element array with
 flexible-array member in struct mwifiex_ie_types_rxba_sync
Message-ID: <774ab3c21e1f2ee9c95909e5779216d83d05fd9f.1692829410.git.gustavoars@kernel.org>
References: <cover.1692829410.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692829410.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct mwifiex_ie_types_rxba_sync with
flexible-array member, and refactor the rest of the code, accordingly.

This results in no differences in binary output.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c | 2 +-
 drivers/net/wireless/marvell/mwifiex/fw.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index d1d3632a3ed7..735aac52bdc4 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -918,7 +918,7 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
 
 	mwifiex_dbg_dump(priv->adapter, EVT_D, "RXBA_SYNC event:",
 			 event_buf, len);
-	while (tlv_buf_left >= sizeof(*tlv_rxba)) {
+	while (tlv_buf_left > sizeof(*tlv_rxba)) {
 		tlv_type = le16_to_cpu(tlv_rxba->header.type);
 		tlv_len  = le16_to_cpu(tlv_rxba->header.len);
 		if (tlv_type != TLV_TYPE_RXBA_SYNC) {
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index f2168fac95ed..8e6db904e5b2 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -779,7 +779,7 @@ struct mwifiex_ie_types_rxba_sync {
 	u8 reserved;
 	__le16 seq_num;
 	__le16 bitmap_len;
-	u8 bitmap[1];
+	u8 bitmap[];
 } __packed;
 
 struct chan_band_param_set {
-- 
2.34.1

