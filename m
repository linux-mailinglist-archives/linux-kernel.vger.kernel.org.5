Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A07C6A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377960AbjJLKI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343761AbjJLKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:08:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D1FC0;
        Thu, 12 Oct 2023 03:08:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32799639a2aso735245f8f.3;
        Thu, 12 Oct 2023 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697105318; x=1697710118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIsjeim7XUbQUze6bD56uxG9gvOx0giE5m3S+sNf+CI=;
        b=BfKiZmA6TRT0AP4pLZJkyftO9FGwmQTmAomyLY8xRbbgK0oAYxXsOWnGKfM0VEJUNF
         q9H+5uiXHa/IzhufKhLXe4pss8XrEc3aJwxRTWvshrltfrwVWgFv7wXCuAOtPOOOn4I2
         yxAueSKDzkKd6L9IDQ/uPDMNN4UIsmRBxoHTSxbB5pfWKJAvMF83O3iXgdjevjGzzpCr
         km0CygpFgVLLUQB0HmfziKMTEghFdnIKLNpdPnSDyEZCNlTwCIxxSxsHATDKX3XYzCls
         E38gJY9oSE0qYdz/Fs+uHYEW3yuxwrXzPJJPm56JE49+NbUtJGglmCgFhocSOZG6jiLT
         QhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105318; x=1697710118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIsjeim7XUbQUze6bD56uxG9gvOx0giE5m3S+sNf+CI=;
        b=ltLRwMPvPG5cwl+Q463Y5sE6oA03rVaQyRGSMjkpxPIVgKPg5si/M2gYPGCsHi3wQw
         RJLr29XbCUEVxRnB6e0bm0QWDVZpydZDH0kcItA1/UsPV2fDcs86XSmPXxECaAxrm0ss
         Y90FfI0JHIjKG3WV1c1pKfWwKwX/csZHJoQdAqdkJ6phpHLsAcd0uDXUEOauxMwVs35c
         j1rPLrdKmjdQl0umQ9z7gfyE6ROmey/kvOWorRNdtlcq2j2c2Fw0e3FTUfnwuzr/wpe5
         DDC3S9SbHjDpTqh+9ZXamsaRne+seOtBLR6Tyhfxx4kJEFbriiOoun8KtflDhGDaTTo+
         PvFg==
X-Gm-Message-State: AOJu0Yygg5DDt7qH5T53rDBjHcGScm3oq9Wr1g2dw4+iquhoXzqoRq/k
        LD3iP/tuzo2Rx2VGfHL/PZA=
X-Google-Smtp-Source: AGHT+IHpdKVnN91CglYdASUt5zwHQXrdDBnHHb+85IX/ZvGINItZUurXQ7kVAD8loaEYbKmTZ81veA==
X-Received: by 2002:a05:6000:4e1:b0:31f:ea18:6f6b with SMTP id cr1-20020a05600004e100b0031fea186f6bmr20124897wrb.19.1697105317932;
        Thu, 12 Oct 2023 03:08:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id dj16-20020a0560000b1000b003198a9d758dsm922737wrb.78.2023.10.12.03.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:08:37 -0700 (PDT)
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
Subject: [net-next PATCH v2 2/4] net: stmmac: improve TX timer arm logic
Date:   Thu, 12 Oct 2023 12:04:57 +0200
Message-Id: <20231012100459.6158-3-ansuelsmth@gmail.com>
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
index bb1dbf4c9f6c..5124ee87286c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2996,13 +2996,25 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
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

