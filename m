Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C2E7AB043
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjIVLNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjIVLNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:13:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEC0180;
        Fri, 22 Sep 2023 04:13:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31f7638be6eso1890521f8f.3;
        Fri, 22 Sep 2023 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695381186; x=1695985986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo60L/CqsBXTZMp9OSNBO8agQpgsikCTWPBLj8xU0z8=;
        b=iYIerVfY1NbBVwujHou3raRdNzAq/EF0Qk2tI0vUChm7hYMLIcfWAF7yTChKMbt/xu
         tGecAjAF8gDIPCM1bgDJzItbEE5gVYhkVGwH51UOo7HsgntvJKsbNIKwmIuKUIL0vU3S
         dTru+vzXt5DoHzxDZGIjkpPiofTOc+n+W9U3m9XWvb5oFFc3ZW84uskbwnP8RYnEP+/c
         s5mFOyC3Wy7PZguQUg+WRixmBShv0+jQc/F3Oic2ZDnNCq7MfNRCV05OpKg7SnApAA/b
         GQIjcc+Yc0PWThaAiWl5SifhxBBgwhXk2wA/g4xMNCMHOTcZTT9t4EApNcxX40Am0yzW
         olOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381186; x=1695985986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mo60L/CqsBXTZMp9OSNBO8agQpgsikCTWPBLj8xU0z8=;
        b=ntKLU+7hRv+7pCDyEnjlTpVnnJC42DN+6XLjuXJSzGE9r/vGMxn0JEAsPcXhZDkmPW
         h4qdZvql9YyXofpq/AhKfxsedcBObDFeFKVf49jo3XHHweFyXZRDEr68RUFBOUi19dPJ
         91Y2od2rIYEvMzJIrOm5b+QdnQFgKnnmE030dceZK+2ZaPPUfJQoHlIQqLnq/Gx6kmBc
         1fGWGKp5A0lXFU6UhKuausSOI27O919xRNOO+bKjDqz3vK53rYWRaFfmQ6qaeQpmiijI
         JrOZ2brA0rpjjmHPrJrFibRKiRQawKPWsR8AJei1r5oBfXf1bykgE1RLCuIRiIpVM8UW
         OeFw==
X-Gm-Message-State: AOJu0YzleksLRo03lHq3nQN6pm60xD2kmiwpNvTnuVafcPYniqe0T9y/
        GSn+94I1DiSrrQHAbaqEtJw=
X-Google-Smtp-Source: AGHT+IH7mPXmlPp61fOS1UbXVt881rz7wfseEorF4MkXdznkIZPNZgazS5rBLuHv+qOU+uGgsaXdlQ==
X-Received: by 2002:a5d:694d:0:b0:314:12c:4322 with SMTP id r13-20020a5d694d000000b00314012c4322mr7281735wrw.4.1695381185667;
        Fri, 22 Sep 2023 04:13:05 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g10-20020adffc8a000000b003176c6e87b1sm4191765wrr.81.2023.09.22.04.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:13:04 -0700 (PDT)
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
Subject: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
Date:   Fri, 22 Sep 2023 13:12:45 +0200
Message-Id: <20230922111247.497-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

We currently have napi_if_scheduled_mark_missed that can be used to
check if napi is scheduled but that does more thing than simply checking
it and return a bool. Some driver already implement custom function to
check if napi is scheduled.

Drop these custom function and introduce napi_is_scheduled that simply
check if napi is scheduled atomically.

Update any driver and code that implement a similar check and instead
use this new helper.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb3/sge.c  | 8 --------
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 include/linux/netdevice.h                 | 5 +++++
 net/core/dev.c                            | 2 +-
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index 2e9a74fe0970..71fa2dc19034 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -2501,14 +2501,6 @@ static int napi_rx_handler(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-/*
- * Returns true if the device is already scheduled for polling.
- */
-static inline int napi_is_scheduled(struct napi_struct *napi)
-{
-	return test_bit(NAPI_STATE_SCHED, &napi->state);
-}
-
 /**
  *	process_pure_responses - process pure responses from a response queue
  *	@adap: the adapter
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 133bf289bacb..bbf4ea3639d4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1744,7 +1744,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 	struct napi_struct *napi = &rtwdev->napi;
 
 	/* In low power mode, napi isn't scheduled. Receive it to netif. */
-	if (unlikely(!test_bit(NAPI_STATE_SCHED, &napi->state)))
+	if (unlikely(!napi_is_scheduled(napi)))
 		napi = NULL;
 
 	rtw89_core_hw_to_sband_rate(rx_status);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index db3d8429d50d..8eac00cd3b92 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -482,6 +482,11 @@ static inline bool napi_prefer_busy_poll(struct napi_struct *n)
 	return test_bit(NAPI_STATE_PREFER_BUSY_POLL, &n->state);
 }
 
+static inline bool napi_is_scheduled(struct napi_struct *n)
+{
+	return test_bit(NAPI_STATE_SCHED, &n->state);
+}
+
 bool napi_schedule_prep(struct napi_struct *n);
 
 /**
diff --git a/net/core/dev.c b/net/core/dev.c
index cc03a5758d2d..32ba8002f65a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6523,7 +6523,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 	 * accidentally calling ->poll() when NAPI is not scheduled.
 	 */
 	work = 0;
-	if (test_bit(NAPI_STATE_SCHED, &n->state)) {
+	if (napi_is_scheduled(n)) {
 		work = n->poll(n, weight);
 		trace_napi_poll(n, work, weight);
 	}
-- 
2.40.1

