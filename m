Return-Path: <linux-kernel+bounces-68678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EAD857E44
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737511C222AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F57812C537;
	Fri, 16 Feb 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OK6FDq9M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21812BEA5;
	Fri, 16 Feb 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091905; cv=none; b=IzYjzDZqxZPm+phJlXWJtMDAp6scWcxFqJ70jKHt7riSjFvWlHTwMthmzqSOMhr5Rzu+C6MAoYE2c8IhWc24jIYWewxCNz2xF54FY9QIPbE5mtoQlOs1V1LCLaipS2YapD5GJw14ZXncLe+kDK+4cvy+Nu+MpqTu0Ddjv+8c6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091905; c=relaxed/simple;
	bh=CB4g2cCQgiWIC67i2T4tPOsa8k0vlzMP7TVNg5Oz1j0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsETvJAPxoGYsb+SGcE+B70gYejNl6vZ8/cKZ72hQItyaGN87wbBB0NsqNXECVQKFXDy3ql3iPq75LcMWenRPbTkfMvH1NnkOmokIfcnPKo/Ca+99neRxmp/x7xVSAHVb0c8aN0byDHOIxYVnfnkf6bucUClBcQ5y5fGnzwszwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OK6FDq9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059D3C43390;
	Fri, 16 Feb 2024 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708091904;
	bh=CB4g2cCQgiWIC67i2T4tPOsa8k0vlzMP7TVNg5Oz1j0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OK6FDq9MAY2HkAu8eJYLHeP1oEYKKgwKmwlZtUdkddD5wg3cTXrlDcJ7Vc5NknZkL
	 0WNZbEyZORYkCs15IgQz0jJtCsevneOIyksZzepmPHoA1MUo3XafKc9RmWAL/ORHJJ
	 qBoUfRJF3/iyO+hpqSEcJ4STBX6RFDCeGtdzBsVW5rCNQbbufyepzcG4BbiWNfj1TC
	 WV8lYFOy02aHz7IsofjHhYfs/8+6LHLDvYw4YavFgcr0MnnUWwzzRofcGUsHRsXt8Q
	 sih2MhPmf/LtBnYITHTWTGIIt3RESfARRtWd0mDGqq66oB9aCdaMMJikhTO/PWhtq/
	 W/c89UIesdFcw==
Date: Fri, 16 Feb 2024 13:58:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-kernel@vger.kernel.org, David Laight
 <David.Laight@aculab.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 linux-iio@vger.kernel.org
Subject: Re: [RESEND PATCH v2] iio: gts-helper: Fix division loop
Message-ID: <20240216135812.07c9b769@jic23-huawei>
In-Reply-To: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
References: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 13:20:09 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The loop based 64bit division may run for a long time when dividend is a
> lot bigger than the divider. Replace the division loop by the
> div64_u64() which implementation may be significantly faster.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> 
> ---
> This is a resend. Only change is the base which is now the v6.8-rc4 and
> not the v6.8-rc1
Given I'm not rushing this in, it is going via my togreg tree, so the
rebase wasn't really helpful (thankfully didn't stop it applying).
Would have been fine to send a ping response to the first posting of it.

I was leaving some time for David or Subhajit to have time to take
another look, but guess they are either happy with this or busy.

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Jonathan

> 
> This change was earlier applied and reverted as it confusingly lacked of
> the removal of the overflow check (which is only needed when we do
> looping "while (full > scale * (u64)tmp)". As this loop got removed, the
> check got also obsolete and leaving it to the code caused some
> confusion.
> 
> So, I marked this as a v2, where v1 is the reverted change discussed
> here:
> https://lore.kernel.org/linux-iio/ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi/
> 
> Revision history:
> v1 => v2:
>  - Drop the obsolete overflow check
>  - Rebased on top of the v6.8-rc4
> 
> iio: gts: loop fix fix
> ---
>  drivers/iio/industrialio-gts-helper.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 7653261d2dc2..b51eb6cb766f 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -34,24 +34,11 @@
>  static int iio_gts_get_gain(const u64 max, const u64 scale)
>  {
>  	u64 full = max;
> -	int tmp = 1;
>  
>  	if (scale > full || !scale)
>  		return -EINVAL;
>  
> -	if (U64_MAX - full < scale) {
> -		/* Risk of overflow */
> -		if (full - scale < scale)
> -			return 1;
> -
> -		full -= scale;
> -		tmp++;
> -	}
> -
> -	while (full > scale * (u64)tmp)
> -		tmp++;
> -
> -	return tmp;
> +	return div64_u64(full, scale);
>  }
>  
>  /**
> 
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de


