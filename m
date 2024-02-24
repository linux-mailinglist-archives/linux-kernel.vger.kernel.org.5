Return-Path: <linux-kernel+bounces-79778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6A86268C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510E91C20EB8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E12D482ED;
	Sat, 24 Feb 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCcrhlsH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064E1E497;
	Sat, 24 Feb 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797679; cv=none; b=QMnbeVo1i58sLogho2FR6P1cGZs4nB2JMa+ajUuwkc4CBr/UxmYBjejvcTCGXK4e0Fw78ql7rrVr5xl4yC/CT0hoAQT7eRD6yL/4sd5fTJMfjZwy/gowsS0RD9nBk+JV+pkVq9YXYdq141nLLSk5Ii3mq0DKYi7VcA/TJ6b0sSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797679; c=relaxed/simple;
	bh=udt29uG8DZdVdCXOm1/tLL2iD2xGRx1dlaQjSixcwp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ithCmKGDCVPQABKbUick3Ns6EwHsSI4FpJIYMSoBkm1CedkXLtesyk2Zvda6hGp+3CUil5tNVw9QFY1rTuy3BjZN8gaxw/36++i5fGMsvr6nQvkitcTHd1Ks8bbxuPlnoyVWXYfvcBQJf51Gae3iAXZd6qaTAKf05b9elju1HbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCcrhlsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75FCC433F1;
	Sat, 24 Feb 2024 18:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708797678;
	bh=udt29uG8DZdVdCXOm1/tLL2iD2xGRx1dlaQjSixcwp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NCcrhlsHBDAcvTYepFo+mmNATX7nQpLQMMrMgArKlcgWN1rsDI78AidqtiGBk6frl
	 SM35JHQSwIlW5WFKts0FYXYzSrZYaqHCqo2SAu+su6/NlinldPVXZ+CxcwMXTetceL
	 ghefknXJJBDA5uIvfULn3TIjBZni2LCkErWSwWF318FV342l94aVoQtrl6DCHj1V5X
	 /lplR+HtYS1h0VJM+ILDIxrAAOX6dSOqou9mFelA+LLR7yw6xqhEpUN6nhmSZNjnzz
	 LlMsp2P7ZTRNr86FwjhQ7SCLZmB1n2O2wmMtleM+m5j2l9EozdR7mGtnN8xiTHjauu
	 MdTlVsbVKmNzQ==
Date: Sat, 24 Feb 2024 18:01:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <20240224180103.3e522481@jic23-huawei>
In-Reply-To: <ZdX45xqSlz1oQQ-R@smile.fi.intel.com>
References: <20240220224329.53729-1-vassilisamir@gmail.com>
	<20240220224329.53729-2-vassilisamir@gmail.com>
	<ZdX45xqSlz1oQQ-R@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 15:21:43 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Feb 20, 2024 at 11:43:29PM +0100, Vasileios Amoiridis wrote:
> > According to the datasheet of BMP38x and BMP390 devices, for an SPI
> > read operation the first byte that is returned needs to be dropped,
> > and the rest of the bytes are the actual data returned from the
> > sensor.  
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> (If you got tags in the previous rounds of review, it's your responsibility
>  to carry them, in case code is not _drastically_ changed.)
> 

Version numbers! Otherwise poor maintainers like me have no
idea which one to pick up.

Anyhow, I got the much earlier one so will ignore newer versions.

