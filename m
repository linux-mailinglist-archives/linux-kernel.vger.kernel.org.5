Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68D875788B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjGRJy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjGRJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:54:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEE61715;
        Tue, 18 Jul 2023 02:53:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4vMx5rg8z6J6ts;
        Tue, 18 Jul 2023 17:50:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 10:53:23 +0100
Date:   Tue, 18 Jul 2023 10:53:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sean Wang <sean.wang@kernel.org>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 02/10] pinctrl: baytrail: Make use of pm_ptr()
Message-ID: <20230718105322.000074ca@Huawei.com>
In-Reply-To: <20230717172821.62827-3-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
        <20230717172821.62827-3-andriy.shevchenko@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 20:28:13 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Cleaning up the driver to use pm_ptr() and *_PM_OPS() macros that
> make it simpler and allows the compiler to remove those functions
> if built without CONFIG_PM and CONFIG_PM_SLEEP support.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

LGTM but why is it in a set that claims to be about NOIRQ PM helper?

FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pinctrl/intel/pinctrl-baytrail.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
> index 27aef62fc7c0..66aabac6be9c 100644
> --- a/drivers/pinctrl/intel/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
> @@ -1733,7 +1733,6 @@ static int byt_pinctrl_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int byt_gpio_suspend(struct device *dev)
>  {
>  	struct intel_pinctrl *vg = dev_get_drvdata(dev);
> @@ -1817,9 +1816,7 @@ static int byt_gpio_resume(struct device *dev)
>  	raw_spin_unlock_irqrestore(&byt_lock, flags);
>  	return 0;
>  }
> -#endif
>  
> -#ifdef CONFIG_PM
>  static int byt_gpio_runtime_suspend(struct device *dev)
>  {
>  	return 0;
> @@ -1829,19 +1826,17 @@ static int byt_gpio_runtime_resume(struct device *dev)
>  {
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops byt_gpio_pm_ops = {
> -	SET_LATE_SYSTEM_SLEEP_PM_OPS(byt_gpio_suspend, byt_gpio_resume)
> -	SET_RUNTIME_PM_OPS(byt_gpio_runtime_suspend, byt_gpio_runtime_resume,
> -			   NULL)
> +	LATE_SYSTEM_SLEEP_PM_OPS(byt_gpio_suspend, byt_gpio_resume)
> +	RUNTIME_PM_OPS(byt_gpio_runtime_suspend, byt_gpio_runtime_resume, NULL)
>  };
>  
>  static struct platform_driver byt_gpio_driver = {
>  	.probe          = byt_pinctrl_probe,
>  	.driver         = {
>  		.name			= "byt_gpio",
> -		.pm			= &byt_gpio_pm_ops,
> +		.pm			= pm_ptr(&byt_gpio_pm_ops),
>  		.acpi_match_table	= byt_gpio_acpi_match,
>  		.suppress_bind_attrs	= true,
>  	},

