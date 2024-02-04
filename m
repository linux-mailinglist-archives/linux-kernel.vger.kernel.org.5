Return-Path: <linux-kernel+bounces-51806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97628848F80
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A189B21B7E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F323770;
	Sun,  4 Feb 2024 17:00:57 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA623750
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707066056; cv=none; b=WN9xJu4z3K6GbX4lAXOszyZFziSmkNa9/p/Yj0cprvygkFisQb7yeyA3ntnk36asSms/cznUpPaOkADD05PNuunJi9m2ucbn4+DCopXcrHdhrzbsNVfgwKFqovisfehVS2cFtXTqMbss9N++3iCVl8UlqEtz0EDeZKzYT+6CvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707066056; c=relaxed/simple;
	bh=L4N+w+Xl9amelgcnkkk1AsPQ5omDQKGC5rGF9ag5Cj8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFvyZOlz6FSgt7H1wp6pLWwQnbCwNoc1GG6crvwQmn3rYmOJuKB+Hmix7wDDFLnVz1qoZwRZIf0n7zIsnsJkFhOzq6FBXXpy+XnforDeWNyAiUWcCnE6uXAwYDdYZdYk/2FvbBlWC1AwLLIqn7qBIK/nPe9TdLyTwE0to/klFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id f4473253-c37e-11ee-b972-005056bdfda7;
	Sun, 04 Feb 2024 19:00:53 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 4 Feb 2024 19:00:52 +0200
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 22/39] ata: pata_ep93xx: add device tree support
Message-ID: <Zb_CxFpxm3WoyeCC@surfacebook.localdomain>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
 <20240118-ep93xx-v7-22-d953846ae771@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-ep93xx-v7-22-d953846ae771@maquefel.me>

Thu, Jan 18, 2024 at 11:21:05AM +0300, Nikita Shubin kirjoitti:
> - add OF ID match table
> - drop platform DMA and filters
> - change DMA setup to OF, so we can defer probe

..

> +	drv_data->dma_rx_channel = dma_request_chan(dev, "rx");
> +	if (IS_ERR(drv_data->dma_rx_channel)) {
> +		ret = PTR_ERR(drv_data->dma_rx_channel);
> +		return dev_err_probe(dev, ret, "rx DMA setup failed\n");

It can be done in one statement:

		return dev_err_probe(dev, PTR_ERR(drv_data->dma_rx_channel),
				     "rx DMA setup failed\n");

> +	}

..

> +	drv_data->dma_tx_channel = dma_request_chan(&pdev->dev, "tx");
> +	if (IS_ERR(drv_data->dma_tx_channel)) {
> +		ret = PTR_ERR(drv_data->dma_tx_channel);
> +		dev_err_probe(dev, ret, "tx DMA setup failed\n");

In the similar way

		ret = dev_err_probe(...);

> +		goto fail_release_rx;
>  	}

-- 
With Best Regards,
Andy Shevchenko



