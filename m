Return-Path: <linux-kernel+bounces-163002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17BC8B6338
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137B4B2173D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5614535E;
	Mon, 29 Apr 2024 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2Eu+bDc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A21442FD;
	Mon, 29 Apr 2024 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421220; cv=none; b=JHZyneKZbcosxBtYHIs679lL9Vnbu30aatlB0Nb8RQu6RUijHUtefB4BpnE8Z9w3TMC5NMc+BQg2KiihCuIyVklDkAZePUcVa+b04/TCGh4DVOfvddjO2mc30TO6nZ0i1/DC13ToOu8SfkjBDSSLiqr2BtxkkIlSd1s1tZdxTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421220; c=relaxed/simple;
	bh=4A88CtFhO9g0Vm1pMTxYoO6IBnLwMZJMkAtxvaB8yTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PD//LsOY5mZSEnj7mhp8kSd5Z2dfL2ZruNetOb9eE8NvqJOcPEg3bkIqzx/zuUfgPdpIEIFUWDZfEPu+uKEIxe9p7MN08LgDDfPxaF/OQ8pwnGJXfGZSJz/Pr9YDRIMMvJjge7dPhVY9bJVsyflDSMo+7IWQblxJyHwYw/D+N/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2Eu+bDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C298EC4AF14;
	Mon, 29 Apr 2024 20:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714421219;
	bh=4A88CtFhO9g0Vm1pMTxYoO6IBnLwMZJMkAtxvaB8yTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d2Eu+bDcB2VBGxzdNS8FaG+wTdSF6EoPn0gvxQjza1D737089iPlbg0X3lOuJ7qth
	 yva0Bwg83ykirUtT774C38MB8baxZTN7nAsmiaI4FJKiv2i9/gmHixZUCEOw9MeQ1h
	 zg6AbK4mBXTHZT+4Cvu/os75HZWacf7PReftRCBMhYTrKwp2XbiaubHfGdTuvfZ5rg
	 BONtufjopg6ZlMGGhKRZppD2XFeHXoXqHwen53ezbgea/Cg+w9UpW2hDxgRMTqxJC+
	 07vhFpg9Xe221vL8ol/WQGRNXarUta0VmHYfVOgReolABJxkH5ps5kZNfzH3AFlg8w
	 9NFnqEt6HKlLQ==
Date: Mon, 29 Apr 2024 21:06:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-iio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/8] iio: use 'time_left' instead of 'timeout' with
 wait_for_*() functions
Message-ID: <20240429210648.4b429d31@jic23-huawei>
In-Reply-To: <20240429113313.68359-1-wsa+renesas@sang-engineering.com>
References: <20240429113313.68359-1-wsa+renesas@sang-engineering.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 13:33:03 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_*() functions causing patterns like:
> 
>         timeout = wait_for_completion_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> obvious and self explaining.
> 
> This is part of a tree-wide series. The rest of the patches can be found here
> (some parts may still be WIP):
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/time_left
> 
> Because these patches are generated, I audit them before sending. This is why I
> will send series step by step. Build bot is happy with these patches, though.
> No functional changes intended.

Nice improvement.  Applied

> 
> Wolfram Sang (8):
>   iio: adc: ad_sigma_delta: use 'time_left' variable with
>     wait_for_completion_timeout()
>   iio: adc: exynos_adc: use 'time_left' variable with
>     wait_for_completion_timeout()
>   iio: adc: fsl-imx25-gcq: use 'time_left' variable with
>     wait_for_completion_interruptible_timeout()
>   iio: adc: intel_mrfld_adc: use 'time_left' variable with
>     wait_for_completion_interruptible_timeout()
>   iio: adc: stm32-adc: use 'time_left' variable with
>     wait_for_completion_interruptible_timeout()
>   iio: adc: stm32-dfsdm-adc: use 'time_left' variable with
>     wait_for_completion_interruptible_timeout()
>   iio: adc: twl6030-gpadc: use 'time_left' variable with
>     wait_for_completion_interruptible_timeout()
>   iio: pressure: zpa2326: use 'time_left' variable with
>     wait_for_completion_interruptible_timeout()
> 
>  drivers/iio/adc/ad_sigma_delta.c  |  6 +++---
>  drivers/iio/adc/exynos_adc.c      | 16 ++++++++--------
>  drivers/iio/adc/fsl-imx25-gcq.c   | 10 +++++-----
>  drivers/iio/adc/intel_mrfld_adc.c | 12 ++++++------
>  drivers/iio/adc/stm32-adc.c       | 10 +++++-----
>  drivers/iio/adc/stm32-dfsdm-adc.c | 12 ++++++------
>  drivers/iio/adc/twl6030-gpadc.c   |  8 ++++----
>  drivers/iio/pressure/zpa2326.c    | 10 +++++-----
>  8 files changed, 42 insertions(+), 42 deletions(-)
> 


