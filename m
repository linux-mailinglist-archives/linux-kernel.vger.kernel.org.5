Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D267CDBDF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjJRMgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjJRMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:36:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC35114;
        Wed, 18 Oct 2023 05:36:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083cd39188so4660215e9.2;
        Wed, 18 Oct 2023 05:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632558; x=1698237358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v0ZmldTmEHElH0nzfPoImpxhHxc/jfxnYXGlHkEaSw=;
        b=P/FnAP9ANfmDDxex6pXE8sdpnuIA4RjlogwtL6Ul37mnpF5bcN8VE6D1bXHGPoU/OC
         XPpRFIMlnIOzYWN9j2OU0uqXtjcRwG7gNyQqdIkstfJs2yS77OGXs1gJlPfSwdQ61o24
         JUGwhY8GK9AtKTosNTe5c2gD0y5wTekNzzRLKQjEgsLEd0dKBgRlN0Szp9tyV4IXTqHG
         bdtJwW+YKtP4YeEoA7v5khVhlS12LQG0ELO+kLVXCANJyWW44L8dMHL6uZbM7nLYVLvR
         ZL+kwYh8I84WS9ed2GWAlAZFr782nQrj5p9WlP7rRa99+1Is/0ptvQqyOao4PrQyt0Ne
         PrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632558; x=1698237358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0v0ZmldTmEHElH0nzfPoImpxhHxc/jfxnYXGlHkEaSw=;
        b=Ls/g2JXAAXVTqVAt3lnqRZZMMjtBZ7MXNOq59r+ZUbnaRlsnCF4tsyLqJxQYOo8Gkt
         E5BaZDV4/Iye9ss41ZVqLpwJEBKwoV8JbKqY1oRXn9M9EZRPGjE6E3sDfpxKSAjR/Sbp
         Qab6QlRUcTTxaOASJDygBW6OEanyNqzPMvJ+40s7fM0XZA4LSFBdhhlTwneoyhj4xR8m
         15eramOofmJouBpxd/yyyBJXykAH/2pPvI3X1l/2Ucbc6DCb2AS6MVabUV1Srasot1st
         iP+fQDCNiXF8OE/lOvJNrC9BbCLeR84yvO/iOLfdebbvgS9E5vBlGdKzk5DFUgyF4O47
         QvtQ==
X-Gm-Message-State: AOJu0Yy12u167d84IWg6WHdqe6wX6KbJqb+KqzEuLhG4mdvKaPP4mstq
        /SmkREEnguTtCv5DZBrjoy3qQzEcwrU=
X-Google-Smtp-Source: AGHT+IHYxeHjCIR/FT2JDqNfUwmEd2G8A/49wx/hETYLT6M/03g9TnduO1+10bkcfRpmv5Wp7ErFMw==
X-Received: by 2002:a05:600c:3511:b0:404:72fe:ed5c with SMTP id h17-20020a05600c351100b0040472feed5cmr4380670wmq.29.1697632558280;
        Wed, 18 Oct 2023 05:35:58 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q28-20020adfab1c000000b003248a490e3asm2048211wrc.39.2023.10.18.05.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:35:57 -0700 (PDT)
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
Subject: [net-next PATCH v4 1/4] net: introduce napi_is_scheduled helper
Date:   Wed, 18 Oct 2023 14:35:47 +0200
Message-Id: <20231018123550.27110-2-ansuelsmth@gmail.com>
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
 drivers/net/ethernet/chelsio/cxgb3/sge.c  |  8 --------
 drivers/net/wireless/realtek/rtw89/core.c |  2 +-
 include/linux/netdevice.h                 | 23 +++++++++++++++++++++++
 net/core/dev.c                            |  2 +-
 4 files changed, 25 insertions(+), 10 deletions(-)

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
index cca18d7ea1dd..6faf4dcf007c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1919,7 +1919,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 	struct napi_struct *napi = &rtwdev->napi;
 
 	/* In low power mode, napi isn't scheduled. Receive it to netif. */
-	if (unlikely(!test_bit(NAPI_STATE_SCHED, &napi->state)))
+	if (unlikely(!napi_is_scheduled(napi)))
 		napi = NULL;
 
 	rtw89_core_hw_to_sband_rate(rx_status);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1c7681263d30..b8bf669212cc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -482,6 +482,29 @@ static inline bool napi_prefer_busy_poll(struct napi_struct *n)
 	return test_bit(NAPI_STATE_PREFER_BUSY_POLL, &n->state);
 }
 
+/**
+ * napi_is_scheduled - test if NAPI is scheduled
+ * @n: NAPI context
+ *
+ * This check is "best-effort". With no locking implemented,
+ * a NAPI can be scheduled or terminate right after this check
+ * and produce not precise results.
+ *
+ * NAPI_STATE_SCHED is an internal state, napi_is_scheduled
+ * should not be used normally and napi_schedule should be
+ * used instead.
+ *
+ * Use only if the driver really needs to check if a NAPI
+ * is scheduled for example in the context of delayed timer
+ * that can be skipped if a NAPI is already scheduled.
+ *
+ * Return True if NAPI is scheduled, False otherwise.
+ */
+static inline bool napi_is_scheduled(struct napi_struct *n)
+{
+	return test_bit(NAPI_STATE_SCHED, &n->state);
+}
+
 bool napi_schedule_prep(struct napi_struct *n);
 
 /**
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ca746a5f0ad..8d267fc0b988 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6527,7 +6527,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
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

