Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CDC7E5A98
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjKHP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjKHP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:57:06 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2AD9C;
        Wed,  8 Nov 2023 07:57:03 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81AB82000B;
        Wed,  8 Nov 2023 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699459022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lHXBl5GzOkQJlYFz/o6gC1KSlh7snY9Q9gjR1xg7Qs=;
        b=hQzaRRNp09CxA/nhsZ+lZnrN1/d1UWND2RnguWmH1pn3bicGDogWWuurNxT3IlMz1Hr3CW
        B26QZJue/gDXbX+BspQiFxTT/iQdByTemeKyPJI4KbViOCIh97zJcpcnVDzlunLgx58jGj
        +RMHf30vcncC5ul883ElnnfCM75CwbkQJpBGTvn4yP+wc3Z/0HlNPvKO9JT4NsoBrM+8dI
        aSmjjp4QMdyIB1SrQll+WJzG0xuPuH9Jx+Is8zuCBxRT9RX+u77kjMpHaG7Q75wn9rwJDL
        ghI3tyiVGukSaVDo9cd78GD7jN/rxQap8g2vRbDV5dc8VPRAi18SYGYqkWPd1g==
Date:   Wed, 8 Nov 2023 16:56:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 5/6] mtd: rawnand: gpio: Support standard nand width
Message-ID: <20231108165659.2465ed7c@xps-13>
In-Reply-To: <20231108-fix-mips-nand-v1-5-5fc5586d04de@linaro.org>
References: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
        <20231108-fix-mips-nand-v1-5-5fc5586d04de@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

linus.walleij@linaro.org wrote on Wed, 08 Nov 2023 15:33:53 +0100:

> The standard property for describing the band width of a NAND
> memory is "nand-bus-width" not "bank-width". The new bindings
> support both so make Linux check both in priority order.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/nand/raw/gpio.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
> index 5553101c709c..d5bd245b0c0d 100644
> --- a/drivers/mtd/nand/raw/gpio.c
> +++ b/drivers/mtd/nand/raw/gpio.c
> @@ -183,7 +183,15 @@ static int gpio_nand_get_config(struct device *dev,
>  {
>  	u32 val;
> =20
> -	if (!device_property_read_u32(dev, "bank-width", &val)) {
> +	/* The preferred binding takes precedence */
> +	if (!device_property_read_u32(dev, "nand-bus-width", &val)) {
> +		if (val =3D=3D 16) {
> +			chip->options |=3D NAND_BUSWIDTH_16;
> +		} else if (val !=3D 8) {
> +			dev_err(dev, "invalid nand-bus-width %u\n", val);
> +			return -EINVAL;
> +		}
> +	} else if (!device_property_read_u32(dev, "bank-width", &val)) {
>  		if (val =3D=3D 2) {
>  			chip->options |=3D NAND_BUSWIDTH_16;
>  		} else if (val !=3D 1) {
>=20

I'm not sure this is actually needed. I believe of_get_nand_bus_width
is already called (nand_scan_ident -> rawnand_dt_init) and will set the
NAND_BUSWIDTH_16 flag automatically. So the above 'if' is already a
fallback. Maybe you can add a comment if you want to make this more
explicit that the real property is nand-bus-width and the property
parsed in the driver is for backward compatibility only?

Thanks,
Miqu=C3=A8l
