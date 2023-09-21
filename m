Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462DF7AA4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjIUWNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjIUWNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:13:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29B96EA7;
        Thu, 21 Sep 2023 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=UcFpdC0vFAH/Fz0DtjkWCHabyBbtm3h/3opGUF6dgAA=; b=YZ0rClUvYgEYr6oOzoWfENSHfx
        6AZwg6G6ehK45Ckqt2RCZzEjeB4NDXXU8IiGCU0HFHXe7yKHuKl7dq+08W9L0Gyxh2aY9j10oRrfC
        c31gx5p7P0I5DoPujRMF2Piib5feDIzKPdvux85dYpzRIn2VEPKysylMU0Pfd0HXd5i4aLjCtU2RB
        euFiT3Yl4N9Yrk9V/Hjb+50doTIXFaD7s9IWkakY3XY6mSOe84UTF+Qtx0aelN69ktc2zU1eBEzIt
        gSt4DtIEqgs8+SD+NAHHDx+XnYvIEndeH9eP7Ssr2I56MZAoC7DYMDf5jbnbvYIFgXQWQKR2NuLWy
        p59cNmlg==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjRmS-007FzB-05;
        Thu, 21 Sep 2023 22:04:16 +0000
Message-ID: <d1d836c6-4597-4870-8c7f-ebede83c2392@infradead.org>
Date:   Thu, 21 Sep 2023 15:04:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: imx: Select MXC_CLK for CLK_IMX8QXP
To:     Abel Vesa <abel.vesa@linaro.org>, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230921093647.3901752-1-abel.vesa@linaro.org>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230921093647.3901752-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/23 02:36, Abel Vesa wrote:
> If the i.MX8QXP clock provider is built-in but the MXC_CLK is
> built as module, build fails:
> 
> aarch64-linux-ld: drivers/clk/imx/clk-imx8-acm.o: in function `imx8_acm_clk_probe':
> clk-imx8-acm.c:(.text+0x3d0): undefined reference to `imx_check_clk_hws'
> 
> Fix that by selecting MXC_CLK in case of CLK_IMX8QXP.
> 
> Fixes: c2cccb6d0b33 ("clk: imx: add imx8qxp clk driver")
> Closes: https://lore.kernel.org/all/8b77219e-b59e-40f1-96f1-980a0b2debcf@infradead.org/
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/clk/imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index f6b82e0b9703..db3bca5f4ec9 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -96,6 +96,7 @@ config CLK_IMX8QXP
>  	depends on (ARCH_MXC && ARM64) || COMPILE_TEST
>  	depends on IMX_SCU && HAVE_ARM_SMCCC
>  	select MXC_CLK_SCU
> +	select MXC_CLK
>  	help
>  	  Build the driver for IMX8QXP SCU based clocks.
>  

-- 
~Randy
