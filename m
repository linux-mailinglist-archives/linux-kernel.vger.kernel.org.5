Return-Path: <linux-kernel+bounces-105282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84887DB5F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B51B20F23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBA31C28F;
	Sat, 16 Mar 2024 19:57:08 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B166468E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710619028; cv=none; b=OZSnhT3ktr/LZmjDR4Meu0EMaeCLh+V8yBPOJhDU/wKEJKaseYxB3SNCOEQId8hx4UnDxm0M3qXLkGAVpycthjoICMWRaGIcyOfUdcL2lDqLclVGjiBvUPpp89KUD+y7B+pbIX/H+b+GwYJNIqvJLQivrCtVgOKTBJ7hD47ZNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710619028; c=relaxed/simple;
	bh=UKCzykZaeKbXBkkY+1MpRT1JBdvsdYA5sQSWa+u0EDw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNtbHg5Ma3nSawJq68H1OsESs/xTaYvAsYLD8pCCQU8yhIzcp+XSH6kSXcBqR+h7P+aGN/fv2dbWr7jyLiQl0iICc0RduQVryWxh/I7ncbaXZ6IFQXTOGPSwgdNWLrt9RmBkfOIZvL/Rlh4/oYdZXiE2E2Q3+CcHpQhQx91ZmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 5bec0d5d-e3cf-11ee-abf4-005056bdd08f;
	Sat, 16 Mar 2024 21:57:03 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 16 Mar 2024 21:57:03 +0200
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
Message-ID: <ZfX5jynjW4M9pvw1@surfacebook.localdomain>
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>

Thu, Mar 14, 2024 at 12:43:38PM -0500, David Lechner kirjoitti:
> This adds support for AD7944 ADCs wired in "3-wire mode". (NOTE: 3-wire
> is the datasheet name for this wiring configuration and has nothing to
> do with SPI_3WIRE.)
> 
> In the 3-wire mode, the SPI controller CS line can be wired to the CNV
> line on the ADC and used to trigger conversions rather that using a
> separate GPIO line.
> 
> The turbo/chain mode compatibility check at the end of the probe
> function is technically can't be triggered right now but adding it now
> anyway so that we don't forget to add it later when support for
> daisy-chaining is added.

..

> +enum ad7944_spi_mode {
> +	/* datasheet calls this "4-wire mode" */
> +	AD7944_SPI_MODE_DEFAULT,
> +	/* datasheet calls this "3-wire mode" (not related to SPI_3WIRE!) */
> +	AD7944_SPI_MODE_SINGLE,
> +	/* datasheet calls this "chain mode" */
> +	AD7944_SPI_MODE_CHAIN,

Why not kernel doc?

> +};

..

>  struct ad7944_adc {
>  	struct spi_device *spi;
> +	enum ad7944_spi_mode spi_mode;
>  	/* Chip-specific timing specifications. */
>  	const struct ad7944_timing_spec *timing_spec;
>  	/* GPIO connected to CNV pin. */
> @@ -58,6 +75,9 @@ struct ad7944_adc {
>  	 } sample __aligned(IIO_DMA_MINALIGN);
>  };

Have you run `pahole` to see if there is a better place for a new member?

..

> +/*

The below is mimicing the kernel doc, but there is no marker for this.
Why?

> + * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conversion and
> + *                                   acquisition
> + * @adc: The ADC device structure
> + * @chan: The channel specification
> + * Return: 0 on success, a negative error code on failure
> + *
> + * This performs a conversion and reads data when the chip is wired in 3-wire
> + * mode with the CNV line on the ADC tied to the CS line on the SPI controller.
> + *
> + * Upon successful return adc->sample.raw will contain the conversion result.
> + */

..

> +	struct spi_transfer xfers[] = {
> +		{
> +			/*
> +			 * NB: can get better performance from some SPI
> +			 * controllers if we use the same bits_per_word
> +			 * in every transfer.

I believe you may reformat this to reduce by 1 line.

> +			 */
> +			.bits_per_word = chan->scan_type.realbits,
> +			/*
> +			 * CS is tied to CNV and we need a low to high
> +			 * transition to start the conversion, so place CNV
> +			 * low for t_QUIET to prepare for this.

This also seems narrow.

> +			 */
> +			.delay = {
> +				.value = T_QUIET_NS,
> +				.unit = SPI_DELAY_UNIT_NSECS,
> +			},
> +
> +		},
> +		{
> +			.bits_per_word = chan->scan_type.realbits,
> +			/*
> +			 * CS has to be high for full conversion time to avoid
> +			 * triggering the busy indication.
> +			 */
> +			.cs_off = 1,
> +			.delay = {
> +				.value = t_conv_ns,
> +				.unit = SPI_DELAY_UNIT_NSECS,
> +			},
> +		},
> +		{
> +			/* Then we can read the data during the acquisition phase */
> +			.rx_buf = &adc->sample.raw,
> +			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
> +			.bits_per_word = chan->scan_type.realbits,
> +		},
> +	};

..

> +	case AD7944_SPI_MODE_SINGLE:
> +		ret = ad7944_3wire_cs_mode_conversion(adc, &indio_dev->channels[0]);
> +		if (ret)
> +			goto out;
> +
> +		break;
> +	default:
> +		/* not supported */

No error code set?

>  		goto out;
> +	}

..

> +	if (device_property_read_string(dev, "adi,spi-mode", &str_val) == 0) {
> +		ret = sysfs_match_string(ad7944_spi_modes, str_val);

Don't you want use new fwnode/device property API for making these two in
one go?

> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL,

Why shadowing the error code?

> +					     "unsupported adi,spi-mode\n");
> +
> +		adc->spi_mode = ret;
> +	} else {
> +		/* absence of adi,spi-mode property means default mode */
> +		adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
> +	}

-- 
With Best Regards,
Andy Shevchenko



