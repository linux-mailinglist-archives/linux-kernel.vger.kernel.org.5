Return-Path: <linux-kernel+bounces-143812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14E8A3DBE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FAC1C20C02
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CA83398A;
	Sat, 13 Apr 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzaF6RVr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6A3D68;
	Sat, 13 Apr 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713026388; cv=none; b=IY1Gek9SuEFVYumEeI88/O9j02aEQXFIPo+MCnCj09BeIlWi/4eXAeV1l1oAPVmBdddw0K92OewZKmdO4Tv8vmBjaOo6N8wQllt1+RCKMm87e2H52J+MRPbABPj+O7Ow6SPnzF4oaQE3lu4snSGzZgBW/wtH9JIFdj9HSsv+L+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713026388; c=relaxed/simple;
	bh=d5kETntayFqL4ZKvkjiGucO/Vxul0FY7mvwIDwpkP7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qo1EfLOmkQRhKni0Z7MY/PthkcbDyKnqQGrjWaNk2j3R1n6Je5sUmRzf6ifEAq9QL9aT6BgUqdRAX+UdZYCK9KyJOMIOfQhlXGrCfgQfzmY9IfFBcqdMg37pspzgp90SqPAaS1l/VTxbm1OOXDqMnpT7H+pCucRA6QOxSPj0e2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzaF6RVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DE7C113CE;
	Sat, 13 Apr 2024 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713026388;
	bh=d5kETntayFqL4ZKvkjiGucO/Vxul0FY7mvwIDwpkP7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pzaF6RVro1oYWpJtD7p830sHgC6oCszvDhcbwYoAO/9zD+oGexYtdsSeOX1VuerdJ
	 Mp61bnIonekWaUZ7YN4jGF0Qj+LCKC20kpk5nqyJ86NSyqgGZ0hqUV1f/jAH7Qmka3
	 ORsH++uDLkwVfNNFUIjbpJrzRqS1QBOJUxS06112c28PwjZjmZqB3bCCxanARdU7/2
	 /Xy6gldrhN/WYy+uWyc0h0C0PFKbg02fXhFDpfWwQAPx2W/LweW1oUTfanY/2VuQV4
	 xe2d+pXmm6lYSyPGHKyR2Jz1P+dRC1SYF4hObgyFsAXzmfcEVJHH6s/YbD21aDsc3e
	 elLEc52YmWlTw==
Date: Sat, 13 Apr 2024 17:39:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for AD4000
Message-ID: <20240413173932.338b574c@jic23-huawei>
In-Reply-To: <1d95d7d023dad69b894a2d0e7b0bad9d569ae382.1712585500.git.marcelo.schmitt@analog.com>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
	<1d95d7d023dad69b894a2d0e7b0bad9d569ae382.1712585500.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Apr 2024 11:31:42 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add support for AD4000 family of low noise, low power, high speed,
> successive aproximation register (SAR) ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
A few trivial comments inline to add to David's much more thorough review.

> +#include <asm/unaligned.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

You don't have custom attributes, so doubt you need that include.

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>

> +
> +static int ad4000_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +			return ad4000_single_conversion(indio_dev, chan, val);
> +		unreachable();
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->scale_tbl[st->pin_gain][st->span_comp][0];
> +		*val2 = st->scale_tbl[st->pin_gain][st->span_comp][1];
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 0;
> +		if (st->span_comp)
> +			*val = mult_frac(st->vref / 1000, 1, 10);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
As below - I'd push into the default: and drop down here.

> +}
> +
> +static int ad4000_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)st->scale_tbl[st->pin_gain];
> +		*length = 2 * 2;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;

dead code.

> +}
> +
> +static int ad4000_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	bool span_comp_en;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			ret = ad4000_read_reg(st, &reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			span_comp_en = (val2 == st->scale_tbl[st->pin_gain][1][1]);
> +			reg_val &= ~AD4000_SPAN_COMP;
> +			reg_val |= FIELD_PREP(AD4000_SPAN_COMP, span_comp_en);
> +
> +			ret = ad4000_write_reg(st, reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			st->span_comp = span_comp_en;
> +			return 0;
> +		}
> +		unreachable();
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
Trivial but could push up into the default and make it clear there are no other ways out
of the switch statement.
> +}


