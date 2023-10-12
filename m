Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED837C6A83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbjJLKIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbjJLKIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:08:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A4B7;
        Thu, 12 Oct 2023 03:08:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d569e73acso748518f8f.1;
        Thu, 12 Oct 2023 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697105317; x=1697710117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMV6knP2vLu/vHdHEBOSBg5/6andL2RYQDxRoSzD5RA=;
        b=VLVUHkqSDo2GFRaqG6kVdKFtY6jDFiUtYMx4nu7m2L/3L5DqYBMGl9Ak4Bvvbkr5nm
         kuywIODetaUb+VS5VvVtOYVoSeQaFf8Jtig1AjIbk8p6pwedxe3D8VEw8u7/sHkHzZpN
         llQYbGz3HKK8dl1Yv+eDyxH3/L33Fw81eMr4vV4orXMnjn4k8nX0o0BdQQYXbnogK7MO
         AwD3mb5w/n98qqorzXfHnYBgouVHgjROZBAf8boorGprTVBS+vSWJ2t4260opDiRG5Ha
         h3ld6DDERKkX3EFsDLhxj4JEepDZeLSJjnKoLHbOCHnnHeUHlILKRhfTgMNTxwu/hQQ6
         l90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105317; x=1697710117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMV6knP2vLu/vHdHEBOSBg5/6andL2RYQDxRoSzD5RA=;
        b=aXzNYfPEbrkmU+3B+0+f6GQrXj+O3Bphy493qL8S0cm4emHnoyCyKVkfL9m1/vSpHq
         mrJ6h11Gdlxea56V+Dm0hf9ZCLR3nlnLUpPYVGTpKPD8tnpnskRfme7/WaLroKOMYEKS
         A+oB5/GfDMYePgadA7fFenNieZg26US7E5CvnM2e3O+FBw5YmP1zhOcZqgto3K089KER
         ke6OoVQBx8eAK8S1VpfmUlhE1CAXHSsbOxjK544WlbMzwACTPsTLsJO4kSOfIcKGretd
         5+866jAUXypBW5GMjGBar0hCuMgU1Lh2vXHfMGAT4P055qNjFhufVWJavpovHpDo5CVE
         6B4A==
X-Gm-Message-State: AOJu0YwiJwPgsqibep1ippEXvE3Ep+LMsrNt3CB6Yv01y+83tpuYt/yh
        t8yFC68s8j4Ymf5PvcA1kp0=
X-Google-Smtp-Source: AGHT+IFjKjcTaHf2NJ6N29120b+8wBoJ+W6K+tl9kn9/Z768BH9cEbvLUKjARc7MjgjfPGjGv95C4A==
X-Received: by 2002:adf:e8ca:0:b0:324:7a6b:d504 with SMTP id k10-20020adfe8ca000000b003247a6bd504mr23080121wrn.4.1697105316670;
        Thu, 12 Oct 2023 03:08:36 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id dj16-20020a0560000b1000b003198a9d758dsm922737wrb.78.2023.10.12.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:08:36 -0700 (PDT)
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
Subject: [net-next PATCH v2 1/4] net: introduce napi_is_scheduled helper
Date:   Thu, 12 Oct 2023 12:04:56 +0200
Message-Id: <20231012100459.6158-2-ansuelsmth@gmail.com>
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
index ae553f886796..ad75875a854d 100644
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
index 02949a929e7f..c2ec535bc9b4 100644
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

