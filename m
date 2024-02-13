Return-Path: <linux-kernel+bounces-63994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 668AA85385E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BFBB29BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839AF5FDD6;
	Tue, 13 Feb 2024 17:35:51 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A425F54E;
	Tue, 13 Feb 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845751; cv=none; b=eAe1L6pwfk+UNZsnGoMTNsukyt38qfFJlTBBwZz72p3JfdGtneF1Wjhrw8mhpbJrlbskAwsft1qG5Vkl8PsiChw2RcG2v8zjYz1aCehJvJjzQgXfH1ge9u0N8FVKpRqwRMz+5v5ujNahxHXLH+UPwGMyxukVBoyO0LMQ3n5adBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845751; c=relaxed/simple;
	bh=hFdRFXyJ6J0gRuqn20aKLMCP8hDT2Psu1blkps/Bmn4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqVEXC7hTNpoFLxZzYVZeYPoL7bsRBGhCsIomRMorvBB2MRlqXOgvVYdBR7g+JRp2ffGmyzcIF5nu4gWc32/igX6niuawBa72ZWItC9BKkgu7mx899xuLZS3ByaiSKUBvtdioff0gzS6ZJGxcwicDcMXdjRFJcy+xbs6fEM5lcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZ7gT4cFdz67LmL;
	Wed, 14 Feb 2024 01:32:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A9F471400D9;
	Wed, 14 Feb 2024 01:35:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 17:35:46 +0000
Date: Tue, 13 Feb 2024 17:35:45 +0000
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
Subject: Re: [PATCH 2/5] spi: move splitting transfers to
 spi_optimize_message()
Message-ID: <20240213173545.00006564@Huawei.com>
In-Reply-To: <20240212-mainline-spi-precook-message-v1-2-a2373cd72d36@baylibre.com>
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
	<20240212-mainline-spi-precook-message-v1-2-a2373cd72d36@baylibre.com>
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

On Mon, 12 Feb 2024 17:26:42 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Splitting transfers is an expensive operation so we can potentially
> optimize it by doing it only once per optimization of the message
> instead of repeating each time the message is transferred.
> 
> The transfer splitting functions are currently the only user of
> spi_res_alloc() so spi_res_release() can be safely moved at this time
> from spi_finalize_current_message() to spi_unoptimize_message().
> 
> The doc comments of the public functions for splitting transfers are
> also updated so that callers will know when it is safe to call them
> to ensure proper resource management.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
Trivial thing (which applies equally to the original code).
Otherwise LGTM.
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +/**
> + * spi_split_transfers - generic handling of transfer splitting
> + * @msg: the message to split
> + *
> + * Under certain conditions, a SPI controller may not support arbitrary
> + * transfer sizes or other features required by a peripheral. This function
> + * will split the transfers in the message into smaller transfers that are
> + * supported by the controller.
> + *
> + * Controllers with special requirements not covered here can also split
> + * transfers in the optimize_message() callback.
> + *
> + * Context: can sleep
> + * Return: zero on success, else a negative error code
> + */
> +static int spi_split_transfers(struct spi_message *msg)
> +{
> +	struct spi_controller *ctlr = msg->spi->controller;
> +	struct spi_transfer *xfer;
> +	int ret;
> +
> +	/*
> +	 * If an SPI controller does not support toggling the CS line on each
> +	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
> +	 * for the CS line, we can emulate the CS-per-word hardware function by
> +	 * splitting transfers into one-word transfers and ensuring that
> +	 * cs_change is set for each transfer.
> +	 */
> +	if ((msg->spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
> +					       spi_is_csgpiod(msg->spi))) {
	if ((msg->spi->mode & SPI_CS_WORD) &&
	    (!(ctlr->mode_bits & SPI_CS_WORD) || spi_is_csgpiod(msg->spi))) {

Seems easier to read to me. I appreciate you are just moving it though so
don't mind that much if you leave it in the original form.



> +		ret = spi_split_transfers_maxwords(ctlr, msg, 1);
> +		if (ret)
> +			return ret;
> +
> +		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +			/* Don't change cs_change on the last entry in the list */
> +			if (list_is_last(&xfer->transfer_list, &msg->transfers))
> +				break;
> +
> +			xfer->cs_change = 1;
> +		}
> +	} else {
> +		ret = spi_split_transfers_maxsize(ctlr, msg,
> +						  spi_max_transfer_size(msg->spi));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}


