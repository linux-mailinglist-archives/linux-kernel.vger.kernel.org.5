Return-Path: <linux-kernel+bounces-79751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52B3862639
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9882B2832B6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740EA46544;
	Sat, 24 Feb 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQOms0S5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108F137E;
	Sat, 24 Feb 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708794164; cv=none; b=B9nlNEbcBzpK5/SUGkhc/UOhvpyxAsGUGeugU40xadhBcCx2BZSGjhXAkZGeapDC/ZWHnfpiD12wNu+XRWRbaQjfU4+i2uXQmtO8SytvGmYUxkrSUG0R72hGcRkaBhFapMw8TbGK9UMpVz24Ds6rXoU+IN52MVT5tV6d49QBXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708794164; c=relaxed/simple;
	bh=Rtj/JgUe0ZgjPqgZ3KPLXjUDHRaTYhlr9OcLC/lvnuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUcS2CHz201yDTKAaKQ/ooDif+w0ETV3c+m/q+pObRSuBCaPWfIpZNIufU9/kx/84CKDKy4mriLYyFNNy/ivpWJp54XcO+Eu8csGlawhHoIsEC0fyNOkJrSVztq0DBce6/LEbNeFojLWE/H9Mx2/YLZg28A52+p5zQ9bVpSGxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQOms0S5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CBFC433C7;
	Sat, 24 Feb 2024 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708794164;
	bh=Rtj/JgUe0ZgjPqgZ3KPLXjUDHRaTYhlr9OcLC/lvnuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TQOms0S5Yw/dWZmvtSpByX6E8sActTkdEb7pXIRHJQB/eVdouySNlLg41R6tsTQmo
	 CJuNnzk75iRq2ZiaRYbThXwjwKODhpJM4lkn9CnG/whcCJsUL/sTp/AZ3IVEwfzPG+
	 Eeq0j/vLz4wmx352vLM/QP/zZZKmpIVYbjhjkjrQdRLWuGGMGmJ3R9tqT+8i7qhCA5
	 PsliHlbvy6exUsi+7+0S3H66AxsdxZcGQAtZRtwYR+Q/HYURxP3ttVtdxOQDdBV5Wo
	 EeFh1ZyR9+VWbWaiXS+xsMC2nDoBM916p7x6uYlsMR9iQACe08/61Rs3OxtripWoj9
	 ApZ4tPaJ+FGBA==
Date: Sat, 24 Feb 2024 17:02:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Ceclan Dumitru <mitrutzceclan@gmail.com>, linus.walleij@linaro.org,
 brgl@bgdev.pl, linux-gpio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, Ceclan
 Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 2/3] iio: adc: ad_sigma_delta: Add optional irq
 selection
Message-ID: <20240224170225.4720f9a2@jic23-huawei>
In-Reply-To: <ZdS0kOKTWHlisuyn@smile.fi.intel.com>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
	<20240220094344.17556-2-mitrutzceclan@gmail.com>
	<ZdSzCe2cw8gL3K-W@smile.fi.intel.com>
	<001d1e99-5d96-44f3-8695-ad2ecee42128@gmail.com>
	<ZdS0kOKTWHlisuyn@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 16:17:52 +0200
Andy Shevchenko <andy@kernel.org> wrote:

> On Tue, Feb 20, 2024 at 04:13:12PM +0200, Ceclan Dumitru wrote:
> > On 2/20/24 16:11, Andy Shevchenko wrote:  
> > > On Tue, Feb 20, 2024 at 11:43:39AM +0200, Dumitru Ceclan wrote:  
> 
> ...
> 
> > >> +	if (!info->irq_num)
> > >> +		sigma_delta->irq_num = spi->irq;
> > >> +	else
> > >> +		sigma_delta->irq_num = info->irq_num;  
> > > 
> > > Why not positive check?
> > >   
> > Considered that selecting spi->irq is usually the default case, so it should
> > be the first branch  
> 
> Let compiler do its job, the negative conditions are harder to read/parse by
> human beings.
> 
FWIW compiler almost certainly won't figure this out as it has nothing to go on
- history based branch prediction in processors will though!  We don't want to
be hinting direction to the compiler for a case like this as that will make
it very painful if we get it wrong.  Anyhow Andy's comment is valid even if
I disagree with the reason.

Jonathan

