Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1387E16AC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjKEU5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjKEU5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:57:34 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A20EB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 12:57:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507be298d2aso4890364e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 12:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699217849; x=1699822649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9I/5QuNpGxNYQ0Q3gYhof8mVfyBGfSfCNnlFCET9W5g=;
        b=R1+nq3Qjdg2hCgC72Qjgy15PG/WFVs4o/VMBOjsxYk/M5itwqwYMIMVRnAd22QxoGD
         AjpsN4tVjWcRUdYrcNYQQ0zNSdTcyMdJoQ4HZ3h3keqmXIYrrzqCg54mdJhenrqehrhv
         VxqWWydDyDIQCe3iJcd7g5bJCbx6u6iSepetRD3QRrlNm80ZwKK6GI/7eGlQRRFECiJ0
         YWt6h003w9Mtc1bNPOkVx5spZ19e7RIjJj6j768FoelffoHexMhASRHvnADFC+Ak+n6H
         BXh2YrgeISmaZPy8cvgJ3WPiCB2vUwStvwtIxKkznJKdlQvOsL1gfGjIv7ZHRZ6UvYla
         KhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699217849; x=1699822649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I/5QuNpGxNYQ0Q3gYhof8mVfyBGfSfCNnlFCET9W5g=;
        b=Ley4czkyo8ptSV/ttrbZb5G6fGvTEuGzkQNLTg/jVPJoee2XHpiplbEMmiNjeBN2Yb
         hSa0hxbdi2tBYHRzD1CMZQjMUxjO6r5fpkJaxo5WQXxRtzRsYe+XA8KkQz6wXUS966ft
         6FiJEWpI6tRqw1uNWocRmVVYahtU0KJVS/TZpPC0d6UpTnG2NLZio+7jx+vqo36eWGHx
         Ku6FHEgpA7JQgyF9qoO3IOVR+bJkk2J95XHuawohNfckF3bQG6T+vLgvbswFzwCUaDpq
         i9nCGXIb+JXnbqMxmFZz1W21QO4EJ6Bx9+PnUj53rXykZEfeWEgV08jd/16ixqm2eMYZ
         IeaA==
X-Gm-Message-State: AOJu0YxrGsr1ztNp14yV40Pa4WbbF1B8TZrNhJoIawjyNGgYzXlbFRXu
        rbZMGJuU1uUWs/Jo/7haZ2tWzA==
X-Google-Smtp-Source: AGHT+IHEu2ba+AMGz02oEBnNqKcgRmT3tE+uIa+goUWOOC86KvEtoEC6fxxX+YOpDBoyi6G/5ZvToQ==
X-Received: by 2002:ac2:5398:0:b0:507:9f69:e8d9 with SMTP id g24-20020ac25398000000b005079f69e8d9mr19751912lfh.49.1699217849468;
        Sun, 05 Nov 2023 12:57:29 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d12-20020ac24c8c000000b00507c72697d0sm931873lfl.303.2023.11.05.12.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 12:57:28 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 05 Nov 2023 21:57:24 +0100
Subject: [PATCH net v2 2/4] net: ethernet: cortina: Fix max RX frame define
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231105-gemini-largeframe-fix-v2-2-cd3a5aa6c496@linaro.org>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
In-Reply-To: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enumerator 3 is 1548 bytes according to the datasheet.
Not 1542.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 4 ++--
 drivers/net/ethernet/cortina/gemini.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index ed9701f8ad9a..b21a94b4ab5c 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -432,8 +432,8 @@ static const struct gmac_max_framelen gmac_maxlens[] = {
 		.val = CONFIG0_MAXLEN_1536,
 	},
 	{
-		.max_l3_len = 1542,
-		.val = CONFIG0_MAXLEN_1542,
+		.max_l3_len = 1548,
+		.val = CONFIG0_MAXLEN_1548,
 	},
 	{
 		.max_l3_len = 9212,
diff --git a/drivers/net/ethernet/cortina/gemini.h b/drivers/net/ethernet/cortina/gemini.h
index 201b4efe2937..24bb989981f2 100644
--- a/drivers/net/ethernet/cortina/gemini.h
+++ b/drivers/net/ethernet/cortina/gemini.h
@@ -787,7 +787,7 @@ union gmac_config0 {
 #define  CONFIG0_MAXLEN_1536	0
 #define  CONFIG0_MAXLEN_1518	1
 #define  CONFIG0_MAXLEN_1522	2
-#define  CONFIG0_MAXLEN_1542	3
+#define  CONFIG0_MAXLEN_1548	3
 #define  CONFIG0_MAXLEN_9k	4	/* 9212 */
 #define  CONFIG0_MAXLEN_10k	5	/* 10236 */
 #define  CONFIG0_MAXLEN_1518__6	6

-- 
2.34.1

