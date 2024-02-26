Return-Path: <linux-kernel+bounces-82238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA98680F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744C91F2CB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A13312FF8E;
	Mon, 26 Feb 2024 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdW5l872"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99B1292FF;
	Mon, 26 Feb 2024 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975570; cv=none; b=ju6KapSK3teaWcxTY5NjTWLQOBQ1em+6R/+ztWkxiJiO/1WOqhD2AcQQ3JLnbjkT41GdlLutTcdGHXHnb/L/QoP1zEomvnr3/B/EZPpBVBKMwr/kBEvlGJCSkk7bmzQvgI81MHs9XlHJzc4rFWflu+R5glC7RfyXiPhLRt7btEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975570; c=relaxed/simple;
	bh=wa/PL+cJrIT91SSldfAwdpGdBKcVakUgXeaWdCAa8AI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfZye3PHd2rCdREfkr2sTpAra1u6+yuniPqKVJYOLuoeDSeNv5emLVd5z8ynHBTm96pUrUiQeniEi9sKW9fYGRRnxueM50Mg/iJWKAKgqX+iR/0Ot+FubO7Ee2JcRveCf4nXOX0e6UIA2ZReFhxlFlcT8HCXHo+NIeBfE8e1KKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdW5l872; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582FCC433C7;
	Mon, 26 Feb 2024 19:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975570;
	bh=wa/PL+cJrIT91SSldfAwdpGdBKcVakUgXeaWdCAa8AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YdW5l872paoUlDDRPdE7jiO/yJ5UVB3xfMDXUsPRSHJZvjO7ommFy+UfJlPOokx99
	 6GlsSva/hUY1R1R4Ccpg0YOhUJKspl4Wl0qfrMCVV8SAYkbkUz2z0HrflLYH7/G0fa
	 eAzp2RI0WmfIaqr+sY5daUur1oxcSQKvT+zZaDJ7Zh/BEIUFI7wjQLemLR5ZDHKqt8
	 3ym0ublhDXbMBgWBGGErwKo4sZGt1V0bfUC6OrDNCuQb2zy38V6YcPRLAqCMuI4XzS
	 EZ05p2p+4bXV6PUMkEn869U59mpQ9Cya2Ku+ex5YuRDVDCeQgdY/KYv+nHVdXdBk/H
	 I/CWURPgdQDpw==
Date: Mon, 26 Feb 2024 19:25:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/2] iio: dac: ad5755: make use of of_device_id table
Message-ID: <20240226192555.14aa178e@jic23-huawei>
In-Reply-To: <20240225201654.49450-1-krzysztof.kozlowski@linaro.org>
References: <20240225201654.49450-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 21:16:53 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Populate the of_device_id table with match data, reference it in the
> spi_driver struct and use spi_get_device_match_data() to perform the
> type matching to fix warning:
> 
>   ad5755.c:866:34: error: unused variable 'ad5755_of_match' [-Werror,-Wunused-const-variable]
> 
> This is also preferred way of matching device variants, then relying on
> fallback via spi_device_id.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Rework according to comments.
> 
> An old v1:
> https://lore.kernel.org/all/20230810111933.205619-1-krzysztof.kozlowski@linaro.org/
> ---
>  drivers/iio/dac/ad5755.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 404865e35460..877c1125d892 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -809,7 +809,7 @@ static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
>  
>  static int ad5755_probe(struct spi_device *spi)
>  {
> -	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
> +	enum ad5755_type type = (kernel_ulong_t)spi_get_device_match_data(spi);
>  	const struct ad5755_platform_data *pdata;
>  	struct iio_dev *indio_dev;
>  	struct ad5755_state *st;
> @@ -864,11 +864,11 @@ static const struct spi_device_id ad5755_id[] = {
>  MODULE_DEVICE_TABLE(spi, ad5755_id);
>  
>  static const struct of_device_id ad5755_of_match[] = {
> -	{ .compatible = "adi,ad5755" },
> -	{ .compatible = "adi,ad5755-1" },
> -	{ .compatible = "adi,ad5757" },
> -	{ .compatible = "adi,ad5735" },
> -	{ .compatible = "adi,ad5737" },
> +	{ .compatible = "adi,ad5755", (void *)ID_AD5755 },
> +	{ .compatible = "adi,ad5755-1", (void *)ID_AD5755 },
> +	{ .compatible = "adi,ad5757", (void *)ID_AD5757 },
> +	{ .compatible = "adi,ad5735", (void *)ID_AD5735 },
> +	{ .compatible = "adi,ad5737", (void *)ID_AD5737 },
If the enum value is 0, what happens?  We ignore the return value and
check the other table - so still fragile :(

That's why I asked that these be pointers, not enum values...

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ad5755_of_match);
> @@ -876,6 +876,7 @@ MODULE_DEVICE_TABLE(of, ad5755_of_match);
>  static struct spi_driver ad5755_driver = {
>  	.driver = {
>  		.name = "ad5755",
> +		.of_match_table = ad5755_of_match,
>  	},
>  	.probe = ad5755_probe,
>  	.id_table = ad5755_id,


