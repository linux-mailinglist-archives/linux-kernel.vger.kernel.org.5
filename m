Return-Path: <linux-kernel+bounces-7082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46AA81A16D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619412860FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E33D973;
	Wed, 20 Dec 2023 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxWsQQdj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517B3D966;
	Wed, 20 Dec 2023 14:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F5FC433C8;
	Wed, 20 Dec 2023 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703083744;
	bh=Zpqr2IduaIi/eJ/LAgUU9AcGnT1pYkcj9gSp3Y9liBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cxWsQQdjxVAgGtLFajkjfRxEgGKU0IxwFKluuoVH+lIwLTGobBcQSdLuaxKRJQJYr
	 tPXBZMkWos12ATD7kurnjiawElKvVNjngtlOkI9qF68mVExoym4AKyDstMSbaEJq9A
	 sSQ1mcLeiaqJgJg801kSvb5adToVQtt9sAJMssLXzR+mYZ4aFXe5WQnSZt/vF6Y6/r
	 PN0TI3kEZmmbJAk+L+K0sb8W6xvMV/9gPME+/YFkWLf3LzQZMxqTm4vnzPvEH2ZwwZ
	 S/ASyHQS0LPmKoWE2K7jujnSJzEhsOYJIHmRqt9IGUMfFMDPPXRyiLZIYBlLMkhpwd
	 VULPoB4hOcvlw==
Date: Wed, 20 Dec 2023 14:48:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 2/2] iio: dac: driver for MCP4821
Message-ID: <20231220144849.0189a16a@jic23-huawei>
In-Reply-To: <20231219090252.818754-2-anshulusr@gmail.com>
References: <20231219090252.818754-1-anshulusr@gmail.com>
	<20231219090252.818754-2-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 14:32:51 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

> Adds driver for the MCP48xx series of DACs.
> 
> Device uses a simplex SPI channel. To set the value of an output channel,
> a 16-bit data of following format must be written:
> 
> Bit field | Description
> 15 [MSB]  | Channel selection bit
>             0 -> Channel A
>             1 -> Channel B
> 13        | Output Gain Selection bit
>             0 -> 2x Gain (Vref = 4.096V)
>             1 -> 1x Gain (Vref = 2.048V)
> 12        | Output Shutdown Control bit
>             0 -> Shutdown the selected channel
>             1 -> Active mode operation
> 11-0 [LSB]| DAC Input Data bits
>             Value's big endian representation is taken as input for the
>             selected DAC channel. For devices with a resolution of less
>             than 12-bits, only the x most significant bits are considered
>             where x is the resolution of the device.
> Reference: Page#22 [MCP48x2 Datasheet]
> 
> Supported devices:
>   +---------+--------------+-------------+
>   | Device  |  Resolution  |   Channels  |
>   |---------|--------------|-------------|
>   | MCP4801 |     8-bit    |      1      |
>   | MCP4802 |     8-bit    |      2      |
>   | MCP4811 |    10-bit    |      1      |
>   | MCP4812 |    10-bit    |      2      |
>   | MCP4821 |    12-bit    |      1      |
>   | MCP4822 |    12-bit    |      2      |
>   +---------+--------------+-------------+
> 
> Devices tested:
>   MCP4821 [12-bit single channel]
>   MCP4802 [8-bit dual channel]
> 
> Tested on Raspberry Pi Zero 2W
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf #MCP48x1
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf #MCP48x2
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> 
> ---
> 
> Changes for v3,4:
> - no updates
Comments were on v2 from me.  

