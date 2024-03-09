Return-Path: <linux-kernel+bounces-98012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F287734E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BF81F21919
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F445BE0;
	Sat,  9 Mar 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucyHH28V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20945037;
	Sat,  9 Mar 2024 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009432; cv=none; b=BB6FWkFpVvLrmUnCILFvLQ0MVpPPBHW91BJ0tbCk5BxK8MR3S7NA/1yn6vqEGrhtFtAtgQAc9/r81zaLeMhmQ0p4ausdQpmkOsg5r4+n3stGa973zdr+m1Wm0/a11FHyGwBN1Yg/2nhJQZN1sob5jsiQAmXfu8jXQMospRuxlTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009432; c=relaxed/simple;
	bh=QW7Gm46e+mmwfVPg98I+PIYT9eH/t++qHQlKXDiQ9pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5bl0djV1O6z/+6QIMjLIcNwFygQh7KNYLd/glojd2YGetFPlnjwH/6ijxPmNM59LpaBh/0eLP8YSQy/db5apsrhvekeItym4WP4vN3jv1h51hpj1hiinasD5HY8PyO7MftGciOCIXnxnCTR6ZOrCyBhRBh8QkRNugzuRpqO330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucyHH28V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4F6C433C7;
	Sat,  9 Mar 2024 18:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009432;
	bh=QW7Gm46e+mmwfVPg98I+PIYT9eH/t++qHQlKXDiQ9pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ucyHH28VOYLm1i/YEe/fQPBAb5m8/NoSYPrgjtI8r7GfX4M0NFgpBnX6eKe1l6INn
	 EhrRwpqDDkXm1E+siDN44uHAJrimeUlGzl8et6l97fkeUbnu2EqDuzqZj6jgdESyTY
	 55jZ0jJQkgx7bnhWJCdoaDwjjR1s7yiB2Vd1yUpckHrLykHz0crwDdD2cf6mhnj/AU
	 LZesoxIQos5PGygbsEb6Qoo5pPkd7rMNQ27Mq3ZA3obO4oa4GcPcUqmUUGrtKQUzIS
	 28dVhnoHOEAl1FHfmi0qHZsjGum3eD9S1hLvBm8DJLyMo4oBaI2ndut6Q8jkg50BKy
	 aCETBmz7QXwzg==
Date: Sat, 9 Mar 2024 18:37:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v1 1/2] iio: core: Leave private pointer NULL when no
 private data supplied
Message-ID: <20240309183700.60133d78@jic23-huawei>
In-Reply-To: <20240304140650.977784-2-andriy.shevchenko@linux.intel.com>
References: <20240304140650.977784-1-andriy.shevchenko@linux.intel.com>
	<20240304140650.977784-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 16:04:32 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In iio_device_alloc() when size of the private data is 0,
> the private pointer is calculated to point behind the valid data.
> Leave it NULL when no private data supplied.
> 
> Fixes: 6d4ebd565d15 ("iio: core: wrap IIO device into an iio_dev_opaque object")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fix is a strong word given any driver trying to access the pointer in this case
will be broken anyway.  I don't mind it being backported as it'll make bugs
easier to identify but I'm not rushing it in.

Otherwise seems like a sensible bit of tidying up.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4302093b92c7..8684ba246969 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1654,8 +1654,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  		return NULL;
>  
>  	indio_dev = &iio_dev_opaque->indio_dev;
> -	indio_dev->priv = (char *)iio_dev_opaque +
> -		ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
> +
> +	if (sizeof_priv)
> +		indio_dev->priv = (char *)iio_dev_opaque +
> +			ALIGN(sizeof(*iio_dev_opaque), IIO_DMA_MINALIGN);
>  
>  	indio_dev->dev.parent = parent;
>  	indio_dev->dev.type = &iio_device_type;


