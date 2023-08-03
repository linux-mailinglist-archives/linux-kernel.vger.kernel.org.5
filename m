Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A076F4E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjHCV4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHCVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:55:59 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012333ABA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:55:57 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-56c9237e0ffso227755eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691099757; x=1691704557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2UZl4QpAWyxcUJwZDlhPGc5WDh+5opBLbzbcmNoQ3A=;
        b=WNrHGWvajB9owXhq72vzLzjORCtYxgjEOKy3ToAroBO5cc2iVV/AOa2sGrWr0XC6OS
         F7OgtlIlUStnTLixmFI+RoRlt37gLqLiAAu1I4V/HyJUTRJXABtAv2jMTLzlNyWy8PNr
         YqGIeH8sk75ovTjISR7M3n3QbQV4vsc9WMoP8ov9sl0brrhIqHw2FVNscdzgitba0a7F
         hnfeRmxRL7gs0aA9qbFwvukrXFSyo1vgHimoSTJbPu7v+EZyPmzk0tkHeDLJF45U4ajs
         KFrY+ad2rWJwpsZPKyIm3cV5wzbAa+xL/2ocix9fblYTDcL03n5JJpRpnEHVnbS6k9Bs
         m4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691099757; x=1691704557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2UZl4QpAWyxcUJwZDlhPGc5WDh+5opBLbzbcmNoQ3A=;
        b=iUukKhU7AC+wDZyf+ZeurWHBV4DfMQoZY0vTmY+VLELlV8oCkJeVCMS++fVZVbKS2w
         qxAnRAXc6ibF4h5KRE1+3e3K11epsYz20ziVX94Uwi5Fg4TFafmD/J45TGGu0Z6858Cc
         WH93e91uw6dwZ9rGk5MtfwodD4WPis+4wa1+apjG/QHTdnH1rkCo71KAOuj6XszqwJ9h
         U96A2T3sRZa4fuxK+qGM5jrNYOmpstmf9BjjizAIGCN/00lvvJIUmddtNwTfJQ2x36Xa
         I9p0BAS75vmB9EMvVHJ91/TKO0D6UKBpO3R6WRSPRXAIVvA7WuCwYPFr8Na+Z6eATdw5
         UCbQ==
X-Gm-Message-State: ABy/qLZr09yx4shDlXWGTM65wmVKmrZwSt9pg2nPzl24VvqbxMXzEpLW
        6jZn5GG4VsIJ/oWnCB4gWS4=
X-Google-Smtp-Source: APBJJlFHH3Qb47XCMYL9bftxfoCCIs5KfvjB0KLR6Ld/3K3C0v7ygbIViTI9b9JE7yUcKBTNwq8mUQ==
X-Received: by 2002:a05:6820:2108:b0:56c:5e21:c72d with SMTP id cd8-20020a056820210800b0056c5e21c72dmr14882225oob.1.1691099757208;
        Thu, 03 Aug 2023 14:55:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:48ea:73bf:1876:eaf3])
        by smtp.gmail.com with ESMTPSA id w15-20020a4aa98f000000b005660ed0becesm321978oom.39.2023.08.03.14.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 14:55:56 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] ASoC: wm8960: Add support for the power supplies
Date:   Thu,  3 Aug 2023 18:55:06 -0300
Message-Id: <20230803215506.142922-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803215506.142922-1-festevam@gmail.com>
References: <20230803215506.142922-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

WM8960 has the following power supplies:

- AVDD
- DBVDD
- DCVDD
- SPKVDD1
- SPKVDD1

Add support for them.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Hi,

I haven't tested this. The motivation for this patch is due to a schema
warning on imx8m-evk.dts that says 'SPKVDD1-supply' is not a valid property.

 sound/soc/codecs/wm8960.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index d4bc97088354..0a50180750e8 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -120,6 +120,15 @@ static bool wm8960_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
+#define WM8960_NUM_SUPPLIES 5
+static const char *wm8960_supply_names[WM8960_NUM_SUPPLIES] = {
+	"DCVDD",
+	"DBVDD",
+	"AVDD",
+	"SPKVDD1",
+	"SPKVDD2",
+};
+
 struct wm8960_priv {
 	struct clk *mclk;
 	struct regmap *regmap;
@@ -137,6 +146,7 @@ struct wm8960_priv {
 	bool is_stream_in_use[2];
 	struct wm8960_data pdata;
 	ktime_t dsch_start;
+	struct regulator_bulk_data supplies[WM8960_NUM_SUPPLIES];
 };
 
 #define wm8960_reset(c)	regmap_write(c, WM8960_RESET, 0)
@@ -1417,6 +1427,7 @@ static int wm8960_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8960_data *pdata = dev_get_platdata(&i2c->dev);
 	struct wm8960_priv *wm8960;
+	unsigned int i;
 	int ret;
 	u8 val;
 
@@ -1439,6 +1450,23 @@ static int wm8960_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
+	for (i = 0; i < ARRAY_SIZE(wm8960->supplies); i++)
+		wm8960->supplies[i].supply = wm8960_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8960->supplies),
+				 wm8960->supplies);
+	if (ret <  0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8960->supplies),
+				    wm8960->supplies);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	wm8960->regmap = devm_regmap_init_i2c(i2c, &wm8960_regmap);
 	if (IS_ERR(wm8960->regmap))
 		return PTR_ERR(wm8960->regmap);
@@ -1505,7 +1533,11 @@ static int wm8960_i2c_probe(struct i2c_client *i2c)
 }
 
 static void wm8960_i2c_remove(struct i2c_client *client)
-{}
+{
+	struct wm8960_priv *wm8960 = i2c_get_clientdata(client);
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8960->supplies), wm8960->supplies);
+}
 
 static const struct i2c_device_id wm8960_i2c_id[] = {
 	{ "wm8960", 0 },
-- 
2.34.1

