Return-Path: <linux-kernel+bounces-116941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F988A55B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86AE2E43E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60611CB30E;
	Mon, 25 Mar 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAcNm/kG"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5D21C5AA5;
	Mon, 25 Mar 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366281; cv=none; b=gwB6fvH4v2AaewrXuimYCF9vuQyrKtR3CQAMo4VxcGe5gf7BE7hDto4KLdMc5cSOG9Eapzf17aa9gJj32T4Q2kZby2GVIpwp6x9/NXbaxBvuiZElgRDvQJKxULouXb5txJXAmS8A98VRjfQVbXPBiTTDLZA0IHUqgmqkq5VZLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366281; c=relaxed/simple;
	bh=EyIlueejT0gK9GuEs5MdPNg8HDGXDVqmLnd5nxFpcZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ypqqy0jNaJp+tlKd2kL0uFEjfsxRMJr1+5V/QFvxpnk8qOIDk4liDIuhhjqmuluhH4RBeqRG0hcEx+YJrg6NnTqx9RCjH0bQ+vG2pI2wquJ6Hgf97Btl0Bq9UxmvOUgKiR9SHihKoT1Ln0Jd9Tcd1q3UsMzxDKxLwNaxWUO5Qvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAcNm/kG; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515a68d45faso1518007e87.3;
        Mon, 25 Mar 2024 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711366276; x=1711971076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJkBHyUsM1Ra6ur6SOchqQjxQFdX44EdA5Gc6F4wbhw=;
        b=MAcNm/kGdnd0rZqRC8e7j+J81J0l53eJYL3481mBjVy8IsB4/nm9IhyCWN6oklYO72
         QEy6V0YEQ8lOEN+QJ6lnximKhQjY1pUTFOcuC6VTr2AyeHsf6WpoPVu15Rdgd8RRE0CN
         9vhdh3HjhJhp12SJO25bonDUUKQZVIa1KfLVpyvSoMSyEompAGW9GCjQnZZdRRStgvcp
         cjSJNaMY+9g98Qin+Lg5ZSVFhUelgGMkuQ8mCdo+lQ24qYfeygy5ju80e6YJjTne5p5b
         RqqCJxy6z3s+yNp12vpDlX2GLhjnPRJ8AH549OFgTo/hWa/vyigPPx+t4d2T8UDh1Zh8
         Nb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711366276; x=1711971076;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJkBHyUsM1Ra6ur6SOchqQjxQFdX44EdA5Gc6F4wbhw=;
        b=BPd6kH+QULDFAMEU6KWslsEpSJT2XdAsx2OLPdr+oBgb4VzpRdt0A9ovEGYYbpbeZH
         6BNiy+idW8S4Plk03QKPG+d+cfmMFhPQI5+tduFO/00l3tzBoe7/v2yShBq4rVkAtwLa
         yoeg5CIq7Rs1IO6Ln54pchHjMqIFP9yJ8RHm//3fzw/NjVu5IwQio2AXf/sERWXhENVH
         R5tEHF6AvihIOhdSps+eaOtGDbyUrGQWkbM0WNoHWrx243YYQI2iMJONSWfOydSiBFz/
         PMK+e/WaBsPui4MZQ6EJGqPwHr9BabNN2MjoriVC0wkoJIIOVQemG2Zo1Nb4Fk6G056q
         UZCg==
X-Forwarded-Encrypted: i=1; AJvYcCWkY5JhNelePlDssYOBobAv3E9CFnd14TYnKQHIdh3CLbpD9ycXLJh7MozytR9jBWJdakrxg8XIFQZLTi55+Fr+3nctVtGq3cegfHgu8JgcOtZBo8NL3Nd/B97cM2YxKyyJlG4sySDAUw==
X-Gm-Message-State: AOJu0YyBIcprijDQjxrDipq11zV7SE8gG6v6yt07njm+leYR4GpKm/f6
	SWinmKRaWp7UIj47vqr1xf6+2WnpsAlwFWvW1QNWSZKcf0CTwYzACEraDHR9
X-Google-Smtp-Source: AGHT+IF2nqxUG0rM7Fo+wTv5ljPmgwCa+w71rkB3zM9tbCRqlpdyPxc1zfzOtVQRkUO55CzC5ywi3Q==
X-Received: by 2002:a19:ca07:0:b0:512:fabd:8075 with SMTP id a7-20020a19ca07000000b00512fabd8075mr4079760lfg.48.1711366276190;
        Mon, 25 Mar 2024 04:31:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::6? (drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:7426:df00::6])
        by smtp.gmail.com with ESMTPSA id y5-20020a196405000000b00515a3293478sm955108lfb.104.2024.03.25.04.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 04:31:15 -0700 (PDT)
Message-ID: <472c6eaf-6cbc-484c-bc94-571d115176aa@gmail.com>
Date: Mon, 25 Mar 2024 13:31:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] mfd: rohm-bd71828: Add power off functionality
Content-Language: en-US, en-GB
To: Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20240324201210.232301-1-andreas@kemnade.info>
 <20240324201210.232301-3-andreas@kemnade.info>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240324201210.232301-3-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/24 22:12, Andreas Kemnade wrote:
> Since the chip can power off the system, add the corresponding
> functionality.
> Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
> No information source about the magic numbers found.

Oh, interesting repository :) Thanks for linking to it! I didn't know 
someone had reworked this driver...

I have access to the data-sheets so I also have some pieces of 
information. I hope I can clarify part of the puzzle. Unfortunately I 
have no information about the magic delays. I guess I could try asking 
though.

Oh, it seems to me this handler is only working on BD71828, not on 
BD71815. So, it should be tied to the ROHM_CHIP_TYPE_BD71828.

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/mfd/rohm-bd71828.c | 31 ++++++++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> index 594718f7e8e1..5a55aa3620d0 100644
> --- a/drivers/mfd/rohm-bd71828.c
> +++ b/drivers/mfd/rohm-bd71828.c
> @@ -464,6 +464,24 @@ static int set_clk_mode(struct device *dev, struct regmap *regmap,
>   				  OUT32K_MODE_CMOS);
>   }
>   
> +static struct i2c_client *bd71828_dev;

I'm not sure why to store pointer to the device and not a pointer to the 
regmap?

> +static void bd71828_power_off(void)
> +{
> +	i2c_smbus_write_byte_data(bd71828_dev, 0x03, 0xff);

0x03 is a "reset reason" - register. Spec I have states that the 
register should clear when a reset occurs - but it also says the bits 
are "write '1' to clear". So, for some reason(?), this clears the 
previous reset reason. I am unsure why i2c_smbus_write_byte_data() and 
not regmap()?

> +	mdelay(500);
> +	i2c_smbus_write_byte_data(bd71828_dev, BD71828_REG_INT_DCIN2, 0x02);

This clears the DCIN monitoring status bit from the IRQ status register. 
I don't understand the purpose though.

> +	mdelay(500);
> +	while (true) {
> +		i2c_smbus_write_byte_data(bd71828_dev, BD71828_REG_PS_CTRL_1, 0x02);

This write to PS_CTRL_1 initiates a state transition. 0x2 equals to HBNT 
state. Eg, in usual cases this should be a start of the power-off sequence.

> +		mdelay(500);
> +	}
> +}

If you have the hardware to test this on, then it'd be great to see if 
clearing the reset reason and IRQ status could be dropped. I can't 
immediately think of a reason for those.

> +static void bd71828_remove_poweroff(void *data)
> +{
> +	bd71828_dev = NULL;

This does not smell correct to me. Should we remove the 
bd71828_power_off() from the pm_power_off instead?

> +}
> +
>   static int bd71828_i2c_probe(struct i2c_client *i2c)
>   {
>   	struct regmap_irq_chip_data *irq_data;
> @@ -542,7 +560,18 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
>   	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
>   				   NULL, 0, regmap_irq_get_domain(irq_data));
>   	if (ret)
> -		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
> +		return	dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
> +
> +	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
> +		if (!pm_power_off) {
> +			bd71828_dev = i2c;
> +			pm_power_off = bd71828_power_off;
> +			ret = devm_add_action_or_reset(&i2c->dev,
> +						       bd71828_remove_poweroff,
> +						       NULL);
> +		} else
> +			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
> +	}
>   
>   	return ret;
>   }

Thanks for doing the digging Andreas! I think supporting the power-off 
for devices using this PMIC is nice!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


