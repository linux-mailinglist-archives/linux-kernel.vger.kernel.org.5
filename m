Return-Path: <linux-kernel+bounces-2673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0E1816049
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D9E1F22A2F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AC54597E;
	Sun, 17 Dec 2023 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjkEMszE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377645966;
	Sun, 17 Dec 2023 15:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBBBC433C8;
	Sun, 17 Dec 2023 15:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702828466;
	bh=tDPWvMV6+ju7SK93SQJWeIdlKhsA3hrB9iT5eFL+y9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QjkEMszE9913b+/17syBSIP02B3s8+kgf2gHXqV9KR6Gm9xHz3YWqsAhcP7NP+iay
	 VbGv9u8LHefcRk4ANJ1BqFgCjvEy9h54Eq/pXqj5XozOQRC4pnYO9FdmBlP9mUuOwk
	 v5WTPC4CTzW71Tw0mXZear6WyYBdgEsLgmtLov5oor/qzhhtzDNl5GQZb1SsboNAIO
	 CAXZXWOdp9ad34Pc233tyn3vFttjYuBWbL+2wQ48LIKZ6zm3rCIit5+XlXIIACMP7t
	 scBTNr4y6edfU3CI9ZfSoHBacHHiqrQpfuonEAhG6QEhu6/JtW8xE4P7dhjUjrii0K
	 0ysl848agY0tw==
Date: Sun, 17 Dec 2023 15:54:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
 <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <dan.carpenter@linaro.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 15/15] iio: adc: ad7091r: Allow users to configure
 device events
Message-ID: <20231217155409.4da6b795@jic23-huawei>
In-Reply-To: <24a9f1bb721e66df65e36797b0c3fd2ca1f95227.1702746240.git.marcelo.schmitt1@gmail.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
	<24a9f1bb721e66df65e36797b0c3fd2ca1f95227.1702746240.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 14:51:50 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Implement event configuration callbacks allowing users to read/write
> event thresholds and enable/disable event generation.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> This is from a review suggestion David made on v3 [1].
> 
> Is this the case for a Suggested-by tag?
> 
> [1]: https://lore.kernel.org/linux-iio/CAMknhBFPbAqp4-AQdmbp+VRW-Ksk1PxaLCG+3n=Zk4gyStqhgw@mail.gmail.com/#t
> 
>  drivers/iio/adc/ad7091r-base.c | 117 +++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 57355ca157a1..64e8baeff258 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -20,19 +20,18 @@ const struct iio_event_spec ad7091r_events[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_RISING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -				 BIT(IIO_EV_INFO_ENABLE),
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),

This is an ABI change.  So would need a really strong reason to make it...
mind you - it seems like this has been broken until now anyway so this change
may be fine.


>  	},
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_FALLING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -				 BIT(IIO_EV_INFO_ENABLE),
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
>  	},
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_EITHER,
>  		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
It's relatively unusual that you can't separate the two event directions with careful
control of the thresholds.  So I think you can implement the existing ABI by
just setting the thresholds to the either 0 or 2^12 - 1 as appropriate.
The docs seem to say it must exceed the value, or fall below the min so these values
should ensure it can't do either.

You can then enable the event generate if one of them is set.



