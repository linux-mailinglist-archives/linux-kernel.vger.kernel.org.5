Return-Path: <linux-kernel+bounces-68775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2A9857FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EE11C23A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39AA12F388;
	Fri, 16 Feb 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7UfS5hW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65D912F377;
	Fri, 16 Feb 2024 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095636; cv=none; b=WSnKbv02/hYDPJypUOn90JUtOZ1dBpJjBih9OO7g38+G/lhwEMYGznkZEs4xdmmhdCz6MdqRqse+4Qi8CON+PmcT2vdGYDwxgfPzojZu1Xd3di4/Zi8BzOY3AoNHy+l9QXZpaXn/TrxVSX5vtyCSgcdFsS78ahimBQdxg/PDQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095636; c=relaxed/simple;
	bh=SlsPKpnC/Bj0Ge4xbcBdLPan6kK3Dz/4j4gB5D2L1VU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJLPXRKHJppiqP3jzddhxf6OiHfPHJfNZ/56C/os0xfVMNJmbymhug0wxnOb4qYkpBrWOrZdy5nTphmlfQ9EAYiNaM9kbXAQFfaWz9u+yPgscunRRY96fkc6RBS0NAcHWi/quDA7ondmJHDZmPGpUbk2QVU4hvgqhP7Za4sUwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7UfS5hW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E34C433C7;
	Fri, 16 Feb 2024 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708095636;
	bh=SlsPKpnC/Bj0Ge4xbcBdLPan6kK3Dz/4j4gB5D2L1VU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D7UfS5hWvGrV0c6HztB7bftM4x+YCOGfe5XNHzdaBtCU5NHG7ikVTCROH0Ro2x6Fk
	 aymugkNxgqOhjTDC8Q4mDsS4Urx1OqBt++KzVAkiiTbD3+Y9rrX6q/fdisgHK8rYiU
	 gv29Tp86xePMnEvOq09zB3sw7nShc9yhyo+tNNuWH05m+gdlyoh6wIXiAGRg75FuaS
	 yMtrhPcN+iZVKApW6SEoe6n9ZrFoeQHcYk69gcM9H7a9Bb+feOVszxs2wkLSgXGdjf
	 SOtcjbeL6Nd495I9YY2XsR3K71f/GIKJldp47nUPJ5gYtvFCV2lPUPeXSidzx2MHZM
	 XjrPt+mQ3Rpbw==
Date: Fri, 16 Feb 2024 15:00:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 0/6] iio: pressure: hsc030pa: cleanup and triggered
 buffer
Message-ID: <20240216150025.6c718307@jic23-huawei>
In-Reply-To: <20240211075645.28777-1-petre.rodan@subdimension.ro>
References: <20240211075645.28777-1-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 09:56:31 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> This set of patches covers the following:
> 
>  - small cleanup
>  - mandatory 2ms delay between readings
>  - support for triggered buffer readings

Hi Petre

Applied to the togreg branch of iio.git but that will initially be pushed
out as testing for 0-day to take a look at it.

Thanks,

Jonathan

> 
> The support for devices that have "sleep mode" factory option that was
> present in v1 of this patchset was removed, for a few reasons:
> 
>  - a Honeywell employee told me that this chip variant is extremely
>     unlikely to be found in the wild, which also makes testing the
>     driver functionality impossible
>  - I found no reliable way of generating i2c/spi bus traffic with no
>     payload (toggle CS for SPI case, send i2c packet containing only
>     the address byte) that are required for the wakeup sequence.

> 
> Petre Rodan (6):
>   dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
>   iio: pressure: hsc030pa: use signed type to hold div_64() result
>   iio: pressure: hsc030pa: include cleanup
>   iio: pressure: hsc030pa: update datasheet URLs
>   iio: pressure: hsc030pa add mandatory delay
>   iio: pressure: hsc030pa add triggered buffer
> 
>  .../iio/pressure/honeywell,hsc030pa.yaml      |  3 ++
>  drivers/iio/pressure/Kconfig                  |  2 +
>  drivers/iio/pressure/hsc030pa.c               | 49 ++++++++++++++++++-
>  drivers/iio/pressure/hsc030pa.h               |  7 +++
>  drivers/iio/pressure/hsc030pa_i2c.c           |  9 +++-
>  drivers/iio/pressure/hsc030pa_spi.c           |  7 ++-
>  6 files changed, 73 insertions(+), 4 deletions(-)
> 


