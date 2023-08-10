Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63B7777609
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjHJKjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjHJKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:39:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC2E6B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:39:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5230df1ce4fso926157a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691663950; x=1692268750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVkz966lVYyCDepVDZixPFVRMmINlccfjfN4fA3av38=;
        b=rcBWBchpudmlABde9Rt0jgbwvZt3JLlNKnutj7SpHxmJb+2+blf8UeEmRvnoxluzW5
         1gv0+uFgkYSX35giBFSt9niVpWRGpyGZdkai1ta1th3BOkF5gQ2GIZUaH/mYg0SR0snU
         x1pZ8KoqOKd0D7HN+ijqszlHiiJGiiY6XQp2NGiWnjhaPXa4JTYLbJT2A3VIKGXCOQlm
         sf6425ASRzlmlV/URjhquYM3Y3zDd1PxHBCfewhZH/6j5iTH18r2hSMG2FxDCIWTPXXM
         IrlIBhztFlBkJMejHnraCLp2zpGL9fYMyf/knI35LDBH/LvzEvfPG4ehkKekvAex96AF
         /Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663950; x=1692268750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVkz966lVYyCDepVDZixPFVRMmINlccfjfN4fA3av38=;
        b=lzLp5PkXMpN9w2Pgzwffig4RrJ7y9u0TzXG6XgEfTf+XPuiM96RtN6AiqLkOaEGxIs
         6lo4qj9spYC4BAq0fBCiGtW0LT6prx5rFYLNacmO1UNj0zfxz5ugq9KYHCg2Fr1COiih
         I8UIJUoCdciJ624EE2n9/CdCpAeIPrLYV6QC6HMrVEbs4vYAF8EMKYwHfiWKKyiG6v60
         ZMyxg+lqGUD+hfGRJ0ptPVIZwI6lrQbmJC4WyNcCDxTK+TciYuHsUFBdLSn/W6/Mbp6l
         Zw0+xqmiiwrJnK9dN/HNt8RRrh1VhttrVsbxBLRzvj5Bbdh34/kjvcSuq7d/GDBdvXcL
         DQJA==
X-Gm-Message-State: AOJu0YxocJDR2bgjCcCStCwSC1rOJQ7ZpwBC0zWcIinI1GS07cfiXEeB
        Rq9a095lAqVsudqDWPux15bnGsSqu6FKz0JlV8Fvlw==
X-Google-Smtp-Source: AGHT+IEjQzcGZgIz+Rb4K1zibn9OcjCTVtMdKc90JKBBfHAV2Gn4v8OlNYGNSmZP7MYiUBNsXJF8oA==
X-Received: by 2002:a05:6402:6c9:b0:51e:3558:5eb6 with SMTP id n9-20020a05640206c900b0051e35585eb6mr1856385edy.3.1691663949849;
        Thu, 10 Aug 2023 03:39:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906868b00b0099bca8b9a31sm742180ejx.100.2023.08.10.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:39:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] rtc: rs5c372: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:39:02 +0200
Message-Id: <20230810103902.151145-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103902.151145-1-krzysztof.kozlowski@linaro.org>
References: <20230810103902.151145-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  rtc-rs5c372.c:829:19: error: cast to smaller integer type 'enum rtc_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-rs5c372.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index a5a6c8772ecd..6df3d25345ac 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -826,8 +826,7 @@ static int rs5c372_probe(struct i2c_client *client)
 	rs5c372->client = client;
 	i2c_set_clientdata(client, rs5c372);
 	if (client->dev.of_node) {
-		rs5c372->type = (enum rtc_type)
-			of_device_get_match_data(&client->dev);
+		rs5c372->type = (uintptr_t)of_device_get_match_data(&client->dev);
 	} else {
 		const struct i2c_device_id *id = i2c_match_id(rs5c372_id, client);
 		rs5c372->type = id->driver_data;
-- 
2.34.1

