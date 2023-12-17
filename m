Return-Path: <linux-kernel+bounces-2652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F6A815FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CA41F216D4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065A44398;
	Sun, 17 Dec 2023 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L61K4gga"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F612FE2E;
	Sun, 17 Dec 2023 14:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EDAC433C7;
	Sun, 17 Dec 2023 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702824356;
	bh=kVuXjANOUieH9LrXbZoogYCG3uzkAL+/ag6djbg25Og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L61K4ggaBYJDjrStvfKdJFi1QM0XjOPUHNMECn+3mLPV527Iv0+Ex2jO4zHYaRvOE
	 VKelZxqO8ycWZvgcyzEluwDE5VvpsDWbcz/7k8YVbIm7x+wMpS55oFFHXbhwpMbwye
	 B4bLSrqCOpqW1+PewwqwYbUh/g8Jmyd4ywY74hFowqMFOLXTzwlL78BXwb9gs77MII
	 3otY2EC/oaNp+4IRV7rl6aCo989eyf0UD2tteDfVxNptTJzNxKw95Idn7plbDVjNlG
	 QNWOeUe1rQuryOU7v1SRDmEWs5RY9AIf76/W4foZ6UAm7TooEHAGOlt2X9zG+ejf8K
	 7EiO4NODTWMYg==
Date: Sun, 17 Dec 2023 14:45:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v5 3/3] iio: chemical: add support for Aosong AGS02MA
Message-ID: <20231217144542.0794bd0e@jic23-huawei>
In-Reply-To: <20231215162312.143568-3-anshulusr@gmail.com>
References: <20231215162312.143568-1-anshulusr@gmail.com>
	<20231215162312.143568-3-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 21:53:11 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

> A simple driver for the TVOC (Total Volatile Organic Compounds)
> sensor from Aosong: AGS02MA
> 
> Steps in reading the VOC sensor value over i2c:
>   1. Read 5 bytes from the register `AGS02MA_TVOC_READ_REG` [0x00]
>   2. The first 4 bytes are taken as the big endian sensor data with final
>      byte being the CRC
>   3. The CRC is verified and the value is returned over an
>      `IIO_CHAN_INFO_RAW` channel as percents
> 
> Tested on Raspberry Pi Zero 2W
> 
> Datasheet: https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

Hi Anshul, Just one trivial thing. I'll fix up whilst applying.

Applied to the togreg branch of iio.git. Will be initially pushed out as testing
for 0-day to see if it can find anything we missed.

Thanks,

Jonathan

> +
> +static const struct iio_info ags02ma_info = {
> +	.read_raw = ags02ma_read_raw,
> +};
> +
> +static const struct iio_chan_spec ags02ma_channel = {
> +	.type = IIO_CONCENTRATION,
> +	.channel2 = IIO_MOD_VOC,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)

Comma after this line. I'll fix up if there isn't much else.
The reason for this is that it is very plausible we'll add more to this
channel description in the future and the absence of the comma would make that
messier.


> +};


