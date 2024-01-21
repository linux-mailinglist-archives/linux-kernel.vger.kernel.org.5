Return-Path: <linux-kernel+bounces-32136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC238356FD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E462B2305D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA163A1C3;
	Sun, 21 Jan 2024 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUZCdhIe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67C3A1AA;
	Sun, 21 Jan 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856371; cv=none; b=pDUGZK9ffBdD3cmJwJXYeAleizuWY3omqLkD8WUepKshQmK7PumXZfw1AvMuofBBVpG1M7BtCGi8KWr3UnvJPfhrGLjljN5H0KbtsXJOQwzDq7e3SLrIMVzuUczy1rKI/4U+IWSX7ACa85pjZyTuutJK0TTVyWj0QpCEl6jCpM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856371; c=relaxed/simple;
	bh=/lIv+VUUpsGxYSSv4VVFy0oNYdfHK3EeEkjk58z7vws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pO0QiCJgkIfJhDFrewRXxdUsMkaTMQ/nr9ipjQuzN97QmIc8WHUZWbIN9novnQxLVWXS2GBA6uFA58fd7aLOKaOZL1Ai7MmyIO+l5/6Y8qMl8YqTVM7KozOrYmpGgfN1nVvJrm4P5WbhL99f/IHlHOaUYrWGXmBR1ir2rDPPJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUZCdhIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5F2C433C7;
	Sun, 21 Jan 2024 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705856370;
	bh=/lIv+VUUpsGxYSSv4VVFy0oNYdfHK3EeEkjk58z7vws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bUZCdhIebivnc+wfH++5dnJjGOB18ZtHPlpABi/SwFdNRaiauMUsMFs/eghUxK4RF
	 Q2JkBEPVM3PWpE97XSLr/Mk6dDUPgSzp9eIcqQHADST1JaNmyCbTrX5EiI9WBGTBmU
	 lrhp9WRXlPphcYiKECHYUarpj2WrXzGD0MBTD8ecPI7gbiNvnc9mbqe7aTutxdkfnj
	 /r6OXvzb3baex4lPdaGp9K3U1Hiwh06+TC/W4NqxO2a0V+NskO2l5vh/8pa0XNpoIn
	 t3PRIuWu2vc9iYFxE25nyUs3+vKeRz4oTdULG1aZrpGm5h96dGWrkChuT/OT2t0sG2
	 J4VdupMUhA0Dw==
Date: Sun, 21 Jan 2024 16:59:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7091r8: Fix error code in
 ad7091r8_gpio_setup()
Message-ID: <20240121165914.21486583@jic23-huawei>
In-Reply-To: <ZaCdNl6S1IRjyWru@debian-BULLSEYE-live-builder-AMD64>
References: <fd905ad0-6413-489c-9a3b-90c0cdb35ec9@moroto.mountain>
	<ZaCdNl6S1IRjyWru@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jan 2024 23:00:22 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 01/08, Dan Carpenter wrote:
> > There is a copy and paste error so it accidentally returns ->convst_gpio
> > instead of ->reset_gpio.  Fix it.
> > 
> > Fixes: 0b76ff46c463 ("iio: adc: Add support for AD7091R-8")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---  
> 
> Oops, that also slipped through.
> Thanks for the fix.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> >  drivers/iio/adc/ad7091r8.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
> > index 57700f124803..700564305057 100644
> > --- a/drivers/iio/adc/ad7091r8.c
> > +++ b/drivers/iio/adc/ad7091r8.c
> > @@ -195,7 +195,7 @@ static int ad7091r8_gpio_setup(struct ad7091r_state *st)
> >  	st->reset_gpio = devm_gpiod_get_optional(st->dev, "reset",
> >  						 GPIOD_OUT_HIGH);
> >  	if (IS_ERR(st->reset_gpio))
> > -		return dev_err_probe(st->dev, PTR_ERR(st->convst_gpio),
> > +		return dev_err_probe(st->dev, PTR_ERR(st->reset_gpio),
> >  				     "Error on requesting reset GPIO\n");
> >  
> >  	if (st->reset_gpio) {
> > -- 
> > 2.42.0
> > 
> >   


