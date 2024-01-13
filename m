Return-Path: <linux-kernel+bounces-25331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C044982CDAF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59390284118
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C313E3D63;
	Sat, 13 Jan 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4I8vf2C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122EF4A23;
	Sat, 13 Jan 2024 16:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E502AC433F1;
	Sat, 13 Jan 2024 16:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705162449;
	bh=ov4r1pQnCWGD4LZgwtdWh6NQsa71tmBhiJJ4tREobgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g4I8vf2CTbAdtMRpUFjQQ6vuicVXlfJhDTbvoJfaSEZu4B8RpKY7fvu5mYjmHx2gy
	 OizC5XgkuvR3/UVktGrwVMPTm/RwlcXYyF6l5MmI7wM664xrUnhAs8ai/UxRJSMinM
	 1hu9T9zUb2p3byQhB7JM5pPgfISob3667hsLezD9kbq8qqGdJVuVNVTzQ7ejB5zt/y
	 e+UBj93iORkyUMGZNxMbuTCugYhu3YC/MNAgU+N3X2MWDXU1sBQFiY/Abm7Xecpyq2
	 RAWP0s+kyzpSRaP6osnVt74Ndp15d+seaT3qpB04jknr0TdoEJUdlSESrVgWgTmLo2
	 qrj0rHlov2W1Q==
Date: Sat, 13 Jan 2024 16:14:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-kernel@vger.kernel.org, Stefan Popa
 <stefan.popa@analog.com>
Subject: Re: [PATCH v4 0/2] iio: adc: add new ad7380 driver
Message-ID: <20240113161403.4654db9d@jic23-huawei>
In-Reply-To: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com>
References: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 14:28:39 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This series is adding a new driver for the Analog Devices Inc. AD7380,
> AD7381, AD7383, and AD7384 ADCs. These chips are part of a family of
> simultaneous sampling SAR ADCs.
> 
> One quirk of these chips is that since they are simultaneous sampling,
> they have multiple SPI data output lines that allow transferring two
> data words (one for each input channel) at the same time. So a new
> generic devicetree binding is added to describe this sort of SPI bus
> configuration.
> 
> To keep things simple, the initial driver implementation only supports
> the 2-channel differential chips listed above. There are also 4-channel
> differential chips and 4-channel single-ended chips in the family that
> can be added later.
> 
> Furthermore, the driver is just implementing basic support for capturing
> data. Additional features like interrupts, CRC, etc. can be added later.
> 
> Also, FYI, this driver will also be used as the base for an upcoming
> series adding AXI SPI Engine offload support for these chips along with
> [1].
> 
> This work is being done by BayLibre and on behalf of Analog Devices Inc.
> hence the maintainers are @analog.com.
> 
> [1]: https://lore.kernel.org/linux-spi/20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com/
Series applied to the togreg branch of iio.git though that is only pushed
out as testing for now as I'll be rebasing it on rc1 once available.

Jonathan

