Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBF97D81F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344835AbjJZLpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJZLpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:45:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A144B1AD;
        Thu, 26 Oct 2023 04:45:05 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5328566072F9;
        Thu, 26 Oct 2023 12:45:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698320703;
        bh=5RoWXkPv8UrV5cMyCQWqrIIGsEZRri7N1//OlH5MbZQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YPDDXhKeYw2cV8KqViXmYh0quv3bmsMbiuq+he0zLeLNLO+p8nsr0BQdSJu4oIT/o
         spx974GAd0EZYgge2VQHU3sTi4TQ2+TPwEhADqbAOZa2G4utG0XzGzoZFRNkhs9ql9
         5eqKds2E3zdj5ZBjkWTvxhISNn6ffURVFBNFOQ4n/QPrrdQ5t4fUxfILTKqZnWpb6p
         X9AoM23YCWRF4thzv94mql54eYpENzI5VjJazB28KHwkFmQSHRdcAK9F4p/FUvHoDb
         lW6KvG+oW6uv9BIGcUb8WIe3pcJQRDR2A9uKea8afEd9hLCIfSSfSsRFQaL6bt2/8G
         21OkrFgT9ipTQ==
Message-ID: <a7321404-0c8f-430c-b14c-7ffc9e4fc5d7@collabora.com>
Date:   Thu, 26 Oct 2023 13:45:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt8188: probe vpp with
 mtk_clk_simple_probe()
Content-Language: en-US
To:     "yu-chang.lee" <yu-chang.lee@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231026113830.29215-1-yu-chang.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231026113830.29215-1-yu-chang.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/10/23 13:38, yu-chang.lee ha scritto:
> switch to the common mtk_clk_simple_probe() function for all of the
> clock drivers that are registering as platform drivers.
> 

So VPPSYS0 and VPPSYS1 aren't dependant on MMSYS anymore?

Like this, it doesn't look like this will ever work fine, so if you want
that to happen, you must provide a good explanation, and then, since MT8188
and MT8195's VPPSYS are practically the same, you should also convert MT8195
to do the same, and make sure that everything works as expected before sending
a commit upstream.

Please, explain.

Thanks,
Angelo

> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
> ---
>   drivers/clk/mediatek/clk-mt8188-vpp0.c | 14 +++++++++++---
>   drivers/clk/mediatek/clk-mt8188-vpp1.c | 14 +++++++++++---
>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8188-vpp0.c b/drivers/clk/mediatek/clk-mt8188-vpp0.c
> index e7b02b26fefb..18fffa191ee1 100644
> --- a/drivers/clk/mediatek/clk-mt8188-vpp0.c
> +++ b/drivers/clk/mediatek/clk-mt8188-vpp0.c
> @@ -96,6 +96,15 @@ static const struct mtk_clk_desc vpp0_desc = {
>   	.num_clks = ARRAY_SIZE(vpp0_clks),
>   };
>   
> +static const struct of_device_id of_match_clk_mt8188_vpp0[] = {
> +	{
> +		.compatible = "mediatek,mt8188-vppsys0",
> +		.data = &vpp0_desc,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
>   static const struct platform_device_id clk_mt8188_vpp0_id_table[] = {
>   	{ .name = "clk-mt8188-vpp0", .driver_data = (kernel_ulong_t)&vpp0_desc },
>   	{ /* sentinel */ }
> @@ -103,12 +112,11 @@ static const struct platform_device_id clk_mt8188_vpp0_id_table[] = {
>   MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp0_id_table);
>   
>   static struct platform_driver clk_mt8188_vpp0_drv = {
> -	.probe = mtk_clk_pdev_probe,
> -	.remove_new = mtk_clk_pdev_remove,
> +	.probe = mtk_clk_simple_probe,
>   	.driver = {
>   		.name = "clk-mt8188-vpp0",
> +		.of_match_table = of_match_clk_mt8188_vpp0,
>   	},
> -	.id_table = clk_mt8188_vpp0_id_table,
>   };
>   module_platform_driver(clk_mt8188_vpp0_drv);
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8188-vpp1.c b/drivers/clk/mediatek/clk-mt8188-vpp1.c
> index e8f0f7eca097..f4b35336d427 100644
> --- a/drivers/clk/mediatek/clk-mt8188-vpp1.c
> +++ b/drivers/clk/mediatek/clk-mt8188-vpp1.c
> @@ -91,6 +91,15 @@ static const struct mtk_clk_desc vpp1_desc = {
>   	.num_clks = ARRAY_SIZE(vpp1_clks),
>   };
>   
> +static const struct of_device_id of_match_clk_mt8188_vpp1[] = {
> +	{
> +		.compatible = "mediatek,mt8188-vppsys1",
> +		.data = &vpp1_desc,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
>   static const struct platform_device_id clk_mt8188_vpp1_id_table[] = {
>   	{ .name = "clk-mt8188-vpp1", .driver_data = (kernel_ulong_t)&vpp1_desc },
>   	{ /* sentinel */ }
> @@ -98,12 +107,11 @@ static const struct platform_device_id clk_mt8188_vpp1_id_table[] = {
>   MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp1_id_table);
>   
>   static struct platform_driver clk_mt8188_vpp1_drv = {
> -	.probe = mtk_clk_pdev_probe,
> -	.remove_new = mtk_clk_pdev_remove,
> +	.probe = mtk_clk_simple_probe,
>   	.driver = {
>   		.name = "clk-mt8188-vpp1",
> +		.of_match_table = of_match_clk_mt8188_vpp1,
>   	},
> -	.id_table = clk_mt8188_vpp1_id_table,
>   };
>   module_platform_driver(clk_mt8188_vpp1_drv);
>   MODULE_LICENSE("GPL");

