Return-Path: <linux-kernel+bounces-143037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8978A337B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101201F223AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9A9149DE6;
	Fri, 12 Apr 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MolebbcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9D84A4F;
	Fri, 12 Apr 2024 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938556; cv=none; b=kD6BZIJstCTWleEWdsA1SicUaY+jht0bnnE2aFKSSlYoRzxAdRWczPXPtg3MJGZmcfLKtmLO2sBNYTRCphsHOuX7OQDoXMuUg1ZHxQlwTIPwJiUO/IB5e20Sz16+xozIigZvE96Ms+YnDLPHTBuMaOWKUqiE9pzN38JjlySBSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938556; c=relaxed/simple;
	bh=OGemIX+8j/SNPZ6+9iiBSfvBSY+CSmmHswHoWL2kVOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmEyQ2cG4NQV6ONsGxnYSpDOStwG5cElml8pE36o1pcQQ6W/Vs6ls56PJa+Jx9c3JslqEEddOr4/AyDTZsIZsli/dVrtM64ke9UWAVAKWJl9gZ2DU46VUVNfGYcjsQ3ZnKEGfOmKA7kA3ihucg+N7HVydyV2pETjORYK97O0NPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MolebbcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04972C113CC;
	Fri, 12 Apr 2024 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938556;
	bh=OGemIX+8j/SNPZ6+9iiBSfvBSY+CSmmHswHoWL2kVOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MolebbcDZ5evosjdFYXSEiJYVEIgZrNBKZZK3dkxLS/4oJUUc8OUhWxTZ7BlqdJuW
	 OrP5ALCDNDHu+gonENkJaoMP3/IzdN5btztrEt2mV9lvCXfGRSNGU8pZiBZgvDvtzv
	 YVQ8Y65MuVVbB/wP5NFy5tce1FdzECQzavYHOg3Ua5MBo/j7O+3pH6USMVy9WCqFVv
	 ocALK9bb8w5NHoGyw7lDrV64k488p0X3m8/+nuFVfCHu1FV8Smy8tU7NK+EQDkRxQl
	 x9u+2GHsfMvHHhRunejv+GZWXp0BDYvgJ26kqQ0dM51Npz9xItiqVSHXLN1VKWAGnk
	 G1Dw1MIOexwGA==
Date: Fri, 12 Apr 2024 11:15:53 -0500
From: Rob Herring <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: net: add phy-supply property for stm32
Message-ID: <20240412161553.GA3051386-robh@kernel.org>
References: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
 <20240411143658.1049706-3-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411143658.1049706-3-christophe.roullier@foss.st.com>

On Thu, Apr 11, 2024 at 04:36:49PM +0200, Christophe Roullier wrote:
> Phandle to a regulator that provides power to the PHY. This
> regulator will be managed during the PHY power on/off sequence.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Missing Krzysztof's ack or reason it was not added.

> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> index 20f58eff6e6f9..34650cd9d6702 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -91,6 +91,9 @@ properties:
>        RCC clock instead of ETH_CLK125.
>      type: boolean
>  
> +  phy-supply:
> +    description: PHY regulator
> +
>    st,eth-clk-sel:
>      description:
>        set this property in RGMII PHY when you want to select RCC clock instead of ETH_CLK125.
> -- 
> 2.25.1
> 

