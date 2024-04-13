Return-Path: <linux-kernel+bounces-143824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F888A3DE0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26FD8B2141E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7240C4AEF9;
	Sat, 13 Apr 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebxWUSHh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35DE262BD;
	Sat, 13 Apr 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713028029; cv=none; b=iF2AZKr2vRblB5QNZPv3r+rxuG8K9qaTA19dtAK/QqjX/DCgcehzcw1vM9m8hICIN+PIR45PicSs54I/SbVnYHv4LHuxqUuDoOu/Fpvy4hNOZ8ymGj53Cfc3FZ1UC9jkvByV/1+5Udqu4Q+ce+wnsRtU6O4g6Sz8zJs5edcQnEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713028029; c=relaxed/simple;
	bh=flcPES28k6bVBGU75yXASImr1jMZq2nhe3p/0JjafvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ToTA83R+iSxIiU6FB16CZ0LqQfEQNS5GaHn1pNUFXBB7Uo+UzEpbuRzf//JQc4KBLqSRJTMmOScG/+YftRRZbZXwMw6KDYaMULzT5xslJKK+SjDuJ7gTStQhz3VoafBttJKw18lnFg4GZziiG9UuYVOFL6gqUKRB1nL6uwm5PQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebxWUSHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E4DC113CD;
	Sat, 13 Apr 2024 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713028029;
	bh=flcPES28k6bVBGU75yXASImr1jMZq2nhe3p/0JjafvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ebxWUSHhUtr3LH5yZlkmwlJOa+Ll6iaVxRWwf4mzxcfLcwr7YZTnCH1x3v7JxOdN9
	 HGxN2a12iZUaPFvB42KEb+59ASazLG6pUV1pY8Pb+FgViub1f/ydkdVFLXHfLMwRE2
	 n57ojEV77C3hJJ4CGDtnLN83q2Np8V0zHmaQhLp6taaTCij6Bx1yHM5ItoAC9Z4ad8
	 d9Q657y52uBtP/KsH2n2Ho5yQIZVutzCC+1aPqnt2pUjyPn5c7Z7eujigvbUJCGctT
	 shib7LOQNu335xNNwB3wfEFgSrm8ofxHt73pLKJpGoynErk2MXEqE1hBo2i0Md5LyO
	 pTc/i+0BBXFJQ==
Date: Sat, 13 Apr 2024 18:06:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 u.kleine-koenig@pengutronix.de, biju.das.jz@bp.renesas.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240413180651.1eedce99@jic23-huawei>
In-Reply-To: <20240407172920.264282-7-vassilisamir@gmail.com>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
	<20240407172920.264282-7-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Apr 2024 19:29:20 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> temperature, pressure and humidity readings. This facilitates the
> use of burst/bulk reads in order to acquire data faster. The
> approach is different from the one used in oneshot captures.
> 
> BMP085 & BMP1xx devices use a completely different measurement
> process that is well defined and is used in their buffer_handler().
> 
> Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Hi,

A few things inline.

Jonathan

> ---
>  drivers/iio/pressure/Kconfig       |   2 +
>  drivers/iio/pressure/bmp280-core.c | 338 +++++++++++++++++++++++++++--
>  drivers/iio/pressure/bmp280-spi.c  |   8 +-
>  drivers/iio/pressure/bmp280.h      |  21 +-
>  4 files changed, 347 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 3ad38506028e..0b5406a3f85d 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -31,6 +31,8 @@ config BMP280
>  	select REGMAP
>  	select BMP280_I2C if (I2C)
>  	select BMP280_SPI if (SPI_MASTER)
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Bosch Sensortec BMP180, BMP280, BMP380
>  	  and BMP580 pressure and temperature sensors. Also supports the BME280 with
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 1b894feb717b..32dd35475826 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -41,7 +41,10 @@

>
> 
>  
> +static irqreturn_t bmp580_buffer_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	s32 adc_temp, adc_press;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	/* If humidity channel is enabled it means that we are called for the
> +	 * BME280 humidity sensor.
Please match IIO multiline comment syntax. Like most of the kernel.

	/*
	 * If ...

> +	 */
> +



..

> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index ccba779d7a83..0373d5f9b9a8 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -301,6 +301,16 @@

>  /* Core exported structs */
>  
>  static const char *const bmp280_supply_names[] = {
> @@ -394,13 +404,19 @@ struct bmp280_data {
>  	 */
>  	int sampling_freq;
>  
> +	/*
> +	 * Data to push to userspace triggered buffer. Up to 3 channels and
> +	 * s64 timestamp, aligned.
> +	 */
> +	s32 sensor_data[5] __aligned(8);
For the timestamp to be aligned (which is the reason this is __aligned(8))
when landing at the end of the buffer, the buffer needs to be a multiple of 8
bytes.

3 channel, 32bit padding, s64 timestamp. So [6]

On the todo list is to add runtime checking to the IIO core on these buffers
being big enough which would have caught this, but I haven't gotten started
on that project yet.

Jonathan
> +

