Return-Path: <linux-kernel+bounces-133961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E40D89AB79
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0143FB21646
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66773383B2;
	Sat,  6 Apr 2024 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7Xaidty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94A38390;
	Sat,  6 Apr 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712415420; cv=none; b=rE5pdsT2nGGJeSRBPe9vcpHowsXVOnHhJUom5gRixR9DN0/6sT15rnVYgbEJwfrF+EwkcANk5ryXR3UcjmELWvIyzfq7ePfIcg50u2nxw53WMirMlEbYywZf82OkWpKx8iiemlNznAPWvJuxlhX2bi407P9AfK49klWdG5J8ieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712415420; c=relaxed/simple;
	bh=H7r4BwHYdEAkivbchzdrbMt8uQAr7fq8c2kkzMTjysk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iy4QfkxgiYNPRsWE5xf/nspyIG8VsVkXUOEc/YKds07H5EZaWKQcPNeo47N6lASaM+/k5lt84SRM0aSzBgs5m8SCJHS+9bUWwPUSc9IWFwZjnvxyP/zXsT5gOh6Ff8PvycGHa8l96r5AXM8/mroI6WeKvrJztldMSJLB4TWQ4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7Xaidty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163CEC433F1;
	Sat,  6 Apr 2024 14:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712415420;
	bh=H7r4BwHYdEAkivbchzdrbMt8uQAr7fq8c2kkzMTjysk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t7XaidtysS/mL4yRu/ZNJPnY2CXH2LEHOBo8qFRjr1egb4qlFtKO8rrd81+/2cXaA
	 UrbiEdU9+EMPXyw2pqGWkHWtd8GETehuKheyXQQihZraZld8T7z6OXHV2III0aqaF0
	 +Ba5bv/mqOqL6Jq/IF+iKX3txDS11I8tLhzjQ+Qi5LHkTyV0kNtM4fk0BAPswBendF
	 oFJF9eO27YWR/vkb51Q58Mkde3vZJcrUTSGnZ30L87EqjY0z64nuWzMjBebeYC+CsE
	 XVTbdEmdJdBbi+p6evdJuZJMtDtHoaJphUDqFvkF9skddHdFm44CSsPeqyB3hUwatW
	 Xk1ZwiQxwrRYA==
Date: Sat, 6 Apr 2024 15:56:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH 2/6] iio: adc: ad7173: fix buffers enablement for
 ad7176-2
Message-ID: <20240406155646.694f710b@jic23-huawei>
In-Reply-To: <20240401-ad4111-v1-2-34618a9cc502@analog.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
	<20240401-ad4111-v1-2-34618a9cc502@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Apr 2024 18:32:20 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> AD7176-2 does not feature input buffers, enable buffers only on
>  supported models.
> 
> Fixes: cff259bf7274 ("iio: adc: ad7173: fix buffers enablement for ad7176-2")
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>

How bad is this?  If you can find out if writing those bits does anything
harmful (they are reserved and datasheet says should be written 0 I think)
That will help people decide whether to backport the fix?

> ---
>  drivers/iio/adc/ad7173.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index f6d29abe1d04..8a95b1391826 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -145,6 +145,7 @@ struct ad7173_device_info {
>  	unsigned int id;
>  	char *name;
>  	bool has_temp;
> +	bool has_input_buf;
>  	bool has_int_ref;
>  	bool has_ref2;
>  	u8 num_gpios;
> @@ -212,6 +213,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 4,
>  		.num_gpios = 2,
>  		.has_temp = true,
> +		.has_input_buf = true,
>  		.has_int_ref = true,
>  		.clock = 2 * HZ_PER_MHZ,
>  		.sinc5_data_rates = ad7173_sinc5_data_rates,
> @@ -224,6 +226,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 8,
>  		.num_gpios = 4,
>  		.has_temp = false,
> +		.has_input_buf = true,
>  		.has_ref2 = true,
>  		.clock = 2 * HZ_PER_MHZ,
>  		.sinc5_data_rates = ad7173_sinc5_data_rates,
> @@ -237,6 +240,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 8,
>  		.num_gpios = 4,
>  		.has_temp = true,
> +		.has_input_buf = true,
>  		.has_int_ref = true,
>  		.has_ref2 = true,
>  		.clock = 2 * HZ_PER_MHZ,
> @@ -251,6 +255,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 4,
>  		.num_gpios = 2,
>  		.has_temp = true,
> +		.has_input_buf = true,
>  		.has_int_ref = true,
>  		.clock = 16 * HZ_PER_MHZ,
>  		.sinc5_data_rates = ad7175_sinc5_data_rates,
> @@ -263,6 +268,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 8,
>  		.num_gpios = 4,
>  		.has_temp = true,
> +		.has_input_buf = true,
>  		.has_int_ref = true,
>  		.has_ref2 = true,
>  		.clock = 16 * HZ_PER_MHZ,
> @@ -289,6 +295,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
>  		.num_configs = 4,
>  		.num_gpios = 2,
>  		.has_temp = true,
> +		.has_input_buf = true,
>  		.has_int_ref = true,
>  		.clock = 16 * HZ_PER_MHZ,
>  		.odr_start_value = AD7177_ODR_START_VALUE,
> @@ -932,7 +939,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  			AD7173_CH_ADDRESS(chan_arr[chan_index].channel,
>  					  chan_arr[chan_index].channel2);
>  		chan_st_priv->cfg.bipolar = false;
> -		chan_st_priv->cfg.input_buf = true;
> +		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
>  		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>  
> @@ -989,7 +996,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  
>  		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
>  		chan_st_priv->chan_reg = chan_index;
> -		chan_st_priv->cfg.input_buf = true;
> +		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.odr = 0;
>  
>  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
> 


