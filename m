Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA3380F3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376455AbjLLQz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376582AbjLLQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:55:21 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75045110;
        Tue, 12 Dec 2023 08:55:26 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d9d4193d94so4450925a34.3;
        Tue, 12 Dec 2023 08:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702400126; x=1703004926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUQUAdU8s5rttqBM7PCWLU90rveY3HOOI2yZDd455NM=;
        b=i0Y2c4WKe6eG0lYScakwo2QsJueNnB1KW67leh3d+nh3Jpi/cnMrilbP6qQkpBYGcU
         f4/3DdabnXSGPZ1Fq3zxmg4F6wxNGF8i+S/IcGVYYwZhu/2jN5Zhm5Q9z/4mQMDVq5wn
         ALOjDHzVlvy3bJrWYtPcO+mwwJxT46aUMTejKELwXxwMUByC/89lJrOCkzPAxuYP4ULT
         hWSV1d4axiSDSM9WEo8QpFAwfxdOBvnVxnRppLJSU2PYdBSLX1MLd6Z4vCiV/K2Tt0WW
         x5nJxjN2WYWocR9+ZRDUEBoXkhK/L90Mp8LtL+6VzzAVyqyASUQOgcPthidbmxklxlKd
         8usQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400126; x=1703004926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUQUAdU8s5rttqBM7PCWLU90rveY3HOOI2yZDd455NM=;
        b=cN0KBQyLnH3Uk8wLmgFAqOsWDlegjqevII9UwD0cLT7Te8eNEBLBk4wbgnhdTefI/2
         hUp0LQ+Aodc/mxREUexsKQU+Z1kHXy4CkB+vNczUKaN0y33bN8N1XM+vDeF6Ra9WCqRu
         EFxmwVBR/S1hVp9H8Dwsxu22tgP/DEY1EvYKx2hWlIBQWx/rqt1VQp+XbhIBtYYl6P7T
         lohB5haIHdGaR+CxLf8D5lr2FYsn5HjLCD+nE9BE3DIH36PqwT2IQcQRUgBRvCcwhP/B
         hPDBrRyJdIRZxQtLA+oy3ZXiOW5qUyKSfk26Kd+i+b9IaG2S1dlptmXOdE9dEwrh3woj
         1LLQ==
X-Gm-Message-State: AOJu0Yykz/Zw7mLG6WoD0Ejo/LgcwP72qrIBUzr2w27rF0ytHNKNV0wX
        Ncokx+vkvio6rd0E76EGmr8=
X-Google-Smtp-Source: AGHT+IEygqoSnVmCrbpWnvz3FkfAJ5cZgdkB0GF6zDdFZ9rKyksX2qGzIhBOSSpCSaIJib3YEuQMxg==
X-Received: by 2002:a05:6870:ef0e:b0:1ea:2e2c:e9e7 with SMTP id qq14-20020a056870ef0e00b001ea2e2ce9e7mr7608515oab.59.1702400125615;
        Tue, 12 Dec 2023 08:55:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x5-20020a056830244500b006d9ac5f6606sm2286155otr.11.2023.12.12.08.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:55:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Dec 2023 08:55:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] watchdog: mediatek: mt7988: add wdt support
Message-ID: <c39a109b-a42d-4a86-a580-a3edc7d51e9a@roeck-us.net>
References: <e26a98fd0b7b7b431922405732275bac01eaf220.1699890006.git.daniel@makrotopia.org>
 <fc1c022551edc9ee2dfaa4c1dcf6b146b5b2aae5.1699890006.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1c022551edc9ee2dfaa4c1dcf6b146b5b2aae5.1699890006.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 03:43:47PM +0000, Daniel Golle wrote:
> Add support for watchdog and reset generator unit of the MediaTek
> MT7988 SoC.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: call new toprgu_reset_sw_en_unlocked from toprgu_reset_update while
>     holding lock.
> 
>  drivers/watchdog/mtk_wdt.c | 40 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index b2330b16b497a..5a31a8746e954 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -58,6 +58,8 @@
>  #define WDT_SWSYSRST		0x18U
>  #define WDT_SWSYS_RST_KEY	0x88000000
>  
> +#define WDT_SWSYSRST_EN		0xfc
> +
>  #define DRV_NAME		"mtk-wdt"
>  #define DRV_VERSION		"1.0"
>  
> @@ -71,10 +73,12 @@ struct mtk_wdt_dev {
>  	struct reset_controller_dev rcdev;
>  	bool disable_wdt_extrst;
>  	bool reset_by_toprgu;
> +	bool has_swsysrst_en;
>  };
>  
>  struct mtk_wdt_data {
>  	int toprgu_sw_rst_num;
> +	bool has_swsysrst_en;
>  };
>  
>  static const struct mtk_wdt_data mt2712_data = {
> @@ -89,6 +93,11 @@ static const struct mtk_wdt_data mt7986_data = {
>  	.toprgu_sw_rst_num = MT7986_TOPRGU_SW_RST_NUM,
>  };
>  
> +static const struct mtk_wdt_data mt7988_data = {
> +	.toprgu_sw_rst_num = 24,
> +	.has_swsysrst_en = true,
> +};
> +
>  static const struct mtk_wdt_data mt8183_data = {
>  	.toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
>  };
> @@ -109,6 +118,28 @@ static const struct mtk_wdt_data mt8195_data = {
>  	.toprgu_sw_rst_num = MT8195_TOPRGU_SW_RST_NUM,
>  };
>  
> +/**
> + * toprgu_reset_sw_en_unlocked() - enable/disable software control for reset bit
> + * @mtk_wdt: Pointer to instance of struct mtk_wdt_dev.
> + * @id: Bit number identifying the reset to be enabled or disabled.
> + * @enable: If true, enable software control for that bit, disable otherwise.
> + *
> + * Context: The caller must hold lock of struct mtk_wdt_dev.
> + */
> +static void toprgu_reset_sw_en_unlocked(struct mtk_wdt_dev *data,
> +					unsigned long id, bool enable)
> +{
> +	u32 tmp;
> +
> +	tmp = readl(data->wdt_base + WDT_SWSYSRST_EN);
> +	if (enable)
> +		tmp |= BIT(id);
> +	else
> +		tmp &= ~BIT(id);
> +
> +	writel(tmp, data->wdt_base + WDT_SWSYSRST_EN);
> +}
> +
>  static int toprgu_reset_update(struct reset_controller_dev *rcdev,
>  			       unsigned long id, bool assert)
>  {
> @@ -119,6 +150,9 @@ static int toprgu_reset_update(struct reset_controller_dev *rcdev,
>  
>  	spin_lock_irqsave(&data->lock, flags);
>  
> +	if (assert && data->has_swsysrst_en)
> +		toprgu_reset_sw_en_unlocked(data, id, true);
> +
>  	tmp = readl(data->wdt_base + WDT_SWSYSRST);
>  	if (assert)
>  		tmp |= BIT(id);
> @@ -127,6 +161,9 @@ static int toprgu_reset_update(struct reset_controller_dev *rcdev,
>  	tmp |= WDT_SWSYS_RST_KEY;
>  	writel(tmp, data->wdt_base + WDT_SWSYSRST);
>  
> +	if (!assert && data->has_swsysrst_en)
> +		toprgu_reset_sw_en_unlocked(data, id, false);
> +
>  	spin_unlock_irqrestore(&data->lock, flags);
>  
>  	return 0;
> @@ -406,6 +443,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
>  						       wdt_data->toprgu_sw_rst_num);
>  		if (err)
>  			return err;
> +
> +		mtk_wdt->has_swsysrst_en = wdt_data->has_swsysrst_en;
>  	}
>  
>  	mtk_wdt->disable_wdt_extrst =
> @@ -444,6 +483,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
>  	{ .compatible = "mediatek,mt6589-wdt" },
>  	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
>  	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
> +	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
>  	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
>  	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
>  	{ .compatible = "mediatek,mt8188-wdt", .data = &mt8188_data },
> -- 
> 2.42.1
