Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5897774496
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjHHSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjHHSXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:23:38 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929B23C33;
        Tue,  8 Aug 2023 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=XkZlvp32aRkJTNbGOKHPFPOVDj8xTKl+lMyseu9ZRpY=; b=hHzTyYqt9hPsBJ21nGtMp8MPJB
        ycW/EtEnHqTW3Tr9GQH8pLqHCWaIpL9gfw1pFjdbzBJlreCQuHKxCtMTEtf5og5sanwk4odTkt1ni
        74TAdCwbUC2EsUrbqGQIMlYHMlrQK3FNUNdalZj0rnfqqeiS95IshVMO/RHEL6b4YtMQ=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:37752 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qTQbZ-0001On-JD; Tue, 08 Aug 2023 13:34:50 -0400
Date:   Tue, 8 Aug 2023 13:34:48 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Message-Id: <20230808133448.96e39db8e86a67ad7e2e5a43@hugovil.com>
In-Reply-To: <20230808033106.2174-1-Wenhua.Lin@unisoc.com>
References: <20230808033106.2174-1-Wenhua.Lin@unisoc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 1/3] gpio: sprd: Modify the calculation method of eic
 number
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 11:31:06 +0800
Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:

> Automatic calculation through matching nodes,
> subsequent projects can avoid modifying driver files.
> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/gpio/gpio-eic-sprd.c | 49 +++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 84352a6f4973..0d85d9e80848 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -50,10 +50,10 @@
>  #define SPRD_EIC_SYNC_DATA		0x1c
>  
>  /*
> - * The digital-chip EIC controller can support maximum 3 banks, and each bank
> + * The digital-chip EIC controller can support maximum 8 banks, and each bank
>   * contains 8 EICs.
>   */
> -#define SPRD_EIC_MAX_BANK		3
> +#define SPRD_EIC_MAX_BANK		8

Hi,
it seems as tough the commit title doesn't reflect the fact that you
not only modify the calculation method, but also the maximum number of
banks?


>  #define SPRD_EIC_PER_BANK_NR		8
>  #define SPRD_EIC_DATA_MASK		GENMASK(7, 0)
>  #define SPRD_EIC_BIT(x)			((x) & (SPRD_EIC_PER_BANK_NR - 1))
> @@ -99,33 +99,32 @@ struct sprd_eic {
>  
>  struct sprd_eic_variant_data {
>  	enum sprd_eic_type type;
> -	u32 num_eics;
>  };
>  
> +#define SPRD_EIC_VAR_DATA(soc_name)				\
> +static const struct sprd_eic_variant_data soc_name##_eic_dbnc_data = {	\
> +	.type = SPRD_EIC_DEBOUNCE,					\
> +};									\
> +									\
> +static const struct sprd_eic_variant_data soc_name##_eic_latch_data = {	\
> +	.type = SPRD_EIC_LATCH,						\
> +};									\
> +									\
> +static const struct sprd_eic_variant_data soc_name##_eic_async_data = {	\
> +	.type = SPRD_EIC_ASYNC,						\
> +};									\
> +									\
> +static const struct sprd_eic_variant_data soc_name##_eic_sync_data = {	\
> +	.type = SPRD_EIC_SYNC,						\
> +}
> +
> +SPRD_EIC_VAR_DATA(sc9860);
> +
>  static const char *sprd_eic_label_name[SPRD_EIC_MAX] = {
>  	"eic-debounce", "eic-latch", "eic-async",
>  	"eic-sync",
>  };
>  
> -static const struct sprd_eic_variant_data sc9860_eic_dbnc_data = {
> -	.type = SPRD_EIC_DEBOUNCE,
> -	.num_eics = 8,
> -};
> -
> -static const struct sprd_eic_variant_data sc9860_eic_latch_data = {
> -	.type = SPRD_EIC_LATCH,
> -	.num_eics = 8,
> -};
> -
> -static const struct sprd_eic_variant_data sc9860_eic_async_data = {
> -	.type = SPRD_EIC_ASYNC,
> -	.num_eics = 8,
> -};
> -
> -static const struct sprd_eic_variant_data sc9860_eic_sync_data = {
> -	.type = SPRD_EIC_SYNC,
> -	.num_eics = 8,
> -};
>  
>  static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *sprd_eic,
>  						 unsigned int bank)
> @@ -583,6 +582,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
>  	struct sprd_eic *sprd_eic;
>  	struct resource *res;
>  	int ret, i;
> +	u16 num_banks = 0;
>  
>  	pdata = of_device_get_match_data(&pdev->dev);
>  	if (!pdata) {
> @@ -613,12 +613,13 @@ static int sprd_eic_probe(struct platform_device *pdev)
>  			break;
>  
>  		sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
> +		num_banks++;
>  		if (IS_ERR(sprd_eic->base[i]))
>  			return PTR_ERR(sprd_eic->base[i]);
>  	}
>  
>  	sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
> -	sprd_eic->chip.ngpio = pdata->num_eics;
> +	sprd_eic->chip.ngpio = num_banks * SPRD_EIC_PER_BANK_NR;
>  	sprd_eic->chip.base = -1;
>  	sprd_eic->chip.parent = &pdev->dev;
>  	sprd_eic->chip.direction_input = sprd_eic_direction_input;
> @@ -630,10 +631,12 @@ static int sprd_eic_probe(struct platform_device *pdev)
>  		sprd_eic->chip.set = sprd_eic_set;
>  		fallthrough;
>  	case SPRD_EIC_ASYNC:
> +		fallthrough;
>  	case SPRD_EIC_SYNC:
>  		sprd_eic->chip.get = sprd_eic_get;
>  		break;
>  	case SPRD_EIC_LATCH:
> +		fallthrough;
>  	default:
>  		break;
>  	}
> -- 
> 2.17.1
> 
