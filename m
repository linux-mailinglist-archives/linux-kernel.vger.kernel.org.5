Return-Path: <linux-kernel+bounces-18914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AD5826511
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BA4281F33
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32F913AE7;
	Sun,  7 Jan 2024 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou2myyGP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FCA13AC0;
	Sun,  7 Jan 2024 16:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663E1C433C8;
	Sun,  7 Jan 2024 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704644580;
	bh=pAJa9FhPlrM8i2rsTryIUZC2aAj10fpZi1sCrni16rA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ou2myyGPM00LYZQZm5eo2fbC5id+sXzIFYVT9N0XNeDcJGbIpgQOD4hwaYZuQati6
	 qpECDvraCEX1KV1vrGl8vLXwnJcGKcLJUTos7oZ57RSayBm6Y5khuWbovJcRXQNCNO
	 6eX/YMQgXEC3Si5nwJq/RvT852ncyEr+gPEOnJ9x/pcAoMb9Q/Plq5ANAqh91jGcd0
	 gmvafTL+oLqR4mzgIpfw0cG0SUI4CiJI17H+80y6jZGoGJO/gRNcMftkXUTgD/hcfQ
	 YMjE6LreNAO9h8RAz5vEZZIFdWlqn/pDAN4AmZLe7ut3X59wY6yCuHLnPTM6vQHoCi
	 pW/ifaawVPR4g==
Date: Sun, 7 Jan 2024 16:22:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gts-helper: Fix division loop
Message-ID: <20240107162253.66c1f0f1@jic23-huawei>
In-Reply-To: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
References: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 11:34:28 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The loop based 64bit division may run for a long time when dividend is a
> lot bigger than the divider. Replace the division loop by the
> div64_u64() which implementation may be significantly faster.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")

Hmm. Fix or not perf improvement?  I'm going to take the middle ground
and leave the fixes tag, but not rush this in.

So applied to the togreg branch of iio.git and for now just pushed out
as testing for 0-day etc to take a look before I rebase that tree after
rc1.



> ---
> 
> I've implemented also a fixup series for supporting rounding of
> gains/scales:
> https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1701780964.git.mazziesaccount@gmail.com/
> 
> That series does also remove the offending loop.
> 
> We don't currently have any in-tree users of GTS helpers which would
> need the rounding support so pushing the rounding is not urgent (and I
> haven't heard of Subjahit whose driver required the rounding). Hence, we
> may want to only take this loop fix in for now (?) and reconsider
> rounding when someone need that.
> 
> Jonathan, what's your take on this?
Agreed - let us wait for the rounding to have a user, but makes sense
to tidy this corner up in the meantime.

Thanks,

Jonathan

> 
>  drivers/iio/industrialio-gts-helper.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 7653261d2dc2..abcab2d38589 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -34,7 +34,7 @@
>  static int iio_gts_get_gain(const u64 max, const u64 scale)
>  {
>  	u64 full = max;
> -	int tmp = 1;
> +	int tmp = 0;
>  
>  	if (scale > full || !scale)
>  		return -EINVAL;
> @@ -48,8 +48,7 @@ static int iio_gts_get_gain(const u64 max, const u64 scale)
>  		tmp++;
>  	}
>  
> -	while (full > scale * (u64)tmp)
> -		tmp++;
> +	tmp += div64_u64(full, scale);
>  
>  	return tmp;
>  }
> 
> base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab


