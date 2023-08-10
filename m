Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE7E777636
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjHJKsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbjHJKsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:48:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F168213B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:48:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so937756a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691664483; x=1692269283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzMSq7HLSHN1HFLKAp83kiHFzC/dRhYUs++4UrDqaOA=;
        b=ClILBq+MRAloWpJfwnTeCf1bHZEDnZelIoj+A/axjmW1s+j+dR7FOxDjEF9I8PXXMG
         Tc/C6Gx1scvwjkKx98djoORst6Cl/ycaIodat9D0KfilMBRvN/MaESoqI9Ak9Z8YOvq8
         Drt7RbTwvMya7Xn2ck8jDeLdI/Z7sUH7nVGyIWw72YyEu8FIwQyDUF2+604OgUg5Qlo8
         KTzw8odQYPl7LwA7/7fNEKKen26+y7OwDK4lXPT/WxmIVFxgAll4Bs74be7u4YK0EZSR
         uDWOkSy5IvuHT6ViBxshwTxcHfylLOROqvd7FmX+lup7xXId0mPOyWI9lt1jUGL3LnMp
         YXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664483; x=1692269283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzMSq7HLSHN1HFLKAp83kiHFzC/dRhYUs++4UrDqaOA=;
        b=QG3jT+P9AdSg9VLPUIfvWXAQntJViDNfnlPxhfKLIYiJj1nRSuUUP46/y0EDLSqv8r
         TDBrEKwD2QqXw2OUELixEhOWARh+JpBvqpUOKTS+eEvClA3jA4KEO1OnxDEFnDuVGFXz
         0J+47MNLoh6i38gztlI3TN+/u75uDJq1t1ziDnQWj9kzFqieqkMGkaZRG4LjACp6jFmy
         8y7q8/Ouq6jP07GoLMvThwF5ITZN7rKvl0RG6ca9EcNObW/PTHaIktRULrkr6+5Dj0oV
         wjcwdj/8fU5wZjwKKWRr+O0Q8W5cLxXIZku7XP15ccT6LzU+aXR2a9iDTS37FfkP83k0
         Ia0g==
X-Gm-Message-State: AOJu0YxPq3iI9khsJzLkA7VUEWU5BYGXnGH+gtOdQ7+HgPZSA6ISkW4O
        GOHhWmmU/xVuW/Y/x31qNs5ClA==
X-Google-Smtp-Source: AGHT+IEm4GcDsfGX7LdWBqE4b5IJZoo0ChzDs3csIlSh1GyolAoj+48i33/6cKTWLD7egpAVJdszfA==
X-Received: by 2002:a50:fa84:0:b0:51e:2305:931 with SMTP id w4-20020a50fa84000000b0051e23050931mr1511310edr.22.1691664483233;
        Thu, 10 Aug 2023 03:48:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7cd94000000b0051dfa2e30b2sm653854edv.9.2023.08.10.03.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:48:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, llvm@lists.linux.dev
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] ASoC: rockchip: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:47:49 +0200
Message-Id: <20230810104749.164827-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
References: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
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

'version' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  rockchip_pdm.c:587:18: error: cast to smaller integer type 'enum rk_pdm_version' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 52f9aae60be8..678989b25e57 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -584,7 +584,7 @@ static int rockchip_pdm_probe(struct platform_device *pdev)
 
 	match = of_match_device(rockchip_pdm_match, &pdev->dev);
 	if (match)
-		pdm->version = (enum rk_pdm_version)match->data;
+		pdm->version = (uintptr_t)match->data;
 
 	if (pdm->version == RK_PDM_RK3308) {
 		pdm->reset = devm_reset_control_get(&pdev->dev, "pdm-m");
-- 
2.34.1

