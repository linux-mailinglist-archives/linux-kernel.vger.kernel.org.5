Return-Path: <linux-kernel+bounces-47027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E945844832
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCD128A1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295973E49D;
	Wed, 31 Jan 2024 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="vpLA9WZb"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DE3FB1B;
	Wed, 31 Jan 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730134; cv=none; b=lulEF9wPer63pA3GkKIWklfWP0ZJYRqXJoDXT17TjmNHrhuw0HJnzc7T4izCWv9vWOkD5OeqDD+f+rgIyBA6GhOdQwqu7lEGkb5EamOHm1koKklbu+Q6n7UlB7toGy6vInVTmSc/AVDZ/8+xn0q7OrVbmfGIE2TCvJB+4xCxlgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730134; c=relaxed/simple;
	bh=HfEeR4MwJftRCskWBfPPSp7AlKEy7Zjknx2BVaGOJBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWYLW2kFWHHDXiMB16TSnRq0FoMoVRPOKfKNMc5vEFXv0YbOyCM5IDIm8CpR+P87GGoxSTXZVEtrEb8REt9SL6K6ktEir6im384QaU0r/BtTCTsKMaM+iW7qbdWjbOywYmfZBclm5MNkQTPbZ4koYSIACHTY5kzX2Piro7yMKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=vpLA9WZb; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A02F422B70;
	Wed, 31 Jan 2024 20:42:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706730130;
	bh=+K3WVKgZ1fWnpN1m6qoOBzVUSoAk5LMmTV/l3Hp8dMU=; h=From:To:Subject;
	b=vpLA9WZbGyS5yGYnXdvEOeicCcSD8At9fQJ0HSzQVEvS4QTiZsOss7LArzGKItS1Y
	 rgQLbPcwPMoLFvCXJ6KbDnlh3QzXvlIE36EWtHbTKJv1dhNuJyAfWToxxDmWJ/fNbJ
	 87NwCIEjzO7iDLhtkYhpLiDvBQCDKxYqC2ldxZlLtZy4jrYbzWALolIHqbtCdqz2Lr
	 W+HYj6+Zq92UGlubi3VZUJYDyzHw54BPSdbw/a8l3QOVeKSsROKQN3PH7SSRwCu7Qa
	 CyLpN17qrN/is5nPRH3cAOk7kfEisnNA+6Uw+jVCSK5ShxX2iZdxvfIczDrJL2GDqd
	 QDXPEjpqdM0qw==
Date: Wed, 31 Jan 2024 20:42:07 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: carlos.song@nxp.com
Cc: broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, linux-imx@nxp.com, benjamin@bigler.one,
	stefanmoring@gmail.com, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: imx: fix the burst length at DMA mode and CPU
 mode
Message-ID: <20240131194207.GB12870@francesco-nb>
References: <20240131101916.437398-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131101916.437398-1-carlos.song@nxp.com>

On Wed, Jan 31, 2024 at 06:19:16PM +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> For DMA mode, the bus width of the DMA is equal to the size of data
> word, so burst length should be configured as bits per word.
> 
> For CPU mode, because of the spi transfer len is in byte, so burst
> length should be configured as bits per byte * spi_imx->count.
> 
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
> Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when using dma")
> Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of assuming 8-bits")
> ---
> Changes for V2:
> - Removed BITS_PER_BYTE defination
> ---
>  drivers/spi/spi-imx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 546cdce525fc..0436e7a161ef 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -660,15 +660,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  			<< MX51_ECSPI_CTRL_BL_OFFSET;
>  	else {
>  		if (spi_imx->usedma) {
> -			ctrl |= (spi_imx->bits_per_word *
> -				spi_imx_bytes_per_word(spi_imx->bits_per_word) - 1)
> +			ctrl |= (spi_imx->bits_per_word - 1)
>  				<< MX51_ECSPI_CTRL_BL_OFFSET;
>  		} else {
>  			if (spi_imx->count >= MX51_ECSPI_CTRL_MAX_BURST)
> -				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST - 1)
> +				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
>  						<< MX51_ECSPI_CTRL_BL_OFFSET;
>  			else
> -				ctrl |= (spi_imx->count * spi_imx->bits_per_word - 1)
> +				ctrl |= (spi_imx->count * BITS_PER_BYTE - 1)
>  						<< MX51_ECSPI_CTRL_BL_OFFSET;
>  		}
>  	}

Add #include <linux/bits.h> given you are using BITS_PER_BYTE

Francesco


