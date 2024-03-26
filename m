Return-Path: <linux-kernel+bounces-119576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E8A88CA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933A832411C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC61CD2D;
	Tue, 26 Mar 2024 17:21:56 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F811D543;
	Tue, 26 Mar 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473715; cv=none; b=JWNLpe6miG4lA3D9fBb9+hMj92ScG3eL5TBQiXyO1fVtwO86gwepFktBo2by+jKQM90DsIYFfalRY7+jBy3+gugnT9ssUxgJXXlVotjXVm27AVbDHLwuSuuryJ1cxCkvvz1+92/0NNIRKCzx16JlNycHEc34iFNVCyQoPpTwF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473715; c=relaxed/simple;
	bh=wHPXTdCN/SeU9t8rC4jveK0ET7TysbQBSYGX7I9XLKc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yj8ZTjQcZeKLPRoD5KFphlIpqolDWiZIVzDsf1aDOb9hYKUQQZEoCHhQriQpba0BdbO/WUwrHO7lofMYmXtRWLm56Yn5bAW3RJSgNRCTiu0qAy9ShNzmVCvRJzHHlK5bCaiOCgOEdD4NjM8cmwoioFocIh9qn7cELkUggIJ+mRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3xQt1sGzz6JB9Z;
	Wed, 27 Mar 2024 01:20:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 32087140A90;
	Wed, 27 Mar 2024 01:21:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 17:21:50 +0000
Date: Tue, 26 Mar 2024 17:21:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7944: use spi_optimize_message()
Message-ID: <20240326172149.00004247@Huawei.com>
In-Reply-To: <20240325-ad7944-spi-optimize-message-v1-1-cded69b9e27f@baylibre.com>
References: <20240325-ad7944-spi-optimize-message-v1-1-cded69b9e27f@baylibre.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 25 Mar 2024 17:03:13 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This modifies the ad7944 driver to use spi_optimize_message() to reduce
> CPU usage and increase the max sample rate by avoiding repeating
> validation of the spi message on each transfer.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
One buglet inline. Otherwise looks fine to me.


Jonathan

> ---
>  drivers/iio/adc/ad7944.c | 177 +++++++++++++++++++++++++++--------------------
>  1 file changed, 103 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index 261a3f645fd8..c767401712af 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -51,6 +51,8 @@ static const char * const ad7944_spi_modes[] = {
>  struct ad7944_adc {
>  	struct spi_device *spi;
>  	enum ad7944_spi_mode spi_mode;
> +	struct spi_transfer xfers[3];
> +	struct spi_message msg;
>  	/* Chip-specific timing specifications. */
>  	const struct ad7944_timing_spec *timing_spec;
>  	/* GPIO connected to CNV pin. */
> @@ -130,6 +132,88 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
>  /* fully differential */
>  AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
>  
> +static void ad7944_unoptimize_msg(void *msg)
> +{
> +	spi_unoptimize_message(msg);
> +}
> +
> +static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
> +					 const struct iio_chan_spec *chan)
> +{
> +	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
> +						   : adc->timing_spec->conv_ns;
> +	struct spi_transfer *xfers = adc->xfers;
> +	int ret;
> +
> +	/*
> +	 * NB: can get better performance from some SPI controllers if we use
> +	 * the same bits_per_word in every transfer.
> +	 */
> +	xfers[0].bits_per_word = chan->scan_type.realbits;
> +	/*
> +	 * CS is tied to CNV and we need a low to high transition to start the
> +	 * conversion, so place CNV low for t_QUIET to prepare for this.
> +	 */
> +	xfers[0].delay.value = T_QUIET_NS;
> +	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +	/*
> +	 * CS has to be high for full conversion time to avoid triggering the
> +	 * busy indication.
> +	 */
> +	xfers[1].cs_off = 1;
> +	xfers[1].delay.value = t_conv_ns;
> +	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
> +	xfers[0].bits_per_word = chan->scan_type.realbits;

0 ?

> +
> +	/* Then we can read the data during the acquisition phase */
> +	xfers[2].rx_buf = &adc->sample.raw;
> +	xfers[2].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> +	xfers[2].bits_per_word = chan->scan_type.realbits;
> +
> +	spi_message_init_with_transfers(&adc->msg, xfers, 3);
> +
> +	ret = spi_optimize_message(adc->spi, &adc->msg);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
> +}



