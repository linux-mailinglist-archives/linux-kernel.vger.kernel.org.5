Return-Path: <linux-kernel+bounces-143392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F838A3807
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95F5282DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39885152184;
	Fri, 12 Apr 2024 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DUsOkhGf"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33257152164;
	Fri, 12 Apr 2024 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712958188; cv=none; b=UEyBU1LgJuhoWTFroINI6P/sMsiXX64zXpu7Yr2GliQmV35yb+vK7IZRMhhwpxNzdb4jdJgFNVewGCV1FJIbTy0I3UEOP2xRfuL40WVp7J+12EyGUOf1pDK0oRjceVgo7MQIu4RVCYHerpYDUtIIlLns9RwU7K4I5BY7qOmriZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712958188; c=relaxed/simple;
	bh=fJFJt/O18YOy06weCmALUUpTwY9csI4YS3ZZnqltSDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+yuk4eRc3sTMBc3Vgfk/dRcAVuIlR8bNadsFW7q645PQs5EBE2dJ5njC8UwozV0mWjywwuPIn2yczJGJ2KDMd9BagbwcEiRJ2xMjxxZ9lco+2cxqPa4B3rpagF6YpraL2IS0kPI57aksnvrdl564LaJfRMhPeK6GLT1LTeejWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DUsOkhGf; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73CB91BF204;
	Fri, 12 Apr 2024 21:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712958183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMFYGKt8Bu7x5uUg4ZkcdxFN8tZOkh1RWzacUVnLx1k=;
	b=DUsOkhGfs+S2lL7ghtnZAlYaMa/6YzxDPAfXVDsfCduvFfqDAn1+oFwiLOwhRa+G0iYJ4R
	FBqhmwxd0i05VS21hI6J2WpEuWVxQbIjR8/p1nM2pUZJXmlaiTvZV1FpHt+TJFcOlgZ85d
	p+e+CPOWYZoisQg0bgLRMjPVwJMKp2DCmOBAcZnyOKU8nJD21FwHCKIR8H/UA1wE02SBMu
	pyRpXCEhR9h22YYQLOnXy4UWMoKl4SR3P970yt2wpWhaw4649CAhRRFPdjOhlL2fZeK7mL
	ylZGNopM3wEuBSQN9J2L+B0PA3csLYO/8sf+MrZ/6qMaHtGRBv8ZM3/OWZo4vA==
Date: Fri, 12 Apr 2024 23:43:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/4] dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
Message-ID: <20240412214300a31799c2@mail.local>
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
 <20240410-rtc_dtschema-v2-2-d32a11ab0745@gmail.com>
 <202404102043571b7450b5@mail.local>
 <130d47d8-3294-44be-9a8c-8474d342cb12@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <130d47d8-3294-44be-9a8c-8474d342cb12@linaro.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 11/04/2024 08:17:55+0200, Krzysztof Kozlowski wrote:
> On 10/04/2024 22:43, Alexandre Belloni wrote:
> > On 10/04/2024 17:55:34+0200, Javier Carrasco wrote:
> >> Convert existing binding to dtschema to support validation.
> >>
> >> Add the undocumented 'clocks' property.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> ---
> >>  .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 --------
> >>  .../devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml   | 41 ++++++++++++++++++++++
> >>  2 files changed, 41 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt b/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
> >> deleted file mode 100644
> >> index a87a1e9bc060..000000000000
> >> --- a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
> >> +++ /dev/null
> >> @@ -1,15 +0,0 @@
> >> -* NXP LPC32xx SoC Real Time Clock controller
> >> -
> >> -Required properties:
> >> -- compatible: must be "nxp,lpc3220-rtc"
> >> -- reg: physical base address of the controller and length of memory mapped
> >> -  region.
> >> -- interrupts: The RTC interrupt
> >> -
> >> -Example:
> >> -
> >> -	rtc@40024000 {
> >> -		compatible = "nxp,lpc3220-rtc";
> >> -		reg = <0x40024000 0x1000>;
> >> -		interrupts = <52 0>;
> >> -	};
> >> diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
> >> new file mode 100644
> >> index 000000000000..62ddeef961e9
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
> >> @@ -0,0 +1,41 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/rtc/nxp,lpc32xx-rtc.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: NXP LPC32xx SoC Real Time Clock
> >> +
> >> +maintainers:
> >> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> +
> >> +allOf:
> >> +  - $ref: rtc.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: nxp,lpc3220-rtc
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    maxItems: 1
> > 
> > As I explained the clock doesn't really exist, there is no control over
> > it, it is a fixed 32768 Hz crystal, there is no point in describing it
> > as this is already the input clock of the SoC.
> 
> That's common for many SoCs but it is still (at least for them) input to
> the RTC. On some SoC boards 32 kHz is controllable.
> 

There is n way this can be controlled at the board level as the soc
mandates a crystal. There is a control for the oscillator but it is not
functional. This would be bit 5 of RTC_CTRL which is documented as such:

"5 Not used. Write is don’t care, Read returns random value."

Even so, the clock wouldn't be an input to the RTC but it is provided by
the RTC.

I guess because it was easer to d so, the clock is defined in the clock
controller driver:
https://elixir.bootlin.com/linux/latest/source/drivers/clk/nxp/clk-lpc32xx.c#L1222

but, from an HW point of view, this is not correct.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

