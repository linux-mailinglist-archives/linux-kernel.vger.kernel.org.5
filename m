Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19A77F8C2A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKYPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjKYPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:50:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B47EDB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:50:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAEDC433C8;
        Sat, 25 Nov 2023 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700927446;
        bh=IMdjSRImTOsSj632Oy8vblfweC2HmmGiUhLrTQiSzSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Debed8VxJmwqkFs3bQazCdvwV8ZnagzGwZO6SOGs/BnV71m+bJogDKl6a5H8twVT9
         /2bqHceXiRQa9cAtRLp8p4wOpN8ezoEmWv+1Qp3b1LXcyhPdsXod+a1P07udKGnDNh
         aV4PXJ0lCW4zDGzDj3k3WvToPqS9hHbBZzvW+7VcNyOJM4sG4K3kbyFAnP2/icg9/v
         5pKTlfAGPl64GqBmqaetfzon67Y19P4YyMAJ9s+AoyBDNUwQQ7amfNDRTZEARqQ2j/
         vllJZRWU8qTsXTuF7dEotw8VE4NGoXrwWeddQWEck6DzAxdSVQmJOBZWpXTfPcNFdA
         IoT0LDJ1mlPFw==
Date:   Sat, 25 Nov 2023 15:50:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v5 2/2] iio: frequency: admfm2000: New driver
Message-ID: <20231125155038.5278de39@jic23-huawei>
In-Reply-To: <20231124105116.5764-2-kimseer.paller@analog.com>
References: <20231124105116.5764-1-kimseer.paller@analog.com>
        <20231124105116.5764-2-kimseer.paller@analog.com>
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

On Fri, 24 Nov 2023 18:51:16 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
I've +CC Linus and Bartosz for the question of GPIOs under the channel child
nodes in DT.

Some background for them.  This device has two separate channels and each of them
has a mirrored set of attentuation and configuration controls via arrays of GPIOS.

Currently they are
switch1-gpios, switch2-gpios etc.

I suggested we might be able to move those into the existing channel child nodes
that are used for describing other per channel stuff.

      channel@0 {
        reg = <0>;
        adi,mode = <1>;
	switch-gpios = <&gpio 1 GPIO_ACTIVE_LOW>,
                       <&gpio 2 GPIO_ACTIVE_HIGH>

	attenuation-gpios = <&gpio 17 GPIO_ACTIVE_LOW>,
                            <&gpio 22 GPIO_ACTIVE_LOW>,
                            <&gpio 23 GPIO_ACTIVE_LOW>,
                            <&gpio 24 GPIO_ACTIVE_LOW>,
                            <&gpio 25 GPIO_ACTIVE_LOW>;
      };

I think there are suitable interfaces to do this in the GPIO firmware handling code
but wanted your opinion on whether it is worth the effort.

Relevant code is towards the end.

A few trivial other comments. In general this looks very clean to me.

Thanks,

Jonathan

> ---
> V4 -> V5: Added missing return -ENODEV in setup function. Reordered variable
> 	  declarations in probe function.
> V1 -> V4: No changes.
> 
>  MAINTAINERS                       |   1 +
>  drivers/iio/frequency/Kconfig     |  10 +
>  drivers/iio/frequency/Makefile    |   1 +
>  drivers/iio/frequency/admfm2000.c | 310 ++++++++++++++++++++++++++++++
>  4 files changed, 322 insertions(+)
>  create mode 100644 drivers/iio/frequency/admfm2000.c
> 
..

> +
> +static int admfm2000_mode(struct iio_dev *indio_dev, u32 reg, u32 mode)
> +{
> +	struct admfm2000_state *st = iio_priv(indio_dev);
> +	DECLARE_BITMAP(values, 2);
> +
> +	switch (mode) {
> +	case ADMFM2000_MIXER_MODE:
> +		values[0] = (reg == 0) ? 1 : 2;
> +		gpiod_set_array_value_cansleep(st->sw_ch[reg]->ndescs,
> +					       st->sw_ch[reg]->desc,
> +					       NULL, values);
> +		break;
> +	case ADMFM2000_DIRECT_IF_MODE:
> +		values[0] = (reg == 0) ? 2 : 1;
> +		gpiod_set_array_value_cansleep(st->sw_ch[reg]->ndescs,
> +					       st->sw_ch[reg]->desc,
> +					       NULL, values);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

I'd return in the good paths above as nothing useful to do down here.

> +}

> +
> +static int admfm2000_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct admfm2000_state *st = iio_priv(indio_dev);
> +	int gain, ret;
> +
> +	if (val < 0)
> +		gain = (val * 1000) - (val2 / 1000);
> +	else
> +		gain = (val * 1000) + (val2 / 1000);
> +
> +	if (gain > ADMF20000_MAX_GAIN || gain < ADMF20000_MIN_GAIN)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		mutex_lock(&st->lock);
guard(mutex)(&st->lock); 
would tidy this up a tiny bit by allow a direct return.
You will need to add {} around the whole case statement though.

> +		st->gain[chan->channel] = ~((abs(gain) / 1000) & 0x1F);
> +
> +		ret = admfm2000_attenuation(indio_dev, chan->channel,
> +					    st->gain[chan->channel]);
> +
> +		mutex_unlock(&st->lock);
> +		if (ret)
> +			return ret;
return here.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

...

> +static int admfm2000_channel_config(struct admfm2000_state *st,
> +				    struct iio_dev *indio_dev)
> +{
> +	struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct fwnode_handle *child;
> +	u32 reg, mode;
> +	int ret;
> +
> +	device_for_each_child_node(dev, child) {

If the below handling of gpios suggestion works, that would become per channel
and move in here.

> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get reg property\n");
> +		}
> +
> +		if (reg >= indio_dev->num_channels) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL, "reg bigger than: %d\n",
> +					     indio_dev->num_channels);
> +		}
> +
> +		ret = fwnode_property_read_u32(child, "adi,mode", &mode);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get mode property\n");
> +		}
> +
> +		if (mode >= 2) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL, "mode bigger than: 1\n");
> +		}
> +
> +		ret = admfm2000_mode(indio_dev, reg, mode);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int admfm2000_setup(struct admfm2000_state *st,
> +			   struct iio_dev *indio_dev)
> +{
> +	struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +
Looking at this and considering if we can move the description into the channel
child fwnodes of the main one, the interfaces exposed are a bit limited, but I think
we can do it with devm_fwnode_gpiod_get_index() or potentially adding similar for
the array forms.


> +	st->sw_ch[0] = devm_gpiod_get_array(dev, "switch1", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->sw_ch[0]))
> +		return dev_err_probe(dev, PTR_ERR(st->sw_ch[0]),
> +				     "Failed to get gpios\n");
> +
> +	if (st->sw_ch[0]->ndescs != ADMF20000_MODE_GPIOS) {
> +		dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +			      ADMF20000_MODE_GPIOS);
> +		return -ENODEV;
> +	}
> +
> +	st->sw_ch[1] = devm_gpiod_get_array(dev, "switch2", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->sw_ch[1]))
> +		return dev_err_probe(dev, PTR_ERR(st->sw_ch[1]),
> +				     "Failed to get gpios\n");
> +
> +	if (st->sw_ch[1]->ndescs != ADMF20000_MODE_GPIOS) {
> +		dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +			      ADMF20000_MODE_GPIOS);
> +		return -ENODEV;
> +	}
> +
> +	st->dsa_gpios[0] = devm_gpiod_get_array(dev, "attenuation1",
> +						GPIOD_OUT_LOW);
> +	if (IS_ERR(st->dsa_gpios[0]))
> +		return dev_err_probe(dev, PTR_ERR(st->dsa_gpios[0]),
> +				     "Failed to get gpios\n");
> +
> +	if (st->dsa_gpios[0]->ndescs != ADMF20000_DSA_GPIOS) {
> +		dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +			      ADMF20000_DSA_GPIOS);
> +		return -ENODEV;
> +	}
> +
> +	st->dsa_gpios[1] = devm_gpiod_get_array(dev, "attenuation2",
> +						GPIOD_OUT_LOW);
> +	if (IS_ERR(st->dsa_gpios[1]))
> +		return dev_err_probe(dev, PTR_ERR(st->dsa_gpios[1]),
> +				     "Failed to get gpios\n");
> +
> +	if (st->dsa_gpios[1]->ndescs != ADMF20000_DSA_GPIOS) {
> +		dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +			      ADMF20000_DSA_GPIOS);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

