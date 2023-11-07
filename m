Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E137E3843
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjKGJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjKGJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:54:39 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8A124
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:54:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso7231669e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699350875; x=1699955675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9I/5QuNpGxNYQ0Q3gYhof8mVfyBGfSfCNnlFCET9W5g=;
        b=cw8sWqgK1dCbpTCOVilOsRRpFu+XGwe2A+JlBn9gIc5z+A02F1E55dCZmZVaCzjn65
         tP/PZfyiXANxGB/yXYN/GUwV+cGpYsngXlhPEVRaF0BJ+drRu/8aynJKmGkgwOfzN0gF
         XHBmRvVWb0As33NpAdU6czRD7XoVLMV5SQXXrzGc8To8LRdGn9yaWD3BzoimO5/F7S4F
         FsvHHc81LGD2ZS5I7PWbWggkjq7wLDJM+n1JOuMMLQ2P4FPXLqq6z9nUrjnqT3gbp9uT
         AKWCYboEaQhz758ng27QcAYU8Iuv7WdvYvljrh3zybXkxpR2PDSAp/TKuTxl/9ec/OOy
         NBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350875; x=1699955675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I/5QuNpGxNYQ0Q3gYhof8mVfyBGfSfCNnlFCET9W5g=;
        b=UgzzwQSHdekrAHK31MtIdBYJt9twSvS6uGy5xLDzyqPtacTuWsNcLu/Tx84JM09sUn
         0ZSl7S8NK8CGIpv5Zi+7N8AIOdaiHz3Qshy+K5vwCI/aZa7+cIfDE1VWI6SMss2JMNXh
         IhKO5BUQcAPadvJCIUian4/5tAs9kBCAe0tsq9BvwGumy2NJl4arM/CnmGjgE5A6CITC
         cIN93mgghDTIyZYj3HafOB1RDl1C/s9gCfHAg2UhmL9r5hsgrKyiJ+xHnaZZRSDjBVmp
         k6hb0IMnwTf/Pve+WyyJw/j4sda1Lt0sHKksUah5lF9fpZBMJOtZcr5HEuBNDAFHrGJR
         ttww==
X-Gm-Message-State: AOJu0YyaJvYt+AxE/mhX9b3FtWWzAIYpJLZ0AzH9MjvMGvEipR1jujh4
        g1M6HEaypK5qMDJOttmUeddAdw==
X-Google-Smtp-Source: AGHT+IGlT4InGGRd4uD9B/kQKUczRMijoKcGtyPoFdZviLpDAoD/so75+M9LyQ+ioSY6DkDZzqHtaQ==
X-Received: by 2002:a05:6512:358e:b0:505:6cc7:e0f7 with SMTP id m14-20020a056512358e00b005056cc7e0f7mr20581023lfr.44.1699350875084;
        Tue, 07 Nov 2023 01:54:35 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b005091314185asm296356lfp.285.2023.11.07.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:34 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Nov 2023 10:54:27 +0100
Subject: [PATCH net v3 2/4] net: ethernet: cortina: Fix max RX frame define
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-gemini-largeframe-fix-v3-2-e3803c080b75@linaro.org>
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
In-Reply-To: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

