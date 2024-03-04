Return-Path: <linux-kernel+bounces-90932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993A18706F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5055A281250
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7DF4D5B5;
	Mon,  4 Mar 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTeEzxHf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906D4AEEE;
	Mon,  4 Mar 2024 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569486; cv=none; b=knlUNWlKYgVro8Obg1WB/ZWe8ejLD9QF9Jl2aO4iQ9c+OXOSWgZAXsUhHYdfM3riV/fT29c5Sj8YM17tpU+imKfkbmy2RaXchWcAag3FWN7Df6+oSogVeJcprT7tmpb60J+1fuo+ZBXx2GbdZ7AYnIIpo9k97uR8chMo1z68RL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569486; c=relaxed/simple;
	bh=Yc4P1CIXlKDGFPR0/DVQiT/46JdWqiofdfkNDqPQVZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoRy3Ys4ngM6sODtulSZVVSrhEThSCKApBf9S7XB/S+8/nfVgaOkYaGVyy033aDEx7Gp7yI04NqYWUW3MdpfQv1QTSeIfbKd5wMAsxxBTQHqASSGD2u6fU8w3aWIOXdYLzvmBAoEx1yO1bLb0Ix9f8kYJ5x1iW5h8tqmyWRJ5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTeEzxHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44643C433F1;
	Mon,  4 Mar 2024 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569485;
	bh=Yc4P1CIXlKDGFPR0/DVQiT/46JdWqiofdfkNDqPQVZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTeEzxHfNCuzklQWKn0MQXGpW9wqJ5wU7bMtXXE3fNVk9xkSNCPuSErh0dD0iaM66
	 Zf/idjm7pk9j+QcMsx+CiFy9KLc4DVT269NsV+fSYoAWP7T6MQZSNh+8Q8Z/guuzET
	 fPgLI/JpW2VumWdtsZ9LYTzB2FhR8AKOkJ44dU0ewYkcxpbnA0Z/KHgTSA1xdAdBLy
	 Ox3nmj1Me/PuiigdHF9L5hfYMUdMhWon/P14XnXBKzCzKmflmmQKwtTPwd4tMCMkmu
	 japN0uyQHYOVfn+D5pfavzok/zAqZJSFByDy00IT9Rw2nVXfnL5vVst2ROwEp8Hn77
	 0ViJmGCCPQG6w==
Date: Mon, 4 Mar 2024 10:24:43 -0600
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
Subject: Re: [PATCH 2/2] dt-bindings: net: add new property st,ext-phyclk in
 documentation for stm32
Message-ID: <20240304162443.GA568211-robh@kernel.org>
References: <20240229134724.1353903-1-christophe.roullier@foss.st.com>
 <20240229134724.1353903-3-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229134724.1353903-3-christophe.roullier@foss.st.com>

On Thu, Feb 29, 2024 at 02:47:24PM +0100, Christophe Roullier wrote:
> Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
> This property can be used with RMII phy without cristal 50Mhz and when we
> want to select RCC clock instead of ETH_REF_CLK
> Can be used also with RGMII phy with no cristal and we select RCC clock
> instead of ETH_CLK125
> This new property replace st,eth-clk-sel and st,eth-ref-clk-sel

That is obvious from the diff. What is not obvious is why we need a new 
property and what is the problem with the existing ones.

> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> index 80937b28fa046..fda23c07c1cad 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -85,12 +85,21 @@ properties:
>    phy-supply:
>      description: PHY regulator
>  
> +  st,ext-phyclk:
> +    description:
> +      set this property in RMII mode when you have PHY without crystal 50MHz and want to
> +      select RCC clock instead of ETH_REF_CLK. OR in RGMII mode when you want to select
> +      RCC clock instead of ETH_CLK125.
> +    type: boolean
> +
>    st,eth-clk-sel:
> +    deprecated: true
>      description:
>        set this property in RGMII PHY when you want to select RCC clock instead of ETH_CLK125.
>      type: boolean
>  
>    st,eth-ref-clk-sel:
> +    deprecated: true
>      description:
>        set this property in RMII mode when you have PHY without crystal 50MHz and want to
>        select RCC clock instead of ETH_REF_CLK.
> -- 
> 2.25.1
> 

