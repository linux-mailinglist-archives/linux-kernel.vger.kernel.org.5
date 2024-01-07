Return-Path: <linux-kernel+bounces-18903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA378264E8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502381F21561
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D324C13ADB;
	Sun,  7 Jan 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyQLmV3f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678E13AC7;
	Sun,  7 Jan 2024 16:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC203C433C8;
	Sun,  7 Jan 2024 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704643661;
	bh=irwiB0glJqtkW5oESCUx2inVytpmIwtrLKY8B2VSb7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lyQLmV3fl2YZWdk+11aDymPdtPvyIECQmIjD3cct2tyigiLrV+ZJYslhW46z6o6CM
	 JFjSKGvnSHwCpKoO+SpWMODGqM0nLA479N9H0e4p3sfCdFfg5Gp94iqT3NuLmZHnb5
	 z9hbf6x0ioRke7ZVI9psr5vnCtTZI5xvdKSbmrWp7VienhV1VcRbgvQ7FTNpNHLJ/d
	 ywm/RVObu0u6tQ+KXyWuFPYzEzmUbejYwx3QOuCNHThlvU5urMO6nwgWNfkpCoX+zX
	 oxfdzGz1XphUo2pHuVqhhS+/UALoEzHX03C7YvDQRTKsXLujGWTijFR9KN+mD2wVFg
	 AtQt8VsXqPYYw==
Date: Sun, 7 Jan 2024 16:07:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: invensense: remove redundant initialization
 of variable period
Message-ID: <20240107160736.14f3ae1d@jic23-huawei>
In-Reply-To: <20240106153202.54861-1-colin.i.king@gmail.com>
References: <20240106153202.54861-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jan 2024 15:32:02 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> The variable period is being initialized with a value that is never
> read, it is being re-assigned a new value later on before it is read.
> The initialization is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> Value stored to 'period' during its initialization is never
> read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Hi Colin,

I definitely want input from someone who can test this.
There is direct use of ts->period as well as the local
variable that is indeed overwritten as you've noted.
Feels like naming needs some work and perhaps reduce the scope of
the period local variable so it's obvious it was only intended
for more local use than it currently looks like.

Thanks,

Jonathan

> ---
>  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> index 03823ee57f59..3b0f9598a7c7 100644
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> @@ -126,7 +126,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
>  	struct inv_sensors_timestamp_interval *it;
>  	int64_t delta, interval;
>  	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
> -	uint32_t period = ts->period;
> +	uint32_t period;
>  	bool valid = false;
>  
>  	if (fifo_nb == 0)


