Return-Path: <linux-kernel+bounces-48421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC99845BC3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F0AB2D968
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF1562169;
	Thu,  1 Feb 2024 15:39:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E004662145
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801962; cv=none; b=TpKcEk76bGIltTmFaAqPDlcYTMYHArr1yZTRKuP2idRmehKaum9YNd6rftb56VvPK3kKjokB8b8rXpQKuoNRqlRX9UjOiATV01kJYh11hbVWFI1SuEWiy01lQy4jBJracpgUdjRPgGjyZJKtlijmwpbzcOh/Ny0bgHmvKBMfanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801962; c=relaxed/simple;
	bh=MlHt58vVMX7DlMJqyZr2vbaLLktiP3nHtP94fmm6Gqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgIVRgTHnMG8qPIdf9McHaowOgfRkeKhWU9pYxV/aWUDX53qizTzUoMXjMnQ+tYhpO6vp9DKQljngF9VdlrYCb1w1S0eZL77pCbUOPk0B8U9dt8ogIdB2TgPtSKDvoCDvpSC/ya3V0kFOw0it4N859i1E35NPEW4OKIH85aSm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rVZ9T-0007Us-Ou; Thu, 01 Feb 2024 16:38:55 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rVZ9S-003tA1-NX; Thu, 01 Feb 2024 16:38:54 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C71AF283055;
	Thu,  1 Feb 2024 15:38:38 +0000 (UTC)
Date: Thu, 1 Feb 2024 16:38:38 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ralf Schlatterbeck <rsc@runtux.com>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Vinod Koul <vkoul@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] spi-mxs: Fix chipselect glitch
Message-ID: <20240201-tributary-fax-dd6055160dbe-mkl@pengutronix.de>
References: <20240201131540.3dlqoxlrrbzshz7w@runtux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201131540.3dlqoxlrrbzshz7w@runtux.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 01.02.2024 14:15:40, Ralf Schlatterbeck wrote:
> There was a change in the mxs-dma engine that uses a new custom flag.
> The change was not applied to the mxs spi driver.
> This results in chipselect being deasserted too early.
> This fixes the chipselect problem by using the new flag in the mxs-spi
> driver.
> 
> Fixes: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
> Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
> ---
> For oscilloscope screenshots and a verbose explanation see my blog post
> at https://blog.runtux.com/posts/2024/02/01/
> 
>  drivers/spi/spi-mxs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index 1bf080339b5a..a296050c8bd3 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -39,6 +39,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/mxs-spi.h>
>  #include <trace/events/spi.h>
> +#include <linux/dma/mxs-dma.h>
>  
>  #define DRIVER_NAME		"mxs-spi"
>  
> @@ -251,8 +252,9 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
>  
>  		desc = dmaengine_prep_slave_sg(ssp->dmach,
>  				&dma_xfer[sg_count].sg, 1,
> -				(flags & TXRX_WRITE) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
> -				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +				(flags & TXRX_WRITE)
> +				? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
> +				DMA_PREP_INTERRUPT | MXS_DMA_CTRL_WAIT4END);

nitpick: Please omit the line break change from this patch.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

