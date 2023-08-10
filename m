Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F835777524
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjHJJ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjHJJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:58:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88355DF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317c1845a07so676300f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661534; x=1692266334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+nzMX9FF8kMvDilSoJvEkDnwU2aF0sCzfp1fOHFLkw=;
        b=J/QzEdrotJeq6mkMZKmknV6NSGn1i48xgkQlExfqCknCcWTmLMs+dKECTzaDTq2EZ2
         OX9b58tvVjvvwoKEvSIfaVB0EDLFq8r0/LG956ROPx7m54ErELhjciAQ1tutZYTsbcLD
         tydeQgAnpCdXuBEFaGOS3hbuJdqwiksqMwqmtsPprrnsShUx3mX5eYrlwP8kgk8s9q57
         0j7035BtnLYfAHRMkWtvJfauDV5Bb5jmMHQIhLQRByiZLUkGWC0F0GRgv7u8mehxz9W9
         hhcImeg0tnEL6b6XTqcjtEsdymhyR+MTmp2Xnvkw8GLCiA9w/wZjnSXw1B3etrYs70ZY
         k8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661534; x=1692266334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+nzMX9FF8kMvDilSoJvEkDnwU2aF0sCzfp1fOHFLkw=;
        b=FxsLdLgnCbMzOZxvAdiIaJtVSwjDO8M2qkafPjbNQ0432iyUCpwGrM2nMjhD2khuOh
         uUZsKq83LAuolUkVAxebUaI8RlD7o6srrQqG8XwSRdYvMe78Q12PLuEKxo4sIK9I4IN/
         EjCx6SQ0z/QfTdPecsD/w21hr9wkuYi1dN9HZNTxBuj5gGCKdNVBPnHZwizOWyMw8etq
         vKAQoEGT/Qk1By2V6R2MEoDLm+K/fx2VVfzwdk7+vRlCMNtk5F/iejHSh+Vc/o6FV7wP
         TyzJld+T0a7cNG4jmeZKRvRd+t/g/GmwqjaJ3D1pqbm8VKKD28v3MB55JiuWJ5vQ2UH/
         pZGg==
X-Gm-Message-State: AOJu0YzP9U0Wq4Fx8B4K4xajDKt11EcaQIctzktwJjfTVAo6klS5MDHj
        jC3JMQv17dbfo1s75/aJiTYlVQ==
X-Google-Smtp-Source: AGHT+IGOY/Wa6bcolP74qFMq1OnVMSVcWZhnbgWCe3a3KtgXEdLX4dfd1HffY7h7uIWP0SudxOc1Kg==
X-Received: by 2002:a5d:4683:0:b0:317:39e3:7c68 with SMTP id u3-20020a5d4683000000b0031739e37c68mr1555463wrq.18.1691661534148;
        Thu, 10 Aug 2023 02:58:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm1621372wrj.33.2023.08.10.02.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:58:53 -0700 (PDT)
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
Subject: [PATCH 2/9] mfd: max14577: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:58:42 +0200
Message-Id: <20230810095849.123321-2-krzysztof.kozlowski@linaro.org>
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

'dev_type' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  max14577.c:406:5: error: cast to smaller integer type 'enum maxim_device_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/max14577.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 25ed8846b7fb..1f4f5002595c 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -402,8 +402,7 @@ static int max14577_i2c_probe(struct i2c_client *i2c)
 
 		of_id = of_match_device(max14577_dt_match, &i2c->dev);
 		if (of_id)
-			max14577->dev_type =
-				(enum maxim_device_type)of_id->data;
+			max14577->dev_type = (uintptr_t)of_id->data;
 	} else {
 		max14577->dev_type = id->driver_data;
 	}
-- 
2.34.1

