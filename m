Return-Path: <linux-kernel+bounces-32138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C88835702
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E771C20B10
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05A3381B3;
	Sun, 21 Jan 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APOKnkrz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BB12E4C;
	Sun, 21 Jan 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856895; cv=none; b=Lio+MrUwzNnDgGzsWo/DH6h6zGB1JbFJxGbAC/UYlfWSfXIOuzJzaCPpXWbUMfFxREM+GdGR3X7m7oLn1X1lYo5kYm9u4pJlV7V9l3dKIq8hge/sq8MxW7t/ECsFQZ2BKfP2JdxgQyM7bEuwnaB4Teg3QWHPvoisbKuo8iFY60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856895; c=relaxed/simple;
	bh=u5ZvBZF1pXrSm3zSNAXlVdGjYuhQd8XRplQ92G8rl4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYfitejLQoQ05LeIu+HrKK+plPi11Wsgz7GNJLQ5wykcwzMmIOC7RQZSIL/qu83BUT/Pu7K++f+M6f+IXKbWn/HY8TF1XvEG8/Ssr4JRmGFXEhwPJaA1HWfhIdGWNoDuHBj142USEwfiXBbKj6A+2akuvlGwH6s90oPXRGfGj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APOKnkrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22202C433F1;
	Sun, 21 Jan 2024 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705856894;
	bh=u5ZvBZF1pXrSm3zSNAXlVdGjYuhQd8XRplQ92G8rl4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=APOKnkrz1DiOLwSBPul7WIjqj3auIgLuDNDmCshFkurIqLuMvuIIoPdvhHuEUUC68
	 w+WqhMUDP4vYHtNVs1Ic7pIdVGIvq6G0FqLtTSjuyb3b7xoGwi2r5PEDkuDmoVH5kh
	 +NJjaB53WjUOXCIbDgus3JzHZXt/Hl+BDIpcQo8iMKDi5p+OisXatKD6LqniUfoPXr
	 C/YPSQkm8kssCo1hCbdNOYo47Ej61Wcf98/D+1CXf02KxB0FRwHm5yyn2IiejsDlXP
	 zwKKAzN6PoA6DFVYPcFgAP8ffd9WvxakuTmSUC01j2eCtFAZj2j/L9683O2zp+Y3Xr
	 DoKtWuOjGmkEQ==
Date: Sun, 21 Jan 2024 17:07:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ceclan Dumitru
 <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v4 3/5] iio: amplifiers: hmc425a: move conversion logic
Message-ID: <20240121170759.7e4488dd@jic23-huawei>
In-Reply-To: <20240117125124.8326-4-mitrutzceclan@gmail.com>
References: <20240117125124.8326-1-mitrutzceclan@gmail.com>
	<20240117125124.8326-4-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 14:51:12 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> Move gain-dB<->code conversion logic from read_raw and write_raw to
> hmc425a_gain_dB_to_code() and hmc425a_code_to_gain_dB().
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
Some comments inline

Jonathan

> ---
>  drivers/iio/amplifiers/hmc425a.c | 102 ++++++++++++++++++-------------
>  1 file changed, 59 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> index ed4d72922696..e1162a500daf 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -56,35 +56,72 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
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

In the next patch I point out that this should be data or callbacks in in
the st->chip_info structure, not encoded in code here based on st->type (which
I want you to get rid of!)

> +		return 0;
> +	case ID_HMC540S:
> +		*code = ~((abs(gain) / 1000) & 0xF);
> +		return 0;
> +	case ID_ADRF5740:
> +		temp = (abs(gain) / 2000) & 0xF;
> +		*code = temp & BIT(3) ? temp | BIT(2) : temp;

Given you are moving the code, a comment here might be nice as it's unusual
(bits are 2DB, 4DB, 8DB and another 8DB)

> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
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
> +
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
> +		ret = hmc425a_code_to_gain_dB(st, val, val2);
> +		if (ret)
>  			break;
> -		case ID_ADRF5740:
> -			code = code & BIT(3) ? code & ~BIT(2) : code;
> -			gain = code * -2000;
> -			break;
> -		}
> -
> -		*val = gain / 1000;
> -		*val2 = (gain % 1000) * 1000;
> -
>  		ret = IIO_VAL_INT_PLUS_MICRO_DB;
>  		break;
>  	default:
> @@ -100,36 +137,15 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
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


