Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3FC77116D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjHES3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHES3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:29:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F2B7;
        Sat,  5 Aug 2023 11:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D9F560DEB;
        Sat,  5 Aug 2023 18:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F56C433C7;
        Sat,  5 Aug 2023 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691260146;
        bh=JBI9wEFgEqZ+ZNjqqddLnr0kDMNZ61yJ9TwZMzWMoSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tRGExrGhmdgQruMQApR4bXKOOKv9SxZn7yny0wyDVDpeJsyWdpU0XXlGboYuTZXSN
         s9iHd+G+xC+p4VbLM6ei89LPm4h/muFzwjBQsbrkZuTqo/gvAGwZNLXGJnPkRKW9WI
         nB2VpY3yLRqonuxJU2et4lWpSv1CyBvhJv85qe/E7eyPHjA7vHtnTkvMSGzJ7EPwbD
         73qL843pm508NDkquOzkBOWCPLAUsw489g2c/ebGIiTU3cyn/6C9fDht2Id7AQ2rQ1
         0SQSZuBr2igPwhrXmvV0zMITeg57g6Ys5PM0b9KNEtF+MN6Ba76et/rRU7Ods8f08I
         YOtgnXgmFZW/Q==
Date:   Sat, 5 Aug 2023 19:28:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Collamati <andrea.collamati@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: add MCP4728 I2C DAC driver
Message-ID: <20230805192859.116421bc@jic23-huawei>
In-Reply-To: <a0933003ed3c855f9d80d6ce0a40add2b6f0ba36.1691066050.git.andrea.collamati@gmail.com>
References: <cover.1691066050.git.andrea.collamati@gmail.com>
        <a0933003ed3c855f9d80d6ce0a40add2b6f0ba36.1691066050.git.andrea.collamati@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Aug 2023 14:56:35 +0200
Andrea Collamati <andrea.collamati@gmail.com> wrote:

> MCP4728 is a 12-bit quad channel DAC with I2C interface.
> 
> support for:
>  * per-channel gain
>  * per-channel power state
>  * per-channel power down mode control
>  * per-channel vref selection internal/vdd
>  * store current state to on-chip EEPROM
> 
> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
Hi Andrea,

On this final read through I noticed a few minor things. Rather than
get you to do a v5 I've made the changes whilst applying. Please
take a sanity check at
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing
to make sure I didn't break anything and let me know if I did!

Applied with the below mentioned changes to the togreg branch of iio.git
which is initially pushed out as testing to let 0-day poke at it and see
if it can find any problems.

Thanks,

Jonathan

> diff --git a/drivers/iio/dac/mcp4728.c b/drivers/iio/dac/mcp4728.c
> new file mode 100644
> index 000000000000..ba3eab349b0a
> --- /dev/null
> +++ b/drivers/iio/dac/mcp4728.c
> @@ -0,0 +1,626 @@
...



> +
> +static int mcp4728_set_scale(int channel, struct mcp4728_data *data, int val,
> +			     int val2)
> +{
> +	int scale = mcp4728_find_matching_scale(data, val, val2);
> +
> +	if (scale < 0)
> +		return scale;
> +
> +	switch (scale) {
> +	case MCP4728_SCALE_VDD:
> +		data->chdata[channel].ref_mode = MCP4728_VREF_EXTERNAL_VDD;
> +		break;
> +	case MCP4728_SCALE_VINT_NO_GAIN:
> +		data->chdata[channel].ref_mode = MCP4728_VREF_INTERNAL_2048mV;
> +		data->chdata[channel].g_mode   = MCP4728_GAIN_X1;
> +		break;
> +	case MCP4728_SCALE_VINT_GAIN_X2:
> +		data->chdata[channel].ref_mode = MCP4728_VREF_INTERNAL_2048mV;
> +		data->chdata[channel].g_mode   = MCP4728_GAIN_X2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;

return instead of breaking above as nothing to be done after the switch.
Side effect of that is this return 0 not needed.

> +}

...

> +static int mcp4728_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct mcp4728_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val > GENMASK(MCP4728_RESOLUTION - 1, 0))
> +			return -EINVAL;
> +		data->chdata[chan->channel].dac_value = val;
> +		ret = mcp4728_program_channel_cfg(chan->channel, indio_dev);
> +		break;

Direct returns preferred if no cleanup to do.

> +	case IIO_CHAN_INFO_SCALE:
> +		ret = mcp4728_set_scale(chan->channel, data, val, val2);
> +		if (ret)
> +			break;
> +
> +		ret = mcp4728_program_channel_cfg(chan->channel, indio_dev);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}



> +static int mcp4728_init_channels_data(struct mcp4728_data *data)
> +{
> +	u8 inbuf[MCP4728_READ_RESPONSE_LEN];
> +	int ret;
> +	unsigned int i;
> +
> +	ret = i2c_master_recv(data->client, inbuf, MCP4728_READ_RESPONSE_LEN);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"failed to read mcp4728 conf. Err=%d\n", ret);
> +		return ret;

As this is only called from probe, we should still use dev_err_probe() in here
as mentioned below.


> +	} else if (ret != MCP4728_READ_RESPONSE_LEN) {
> +		dev_err(&data->client->dev,
> +			"failed to read mcp4728 conf. Wrong Response Len ret=%d\n",
> +			ret);
> +		return -EIO;
> +	}
> +
> +	for (i = 0; i < MCP4728_N_CHANNELS; i++) {
> +		struct mcp4728_channel_data *ch = &data->chdata[i];
> +		u8 r2				= inbuf[i * 6 + 1];
> +		u8 r3				= inbuf[i * 6 + 2];
> +
> +		ch->dac_value = FIELD_GET(MCP4728_DAC_H_MASK, r2) << 8 |
> +				FIELD_GET(MCP4728_DAC_L_MASK, r3);
> +		ch->ref_mode = FIELD_GET(MCP4728_VREF_MASK, r2);
> +		ch->pd_mode  = FIELD_GET(MCP4728_PDMODE_MASK, r2);
> +		ch->g_mode   = FIELD_GET(MCP4728_GAIN_MASK, r2);
> +	}
> +
> +	return 0;
> +}

...

> +static int mcp4728_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	struct mcp4728_data *data;
> +	struct iio_dev *indio_dev;
> +	int err;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_reg))
> +		return PTR_ERR(data->vdd_reg);
> +
> +	err = regulator_enable(data->vdd_reg);
> +	if (err)
> +		return err;
> +
> +	err = devm_add_action_or_reset(&client->dev, mcp4728_reg_disable,
> +				       data->vdd_reg);
> +	if (err)
> +		return err;
> +
> +	/* MCP4728 has internal EEPROM that save each channel boot configuration.

Trivial but comment syntax in IIO (there are some differences in a few other subsystems)
is
	/*
	 * MCP...

> +	 * It means that device configuration is unknown to the driver at kernel boot.
> +	 * mcp4728_init_channels_data reads back DAC settings and stores them in data
> +	 * structure.
> +	 */
> +	err = mcp4728_init_channels_data(data);
> +	if (err) {

I'd missed this previously but dev_err_probe() has several advantages in that
it handles deferring neatly and also ends up with less code.

> +		dev_err(&client->dev,
> +			"failed to read mcp4728 current configuration\n");
> +		return err;
> +	}
> +
> +	err = mcp4728_init_scales_avail(data);
> +	if (err) {
> +		dev_err(&client->dev, "failed to init scales\n");
> +		return err;
> +	}
> +
> +	indio_dev->name		= id->name;
> +	indio_dev->info		= &mcp4728_info;
> +	indio_dev->channels	= mcp4728_channels;
> +	indio_dev->num_channels = MCP4728_N_CHANNELS;
> +	indio_dev->modes	= INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

