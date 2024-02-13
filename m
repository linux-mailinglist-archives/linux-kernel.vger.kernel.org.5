Return-Path: <linux-kernel+bounces-63980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A585377D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B59428E011
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0ED5FF03;
	Tue, 13 Feb 2024 17:26:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43D5FDDF;
	Tue, 13 Feb 2024 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845159; cv=none; b=ETjdQiaCHmhdBWNckQRbJRRPSBBmzqRgRcFNVYlD+4EpfashTfLVp8mUo2SAjZzpbzeLGDIsQ8DiUvB7gPjK1ayqzdNyDGwRH5PAo9vP2Bff1ivcU3g8WHWqO572yx9tUqoqJuXHnUdxHREQv719VvNK3rE1NTiwO7UaA3fIlOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845159; c=relaxed/simple;
	bh=tuwFW0aeQd+W4iChfvmqXXIKXMdz2pY5OHL+K4tGxQ0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbXP3LD+marVPFU9sqGM9oMVsXHD6aLm7hhu8lA0EhCnTBUzt3ce6p9MpeWTkxArfwladk03/QuhySBL0fKp6h9IqbVUJENyojucfzOLy9HZp72FB7UJu5FuCeZdZ2Kf/DZKNEYxSRg6fw+Czso6xAt07CAxSFwLC7V5vrJyl7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZ7Rn3QwWz6K5pj;
	Wed, 14 Feb 2024 01:22:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E6EB01400D9;
	Wed, 14 Feb 2024 01:25:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 17:25:51 +0000
Date: Tue, 13 Feb 2024 17:25:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>, Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S?=
 =?ISO-8859-1?Q?=E1?= <nuno.sa@analog.com>, Alain Volmat
	<alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] spi: add spi_optimize_message() APIs
Message-ID: <20240213172550.000023a7@Huawei.com>
In-Reply-To: <20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com>
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
	<20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 12 Feb 2024 17:26:41 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new spi_optimize_message() function that can be used to
> optimize SPI messages that are used more than once. Peripheral drivers
> that use the same message multiple times can use this API to perform SPI
> message validation and controller-specific optimizations once and then
> reuse the message while avoiding the overhead of revalidating the
> message on each spi_(a)sync() call.
> 
> Internally, the SPI core will also call this function for each message
> if the peripheral driver did not explicitly call it. This is done to so
> that controller drivers don't have to have multiple code paths for
> optimized and non-optimized messages.
> 
> A hook is provided for controller drivers to perform controller-specific
> optimizations.
> 
> Suggested-by: Martin Sperl <kernel@martin.sperl.org>
> Link: https://lore.kernel.org/linux-spi/39DEC004-10A1-47EF-9D77-276188D2580C@martin.sperl.org/
> Signed-off-by: David Lechner <dlechner@baylibre.com>

A few trivial things inline but looks good to me in general.

I thought about suggesting splitting this into an initial patch that just does
the bits without the controller callbacks. Maybe it would work better that way
with that introduced after the validate and splitting of transfers (so most
of patches 1 and 2) as a patch 3 prior to the stm32 additions?

> ---
>  drivers/spi/spi.c       | 145 ++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/spi/spi.h |  19 +++++++
>  2 files changed, 160 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index c2b10e2c75f0..5bac215d7009 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2106,6 +2106,41 @@ struct spi_message *spi_get_next_queued_message(struct spi_controller *ctlr)
>  }
>  EXPORT_SYMBOL_GPL(spi_get_next_queued_message);
>  
> +/**
> + * __spi_unoptimize_message - shared implementation of spi_unoptimize_message()
> + *                            and spi_maybe_unoptimize_message()
> + * @msg: the message to unoptimize
> + *
> + * Periperhal drivers should use spi_unoptimize_message() and callers inside
> + * core should use spi_maybe_unoptimize_message() rather than calling this
> + * function directly.
> + *
> + * It is not valid to call this on a message that is not currently optimized.
> + */
> +static void __spi_unoptimize_message(struct spi_message *msg)
> +{
> +	struct spi_controller *ctlr = msg->spi->controller;
> +
> +	if (ctlr->unoptimize_message)
> +		ctlr->unoptimize_message(msg);
> +
> +	msg->optimized = false;
> +	msg->opt_state = NULL;
> +}

Seems misbalanced that this doesn't take a pre_optimized flag in but
__spi_optimize does. I'd move handling that to outside the call in both cases.


>  	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
> @@ -4271,6 +4401,8 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
>  
>  	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
>  
> +	spi_maybe_unoptimize_message(message);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(spi_async);
> @@ -4331,10 +4463,15 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
>  		return -ESHUTDOWN;
>  	}
>  
> -	status = __spi_validate(spi, message);
> -	if (status != 0)
> +	status = spi_maybe_optimize_message(spi, message);
> +	if (status)
>  		return status;
>  
> +	/*
> +	 * NB: all return paths after this point must ensure that
> +	 * spi_finalize_current_message() is called to avoid leaking resources.

I'm not sure a catch all like that makes sense. Not sufficient to call
the finer grained spi_maybe_unoptimize_message()  ?
> +	 */
> +
>  	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_sync);
>  	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_sync);


