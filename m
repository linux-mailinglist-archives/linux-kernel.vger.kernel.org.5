Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B407A7E9686
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 06:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjKMFtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 00:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKMFtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 00:49:39 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4966B10FD;
        Sun, 12 Nov 2023 21:49:35 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 51E22604BD35B;
        Mon, 13 Nov 2023 13:49:32 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     Jes.Sorensen@gmail.com, kvalo@kernel.org
Cc:     Su Hui <suhui@nfschina.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: rtl8xxxu: correct the error value of 'timeout'
Date:   Mon, 13 Nov 2023 13:49:18 +0800
Message-Id: <20231113054917.96894-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'rtl8xxxu_dma_agg_pages <= page_thresh', 'timeout' should equal to
'page_thresh' rather than '4'. Change the code order to fix this problem.

Fixes: 614e389f36a9 ("rtl8xxxu: gen1: Set aggregation timeout (REG_RXDMA_AGG_PG_TH + 1) as well")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 43ee7592bc6e..9cab8b1dc486 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4757,6 +4757,12 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
 	 *   RxAggPageTimeout = 4 or 6 (absolute time 34ms/(2^6))
 	 */
 
+	/* REG_RXDMA_AGG_PG_TH + 1 seems to be the timeout register on
+	 * gen2 chips and rtl8188eu. The rtl8723au seems unhappy if we
+	 * don't set it, so better set both.
+	 */
+	timeout = 4;
+
 	page_thresh = (priv->fops->rx_agg_buf_size / 512);
 	if (rtl8xxxu_dma_agg_pages >= 0) {
 		if (rtl8xxxu_dma_agg_pages <= page_thresh)
@@ -4771,12 +4777,6 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
 				__func__, rtl8xxxu_dma_agg_pages, page_thresh);
 	}
 	rtl8xxxu_write8(priv, REG_RXDMA_AGG_PG_TH, page_thresh);
-	/*
-	 * REG_RXDMA_AGG_PG_TH + 1 seems to be the timeout register on
-	 * gen2 chips and rtl8188eu. The rtl8723au seems unhappy if we
-	 * don't set it, so better set both.
-	 */
-	timeout = 4;
 
 	if (rtl8xxxu_dma_agg_timeout >= 0) {
 		if (rtl8xxxu_dma_agg_timeout <= 127)
-- 
2.30.2

