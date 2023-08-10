Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FDD77748E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjHJJcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjHJJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519832691
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so103320866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659929; x=1692264729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujYRW768sxUw3nWx+F0Fmk4BkGloyO7j/jd8yaU4H6k=;
        b=oyz/NES/PoxGiBLxT272BOh4/YUvg9BPzVZAggDDIHaexYiMutdzlpQZPd9tYlM7Di
         QPBnVXRmfVV1RXHNigwDBH9aqUiO3oU+SAKmNk/X+AKnM58T0gX6M7rk1bfmk3v0B74O
         1/mXOHn81Ws3VvGOHZ8NEmDjUNu5st4RSXv2826OxUSFO9ufryodkJoJtER9ehiiXdrL
         OQEu/y9KXVLQOb3qrnQrvc8rkIe8Qktr34sK9L6v7oFNGDAELP9u04GDaVaYzMK/WwvQ
         I6BF+25eTSHdUc0rLc0IgD6RNAPz0T/RFvW4n6JLX+MWEnk6BPlFup8MF8GKscCz8wm2
         3u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659929; x=1692264729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujYRW768sxUw3nWx+F0Fmk4BkGloyO7j/jd8yaU4H6k=;
        b=TkCTK8XtyTUaPIci3HjTDsvRprJ5PNiRnJYrekOG6a92If88djnchUFk1wmqfoVmP8
         tDzDKqtNsLFHmfGSJEqLaVSRyP1Q1FKoB8z53AJQRtmx8oVWnPFZClbUI6JPRnP1VT9u
         vz90gt0ZiWfDI7GV1c/kyw10VNe+l19uidqW/az9hAmbBfTVOFXKSFKUUPylnIRizDCX
         VRK5eFeIrogriomHlnM/3KMs/B5ceNR0IpBW9UfrTP3X1bRnY3Jowc3frHA6QM99cwEB
         4FCkf66u8eSRxwBeHo/Ln5RCQKW2SqbbdXW9SXsDSac/Q9XLJIAjx7AZyS3GKfqLr7FJ
         37ew==
X-Gm-Message-State: AOJu0YzQU0wuONww/KHdUwjEtr4LWiVR1BHM8pDj3xtMDHBO1DTLUR5F
        eOmStqRxY6AO90EQFgCFExbhtQ==
X-Google-Smtp-Source: AGHT+IEuckkYeG1+UR9IVmnMB8agEZb1tjh+K12U8mE5NT6o0jcXGi4ze1mthFaaclMtIhXJdETAcw==
X-Received: by 2002:a17:907:7616:b0:994:555a:e49f with SMTP id jx22-20020a170907761600b00994555ae49fmr1560261ejc.31.1691659928913;
        Thu, 10 Aug 2023 02:32:08 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/15] hwmon: (lm75) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:48 +0200
Message-Id: <20230810093157.94244-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
References: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
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

'kind' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  lm75.c:581:10: error: cast to smaller integer type 'enum lm75_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/lm75.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index bcfa8193e5e7..5b2ea05c951e 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -578,7 +578,7 @@ static int lm75_probe(struct i2c_client *client)
 	enum lm75_type kind;
 
 	if (client->dev.of_node)
-		kind = (enum lm75_type)of_device_get_match_data(&client->dev);
+		kind = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		kind = i2c_match_id(lm75_ids, client)->driver_data;
 
-- 
2.34.1

