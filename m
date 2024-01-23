Return-Path: <linux-kernel+bounces-35154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7767E838CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6C71C21987
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB655D72F;
	Tue, 23 Jan 2024 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o8C4t3nA"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6AE5EE66;
	Tue, 23 Jan 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007881; cv=none; b=oSIufhyZwMYv91PHb3o4dT39hTkN3Y0jDuDE/b9z9lzI27yBl6m5Fjxxynu9t5hEFE7vI0PLSjHSJKAEaNTvFw9/3JbN9S5DBqs0I9CQKvx8VxuWk5YMAcaO31ihi3TeTZu0h3SFxKEt6tlOj17DadJhMyOCAX2H7t2fIxthdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007881; c=relaxed/simple;
	bh=xCnJ8xJuxebCpDNF2e7MIWGu7ImkBszdj5dRRRtzFV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdMKIKavGptwXelXP5TiRRKEV5omr/LL9WXlXCT2T+Y8+XU/NMxQE0OOHnxlzWjZE/mqB2+se+WXq25HPOfbpNCJ2pySJdy2g7ZvXQy9KXLiABJ4ZU+APXSl0NV1iZI5p4ViaWTRbKZDxW13HGIHGcv32MQCAbebf84XIFP/A+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o8C4t3nA; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CEEF7E0009;
	Tue, 23 Jan 2024 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706007871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERkGN3ut0bd4IXhlqDLq7x6w+GseXu2L5k7FffyevXA=;
	b=o8C4t3nAHO2+SfiDtDcfHHn8xtehXnX+K0kJekEC7AAv3IbXQN/qVxQnIWfVtRPo6akAh1
	Li/wqOSu62hWF0+qXKl8ObKfnLqq+0EqavcINl9NjCyGACK3x103YsCA3UgO13Wxg2H5j0
	M2gzq4wvdjaPtbFNzCIrnqNfi00wcO41p7j3qHel6Ea3a1lKFxEBURiHMzfZjT3mkAhfYw
	cJVnnjsXwUc1HdP8jc+uqOKXDKw1s/h4nvSpP8i/bNWGR2kgqq65N2Q9wjcdO1Ez+a+NqU
	w+NDSBtyn/ZpZunjnjFUGTMH/4bnrPvJb2BK7ZZFWj6v4Tbtu41i2x/FGUMaoA==
Date: Tue, 23 Jan 2024 12:04:30 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Guenter Roeck
 <linux@roeck-us.net>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
Message-ID: <20240123120430.75c7ace0@bootlin.com>
In-Reply-To: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Mark,

On Mon, 22 Jan 2024 01:21:46 +0000
Mark Brown <broonie@kernel.org> wrote:

> As reported by Guenter the limit we've got on the number of chip selects is
> set too low for some systems, raise the limit. We should really remove the
> hard coded limit but this is needed as a fix so let's do the simple thing
> and raise the limit for now.
> 
> Fixes: 4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/spi/spi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 471fe2ff9066..d71483bf253a 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -21,7 +21,7 @@
>  #include <uapi/linux/spi/spi.h>
>  
>  /* Max no. of CS supported per spi device */
> -#define SPI_CS_CNT_MAX 4
> +#define SPI_CS_CNT_MAX 8
>  
>  struct dma_chan;
>  struct software_node;
> 

I got also the issue related to SPI_CS_CNT_MAX introduced by 4d8ff6b0991d ("spi:
Add multi-cs memories support in SPI core").

Errors like the following one are raised at boot for each of my SPI devices:
  spi_master spi0: No. of CS is more than max. no. of supported CS
  spi_master spi0: Failed to create SPI device for /soc@ff000000/cpm@9c0/spi@a80/idt821034@0
and none of my SPI devices were probed.

On my system, 9 SPI devices are present on my SPI bus and so, I have 9 chip-selects
(gpio chip-selects in my case).

Moving the SPI_CS_CNT_MAX value from 4 to 8 is not enough to handle my case.
Tested moving SPI_CS_CNT_MAX to 16 and it was ok.

Best regards,
Hervé


