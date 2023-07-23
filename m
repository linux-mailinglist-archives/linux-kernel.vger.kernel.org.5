Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57F75E1F0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGWMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9CE54;
        Sun, 23 Jul 2023 05:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FD0760CFA;
        Sun, 23 Jul 2023 12:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ECAC433C7;
        Sun, 23 Jul 2023 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690116446;
        bh=vom/MdLbeAAtjonsKG+U94PwQKGKIWz91c/Gxmed8fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H1INqRAYk72xLX1ZxaKxDaKsVxzzMHnOQvE7C3A2CALGMsvyEKlQWWwXZMm8cL5tp
         KrOST1seFIJkJ/TcBNTSIAQC7iz6tIpAmiPge0EN5UWGWTOe1g52aJuUDVsHSG3F+h
         Z/8mVjw21Demu1YrWEtLnyqPNX0lcjNFrSW8YsG5nvK0WNqT7AvkKtwqKM/2XivCbP
         oEJwAGKDFlBLnP6+cEYUo6GFQiwpPBO4iIAtzSTSb25UXPhKRVCilSribaaUGv7vqR
         SJdNFo6A226XBaFub6z6EOJ6q8bkQZ9xvaXls3/iOEc7Xf8pQs4q6bzXzVqfbdTG3z
         tRnIUCkP+cfbA==
Date:   Sun, 23 Jul 2023 13:47:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Collamati <andrea.collamati@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: add MCP4728 I2C DAC driver
Message-ID: <20230723134721.1404d533@jic23-huawei>
In-Reply-To: <15ee98bd-b92b-8a34-e3f9-a1537edf2da9@gmail.com>
References: <cover.1689857295.git.andrea.collamati@gmail.com>
        <3d08130fcb093fea3f755848690db9b2c8e1cb75.1689857295.git.andrea.collamati@gmail.com>
        <20230720201311.0142db3d@jic23-huawei>
        <739ea3c7-7181-183c-799d-a3f9403c7f66@gmail.com>
        <20230723124101.1af2ae2c@jic23-huawei>
        <15ee98bd-b92b-8a34-e3f9-a1537edf2da9@gmail.com>
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

On Sun, 23 Jul 2023 14:15:10 +0200
Andrea Collamati <andrea.collamati@gmail.com> wrote:

> On 7/23/23 13:41, Jonathan Cameron wrote:
> >>>> +
> >>>> +	if (mode =3D=3D MCP4728_VREF_EXTERNAL_VDD &&
> >>>> +	    data->channel_data[chan->channel].g_mode =3D=3D MCP4728_GAIN_X=
2) {
> >>>> +		dev_warn(&data->client->dev,
> >>>> +			 "CH%d: Gain x2 not effective when vref is vdd, force to x1",
> >>>> +			 chan->channel);   =20
> >>> Even better if you don't present the option at all and wrap it up in =
the
> >>> standard ABI of _scale
> >>>   =20
> >> I think that the solution could be:
> >>
> >> - Removing custom ABI (vref/gain)
> >>
> >> - Initialize them at device tree level using two 4-elements arrays. =20
> > If doing with device tree, they should reflect something that is a char=
acteristic
> > of how the chips is wired up.  So you would need to explain why that is=
 the case here.
> >
> > However, I'm still not understanding why _SCALE is not appropriate here=
.  We have
> > a small set of options with well defined scales. =20
>=20
> SCALE is appropriate. I didn't know that scale_available was a standard A=
BI.
>=20
> I will follow=C2=A0 the implementation done n https://github.com/torvalds=
/linux/blob/c2782531397f5cb19ca3f8f9c17727f1cdf5bee8/drivers/iio/dac/ad5592=
r-base.c#L487

That's long out of date wrt to best practice.  Instead follow.
drivers/iio/dac/ad7293.c or any of the other drivers that set
.info_mask_shared_by_*_available =3D BIT(IIO_CHAN_INFO_SCALE)
and provide the read_avail() callback.

The advantage that brings is that consumer drivers can then
access this information much more simply.

One day we will hopefully finish converting old drivers over to
newer interfaces, but it's slow progress!

Jonathan

