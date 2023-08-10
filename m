Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A3277752D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjHJJ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjHJJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:59:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E1310C7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so3988885e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661542; x=1692266342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zekv1qUTHsXZMS52D/bblKYQ9yuAb3K5khsXk7JIads=;
        b=Hsk6a635P0uAUW2FI8CFKpCkorA724IY5XNrKigMaVTe/XyKck9fs2A+yBzzHij0M0
         1qvAV8izKdrfUxYxu/93N605HJJ2hYYenHqzHQ3SO88mUlm/eJsuLphnT2WcfyRCGr+B
         OcG0uJNM9uVqWzAts3ZaJhhp4nkc0eksQF4tFOlvlot8gdUmd9SxDrfZbTSgN6yVJabE
         QDznRHzUux8migZ8J8W86WYwetjShJ+e0HordOTY9j3Bbo9ijueh498qxo6sVf/R6rKC
         ugpF4xt/BXsFr7Rcq7ITQOCppE5QX6rkKvq7rAC9kJcTFB5YJ8lJf9+OxHknho83FEdB
         la7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661542; x=1692266342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zekv1qUTHsXZMS52D/bblKYQ9yuAb3K5khsXk7JIads=;
        b=ZPHmgax9TAM0qdv8RosC0Yduw8TZ3r/G+mr3IP9fPnZEHGNbw51xIhxpkqty5CcRXk
         JoC5FpFpgAP+KMqWdzL3f0ryybL+cPR3OlgChYExyaQefq5OiTQS58L90UV1ssgtyFtB
         U6/HXgncaVQfeHagX/UkTw3VjA3xpch8txqk8pXNNT/Eo4ApawEvs9AUxWMoqEGhHPeW
         9iaXVSQUt7BzHppTWfXAqogy8ilRY84mnBUECDld/eUGdFQbPH8MTkKB4804Vfo+cfIE
         uwJm6C9EgEZ/m4g8o8l/a/BW12G9u5MAtXgSOHlVJqVBpYZ0AGiRuu01jxXGU24hXoi6
         Otww==
X-Gm-Message-State: AOJu0YxTZItPJdua0JcsbTl8UgoZY8POemNt1kV2iu/ThXKoNzNmSFP1
        wlvHrG2tEXJpJ5NTy+IXXv9KZg==
X-Google-Smtp-Source: AGHT+IGPHL6/KxDf4b9fFexyz/4oHkLvUgzvOtzHyP1978kHH/Xl4TBlrKa+67TCneX1W4cSLYE/mA==
X-Received: by 2002:a05:600c:2909:b0:3fe:1b5e:82 with SMTP id i9-20020a05600c290900b003fe1b5e0082mr1114932wmd.20.1691661541849;
        Thu, 10 Aug 2023 02:59:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm1621372wrj.33.2023.08.10.02.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:59:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 7/9] mfd: wm8994: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:58:47 +0200
Message-Id: <20230810095849.123321-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
References: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  wm8994-core.c:631:19: error: cast to smaller integer type 'enum wm8994_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/wm8994-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 1e4f1694f065..aba7af688175 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -628,7 +628,7 @@ static int wm8994_i2c_probe(struct i2c_client *i2c)
 	if (i2c->dev.of_node) {
 		of_id = of_match_device(wm8994_of_match, &i2c->dev);
 		if (of_id)
-			wm8994->type = (enum wm8994_type)of_id->data;
+			wm8994->type = (uintptr_t)of_id->data;
 	} else {
 		wm8994->type = id->driver_data;
 	}
-- 
2.34.1

