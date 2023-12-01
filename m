Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA8800B44
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378860AbjLAMtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378839AbjLAMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:49:34 -0500
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6B410E2;
        Fri,  1 Dec 2023 04:49:39 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 1 Dec
 2023 15:49:35 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 1 Dec 2023
 15:49:34 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     Antoine Tenart <atenart@kernel.org>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] crypto: safexcel - Add error handling for dma_map_sg() calls
Date:   Fri, 1 Dec 2023 04:49:29 -0800
Message-ID: <20231201124929.12448-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro dma_map_sg() may return 0 on error. This patch enables
checks in case of the macro failure and ensures unmapping of
previously mapped buffers with dma_unmap_sg().

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 49186a7d9e46 ("crypto: inside_secure - Avoid dma map if size is zero")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v2: remove extra level of parentheses and
change return error code from -ENOMEM to EIO
per Antoine Tenart's <atenart@kernel.org> suggestion

 drivers/crypto/inside-secure/safexcel_cipher.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index 272c28b5a088..b83818634ae4 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -742,9 +742,9 @@ static int safexcel_send_req(struct crypto_async_request *base, int ring,
 				max(totlen_src, totlen_dst));
 			return -EINVAL;
 		}
-		if (sreq->nr_src > 0)
-			dma_map_sg(priv->dev, src, sreq->nr_src,
-				   DMA_BIDIRECTIONAL);
+		if (sreq->nr_src > 0 &&
+		    !dma_map_sg(priv->dev, src, sreq->nr_src, DMA_BIDIRECTIONAL))
+			return -EIO;
 	} else {
 		if (unlikely(totlen_src && (sreq->nr_src <= 0))) {
 			dev_err(priv->dev, "Source buffer not large enough (need %d bytes)!",
@@ -752,8 +752,9 @@ static int safexcel_send_req(struct crypto_async_request *base, int ring,
 			return -EINVAL;
 		}
 
-		if (sreq->nr_src > 0)
-			dma_map_sg(priv->dev, src, sreq->nr_src, DMA_TO_DEVICE);
+		if (sreq->nr_src > 0 &&
+		    !dma_map_sg(priv->dev, src, sreq->nr_src, DMA_TO_DEVICE))
+			return -EIO;
 
 		if (unlikely(totlen_dst && (sreq->nr_dst <= 0))) {
 			dev_err(priv->dev, "Dest buffer not large enough (need %d bytes)!",
@@ -762,9 +763,11 @@ static int safexcel_send_req(struct crypto_async_request *base, int ring,
 			goto unmap;
 		}
 
-		if (sreq->nr_dst > 0)
-			dma_map_sg(priv->dev, dst, sreq->nr_dst,
-				   DMA_FROM_DEVICE);
+		if (sreq->nr_dst > 0 &&
+		    !dma_map_sg(priv->dev, dst, sreq->nr_dst, DMA_FROM_DEVICE)) {
+			ret = -EIO;
+			goto unmap;
+		}
 	}
 
 	memcpy(ctx->base.ctxr->data, ctx->key, ctx->key_len);
