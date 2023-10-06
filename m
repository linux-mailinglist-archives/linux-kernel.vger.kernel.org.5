Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A167BB9A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjJFNrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjJFNrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:47:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6710DF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:46:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-503065c4b25so2863749e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696599988; x=1697204788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcctjBppf75NLO6YkO8Pl2INJRmj2vKxlHT5saQtZoY=;
        b=hRK0p2q2Otfu7EV7elnz3NxGfz9KHGd+rELPh3AuB2i64zooZwg5dFVWa3hA+7u/1T
         zD/80o/Tg3wSuJBWchmNFkXCyYdAey/4Haj5ynazlk2cHsWWF9lbE3o2sby4/ztiT6U4
         1+5aIGjrAGdVCagXzFAvnNT9bqOgeoJZ78QxGqUIt6bLWZLkaye8zA/hfPYvnNLzRmVM
         awIwLG6NwvtKMbq+Iwv1LwoHiyq1TwGdmm7+B3c2WNLBGfO7r0NLh+xFfGZmgE0Hbnw2
         T+yi34V8IJYqybhPn67BZmXRcadOpbUGY/3il2uuKMhyrsbFo5BP6bN9UWeKuXShiXuZ
         D6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696599988; x=1697204788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcctjBppf75NLO6YkO8Pl2INJRmj2vKxlHT5saQtZoY=;
        b=awcxoLqHrPYWNCS1sk6T/p2xzAatkw5h+d21iPpFv7ogSyXC/INHRq8BoU/ka4HROy
         s3SLDCKS+cKWhI2HonRYP3I0R7CdFmKQN5g7UaLcikrVCWu8RPJb7qOYHxFK2iJYo1Ch
         vYePmErkEvszOm/y/RPwWVu98SrspgcpGuvjWPLmKV4hs2+qpidQrRCxakwfdcdf4G5V
         av5lLnfsmLVZdIYU7EHIkROZMBQ8d7WgOY99F+jTvi88m8MmLFn4yoz9miSTvAyGIR/6
         ActZ5+Pk9gVyn/HEzeBwPEOywCctwP8Q5YaZZ3YNliOtpHu3YgL4kFCRQJ9flJEV3wHG
         eT6A==
X-Gm-Message-State: AOJu0YyQG20WOt2GJB1ZjUhC+TU5z/t1ot5ha1lQetUEgblYSB20gLWM
        ej+aMBZXf8xhRSYB7uKj4iiOug==
X-Google-Smtp-Source: AGHT+IGGfV3zI+nczOVhjRr4Mwdj1t6P4p9VuGFvQPwS1+LInpdbM8MctPtTPICaU62NLB0lwNF8YA==
X-Received: by 2002:ac2:5f62:0:b0:4fe:5860:7abf with SMTP id c2-20020ac25f62000000b004fe58607abfmr5744253lfc.13.1696599988003;
        Fri, 06 Oct 2023 06:46:28 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a197419000000b004fe37199b87sm308733lfe.156.2023.10.06.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 06:46:27 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 06 Oct 2023 15:46:24 +0200
Subject: [PATCH 1/8] gpiolib: of: Add quirk for mt2701-cs42448 ASoC sound
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-descriptors-asoc-mediatek-v1-1-07fe79f337f5@linaro.org>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These gpio names are due to old DT bindings not following the
"-gpio"/"-gpios" conventions. Handle it using a quirk so the
driver can just look up the GPIOs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 531faabead0f..d9525d95e818 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -512,6 +512,10 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 #if IS_ENABLED(CONFIG_SND_SOC_CS42L56)
 		{ "reset",	"cirrus,gpio-nreset",	"cirrus,cs42l56" },
 #endif
+#if IS_ENABLED(CONFIG_SND_SOC_MT2701_CS42448)
+		{ "i2s1-in-sel-gpio1",	NULL,	"mediatek,mt2701-cs42448-machine" },
+		{ "i2s1-in-sel-gpio2",	NULL,	"mediatek,mt2701-cs42448-machine" },
+#endif
 #if IS_ENABLED(CONFIG_SND_SOC_TLV320AIC3X)
 		{ "reset",	"gpio-reset",	"ti,tlv320aic3x" },
 		{ "reset",	"gpio-reset",	"ti,tlv320aic33" },

-- 
2.34.1

