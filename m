Return-Path: <linux-kernel+bounces-7058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B43381A118
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01D2B20DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B31F38FA1;
	Wed, 20 Dec 2023 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lME0Uujr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A577938F82;
	Wed, 20 Dec 2023 14:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C9BC433C7;
	Wed, 20 Dec 2023 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703082414;
	bh=ACSAlCfkl6Oembs96AIka+WCm/EX8xaNKzVQV9k6Pgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lME0Uujr7IM1G7b832SNrxZn18Q9EY0WAkvH4/aZq74jJNTpCH3Sde26A6MBnScZU
	 q7h0NsgVhA+Pdir/XPdD4lfhR8BuaPlwFDS2Gb9tSYY/l6Bco5D8frPQL2CtkRQWH/
	 bvqB7vG/uCOCtQN4soc/yxWUyJH5r/dsIcaypdv94EW9XCyOffxM9/GpYRgjWArxUc
	 xDypCsQt50Yeh5VyUhCY4P4+IJyy+OqUIJevpAUMO/OTXImTZLtB2CvFVWKKk3sE+5
	 vdSmra5TM4UKRhy1frsuR9MQ6i02jx6WcceU2I7MDzmDXs7gE4IP+j02dMYSUv4f09
	 Qb6ZECqksBm/g==
Date: Wed, 20 Dec 2023 14:26:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 2/2] iio: dac: driver for MCP4821
Message-ID: <20231220142638.7739c5d7@jic23-huawei>
In-Reply-To: <20231218164735.787199-2-anshulusr@gmail.com>
References: <20231218164735.787199-1-anshulusr@gmail.com>
	<20231218164735.787199-2-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 22:17:34 +0530
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
> Changes for v3:
> - no updates
>
Oops. I reviewed v2.  Please find comments there.

Jonathan

