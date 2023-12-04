Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0280310C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbjLDK6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjLDK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:57:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F818D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:57:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F22C433C8;
        Mon,  4 Dec 2023 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701687459;
        bh=I8qqFwU/CNFBFB1RbaJ0Hz5lP25JM/DystuP6KB/gqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ESX7vJifVGf9HThVts8MfAnPbTBy7uX0FPUy4zk3R9O4JSLCtEhVnr77mwNbTaa90
         B29/HPII4ljy0fbh9Tm/30J7v6lQBV9eZx2+5TNGZfRf+2kuC51tqxg471FFh7Rl1k
         as2/BNdKxjtFtE5VWZvz/AxPlm/uZY+F4xMg0C8j6nS8USfZ+ZHLqnkR0g5zkXuJRy
         MqOXTSKDjQBQ8E294Dmfd/R1Nr/etEKVcx/2t6mqYD7Jfc/YSi0xxre3ggKCBsvEmc
         EpGBGG9LkoH8RfrsRWWQlVls4Kr2IlAJAFQ3YOVtFzU5FWPxuw/kH+cXsTQ+700YZk
         IbirFw/vFBO7g==
Date:   Mon, 4 Dec 2023 10:57:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     George Stark <gnstark@salutedevices.com>
Cc:     <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v3 1/1] iio: adc: meson: add separate config for axg SoC
 family
Message-ID: <20231204105730.49623b12@jic23-huawei>
In-Reply-To: <20231127235558.71995-1-gnstark@salutedevices.com>
References: <20231127235558.71995-1-gnstark@salutedevices.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 02:55:58 +0300
George Stark <gnstark@salutedevices.com> wrote:

> According to Amlogic custom kernels ADC of axg SoC family has
> vref_select and requires this setting to work nominally and thus
> needs a separate config.
> 
> Fixes: 90c6241860bf ("iio: adc: meson: init voltage control bits")
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index db280da9edbf..34555a85f131 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1242,6 +1242,20 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
>  	.cmv_select = 1,
>  };
>  
> +static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
> +	.has_bl30_integration = true,
> +	.clock_rate = 1200000,
> +	.bandgap_reg = MESON_SAR_ADC_REG11,
> +	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
> +	.resolution = 12,
> +	.disable_ring_counter = 1,
> +	.has_reg11 = true,
> +	.vref_volatge = 1,
> +	.has_vref_select = true,
> +	.vref_select = VREF_VDDA,
> +	.cmv_select = 1,
> +};
> +
>  static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
>  	.has_bl30_integration = false,
>  	.clock_rate = 1200000,
> @@ -1286,7 +1300,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>  };
>  
>  static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
> -	.param = &meson_sar_adc_gxl_param,
> +	.param = &meson_sar_adc_axg_param,
>  	.name = "meson-axg-saradc",
>  };
>  

