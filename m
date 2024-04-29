Return-Path: <linux-kernel+bounces-162217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857278B57A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70071C22EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF0548F0;
	Mon, 29 Apr 2024 12:14:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18502535A4;
	Mon, 29 Apr 2024 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392884; cv=none; b=QayZPJi/TVGOQfHwwcCUM6L0KsEctDHzJAaioYDw7Xf/bpKtXtO7i4TkYIstHQbT1019/ZEhzo6FwwUzILrEMLEa98TYqYyb7ymcnbIp+cjMWpOXCUz+aZ2IKHngrXt5STXxugUfnQfdRbnTRv5nat3u3lpHggBsZaxAZDqt10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392884; c=relaxed/simple;
	bh=TY0BbP/ydR9gp4nj26TsMUiKKoe0SHMu2mZIdj/+l9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzOAcpvHl9pRvdGK7+BRBP19qh1iOr2aLoYHf+URlTw47cjWxzHXyN8izK8cbNp0M1pdfOaCFxhIbzgHgvHtW2c3qU32DbyIoDN6yuOvx++qfI2i+7u7MKoh3jbnnBAL79ANsDKgp2d/ogJlUnwVdDn4V5svV4uL7NvdcfNYcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D8602F4;
	Mon, 29 Apr 2024 05:15:09 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A223F73F;
	Mon, 29 Apr 2024 05:14:41 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:14:38 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] spi: sun4i: use 'time_left' variable with
 wait_for_completion_timeout()
Message-ID: <20240429131438.1f036341@donnerap.manchester.arm.com>
In-Reply-To: <20240429112843.67628-7-wsa+renesas@sang-engineering.com>
References: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
	<20240429112843.67628-7-wsa+renesas@sang-engineering.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 13:28:39 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Fix to the proper variable type 'unsigned long' while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/spi/spi-sun4i.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 11d8bd27b3e9..2ee6755b43f5 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -206,7 +206,8 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
>  				  struct spi_transfer *tfr)
>  {
>  	struct sun4i_spi *sspi = spi_controller_get_devdata(host);
> -	unsigned int mclk_rate, div, timeout;
> +	unsigned int mclk_rate, div;
> +	unsigned long time_left;
>  	unsigned int start, end, tx_time;
>  	unsigned int tx_len = 0;
>  	int ret = 0;
> @@ -327,10 +328,10 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
>  
>  	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
>  	start = jiffies;
> -	timeout = wait_for_completion_timeout(&sspi->done,
> -					      msecs_to_jiffies(tx_time));
> +	time_left = wait_for_completion_timeout(&sspi->done,
> +						msecs_to_jiffies(tx_time));
>  	end = jiffies;
> -	if (!timeout) {
> +	if (!time_left) {
>  		dev_warn(&host->dev,
>  			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
>  			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,


