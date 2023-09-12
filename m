Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6479D024
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjILLhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjILLgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:36:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46487172B;
        Tue, 12 Sep 2023 04:35:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso799108666b.1;
        Tue, 12 Sep 2023 04:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694518556; x=1695123356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zofwSNLHzuaFkxU90/ciFQd/cYGOkavRsAzLbHl083k=;
        b=i1qJgw65hBnGWzVBq1rEyFkqurmOZXPhF10uulFKvOskgeS5NxqUcrOtHM38HoszNz
         kilGF6xAxV28cq0weI3nod6rATAfNdoVehe6uVFt1JDloK9RiiRDllQVUt2MmeMYyVas
         PEjDP5CUuzl9VOl+KhMJtmKJ1AzgbsBBd8S+Ub9aDXYcmQMcabu8eATOK8FhQQUBIgxD
         l00KvfKRW4+uc8CEPjjojTLPgTcYKu6f4B9RjkSoiydVAdl07hp158K7OYWI4VixGsNb
         zZgiWAp7gnVcgkYnpauvannbredEwr4iVeRvznaAGv1tbNta00Vkq6ikyLzlXhScZ5Un
         ivpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518556; x=1695123356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zofwSNLHzuaFkxU90/ciFQd/cYGOkavRsAzLbHl083k=;
        b=ekKk+SiUiqDYc+DWfdf4ODm4IJv8hE5+jGKAidl88E7hPCNXXAT6ja4LNLwwHwUBVR
         WOmmjc3GlYcA5N3CrKTvQmzJSQoFBXN/cjJg6MgA70kVbjk0i8hd9ZNb5T3lhBynxZN5
         7ugwkJE/ozMDf+dX2fGxX9MfFY88zsy4TkjGGXAMpStO/5V8uNBuow3Dv2l7Ow6ZEJ6D
         IEEbjOP660ule0e/7RepMUxUiugxI1i9L2AjSM0VQvpsvkg7fIPXYe+wF+ryYJYhu9Jp
         5ZBDhuYy/woqi7h26J4KZg4St4Gxb0xUkwdu8lmelkBwZ1NKaTfhMCNHCEzP9S6jbPig
         IaUQ==
X-Gm-Message-State: AOJu0YxM3rmAiZC1wq8wbl5/ZAt1eoDmkTEqTwKHR3nFAPc+DQCO2BXN
        /eGmBhiUHdAN3awJscKrcdc=
X-Google-Smtp-Source: AGHT+IHghIPteUvhOfKXpxCY0vv/O4O2PFrpEFGx+S8fLorr7TgU4QvXJ3rK4kstsSLVvuM79gTI4A==
X-Received: by 2002:a17:906:3117:b0:9a2:143e:a070 with SMTP id 23-20020a170906311700b009a2143ea070mr3126895ejx.20.1694518556075;
        Tue, 12 Sep 2023 04:35:56 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b0098e0a937a6asm6654876ejb.69.2023.09.12.04.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 04:35:55 -0700 (PDT)
Date:   Tue, 12 Sep 2023 14:35:53 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: dsa: microchip: Add drive strength
 configuration
Message-ID: <20230912113553.fselyj2v5ynddme2@skbuf>
References: <20230912045459.1864085-1-o.rempel@pengutronix.de>
 <20230912045459.1864085-1-o.rempel@pengutronix.de>
 <20230912045459.1864085-3-o.rempel@pengutronix.de>
 <20230912045459.1864085-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912045459.1864085-3-o.rempel@pengutronix.de>
 <20230912045459.1864085-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 06:54:59AM +0200, Oleksij Rempel wrote:
> Add device tree based drive strength configuration support. It is needed to
> pass EMI validation on our hardware.
> 
> Configuration values are based on the vendor's reference driver.
> 
> Tested on KSZ9563R.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/dsa/microchip/ksz8795_reg.h |  14 --
>  drivers/net/dsa/microchip/ksz9477_reg.h |  13 -
>  drivers/net/dsa/microchip/ksz_common.c  | 309 ++++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz_common.h  |  20 ++
>  4 files changed, 329 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 42db7679c3606..ee77c44e99f65 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -186,6 +186,72 @@ static const struct ksz_mib_names ksz9477_mib_names[] = {
>  	{ 0x83, "tx_discards" },
>  };
>  
> +struct ksz_driver_strength_prop {
> +	const char *name;
> +	int offset;
> +	int value;
> +};
> +
> +enum ksz_driver_strength_type {
> +	KSZ_DRIVER_STRENGTH_HI,
> +	KSZ_DRIVER_STRENGTH_LO,
> +	KSZ_DRIVER_STRENGTH_IO,
> +};
> +
> +/**
> + * struct ksz_drive_strength - drive strength mapping
> + * @reg_val:	register value
> + * @milliamp:	milliamp value
> + */
> +struct ksz_drive_strength {
> +	u32 reg_val;
> +	u32 milliamp;
> +};
> +
> +/* ksz9477_drive_strengths - Drive strength mapping for KSZ9477 variants
> + *
> + * This values are not documented in KSZ9477 variants but confirmed by
> + * Microchip that KSZ9477, KSZ9567, KSZ8567, KSZ9897, KSZ9896, KSZ9563, KSZ9893
> + * and KSZ8563 are using same register (drive strength) settings like KSZ8795.
> + *
> + * Documentation in KSZ8795CLX provides more information with some
> + * recommendations:
> + * - for high speed signals
> + *   1. 4 mA or 8 mA is often used for MII, RMII, and SPI interface with using
> + *      2.5V or 3.3V VDDIO.
> + *   2. 12 mA or 16 mA is often used for MII, RMII, and SPI interface with
> + *      using 1.8V VDDIO.
> + *   3. 20 mA or 24 mA is often used for GMII/RGMII interface with using 2.5V
> + *      or 3.3V VDDIO.
> + *   4. 28 mA is often used for GMII/RGMII interface with using 1.8V VDDIO.
> + *   5. In same interface, the heavy loading should use higher one of the
> + *      drive current strength.
> + * - for low speed signals
> + *   1. 3.3V VDDIO, use either 4 mA or 8 mA.
> + *   2. 2.5V VDDIO, use either 8 mA or 12 mA.
> + *   3. 1.8V VDDIO, use either 12 mA or 16 mA.
> + *   4. If it is heavy loading, can use higher drive current strength.
> + */
> +static const struct ksz_drive_strength ksz9477_drive_strengths[] = {
> +	{ SW_DRIVE_STRENGTH_2MA,  2000 },
> +	{ SW_DRIVE_STRENGTH_4MA,  4000 },
> +	{ SW_DRIVE_STRENGTH_8MA,  8000 },
> +	{ SW_DRIVE_STRENGTH_12MA, 12000 },
> +	{ SW_DRIVE_STRENGTH_16MA, 16000 },
> +	{ SW_DRIVE_STRENGTH_20MA, 20000 },
> +	{ SW_DRIVE_STRENGTH_24MA, 24000 },
> +	{ SW_DRIVE_STRENGTH_28MA, 28000 },
> +};
> +
> +/* ksz8830_drive_strengths - Drive strength mapping for KSZ8830, KSZ8873, ..
> + *			     variants.
> + * This values are documented in KSZ8873 and KSZ8863 datasheets.
> + */
> +static const struct ksz_drive_strength ksz8830_drive_strengths[] = {
> +	{ 0,  8000 },
> +	{ KSZ8873_DRIVE_STRENGTH_16MA, 16000 },
> +};
> +
>  static const struct ksz_dev_ops ksz8_dev_ops = {
>  	.setup = ksz8_setup,
>  	.get_port_addr = ksz8_get_port_addr,
> @@ -3530,6 +3596,245 @@ static void ksz_parse_rgmii_delay(struct ksz_device *dev, int port_num,
>  	dev->ports[port_num].rgmii_tx_val = tx_delay;
>  }
>  
> +/**
> + * ksz_drive_strength_to_reg() - Convert drive strength value to corresponding
> + *				 register value.
> + * @array:	The array of drive strength values to search.
> + * @array_size:	The size of the array.
> + * @milliamp:	The drive strength value in milliamp to be converted.
> + *
> + * This function searches the array of drive strength values for the given
> + * milliamp value and returns the corresponding register value for that drive.
> + *
> + * Returns: If found, the corresponding register value for that drive strength
> + * is returned. Otherwise, -EINVAL is returned indicating an invalid value.
> + */
> +static int ksz_drive_strength_to_reg(const struct ksz_drive_strength *array,
> +				     size_t array_size, int milliamp)
> +{
> +	int i;
> +
> +	for (i = 0; i < array_size; i++) {
> +		if (array[i].milliamp == milliamp)
> +			return array[i].reg_val;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * ksz_drive_strength_error() - Report invalid drive strength value
> + * @dev:	ksz device
> + * @array:	The array of drive strength values to search.
> + * @array_size:	The size of the array.
> + * @milliamp:	Invalid drive strength value in milliamp
> + *
> + * This function logs an error message when an unsupported drive strength value
> + * is detected. It lists out all the supported drive strength values for
> + * reference in the error message.
> + */
> +static void ksz_drive_strength_error(struct ksz_device *dev,
> +				     const struct ksz_drive_strength *array,
> +				     size_t array_size, int milliamp)
> +{
> +	char supported_values[100];
> +	size_t remaining_size;
> +	int added_len;
> +	char *ptr;
> +	int i;
> +
> +	remaining_size = sizeof(supported_values);
> +	ptr = supported_values;
> +
> +	for (i = 0; i < array_size; i++) {
> +		added_len = snprintf(ptr, remaining_size,
> +				     i == 0 ? "%d" : ", %d", array[i].milliamp);
> +
> +		if (added_len < 0 || added_len >= remaining_size)
> +			break;
> +
> +		ptr += added_len;
> +		remaining_size -= added_len;
> +	}
> +
> +	dev_err(dev->dev, "Invalid drive strength %d, supported values are %s\n",
> +		milliamp, supported_values);
> +}

Milliamp or microamp? The dt-binding is in microamps, and I see no micro -> milli
conversion.

> +
> +/**
> + * ksz9477_drive_strength_write() - Set the drive strength for specific KSZ9477
> + *				    chip variants.
> + * @dev:       ksz device
> + * @props:     Array of drive strength properties to be applied
> + * @num_props: Number of properties in the array
> + *
> + * This function configures the drive strength for various KSZ9477 chip variants
> + * based on the provided properties. It handles chip-specific nuances and
> + * ensures only valid drive strengths are written to the respective chip.
> + *
> + * Return: 0 on successful configuration, a negative error code on failure.
> + */
> +static int ksz9477_drive_strength_write(struct ksz_device *dev,
> +					struct ksz_driver_strength_prop *props,
> +					int num_props)
> +{
> +	size_t array_size = ARRAY_SIZE(ksz9477_drive_strengths);
> +	int i, ret, reg;
> +	u8 mask = 0;
> +	u8 val = 0;
> +
> +	if (props[KSZ_DRIVER_STRENGTH_IO].value != -1)
> +		dev_warn(dev->dev, "%s is not supported by this chip variant\n",
> +			 props[KSZ_DRIVER_STRENGTH_IO].name);
> +
> +	if (dev->chip_id == KSZ8795_CHIP_ID ||
> +	    dev->chip_id == KSZ8794_CHIP_ID ||
> +	    dev->chip_id == KSZ8765_CHIP_ID)
> +		reg = KSZ8795_REG_SW_CTRL_20;
> +	else
> +		reg = KSZ9477_REG_SW_IO_STRENGTH;
> +
> +	for (i = 0; i < num_props; i++) {
> +		if (props[i].value == -1)
> +			continue;
> +
> +		ret = ksz_drive_strength_to_reg(ksz9477_drive_strengths,
> +						array_size, props[i].value);
> +		if (ret < 0) {
> +			ksz_drive_strength_error(dev, ksz9477_drive_strengths,
> +						 array_size, props[i].value);
> +			return ret;
> +		}
> +
> +		mask |= SW_DRIVE_STRENGTH_M << props[i].offset;
> +		val |= ret << props[i].offset;
> +	}
> +
> +	return ksz_rmw8(dev, reg, mask, val);
> +}
> +
> +/**
> + * ksz8830_drive_strength_write() - Set the drive strength configuration for
> + *				    KSZ8830 compatible chip variants.
> + * @dev:       ksz device
> + * @props:     Array of drive strength properties to be set
> + * @num_props: Number of properties in the array
> + *
> + * This function applies the specified drive strength settings to KSZ8830 chip
> + * variants (KSZ8873, KSZ8863).
> + * It ensures the configurations align with what the chip variant supports and
> + * warns or errors out on unsupported settings.
> + *
> + * Return: 0 on success, error code otherwise
> + */
> +static int ksz8830_drive_strength_write(struct ksz_device *dev,
> +					struct ksz_driver_strength_prop *props,
> +					int num_props)
> +{
> +	size_t array_size = ARRAY_SIZE(ksz8830_drive_strengths);
> +	int milliamp;
> +	int i, ret;
> +
> +	for (i = 0; i < num_props; i++) {
> +		if (props[i].value == -1 || i == KSZ_DRIVER_STRENGTH_IO)
> +			continue;
> +
> +		dev_warn(dev->dev, "%s is not supported by this chip variant\n",
> +			 props[i].name);
> +	}
> +
> +	milliamp = props[KSZ_DRIVER_STRENGTH_IO].value;
> +	ret = ksz_drive_strength_to_reg(ksz8830_drive_strengths, array_size,
> +					milliamp);
> +	if (ret < 0) {
> +		ksz_drive_strength_error(dev, ksz8830_drive_strengths,
> +					 array_size, milliamp);
> +		return ret;
> +	}
> +
> +	return ksz_rmw8(dev, KSZ8873_REG_GLOBAL_CTRL_12,
> +			KSZ8873_DRIVE_STRENGTH_16MA, ret);
> +}
> +
> +/**
> + * ksz_parse_drive_strength() - Extract and apply drive strength configurations
> + *				from device tree properties.
> + * @dev:	ksz device
> + *
> + * This function reads the specified drive strength properties from the
> + * device tree, validates against the supported chip variants, and sets
> + * them accordingly. An error should be critical here, as the drive strength
> + * settings are crucial for EMI compliance.
> + *
> + * Return: 0 on success, error code otherwise
> + */
> +static int ksz_parse_drive_strength(struct ksz_device *dev)
> +{
> +	struct ksz_driver_strength_prop of_props[] = {
> +		[KSZ_DRIVER_STRENGTH_HI] = {
> +			.name = "microchip,hi-drive-strength-microamp",
> +			.offset = SW_HI_SPEED_DRIVE_STRENGTH_S,
> +			.value = -1

nit: it is usual to place a comma even after the last element of an
array or structure, because it makes future patches cleaner (they don't
need to touch the previous line to add a comma).

> +		},
> +		[KSZ_DRIVER_STRENGTH_LO] = {
> +			.name = "microchip,lo-drive-strength-microamp",
> +			.offset = SW_LO_SPEED_DRIVE_STRENGTH_S,
> +			.value = -1
> +		},
> +		[KSZ_DRIVER_STRENGTH_IO] = {
> +			.name = "microchip,io-drive-strength-microamp",
> +			.offset = 0, /* don't care */
> +			.value = -1
> +		},
> +	};
> +	struct device_node *np = dev->dev->of_node;
> +	bool found = false;
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(of_props); i++) {
> +		ret = of_property_read_u32(np, of_props[i].name,
> +					   &of_props[i].value);
> +		if (ret && ret != -EINVAL)
> +			dev_warn(dev->dev, "Failed to read %s\n",
> +				 of_props[i].name);
> +		if (ret)
> +			continue;
> +
> +		found = true;
> +	}
> +
> +	if (!found)
> +		return 0;

Maybe "have_any_prop" would be a better name to avoid Christophe's confusion?

> +
> +	switch (dev->chip_id) {
> +	case KSZ8830_CHIP_ID:
> +		return ksz8830_drive_strength_write(dev, of_props,
> +						    ARRAY_SIZE(of_props));
> +	case KSZ8795_CHIP_ID:
> +	case KSZ8794_CHIP_ID:
> +	case KSZ8765_CHIP_ID:
> +	case KSZ8563_CHIP_ID:
> +	case KSZ9477_CHIP_ID:
> +	case KSZ9563_CHIP_ID:
> +	case KSZ9567_CHIP_ID:
> +	case KSZ9893_CHIP_ID:
> +	case KSZ9896_CHIP_ID:
> +	case KSZ9897_CHIP_ID:
> +		return ksz9477_drive_strength_write(dev, of_props,
> +						    ARRAY_SIZE(of_props));
> +	default:
> +		for (i = 0; i < ARRAY_SIZE(of_props); i++) {
> +			if (of_props[i].value == -1)
> +				continue;
> +
> +			dev_warn(dev->dev, "%s is not supported by this chip variant\n",
> +				 of_props[i].name);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
