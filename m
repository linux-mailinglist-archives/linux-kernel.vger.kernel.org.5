Return-Path: <linux-kernel+bounces-161464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF18B4C56
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61867281991
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1F86EB5C;
	Sun, 28 Apr 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYW8fSX2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728831A81;
	Sun, 28 Apr 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714316850; cv=none; b=oq9cD/i+aw3CNrP3X4bTwULqS3CpCadpDembSD8bmlSPODybHFFC4mdlvraiu3ixhmwQPBlGPxiLKv5Ju5oQPGUnh5hj4YurpEeiM8SruYc+JRnIXsmC1oEQIR1dPxLoQKeesI+q/sRP8UshU3eUyGn1ok/F/UQU7Dm7oDNOrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714316850; c=relaxed/simple;
	bh=3vofxZ5dOxVgjGw9YNeLDNWOQwfjkT8OukmW+wWJ3tU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UL7rgo4pOw8xaMzbh8AFSDlbc5+FI5WtN8W6ZHUoGPXFrtx86hYm/+NZDXqeol7uPjfQc71SdtLbvqOMdkZXTWmacaa9FfGwoF/iIqbMLrLt98hPZK9rbXwVl/UP5bsfXGPEpZieBJhMSEEEX3LjczqfRQxQDxaJ/Cv5/dWALSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYW8fSX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16F3C113CC;
	Sun, 28 Apr 2024 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714316849;
	bh=3vofxZ5dOxVgjGw9YNeLDNWOQwfjkT8OukmW+wWJ3tU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AYW8fSX2tJBFRvWSNzRyXgIvE10icGBTmyY4jCGqK7+G9+ATVgHNez9MXM/XTX1LB
	 QXgzykZU8A2OSJUUC7utVS97V+yyNgpdN9oDBGeapjKe287IeB4I/C+oQ0jg7CGuRf
	 8M1W1VyTCJOwy6H6nxZV6wMwbf95VlBcg6EhTFFKtaqArtGa7NaSGuzZaLNM3C8qRi
	 1OeHVq5RSRe6p5JaSI5bjxN5r81oxf5jOsBvmD9pj8Zys7jNLV96geSndMSSEU6Ou1
	 gLv58S5ST3GEtoZHTXaztgomdWhYI923r3FiwiK93xljp8/9AJCzf8luc8Ie06ypdT
	 RkpTToJkwp1eA==
Date: Sun, 28 Apr 2024 16:07:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net,
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH 2/5] iio: imu: adis16480.c: Add delta angle and delta
 velocity channels
Message-ID: <20240428160718.45480db8@jic23-huawei>
In-Reply-To: <20240428160438.424e33d2@jic23-huawei>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	<20240423084210.191987-3-ramona.gradinariu@analog.com>
	<20240428160438.424e33d2@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Apr 2024 16:04:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 23 Apr 2024 11:42:07 +0300
> Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
> 
> > Add support for delta angle and delta velocity raw readings to
> > adis16480 driver.  
> 
> Why are these not allowed via the buffer interface?   Normally
> my expectation of delta values is they are more or less useless
> without buffered capture. The intent of providing those channels
> is that they are gathered over time and summed up to give the
> angle difference (for example) between start of capture and now.
> Note the formula on the datasheet 
> https://www.analog.com/media/en/technical-documentation/data-sheets/adis16545-16547.pdf
> looks wrong (formula 3) as it's adding the signals at time
> nD + d and at nD + D - 1 whereas for a delta you'd subtract those
> (maybe I'm reading that wrong).
> 
> If we are providing these values as raw readings I'd expect them
> to be presented as delta_angle / time (e.g. rate of change of angle) and
> delta_velocity / time = acceleration (be it slightly distorted vs
> the acceleration measured as a result of oversampling.).
> So basically spot measurements of delta values are normally pretty
> useless.
> 
> My guess is that you did this because the device either seems
> to allow burst reads of the main channels or of these delta
> values?
> 
> If so consider using available_scan_masks to allow one or the
> other set of channels rather than not allowing capture of these
> via the buffered interfaces.

I see from later patch that this was adding support to parts that
don't support grabbing these in burst mode.  Please make that clearer
in this patch description and list the parts to which this support
applied.

I'm a bit dubious of it being a useful feature, but maybe it is
worth supporting.

Jonathan

> 
> Jonathan
> 
> 
> 
> > 
> > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > ---
> >  drivers/iio/imu/adis16480.c | 78 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 76 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> > index bc6cbd00cd4b..4adc2244a4ef 100644
> > --- a/drivers/iio/imu/adis16480.c
> > +++ b/drivers/iio/imu/adis16480.c
> > @@ -140,6 +140,8 @@ struct adis16480_chip_info {
> >  	unsigned int accel_max_val;
> >  	unsigned int accel_max_scale;
> >  	unsigned int temp_scale;
> > +	unsigned int deltang_max_val;
> > +	unsigned int deltvel_max_val;
> >  	unsigned int int_clk;
> >  	unsigned int max_dec_rate;
> >  	const unsigned int *filter_freqs;
> > @@ -445,6 +447,12 @@ enum {
> >  	ADIS16480_SCAN_MAGN_Z,
> >  	ADIS16480_SCAN_BARO,
> >  	ADIS16480_SCAN_TEMP,
> > +	ADIS16480_SCAN_DELTANG_X,
> > +	ADIS16480_SCAN_DELTANG_Y,
> > +	ADIS16480_SCAN_DELTANG_Z,
> > +	ADIS16480_SCAN_DELTVEL_X,
> > +	ADIS16480_SCAN_DELTVEL_Y,
> > +	ADIS16480_SCAN_DELTVEL_Z,
> >  };
> >  
> >  static const unsigned int adis16480_calibbias_regs[] = {
> > @@ -688,6 +696,14 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
> >  			*val = 131; /* 1310mbar = 131 kPa */
> >  			*val2 = 32767 << 16;
> >  			return IIO_VAL_FRACTIONAL;
> > +		case IIO_DELTA_ANGL:
> > +			*val = st->chip_info->deltang_max_val;
> > +			*val2 = 31;
> > +			return IIO_VAL_FRACTIONAL_LOG2;
> > +		case IIO_DELTA_VELOCITY:
> > +			*val = st->chip_info->deltvel_max_val;
> > +			*val2 = 31;
> > +			return IIO_VAL_FRACTIONAL_LOG2;
> >  		default:
> >  			return -EINVAL;
> >  		}
> > @@ -761,6 +777,30 @@ static int adis16480_write_raw(struct iio_dev *indio_dev,
> >  	BIT(IIO_CHAN_INFO_CALIBSCALE), \
> >  	32)
> >  
> > +#define ADIS16480_DELTANG_CHANNEL(_mod) \
> > +	ADIS16480_MOD_CHANNEL(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
> > +	ADIS16480_REG_ ## _mod ## _DELTAANG_OUT, ADIS16480_SCAN_DELTANG_ ## _mod, \
> > +	0, \  
> 
> Trivial but why this line wrap?  I'd push 32 onto the line above at least.
> 
> > +	32)
> > +
> > +#define ADIS16480_DELTANG_CHANNEL_NO_SCAN(_mod) \
> > +	ADIS16480_MOD_CHANNEL(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
> > +	ADIS16480_REG_ ## _mod ## _DELTAANG_OUT, -1, \
> > +	0, \
> > +	32)
> > +
> > +#define ADIS16480_DELTVEL_CHANNEL(_mod) \
> > +	ADIS16480_MOD_CHANNEL(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
> > +	ADIS16480_REG_ ## _mod ## _DELTAVEL_OUT, ADIS16480_SCAN_DELTVEL_ ## _mod, \
> > +	0, \
> > +	32)
> > +
> > +#define ADIS16480_DELTVEL_CHANNEL_NO_SCAN(_mod) \
> > +	ADIS16480_MOD_CHANNEL(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
> > +	ADIS16480_REG_ ## _mod ## _DELTAVEL_OUT, -1, \
> > +	0, \
> > +	32)  
> 


