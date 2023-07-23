Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1BD75E19F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 13:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGWLlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 07:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 07:41:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8AE7C;
        Sun, 23 Jul 2023 04:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0794E60C8A;
        Sun, 23 Jul 2023 11:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB2EC433CA;
        Sun, 23 Jul 2023 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690112465;
        bh=2xZmH+f+Ch2BTpaNHy+rrxOknCARivtnWq6wDFk29PQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jdHd657IHu+pJ9ZGlFoYFs9f3AD7tfzRzQJsaH+mgbusy2mpy1UUrZnZ0erZc0HXU
         q9xf2CfFTQAY/nbp9B/CHZrtWH5u44hqBGSoShYPtT67OcOMOmEN9GzOgf5CCN0cad
         JR7FPlc+BRy6QIpUT3dIFdpmKkX0YqFIWTefqEf08XyyW+qN8R8Gk8w7o01GH9ss/5
         0D+nOyVAx8Pe/7LftoOJ6pT8sMraHN0Vtgu4V8g8dX+tTJMZtyft9Jef5rYQqkKGuH
         hqQzdZ5QrTZeFGZxCBydUXSfeDHIYdbCzdVOxe9XuVP3Nh1kB2lJMP3huUYo2xf7MA
         vu88ioH6g4Mng==
Date:   Sun, 23 Jul 2023 12:41:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Collamati <andrea.collamati@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: add MCP4728 I2C DAC driver
Message-ID: <20230723124101.1af2ae2c@jic23-huawei>
In-Reply-To: <739ea3c7-7181-183c-799d-a3f9403c7f66@gmail.com>
References: <cover.1689857295.git.andrea.collamati@gmail.com>
        <3d08130fcb093fea3f755848690db9b2c8e1cb75.1689857295.git.andrea.collamati@gmail.com>
        <20230720201311.0142db3d@jic23-huawei>
        <739ea3c7-7181-183c-799d-a3f9403c7f66@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2023 07:09:11 +0200
Andrea Collamati <andrea.collamati@gmail.com> wrote:

> Hi Jonathan,
>=20
> On 7/20/23 21:13, Jonathan Cameron wrote:
> >> +static const char *const mcp4728_vref_modes[] =3D {
> >> +	"vdd_ext",
> >> +	"internal",
> >> +};
> >> +
> >> +static int mcp4728_get_vref_mode(struct iio_dev *indio_dev,
> >> +				 const struct iio_chan_spec *chan)
> >> +{
> >> +	struct mcp4728_data *data =3D iio_priv(indio_dev);
> >> +
> >> +	return data->channel_data[chan->channel].ref_mode;
> >> +}
> >> +
> >> +static int mcp4728_set_vref_mode(struct iio_dev *indio_dev,
> >> +				 const struct iio_chan_spec *chan,
> >> +				 unsigned int mode)
> >> +{
> >> +	struct mcp4728_data *data =3D iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	data->channel_data[chan->channel].ref_mode =3D mode;
> >> +
> >> +	if (mode =3D=3D MCP4728_VREF_EXTERNAL_VDD &&
> >> +	    data->channel_data[chan->channel].g_mode =3D=3D MCP4728_GAIN_X2)=
 {
> >> +		dev_warn(&data->client->dev,
> >> +			 "CH%d: Gain x2 not effective when vref is vdd, force to x1",
> >> +			 chan->channel); =20
> > Even better if you don't present the option at all and wrap it up in the
> > standard ABI of _scale
> > =20
> I think that the solution could be:
>=20
> - Removing custom ABI (vref/gain)
>=20
> - Initialize them at device tree level using two 4-elements arrays.

If doing with device tree, they should reflect something that is a characte=
ristic
of how the chips is wired up.  So you would need to explain why that is the=
 case here.

However, I'm still not understanding why _SCALE is not appropriate here.  W=
e have
a small set of options with well defined scales.

>=20
> - Finally using the same approach of https://github.com/torvalds/linux/bl=
ob/c2782531397f5cb19ca3f8f9c17727f1cdf5bee8/drivers/iio/dac/mcp4725.c#L462 =
where after having=C2=A0 synced current parameters stored in EEPROM they ar=
e updated with the ones specified in dts.
>=20
=46rom a quick look those are not coming from DTS and are not in the dt-bindi=
ng for that
device. The parameters only come from legacy platform data (or the wild wes=
t of early IIO).

Only the presence of vref and whether to buffer it are in DT binding
https://elixir.bootlin.com/linux/latest/source/drivers/iio/dac/mcp4725.c#L3=
73

We should probably rip the remaining platform data based probe paths out of=
 drivers
sometime soon. No one uses them any more (there are better paths even if pe=
ople are
using non DT based board files) and they can mislead because the rules were=
n't
as tight as they are for what goes in a DT binding.

Jonathan


>=20
> Best regards
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Andrea
>=20
>=20

