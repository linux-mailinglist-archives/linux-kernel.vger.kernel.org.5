Return-Path: <linux-kernel+bounces-152243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F9D8ABB4C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278561C20CB6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930329425;
	Sat, 20 Apr 2024 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nvtt52Jp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E6A179A8;
	Sat, 20 Apr 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611985; cv=none; b=Q3M44pocgJrNaAAVaz7DnwkG3qarbVpGVTcZrzYNGT593q/QSaeWs4iZdDVM7TYbx/TtD9HcaFvoKu7RxwUVcZSGkPYcgupB1G7iaFa5IFkYLkCwWC7Nsy2W89cVYbSpxz0YtTHsUt/v5BrZjjGZ3TQaGnk98wWrq70ernSVGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611985; c=relaxed/simple;
	bh=iBr9YZ8SOZTOAUJpTCJ44n0d905eTuzIANCWXoPwtbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctOAveey/Am7104pAnhPbe/c8+tWuKqtKzCueYNIMh2Wyc3pg+Jut+/EWFiifCrWIH4DdPTh0S+tAeXZ7wL2z7X0GInW3nBXRtboIYawodbXeuqbdZw4z/0IXhCG72WClEy8lgFuroGJVpjgx87eiT/lHb7f1X6vxUxqftrZLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nvtt52Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8A5C072AA;
	Sat, 20 Apr 2024 11:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713611984;
	bh=iBr9YZ8SOZTOAUJpTCJ44n0d905eTuzIANCWXoPwtbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nvtt52JpVsLO6yPJGc6piA5JroYfOTIHUvfEBtdNi1EW4F3LSApc2cPdSDJpiATrC
	 GmRKzsc7mzyd0AE82E+d7FeYR67GSORtem1hFQ4hGUFgkIMxU9gTvTm6GGx3CGg6kE
	 vY029VZfS6KE/nOJ+GcoD+kYaDQu4rYAqehiR1R9WH2H7XzdM4fDoqAADKlz3n6ORE
	 C1VmMqr5b5/ZgyCUkj+4udM5bn5mq66D+3iecB+a71rpcbaMk4cy7qFzORUBC2JmUE
	 OPMryCqHmQwF+D6bCXnUVLi/589scYU0EFojbsiysJshb56sO1JBvVyzGsGcWWa/MY
	 NkP5K1NCbRswQ==
Date: Sat, 20 Apr 2024 12:19:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>, dlechner@baylibre.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, jstephan@baylibre.com
Subject: Re: [PATCH] iio: adc: ad7606: remove frstdata check
Message-ID: <20240420121933.13a0e22f@jic23-huawei>
In-Reply-To: <20240417-cleanup-ad7606-v1-1-5c2a29662c0a@baylibre.com>
References: <20240417-cleanup-ad7606-v1-1-5c2a29662c0a@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 09:11:18 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Frstdata pin is set high during the first sample's transmission and
> then set low.
> This code chunk attempts to recover from an eventual glitch in the clock
> by checking frstdata state after reading the first channel's sample.
> Currently, in serial mode, this check happens AFTER the 16th pulse, and if
> frstdata is not set it resets the device and returns EINVAL.
> According to the datasheet, "The FRSTDATA output returns to a logic low
> following the 16th SCLK falling edge.", thus after the 16th pulse, the check
> will always be true, and the driver will not work as expected.
> Even if it was working, the usefulness of this check is limited, since
> it would only detect a glitch on the first channel, but not on the
> following ones, and the convst pulse will reset the communication sequence at
> each new conversion.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

Michael, I'm sure you remember this well - it was only 13 years ago you wrote
this...

https://lore.kernel.org/all/1296744691-24320-1-git-send-email-michael.hennerich@analog.com/

Anyhow, I'd like an Ack or a statement of you have no idea any more and i should
go with what Guillaume has worked out...

Jonathan

> ---
> This is the first commit of cleanup series. It will be followed by more
> cleanups and support for more parts and features.

Sounds good.

> ---
>  drivers/iio/adc/ad7606.c | 30 ------------------------------
>  drivers/iio/adc/ad7606.h |  3 ---
>  2 files changed, 33 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 1928d9ae5bcf..f85eb0832703 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -88,31 +88,6 @@ static int ad7606_read_samples(struct ad7606_state *st)
>  {
>  	unsigned int num = st->chip_info->num_channels - 1;
>  	u16 *data = st->data;
> -	int ret;
> -
> -	/*
> -	 * The frstdata signal is set to high while and after reading the sample
> -	 * of the first channel and low for all other channels. This can be used
> -	 * to check that the incoming data is correctly aligned. During normal
> -	 * operation the data should never become unaligned, but some glitch or
> -	 * electrostatic discharge might cause an extra read or clock cycle.
> -	 * Monitoring the frstdata signal allows to recover from such failure
> -	 * situations.
> -	 */
> -
> -	if (st->gpio_frstdata) {
> -		ret = st->bops->read_block(st->dev, 1, data);
> -		if (ret)
> -			return ret;
> -
> -		if (!gpiod_get_value(st->gpio_frstdata)) {
> -			ad7606_reset(st);
> -			return -EIO;
> -		}
> -
> -		data++;
> -		num--;
> -	}
>  
>  	return st->bops->read_block(st->dev, num, data);
>  }
> @@ -450,11 +425,6 @@ static int ad7606_request_gpios(struct ad7606_state *st)
>  	if (IS_ERR(st->gpio_standby))
>  		return PTR_ERR(st->gpio_standby);
>  
> -	st->gpio_frstdata = devm_gpiod_get_optional(dev, "adi,first-data",
> -						    GPIOD_IN);
> -	if (IS_ERR(st->gpio_frstdata))
> -		return PTR_ERR(st->gpio_frstdata);
> -
>  	if (!st->chip_info->oversampling_num)
>  		return 0;
>  
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 0c6a88cc4695..eacb061de6f8 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -80,8 +80,6 @@ struct ad7606_chip_info {
>   * @gpio_range		GPIO descriptor for range selection
>   * @gpio_standby	GPIO descriptor for stand-by signal (STBY),
>   *			controls power-down mode of device
> - * @gpio_frstdata	GPIO descriptor for reading from device when data
> - *			is being read on the first channel
>   * @gpio_os		GPIO descriptors to control oversampling on the device
>   * @complete		completion to indicate end of conversion
>   * @trig		The IIO trigger associated with the device.
> @@ -108,7 +106,6 @@ struct ad7606_state {
>  	struct gpio_desc		*gpio_reset;
>  	struct gpio_desc		*gpio_range;
>  	struct gpio_desc		*gpio_standby;
> -	struct gpio_desc		*gpio_frstdata;
>  	struct gpio_descs		*gpio_os;
>  	struct iio_trigger		*trig;
>  	struct completion		completion;
> 
> ---
> base-commit: 62d3fb9dcc091ccdf25eb3b716e90e07e3ed861f
> change-id: 20240416-cleanup-ad7606-161e2ed9818b
> 
> Best regards,


