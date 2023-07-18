Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9810757863
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjGRJrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGRJrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:47:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE45128;
        Tue, 18 Jul 2023 02:47:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 792D1660704F;
        Tue, 18 Jul 2023 10:47:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689673662;
        bh=xlkvCFSIyUU/M7gkrwgIXP7wr6bqg7L/fte3NfnuGE4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kpNw5uiQpRxgVIR/cZolWOBcgtgrIh5Qjc90he0kMFkFvs1JnWQ4MgAnaw9HgDhan
         J+x56N3uYtgBjZoxA6i5Ljwzng0/OHxWegzoPcveF0qv8BhdHpqkgHPswzycJ8Iu5j
         mT96yOFMrX+tDz7Ezg7vg1tvSr/HmUSjZVHcUdslSvKmr3Pii+2u833Og6T+Wc831J
         VMzRDzaw3bLI2vrqJdkM51ygFoAaf1KxokL046C2rSmYNJlztSwIdnQz9OHvYm9A7s
         OtGccP6zdwc2De1Lh9M1fthZwYbRUsXKsL9+QPj0Cnewr3C3oiYOGpsZAw/cFTzJjP
         F5bEbkHAJiFxw==
Message-ID: <64741cb9-3bcb-ba50-6e09-f30847bda669@collabora.com>
Date:   Tue, 18 Jul 2023 11:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 07/10] pinctrl: mediatek: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-8-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230717172821.62827-8-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/07/23 19:28, Andy Shevchenko ha scritto:
> Since pm.h provides a helper for system no-IRQ PM callbacks,
> switch the driver to use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 5 +----
>   drivers/pinctrl/mediatek/pinctrl-paris.c      | 9 +++------
>   2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 665dec419e7c..2bf5082d3aa9 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -922,10 +922,7 @@ static int mtk_eint_resume(struct device *device)
>   	return mtk_eint_do_resume(pctl->eint);
>   }
>   
> -const struct dev_pm_ops mtk_eint_pm_ops = {
> -	.suspend_noirq = mtk_eint_suspend,
> -	.resume_noirq = mtk_eint_resume,
> -};
> +DEFINE_NOIRQ_DEV_PM_OPS(mtk_eint_pm_ops, mtk_eint_suspend, mtk_eint_resume);
>   
>   static int mtk_pctrl_build_state(struct platform_device *pdev)
>   {
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index 33d6c3fb7908..b1cbd5bafa2e 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -1119,24 +1119,21 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev)
>   }
>   EXPORT_SYMBOL_GPL(mtk_paris_pinctrl_probe);
>   
> -static int mtk_paris_pinctrl_suspend(struct device *device)
> +static int mtk_paris_suspend(struct device *device)
>   {
>   	struct mtk_pinctrl *pctl = dev_get_drvdata(device);
>   
>   	return mtk_eint_do_suspend(pctl->eint);
>   }
>   
> -static int mtk_paris_pinctrl_resume(struct device *device)
> +static int mtk_paris_resume(struct device *device)

What's the reason why you changed the suspend/resume function names?
I don't really mind, but please at least mention that in the commit description.

Thanks,
Angelo

>   {
>   	struct mtk_pinctrl *pctl = dev_get_drvdata(device);
>   
>   	return mtk_eint_do_resume(pctl->eint);
>   }
>   
> -const struct dev_pm_ops mtk_paris_pinctrl_pm_ops = {
> -	.suspend_noirq = mtk_paris_pinctrl_suspend,
> -	.resume_noirq = mtk_paris_pinctrl_resume,
> -};
> +DEFINE_NOIRQ_DEV_PM_OPS(mtk_paris_pinctrl_pm_ops, mtk_paris_suspend, mtk_paris_resume);
>   
>   MODULE_LICENSE("GPL v2");
>   MODULE_DESCRIPTION("MediaTek Pinctrl Common Driver V2 Paris");

