Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF61E786370
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbjHWWcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbjHWWcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0010F2;
        Wed, 23 Aug 2023 15:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4538A62E8E;
        Wed, 23 Aug 2023 22:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EEAC433C8;
        Wed, 23 Aug 2023 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692829939;
        bh=/JEr4TiHL6f3C8pK8z0KSpApP+0BeWgNlnpN+Skgn7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=of+NJVqTH37IuwzRB3hQZIxEBU6zwQHRnlCyo4vyD670RFKtLzpqWBdOnfwrrI1Jb
         BQejQs9AOsAwUnqd3cGDLhgouANeu61BqiJmS9E0PN893UZ+/pe/gGfRSN7kw8nIHO
         ce7DiCu6Jf0iy3EBBe93u6vdycW0xhnHhWTqawU8UO+4fUwTlUx2CahpI14KewSn7R
         U3UDb6nBBkkWio+YolLAj9ob8MaaCG9oOroDVHflJgA+uSrsBGy/WGC6ZYOxojvw4m
         791gs3XOdI30sDc5bEYu7qvGOiRyoyP7g//LCzjnxuHxL4l5BXeYUlbDICQjLdr7Pn
         CpqYCP6KTra7Q==
Date:   Wed, 23 Aug 2023 16:33:19 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
Message-ID: <587423b0737108effe82aefed4407daca39e9a51.1692829410.git.gustavoars@kernel.org>
References: <cover.1692829410.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692829410.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sanity checks for both `tlv_len` and `tlv_bitmap_len` before
decoding data from `event_buf`.

This prevents any malicious or buggy firmware from overflowing
`event_buf` through large values for `tlv_len` or `tlv_bitmap_len`.

Suggested-by: Dan Williams <dcbw@redhat.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 735aac52bdc4..9ee3b9f1e9ce 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -921,6 +921,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
 	while (tlv_buf_left > sizeof(*tlv_rxba)) {
 		tlv_type = le16_to_cpu(tlv_rxba->header.type);
 		tlv_len  = le16_to_cpu(tlv_rxba->header.len);
+		if (size_add(sizeof(tlv_rxba->header), tlv_len) > tlv_buf_left) {
+			mwifiex_dbg(priv->adapter, WARN,
+				    "TLV size (%ld) overflows event_buf (%d)\n",
+				    size_add(sizeof(tlv_rxba->header), tlv_len),
+				    tlv_buf_left);
+			return;
+		}
+
 		if (tlv_type != TLV_TYPE_RXBA_SYNC) {
 			mwifiex_dbg(priv->adapter, ERROR,
 				    "Wrong TLV id=0x%x\n", tlv_type);
@@ -929,6 +937,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
 
 		tlv_seq_num = le16_to_cpu(tlv_rxba->seq_num);
 		tlv_bitmap_len = le16_to_cpu(tlv_rxba->bitmap_len);
+		if (size_add(sizeof(*tlv_rxba), tlv_bitmap_len) > tlv_buf_left) {
+			mwifiex_dbg(priv->adapter, WARN,
+				    "TLV size (%ld) overflows event_buf (%d)\n",
+				    size_add(sizeof(*tlv_rxba), tlv_bitmap_len),
+				    tlv_buf_left);
+			return;
+		}
+
 		mwifiex_dbg(priv->adapter, INFO,
 			    "%pM tid=%d seq_num=%d bitmap_len=%d\n",
 			    tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
-- 
2.34.1

