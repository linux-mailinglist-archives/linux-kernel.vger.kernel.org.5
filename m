Return-Path: <linux-kernel+bounces-51770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533F848F1E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A2E1C21E5F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4C2263A;
	Sun,  4 Feb 2024 16:04:41 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5012261B
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062681; cv=none; b=jqutEFUuncSDX7XpywZef0Xda935Lglg9mFnev43ljgwj9kHKTj4s+u5c6S0WFx1pyuf4sestafPScRoyzmGF8LziC+66yFC0GxEWdXvjIYpXfqp1WWuEf4o7dorMCEDNqwWsMw5OANsnmRIhCY3ZlWo9bhTFCMWUjiFI7TQez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062681; c=relaxed/simple;
	bh=84hkzMnb4d0qSNlDJzg77SjZalzYwkJt2ttpNlkHAS0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj0QcMc3vtI35nOFXLYuMhTp6hFRgiZSmEy3Y87YFqMykJt0iTcpcuWEl0sAFPxaow4F2oEH3AZLOGI3oC9va3ruq6p+AgCuccc6Ybf/h4W8uB2QYVa8jroAR5spw68oRpNONGEkNnWl5YBYcPNlTx2riBSMwtrD2gNeRxGIhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id ef68d8fc-c376-11ee-b3cf-005056bd6ce9;
	Sun, 04 Feb 2024 18:03:28 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 4 Feb 2024 18:03:28 +0200
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/4] iio: pressure: hsc030pa add triggered buffer
Message-ID: <Zb-1UGJt27OV-vjc@surfacebook.localdomain>
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
 <20240127160405.19696-5-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127160405.19696-5-petre.rodan@subdimension.ro>

Sat, Jan 27, 2024 at 06:03:58PM +0200, Petre Rodan kirjoitti:
> Add triggered buffer feature.

..

> +static irqreturn_t hsc_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct hsc_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = hsc_get_measurement(data);
> +	if (ret)
> +		goto error;

> +	memcpy(&data->scan.chan[0], &data->buffer, 2);

You probably wanted here &data->buffer[0] as currently you use pointer to
the poiner.

> +	memcpy(&data->scan.chan[1], &data->buffer[2], 2);

Hmm... We don't have fixed-size memcpy() :-(

> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +error:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko



