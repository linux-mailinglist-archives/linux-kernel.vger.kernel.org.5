Return-Path: <linux-kernel+bounces-112670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DAF887CC5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9108AB20EA0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1196A17BB7;
	Sun, 24 Mar 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO2q+6bV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5D1168DA;
	Sun, 24 Mar 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711284139; cv=none; b=eFRlyQZ82ZzZZ4KgwNQQ+XRrp+lV8FvWrfS9Oq2Y8KzCm7tGXuiowrzWQpVaS9UUUpGYY41o0R3Qu7WvVs/GNbgrMKbof0P2Q+mYlCM05BDCypLxsKJyxdJ8DuZOx3amGE5JCnB3HMg9QJ5D2vJcqOFKn14wpYv1tBdxLphrv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711284139; c=relaxed/simple;
	bh=VWSPwjYIKUe7F1DNHFNM9x5mfJP4QIY7I+2zOjTFSdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gI1RhlDq0dgbkLofMPYworUI/IAyXrEnDVyAFeGT72gq7KGdRP2tZhmeRWN2m549CxGB2thcyH+YTpJqAKOqhmhZ4ck1AURTHFr48HBAbsQT52FIpd2As/WqL8sLEjVKajrXEvwptkiob8IbIpoutxAieF+xiBU0azrZce9e6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO2q+6bV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C21CC433C7;
	Sun, 24 Mar 2024 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711284138;
	bh=VWSPwjYIKUe7F1DNHFNM9x5mfJP4QIY7I+2zOjTFSdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rO2q+6bVgabwedQm+ppnIa3VhE8SESdp2K8eYY8BUdAORj4vLAzZK4Spi1DCGqvnE
	 A9rieMZ0huIyO2lePMBL32BMpYJ7GVsQClCYDnvN4fzbFI33FpiQa7PfroI+sH1+/d
	 di5fTnQUE+akw98oa/8UytlGOpeUsx5vfzZn1isItNtq1eju+6FPLK8J6Q/gZaCjF+
	 w1MHeytJs4MULvCOXPBVVA+9V6CeY9w9k6WRYaTFn49DX57PUXO+lIFU7N/iaQCAz/
	 S0PUnO6zi84y8D4J3Nf29NV3uzjXZo1pDp0wNBKh93ovXAIFbTQ0QhJkV0OJ9B21by
	 5t2bM/MvIykFw==
Date: Sun, 24 Mar 2024 12:42:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>, Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH v5 2/7] iio: adc: ad7380: new driver for AD7380 ADCs
Message-ID: <20240324124201.3ce3e650@jic23-huawei>
In-Reply-To: <20240319-adding-new-ad738x-driver-v5-2-ce7df004ceb3@baylibre.com>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
	<20240319-adding-new-ad738x-driver-v5-2-ce7df004ceb3@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 11:11:23 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> From: David Lechner <dlechner@baylibre.com>
> 
> This adds a new driver for the AD7380 family ADCs.
> 
> The driver currently implements basic support for the AD7380, AD7381,
> 2-channel differential ADCs. Support for additional single-ended,
> pseudo-differential and 4-channel chips that use the same register map
> as well as additional features of the chip will be added in future patches.
> 
> Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> [Julien Stephan: add datasheet links of supported parts]
> [Julien Stephan: fix rx/tx buffer for regmap access]
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Looks good to me.  One unrelated comment inline.

Jonathan

> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  16 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7380.c | 447 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 465 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f7c512f3bbda..2277870853c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -435,6 +435,7 @@ S:	Supported
>  W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> +F:	drivers/iio/adc/ad7380.c
>  
>  AD7877 TOUCHSCREEN DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 8db68b80b391..631386b037ae 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -155,6 +155,22 @@ config AD7298
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7298.
>  
> +config AD7380
> +	tristate "Analog Devices AD7380 ADC driver"
> +	depends on SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  AD7380 is a family of simultaneous sampling ADCs that share the same
> +	  SPI register map and have similar pinouts.
> +
> +	  Say yes here to build support for Analog Devices AD7380 ADC and
> +	  similar chips.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7380.
> +
>  config AD7476
>  	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index edb32ce2af02..bd3cbbb178fa 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7292) += ad7292.o
>  obj-$(CONFIG_AD7298) += ad7298.o
>  obj-$(CONFIG_AD7923) += ad7923.o

Oops these clearly got out of order a long time ago.
We should fix that up but nothing to do with this series.
 
> +obj-$(CONFIG_AD7380) += ad7380.o
>  obj-$(CONFIG_AD7476) += ad7476.o
>  obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o

