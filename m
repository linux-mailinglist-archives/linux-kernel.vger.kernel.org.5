Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8208D7CDBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjJRMgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbjJRMgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:36:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FCEA3;
        Wed, 18 Oct 2023 05:36:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405361bb94eso72759545e9.0;
        Wed, 18 Oct 2023 05:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632561; x=1698237361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQganKp8aZF21H/zUPTyA0gQtuZNoVrMeBEcku+H04Y=;
        b=kDBc++rI5D/Q2SPGoKVhEUpexVBs4FZ0JP/6w/LxVJh4Gqm9iLTHU1/L7TWmUvASfS
         HgQCqU0egYRFX59nBTFK/H9aTAJA+fHQvCuygFwmy5jo/+MVvbBQ2MJ2RfDlc5/p2nZF
         W7rhIo7vvoesHMTXqBO3P1HtgQN/BVxz9jfG77Ob1HmZeV/gxo2mrwJEHHB9nuKp6t37
         kl94IldcHaF0gfTGmKbnhsU+ykzpNQRzW2flhYW0vmOdoS0APbuuaC6cnq4UIyswfRD7
         qTo8r7OrkqVEpG7sLIbikLUL26PWJiFr3cW94LypzMCLheHOjOf47xv4WprOX6T9DmBq
         bDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632561; x=1698237361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQganKp8aZF21H/zUPTyA0gQtuZNoVrMeBEcku+H04Y=;
        b=Ax9y17OVR4wkjREZ/tOreUw9bQa+hJgf6hIsbp+STnKTKTcS/wWjy7Yc7umHRxlCg0
         EOkMJ3CIvlkrBIdcJJW+lyLxFiJ77E4ekIJ3cOGVESINXWLrDmsEeZEaRQglBkjFVx5k
         evjnAkRzRjQSZfQFO7Y7E0gu15xX9cg5YP9dTbwk9LE1NZzhPRFibZTLwkS1sRr4IoSQ
         4sSeMRRlfHQn89kABIV+Xz2sPFedm9I/QYqQNK3PxeA/e4ecqhAeq2p0/D9BGsE5eCx5
         WhA+JKFU6J7v5BCYNQUR16f2Enme92S+zEVA4ERkCcXyzfxV8Xs2hQugKmHoxuJ3bEnp
         +NKA==
X-Gm-Message-State: AOJu0YwEoVD0XKVCkE+kB82hTstfCUxpf6VGt7lDhAoSapXvzJ3FVl09
        K1Dycq9dx6VeSs4bvjQqQBY=
X-Google-Smtp-Source: AGHT+IGWvw4ZG3SuGsV3ihR3L7f4r/gBqme7cwP3cF/b5NR29eZ1jaXh9BTqQTHxCvA+LdtfhtVbtA==
X-Received: by 2002:adf:cf0e:0:b0:32d:a43c:a23d with SMTP id o14-20020adfcf0e000000b0032da43ca23dmr4654866wrj.3.1697632560973;
        Wed, 18 Oct 2023 05:36:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q28-20020adfab1c000000b003248a490e3asm2048211wrc.39.2023.10.18.05.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:36:00 -0700 (PDT)
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
Subject: [net-next PATCH v4 3/4] net: stmmac: move TX timer arm after DMA enable
Date:   Wed, 18 Oct 2023 14:35:49 +0200
Message-Id: <20231018123550.27110-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018123550.27110-1-ansuelsmth@gmail.com>
References: <20231018123550.27110-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5124ee87286c..11055e98efcc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2543,9 +2543,13 @@ static void stmmac_bump_dma_threshold(struct stmmac_priv *priv, u32 chan)
  * @priv: driver private structure
  * @budget: napi budget limiting this functions packet handling
  * @queue: TX queue index
+ * @pending_packets: signal to arm the TX coal timer
  * Description: it reclaims the transmit resources after transmission completes.
+ * If some packets still needs to be handled, due to TX coalesce, set
+ * pending_packets to true to make NAPI arm the TX coal timer.
  */
-static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
+static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
+			   bool *pending_packets)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
@@ -2706,7 +2710,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 
 	/* We still have pending packets, let's call for a new scheduling */
 	if (tx_q->dirty_tx != tx_q->cur_tx)
-		stmmac_tx_timer_arm(priv, queue);
+		*pending_packets = true;
 
 	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
 	txq_stats->tx_packets += tx_packets;
@@ -5572,6 +5576,7 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 		container_of(napi, struct stmmac_channel, tx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
 	struct stmmac_txq_stats *txq_stats;
+	bool pending_packets = false;
 	u32 chan = ch->index;
 	unsigned long flags;
 	int work_done;
@@ -5581,7 +5586,7 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 	txq_stats->napi_poll++;
 	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
-	work_done = stmmac_tx_clean(priv, budget, chan);
+	work_done = stmmac_tx_clean(priv, budget, chan, &pending_packets);
 	work_done = min(work_done, budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
@@ -5592,6 +5597,10 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 		spin_unlock_irqrestore(&ch->lock, flags);
 	}
 
+	/* TX still have packet to handle, check if we need to arm tx timer */
+	if (pending_packets)
+		stmmac_tx_timer_arm(priv, chan);
+
 	return work_done;
 }
 
@@ -5600,6 +5609,7 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 	struct stmmac_channel *ch =
 		container_of(napi, struct stmmac_channel, rxtx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
+	bool tx_pending_packets = false;
 	int rx_done, tx_done, rxtx_done;
 	struct stmmac_rxq_stats *rxq_stats;
 	struct stmmac_txq_stats *txq_stats;
@@ -5616,7 +5626,7 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
 	txq_stats->napi_poll++;
 	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
 
-	tx_done = stmmac_tx_clean(priv, budget, chan);
+	tx_done = stmmac_tx_clean(priv, budget, chan, &tx_pending_packets);
 	tx_done = min(tx_done, budget);
 
 	rx_done = stmmac_rx_zc(priv, budget, chan);
@@ -5641,6 +5651,10 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
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

