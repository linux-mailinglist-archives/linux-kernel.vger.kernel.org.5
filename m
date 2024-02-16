Return-Path: <linux-kernel+bounces-68498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB7B857B28
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1B71C23B71
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117ED60EE3;
	Fri, 16 Feb 2024 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUr/PeLl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D35C65193;
	Fri, 16 Feb 2024 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081557; cv=none; b=B7uBkjWU9KbU4TnoRQgVCcf2nxgJDQjr5C2kBzMiK3vUf9RueC+MLwXLoFRGGYXg4a9n8+zoxrMV0jshIcepb+j3QdrnqYdwLoO17yd5ftjyFUVgB+jKoLF9oCgTC8O/OTtUcnAX3eO/9ttSKNXi2dg5ndteX2FYIzD2ByOwIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081557; c=relaxed/simple;
	bh=9EwGRDiJUOCQYFRJiAC9JK5wa11kNaXqYFEr9m1LBXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHGZacx8oOWd4+HrNjVHu3DvU+W/eInM4wsBtsozQ/RaDjBpnhxcd0q+bkySmvK0mWkOCOqrae+t1nasyPOAVRdGHaudGTUrWYUmj07V3Y9BEKmWrE7OxZAiwVz5bdMI57D0aCFYwKV7ecNh4TmKBe+hT/3Q+A59WPW4n27x2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUr/PeLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7011BC433F1;
	Fri, 16 Feb 2024 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708081556;
	bh=9EwGRDiJUOCQYFRJiAC9JK5wa11kNaXqYFEr9m1LBXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tUr/PeLlXLrcCeA8bz9B7z5OEd4rXjFpW7Jcpru53mBQK0XYTWFg3ovrgPrPj8PII
	 BsX8YUTpL+Xf2J4nyojXidQ0RNCBnb2P6x7xypkdjCWnpA0f8nP3AbT2lMa9Quela+
	 /X89F3sPJV9ztGQ0+5hDGDM1O2Cdt8AU+0FXX+dEBqrOeyA+eXfg2p8jWiyD+0Yosz
	 uzUdXEr73HYuu++3e/2FUDx6ILb6wVPPxGzSvHUTb/+cGUEmgiw8hjwieFJrvQbjHq
	 ymbNDzYlRCnI8obgptfdqrDhjT0w2zVxLCHZN80HpQ0eG37EOX0MUmK04qcPhtr+3J
	 t87c6twyf0/lw==
Date: Fri, 16 Feb 2024 11:05:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Add SPI support for BMP38x and
 BMP390
Message-ID: <20240216110543.5d6289f6@jic23-huawei>
In-Reply-To: <Zc5D35_4FdERZXe4@smile.fi.intel.com>
References: <20240215164332.506736-1-vassilisamir@gmail.com>
	<Zc5D35_4FdERZXe4@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 19:03:27 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Feb 15, 2024 at 05:43:32PM +0100, Vasileios Amoiridis wrote:
> > According to the datasheet of BMP38x and BMP390 devices, in SPI
> > operation, the first byte that returns after a read operation is
> > garbage and it needs to be dropped and return the rest of the
> > bytes.  
> 
> Thank you for the patch, my comments below.
> 
> ...
> 
> > +static int bmp380_regmap_spi_read(void *context, const void *reg,
> > +				  size_t reg_size, void *val, size_t val_size)
> > +{
> > +	struct spi_device *spi = to_spi_device(context);
> > +	u8 ret[BMP380_SPI_MAX_REG_COUNT_READ + 1];
> > +	ssize_t status;
> > +	u8 buf;  
> 
> AFAIU this buffer is not DMA-capable.

Doesn't matter in this case as spi_write_then_read() bounces anyway so you don't need
to provide it with a dma safe buffer. It's in the docs, so we can rely
on this not changing.

https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L4391


