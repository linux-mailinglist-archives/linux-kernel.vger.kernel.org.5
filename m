Return-Path: <linux-kernel+bounces-162219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB28B57A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2483288DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC054730;
	Mon, 29 Apr 2024 12:16:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB8B535DD;
	Mon, 29 Apr 2024 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392966; cv=none; b=FkKfs/slV+CZSAC6AKY/GYjo29Lkrkcz3CpJlfRzu4AxBlYH0tbzj12ZCt6JtqbbVc3uI35VHSOAo0pXDZdvPPGvyndq0/fQggv3lGaee4l99tchthGZSOA49ad4pUiM7EMdv60IvQiNFCX51RaxcsoDAiQ7YnntBPaM4e+fmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392966; c=relaxed/simple;
	bh=3f7kFrWN9PnhKtMaJl5LG1KYsuwVsMgdCCXo9ToFZnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9JvA+qbPz0CZS5Zl8LX4hoOvosixo6XkEUe7O2MLj6lETdY/TwH84ccmHTOr1BOHvsGvDkby45zvOtMPEQrbF3FomzFpiSOOoi6ppKbbRgeqg3P4fLdU/RGNruw2CUsng39OQIO0ySS+DtSXRKtV8qBmDwx+HB+u6tCAjdSPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 286752F4;
	Mon, 29 Apr 2024 05:16:31 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18BFB3F73F;
	Mon, 29 Apr 2024 05:16:02 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:16:00 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] spi: sun6i: use 'time_left' variable with
 wait_for_completion_timeout()
Message-ID: <20240429131600.4e910d8a@donnerap.manchester.arm.com>
In-Reply-To: <20240429112843.67628-8-wsa+renesas@sang-engineering.com>
References: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
	<20240429112843.67628-8-wsa+renesas@sang-engineering.com>
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

On Mon, 29 Apr 2024 13:28:40 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

Hi,

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
> ---
>  drivers/spi/spi-sun6i.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index cd018ea1abf1..7bbe7ea0d66a 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -277,7 +277,8 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
>  				  struct spi_transfer *tfr)
>  {
>  	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
> -	unsigned int div, div_cdr1, div_cdr2, timeout;
> +	unsigned int div, div_cdr1, div_cdr2;
> +	unsigned long time_left;
>  	unsigned int start, end, tx_time;
>  	unsigned int trig_level;
>  	unsigned int tx_len = 0, rx_len = 0, nbits = 0;
> @@ -488,26 +489,26 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
>  
>  	tx_time = spi_controller_xfer_timeout(host, tfr);
>  	start = jiffies;
> -	timeout = wait_for_completion_timeout(&sspi->done,
> -					      msecs_to_jiffies(tx_time));
> +	time_left = wait_for_completion_timeout(&sspi->done,
> +						msecs_to_jiffies(tx_time));
>  
>  	if (!use_dma) {
>  		sun6i_spi_drain_fifo(sspi);
>  	} else {
> -		if (timeout && rx_len) {
> +		if (time_left && rx_len) {
>  			/*
>  			 * Even though RX on the peripheral side has finished
>  			 * RX DMA might still be in flight
>  			 */
> -			timeout = wait_for_completion_timeout(&sspi->dma_rx_done,
> -							      timeout);
> -			if (!timeout)
> +			time_left = wait_for_completion_timeout(&sspi->dma_rx_done,
> +							      time_left);

Nit: indentation is off here. Regardless:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> +			if (!time_left)
>  				dev_warn(&host->dev, "RX DMA timeout\n");
>  		}
>  	}
>  
>  	end = jiffies;
> -	if (!timeout) {
> +	if (!time_left) {
>  		dev_warn(&host->dev,
>  			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
>  			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,


