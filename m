Return-Path: <linux-kernel+bounces-161463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47CD8B4C51
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF7F1F212C4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE66EB59;
	Sun, 28 Apr 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj9My2hP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8486A8A0;
	Sun, 28 Apr 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714316688; cv=none; b=eGoyLj9SEto9yqJuJTQX8QJ/O/6EOcsG/xW0t2eo7Ii4f94eiq9f016UKc5+Nm8Oak2RRDczg0GV+TwGrIy4Zu9ctD2Q6FfLa3wdmKJCuzM08bC2lYN3wyLanPMIgqnKTW7SNbYEQaQoy79pJ+RDd0on5Cy2gIL+xWIBk+dyOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714316688; c=relaxed/simple;
	bh=+GqHU7a9ra3T6Y0nb2mmVQSYhBd/G4kHj/saCxthdzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccRuHRVMXosQ7ZF3qtev+0z+XmR3FGp6rq01fEmsceik/0ZzVicHMZI7SwR7dsk7V3jekSc8P598bALpHdNdofIf89Rng/lllOmqB9wl9MsR/jGhcVNi1S60qSWSpeaD7w1nrLqz4qosP8EPvluJsdsfLnQvpcRPAhomvbrc6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj9My2hP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4016BC113CC;
	Sun, 28 Apr 2024 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714316688;
	bh=+GqHU7a9ra3T6Y0nb2mmVQSYhBd/G4kHj/saCxthdzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bj9My2hPIKGtcZ90jAdKkFF1W7yQoSLxJCvsgsRPYoAC77clALC2I/hIjt5qD89Ng
	 RfxS/KA1dUaVxGrQw29jXlko5ECweMvEka7HpC2bvLwsXJ4gLqT5LECttdul7u1B9Q
	 1q08aY8jztg8OEYiVOrgYV0xLGUCjn/1PeAlAgy6jAgwZIZhoMDGlpz9J25Pc1ALkO
	 KPlle+INMF1DTGnTJSyOA2Vien7JlPQ9NZjVPNyYvCCDDZhDznY0hveS/IFST9vWj8
	 TsIHj7FxhoEdVQHEj5gZbw9u5K/MyAS9hbKO/h9l0Bu+Gq2f7ILsIuW++7FhClj9cw
	 XlgejYj0N3IKQ==
Date: Sun, 28 Apr 2024 16:04:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net,
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH 2/5] iio: imu: adis16480.c: Add delta angle and delta
 velocity channels
Message-ID: <20240428160438.424e33d2@jic23-huawei>
In-Reply-To: <20240423084210.191987-3-ramona.gradinariu@analog.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	<20240423084210.191987-3-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 11:42:07 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> Add support for delta angle and delta velocity raw readings to
> adis16480 driver.

Why are these not allowed via the buffer interface?   Normally
my expectation of delta values is they are more or less useless
without buffered capture. The intent of providing those channels
is that they are gathered over time and summed up to give the
angle difference (for example) between start of capture and now.
Note the formula on the datasheet 
https://www.analog.com/media/en/technical-documentation/data-sheets/adis16545-16547.pdf
looks wrong (formula 3) as it's adding the signals at time
nD + d and at nD + D - 1 whereas for a delta you'd subtract those
(maybe I'm reading that wrong).

If we are providing these values as raw readings I'd expect them
to be presented as delta_angle / time (e.g. rate of change of angle) and
delta_velocity / time = acceleration (be it slightly distorted vs
the acceleration measured as a result of oversampling.).
So basically spot measurements of delta values are normally pretty
useless.

My guess is that you did this because the device either seems
to allow burst reads of the main channels or of these delta
values?

If so consider using available_scan_masks to allow one or the
other set of channels rather than not allowing capture of these
via the buffered interfaces.

Jonathan



> 
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---
>  drivers/iio/imu/adis16480.c | 78 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index bc6cbd00cd4b..4adc2244a4ef 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -140,6 +140,8 @@ struct adis16480_chip_info {
>  	unsigned int accel_max_val;
>  	unsigned int accel_max_scale;
>  	unsigned int temp_scale;
> +	unsigned int deltang_max_val;
> +	unsigned int deltvel_max_val;
>  	unsigned int int_clk;
>  	unsigned int max_dec_rate;
>  	const unsigned int *filter_freqs;
> @@ -445,6 +447,12 @@ enum {
>  	ADIS16480_SCAN_MAGN_Z,
>  	ADIS16480_SCAN_BARO,
>  	ADIS16480_SCAN_TEMP,
> +	ADIS16480_SCAN_DELTANG_X,
> +	ADIS16480_SCAN_DELTANG_Y,
> +	ADIS16480_SCAN_DELTANG_Z,
> +	ADIS16480_SCAN_DELTVEL_X,
> +	ADIS16480_SCAN_DELTVEL_Y,
> +	ADIS16480_SCAN_DELTVEL_Z,
>  };
>  
>  static const unsigned int adis16480_calibbias_regs[] = {
> @@ -688,6 +696,14 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
>  			*val = 131; /* 1310mbar = 131 kPa */
>  			*val2 = 32767 << 16;
>  			return IIO_VAL_FRACTIONAL;
> +		case IIO_DELTA_ANGL:
> +			*val = st->chip_info->deltang_max_val;
> +			*val2 = 31;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case IIO_DELTA_VELOCITY:
> +			*val = st->chip_info->deltvel_max_val;
> +			*val2 = 31;
> +			return IIO_VAL_FRACTIONAL_LOG2;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -761,6 +777,30 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
>  	BIT(IIO_CHAN_INFO_CALIBSCALE), \
>  	32)
>  
> +#define ADIS16480_DELTANG_CHANNEL(_mod) \
> +	ADIS16480_MOD_CHANNEL(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
> +	ADIS16480_REG_ ## _mod ## _DELTAANG_OUT, ADIS16480_SCAN_DELTANG_ ## _mod, \
> +	0, \

Trivial but why this line wrap?  I'd push 32 onto the line above at least.

> +	32)
> +
> +#define ADIS16480_DELTANG_CHANNEL_NO_SCAN(_mod) \
> +	ADIS16480_MOD_CHANNEL(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
> +	ADIS16480_REG_ ## _mod ## _DELTAANG_OUT, -1, \
> +	0, \
> +	32)
> +
> +#define ADIS16480_DELTVEL_CHANNEL(_mod) \
> +	ADIS16480_MOD_CHANNEL(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
> +	ADIS16480_REG_ ## _mod ## _DELTAVEL_OUT, ADIS16480_SCAN_DELTVEL_ ## _mod, \
> +	0, \
> +	32)
> +
> +#define ADIS16480_DELTVEL_CHANNEL_NO_SCAN(_mod) \
> +	ADIS16480_MOD_CHANNEL(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
> +	ADIS16480_REG_ ## _mod ## _DELTAVEL_OUT, -1, \
> +	0, \
> +	32)


