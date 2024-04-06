Return-Path: <linux-kernel+bounces-133982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 603FF89ABB4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901101C20BE7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985AB3B79C;
	Sat,  6 Apr 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO0OFTzQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F33A1AB;
	Sat,  6 Apr 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418169; cv=none; b=ETWgPrBcD09ACwVkOMnExacQLNTz7S/ZJ0oEG0S4fALtsgwDCQa+rXCq107CIPa55FdZ3tcmJOjaeW7kB1dYtf1v3kflr3H1DnCVAWXICblFdyRCbhpFW/kzyPI1ttnjMkMk+DYNI9Md/BscPOfmU5ObnBidcKvCfQYtSVA3o+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418169; c=relaxed/simple;
	bh=hCjVczF/+i7ArwQOZesXRzF8mpKkIe90t9B2oG+LLs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmSAzUZIf3SLTizC2vE+wpnLglUpCHCd6K7FpzZPYvh1B68ysyjMfbo7Y47rxnfYuEKM/3viEq2q75kK/+X72j4hKks6LOvvkND34C6FqkjnK2Pzt0ow3LQD2XwFi0m7TEOYUOXrqPCJboRxijXuS8+hgQjhz+lstTr9GeraFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO0OFTzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDE7C433C7;
	Sat,  6 Apr 2024 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712418169;
	bh=hCjVczF/+i7ArwQOZesXRzF8mpKkIe90t9B2oG+LLs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dO0OFTzQK8FQP88si9FI6Mzyhtt6Zl0Y21i4i0Ydkc2HfcxfXXAEL2MnBXYDQB2K4
	 +Qr/X0i3iBMflqfh0WFKGc3kW3JU33sqH0o1TOeU8QjxrKX6ojwkayK40n143BsfKy
	 eIN2Pb0zSyCvtyD/eZ7A3sbuF3wOJ32/H0Lz4821fAMaVQGYaRbyvA6ZZBwNLmijXd
	 ud6gwcs/WeCKNshS3khphIrQ/rVthAQx9aQSjqc0/ej4nEo41YZWtsTS9D4CjdJTkI
	 LRi6DetaZu2SUbKhOW0FbiVbV6wpdqLQ5DQAqWxyqWWOSWmqG0G9t1IlixlZDicvLE
	 S8Astdtm+UBgw==
Date: Sat, 6 Apr 2024 16:42:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9306: Fix off by one in
 apds9306_sampling_freq_get()
Message-ID: <20240406164235.55193b5f@jic23-huawei>
In-Reply-To: <7a54d993-8aff-472f-8132-85e0ca79ff13@tweaklogic.com>
References: <69c5cb83-0209-40ff-a276-a0ae5e81c528@moroto.mountain>
	<7a54d993-8aff-472f-8132-85e0ca79ff13@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 17:44:31 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 4/4/24 18:01, Dan Carpenter wrote:
> > The > comparison needs to be >= to prevent an out of bounds access.
> > 
> > Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   drivers/iio/light/apds9306.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> > index 4d8490602cd7..49fa6b7d5170 100644
> > --- a/drivers/iio/light/apds9306.c
> > +++ b/drivers/iio/light/apds9306.c
> > @@ -635,7 +635,7 @@ static int apds9306_sampling_freq_get(struct apds9306_data *data, int *val,
> >   	if (ret)
> >   		return ret;
> >   
> > -	if (repeat_rate_idx > ARRAY_SIZE(apds9306_repeat_rate_freq))
> > +	if (repeat_rate_idx >= ARRAY_SIZE(apds9306_repeat_rate_freq))
> >   		return -EINVAL;  
> Good find.
> 
> Reviewed-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> 
Applied to the togreg branch of iio.git (where the fixes patch is currently)
and pushed out as testing initially because there is other stuff in there
I want 0-day to checkout before I make a mess of linux-next.

Thanks,

Jonathan

> Regards,
> Subhajit Ghosh
> >   
> >   	*val = apds9306_repeat_rate_freq[repeat_rate_idx][0];  
> 


