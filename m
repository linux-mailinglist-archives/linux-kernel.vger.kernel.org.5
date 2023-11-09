Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B877E6625
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjKIJD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbjKIJDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:03:21 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ACA211B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:03:16 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so6898721fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520595; x=1700125395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzJIeWNq2FEaPyhEpEI6+O7cf3g+sTgw9uPY1dLEPEs=;
        b=mYpbZa3vIe9EoNguaotcW/iuSHQ5nJBhgru7WF6umoDpHN8iwGyMUVIzZqeN7eSC3l
         bUROfxyTyv02qOd4rGh8NC+KC69rP6AUrqfKFV3nAS4z7hQulpEAySIvj2YDKQls4mlI
         AojGS0iRcvbzcwYkXhI/m40+2CgdjYHgCcJQBpDpurkLQGVCPZCZc5IdPJg0d+t1y9f0
         RgujTfifKDufDowdBz6SUtKczS1KGL8L7QqF9lfjQH1xFJmd36RoajCR9HwiPFBrc8ue
         NKBDQnl6UlkdtCu2HTrURXahxmyMNTRihtRx+iwZ2j0MGLkytjexc5aCbi/1wx1Okb92
         12Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520595; x=1700125395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzJIeWNq2FEaPyhEpEI6+O7cf3g+sTgw9uPY1dLEPEs=;
        b=R698cSV98WV7GTDHgBpoNiZNgWZf4Jh7JevMPp5EovIToTJ486D2wojmHcSxtwNqSy
         drlCqX2jrRGreNThGDutnbipkhw2WWEC+4h38XMI8sONwNkmyxMlxV9E9nOak7AWg9+s
         lDayVuL5uOdWda/t7tjb4qF1SRmX9pJdzwKDv2GJCMxWdNkcaOaDilW7xgNx7B0UBpLZ
         k5EEiNX+iN7Twj2v/qhFe6XSO6k+KVVtFmnePtrPLtlIvQjB95VVEuZ5eD9BTPbPP6np
         Q7EQH+18gnlHg1fzE2+3PfgpQmYqmj+ihdcLek7gtY4lSpRyIbOfFfha/4OmHS7BYDxA
         +fEQ==
X-Gm-Message-State: AOJu0Yx6Ryn3AYh7arWyrLH1Nyxm/ClZDXmnlnzLeX7nQLxvyGIOXi27
        VB4m3gY0QDpn4fa1otIFrLi4TA==
X-Google-Smtp-Source: AGHT+IH0sjqNLl/veK2UKnVf2/NE7U4+3ND+oxhdQlRbHZbnIHRAFaAKtPKKAo+K3oMuEO5OM9Y+qA==
X-Received: by 2002:a2e:9e53:0:b0:2c5:cac:e9a3 with SMTP id g19-20020a2e9e53000000b002c50cace9a3mr3404465ljk.52.1699520594884;
        Thu, 09 Nov 2023 01:03:14 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h19-20020a05651c159300b002bbacc6c523sm2212383ljq.49.2023.11.09.01.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:03:14 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Nov 2023 10:03:12 +0100
Subject: [PATCH net v4 1/3] net: ethernet: cortina: Fix max RX frame define
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-gemini-largeframe-fix-v4-1-6e611528db08@linaro.org>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
In-Reply-To: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
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
index a8b9d1a3e4d5..5bdd1b252840 100644
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
index 9fdf77d5eb37..99efb1155743 100644
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

