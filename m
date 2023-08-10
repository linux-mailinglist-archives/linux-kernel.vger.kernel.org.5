Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC6A77760D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjHJKkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbjHJKjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:39:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF29130D1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:39:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bfcf4c814so114245666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691663970; x=1692268770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jIDcfRa5bQrAAvNrBK/T05RZeoNrH4f0IhaNYH0qEk=;
        b=Ou/PXNVkrZ0gFmvLf/CUUPD02qmBpZPBp/7ZPlaVAQfxS6Q3FsRXj2MuT+nO47zIL1
         50sLDZ1tyH1RkS165Fs4Pun4NbBgch0QbnLE6avXrbnAokogg82v5TWHjcIwlWNmPGwm
         rmL9soHCKd2A148Gu9TNbT/RlksINalIISYo6utNySdACHvPq6T5mP/I1d0ruvtvBIms
         wwDRpeV1Ud+RlMTrpgkJqNTTx2bBnWZMjPTpgfqXb2wbhCozqdTpS1NAFE+rBG9J/yn8
         7w5E7+lzTpnRz/YD8dmC3lgukUrkyUYu7G1537rjeX9D+CCAcZFQtnUTC05z+mzEzBvo
         nPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663970; x=1692268770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jIDcfRa5bQrAAvNrBK/T05RZeoNrH4f0IhaNYH0qEk=;
        b=Oqrz40AoG9p1h1+BUb0D8GZWvJQ7jEr2Lg3ZPlyYlrwluwdx2VajR4TZzUmMfZvTH3
         4zMe4PPlQzB6yvEIkNkc03dUK197KxE+Ys6qI9rOL9ge05GqkfWYJYzgzm0GoVrK6Bns
         1IhnGaJi/KQTuiAZxINdUG3aHpHo584ZN50IIxNmc4t09z2MzRQVAnPePwf9SzopU8jR
         pDJiD38piMF7lCuO/uXf5WY5yJVlyw+mKUgzWJev3a/LIpBHXc8YQR13Cd5PSeR80mqR
         wGt3gjNMwWpxrTYzgUHVqKwW9jvCEqMe5tBJ0didoVeDEibyy4R75P4AvEOGl/M3aVG5
         aDaQ==
X-Gm-Message-State: AOJu0Ywmew2NGetOLA4xNKf8kidb8bzF4/QwHyQM2FPH/0m4OgimT8DO
        +dGmKdgF9XLwOQlPoUhYdtHAlw==
X-Google-Smtp-Source: AGHT+IEHvfupsGPUShfWixfcFmXY2PzdYtRDhaH0OKDoUGuOpHMA4CGo8dgjRsbVAoa2w7Kug70V+g==
X-Received: by 2002:a17:906:51db:b0:975:63f4:4b with SMTP id v27-20020a17090651db00b0097563f4004bmr1802753ejk.36.1691663969883;
        Thu, 10 Aug 2023 03:39:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id mc5-20020a170906eb4500b00999bb1e01dfsm749244ejb.52.2023.08.10.03.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:39:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 2/2] net/marvell: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:39:23 +0200
Message-Id: <20230810103923.151226-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
References: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
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

'type' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  mvmdio.c:272:9: error: cast to smaller integer type 'enum orion_mdio_bus_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/marvell/mvmdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index a1a80f13b1e8..674913184ebf 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -269,7 +269,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	struct orion_mdio_dev *dev;
 	int i, ret;
 
-	type = (enum orion_mdio_bus_type)device_get_match_data(&pdev->dev);
+	type = (uintptr_t)device_get_match_data(&pdev->dev);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
-- 
2.34.1

