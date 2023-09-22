Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A665D7AB050
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjIVLNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjIVLNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:13:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ECBAC;
        Fri, 22 Sep 2023 04:13:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32008e339adso1915373f8f.2;
        Fri, 22 Sep 2023 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695381187; x=1695985987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO4PPCAYeBqa8N3X8iNMzO62NO9a8Aa1IWA9xi7rYvw=;
        b=OV0En4bJL0YZ9Vp4bzv/PvNMsEz5F9WxMBaUzyBzhNNpp62+MqMt684g8kW81ZGZKA
         azKi8tcCSX2i4SwMB2rG2Vfr5aimCHUxcLYVv1g8eo9/0dS1srIGE50Iu7t18sxsZXGk
         eW7D6FeelZdrp1MCwLyyBIKO7SSDpwcqqvDam/tNaXopIS8RyGgbpKrLBZTlutBFnFdz
         RIwJEu6eplVVx0PFksuyzXxlLgORiPzzt0t0iStny2PqunUjf22ifKNLotELSgSRO1Ku
         mPMUYw5s36N4gokqZRanW43Af2iPrViAVDRxthkF4doSHTcE9+RKEcEhU+2jjmN5eSFX
         tFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381187; x=1695985987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NO4PPCAYeBqa8N3X8iNMzO62NO9a8Aa1IWA9xi7rYvw=;
        b=aDKKNl0RynPHarW9YblpbdDiMOW/gKWAAlX2Cbzvel7x56+YjQkJ6nZUFX+ykf8x85
         C682hbffyp2c+9coDmVkMLczl2FgZ5ma67ggBnKoGb5vLt5XdA95yYV0wKjLbNRiq/Oq
         37fLrfjalaUarGX8WP0CcVf7i+x0tperMsnVg4QNpxsF95bD33aOUufI31Go9oVV5T1e
         EUhGpwCi2zQg0ePkCe0uIubJjw5Hx2XJ7mrHAiDLWQyTKzSgfAu8BxgIHdI7amdl9nLP
         Ok5RFzklGx5ZiROPDqnXW9P1PdkqfgPZB1tWM0vl/JRrUyeTT5fUsHIdCu+JRcXAiTVv
         HF4w==
X-Gm-Message-State: AOJu0Yye60J+b6zoP+okvSua/ut0hiWV+8PKam4c0SMmlpdBmKONbzYy
        ti8lyb9X7cAi2M+0Eo0Y7qQ=
X-Google-Smtp-Source: AGHT+IGt2zxWyI/cHaEIM9YNy0bqvfBVCcm7j3twnx0VeOiWaEz6/6Yr9n/oPYq1bGBQ0w34CKjfgA==
X-Received: by 2002:adf:fbcf:0:b0:31f:d8b3:e9f5 with SMTP id d15-20020adffbcf000000b0031fd8b3e9f5mr6831681wrs.34.1695381186972;
        Fri, 22 Sep 2023 04:13:06 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g10-20020adffc8a000000b003176c6e87b1sm4191765wrr.81.2023.09.22.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:13:06 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
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
Subject: [net-next PATCH 2/3] net: stmmac: improve TX timer arm logic
Date:   Fri, 22 Sep 2023 13:12:46 +0200
Message-Id: <20230922111247.497-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230922111247.497-1-ansuelsmth@gmail.com>
References: <20230922111247.497-1-ansuelsmth@gmail.com>
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

There is currently a problem with the TX timer getting armed multiple
unnecessary times causing big performance regression on some device that
suffer from heavy handling of hrtimer rearm.

The use of the TX timer is an old implementation that predates the napi
implementation and the interrupt enable/disable handling.

Due to stmmac being a very old code, the TX timer was never evaluated
again with this new implementation and was kept there causing
performance regression. The performance regression started to appear
with kernel version 4.19 with 8fce33317023 ("net: stmmac: Rework coalesce
timer and fix multi-queue races") where the timer was reduced to 1ms
causing it to be armed 40 times more than before.

Decreasing the timer made the problem more present and caused the
regression in the other of 600-700mbps on some device (regression where
this was notice is ipq806x).

The problem is in the fact that handling the hrtimer on some target is
expensive and recent kernel made the timer armed much more times.
A solution that was proposed was reverting the hrtimer change and use
mod_timer but such solution would still hide the real problem in the
current implementation.

To fix the regression, apply some additional logic and skip arming the
timer when not needed.

Arm the timer ONLY if a napi is not already scheduled. Running the timer
is redundant since the same function (stmmac_tx_clean) will run in the
napi TX poll. Also try to cancel any timer if a napi is scheduled to
prevent redundant run of TX call.

With the following new logic the original performance are restored while
keeping using the hrtimer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9201ed778ebc..14bf6fae6662 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2994,13 +2994,25 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	u32 tx_coal_timer = priv->tx_coal_timer[queue];
+	struct stmmac_channel *ch;
+	struct napi_struct *napi;
 
 	if (!tx_coal_timer)
 		return;
 
-	hrtimer_start(&tx_q->txtimer,
-		      STMMAC_COAL_TIMER(tx_coal_timer),
-		      HRTIMER_MODE_REL);
+	ch = &priv->channel[tx_q->queue_index];
+	napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
+
+	/* Arm timer only if napi is not already scheduled.
+	 * Try to cancel any timer if napi is scheduled, timer will be armed
+	 * again in the next scheduled napi.
+	 */
+	if (unlikely(!napi_is_scheduled(napi)))
+		hrtimer_start(&tx_q->txtimer,
+			      STMMAC_COAL_TIMER(tx_coal_timer),
+			      HRTIMER_MODE_REL);
+	else
+		hrtimer_try_to_cancel(&tx_q->txtimer);
 }
 
 /**
-- 
2.40.1

