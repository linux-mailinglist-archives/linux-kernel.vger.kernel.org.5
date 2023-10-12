Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8B57C6A89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377702AbjJLKIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343772AbjJLKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:08:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF0BA;
        Thu, 12 Oct 2023 03:08:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3215f19a13aso713082f8f.3;
        Thu, 12 Oct 2023 03:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697105319; x=1697710119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+fXPfuQFbOLDaAm3isa5Mto3s8GQTNxK9ZpHoavLmQ=;
        b=Mtoc7Xy5pMSCc5E3Za9+pYhu4jnOSxSUtDQzR6RcFVzBwJRbrv7ZbUX5gwNOfBn4KJ
         QP6dZSF3+j3Vt+gtZnvyVWKkHbr45hw2DxByxbMe+YTttAsc/PfIUI3mj05zYdfZY/JC
         ofu+n+dHqjmBntFRoy5Po5ETyUvd/bDhhfJZy0Ad+KX+NFsUjrhRM0CtAVgEpzaBG82C
         WsSglk+9ZtnE4Pmapj4AgJdIR3+2aO+qvfO0xzogNGWTimP9nA6K9tr05uBcBRfBR9iF
         Y2QpEMoNuTUlaqXS5n36snQ0roQ3+yL39KdnRtMnb6CLglm/chhz8SVYov2MBINPPdw7
         Ua8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105319; x=1697710119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+fXPfuQFbOLDaAm3isa5Mto3s8GQTNxK9ZpHoavLmQ=;
        b=hjDwh4SbpQj0cdTe3K4m+3YB0ap/TuaxFblrEIkHjhHebGa+1rx9MAvowcOv6wrneg
         JpQiBIVOhilJeRmXOtXSBLF1RpFxpirnwDK0Sl2uu0eftb4yoi88IHN3kAnrB3f2NF0L
         QM3t0fSUvjZ7aYWJfjxbpcOoqUNpTZWyNcCEw6IzFNBYCDdXb69PJV0i7N7hctMd+NJC
         8ubSi46d5R1/InsTJdaeyq52FaLoAi6z5pOApt6Jd2miThV4ZqQosRzybS5jGoVzGj+c
         BZLXGEJl3WI4x9TGMkU+FrP36JdYOzpc/CEzHtEKKhoHEIqFzMP1rDP/RqyQZiYR7V6d
         xMmg==
X-Gm-Message-State: AOJu0YwOCW8W7DAf1N9J85TJSyW5vX+fS0Ctl4D+W+z/op6UGVENJII/
        I95bE4n/d9UebJlUFoI7qQ7Rly5QtAY=
X-Google-Smtp-Source: AGHT+IHltHLJC8hhVtlccIc/Xfw4D1hVrWKY3835qupMDM2NnVVGZetkTqBYcRWK9c3pUY4nLHFDAQ==
X-Received: by 2002:a5d:6e85:0:b0:323:10b8:543e with SMTP id k5-20020a5d6e85000000b0032310b8543emr19294869wrz.49.1697105319104;
        Thu, 12 Oct 2023 03:08:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id dj16-20020a0560000b1000b003198a9d758dsm922737wrb.78.2023.10.12.03.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:08:38 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 3/4] net: stmmac: move TX timer arm after DMA enable
Date:   Thu, 12 Oct 2023 12:04:58 +0200
Message-Id: <20231012100459.6158-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231012100459.6158-1-ansuelsmth@gmail.com>
References: <20231012100459.6158-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move TX timer arm call after DMA interrupt is enabled again.

The TX timer arm function changed logic and now is skipped if a napi is
already scheduled. By moving the TX timer arm call after DMA is enabled,
we permit to correctly skip if a DMA interrupt has been fired and a napi
has been scheduled again.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5124ee87286c..b2f63f12aee5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2545,7 +2545,8 @@ static void stmmac_bump_dma_threshold(struct stmmac_priv *priv, u32 chan)
  * @queue: TX queue index
  * Description: it reclaims the transmit resources after transmission completes.
  */
-static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
+static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue
+			   bool *pending_packets)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
@@ -2706,7 +2707,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 
 	/* We still have pending packets, let's call for a new scheduling */
 	if (tx_q->dirty_tx != tx_q->cur_tx)
-		stmmac_tx_timer_arm(priv, queue);
+		*pending_packets = true;
 
 	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
 	txq_stats->tx_packets += tx_packets;
@@ -5572,6 +5573,7 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 		container_of(napi, struct stmmac_channel, tx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
 	struct stmmac_txq_stats *txq_stats;
+	bool pending_packets = false;
 	u32 chan = ch->index;
 	unsigned long flags;
 	int work_done;
@@ -5581,7 +5583,7 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 	txq_stats->napi_poll++;
 	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
-	work_done = stmmac_tx_clean(priv, budget, chan);
+	work_done = stmmac_tx_clean(priv, budget, chan, &pending_packets);
 	work_done = min(work_done, budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
@@ -5592,6 +5594,10 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 		spin_unlock_irqrestore(&ch->lock, flags);
 	}
 
+	/* TX still have packet to handle, check if we need to arm tx timer */
+	if (pending_packets)
+		stmmac_tx_timer_arm(priv, chan);
+
 	return work_done;
 }
 
@@ -5600,6 +5606,7 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 	struct stmmac_channel *ch =
 		container_of(napi, struct stmmac_channel, rxtx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
+	bool tx_pending_packets = false;
 	int rx_done, tx_done, rxtx_done;
 	struct stmmac_rxq_stats *rxq_stats;
 	struct stmmac_txq_stats *txq_stats;
@@ -5616,7 +5623,7 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 	txq_stats->napi_poll++;
 	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
-	tx_done = stmmac_tx_clean(priv, budget, chan);
+	tx_done = stmmac_tx_clean(priv, budget, chan, &tx_pending_packets);
 	tx_done = min(tx_done, budget);
 
 	rx_done = stmmac_rx_zc(priv, budget, chan);
@@ -5641,6 +5648,10 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 		spin_unlock_irqrestore(&ch->lock, flags);
 	}
 
+	/* TX still have packet to handle, check if we need to arm tx timer */
+	if (tx_pending_packets)
+		stmmac_tx_timer_arm(priv, chan);
+
 	return min(rxtx_done, budget - 1);
 }
 
-- 
2.40.1

