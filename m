Return-Path: <linux-kernel+bounces-11554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9007381E826
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5601C2140B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5A4F5E1;
	Tue, 26 Dec 2023 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUUa26yc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2E4F207;
	Tue, 26 Dec 2023 15:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EFDC433C7;
	Tue, 26 Dec 2023 15:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703605930;
	bh=jzVP4Y4JhZWGkkFHmLQvr5y6pdDNLeWEKoXU+39nmKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUUa26ycei86jgk4JYf9+fzt63DO9IASM8HD11qwPTDtEI5PPbEUGQI/+6jDgNNLn
	 92rGDw5BpS24yJLn0LKDozuhRJyVmeLNLQne+bvfQpP/KzN2OakDUYKdTv4H729iZR
	 C1q8J2JFgCi1x6SpEPnrTT6BlXsSg2dxp/QWNbw6BW8Xy0SN5ufIdZQhJh6fD/ouE4
	 /UpgBO63hpY7PveeLlSOuaDffn60gFlAq0/iKMka2qA/ShRTmtCHrnmgcQf8NfAAwi
	 7X17/PjspuptqQvbECK+TAOmGtwWWHzGaECJvFZj03YaPctI2QQWu8i63TOyN5fMoT
	 fIDOFLI7QlfpA==
Date: Tue, 26 Dec 2023 15:51:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Stephen Boyd
 <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] iio: sx9324: avoid copying property strings
Message-ID: <20231226155157.6f49b6f9@jic23-huawei>
In-Reply-To: <20231219-strncpy-drivers-iio-proximity-sx9324-c-v4-1-d49ed29ee952@google.com>
References: <20231219-strncpy-drivers-iio-proximity-sx9324-c-v4-1-d49ed29ee952@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 21:34:15 +0000
Justin Stitt <justinstitt@google.com> wrote:

> We're doing some needless string copies when trying to assign the proper
> `prop` string. We can make `prop` a const char* and simply assign to
> string literals.
> 
> For the case where a format string is used, let's extract the parsing
> logic out into sx9324_parse_phase_prop(). We no longer need to create
> copies or allocate new memory.
> 
> sx9324_parse_phase_prop() will simply return the default def value if it
> fails.
> 
> This also cleans up some deprecated strncpy() uses [1].
> 
> Furthermore, let's clean up this code further by removing some unused
> defines:
> |  #define SX9324_PIN_DEF "semtech,ph0-pin"
> |  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
> |  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
This clashes with a patch from Andy Shevchenko 
iio: proximity: sx9324: Switch to device_property_match_property_string()
https://lore.kernel.org/all/20230808162800.61651-7-andriy.shevchenko@linux.intel.com/

Would you mind rebasing on top of that (it should be in linux-next
or my togreg branch of iio.git).

Might be easier to rebase on rc1 once it's available in about 3.5 weeks time.

Jonathan

> ---
> Changes in v4:
> - use u8 return type (thanks Stephen)
> - remove unused defines (thanks Stephen et al.)
> - tweaks to sx9324_parse_phase_prop related to defaults (thanks Stephen)
> - Link to v3: https://lore.kernel.org/r/20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com
> 
> Changes in v3:
> - extract logic into sx9324_parse_phase_prop() and use string literals
>   (thanks Stephen)
> - rebase onto mainline bee0e7762ad2c602
> - Link to v2: https://lore.kernel.org/r/20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com
> 
> Changes in v2:
> - make prop a const char* and do simple assignments (thanks Jonathan)
> - rebase onto 3a568e3a961ba330
> - Link to v1: https://lore.kernel.org/r/20230921-strncpy-drivers-iio-proximity-sx9324-c-v1-1-4e8d28fd1e7c@google.com
> ---
> ---
>  drivers/iio/proximity/sx9324.c | 70 ++++++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 438f9c9aba6e..3daad7167c63 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -873,6 +873,29 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
>  					20000, 2000000);
>  }
>  
> +static u8 sx9324_parse_phase_prop(struct device *dev,
> +				  struct sx_common_reg_default *reg_def,
> +				  const char *prop)
> +{
> +	unsigned int pin_defs[SX9324_NUM_PINS];
> +	int count, ret, pin;
> +	u32 raw = 0;
> +
> +	count = device_property_count_u32(dev, prop);
> +	if (count != ARRAY_SIZE(pin_defs))
> +		return reg_def->def;
> +	ret = device_property_read_u32_array(dev, prop, pin_defs,
> +					     ARRAY_SIZE(pin_defs));
> +	if (ret)
> +		return reg_def->def;
> +
> +	for (pin = 0; pin < SX9324_NUM_PINS; pin++)
> +		raw |= (pin_defs[pin] << (2 * pin)) &
> +		       SX9324_REG_AFE_PH0_PIN_MASK(pin);
> +
> +	return raw;
> +}
> +
>  static const struct sx_common_reg_default *
>  sx9324_get_default_reg(struct device *dev, int idx,
>  		       struct sx_common_reg_default *reg_def)
> @@ -881,38 +904,29 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  		"highest" };
>  	static const char * const sx9324_csidle[] = { "hi-z", "hi-z", "gnd",
>  		"vdd" };
> -#define SX9324_PIN_DEF "semtech,ph0-pin"
> -#define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
> -#define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
> -	unsigned int pin_defs[SX9324_NUM_PINS];
> -	char prop[] = SX9324_PROXRAW_DEF;
>  	u32 start = 0, raw = 0, pos = 0;
> -	int ret, count, ph, pin;
> -	const char *res;
> +	const char *prop, *res;
> +	int ret;
>  
>  	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
>  
>  	sx_common_get_raw_register_config(dev, reg_def);
>  	switch (reg_def->reg) {
>  	case SX9324_REG_AFE_PH0:
> +		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
> +						       "semtech,ph0-pin");
> +		break;
>  	case SX9324_REG_AFE_PH1:
> +		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
> +						       "semtech,ph1-pin");
> +		break;
>  	case SX9324_REG_AFE_PH2:
> +		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
> +						       "semtech,ph2-pin");
> +		break;
>  	case SX9324_REG_AFE_PH3:
> -		ph = reg_def->reg - SX9324_REG_AFE_PH0;
> -		snprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
> -
> -		count = device_property_count_u32(dev, prop);
> -		if (count != ARRAY_SIZE(pin_defs))
> -			break;
> -		ret = device_property_read_u32_array(dev, prop, pin_defs,
> -						     ARRAY_SIZE(pin_defs));
> -		if (ret)
> -			break;
> -
> -		for (pin = 0; pin < SX9324_NUM_PINS; pin++)
> -			raw |= (pin_defs[pin] << (2 * pin)) &
> -			       SX9324_REG_AFE_PH0_PIN_MASK(pin);
> -		reg_def->def = raw;
> +		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
> +						       "semtech,ph3-pin");
>  		break;
>  	case SX9324_REG_AFE_CTRL0:
>  		ret = device_property_read_string(dev,
> @@ -937,11 +951,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  	case SX9324_REG_AFE_CTRL4:
>  	case SX9324_REG_AFE_CTRL7:
>  		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
> -			strncpy(prop, "semtech,ph01-resolution",
> -				ARRAY_SIZE(prop));
> +			prop = "semtech,ph01-resolution";
>  		else
> -			strncpy(prop, "semtech,ph23-resolution",
> -				ARRAY_SIZE(prop));
> +			prop = "semtech,ph23-resolution";
>  
>  		ret = device_property_read_u32(dev, prop, &raw);
>  		if (ret)
> @@ -1012,11 +1024,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  	case SX9324_REG_PROX_CTRL0:
>  	case SX9324_REG_PROX_CTRL1:
>  		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
> -			strncpy(prop, "semtech,ph01-proxraw-strength",
> -				ARRAY_SIZE(prop));
> +			prop = "semtech,ph01-proxraw-strength";
>  		else
> -			strncpy(prop, "semtech,ph23-proxraw-strength",
> -				ARRAY_SIZE(prop));
> +			prop = "semtech,ph23-proxraw-strength";
>  		ret = device_property_read_u32(dev, prop, &raw);
>  		if (ret)
>  			break;
> 
> ---
> base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
> change-id: 20230921-strncpy-drivers-iio-proximity-sx9324-c-8c3437676039
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 


