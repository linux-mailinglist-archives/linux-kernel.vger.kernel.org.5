Return-Path: <linux-kernel+bounces-142758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576148A2FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846371C23E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAEA85278;
	Fri, 12 Apr 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lln+cZkz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5584DF6;
	Fri, 12 Apr 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929603; cv=none; b=cxyYPMV/3hJNQ2s05ZCOE8r69iWIRJVOLlSI8ADgXn4Ysc6P2kOsdw+S+jAthoiE2kIs+gndRcRhGG5CrG1u0RHQAtTtVHE0mtmdMRKYdz9cKw3jA/RXBYudNzofNmr+X6j+WSHaz9D9A4riE4P0Ace1SWmgd7ID5tKyquHVbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929603; c=relaxed/simple;
	bh=23t1wc48Z7qjQUHxpMlFdirQHFa5WZ1akQpPogYgwdY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=HnNHgOWRqM3q28g0sw0Yq4VpH4Los8X1G+vWfMGbFCx9zCgzLK1JfLxMMxhmSDUYX5+W2Pr98iPfSdrenQfziAhUcnuW4d0wom4b9gEjVDDxQxy/L6g1WOSYDCasA6OqXWE1CtBgeazIKxHTaj4CGkPmjC1NlRJwfDUSLl/VVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lln+cZkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2156C113CC;
	Fri, 12 Apr 2024 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929603;
	bh=23t1wc48Z7qjQUHxpMlFdirQHFa5WZ1akQpPogYgwdY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Lln+cZkzg/nxbwSrjo5hvvxfOWZKMcLDjlh30TDb4jnAQxuTd7nn4mXkaH8/CSB1t
	 9cazUiXc+ryK7SXp7hHtMkc3fon+HFW2OSNJf3hsQ/qCftZFkfkn9dpU+xXXRr5TSE
	 Ts+Mx7UbGuqyXwYeHDmxf46VpJ6uv98hvirgIzpiX5m7DoC67NTYHLnWeFLfMBy5Vs
	 Th04fTu+CfEuq9qGCqU1jHzJmbQw5R0eeaz7DnOG6ZFsAXVW2ahOuq8jaXuYkid9fA
	 08+qhK6jBLexOgO/e7O/PYWJ9RcnsK0AlUdD8orRta+tWoiWVVybtVG5VbN84wk1Nh
	 g5ZNxTNb6ElJg==
Date: Fri, 12 Apr 2024 08:46:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Eric Dumazet <edumazet@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Jose Abreu <joabreu@synopsys.com>, 
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
References: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
Message-Id: <171292930694.2308702.12108714635472172661.robh@kernel.org>
Subject: Re: [PATCH 00/11] Series to deliver Ethernets for STM32MP13


On Thu, 11 Apr 2024 16:36:47 +0200, Christophe Roullier wrote:
> STM32MP13 is STM32 SOC with 2 GMACs instances
> This board have 2 RMII phy:
>   -Ethernet1: RMII with crystal
>   -Ethernet2: RMII without crystal
> Rework dwmac glue to simplify management for next stm32
> Add support for PHY regulator
> 
> Christophe Roullier (11):
>   dt-bindings: net: add STM32MP13 compatible in documentation for stm32
>   dt-bindings: net: add phy-supply property for stm32
>   net: ethernet: stmmac: rework glue to simplify management for next
>     stm32
>   net: ethernet: stmmac: add management of stm32mp13 for stm32
>   net: ethernet: stmmac: stm32: update config management for phy wo
>     cristal
>   net: ethernet: stm32: clean the way to manage wol irqwake
>   net: ethernet: stmmac: stm32: support the phy-supply regulator binding
>   ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
>   ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
>   ARM: dts: stm32: add ethernet1 and ethernet2 for STM32MP135F-DK board
>   ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support
> 
>  .../devicetree/bindings/net/stm32-dwmac.yaml  |  83 ++++++-
>  arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 ++++++
>  arch/arm/boot/dts/st/stm32mp131.dtsi          |  31 +++
>  arch/arm/boot/dts/st/stm32mp133.dtsi          |  30 +++
>  arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  48 ++++
>  arch/arm/configs/multi_v7_defconfig           |   1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 235 ++++++++++++------
>  7 files changed, 421 insertions(+), 78 deletions(-)
> 
> --
> 2.25.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y st/stm32mp135f-dk.dtb' for 20240411143658.1049706-1-christophe.roullier@foss.st.com:

arch/arm/boot/dts/st/stm32mp135f-dk.dtb: adc@48003000: 'ethernet@5800e000' does not match any of the regexes: '^adc@[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#






