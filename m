Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4987A754EDC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjGPNke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 09:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDB2E6E;
        Sun, 16 Jul 2023 06:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB12660CF7;
        Sun, 16 Jul 2023 13:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9786C433C8;
        Sun, 16 Jul 2023 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689514831;
        bh=naNqnTGi8G/TtDcRQ7Ugp3e5gX6+eGvdkujrUDzO2LY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PapCuYyaQ59pzb2sB5m6jEK9IcDBt+RZPzkDDj3gDpCM0z6F5LJLvcyK4X7A7g0z5
         GzvLDmAHUgsVHiGvzefWv5qIOxXLqpSNSACRxX5U+2zymqhqiQKQKAefBYa4V81Xwg
         FPGK8a9zEtetXye+QwuIh926U6vKyvbc/ozGRVvuwsO3Gdf68uoPISz/iJcc6LKrlL
         IPSqb35dWjlreXLkrnRHMb82ByDKcOWdBUsD38gXvSDnye+CD+2ex/2Mi4BkmOUyQO
         Hv+6rrSirixOmMvxLYCntFRKnmT7Xrw9xP8UiI4p/68G3P55jh+y+Na9DSSy+Nm2FV
         LJYKKPRNkGGmA==
Date:   Sun, 16 Jul 2023 14:40:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] staging: iio: ad7816: add iio interface
Message-ID: <20230716144024.30ded663@jic23-huawei>
In-Reply-To: <DB4PR10MB6261ADF6C8845AF66AB292989232A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
References: <DB4PR10MB6261ADF6C8845AF66AB292989232A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
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

On Sun,  9 Jul 2023 00:29:58 +0800
JuenKit Yip <JuenKit_Yip@hotmail.com> wrote:

> add iio interface for 4 channels, replacing the previous sysfs
> interface
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>

Hi JuenKit,

Great to see some work on this driver.

A few comments inline.  Mostly they are about the fact we can't unwind
this part of the interface without dealing with the other use of the existing 'channel'
attribute.

This is a great start, but need to jump forwards a few more steps so that
we don't accidentally reduce or confuse the existing functionality.


> ---
>  drivers/staging/iio/adc/ad7816.c | 122 +++++++++++++++----------------
>  1 file changed, 59 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 6c14d7bcdd67..8af117b6ae11 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -162,64 +162,17 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
>  static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
>  			NULL, 0);
>  
> -static ssize_t ad7816_show_channel(struct device *dev,
> -				   struct device_attribute *attr,
> -				   char *buf)
> +static int ad7816_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long m)
Probably better to rewrap this to get closer to the 80 char line length.

>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> -
> -	return sprintf(buf, "%d\n", chip->channel_id);
> -}
> -
> -static ssize_t ad7816_store_channel(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf,
> -				    size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> -	unsigned long data;
> -	int ret;
> -
> -	ret = kstrtoul(buf, 10, &data);
> -	if (ret)
> -		return ret;
> -
> -	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
> -		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
> -			data, indio_dev->name);
> -		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
> -		dev_err(&chip->spi_dev->dev,
> -			"Invalid channel id %lu for ad7818.\n", data);
> -		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
> -		dev_err(&chip->spi_dev->dev,
> -			"Invalid channel id %lu for ad7816.\n", data);
> -		return -EINVAL;
> -	}
> -
> -	chip->channel_id = data;
> -
> -	return len;
> -}
> -
> -static IIO_DEVICE_ATTR(channel, 0644,
> -		ad7816_show_channel,
> -		ad7816_store_channel,
> -		0);
> -
> -static ssize_t ad7816_show_value(struct device *dev,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>  	u16 data;
> -	s8 value;
>  	int ret;
>  
> +	chip->channel_id = (u8)chan->channel;

Can we keep the channel_id local?
It is used for over temperature detection (OTI) but that needs separating out.

Given you'll be breaking that connection I think you need to deal with
both the main attributes and the event ones in a single go.  Thus removing
any hidden usage of the last channel touched like you have here.


>  	ret = ad7816_spi_read(chip, &data);
>  	if (ret)
>  		return -EIO;
> @@ -227,22 +180,21 @@ static ssize_t ad7816_show_value(struct device *dev,
>  	data >>= AD7816_VALUE_OFFSET;
>  
>  	if (chip->channel_id == 0) {
> -		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
> -		data &= AD7816_TEMP_FLOAT_MASK;
> -		if (value < 0)
> -			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
> -		return sprintf(buf, "%d.%.2d\n", value, data * 25);
> +		*val = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);

Use masks and FIELD_GET() though that change perhaps belongs in a separate patch set.

> +		*val2 = (data & AD7816_TEMP_FLOAT_MASK) * 25;
> +		if (*val < 0)
> +			*val2 = BIT(AD7816_TEMP_FLOAT_OFFSET) - *val2;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	}
> -	return sprintf(buf, "%u\n", data);
> -}
>  
> -static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
> +	*val = data;
> +
> +	return IIO_VAL_INT;
> +}
>  
>  static struct attribute *ad7816_attributes[] = {
>  	&iio_dev_attr_available_modes.dev_attr.attr,
>  	&iio_dev_attr_mode.dev_attr.attr,
> -	&iio_dev_attr_channel.dev_attr.attr,
> -	&iio_dev_attr_value.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -341,10 +293,47 @@ static const struct attribute_group ad7816_event_attribute_group = {
>  };
>  
>  static const struct iio_info ad7816_info = {
> +	.read_raw = ad7816_read_raw,
>  	.attrs = &ad7816_attribute_group,
>  	.event_attrs = &ad7816_event_attribute_group,
>  };
>  
> +static const struct iio_chan_spec ad7816_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +};
> +
> +static const struct iio_chan_spec ad7817_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),

This would require the reading presented to be in the units defined by
the ABI (Documentation/ABI/testing/sysfs-bus-iio)
Can you confirm that these are all correct?

Note it is very unusual for an IIO driver to present all processed channels.
Superficially it looks like there might be some appropriate conversions done
for the temperature channels for them to be in the right units, but nothing
at all is done to the voltage channels...

> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 2,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 3,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +};
> +
>  /*
>   * device probe and remove
>   */
> @@ -367,6 +356,13 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  		chip->oti_data[i] = 203;
>  
>  	chip->id = spi_get_device_id(spi_dev)->driver_data;
> +	if (chip->id == ID_AD7816) {
> +		indio_dev->channels = ad7816_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7816_channels);
> +	} else {
> +		indio_dev->channels = ad7817_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7817_channels);
> +	}
>  	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
>  	if (IS_ERR(chip->rdwr_pin)) {
>  		ret = PTR_ERR(chip->rdwr_pin);

	
