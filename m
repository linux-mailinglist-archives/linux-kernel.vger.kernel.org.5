Return-Path: <linux-kernel+bounces-25324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB482CD85
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2E61F225EA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B7F23A3;
	Sat, 13 Jan 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQVO27fD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CC1C16;
	Sat, 13 Jan 2024 15:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF087C433C7;
	Sat, 13 Jan 2024 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705160144;
	bh=n2el2oEmSVM6jBq5Bm0mWVcLdER3YEV7FbeXd9Wt9m4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IQVO27fDAPLkTgMXnKIS48uZglh8scp8o5AReAf8lnDHggI9mFzjUgwCNafn5MIXe
	 skdJOP6r9jEH1jPxLAN+ZEo839N/+V11ZvMMcxewwTYzzlkoBcDwI5CY7Yo6q5AL2w
	 Y1mOoxwy9ggDh/x7N4broE4Ja4mk4YbCCEvPBYQEh69hfFfzHJ0YVSIrS7PaW7qrNm
	 9WqQqnkwHyCoJPAEAA04Hk695uQFqUQsU8B5Z77I33QMEr69bKFvr+uPpIghQoZyHj
	 3kZg8Jk9oP2RCT85AfikWyvSiY4NMeP04lmZ8mvmavRB3xpgQoSRSXS1FxWxx+CnrQ
	 EIu7PSmNE5iYA==
Date: Sat, 13 Jan 2024 15:35:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ceclan Dumitru
 <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v2 3/4] iio: amplifiers: hmc425a: move conversion logic
Message-ID: <20240113153537.4a2aae40@jic23-huawei>
In-Reply-To: <20240110153757.5754-4-mitrutzceclan@gmail.com>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
	<20240110153757.5754-4-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 17:37:11 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> Move gain-dB<->code conversion logic from read_raw and write_raw to
> hmc425a_gain_dB_to_code() and hmc425a_code_to_gain_dB().
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
A couple of trivial formatting suggestions if you end up doing a v3.
If not I might make the tweaks whilst applying,

Jonathan

> ---
>  drivers/iio/amplifiers/hmc425a.c | 100 ++++++++++++++++++-------------
>  1 file changed, 57 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> index ed4d72922696..b5fd19403d15 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -56,35 +56,70 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
>  	return 0;
>  }
>  
> +static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2, int *code)
> +{
> +	struct hmc425a_chip_info *inf = st->chip_info;
> +	int gain, temp;
> +
> +	if (val < 0)
> +		gain = (val * 1000) - (val2 / 1000);
> +	else
> +		gain = (val * 1000) + (val2 / 1000);
> +
> +	if (gain > inf->gain_max || gain < inf->gain_min)
> +		return -EINVAL;
> +
> +	switch (st->type) {
> +	case ID_HMC425A:
> +		*code = ~((abs(gain) / 500) & 0x3F);
> +		break;
> +	case ID_HMC540S:
> +		*code = ~((abs(gain) / 1000) & 0xF);
> +		break;
> +	case ID_ADRF5740:
> +		temp = (abs(gain) / 2000) & 0xF;
> +		*code = temp & BIT(3) ? temp | BIT(2) : temp;
> +		break;
> +	}
trivial preference for blank line here.

> +	return 0;
> +}
> +
> +static int hmc425a_code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2)
> +{
> +	int code, gain;
> +
> +	code = st->gain;
> +	switch (st->type) {
> +	case ID_HMC425A:
> +		gain = ~code * -500;
> +		break;
> +	case ID_HMC540S:
> +		gain = ~code * -1000;
> +		break;
> +	case ID_ADRF5740:
> +		code = code & BIT(3) ? code & ~BIT(2) : code;
> +		gain = code * -2000;
> +		break;
> +	}
> +
> +	*val = gain / 1000;
> +	*val2 = (gain % 1000) * 1000;

As above. It's godo to have a blank line before a 'bare' return like this.

> +	return 0;
> +}
> +
>  static int hmc425a_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan, int *val,
>  			    int *val2, long m)
>  {
>  	struct hmc425a_state *st = iio_priv(indio_dev);
> -	int code, gain = 0;
>  	int ret;
>  
>  	mutex_lock(&st->lock);
>  	switch (m) {
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
> -		code = st->gain;
> -
> -		switch (st->type) {
> -		case ID_HMC425A:
> -			gain = ~code * -500;
> -			break;
> -		case ID_HMC540S:
> -			gain = ~code * -1000;
> -			break;
> -		case ID_ADRF5740:
> -			code = code & BIT(3) ? code & ~BIT(2) : code;
> -			gain = code * -2000;
> +		ret = hmc425a_code_to_gain_dB(st, val, val2);
> +		if (ret)
>  			break;
> -		}
> -
> -		*val = gain / 1000;
> -		*val2 = (gain % 1000) * 1000;
> -
>  		ret = IIO_VAL_INT_PLUS_MICRO_DB;
>  		break;
>  	default:
> @@ -100,36 +135,15 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
>  			     int val2, long mask)
>  {
>  	struct hmc425a_state *st = iio_priv(indio_dev);
> -	struct hmc425a_chip_info *inf = st->chip_info;
> -	int code = 0, gain;
> -	int ret;
> -
> -	if (val < 0)
> -		gain = (val * 1000) - (val2 / 1000);
> -	else
> -		gain = (val * 1000) + (val2 / 1000);
> -
> -	if (gain > inf->gain_max || gain < inf->gain_min)
> -		return -EINVAL;
> -
> -	switch (st->type) {
> -	case ID_HMC425A:
> -		code = ~((abs(gain) / 500) & 0x3F);
> -		break;
> -	case ID_HMC540S:
> -		code = ~((abs(gain) / 1000) & 0xF);
> -		break;
> -	case ID_ADRF5740:
> -		code = (abs(gain) / 2000) & 0xF;
> -		code = code & BIT(3) ? code | BIT(2) : code;
> -		break;
> -	}
> +	int code = 0, ret;
>  
>  	mutex_lock(&st->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = hmc425a_gain_dB_to_code(st, val, val2, &code);
> +		if (ret)
> +			break;
>  		st->gain = code;
> -
>  		ret = hmc425a_write(indio_dev, st->gain);
>  		break;
>  	default:


