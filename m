Return-Path: <linux-kernel+bounces-79785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F18626A4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54201C20E54
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AAA4C631;
	Sat, 24 Feb 2024 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtQ+ukrf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD916429;
	Sat, 24 Feb 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708798449; cv=none; b=XDelPixgj6Zo8uH5Nqzy855POEsrht4NVmA72150Nyq84ZU0qq4+rTuJ8eokda6BqfkADifO6w5JmxT7yXDhSUHTk7qwPf6YJpekDZec7EofEmCxff4woSg8oYN4O+ewRe6Ri3zp/IE6UU5EDC1RuSPgRnkSbsVFAniFVMLMsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708798449; c=relaxed/simple;
	bh=LB41P1zdziD/jinsl8eBZ2jf6IUljvsn2veNnk/hyj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPZ0rdXWQDHWuW1nQ6N7fCTX7dFCIual8Ev7vpwEd1yz9gcvNUY9c1gXzVK5gaAxLiRuPxBjEGrDYkGF6NNcVAgjwM0bnyRQ2H4O1OM9ErLPV+0RU1IWz1EGf4lSUnjY1MxRsDe+9RQ0ab+qChmxuajJVdvlAEjC1J+08BhqrCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtQ+ukrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD15C43390;
	Sat, 24 Feb 2024 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708798448;
	bh=LB41P1zdziD/jinsl8eBZ2jf6IUljvsn2veNnk/hyj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dtQ+ukrfmNwsDQuwcwye86Idu3Tus8e10nud7wuuCqnyBRLoX2CEcwOOTp2f77lph
	 yjy080zAGeT2zbDBVJD1rCdow4rI0F/Z+YgNmhHQu/FA1cjL+ZjKcnwLffqgMl0nH4
	 9kceuBvtBzUoh3lJbG+lC/CDwnZWGKwEGZ8cAwr+PqdAZScJXF2NL3kyP1xY+NZoux
	 12jhcgICiJeILqV192V/OkbB7BRrbnFq72vcLja9JBDPA6kcmGmR5GeEbhXACk/aDL
	 NOviesZbuxdyW8wT0ba+cgX/O+0EH8f4nhxPo1vlOgNT53/s77RDEfCNVb24zvJwf2
	 LynEZEStSgO8w==
Date: Sat, 24 Feb 2024 18:13:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-ads1298: Fix error code in probe()
Message-ID: <20240224181354.76842da7@jic23-huawei>
In-Reply-To: <e315c126-619c-48a1-a5d8-001e5ed01930@topic.nl>
References: <5f393a87-ca8b-4e68-a6f4-a79f75a91ccb@moroto.mountain>
	<e315c126-619c-48a1-a5d8-001e5ed01930@topic.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 08:10:25 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Good catch on both patches.
> 
> If so desired, you have my
> 
> Acked-by: Mike Looijmans <mike.looijmans@topic.nl>

Dan, here is a classic example of why I think any series with more than
1 patch could benefit from a cover letter. It gives somewhere for
reviewers to give tags for the lot in a fashion b4 can understand.

Otherwise great find and applied to the togreg branch of iio.git
with Mike's tag added to both of them!  Hopefully the fixes tags will
remain stable - whilst in theory that tree doesn't get rebased, in practice
it might if I messed anything up enough :( 

Thanks

Jonathan


> 
> 
> 
> On 22-02-2024 07:14, Dan Carpenter wrote:
> > There is a copy and paste bug here, it should be "reg_vref" instead of
> > "reg_avdd".  The "priv->reg_avdd" variable is zero so it ends up
> > returning success.
> >
> > Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   drivers/iio/adc/ti-ads1298.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> > index ed895a30beed..67637f1abdc7 100644
> > --- a/drivers/iio/adc/ti-ads1298.c
> > +++ b/drivers/iio/adc/ti-ads1298.c
> > @@ -657,7 +657,7 @@ static int ads1298_probe(struct spi_device *spi)
> >   	priv->reg_vref = devm_regulator_get_optional(dev, "vref");
> >   	if (IS_ERR(priv->reg_vref)) {
> >   		if (PTR_ERR(priv->reg_vref) != -ENODEV)
> > -			return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
> > +			return dev_err_probe(dev, PTR_ERR(priv->reg_vref),
> >   					     "Failed to get vref regulator\n");
> >   
> >   		priv->reg_vref = NULL;  
> 
> 


