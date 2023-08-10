Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B05777634
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjHJKsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjHJKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:47:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5534410DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:47:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe4762173bso1124260e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691664476; x=1692269276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdCk7OUtlyVla0geNv76Vk4CNU64Mjej9PSyuuwP9Mg=;
        b=zfeXdylhcEBVDrqAny1SLIvN9Crr5v54nzF3ZLf3W/Eif1dNWT9wNlCKgPCQL/o0/E
         iYzjBPH3863DIk4aENP9BsmFOE0Y+EpLU2SlozYtRxJb4GQaDpNAA33nYUQsy3M2dVsT
         OpxZyOWl5CCCLP6aJa0vYV6RmTQxA+wi4TcMmhitHOdEobpn5o5vLFCXEirr7/Qm+DMr
         G5Rpk7tIg24B9EHXKP/uHgwg1ZuSYKfYQmoOFP6aLTRJty/VCoAZStEIc29/gNuUHg5E
         VwUyx6TO9alL/BcefRo7HnARKktyocMZXCzb007Et2yQXMf/XrlEBt21mzzwDFc17QPK
         ar7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664476; x=1692269276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdCk7OUtlyVla0geNv76Vk4CNU64Mjej9PSyuuwP9Mg=;
        b=AnIikysDhjIt3zE2abiexZoqJ6DUAcNZe8c8GNAA35gXANFfPiusSepaWIkpUdciLd
         0B58VbgIF+JkWh+buQ1AGArAAT8KX+Mu378nnT1/jbH6AANwt0lwc+y6/M5ZeWBJjAju
         kqEclR58T1hYuOMnhWDAvUPQ/Ute+BN058SstCCo7/Bb2su+gn2p57BCzaNqrAU1qCP+
         +HcFjPC6sN6BfnvXJigShPgPHglo0oILctqbQyKgwRNaYwZQJXrJdnM4IYapsPCs3le2
         dvmkifJKpp3nNGgQlpeWy1d+0QsZbausJzB6RJ6rDAj4cynDXP29KZS1ERCbQEsaOf4Q
         mEBQ==
X-Gm-Message-State: AOJu0YxWjfymhwsWcDACqsUIyi2c9DgcZhyYGmE/Ie2BWhPDagfyPNAb
        lJK0TePGMZsxW5xEzknXz4EkBg==
X-Google-Smtp-Source: AGHT+IER0Z61HNUztY8QpmTryefpq33DBRiWMkpaT+UcHCgK4QowLfvk76l0MXCWns6xcZPsgfbbnw==
X-Received: by 2002:a05:6512:4013:b0:4fe:c6c:ac95 with SMTP id br19-20020a056512401300b004fe0c6cac95mr1693259lfb.35.1691664476514;
        Thu, 10 Aug 2023 03:47:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7cd94000000b0051dfa2e30b2sm653854edv.9.2023.08.10.03.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:47:56 -0700 (PDT)
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
Subject: [PATCH 2/4] ASoC: codecs: tlv320aic32x4: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:47:45 +0200
Message-Id: <20230810104749.164827-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
References: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
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

  tlv320aic32x4.c:1352:18: error: cast to smaller integer type 'enum aic32x4_type' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index ffe1828a4b7e..6829834a412f 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1349,7 +1349,7 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 		return -ENOMEM;
 
 	aic32x4->dev = dev;
-	aic32x4->type = (enum aic32x4_type)dev_get_drvdata(dev);
+	aic32x4->type = (uintptr_t)dev_get_drvdata(dev);
 
 	dev_set_drvdata(dev, aic32x4);
 
-- 
2.34.1

