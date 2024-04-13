Return-Path: <linux-kernel+bounces-143828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0979B8A3DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081181C208EB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D383E4CB2E;
	Sat, 13 Apr 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBVBPVVO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217ED1D696;
	Sat, 13 Apr 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713028406; cv=none; b=edXU/5b27zBbCF7ahXWrWhhXSlV50fInzqIqW4umQj9WG3Y7oBEetq2Hn2STX4N5qIw8ERS/fkJZcoGgl/4nH8ZPnRDIAbyWKw4hp1+Ce0qx7Z9BMK9ZCx2piQsrTa16lpuW0iX2gIjkw11IhGzZxFR1oa9g/Jp0/xGvJykqp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713028406; c=relaxed/simple;
	bh=wzU2x996W99SPd342HnQZWaKhCHWFbUf/VpcY/S67u0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMNun1dFhrQ+Uwi3Bog0sJBLEgOrmH9QzhTjBSBnXSv8rMIDNkNTjNqfIgz1XA3QxKNVSDZzSvOG+Z3ZbCb1q3ciiG4FuCMuEKdUwLi4KyCEsoh7WXnR4Ohn+Ty2pEHSdHazkQmgKIF/Yjk7q+ojIPvQw1IT63wO8fatLNGPWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBVBPVVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3D9C2BD11;
	Sat, 13 Apr 2024 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713028405;
	bh=wzU2x996W99SPd342HnQZWaKhCHWFbUf/VpcY/S67u0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dBVBPVVOj698PtOWSw+BhGfNn439y0jmpgeuSkzMoPWA7zc4P4mIgfsqBqcJJUHZv
	 6aUAGQ4YoAfvNI3K82I52TZ6L1CsQqB8KaVX3FD7554tXBaI2x3YKjvZaqeeD2evMe
	 vzQPwZSVyajDX7DiahtFj2dS6lQgVTk1Ledz/awoGRnUhihHr4+sw9NqI4l/CJo9bP
	 efMI95bobKVJGWvuduXi2OKJa9oZtthR500gORByDBv8d/pxpMyHlD235oGzzFjFkB
	 RJU3XlVL3YggKhSfZ6ahqlaHbaU+IvzUc5exMiAGja3GUuuzw6urLxb7lAn82Olk80
	 LVMT5EulJOyOw==
Date: Sat, 13 Apr 2024 18:13:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] iio: dac: ad5755: make use of of_device_id table
Message-ID: <20240413181311.674fbf95@jic23-huawei>
In-Reply-To: <20240413154511.52576-1-krzysztof.kozlowski@linaro.org>
References: <20240413154511.52576-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Apr 2024 17:45:11 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Store pointers to chip info (struct ad5755_chip_info) in driver match
> data, instead of enum, so every value will be != 0, populate the
> of_device_id table and use it in driver.  Even though it is one change,
> it gives multiple benefits:
> 1. Allows to use spi_get_device_match_data() dropping local 'type'
>    variable.
> 2. Makes both ID tables usable, so kernel can match via any of these
>    methods.
> 3. Code is more obvious as both tables are properly filled.
> 4. Fixes W=1 warning:
>    ad5755.c:866:34: error: unused variable 'ad5755_of_match' [-Werror,-Wunused-const-variable]
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
Applied but only pushed out as testing for 0-day so far, so I can rebase
to add tags (or pull it if anyone finds an issue!)

Thanks for doing this Krzysztof.

Jonathan

> ---
> 
> Changes in v3:
> 1. Use pointers, according to Jonathan comments.
> 
> v2: https://lore.kernel.org/all/20240226192555.14aa178e@jic23-huawei/
> 
> An old v1:
> https://lore.kernel.org/all/20230810111933.205619-1-krzysztof.kozlowski@linaro.org/
> ---
>  drivers/iio/dac/ad5755.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 404865e35460..0b24cb19ac9d 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -809,7 +809,6 @@ static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
>  
>  static int ad5755_probe(struct spi_device *spi)
>  {
> -	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
>  	const struct ad5755_platform_data *pdata;
>  	struct iio_dev *indio_dev;
>  	struct ad5755_state *st;
> @@ -824,7 +823,7 @@ static int ad5755_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  	spi_set_drvdata(spi, indio_dev);
>  
> -	st->chip_info = &ad5755_chip_info_tbl[type];
> +	st->chip_info = spi_get_device_match_data(spi);
>  	st->spi = spi;
>  	st->pwr_down = 0xf;
>  
> @@ -854,21 +853,21 @@ static int ad5755_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id ad5755_id[] = {
> -	{ "ad5755", ID_AD5755 },
> -	{ "ad5755-1", ID_AD5755 },
> -	{ "ad5757", ID_AD5757 },
> -	{ "ad5735", ID_AD5735 },
> -	{ "ad5737", ID_AD5737 },
> +	{ "ad5755", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5755] },
> +	{ "ad5755-1", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5755] },
> +	{ "ad5757", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5757] },
> +	{ "ad5735", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5735] },
> +	{ "ad5737", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5737] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad5755_id);
>  
>  static const struct of_device_id ad5755_of_match[] = {
> -	{ .compatible = "adi,ad5755" },
> -	{ .compatible = "adi,ad5755-1" },
> -	{ .compatible = "adi,ad5757" },
> -	{ .compatible = "adi,ad5735" },
> -	{ .compatible = "adi,ad5737" },
> +	{ .compatible = "adi,ad5755", &ad5755_chip_info_tbl[ID_AD5755] },
> +	{ .compatible = "adi,ad5755-1", &ad5755_chip_info_tbl[ID_AD5755] },
> +	{ .compatible = "adi,ad5757", &ad5755_chip_info_tbl[ID_AD5757] },
> +	{ .compatible = "adi,ad5735", &ad5755_chip_info_tbl[ID_AD5735] },
> +	{ .compatible = "adi,ad5737", &ad5755_chip_info_tbl[ID_AD5737] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ad5755_of_match);
> @@ -876,6 +875,7 @@ MODULE_DEVICE_TABLE(of, ad5755_of_match);
>  static struct spi_driver ad5755_driver = {
>  	.driver = {
>  		.name = "ad5755",
> +		.of_match_table = ad5755_of_match,
>  	},
>  	.probe = ad5755_probe,
>  	.id_table = ad5755_id,


