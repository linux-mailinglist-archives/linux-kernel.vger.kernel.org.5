Return-Path: <linux-kernel+bounces-112646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E789887C80
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A362E281870
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F3D17721;
	Sun, 24 Mar 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwv+bzx/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9A28E7;
	Sun, 24 Mar 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711279215; cv=none; b=PWTwXoumwp7ivPUY9Pr3ws/loKrNJ1JL03BwR2uIaU42TzfDSwRaa21dPWmfTk899oogeCzO/SvC8y1IVpi70gx6OaV36Tg5USs2Qx3hCFsU/ZiGw4Yuy26K29TFI29wKJ7+mqGGNaxAn1+aMme9zskl1pFWOl/Yfz/gLIXjtac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711279215; c=relaxed/simple;
	bh=tmuQFbjp+AOm8Ex/TvUHeaP+sZtrLKa6c/OkabdzZxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMNjwVHN0CXgKcCrwrNWCB+flm2b3v/Jzwaq1pukSpFit6jptI585BPi9pswjotWXWlbV8wf7MgwMX5OBmUgXsS0tTr3cL5QytX5GUhw2gOFkMdrJvGC4XyC1Fi7UBbOKcbk56Bzse3j/rtQGFL5C+Qyn+ZCN8rZyiKuABL6ri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwv+bzx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6856FC433F1;
	Sun, 24 Mar 2024 11:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711279215;
	bh=tmuQFbjp+AOm8Ex/TvUHeaP+sZtrLKa6c/OkabdzZxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rwv+bzx/sbIxAuXRyodp1ZxWf0xB3UWVIxNAYP5sjm7r/iawgLbbrxiPkvLEtZiAi
	 z7WDnfoS5peNVZz0n++f1YdCuQqMJiObJ8fCeSQXj2Usei815kWl1tnXdYbvDie3gX
	 nxJxoglWj1mscsEerJFo5xrQRBqDzJTpn3/vH7hnU6ovQeOYl6lGquk5zVvF5jDykr
	 8bG5kHggwxIw5IbH8uZJwV7hYTLIvdX3JRoetIvjHiGtoX86LZtt/Eo7fbbCmroUY9
	 W3MXiwLiiNXBXeFsvZDkmtmhNSEhxOH4lxhdIRfguFN77myUEtSvVOYoZQR5xo3ZN3
	 5+RtyAADZRINQ==
Date: Sun, 24 Mar 2024 11:20:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/6] iio: pressure: Introduce new cleanup routines to
 BMP280 driver *_raw() functions
Message-ID: <20240324112002.3173a269@jic23-huawei>
In-Reply-To: <20240319002925.2121016-3-vassilisamir@gmail.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
	<20240319002925.2121016-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 01:29:21 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Introduce the new linux/cleanup.h with the guard(mutex) functionality
> in the {read/write}_raw() functions
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 125 +++++++++++++----------------
>  1 file changed, 58 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 871b2214121b..f7a13ff6f26c 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -460,77 +460,74 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  	return IIO_VAL_INT;
>  }
>  
> -static int bmp280_read_raw(struct iio_dev *indio_dev,
> -			   struct iio_chan_spec const *chan,
> -			   int *val, int *val2, long mask)
> +static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,

Why do we need the guarded naming?  It always took the lock, no
change just because we are doing that in a neater fashion.

I don't see a reason for that name.  Better to use something like
_impl, or _internal as the prefix.

I don't want to see people calling every function that uses guard
_guarded().


> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2, long mask)
Otherwise, I didn't find anything beyond what Andy already pointed out.
So looks good in general.

Jonathan


