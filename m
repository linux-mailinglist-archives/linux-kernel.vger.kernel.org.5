Return-Path: <linux-kernel+bounces-139323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816248A016B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35541C2454A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A4181D0A;
	Wed, 10 Apr 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X5lEZxWr"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44D31A60;
	Wed, 10 Apr 2024 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781845; cv=none; b=AHUTCqD22QipC9rBsfMMTpy7xJ4WKhSXfQUZPiP/Qn5ITBnfylciJC1AsqwM37MDf03B2aF9lnILRr+swSWpddMuBxsqY6oAhBwU42wxXzv+3MvaWu8y53f+1+atg6lHCOkstt/8KyZ+DeOwuhS29+jwh1DsDdF77PTw4n5W8SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781845; c=relaxed/simple;
	bh=yyTFQKL9QNBsr2Eej81a7gzvp5NuYRWKv3VKnoCXyA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBwhs5pIV+vOHXoTyhlCHU77N+kZBpwvaoT51J1RDH+gP6rl/LHUa2JQ+UFkx4ey/BSNnHr7mfI2nZk1lVeMAIjtV2COqGl5WkZjySdOEqfm8gsm7iNCM/u+jBXAE8UUPa6Va47SWXo4n9I2qpZgwueJ0XKtqs4Dcuy3jqNSVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X5lEZxWr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E3BE1BF203;
	Wed, 10 Apr 2024 20:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712781841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SO7ecFohm5j2wJ67RRcIW5jl8PWTfmDr0JC62K3rRB0=;
	b=X5lEZxWrbyjP7ZMJaTt6eLdDDj9dqI9T5UQgBEo1q0NcBeEkxgO5KBqvy4m4uhJTW/07ZE
	44d1qmkb3zBTdJOpjEMnpTrjXAHrsuX4ZxB38JKNKFy8bXRYc8AoWJvoShk+IrSA83Bi3G
	SOPaisH/NumDw0/bJvPDnhyMAgcS3Fu6TGQ4bZ+XA2rH5L1dqUPKKunV9kqah5rclGn/dz
	rpwH6//kuildVmYfq1krVU3J3/sqdRjiY4NxRS/pY5NQANb4RAfIBO9isNjlF7V55ZbY0U
	7AJIwgnCoVs25BzUrvz0W6L2vtpe6seBIyhyQuH2i2pAHMhIIEybNQu+Kf45nQ==
Date: Wed, 10 Apr 2024 22:43:57 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
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
Message-ID: <202404102043571b7450b5@mail.local>
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
 <20240410-rtc_dtschema-v2-2-d32a11ab0745@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410-rtc_dtschema-v2-2-d32a11ab0745@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 10/04/2024 17:55:34+0200, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> Add the undocumented 'clocks' property.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 --------
>  .../devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml   | 41 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt b/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
> deleted file mode 100644
> index a87a1e9bc060..000000000000
> --- a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -* NXP LPC32xx SoC Real Time Clock controller
> -
> -Required properties:
> -- compatible: must be "nxp,lpc3220-rtc"
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -- interrupts: The RTC interrupt
> -
> -Example:
> -
> -	rtc@40024000 {
> -		compatible = "nxp,lpc3220-rtc";
> -		reg = <0x40024000 0x1000>;
> -		interrupts = <52 0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
> new file mode 100644
> index 000000000000..62ddeef961e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/nxp,lpc32xx-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LPC32xx SoC Real Time Clock
> +
> +maintainers:
> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: nxp,lpc3220-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

As I explained the clock doesn't really exist, there is no control over
it, it is a fixed 32768 Hz crystal, there is no point in describing it
as this is already the input clock of the SoC.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

