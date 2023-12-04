Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB35380388E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjLDPTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjLDPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:19:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD14F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:19:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5EFC433C8;
        Mon,  4 Dec 2023 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701703160;
        bh=5sEvSdS3ZKittuPMVcViM6IheLlMNVV6ts0oVk77otY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YousOfmMHBUnvlRCr32wRy8FZAF1dTCiHuVIv7Kp2hghkRxjzn4MqQ2IV42kUi7mm
         O9QiotGnaRLRKMgVT9kSHYI+B0kNX5sGLb3YOcF/kzMaCF31Y2xt0yqhBWBqIRMDWq
         uq5Arw2zDAQiMqdZtJirTTKNWaFMN4ppVhJsgzYHfyspehGngnpOAabogB9WgdXQnn
         O0L+CzECjLKWu7s6MDvRCZY1fhRKbvtqjh7ujY9+PsMOHqFuWPemkJgn6KTSvMlH2b
         Yjqm/OreLE8I7rJN96gXBgSlgoMwvs2dcppvhwEqvWaOMXxt3EldipR0L6XUx4VriV
         gXJgWFPGyGguw==
Date:   Mon, 4 Dec 2023 15:19:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc:     <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 05/12] iio: adc: ad9467: don't ignore error codes
Message-ID: <20231204151910.6ab1728f@jic23-huawei>
In-Reply-To: <20231121-dev-iio-backend-v1-5-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
        <20231121-dev-iio-backend-v1-5-6a3d542eba35@analog.com>
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

On Tue, 21 Nov 2023 11:20:18 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Make sure functions that return errors are not ignored.
> 
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 368ea57be117..04474dbfa631 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mutex.h>
David noted this one...

>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -160,11 +161,12 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
>  	struct spi_device *spi = st->spi;
>  	int ret;
>  
> -	if (readval == NULL) {
> +	if (!readval) {

Nothing wrong with tidying this up if the !readval syntax is more common
in the driver, but it doesn't have anything to do with the fix, so not in this
patch.

>  		ret = ad9467_spi_write(spi, reg, writeval);
> -		ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
> -				 AN877_ADC_TRANSFER_SYNC);
> -		return ret;
> +		if (ret)
> +			return ret;
> +		return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
> +					AN877_ADC_TRANSFER_SYNC);
>  	}
>  
>  	ret = ad9467_spi_read(spi, reg);
> @@ -274,6 +276,8 @@ static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
>  	unsigned int i, vref_val;
unsigned and you check it for < 0 ..

>  
>  	vref_val = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
> +	if (vref_val < 0)
> +		return vref_val;

int ret = ...

	vref_val = ret & info1->vref_mask; 
if not an error.


>  
>  	vref_val &= info1->vref_mask;
>  
> @@ -296,6 +300,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
>  	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
>  	unsigned int scale_val[2];
>  	unsigned int i;
> +	int ret;
>  
>  	if (val != 0)
>  		return -EINVAL;
> @@ -305,11 +310,13 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
>  		if (scale_val[0] != val || scale_val[1] != val2)
>  			continue;
>  
> -		ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
> -				 info->scale_table[i][1]);
> -		ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
> -				 AN877_ADC_TRANSFER_SYNC);
> -		return 0;
> +		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
> +				       info->scale_table[i][1]);
> +		if (ret < 0)
> +			return ret;
> +
> +		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
> +					AN877_ADC_TRANSFER_SYNC);
>  	}
>  
>  	return -EINVAL;
> 

