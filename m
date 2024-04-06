Return-Path: <linux-kernel+bounces-134004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A395189ABFA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391192823E6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876613CF73;
	Sat,  6 Apr 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZrIJ05H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAA2D792;
	Sat,  6 Apr 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712420262; cv=none; b=Chg3fXJnHSBbk3cjO9iFmyT0VCUTBFz1TN0XgR3FA1cAmKWE2Os1/NAmuDmgvYH3fwAgPy4GxhIDyTv2Zg1TJnWsKPuDQGIzAUGZDlGNeKOAf9IvHX8DOTODd53mqHRMUwYIN9sur7nznJUouyyO4Z35eQs9aWowOBuPrQQJH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712420262; c=relaxed/simple;
	bh=jPQwg+meiOCUrY3cRR9RHhS/GVu17MEx5UyV6Tze9gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2/8VPYEWfFTjAnjIW4YUxDJnFlPjaWRg82aI9vsONo+oeE4/YYXbFzqxfSrXknpWLMoDGf8q4BpPmJ3uGH3+V3DOjjHedCfbMkKVlMxWxuvD6T1SxkcFhUuKe7sttZ5RfNQGCXBVJuc8sn9JshOKCMa/uwow54u7zqMuoJwWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZrIJ05H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B21C433C7;
	Sat,  6 Apr 2024 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712420261;
	bh=jPQwg+meiOCUrY3cRR9RHhS/GVu17MEx5UyV6Tze9gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SZrIJ05HvJ+5Csyn7NwIImLjil89NscHRzJ0eMFYEvWXY6Q0+2db3z92iazCRiRSu
	 H38Tp6Q3FlTuSIgwsONzWGh/zHDXyRdEKbYJrPXza+jMRLZwDzfB80IGTx/vbGCjCi
	 mm8NQIKjBB7cziAvZovBch9B5sJ/zDxIVnxuAITm8QQhXdlOJLT9PseN4P+PtDo02j
	 XtS2HfCKcuj9ZEWd3uPtZrtBMvUqZJ82b1oIDRwk7+rzJX2qyVMiLS7Fo07f1yMpZV
	 ijX2E3Bk7ukfyFoVUb82cR+alVzhDhHMoHPxrL9reTjkpVS+3hD6wnJpaOXU/SBWsy
	 vAR//L07Dz2dw==
Date: Sat, 6 Apr 2024 17:17:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v1] iio: adc: ad_sigma_delta: Clear pending interrupts
 before enable
Message-ID: <20240406171728.16170b48@jic23-huawei>
In-Reply-To: <20240404175126.110208-1-markus.burri@mt.com>
References: <20240404175126.110208-1-markus.burri@mt.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Apr 2024 19:51:26 +0200
Markus Burri <markus.burri@mt.com> wrote:

Hi Markus,


> For device will enable and disable irq contiously like AD7195,
> it use DOUT/RDY pin for both SPI transfer and data ready.
> It will disable irq during SPI transfer, and re-eanble irq after SPI transfer.
> That may cause irq status bit set to 1 during spi transfer.

Superficially that sounds like it might be an irq driver bug to me...
Or just possibly an irq chip doing lazy disabling?

> 
> When the active condition has been detected, the corresponding bit
> remains set until cleared by software. Status flags are cleared
> by writing a 1 to the corresponding bit position.
> 
> Signed-off-by: Markus Burri <markus.burri@mt.com>

I'll need an appropriate ADI ack for this one.

It seems highly unusual to be calling a generic irqchip related function in a
driver (there are no other such users).  So this seems unlikely to be
the right fix for this particular problem.

> ---
>  drivers/iio/adc/ad_sigma_delta.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index a602429cdde4..59544c39642a 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -515,6 +515,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  
>  irq_handled:
>  	iio_trigger_notify_done(indio_dev->trig);
> +	/*
> +	 * ACK pending interrupts from spi transfer.

Single line comment format would be fine here.

> +	 */
> +	irq_gc_ack_set_bit(irq_get_irq_data(sigma_delta->spi->irq));
>  	sigma_delta->irq_dis = false;
>  	enable_irq(sigma_delta->spi->irq);
>  


