Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0837E27DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjKFO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKFO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:58:38 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5674DA4;
        Mon,  6 Nov 2023 06:58:33 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A71C40015;
        Mon,  6 Nov 2023 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699282711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ivpJSuGY4bSyBLV57NC7HA0MvTDqIRRzvqXn3ZSpC70=;
        b=VHdOuGRkOd7jg0jknuL8rYuwUTtIp8tREWQktA5NbOAqvfEGVg2twj2PQWkxUCWOIDFfFS
        +o+PfrchdcMzJfsJpFv1KLH+JMZEzwqHgsMejBgUd7hrZ2kypegkniJoMTylF8RhewjtjY
        U19S4YR2a7TxK0qOBBxOkuuRxLNIYkdwmAtvoZoXkEDuSaxdBpeInKtXycM3ZG/sxr+C5z
        SO6xcy/KgQGD8iw+nIvN2ZyzlSrUB2n9V+srLsmnsK9kL/DhaAIhFk0897aqk6FTZiA4Zh
        bY0gBa80FwA2p8GN+Lj8g2hyaIHqE/VsuXBqxEGIljhmGswL1BbAdyMjUA8hhQ==
Date:   Mon, 6 Nov 2023 15:58:29 +0100
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH v7 3/3] media: i2c: Introduce a driver for the Techwell
 TW9900 decoder
Message-ID: <ZUj/FQTyajQJrxoU@pc-70.home>
References: <cover.1697463708.git.mehdi.djait@bootlin.com>
 <c3cd9002b2db69a6fb155722adc8410cd6e1f9ab.1697463708.git.mehdi.djait@bootlin.com>
 <ZUNz_h1fn9RH9Uc5@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUNz_h1fn9RH9Uc5@aptenodytes>
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

thank you for the review!

On Thu, Nov 02, 2023 at 11:03:42AM +0100, Paul Kocialkowski wrote:
> > +static int tw9900_write_reg(struct i2c_client *client, u8 reg, u8 val)
> > +{
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, reg, val);
> 
> Is this an SMBUS device in particular? Or is there any reason to use the SMBUS
> API instead of the general I2C API?
> 

I think I will keep using the SMBUS API here. The reason is in the
kernel documentation:

--------------------------------------------------------------------------------
If you write a driver for some I2C device, please try to use the SMBus commands 
if at all possible (if the device uses only that subset of the I2C protocol). 
This makes it possible to use the device driver on both SMBus adapters and I2C 
adapters (the SMBus command set is automatically translated to I2C on I2C 
adapters, but plain I2C commands can not be handled at all on most pure SMBus 
adapters).
--------------------------------------------------------------------------------

And the vast majority of the drivers under /media/i2c are using the
SMBUS API.

> > +static void tw9900_fill_fmt(const struct tw9900_mode *mode,
> > +			    struct v4l2_mbus_framefmt *fmt)
> > +{
> > +	fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
> > +	fmt->width = mode->width;
> > +	fmt->height = mode->height;
> > +	fmt->field = V4L2_FIELD_NONE;
> > +	fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
> > +	fmt->colorspace = V4L2_COLORSPACE_SMPTE170M;
> > +	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SMPTE170M);
> > +	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SMPTE170M);
> > +}
> > +
> > +static int tw9900_cfg_fmt(struct v4l2_subdev *sd,
> 
> You might have to differentiate between set_fmt/get_fmt to return -EBUSY
> if streaming is on in set_fmt. However I understand it will just copy the
> current mode in both cases, but this might still be required to follow v4l2
> semantics (please double-check).
> 

This should be done in the driver calling the pad subdev_call set_fmt,
right ?

--
Kind Regards
Mehdi Djait
