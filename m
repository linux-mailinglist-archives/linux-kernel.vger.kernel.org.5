Return-Path: <linux-kernel+bounces-8793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B48781BC65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7001F22997
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FFE5822F;
	Thu, 21 Dec 2023 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezcv0/ff"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51236084;
	Thu, 21 Dec 2023 16:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE65C433C7;
	Thu, 21 Dec 2023 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703177619;
	bh=YEHi60Chmb/Do0a76SjVzKGF69FvK2G5bimg0PfKPek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ezcv0/ff0i7eAr3JbjaRWYy0DnUJgupriW1a/CfeCtGxmKQ+0ylh9UWakpoc/9xZU
	 Uxhr6R09oTlPAzbPr9GUX+f/SBLeQ/3LuRJEXdb1ajhUdWvSEo29kQ29nftL5UwMXV
	 IDeGid0R40fCdOy55DEN9QX4PzIylC59vP1zM13GAdIlST37K+/woCCkS90vBaENNs
	 3AV7XDthlSoTMq3H735/+XmdQQsFgcSYzmxn1M+X7SEKC4X1WLjnDvVWhY2RTsn59X
	 UG8EdLSQZjXXVmfzxcC/44oivEhl87eWg+tn1VPcyto0dqHSLHZd2A4khY55pPx+we
	 iL1l0Rq1IG5QA==
Date: Thu, 21 Dec 2023 16:53:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
 <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <dan.carpenter@linaro.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/11] Add support for AD7091R-2/-4/-8
Message-ID: <20231221165322.1d6ecfdc@jic23-huawei>
In-Reply-To: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
References: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 17:25:04 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> ----------------- Updates -----------------
> 
> Applied all suggestions. 
> Only submitting patches not applied on v4:
> Patches after ("Align arguments to function call parenthesis").
> 
> Change log v4 -> v5:
> - Patch 1: Event callbacks
>   * Moved to begin of the series to easy backport;
>   * Reverted to original event attributes;
>   * Reworked event configuration to do per direction per channel enable/disable;
>   * Improved commit message;
>   * Added fixes tag;
>   * Added Suggested-by tag.
> - Patch 2: Enable internal vref
>   * Added fixes tag and improved commit message;
>   * Now earlier in the series to easy backport;
>   * Used regmap_set_bits() to make code more neat.
> - Patch 3: Move generic AD7091R code
>   * event specs moved earlier in patch 1.
> - Patch 4: Move chip init data
>   * Renamed field to make initialization clearer: irq_info -> info_irq.
>   * Fixed ad7091r_init_info initialization by passing pointers to info structs;
> - Patch 10: Add ad7091r8 support
>   * Moved bitfield.h include to patch event callbacks patch;
>   * Dropped GPIO consumer include on ad7091r-base.h and added gpio_desc;
>   * Removed extra space before devm_gpiod_get_optional().
> 
> So, since we are already fixing a few things here, maybe it's a good time to
> comment about the event ABI.
> I see the event config files under events directory appearing as
> in_voltage0_thresh_falling_value
> in_voltage0_thresh_rising_value
> in_voltage1_thresh_falling_value
> and so on.
> They don't have the `_raw` part of the name as documented in the IIO ABI [1].
> Not sure if that is how it's intended to be, the driver is still missing
> something, or maybe ABI is somehow outdated.

I think the docs have always been wrong :(
We always derived if these were raw or processed from matching channels (they
are almost always raw because non linear mess in typically processed channels
is hard to invert in order to program a register etc)

> Anyway, if that is also something to be fixed then let me know I'll have a look
> at it.

Great - just drop the _raw bit from the event documentation. I see it's a mixed bag
with some channel types correctly not including it whilst others do :(

Not sure why we've not picked up on that in reviews in the past.

Jonathan

> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio#n887
> 
> Thanks,
> Marcelo
> 
> ----------------- Context -----------------
> 
> This series adds support for AD7091R-2/-4/-8 ADCs which can do single shot
> or sequenced readings. Threshold events are also supported.
> Overall, AD7091R-2/-4/-8 are very similar to AD7091R-5 except they use SPI interface.
> 
> Changes have been tested with raspberrypi and eval board on raspberrypi kernel
> 6.7-rc3 from raspberrypi fork.
> Link: https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad7091r8
> 
> 
> Marcelo Schmitt (11):
>   iio: adc: ad7091r: Allow users to configure device events
>   iio: adc: ad7091r: Enable internal vref if external vref is not
>     supplied
>   iio: adc: ad7091r: Move generic AD7091R code to base driver and header
>     file
>   iio: adc: ad7091r: Move chip init data to container struct
>   iio: adc: ad7091r: Remove unneeded probe parameters
>   iio: adc: ad7091r: Set device mode through chip_info callback
>   iio: adc: ad7091r: Add chip_info callback to get conversion result
>     channel
>   iio: adc: Split AD7091R-5 config symbol
>   dt-bindings: iio: Add AD7091R-8
>   iio: adc: Add support for AD7091R-8
>   MAINTAINERS: Add MAINTAINERS entry for AD7091R
> 
>  .../bindings/iio/adc/adi,ad7091r5.yaml        |  82 +++++-
>  MAINTAINERS                                   |   8 +
>  drivers/iio/adc/Kconfig                       |  16 ++
>  drivers/iio/adc/Makefile                      |   4 +-
>  drivers/iio/adc/ad7091r-base.c                | 269 +++++++++++------
>  drivers/iio/adc/ad7091r-base.h                |  83 +++++-
>  drivers/iio/adc/ad7091r5.c                    | 120 ++++----
>  drivers/iio/adc/ad7091r8.c                    | 272 ++++++++++++++++++
>  8 files changed, 714 insertions(+), 140 deletions(-)
>  create mode 100644 drivers/iio/adc/ad7091r8.c
> 


