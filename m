Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7619E7AC4EF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjIWTt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIWTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:49:25 -0400
X-Greylist: delayed 1713 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Sep 2023 12:49:18 PDT
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF9AAB;
        Sat, 23 Sep 2023 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=jMXd1quUr0+4Bgg8K1TIGdstVnnOb1EijX3MMcy3RFQ=; b=MbtgFZukg+xQ0j2QGvNlpu1xQg
        6K8ceyinxfnZsZZtNof+BsB10qCvxWd5aTrKqTDu/2gkgblFE77r6rq0PVStUrZCeEFpBRNseOjyX
        KKgAvsEMYXsLKz+brH/xlQS6XzQBdq1jGe/yBsWUCREIiQk0PNKmFMrwOfy9+vQ+VmVXtxInRh/wS
        O9623vweCUuF20Jhes7mglr/EMUtbtV92HQ+thOxP9yLj1kPn5psTXaurPXxYGOHKEf3N2kTiFmOw
        MSfQS5RbzfAaBLVxuwki1aaJdZWE2sPqqIjlnSpg+K04GC3gcBDdVksEaOQrS5L8rN35sexEVPoXk
        j5ZCUu/w==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1qk8BG-0007Up-U0; Sat, 23 Sep 2023 21:20:42 +0200
Received: from [136.25.87.181] (helo=[192.168.86.26])
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1qk8BG-000MRy-Gr; Sat, 23 Sep 2023 21:20:42 +0200
Message-ID: <06c78732-5f35-8b33-e374-7e8b148ddff9@metafoo.de>
Date:   Sat, 23 Sep 2023 12:20:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] iio: adc: Add driver support for MAX34408/9
Content-Language: en-US
To:     Ivan Mikhaylov <fr0st61te@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230917211143.7094-1-fr0st61te@gmail.com>
 <20230917211143.7094-3-fr0st61te@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230917211143.7094-3-fr0st61te@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27040/Sat Sep 23 09:38:24 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks very good. Few small comments.

On 9/17/23 14:11, Ivan Mikhaylov wrote:
> [...]
> +static int max34408_read_adc_avg(struct max34408_data *max34408, int channel, int *val)
> +{
> +	unsigned long ctrl;
Should be unsigned int so its compatible with the regmap API and you do 
not have to cast. Otherwise you'll run into trouble where long is 64 bit.
> +	int rc;
> +	u8 tmp;
> +
> +	mutex_lock(&max34408->lock);
> +	rc = regmap_read(max34408->regmap, MAX34408_CONTROL, (u32 *)&ctrl);
> +	if (rc)
> +		goto err_unlock;
> +
> +	/* set averaging (0b100) default values*/
> +	tmp = ctrl;
> +	set_bit(CONTROL_AVG2, &ctrl);
> +	clear_bit(CONTROL_AVG1, &ctrl);
> +	clear_bit(CONTROL_AVG0, &ctrl);

While using set and clear_bit is not wrong these are the atomic 
versions. There is __{set,clear}_bit as the non atomic version. But in 
my opinion is fine to just use |= and &= here.


> +	rc = regmap_write(max34408->regmap, MAX34408_CONTROL, ctrl);
> +	if (rc) {
> +		dev_err(max34408->dev,
> +			"Error (%d) writing control register\n", rc);
> +		goto err_unlock;
> +	}
> +
> +	rc = max34408_read_adc(max34408, channel, val);
> +	if (rc)
> +		goto err_unlock;
> +
> +	/* back to old values */
> +	rc = regmap_write(max34408->regmap, MAX34408_CONTROL, tmp);
> +	if (rc)
> +		dev_err(max34408->dev,
> +			"Error (%d) writing control register\n", rc);
> +
> +err_unlock:
> +	mutex_unlock(&max34408->lock);
> +
> +	return rc;
> +}
> +
> +static int max34408_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max34408_data *max34408 = iio_priv(indio_dev);
> +	int rc;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		rc = max34408_read_adc_avg(max34408, chan->channel,
> +					   val);
> +		if (rc)
> +			return rc;
> +
> +		if (mask == IIO_CHAN_INFO_PROCESSED) {


Usually we only have either raw + offset and scale or processed. In this 
case I'd go with raw + scale and offset since it is a linear 
transformation. processed is usually only used when the transformation 
is non linear.

> +			/*
> +			 * calcluate current for 8bit ADC with Rsense
> +			 * value.
> +			 * 10 mV * 1000 / Rsense uOhm = max current
> +			 * (max current * adc val * 1000) / (2^8 - 1) mA
> +			 */
> +			*val = DIV_ROUND_CLOSEST((10000 / max34408->rsense) *
> +						 *val * 1000, 256);
> +		}
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		rc = max34408_read_adc(max34408, chan->channel, val);
> +		if (rc)
> +			return rc;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info max34408_info = {
> +	.read_raw	= max34408_read_raw,
> +};
> +
> +static int max34408_probe(struct i2c_client *client)
> +{
> +	struct device_node *np = client->dev.of_node;
> +	struct max34408_data *max34408;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int rc;
> +
> +	regmap = devm_regmap_init_i2c(client, &max34408_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "regmap_init failed\n");
There is a the dev_err_probe function, which has the advantage of having 
a unified formatting for the error message style.
> +		return PTR_ERR(regmap);
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max34408));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	max34408 = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	max34408->regmap = regmap;
> +	max34408->dev = &client->dev;
> +	mutex_init(&max34408->lock);
> +	rc = device_property_read_u32(&client->dev,
> +				      "maxim,rsense-val-micro-ohms",
> +				      &max34408->rsense);
> +	if (rc)
> +		return -EINVAL;
> +
> +	/* disable ALERT and averaging */
> +	rc = regmap_write(max34408->regmap, MAX34408_CONTROL, 0x0);
> +	if (rc)
> +		return rc;
> +
> +	if (of_device_is_compatible(np, "maxim,max34408")) {
Instead of using of_device_is_compatible it is usually preferred to 
assign some sort of chip_data struct to the data field of the of the 
compatible array. This makes it both easier to add new chips and also 
other ways to instantiate the device besides devicetree.
> +		indio_dev->channels = max34408_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(max34408_channels);
> +		indio_dev->name = "max34408";
> +	} else if (of_device_is_compatible(np, "maxim,max34409")) {
> +		indio_dev->channels = max34409_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(max34409_channels);
> +		indio_dev->name = "max34409";
> +	}
> +	indio_dev->info = &max34408_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.of_node = np;
The assignment of of_node should not be needed, the IIO core will take 
care of this.
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +


