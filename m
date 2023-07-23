Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C891275E19C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGWLeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 07:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGWLeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 07:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A1E6F;
        Sun, 23 Jul 2023 04:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAB5260C88;
        Sun, 23 Jul 2023 11:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBF9C433CB;
        Sun, 23 Jul 2023 11:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690112050;
        bh=Xdo8uNS5Diyssz4mW9iTsjMkbk0+m5+x0fHZx2zvyMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qw4maAFdyEZPxS99DWzigweME8+V3nbdNP7rInoTnrOnumqG6Vn/MzGLT6bzmhL/g
         UisfNtkkMhBMd9bcm480owB5ELaoVverlLmy/Il/fighYJM2IE/juAjqGF+6fY4P4e
         avlFleObIJMa+NMA8QFe2gGCq6XrSppRQL+Msa+XWORT8EBQKKi2t5tZIxpgpGoCTG
         qLcshJ7jUxIQASpK4rRhtdSFq4sCOT38kC3DPcE01BDZP7ropQF6hVKOWWseyUzxwt
         kyw60jc6b2p513jDDswYx5lF8tQ1PedE7Z3GDnMmSdpuHmh0Q3BfbXxK/l270YVQNl
         mG+IVRijuNniA==
Date:   Sun, 23 Jul 2023 12:34:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Collamati <andrea.collamati@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: add MCP4728 I2C DAC driver
Message-ID: <20230723123408.5d0078a6@jic23-huawei>
In-Reply-To: <a95bdc44-68e6-8d31-0c8a-24b83fb4c613@gmail.com>
References: <cover.1689857295.git.andrea.collamati@gmail.com>
        <3d08130fcb093fea3f755848690db9b2c8e1cb75.1689857295.git.andrea.collamati@gmail.com>
        <20230720201311.0142db3d@jic23-huawei>
        <a95bdc44-68e6-8d31-0c8a-24b83fb4c613@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 21:47:37 +0200
Andrea Collamati <andrea.collamati@gmail.com> wrote:

> Hi Jonathan,
>=20
> thank you for your first review.
>=20
> See below.
>=20
> On 7/20/23 21:13, Jonathan Cameron wrote:
>=20
> >> +
> >> +	outbuf[1] =3D ch->ref_mode << MCP4728_CMD_VREF_POS;
> >> +
> >> +	if (data->powerdown) {
> >> +		u8 mcp4728_pd_mode =3D ch->pd_mode + 1;
> >> +
> >> +		outbuf[1] |=3D mcp4728_pd_mode << MCP4728_CMD_PDMODE_POS;
> >> +	}
> >> +
> >> +	outbuf[1] |=3D ch->g_mode << MCP4728_CMD_GAIN_POS; =20
> > FIELD_PREP()
> > =20
> >> +	outbuf[1] |=3D ch->dac_value >> 8;
> >> +	outbuf[2] =3D ch->dac_value & 0xff; =20
> > put_unaligned_be16()
> > =20
> outbuf[1] contains other data (gain mode, powerdown=C2=A0 mode, etc) in a=
ddition to dac value. Using put_unaligned_be16 will probably reset them.

Ah. I'd missed the |=3D because you then didn't mask the dac_value.

>=20
> Something like this could be the solution?
>=20
> #defineMCP4728_DAC_H_FIELD GENMASK(3, 0)
>=20
> #defineMCP4728_DAC_L_FIELD GENMASK(7, 0)

Call them _MASK or _MSK rather than field.
I think that is much more common naming.

>=20
> ...
>=20
> outbuf[1] |=3D FIELD_PREP(MCP4728_DAC_H_FIELD, ch->dac_value>> 8);
>=20
> outbuf[2] =3D FIELD_PREP(MCP4728_DAC_L_FIELD, ch->dac_value);

That's better.

>=20
>=20
> >> +		return 0;
> >> +}
> >> +
> >> +// powerdown mode
> >> +static const char *const mcp4728_powerdown_modes[] =3D { "1kohm_to_gn=
d",
> >> +						       "100kohm_to_gnd",
> >> +						       "500kohm_to_gnd" };
> >> +
> >> +static int mcp4728_get_powerdown_mode(struct iio_dev *indio_dev,
> >> +				      const struct iio_chan_spec *chan)
> >> +{
> >> +	struct mcp4728_data *data =3D iio_priv(indio_dev);
> >> +
> >> +	return data->channel_data[chan->channel].pd_mode;
> >> +}
> >> +
> >> +static int mcp4728_set_powerdown_mode(struct iio_dev *indio_dev,
> >> +				      const struct iio_chan_spec *chan,
> >> +				      unsigned int mode)
> >> +{
> >> +	struct mcp4728_data *data =3D iio_priv(indio_dev);
> >> +
> >> +	data->channel_data[chan->channel].pd_mode =3D mode;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static ssize_t mcp4728_read_powerdown(struct iio_dev *indio_dev,
> >> +				      uintptr_t private,
> >> +				      const struct iio_chan_spec *chan,
> >> +				      char *buf)
> >> +{
> >> +	struct mcp4728_data *data =3D iio_priv(indio_dev);
> >> +
> >> +	return sysfs_emit(buf, "%d\n", data->powerdown);
> >> +}
> >> +
> >> +static ssize_t mcp4728_write_powerdown(struct iio_dev *indio_dev,
> >> +				       uintptr_t private,
> >> +				       const struct iio_chan_spec *chan,
> >> +				       const char *buf, size_t len)
> >> +{
> >> +	struct mcp4728_data *data =3D iio_priv(indio_dev);
> >> +	bool state;
> >> +	int ret;
> >> +
> >> +	ret =3D kstrtobool(buf, &state);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (state)
> >> +		ret =3D mcp4728_suspend(&data->client->dev);
> >> +	else
> >> +		ret =3D mcp4728_resume(&data->client->dev);
> >> +
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	return len; =20
> > Don't support custom powering down. If this is needed it should be
> > using the existing power management flows. =20
>=20
> Could you explain better? I have extended customized powering down becaus=
e I took as reference=C2=A0 the driver mcp4725.c and=C2=A0 I extended to mu=
ltichannel.
>=20
> How should I change it?

Ok. I'd missed that we had an existing driver doing this and indeed
we have documented it.  Fair enough - I must have been persuaded in the past
and then forgotten about it :)


>=20
> > Might have been more interesting if it were per channel, but it's not.
> > (and I have no idea off the top of my head on how we would deal with it
> > if it were per channel). =20
>=20
> MCP4728 can handle power down per channel...
>=20
> There are two bits per each channel the could be
>=20
> 00 =3D> No Power Down
>=20
> 01 =3D> 1kohm_to_gnd
>=20
> 10 =3D> 100kohm_to_gnd
>=20
> 11 =3D> 500kohm_to_gnd
>=20

Ok.  Good to support that rather than a full power down.

> > =20
> >> +				mcp4728_resume);
> >> +
> >> +static int mcp4728_init_channels_data(struct mcp4728_data *data)
> >> +{
> >> +	u8 inbuf[MCP4728_READ_RESPONSE_LEN];
> >> +	int ret;
> >> +	unsigned int i;
> >> +
> >> +	ret =3D i2c_master_recv(data->client, inbuf, MCP4728_READ_RESPONSE_L=
EN);
> >> +	if (ret < 0) {
> >> +		dev_err(&data->client->dev,
> >> +			"failed to read mcp4728 conf. Err=3D%d\n", ret);
> >> +		return ret;
> >> +	} else if (ret !=3D MCP4728_READ_RESPONSE_LEN) {
> >> +		dev_err(&data->client->dev,
> >> +			"failed to read mcp4728 conf. Wrong Response Len ret=3D%d\n",
> >> +			ret);
> >> +		return -EIO;
> >> +	}
> >> +
> >> +	for (i =3D 0; i < MCP4728_N_CHANNELS; i++) { =20
> > Unusual to read back existing values from the device rather than resett=
ing it into a clean
> > state. What is your reasoning? =20
>=20
> MCP4728 has an EEPROM memory.
>=20
> Under the reset conditions, the device uploads the
> EEPROM data into both of the DAC input and output
> registers simultaneously.
>=20
> My reasoning was that the driver syncs with device at probe time and let =
the user change each channel parameters via iio_chan_spec_ext_info.

Ok - this is fine if it's reading back from EEPROM.
Please add a comment on that though because as demonstrated above
I'm forgetful and may wonder why it was done like this in the future.

Jonathan


>=20
>=20
> Thank you again.
>=20
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Andrea
>=20
>=20

