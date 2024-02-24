Return-Path: <linux-kernel+bounces-79793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD168626C8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F5B21B2A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10423433BB;
	Sat, 24 Feb 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLdR1wZ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CEE11184;
	Sat, 24 Feb 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708799410; cv=none; b=YxLamSwr5p3DFydJkLgnxNRGZtkjmsF+F+gt+76IsFsrV5WmbP0YDTeOZHwuS5/mbb6u6JoumJIklgQmPkFJ2I7dup0vPqjUqGjFiL3XRgjoAVEZksXymjMXfgViQY8grGd4WnxwLmA4SCjB0jF7tSLHre02VxDuKH3Bs+i672Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708799410; c=relaxed/simple;
	bh=seEQb8OOmd5tvbOXouHrGJxGXsGVZAJiN369Eyry94k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4OjHcOTPVRTYGM/MFcECx15g/0RXIdHXBnReqf0wTpsPWMMG7uhANA1vXgX5vk+usO7asbnyhIILQYpDC1vPFIUdd/UKzpoM1rc4hGNQazauQl+vgUdiYPMRD+QHaX8vmkhiXRHqWSSPJqdwvKbVT8rUHHo6+4+r3x293iGicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLdR1wZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3655C433C7;
	Sat, 24 Feb 2024 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708799409;
	bh=seEQb8OOmd5tvbOXouHrGJxGXsGVZAJiN369Eyry94k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLdR1wZ2bZgadL0a9YDlZDmw7YoKy39uS2gYESYkwxWdeqcqdgYSvBHt0CxVk6HCD
	 WYu6xiiUp4+zLZHC2xjemHrveQu3tiBMnLgDnoXNNc6I4ZJFIC8D3hFtaGKGhiyzSm
	 vTQAlFe6p6TrfxgOrRonb8RUzXPfQObyiP+xriOEiyOoAKV7cG9kXh2e0B4JWmJKIo
	 c20zWWVSd2FMlRWyQeNjq/G1WP1Wu7TXdWU98yKsPkZAy1X4lcF6MOKDv5LCa7E+hm
	 AzindeDKu3Mi4PXidtNWZQJ1w2NaDSb7BP0Vp46S1FYWK4vCjqgiDdSoO54Jn/gUpu
	 Ad2erpMPCOcHw==
Date: Sat, 24 Feb 2024 18:29:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, linus.walleij@linaro.org,
 brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, Ceclan
 Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 1/3] dt-bindings: adc: add AD7173
Message-ID: <20240224182950.1d00dab7@jic23-huawei>
In-Reply-To: <20240220-outmost-flavoring-b2593160de91@spud>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
	<20240220-outmost-flavoring-b2593160de91@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 18:52:37 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Feb 20, 2024 at 11:43:38AM +0200, Dumitru Ceclan wrote:
> 
> > +  interrupts:
> > +    minItems: 1
> > +    description: |  
> 
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    items:
> > +      - const: rdy
> > +      - const: err  
> 
> I noticed that for minItems == 1, the rdy interrupt is required and err
> is the optional one.
> 
> With that in mind, you can simplify the interrupts description so that
> it describes the interrupts separately:
> 
>   interrupts:
>     minItems:
>     items:
>       - description:
>           Ready: multiplexed with SPI data out. While SPI CS is low,
>           can be used to indicate the completion of a conversion.
> 
>       - description:
>           Error: The three error bits in the status register (ADC_ERROR, CRC_ERROR,
>           and REG_ERROR) are OR'ed, inverted, and mapped to the ERROR pin. Therefore,
>           the ERROR pin indicates that an error has occurred.
> 
> Otherwise, I think everything has been sorted out?
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

This ordering may bite us in the future. Someone will build a board
with err as only one wired. But meh, it will be a binding relaxation needed
so I'm not that bothered by that.
> 
> Cheers,
> Conor.


