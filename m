Return-Path: <linux-kernel+bounces-112674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49E887CD0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC431C20A87
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E417BCE;
	Sun, 24 Mar 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd+9Qsgi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B831A38EA;
	Sun, 24 Mar 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711285693; cv=none; b=lCzUkIx/wiWEkL7E4pinbMxZg9vszK3+AaNgTaYIvPoUfyQh4oTb/Ne1CwWlx+RJ1MNLWhCwqjpnMChwsIhDN9gKrgD/Pu7wGzgntugXT59u+3Zq+6HzctRwCXp0Xzty1pXOH6CcOeTVcutZt5BlOoJLgQtnXkHhricQbMhkh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711285693; c=relaxed/simple;
	bh=nfUcghzizgYYm6MDQuZDNwGKaMDBsPTJ7jiCL02Z46c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4OAKdCVzUhKnhQNi3NbxcPAQesUdBky7GZKpxB3sHuMrCw+B9g+YFW5alikIIOY4lWzsW/zEUvrzwEOcLwAjpml4zOUGHVp8qvAuaA2mVY/sOpHxm+aqxOlVnkjx6XgfIfQwJjbbrQr29BEobr7a8tXde0mnUgx0MMwPozQKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd+9Qsgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C19EC433F1;
	Sun, 24 Mar 2024 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711285692;
	bh=nfUcghzizgYYm6MDQuZDNwGKaMDBsPTJ7jiCL02Z46c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rd+9QsgiBv0WXLpZ/y8rOCqMF9QKq6oaUP/fcSzeBZjl1hY10NH9dgntlx9jnLJ6g
	 VDK+zzgOPj2PMd/r8UsS3zIqWNLIuykEU45kPkvQ5suVVKBzAlTnTqzCTc/zTPeOUj
	 qtVivZZhJpm+t2YldwO9+jSE8dqI6Py2NqueRiUAEDb/B9cPiSLvXoaRdZbqwQu/J3
	 8/kclF/NaQRKAqzEdQ7OTxA4A/ZECyEGQyH5o58pW9C+e/3iu1h+3chYF6SUJjo/sv
	 6ZLG2ab2KPxVlVCqwhF1EQ1mXNO6CPkT1ANu2JItxtqR5cPBB1DCNX0e/wRPDo2pne
	 aFcU5M3iRYPpw==
Date: Sun, 24 Mar 2024 13:07:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v5 5/7] iio: adc: ad7380: prepare for parts with more
 channels
Message-ID: <20240324130756.598a4b36@jic23-huawei>
In-Reply-To: <20240319-adding-new-ad738x-driver-v5-5-ce7df004ceb3@baylibre.com>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
	<20240319-adding-new-ad738x-driver-v5-5-ce7df004ceb3@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 11:11:26 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> The current driver supports only parts with 2 channels.
> In order to prepare the support of new compatible ADCs with more
> channels, this commit:
>   - defines MAX_NUM_CHANNEL to specify the maximum number of
>     channels currently supported by the driver
>   - adds available_scan_mask member in ad7380_chip_info structure
>   - fixes spi xfer struct len depending on number of channels
>   - fixes scan_data.raw buffer size to handle more channels
>   - adds a timing specifications structure in ad7380_chip_info structure
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

>  struct ad7380_state {
> @@ -148,15 +168,15 @@ struct ad7380_state {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
>  	unsigned int vref_mv;
> -	unsigned int vcm_mv[2];
> +	unsigned int vcm_mv[MAX_NUM_CHANNELS];
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> -	 * Make the buffer large enough for 2 16-bit samples and one 64-bit
> +	 * Make the buffer large enough for MAX_NUM_CHANNELS 16-bit samples and one 64-bit
>  	 * aligned 64 bit timestamp.
>  	 */
>  	struct {
> -		u16 raw[2];
> +		u16 raw[MAX_NUM_CHANNELS];

This can get problematic for drivers supporting devices with varying numbers of channels.
You are fine up to 4 channels as the structure layout isn't changing.  The reason is that
it implies the timestamp location, which if you were for instance to support 8 channels
would be incorrect if only 4 of them were enabled.
Now the timestamp location is only used implicitly in the driver (as the IIO core
handles the actual insertion of the data) so it's not a bug as such to do this, but it
can give people the wrong impression during testing etc.

As such, I'd like to see the comment mention that "as MAX_NUM_CHANNELS is 4
the layout of the structure is the same for all parts".

Note I've reviewed one driver today that did have different layouts depending on
which device was in use and ended up falsely indicating the timestamp was later
than it actually was in the buffer.  Hence my request for a defensive comment!

>  
>  		s64 ts __aligned(8);
>  	} scan_data __aligned(IIO_DMA_MINALIGN);



