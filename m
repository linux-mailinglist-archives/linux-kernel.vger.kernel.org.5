Return-Path: <linux-kernel+bounces-105200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778ED87DA71
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00582B212BF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA271B27D;
	Sat, 16 Mar 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwx1fHHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171942F4A;
	Sat, 16 Mar 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710598593; cv=none; b=djwiGWfGzimpUx52r01YeIfBl24ifOkfKQlPH3CeydcUb86rZNXI57ZmeL1lbdKyuOzigNFMpV8laHQ+cChTTA0e2F41n4CAmxFTaPq9xoIApzuWZrpZzew8UAuCPjkWpfRSC/UeUvGtxY4jwx1WlC8ancL25qrlgf8ykQEKJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710598593; c=relaxed/simple;
	bh=naXuoI17Y6Hsp+2BqV52JndqlRKvCPPqIncmKWKYebI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6K+IcDp0pFFLot3ZjWiGSy3hQpsQw9cI+ddViPwlE3Id1QIcgmdj8/JjGav4b0DfFk6ercykcZyQHFDnU+J/SQYtVnqQ/qqvR2Z3HnC1N6OuNs7/oanXvdtGhJADOZ/azA6RjkWIvbzFTGvwdZjGAKcAb8LoQtWEFxOrFrz4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwx1fHHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117D4C433F1;
	Sat, 16 Mar 2024 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710598592;
	bh=naXuoI17Y6Hsp+2BqV52JndqlRKvCPPqIncmKWKYebI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cwx1fHHgQGBy+XGQ4nEdVMIttyjZwryjNFDjqQtPEfd/7jAdnLmqiUgI2DRVE9t3y
	 oj7xpvp7rH3JDFhuuQ+ihEacRxe4a8kdR/E/QE9J9v9Y1UH0iQm5raBoCS7KEBkoRC
	 dfDxKXP3l0tKXr74lSRitmiPxOFL6hGS6nQAiAF/eUfdwFzIzflrv79YLMV3baykAu
	 x0pb5z4BtwvLNYVRdLbV25W584pZAdBsLq5HY7+1hHgJz3dewqqV6VgyuFcj04k/wC
	 smLFmP+XG5+3w00p2FzOVsALEj1TmpUv+a2Ly8j4LyB3YHChuxEcG3M2eaxfOtkRCe
	 rbtBBIFUtGEtg==
Date: Sat, 16 Mar 2024 14:16:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org, phil@raspberrypi.com,
 579lpy@gmail.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: pressure: Fixes in SPI support of BMP280
 driver
Message-ID: <20240316141616.115b4b24@jic23-huawei>
In-Reply-To: <20240316110743.1998400-1-vassilisamir@gmail.com>
References: <20240316110743.1998400-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Mar 2024 12:07:41 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> PATCH 1/2: Fix BME280 SPI driver data structures as it was assigned
> to the struct for the BMP280 and not the BME280.
> 
> PATCH 2/2: Fix identification of BMP3xx devices in order to use
> different SPI regmap.
> 
> [1]: https://lore.kernel.org/linux-iio/20240311005432.1752853-1-vassilisamir@gmail.com/

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> Vasileios Amoiridis (2):
>   iio: pressure: Fix BME280 SPI driver data
>   iio: pressure: Fixes SPI support for BMP3xx devices
> 
>  drivers/iio/pressure/bmp280-core.c |  1 +
>  drivers/iio/pressure/bmp280-spi.c  | 13 ++++---------
>  drivers/iio/pressure/bmp280.h      |  1 +
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 


