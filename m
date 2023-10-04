Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050AD7B785F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbjJDHHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbjJDHHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:07:46 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF736AF;
        Wed,  4 Oct 2023 00:07:41 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id A177F168B;
        Wed,  4 Oct 2023 09:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1696403259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MH9KWBMgqso6+BwvpRM3ahjbzr5vwavoxYlNVWr5Dc8=;
        b=iqqByt9hnspznEXEbnUfOCTYhmqOBL2lCq3CqX35EOyzDHT8b8leJ1v/g0KOLRCwbtGpX3
        9cIcLj7+StsfSTWJoaBTyMJoJPQQQymh3rWFKdpGwDDurZ2+/BNPRxhu/PF53uDmU0fvj6
        4EHEi1WQPhn8ys6/Q4BpjX1foGRS2Ldg6TYo9FpwhZO9HVF38vwuLku/jCM2SbYINO68gA
        Tp8wmXxxLGfxjI4EBgYRD1vAurwKLJEWXGfvm96UeJN7Rwnpd5bEu0w4x+sE8mGXDjMNao
        yHjQZHTM7rQbgT1FQ5vwKPEgDhGePEspM54gQT6SLQb/CjTOvBUNZF/LMEJPrw==
MIME-Version: 1.0
Date:   Wed, 04 Oct 2023 09:07:39 +0200
From:   Michael Walle <michael@walle.cc>
To:     Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     mitrutzceclan@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        andy@kernel.org, linux-gpio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add AD7173 driver
In-Reply-To: <20230928125443.615006-2-mitrutzceclan@gmail.com>
References: <20230928125443.615006-1-mitrutzceclan@gmail.com>
 <20230928125443.615006-2-mitrutzceclan@gmail.com>
Message-ID: <cc64b68545b4e178e1f5d90109f72e9a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just had a look at the gpio-regmap part.

> +static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int 
> base,
> +			     unsigned int offset, unsigned int *reg,
> +			     unsigned int *mask)
> +{
> +	*mask = AD7173_GPO_DATA(offset);
> +	*reg = AD7173_REG_GPIO;

*reg = base;

See also below.

> +	return 0;
> +}
> +
> +static int ad7173_gpio_init(struct iio_dev *indio_dev)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct gpio_regmap_config gpio_regmap = {};
> +	struct device *dev = &st->sd.spi->dev;
> +	unsigned int mask;
> +
> +	st->regmap = devm_regmap_init_spi(st->sd.spi, &ad7173_regmap_config);
> +	if (IS_ERR(st->regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Unable to init regmap\n");
> +	}
> +
> +	mask = AD7173_GPIO_OP_EN0 | AD7173_GPIO_OP_EN1 | 
> AD7173_GPIO_OP_EN2_3;
> +	regmap_update_bits(st->regmap, AD7173_REG_GPIO, mask, mask);
> +
> +	gpio_regmap.parent = dev;
> +	gpio_regmap.regmap = st->regmap;
> +	gpio_regmap.ngpio = st->info->num_gpios;
> +	gpio_regmap.reg_set_base = GPIO_REGMAP_ADDR_ZERO;

Why don't you set it to AD7173_REG_GPIO? Register 0 seems wrong, it
looks like you're using that to say this is a output-only I/O.


> +	gpio_regmap.reg_mask_xlate = ad7173_mask_xlate;
> +
> +	st->gpio_regmap = devm_gpio_regmap_register(dev, &gpio_regmap);
> +	if (IS_ERR(st->gpio_regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_regmap),
> +				     "Unable to init gpio-regmap\n");
> +	}
> +
> +	return 0;
> +}
> +
> +#endif /* CONFIG_GPIOLIB */

Otherwise looks good. But I've noticed that the chip can actually
also do input on gpio0 and gpio1. If you ever want to support that,
it seems like you need two gpio-regmaps.

-michael
