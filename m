Return-Path: <linux-kernel+bounces-2608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CEA815F5B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2371F21FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D54438A;
	Sun, 17 Dec 2023 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwGAWtSw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA844369;
	Sun, 17 Dec 2023 13:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261C9C433C8;
	Sun, 17 Dec 2023 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702819500;
	bh=TU3V0XOIrapBSmbG7wJEKVU27RSZUFivlAPhn2ejiho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WwGAWtSwzp+kQ33anWPPbw4sp0k5GSc+B7foyxBmmzTDn+ejGRP95AwXeRJ8aMy5j
	 5H1QIggxF76XNmex6sBrZ/ovgdJ+GozaNePV0sRO90+6SgNDfQqMKb/HhpkP8h6wys
	 +bK9zS9XK0w+lX5jNaNXtmPitTf5LpxPSDHz3hRa/W5MVaRiQJai40lRtAu7DTKlRo
	 aA6596234QCdxRp+BnPWKa2ogx7d4EXgRBESsPOKTj39jEkJ6MWJu2qmXuE/3xCsqN
	 Xtv1I0EALe3T4KjKfWJtzUct9weHZxkgYuUjfp9XYijEgL9sCqB0lGePV5DxMIsUki
	 V3Swj7REp0L6g==
Date: Sun, 17 Dec 2023 13:24:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Justin Stitt <justinstitt@google.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Stephen Boyd <swboyd@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] iio: sx9324: avoid copying property strings
Message-ID: <20231217132447.269072df@jic23-huawei>
In-Reply-To: <f03d372a282712dee8412e47aff9bb54f181efd9.camel@perches.com>
References: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
	<f03d372a282712dee8412e47aff9bb54f181efd9.camel@perches.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 22:30:12 -0800
Joe Perches <joe@perches.com> wrote:

> On Tue, 2023-12-12 at 00:42 +0000, Justin Stitt wrote:
> > We're doing some needless string copies when trying to assign the proper
> > `prop` string. We can make `prop` a const char* and simply assign to
> > string literals.  
> 
> trivia:
> 
> I would have updated it like this moving the
> various declarations into the case blocks
> where they are used and removing a few unused
> #defines

I'd definitely like to see those defines gone.
Arguably an unrelated change as I guess they are left from a previous refactor
of this code.

Why prop to type renaming?  It's getting passed into calls where the parameter
is propname so I'd understand renaming to that, but type just seems a bit random
to me.  I do wonder if we are better off having some long lines and getting rid
of the property naming local variables completely by just duplicating
the device_property_read_u32() call and passing them in directly.

Moving declarations more locally is a nice to have but I'll leave that up to Justin.

Anyhow, both solutions look much better than the original so I'm fine either way
(subject to responses to Stephen's review)

> 
> ---
>  drivers/iio/proximity/sx9324.c | 69 +++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index ac2ed2da21ccc..c50c1108a69cc 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -877,17 +877,8 @@ static const struct sx_common_reg_default *
>  sx9324_get_default_reg(struct device *dev, int idx,
>  		       struct sx_common_reg_default *reg_def)
>  {
> -	static const char * const sx9324_rints[] = { "lowest", "low", "high",
> -		"highest" };
> -	static const char * const sx9324_csidle[] = { "hi-z", "hi-z", "gnd",
> -		"vdd" };
> -#define SX9324_PIN_DEF "semtech,ph0-pin"
> -#define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
> -#define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
> -	unsigned int pin_defs[SX9324_NUM_PINS];
> -	char prop[] = SX9324_PROXRAW_DEF;
> -	u32 start = 0, raw = 0, pos = 0;
> -	int ret, count, ph, pin;
> +	u32 raw = 0;
> +	int ret;
>  
>  	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
>  
> @@ -896,7 +887,13 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  	case SX9324_REG_AFE_PH0:
>  	case SX9324_REG_AFE_PH1:
>  	case SX9324_REG_AFE_PH2:
> -	case SX9324_REG_AFE_PH3:
> +	case SX9324_REG_AFE_PH3: {
> +		unsigned int pin_defs[SX9324_NUM_PINS];
> +		int count;
> +		int pin;
> +		int ph;
> +		char prop[32];
> +
>  		ph = reg_def->reg - SX9324_REG_AFE_PH0;
>  		snprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
>  
> @@ -913,7 +910,15 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  			       SX9324_REG_AFE_PH0_PIN_MASK(pin);
>  		reg_def->def = raw;
>  		break;
> -	case SX9324_REG_AFE_CTRL0:
> +	}
> +	case SX9324_REG_AFE_CTRL0: {
> +		static const char * const sx9324_csidle[] = {
> +			"hi-z", "hi-z", "gnd", "vdd"
> +		};
> +		static const char * const sx9324_rints[] = {
> +			"lowest", "low", "high", "highest"
> +		};
> +
>  		ret = device_property_match_property_string(dev, "semtech,cs-idle-sleep",
>  							    sx9324_csidle,
>  							    ARRAY_SIZE(sx9324_csidle));
> @@ -930,16 +935,17 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  			reg_def->def |= ret << SX9324_REG_AFE_CTRL0_RINT_SHIFT;
>  		}
>  		break;
> +	}
>  	case SX9324_REG_AFE_CTRL4:
> -	case SX9324_REG_AFE_CTRL7:
> +	case SX9324_REG_AFE_CTRL7: {
> +		const char *type;
> +
>  		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
> -			strncpy(prop, "semtech,ph01-resolution",
> -				ARRAY_SIZE(prop));
> +			type = "semtech,ph01-resolution";
>  		else
> -			strncpy(prop, "semtech,ph23-resolution",
> -				ARRAY_SIZE(prop));
> +			type = "semtech,ph23-resolution";
>  
> -		ret = device_property_read_u32(dev, prop, &raw);
> +		ret = device_property_read_u32(dev, type, &raw);
>  		if (ret)
>  			break;
>  
> @@ -949,6 +955,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
>  					   raw);
>  		break;
> +	}
>  	case SX9324_REG_AFE_CTRL8:
>  		ret = device_property_read_u32(dev,
>  				"semtech,input-precharge-resistor-ohms",
> @@ -982,17 +989,21 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  					   6 + raw * (raw + 3) / 2);
>  		break;
>  
> -	case SX9324_REG_ADV_CTRL5:
> +	case SX9324_REG_ADV_CTRL5: {
> +		u32 start = 0;
> +
>  		ret = device_property_read_u32(dev, "semtech,startup-sensor",
>  					       &start);
>  		if (ret)
>  			break;
> -
>  		reg_def->def &= ~SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK;
>  		reg_def->def |= FIELD_PREP(SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK,
>  					   start);
>  		break;
> -	case SX9324_REG_PROX_CTRL4:
> +	}
> +	case SX9324_REG_PROX_CTRL4: {
> +		u32 pos = 0;
> +
>  		ret = device_property_read_u32(dev, "semtech,avg-pos-strength",
>  					       &pos);
>  		if (ret)
> @@ -1005,15 +1016,16 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  		reg_def->def |= FIELD_PREP(SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK,
>  					   raw);
>  		break;
> +	}
>  	case SX9324_REG_PROX_CTRL0:
> -	case SX9324_REG_PROX_CTRL1:
> +	case SX9324_REG_PROX_CTRL1: {
> +		const char *type;
> +
>  		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
> -			strncpy(prop, "semtech,ph01-proxraw-strength",
> -				ARRAY_SIZE(prop));
> +			type = "semtech,ph01-proxraw-strength";
>  		else
> -			strncpy(prop, "semtech,ph23-proxraw-strength",
> -				ARRAY_SIZE(prop));
> -		ret = device_property_read_u32(dev, prop, &raw);
> +			type = "semtech,ph23-proxraw-strength";
> +		ret = device_property_read_u32(dev, type, &raw);
>  		if (ret)
>  			break;
>  
> @@ -1022,6 +1034,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  					   raw);
>  		break;
>  	}
> +	}
>  	return reg_def;
>  }
>  
> 
> 


