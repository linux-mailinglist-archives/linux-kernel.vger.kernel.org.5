Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B887BB9B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjJFNrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjJFNrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:47:03 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C8D10E7
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:46:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50325ce89e9so2817712e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696599989; x=1697204789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gs9kODHBf7pe1hvttMIGP4XQeIHebOI3TikCUwTzhsU=;
        b=Hw1Xj9YD8xe61mktLwaUCSoVaZFQprx2cR9WnnpaU3VFI5HuK8cCfMBuTkdjkCclva
         US3Ug5bxW+Z/ECcWRllOfLgJ+BoAqy3T3UDRuM0zzGfv84+RM6a/fk+JJ6DdrPX7HscN
         QS+mGvd0LIrlK8JBwJ3D3sAsFxSSM2pbxP6xiJ4+fAV4dqZ6naG7bUFnyFB8Psa20EtD
         Es5RipMrx3jMvhDnsTPJLTWpehMDU9JMbOBqQZDzfoiC58hWno2C54fUTO3/zryrxbiF
         oCcjbv5E1Jy+VMqCPO5OedugsZXCyvmgNFykVLZiO6nFi7iBwcNxR3i59ZkLpiTPdyhS
         ptBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696599989; x=1697204789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs9kODHBf7pe1hvttMIGP4XQeIHebOI3TikCUwTzhsU=;
        b=ElbgLf1RwbOxlfeajR1d2WdNmBG5RcVSkzGtN7Pla2v9YmLOyY0e61/boI+O6avxxp
         hGT1hoiSkg7EGMySYDkCvygo+a9nwz1qaf8mCuY2mv7XHE2K7S1QrIT5Uywtywn+AR4L
         uY50NcS7y4eYBuXhJyRrLdQlu5wWMKcBcKskxWg+webvqlDt+VK6N0QJxNFE1XbMPo3l
         qruCudTlVdL+S3evZq8OOZxvDSi/zszd3R26zJaqwQIf9bhhiaCY5VcObLUjEA+3HYFW
         EZNmyKg2VypykgATvt3uXS04oDK9CcMbkNe0hM1IqoreaZB3l0khL4NtUJpgueUKx0JH
         YJlA==
X-Gm-Message-State: AOJu0YxUOQ+bTWPgYiWTaR0wGubZpy7p0rR6evksmgfoU61JDGmVg8kX
        G1rC/06VTGH+OhSp6FGNkFSMtg==
X-Google-Smtp-Source: AGHT+IGilaqLsNAkpUFN8HUXTZkEVfQxXSILLUJqpOsm7o4gtJ9UIFBnw+6Mj0Tl221lqSmXK7G3yQ==
X-Received: by 2002:a05:6512:238a:b0:502:a588:6609 with SMTP id c10-20020a056512238a00b00502a5886609mr9257631lfv.3.1696599989015;
        Fri, 06 Oct 2023 06:46:29 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a197419000000b004fe37199b87sm308733lfe.156.2023.10.06.06.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 06:46:28 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 06 Oct 2023 15:46:25 +0200
Subject: [PATCH 2/8] ASoC: mediatek: mt2701-cs42448: Convert to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-descriptors-asoc-mediatek-v1-2-07fe79f337f5@linaro.org>
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is pretty straight-forward to convert to use GPIO
descriptors, however a separate patch is needed to accept
the DT GPIO resources ending with "-gpio1" and "-gpio2"
instead of the standard "-gpio" or "-gpios" name convention.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/mediatek/mt2701/mt2701-cs42448.c | 54 ++++++++++++------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index 08ef109744c7..81b695a19dc7 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -10,16 +10,15 @@
 #include <linux/module.h>
 #include <sound/soc.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/of_gpio.h>
 
 #include "mt2701-afe-common.h"
 
 struct mt2701_cs42448_private {
 	int i2s1_in_mux;
-	int i2s1_in_mux_gpio_sel_1;
-	int i2s1_in_mux_gpio_sel_2;
+	struct gpio_desc *i2s1_in_mux_sel_1;
+	struct gpio_desc *i2s1_in_mux_sel_2;
 };
 
 static const char * const i2sin_mux_switch_text[] = {
@@ -53,20 +52,20 @@ static int mt2701_cs42448_i2sin1_mux_set(struct snd_kcontrol *kcontrol,
 
 	switch (ucontrol->value.integer.value[0]) {
 	case 0:
-		gpio_set_value(priv->i2s1_in_mux_gpio_sel_1, 0);
-		gpio_set_value(priv->i2s1_in_mux_gpio_sel_2, 0);
+		gpiod_set_value(priv->i2s1_in_mux_sel_1, 0);
+		gpiod_set_value(priv->i2s1_in_mux_sel_2, 0);
 		break;
 	case 1:
-		gpio_set_value(priv->i2s1_in_mux_gpio_sel_1, 1);
-		gpio_set_value(priv->i2s1_in_mux_gpio_sel_2, 0);
+		gpiod_set_value(priv->i2s1_in_mux_sel_1, 1);
+		gpiod_set_value(priv->i2s1_in_mux_sel_2, 0);
 		break;
 	case 2:
-		gpio_set_value(priv->i2s1_in_mux_gpio_sel_1, 0);
-		gpio_set_value(priv->i2s1_in_mux_gpio_sel_2, 1);
+		gpiod_set_value(priv->i2s1_in_mux_sel_1, 0);
+		gpiod_set_value(priv->i2s1_in_mux_sel_2, 1);
 		break;
 	case 3:
-		gpio_set_value(priv->i2s1_in_mux_gpio_sel_1, 1);
-		gpio_set_value(priv->i2s1_in_mux_gpio_sel_2, 1);
+		gpiod_set_value(priv->i2s1_in_mux_sel_1, 1);
+		gpiod_set_value(priv->i2s1_in_mux_sel_2, 1);
 		break;
 	default:
 		dev_warn(card->dev, "%s invalid setting\n", __func__);
@@ -382,27 +381,18 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->i2s1_in_mux_gpio_sel_1 =
-		of_get_named_gpio(dev->of_node, "i2s1-in-sel-gpio1", 0);
-	if (gpio_is_valid(priv->i2s1_in_mux_gpio_sel_1)) {
-		ret = devm_gpio_request(dev, priv->i2s1_in_mux_gpio_sel_1,
-					"i2s1_in_mux_gpio_sel_1");
-		if (ret)
-			dev_warn(&pdev->dev, "%s devm_gpio_request fail %d\n",
-				 __func__, ret);
-		gpio_direction_output(priv->i2s1_in_mux_gpio_sel_1, 0);
-	}
+	priv->i2s1_in_mux_sel_1 = devm_gpiod_get_optional(dev, "i2s1-in-sel-gpio1",
+							  GPIOD_OUT_LOW);
+	if (IS_ERR(priv->i2s1_in_mux_sel_1))
+		return dev_err_probe(dev, PTR_ERR(priv->i2s1_in_mux_sel_1),
+				     "error getting mux 1 selector\n");
+
+	priv->i2s1_in_mux_sel_2 = devm_gpiod_get_optional(dev, "i2s1-in-sel-gpio2",
+							  GPIOD_OUT_LOW);
+	if (IS_ERR(priv->i2s1_in_mux_sel_2))
+		return dev_err_probe(dev, PTR_ERR(priv->i2s1_in_mux_sel_2),
+				     "error getting mux 2 selector\n");
 
-	priv->i2s1_in_mux_gpio_sel_2 =
-		of_get_named_gpio(dev->of_node, "i2s1-in-sel-gpio2", 0);
-	if (gpio_is_valid(priv->i2s1_in_mux_gpio_sel_2)) {
-		ret = devm_gpio_request(dev, priv->i2s1_in_mux_gpio_sel_2,
-					"i2s1_in_mux_gpio_sel_2");
-		if (ret)
-			dev_warn(&pdev->dev, "%s devm_gpio_request fail2 %d\n",
-				 __func__, ret);
-		gpio_direction_output(priv->i2s1_in_mux_gpio_sel_2, 0);
-	}
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);

-- 
2.34.1

