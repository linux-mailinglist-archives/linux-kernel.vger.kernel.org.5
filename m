Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83C0777533
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjHJJ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjHJJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:59:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB4710E9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso6490595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661545; x=1692266345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVuqAG+3F8qvCMUvzd26/3b8nCKRcSvskoI/mhLxS7I=;
        b=ksSOYxOFVkT2qDMyrJ9QBdmS1xXtVYG/DwVFHFNz4VM0u1Y4d4rHdP8UHaH6PtL2mx
         sRpCcc7EbrpG3JOaow28og7kFgiPz0EXJwbZJdjZ/uCjEBE6XmzJjU3+bUBlXga/bm1t
         knQf6Nys2YwNfutTBqx6gCRKJzEtf1YKhgVV87fevigV7p8NiMy+VbWrDIRAKVGtCC/1
         Fc9aYo1ZquPOW+MssbVo2S8L8Wp9gQMiMrdo+lLv6CGMOlIl7gXw4eZh7eJug4kU9ewe
         1edAktLWh1Z47nqDcBw+OwBkRV02ozZ6JKqvie/i91XK11X200801VIS6J2cfGDJdAY6
         MO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661545; x=1692266345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVuqAG+3F8qvCMUvzd26/3b8nCKRcSvskoI/mhLxS7I=;
        b=ZhhZf3aXCzrbqRg3THDGLzqyilPTZsPz1aIs2qsEViTN+6GiS7vASK/WNGXhAenab0
         tXn6wo2e0IS6p2HtyDU4py6aPmkNRT13Nx1gjKZbYg53wx5Bl6OpcI6v0OuuZ1iT8jH4
         yH98+OjoOKZUDvUrQ10uF8oORTIHMaHEKfGz0/HoKu5AenqoAgIlTLA3EpGbzn4pKlKW
         5YkZg9Wp71yXeADB9PPo75MaAGPKaee4/foehtBqgM+LUtuQbLUvtyjsvrHJymWCVfSP
         PX7gZMofGBfkRFuDONOxgQMqNi2Va5slesEo1hv01oUgDeF40UE9Uosi75VnHwKanUIh
         4q0Q==
X-Gm-Message-State: AOJu0YxhqKaZDYZO04iD9VOGXTr+5oYsH/9ou/m+RTNY8q68+vU2wN4C
        z5A4YJ6Wq8vkCmnr0DOK/LXZJg==
X-Google-Smtp-Source: AGHT+IFCtq6WipB2zbEW7I5LY2IMam+QHd5OZBc1WfOVn8AUy9sdNsjd5hNeX11xqSry0HmTCBGtPA==
X-Received: by 2002:a05:600c:2493:b0:3fc:f9c:a3ed with SMTP id 19-20020a05600c249300b003fc0f9ca3edmr1638634wms.22.1691661545133;
        Thu, 10 Aug 2023 02:59:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm1621372wrj.33.2023.08.10.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:59:04 -0700 (PDT)
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
Subject: [PATCH 9/9] mfd: mxs-lradc: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:58:49 +0200
Message-Id: <20230810095849.123321-9-krzysztof.kozlowski@linaro.org>
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

'soc' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  mxs-lradc.c:145:15: error: cast to smaller integer type 'enum mxs_lradc_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/mxs-lradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
index 111d11fd25aa..21f3033d6eb5 100644
--- a/drivers/mfd/mxs-lradc.c
+++ b/drivers/mfd/mxs-lradc.c
@@ -142,7 +142,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	if (!of_id)
 		return -EINVAL;
 
-	lradc->soc = (enum mxs_lradc_id)of_id->data;
+	lradc->soc = (uintptr_t)of_id->data;
 
 	lradc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(lradc->clk)) {
-- 
2.34.1

