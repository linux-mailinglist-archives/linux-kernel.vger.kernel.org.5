Return-Path: <linux-kernel+bounces-2655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A41816002
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7E61F21D26
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4EB44C71;
	Sun, 17 Dec 2023 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2g/+f/y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699A44C65;
	Sun, 17 Dec 2023 14:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101D2C433C7;
	Sun, 17 Dec 2023 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702824837;
	bh=6PGHltDeG6Yd1WWUHaZuRnIsh7dV91pqbP7IA10PJq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P2g/+f/yDvBFCk9s4x2scwHc4cEIJCnMzcJ6qi6bjWmNgcQtxPizQ5C9UxVnejo1g
	 FXh1cOwgHJRbYNb2ATiA9FNcvctYMx8NJ4Vi8AkARMjY4auBZa7GRjgJa9GlSRH5Xd
	 Rh+p44maDqZpNe1HnbhRAXuKOnDfO8zTJUvnvMvgOkfhug24xZvPNOgOOnw5HnAP0+
	 m7OWXXCEbw0jH32s33D24q/pwaH8eqviRYcDITkJVqs/6FUSxs1iSuU1VrZsYB7nD8
	 R47y/ctNwCHXhR3hN1L8yKIb52JZFknX2Og9rqu0qTyVN2aHaCv9TiRHeh6eLRH7x0
	 D/5/wQMXcQkIg==
Date: Sun, 17 Dec 2023 14:53:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
 <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <dan.carpenter@linaro.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/15] iio: adc: ad7091r: Pass iio_dev to event
 handler
Message-ID: <20231217145339.1ec0e1cd@jic23-huawei>
In-Reply-To: <5024b764107463de9578d5b3b0a3d5678e307b1a.1702746240.git.marcelo.schmitt1@gmail.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
	<5024b764107463de9578d5b3b0a3d5678e307b1a.1702746240.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 14:46:11 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Previous version of ad7091r event handler received the ADC state pointer
> and retrieved the iio device from driver data field with dev_get_drvdata().
> However, no driver data have ever been set, which led to null pointer
> dereference when running the event handler.
> 
> Pass the iio device to the event handler and retrieve the ADC state struct
> from it so we avoid the null pointer dereference and save the driver from
> filling the driver data field.
> 
> Fixes: ca69300173b6 ("iio: adc: Add support for AD7091R5 ADC")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Given we are late in the cycle, I've applied this to the togreg branch of iio.git
and it will hopefully go in during the merge window rather than before.
Marked it for stable though so should get backported appropriately.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7091r-base.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 8e252cde735b..0e5d3d2e9c98 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -174,8 +174,8 @@ static const struct iio_info ad7091r_info = {
>  
>  static irqreturn_t ad7091r_event_handler(int irq, void *private)
>  {
> -	struct ad7091r_state *st = (struct ad7091r_state *) private;
> -	struct iio_dev *iio_dev = dev_get_drvdata(st->dev);
> +	struct iio_dev *iio_dev = private;
> +	struct ad7091r_state *st = iio_priv(iio_dev);
>  	unsigned int i, read_val;
>  	int ret;
>  	s64 timestamp = iio_get_time_ns(iio_dev);
> @@ -234,7 +234,7 @@ int ad7091r_probe(struct device *dev, const char *name,
>  	if (irq) {
>  		ret = devm_request_threaded_irq(dev, irq, NULL,
>  				ad7091r_event_handler,
> -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, st);
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, iio_dev);
>  		if (ret)
>  			return ret;
>  	}


