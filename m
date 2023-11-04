Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F67E0F78
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjKDMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjKDMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:43:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F929D61
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:43:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a62d4788so3892609e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101832; x=1699706632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWgOFAkaCrL22TdDDJiVpTuZM0XAGRWs9ieW0NKW7II=;
        b=fzaz3lDGtWmN0cUCFT7Iva7piX0heeiCfuSuxVjUKedBm5fMw95+gqlowm+R+MZyDU
         a17jaZu2Sv6XTm7lV2c+JzMpwpVFhpwK/rpMPPUp8is4Dgl+KS8T7k9xQu90hk6t9oM7
         ++j5sJtL6YfD3+quANzBVwUZsn3LeDz9PAsLEAlKEnoM45GAG5FrQblDkUeXhx6oE2fL
         /X3NxBLBsyWcvYLtlAOaEw8EjoAQA75WNNP82gQsRFdHrEOqV3nglXOq3S6499pGUZOt
         9uz3CKOupefq9pmCS4+H7hf61RpUq6v4x1ibGWjm2R/3NGz/d1i3quuQGJia63CqrF3f
         xbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101832; x=1699706632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWgOFAkaCrL22TdDDJiVpTuZM0XAGRWs9ieW0NKW7II=;
        b=SBRtmOd4Z/xTdwmGgTKnNK1Y360BpaqRDsj5m8YchdxrZ1MVz21n/+0OlntXbpFGMh
         YHOyuuBWUvBwYc+QwYmXE4TFUUnKQufmNjMufSfDvUsDXnOfqzMRSMqIgKhY0eOMAnhg
         PWolcN9l63xW/72Eht7JISICL8WCx2KPWJkBUDNmswXwmTPHl4EzTCNK+3mcXdqA0nKC
         ZTr2H6lG8G7kH2rkem3TS713vqz0Ra5BkAaNwcGh7SDbeKL4/bNh3i0nT3YFvJcqFp3F
         w/szTfnG6X1GXrJE5/7FjqRkOsrk0kk6olO5/dBZrdF6GmYOZikeDUuAD1eNjbEDDkle
         /xqA==
X-Gm-Message-State: AOJu0YySsJXds0j8/BXjwb0ZvjnW25/WIdcWi2r/57wOAIVzPGN5Lv4W
        D7CS6+Oh9e/kGrLa2DW0Sac2mg==
X-Google-Smtp-Source: AGHT+IE/D76DP6LP5S/bC2ZUouN5nx6tvXDeDM1odIxhJnsb2wJCBGqDcoLyl8FiiBhU1HViFRqPDQ==
X-Received: by 2002:a05:6512:3196:b0:4fa:f96c:745f with SMTP id i22-20020a056512319600b004faf96c745fmr23906142lfe.38.1699101831782;
        Sat, 04 Nov 2023 05:43:51 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b005093312f66fsm496100lfq.124.2023.11.04.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 04 Nov 2023 13:43:49 +0100
Subject: [PATCH net 2/4] net: ethernet: cortina: Fix max RX frame define
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231104-gemini-largeframe-fix-v1-2-9c5513f22f33@linaro.org>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
In-Reply-To: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 4 ++--
 drivers/net/ethernet/cortina/gemini.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index e12d14359133..fd08f098850b 100644
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
index d7101bfcb4a0..e4b9049b6400 100644
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

