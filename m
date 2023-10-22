Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281CB7D2413
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjJVQBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjJVQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:00:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4700BF4;
        Sun, 22 Oct 2023 09:00:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A5DC433C7;
        Sun, 22 Oct 2023 16:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697990455;
        bh=utWI+Zvn3U4GICP6jBDcLsKnfFN0aqL2pXHguYrSXAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KkEi+BHgSsQ86250AV2fVisFXT3WcG6eDJgufYG8J/UzTdlnHzbabYt8n3zjJrsqR
         2WG1vUCAC891qeHurQHgkjsBYF1gBCnC47AawxFbU+9EPHcne9YLtlTf9pJTCvQHqz
         392vHHK1xtgOg0hrr/Jva6MyD3Mwmqhp857gDLOnq3jkTq0bIpxlxZNW4OopLUztYv
         EibaDb/ozHuLUV/mQiv6eVVheWPZ+mzfIE237vXBtbdDdEQtC0n/zx1zuNWQpt7gr4
         mcNz28yuiIZnbAraTDwp4uzLqrILoRIg9Zm2er5fPfgMrNm8xSiDdVyh1L3ngK+9n8
         41O4tzEKam8bw==
Date:   Sun, 22 Oct 2023 17:00:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sukrut Bellary <sukrut.bellary@linux.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-adc128s052: Add lower resolution
 devices support
Message-ID: <20231022170048.289a1897@jic23-huawei>
In-Reply-To: <20231022031203.632153-3-sukrut.bellary@linux.com>
References: <20231022031203.632153-1-sukrut.bellary@linux.com>
        <20231022031203.632153-3-sukrut.bellary@linux.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2023 20:12:03 -0700
Sukrut Bellary <sukrut.bellary@linux.com> wrote:

> The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> interface. The device family responds with 12-bit data, of which the LSB
> bits are transmitted by the lower resolution devices as 0.
> The unavailable bits are 0 in LSB.
> Shift is calculated per resolution and used in scaling and
> raw data read.
> 
> Lets reuse the driver to support the family of devices with name
> ADC<bb><c>S<sss>, where
> * bb is the resolution in number of bits (8, 10, 12)
> * c is the number of channels (1, 2, 4, 8)
> * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> and 101 for 1 MSPS)
> 
> Complete datasheets are available at TI's website here:
> https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> 
> Tested only with ti-adc102s051 on BegalePlay SBC.
> https://www.beagleboard.org/boards/beagleplay
> 
> arm64: dts: ti: k3-am625-beagleplay: Add adc102s051
> Add adc102s051 support.
> Tested on beaglePlay SBC
> https://www.beagleboard.org/boards/beagleplay
> 
> Co-developed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> ---
> Changes in v2:
>         - Arranged of_device_id and spi_device_id in numeric order.
>         - Used enum to index into adc128_config.
>         - Reorder adc128_config in alphabetical.
>         - Include channel resolution information.
>         - Shift is calculated per resolution and used in scaling and 
>           raw data read.
> - Link to v1: https://lore.kernel.org/all/20220701042919.18180-3-nm@ti.com/
> ---
>  drivers/iio/adc/ti-adc128s052.c | 131 +++++++++++++++++++++++---------
>  1 file changed, 96 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index a456ea78462f..61e3181b8daf 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -7,6 +7,22 @@
>   * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
>   * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
>   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> + *
> + * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> + * interface. This driver supports the whole family of devices with a name
> + * ADC<bb><c>S<sss>, where
> + * bb is the resolution in number of bits (8, 10, 12)
> + * c is the number of channels (1, 2, 4, 8)
> + * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> + * and 101 for 1 MSPS)
> + *
> + * Complete datasheets are available at TI's website here:
> + *   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> + *
> + * 8, 10, and 12 bits converters send 12-bit data with
> + * unavailable bits set to 0 in LSB.
> + * Shift is calculated per resolution and used in scaling and
> + * raw data read.
>   */
>  
>  #include <linux/err.h>
> @@ -53,7 +69,7 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>  	if (ret < 0)
>  		return ret;
>  
> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> +	return (adc->buffer[0] << 8 | adc->buffer[1]);
Firstly outer brackets don't add anything.
Secondly, this is an endian conversion.

return be16_to_cpu(adc->buffer);

should do the job as we know it's aligned enough for a be16.


>  }
>  
>  static int adc128_read_raw(struct iio_dev *indio_dev,
> @@ -70,7 +86,8 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = ret;
> +		*val = (ret >> channel->scan_type.shift) &
> +			GENMASK(channel->scan_type.realbits - 1, 0);
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> @@ -80,7 +97,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		*val = ret / 1000;
> -		*val2 = 12;
> +		*val2 = channel->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
>  	default:
> @@ -89,24 +106,34 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  
>  }
>  
> -#define ADC128_VOLTAGE_CHANNEL(num)	\
> -	{ \
> -		.type = IIO_VOLTAGE, \
> -		.indexed = 1, \
> -		.channel = (num), \
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
> +#define _ADC128_VOLTAGE_CHANNEL(num, real_bits, store_bits)		\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = (num),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = (num),					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = (real_bits),			\
> +			.storagebits = (store_bits),			\
> +			.shift = (12 - real_bits),			\
> +		},							\
>  	}
>  
> -static const struct iio_chan_spec adc128s052_channels[] = {
> -	ADC128_VOLTAGE_CHANNEL(0),
> -	ADC128_VOLTAGE_CHANNEL(1),
> -	ADC128_VOLTAGE_CHANNEL(2),
> -	ADC128_VOLTAGE_CHANNEL(3),
> -	ADC128_VOLTAGE_CHANNEL(4),
> -	ADC128_VOLTAGE_CHANNEL(5),
> -	ADC128_VOLTAGE_CHANNEL(6),
> -	ADC128_VOLTAGE_CHANNEL(7),
> +#define ADC082_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 8, 16)
> +#define ADC102_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 10, 16)
> +#define ADC128_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 12, 16)
> +
> +static const struct iio_chan_spec adc082s021_channels[] = {
> +	ADC082_VOLTAGE_CHANNEL(0),
> +	ADC082_VOLTAGE_CHANNEL(1),
> +};
> +
> +static const struct iio_chan_spec adc102s021_channels[] = {
> +	ADC102_VOLTAGE_CHANNEL(0),
> +	ADC102_VOLTAGE_CHANNEL(1),
>  };
>  
>  static const struct iio_chan_spec adc122s021_channels[] = {
> @@ -121,10 +148,32 @@ static const struct iio_chan_spec adc124s021_channels[] = {
>  	ADC128_VOLTAGE_CHANNEL(3),
>  };
>  
> +static const struct iio_chan_spec adc128s052_channels[] = {
> +	ADC128_VOLTAGE_CHANNEL(0),
> +	ADC128_VOLTAGE_CHANNEL(1),
> +	ADC128_VOLTAGE_CHANNEL(2),
> +	ADC128_VOLTAGE_CHANNEL(3),
> +	ADC128_VOLTAGE_CHANNEL(4),
> +	ADC128_VOLTAGE_CHANNEL(5),
> +	ADC128_VOLTAGE_CHANNEL(6),
> +	ADC128_VOLTAGE_CHANNEL(7),
> +};
> +
>  static const struct adc128_configuration adc128_config[] = {
> -	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
> +	{ adc082s021_channels, ARRAY_SIZE(adc082s021_channels) },
> +	{ adc102s021_channels, ARRAY_SIZE(adc102s021_channels) },
>  	{ adc122s021_channels, ARRAY_SIZE(adc122s021_channels) },
>  	{ adc124s021_channels, ARRAY_SIZE(adc124s021_channels) },
> +	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
> +};
> +
> +/* Ensure match with adc128_config indices */

Make sure that is the case by using them when setting it up.

static const struct adc128_configuration adc128_config[] {
	[ADC128_CONFIG_INDEX_082S] = {
		adc082s021_channels, ARRAY_SIZE(..) 
	},
	[ADC128_CONFIG_INDEX_102S] = ..
}

Or I think you can make it irrelevant by not using an array at all.
static const struct ad128_configruation adc082s021_config = {
};

etc then just use the address of the right one directly.

In this driver, I suspect that is simpler than using the array.

> +enum adc128_configuration_index {
> +	ADC128_CONFIG_INDEX_082S,
> +	ADC128_CONFIG_INDEX_102S,
> +	ADC128_CONFIG_INDEX_122S,
> +	ADC128_CONFIG_INDEX_124S,
> +	ADC128_CONFIG_INDEX_128S,

>  };
>  
>  static const struct iio_info adc128_info = {
> @@ -177,31 +226,43 @@ static int adc128_probe(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id adc128_of_match[] = {
> -	{ .compatible = "ti,adc128s052", .data = &adc128_config[0] },
> -	{ .compatible = "ti,adc122s021", .data = &adc128_config[1] },
> -	{ .compatible = "ti,adc122s051", .data = &adc128_config[1] },
> -	{ .compatible = "ti,adc122s101", .data = &adc128_config[1] },
> -	{ .compatible = "ti,adc124s021", .data = &adc128_config[2] },
> -	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
> -	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
> +	{ .compatible = "ti,adc082s021", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ .compatible = "ti,adc082s051", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ .compatible = "ti,adc082s101", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ .compatible = "ti,adc102s021", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ .compatible = "ti,adc102s051", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ .compatible = "ti,adc102s101", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ .compatible = "ti,adc122s021", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ .compatible = "ti,adc122s051", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ .compatible = "ti,adc122s101", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ .compatible = "ti,adc124s021", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ .compatible = "ti,adc124s051", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ .compatible = "ti,adc124s101", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ .compatible = "ti,adc128s052", .data = &adc128_config[ADC128_CONFIG_INDEX_128S] },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, adc128_of_match);
>  
>  static const struct spi_device_id adc128_id[] = {
> -	{ "adc128s052", (kernel_ulong_t)&adc128_config[0] },
> -	{ "adc122s021",	(kernel_ulong_t)&adc128_config[1] },
> -	{ "adc122s051",	(kernel_ulong_t)&adc128_config[1] },
> -	{ "adc122s101",	(kernel_ulong_t)&adc128_config[1] },
> -	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
> -	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
> -	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
> +	{ "adc082s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ "adc082s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ "adc082s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ "adc102s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ "adc102s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ "adc102s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ "adc122s021",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ "adc122s051",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ "adc122s101",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ "adc124s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ "adc124s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ "adc124s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ "adc128s052", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_128S] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adc128_id);
>  
>  static const struct acpi_device_id adc128_acpi_match[] = {
> -	{ "AANT1280", (kernel_ulong_t)&adc128_config[2] },
> +	{ "AANT1280", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);

