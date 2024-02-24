Return-Path: <linux-kernel+bounces-79776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E64862687
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5971F21EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6990C482DA;
	Sat, 24 Feb 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGF+qR6P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA0ECE;
	Sat, 24 Feb 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797545; cv=none; b=oUnA9nWexbLmjEx7Lo9voy9H4kL/x05RacFBD62S3J1GQ+rGtLKijDJArLRFQ5lBXCYTW0wwxVUCJErPS/rl5UkyT+mp9SLYhjNaIBcRv7/Flq9OGxW88L/zgmcwIcDORea64K4/X7xdKmLpRyRQ6s9iTPHO6HUmS1ICDX2EIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797545; c=relaxed/simple;
	bh=dYi/dilkwURl8LO3PZnPi1vvfmdVHEam1XBWXkIjSkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJ/4/VLqeDBysuLSO+yP0HB0bxmmcxoBUt9UT7FJL5jC0UNLimVLrZbZR3pOkWYVsMgkX5nxwyxDdkYz2k0dxFcQo+oBESmsw7pqmmOO1gf3wBz2TFkAYJKDAOwfis0vbpK+PLBXg2UO8OpOt9KAl+qF4j7YNF9Mpx542FcE7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGF+qR6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BD8C433C7;
	Sat, 24 Feb 2024 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708797545;
	bh=dYi/dilkwURl8LO3PZnPi1vvfmdVHEam1XBWXkIjSkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JGF+qR6Pje6gZApaVmR0Jc9qKIuUcU3mlvJqjz4ZKod6QKREXm0BPUoG8Qx7X6Qx6
	 ArzSCvL1QjyGbxlz/7GT3MNGSOwt6xjYBLepIHNae+VbCN5g5rmZ0v127fQ3otIt4h
	 3FvvZnZJtPxgoJH+u3W/BH/c7PKSxEFckmGt2iHKTAUkHIaPe0MP0d1/cLHX5bUpPk
	 ZVLeqp4eYcccn1eYMmpupsje+MgcWRqwk0fS5QbnvNWcEJk//j7NdJHjxhozc//gfw
	 0TVejky85PoDTlp2/SsNvuQtm1H25nuS52Mywm11HbTA5x9oRCyHGi5b8+zyYX3ylf
	 R0pC2zp35AsWg==
Date: Sat, 24 Feb 2024 17:58:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <20240224175851.2a60d6b4@jic23-huawei>
In-Reply-To: <ZdUEL4zTfCZpWSyt@smile.fi.intel.com>
References: <20240220184125.32602-1-vassilisamir@gmail.com>
	<ZdUEL4zTfCZpWSyt@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 21:57:35 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Feb 20, 2024 at 07:41:24PM +0100, Vasileios Amoiridis wrote:
> > According to the datasheet of BMP38x and BMP390 devices, for an SPI
> > read operation the first byte that is returned needs to be dropped,
> > and the rest of the bytes are the actual data returned from the
> > sensor.  
> 
> ...
> 
> > +static int bmp380_regmap_spi_read(void *context, const void *reg,
> > +				  size_t reg_size, void *val, size_t val_size)
> > +{
> > +	struct spi_device *spi = to_spi_device(context);
> > +	u8 rx_buf[4];
> > +	ssize_t status;
> > +
> > +	/*
> > +	 * Maximum number of consecutive bytes read for a temperature or
> > +	 * pressure measurement is 3.
> > +	 */
> > +	if (val_size > 3)
> > +		return -EINVAL;  
> 
> I would add a blank line here.
> 
> > +	/*
> > +	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
> > +	 * the first byte needs to be dropped and the rest are the requested
> > +	 * data.
> > +	 */
> > +	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
> > +	if (status)
> > +		return status;
> > +
> > +	memcpy(val, rx_buf + 1, val_size);
> > +
> > +	return 0;
> > +}  
> 
> With above and bits.h location being addressed
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
I'd picked up previous version and tweaked it for the header being first.
Now updated the spacing above and added your tag.

Only did this rebase because it was the top of my fixes tree.



