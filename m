Return-Path: <linux-kernel+bounces-63960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352308536CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82471F25462
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860D75FBBF;
	Tue, 13 Feb 2024 17:07:14 +0000 (UTC)
Received: from tux.runtux.com (tux.runtux.com [176.9.82.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685065FB9F;
	Tue, 13 Feb 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.82.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844034; cv=none; b=kPh0QdMRFOocbdzGzUCCBORdgRhG6kqadi6DOOFWsEEj9fFAhn6QcxlDcRIPCrfsCjqQK6zfXnECrjJfCTmrxlCcIMn9Pg7rIK0SoavJe0gazMgVUqMnu7iFMTEU1nrqbG5ebohMHyqFpCE0NXRtlQumdLayBD+JBaJs9+ACphU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844034; c=relaxed/simple;
	bh=WY4Ew4M1a+MQWgVB9uaqd/djXF9yXK8OmPFCiLUqC+g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3CrESqwFMITbOtsXKD4Hx54jIn9RZbTmOAMBHFhMUXdblaTGq4gdTT1lbGqve8z0pfi+Xzr9wSWx/zdVY7xxQ4vqNMdLVeljKT0eGdHdMjmXxwPRX38t4g9y/6LtY/O0TCGvwC3itlHBl1+uty69QL2rBgKNdG9MaxNnPATB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com; spf=pass smtp.mailfrom=runtux.com; arc=none smtp.client-ip=176.9.82.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtux.com
Received: from localhost (localhost [127.0.0.1])
	by tux.runtux.com (Postfix) with ESMTP id CB09E6EF5B;
	Tue, 13 Feb 2024 18:07:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
	by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id dw89rLCWcDQS; Tue, 13 Feb 2024 18:07:02 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
	(Authenticated sender: postmaster@runtux.com)
	by tux.runtux.com (Postfix) with ESMTPSA id C5BE96EEF6;
	Tue, 13 Feb 2024 18:06:57 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
	id 63C29469; Tue, 13 Feb 2024 18:06:57 +0100 (CET)
Date: Tue, 13 Feb 2024 18:06:57 +0100
From: Ralf Schlatterbeck <rsc@runtux.com>
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] spi-mxs: Fix chipselect glitch
Message-ID: <20240213170657.puwlx5pjl3odcs2k@runtux.com>
References: <20240202115330.wxkbfmvd76sy3a6a@runtux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202115330.wxkbfmvd76sy3a6a@runtux.com>
X-ray: beware
User-Agent: NeoMutt/20180716

On Fri, Feb 02, 2024 at 12:53:30PM +0100, Ralf Schlatterbeck wrote:
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
> History:
> Omit the line break change from patch requested by Marc Kleine-Budde
> <mkl@pengutronix.de>
> 
>  drivers/spi/spi-mxs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index 1bf080339b5a..88cbe4f00cc3 100644
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
> @@ -252,7 +253,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
>  		desc = dmaengine_prep_slave_sg(ssp->dmach,
>  				&dma_xfer[sg_count].sg, 1,
>  				(flags & TXRX_WRITE) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
> -				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +				DMA_PREP_INTERRUPT | MXS_DMA_CTRL_WAIT4END);
>  
>  		if (!desc) {
>  			dev_err(ssp->dev,
> -- 
> 2.20.1
> 
> -- 
> Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
> Open Source Consulting                  www:   www.runtux.com
> Reichergasse 131, A-3411 Weidling       email: office@runtux.com

Any news on this, will it be picked up for the next merge window?

Thanks + kind regards
Ralf Schlatterbeck
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com

